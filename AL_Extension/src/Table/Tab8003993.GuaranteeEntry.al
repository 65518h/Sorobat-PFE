Table 8003993 "Guarantee Entry"
{
    // //CAUTION AC 31/01/05 Table de gestion des écritures de caution
    // //PERF MB MAJ SIFT Index

    Caption = 'Guarantee Entry';
    // DrillDownPageID = 8003994;
    //LookupPageID = 8003994;

    fields
    {
        field(1; "Document Type"; Option)
        {
            //blankzero = false;
            Caption = 'Document Type';
            InitValue = "Order";
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));

            trigger OnLookup()
            begin
                SalesHeader.Reset;
                SalesHeader.SetRange("Job No.", "Job No.");
                //DYS page addon non migrer
                // if PAGE.RunModal(page::"NaviBat Sales List", SalesHeader) = Action::LookupOK then begin
                //     "Document Type" := SalesHeader."Document Type";
                //     "No." := SalesHeader."No.";
                // end;
            end;

            trigger OnValidate()
            begin
                if "No." <> '' then begin
                    SalesHeader.Get("Document Type", "No.");
                    if "Job No." = '' then
                        Description := SalesHeader.Subject;
                end;
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = true;
        }
        field(4; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account"."No." where("Bank Type" = const(" "));

            trigger OnValidate()
            begin
                if "Bank Account No." <> '' then
                    CheckGuaranteeCelling;
            end;
        }
        field(5; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(8; "Closed Date"; Date)
        {
            Caption = 'Closed Date';

            trigger OnValidate()
            begin
                CheckGuaranteeCelling;
            end;
        }
        field(9; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                CheckGuaranteeCelling;
            end;
        }
        field(10; Open; Boolean)
        {
            Caption = 'Open';
            InitValue = true;
        }
        field(11; "Job No."; Code[20])
        {
            Caption = 'Job No';
            Editable = false;
            TableRelation = Job;
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "No.", "Line No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Job No.", Open, "Bank Account No.", "Closed Date", "Posting Date")
        {
            SumIndexFields = "Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    var
        tCreateContact: label 'Do you wish to create a contact for %1 %2?';
        UpdateContFromBank: Codeunit "BankCont-Update";
        tErrorFieldisEmpty: label 'You can''t write Guarantee Amount because the field "%1" is empty';
        tErrorAmountValue: label 'The guarantee celling is over to %1.\the bank %2  can''t validate your request for the amount of . \Do you want to continue ?';
        SalesHeader: Record "Sales Header";


    procedure CheckGuaranteeCelling()
    var
        lBankAccount: Record "Bank Account";
        lNewGuaranteeValue: Decimal;
    begin
        if ("Amount (LCY)" <> 0) and ("Bank Account No." = '') then
            Error(tErrorFieldisEmpty, FieldCaption("Bank Account No."));
        lBankAccount.Get("Bank Account No.");
        if lBankAccount."Guarantee Celling" = 0 then
            exit;

        // Calcul des encours de cautions
        lBankAccount.SetRange("Date Filter", 0D, "Posting Date");
        lBankAccount.SetFilter("Due Date Filter", '%1..%2|%3', "Closed Date", 99991231D, 0D);
        lBankAccount.CalcFields("Guarantee in Progress");

        // Test sur le dépassement du plafond.
        lNewGuaranteeValue :=
          lBankAccount."Guarantee in Progress" - xRec."Amount (LCY)" + "Amount (LCY)";
        if lBankAccount."Guarantee Celling" < lNewGuaranteeValue then
            if not Confirm(
               tErrorAmountValue, false,
               lNewGuaranteeValue - lBankAccount."Guarantee Celling",
               lBankAccount.Name, "Amount (LCY)")
            then
                exit;
    end;


    procedure ShowContact(vShow: Boolean) Return: Code[20]
    var
        lContBusRel: Record "Contact Business Relation";
        lBankAccount: Record "Bank Account";
        lContact: Record Contact;
    begin
        if "Bank Account No." = '' then
            exit;

        lContBusRel.SetCurrentkey("Link to Table", "No.");
        lContBusRel.SetRange("Link to Table", lContBusRel."link to table"::"Bank Account");
        lContBusRel.SetRange("No.", "Bank Account No.");
        if not lContBusRel.Find('-') then begin
            if not Confirm(tCreateContact, false, TableCaption, "Bank Account No.") then
                exit;
            lBankAccount.Get("Bank Account No.");
            UpdateContFromBank.InsertNewContact(lBankAccount, false);
            lContBusRel.Find('-')
        end;
        Commit;

        lContact.Get(lContBusRel."Contact No.");
        if vShow then
            Page.Run(page::"Contact Card", lContact);
        Return := lContBusRel."Contact No.";
    end;


    procedure CreateInteraction(pRequest: Boolean)
    var
        lContact: Record Contact;
        lSegLine: Record "Segment Line" temporary;
        lContactNo: Code[20];
        tHandUp: label 'Guarantee Posted to %1';
        tRequest: label 'Guarantee Request to %1';
        tError: label 'Your Entries is closed. Can you open this to create an interaction.';
    begin
        TestField("Bank Account No.");

        //récupération du contact
        lContactNo := ShowContact(false);
        if Open = false then
            Error(tError);

        //#5115
        if not lContact.Get(lContactNo) then
            lContact.Init;
        lSegLine.fCreateInteractionFromGuarante(Rec, lContact, pRequest);
    end;
}

