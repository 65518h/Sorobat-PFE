TableExtension 50025 "Gen. Journal LineEXT" extends "Gen. Journal Line"
{
    //DYS propriete Permission not allowed
    //Permissions = TableData 17 = rm;


    fields
    {


        /*GL2024   modify("Source Code")
          {
              Editable = true;
          }
            */
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Caption = 'Bal. Gen. Prod. Posting Group';
        }
        modify("Check Printed")
        {
            Caption = 'Check Printed';
            //GL2024 Editable = true;

        }


        modify("Sell-to/Buy-from No.")
        {
            Caption = 'Sell-to/Buy-from No.';
        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';
        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price (LCY)';
        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price (LCY)';
        }
        modify("Job Quantity")
        {
            Caption = 'Job Quantity';
        }
        modify("Job Unit Cost (LCY)")
        {
            Caption = 'Job Unit Cost (LCY)';
        }
        modify("Job Line Discount %")
        {
            Caption = 'Job Line Discount %';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount (LCY)';
        }
        modify("Job Unit Of Measure Code")
        {
            Caption = 'Job Unit Of Measure Code';
        }
        modify("Job Line Type")
        {
            Caption = 'Job Line Type';
        }
        modify("Job Unit Price")
        {
            Caption = 'Job Unit Price';
        }
        modify("Job Total Price")
        {
            Caption = 'Job Total Price';
        }
        modify("Job Unit Cost")
        {
            Caption = 'Job Unit Cost';
        }
        modify("Job Total Cost")
        {
            Caption = 'Job Total Cost';
        }
        modify("Job Line Discount Amount")
        {
            Caption = 'Job Line Discount Amount';
        }
        modify("Job Line Amount")
        {
            Caption = 'Job Line Amount';
        }
        modify("Job Total Cost (LCY)")
        {
            Caption = 'Job Total Cost (LCY)';
        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount (LCY)';
        }
        modify("Job Currency Factor")
        {
            Caption = 'Job Currency Factor';
        }
        modify("Job Currency Code")
        {
            Caption = 'Job Currency Code';
        }


        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                lBARMgt: Codeunit "BAR Management";
            begin
                //+RAP+TRESO
                IF gAddOnLicencePermission.HasPermissionRAP() THEN
                    lBARMgt.SetDueDate2GJL(Rec, "Posting Date", TRUE);
                //+RAP+TRESO//
            end;
        }

        modify("Bal. Account No.")
        {
            trigger OnAfterValidate()
            var
                lPaymentIntegration: Codeunit "Payment Integration";
            begin
                //+PMT+PAYMENT
                //IF "Bal. Account Type" = "Bal. Account Type"::"Bank Account" THEN
                //fSetReasonCode;
                IF gAddOnLicencePermission.HasPermissionPMT() AND
                   ("Bal. Account Type" = "Bal. Account Type"::"Bank Account") THEN
                    lPaymentIntegration.GJLSetReasonCode(Rec);
                //+PMT+PAYMENT//
            end;
        }

        modify("Currency Code")
        {
            trigger OnAfterValidate()
            begin
                // CH2300.begin
                IF DtaSetup.READPERMISSION THEN
                    IF (CurrFieldNo = FIELDNO("Currency Code")) THEN
                        DtaMgt.CheckEsrCurrency("Currency Code", "DTA Coding Line");
                // CH2300.end

            end;
        }

        modify("Job No.")
        {
            TableRelation = Job."No." where("IC Partner Code" = const());
            Caption = 'Job No.';
            //GL2024  Editable = true;
            Description = 'Modif : Editable OUI + TableRelation';
            trigger OnAfterValidate()
            begin
                //+JOB+
                //#7044
                IF "Job Quantity" = 0 THEN
                    //#7044//
                    //#7869 "Job Quantity" := 1;
                    "Job Quantity" := fSignJobQuantity("Amount (LCY)" - "VAT Amount (LCY)" > 0);
                //#7869//
                //GL2024  IF "Job Task No." = '' THEN
                //GL2024 
                IF ("Job Task No." = '') and ("Job No." <> '') THEN begin

                    Job.Get("Job No.");
                    //GL2024 
                    VALIDATE("Job Task No.", Job.gGetDefaultJobTask);
                end;
                //+JOB+//
            end;

        }
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            VAR
                lBARMgt: Codeunit "BAR Management";
            begin

                if ("Account Type" <> "Account Type"::"G/L Account") or ("Bal. Account Type" <> "Bal. Account Type"::"G/L Account") then
                    case "Document Type" of
                        //+PMT+PAYMENT
                        "Document Type"::Payment:
                            IF gAddOnLicencePermission.HasPermissionPMT() THEN
                                "Due Date" := xRec."Due Date";
                    //+PMT+PAYMENT//
                    end;

                //+RAP+TRESO
                IF gAddOnLicencePermission.HasPermissionRAP() THEN
                    lBARMgt.SetDueDate2GJL(Rec, "Due Date", FALSE);
                //+RAP+TRESO//
            end;
        }
        field(11580; "Payment Fee Code"; Option)
        {
            Caption = 'Payment Fee Code';
            InitValue = " ";
            OptionCaption = ' ,Own,Beneficiary,Share';
            OptionMembers = " ",Own,Beneficiary,Share;
        }
        field(50000; "External Invoice No."; Code[30])
        {
            Caption = 'N° Facture Externe';
            Description = 'HJ DSFT';
            Editable = false;
        }
        field(50001; "Entry No.1"; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
        }
        field(50002; "Date Echeance"; Text[10])
        {
            Description = 'HJ SORO 09-0-2014';
        }
        field(50003; Lettre; Text[3])
        {
            Description = 'HJ SORO 09-0-2014';
        }
        field(50010; "N° Bordereau"; Code[20])
        {
            Description = 'STD V2.0';
            Editable = false;
        }
        field(50011; "N° compte Bancaire"; Code[20])
        {
            Description = 'STD V2.0';
        }
        field(50012; "Payement Method Code"; Code[10])
        {
            Caption = 'payement method code code';
            Description = 'STD V2.0';
            TableRelation = "Payment Method";
        }
        field(50020; "N° Dossier"; Code[20])
        {
        }
        field(50021; "Type origine entêt"; Option)
        {
            Description = 'MBK';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(50022; "Code origine entêt"; Code[20])
        {
            Description = 'MBK';
        }
        field(50023; "Entry Type1"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Definitive,Simulation';
            OptionMembers = Definitive,Simulation;
        }
        field(50025; "Derogatory Line1"; Boolean)
        {
            Caption = 'Derogatory Line';
            Editable = false;
        }
        field(50026; "Delayed Unrealized VAT1"; Boolean)
        {
            Caption = 'Delayed Unrealized VAT';
        }
        field(50027; "Realize VAT1"; Boolean)
        {
            Caption = 'Realize VAT';
        }
        field(50028; "Created from No.1"; Code[20])
        {
            Caption = 'Created from No.';
        }
        field(50029; "Bank Account Code1"; Code[20])
        {
            Caption = 'Bank Account Code';
            TableRelation = if ("Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Account No."))
            else
            if ("Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Account No."));

            trigger OnValidate()
            begin
                if "Account Type" = "account type"::Customer then
                    if CustBankAcc.Get("Account No.", "Bank Account Code1") then
                        "Code origine entêt" := CustBankAcc.Name
                    else
                        "Code origine entêt" := '';
                if "Account Type" = "account type"::Vendor then
                    if VendBankAcc.Get("Account No.", "Bank Account Code1") then
                        "Code origine entêt" := VendBankAcc.Name
                    else
                        "Code origine entêt" := '';
            end;
        }
        field(50030; Salarie; Code[20])
        {
        }
        field(50031; "Folio N° RS"; Code[20])
        {
            Description = 'RB SORO 27/04/2015';
        }
        field(50032; "Affectation Financiere"; Code[60])
        {
            Description = 'HJ SORO 23-02-2017';
        }
        field(50042; Simulation; Boolean)
        {
            Description = 'RB SORO 16/03/2016';
        }
        field(50502; "Type Doc"; Option)
        {
            Description = 'SDT V1.00';
            OptionMembers = " ","Commande Vente","Bon de Livraison","Commande Achat","Réception";
        }
        field(50503; "Numéro Document"; Code[20])
        {
            Description = 'SDT V1.00';
        }
        field(52001; "N° contrat"; Code[20])
        {
            Description = 'HJ DSFT';
            TableRelation = "Autorisation Types Réglement";
        }
        field(52002; "Période contrat"; Integer)
        {
            Description = 'HJ DSFT';
        }
        field(60000; RG; Boolean)
        {
            Description = 'HJ DSFT';
        }
        field(60001; Avance; Boolean)
        {
            Description = 'HJ DSFT';
        }
        field(3010531; "ESR Information"; Text[100])
        {
            Caption = 'ESR Information';
        }
        field(3010541; "Reference No."; Code[35])
        {
            Caption = 'Reference No.';

            trigger OnValidate()
            begin
                DtaMgt.ProcessGlRefNo(Rec);
            end;
        }
        field(3010542; "Bank Code"; Code[10])
        {
            Caption = 'Bank Code';
            TableRelation = "Vendor Bank Account".Code where(Code = field("Account No."));
        }
        field(3010543; Checksum; Code[2])
        {
            Caption = 'Checksum';

            trigger OnValidate()
            begin
                Validate("Reference No.");
            end;
        }
        field(3010544; "DTA Coding Line"; Code[70])
        {
            Caption = 'DTA Coding Line';

            trigger OnValidate()
            begin
                DtaMgt.ProcessGlLine(Rec, "DTA Coding Line");
            end;
        }
        field(3010545; "Debit Bank"; Code[10])
        {
            Caption = 'Debit Bank';
            TableRelation = "DTA Setup";

            trigger OnValidate()
            begin
                DtaSetup.Get("Debit Bank");
                DtaSetup.TestField("DTA Sender Clearing");
                Clearing := DtaSetup."DTA Sender Clearing";
            end;
        }
        field(3010546; Clearing; Code[5])
        {
            Caption = 'Clearing';
            Editable = false;
            // TableRelation = "Bank Directory";
        }
        field(8001600; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';

            trigger OnValidate()
            begin
                //++ABO++
                if ("Subscription Starting Date" > "Subscription End Date") and ("Subscription End Date" <> 0D) then
                    Error(tSubsriptionDate, FieldCaption("Subscription Starting Date"), FieldCaption("Subscription End Date"));
                //++ABO++//
            end;
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';

            trigger OnValidate()
            begin
                //++ABO++
                if ("Subscription Starting Date" > "Subscription End Date") then
                    Error(tSubsriptionDate, FieldCaption("Subscription Starting Date"), FieldCaption("Subscription End Date"));
                //++ABO++//
            end;
        }
        field(8001904; "Subscription Entry No."; Integer)
        {
            Caption = 'Subscription Entry No.';
            TableRelation = "G/L Entry";
        }
        field(8003924; "Apply-to Sales Order No."; Code[20])
        {
            Caption = 'Apply-to Sales Doc. No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "No." = field("Apply-to Sales Order No."),
                                                        "Order Type" = const(" "));

            trigger OnValidate()
            var
                lSalesHeader: Record "Sales Header";
            begin
                if lSalesHeader.Get(lSalesHeader."document type"::Order, "Apply-to Sales Order No.") then
                    Validate("Job No.", lSalesHeader."Job No.");
            end;
        }
        field(8004040; "Retention Code"; Code[10])
        {
            Caption = 'Retention Code';
            TableRelation = Retention;
        }
        field(8004100; "Payment Bank Account"; Code[10])
        {
            Caption = 'Payment Bank Account';
            TableRelation = if ("Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Account No."))
            else
            if ("Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Account No."));
        }
        field(8004101; "Bill Type"; Option)
        {
            Caption = 'Bill Type';
            OptionCaption = ' ,Not Accepted,Accepted,BOR';
            OptionMembers = " ","Not Accepted",Accepted,BOR;
        }
        field(8004102; "Check Ledger Entry No."; Integer)
        {
            Caption = 'Check Ledger Entry No.';
            Editable = false;
        }
        field(8004103; "Payment Type"; Option)
        {
            //blankzero = true;
            Caption = 'Payment Type';
            OptionCaption = ' ,Check,Bill,Transfer,Direct Debit,Credit Card,VCOM';
            OptionMembers = " ",Check,Bill,Transfer,"Direct Debit","Credit Card",VCOM;

            trigger OnValidate()
            var
                lPaymentMethod: Record "Payment Method";
                lPaymentIntegration: Codeunit "Payment Integration";
            begin
                //+PMT+PAYMENT
                if gAddOnLicencePermission.HasPermissionPMT() then
                    lPaymentIntegration.GJLPmtTypeOnValidate(Rec, xRec)
                else
                    "Payment Type" := 0;
                /* DELETE
                IF "Payment Type" <> 0 THEN
                  "Bank Payment Type" := "Bank Payment Type"::"Computer Check"
                ELSE
                  "Bank Payment Type" := 0;
                IF "Payment Type" = "Payment Type"::Transfer THEN
                  TESTFIELD("Payment Bank Account");
                IF "Payment Type" <> xRec."Payment Type" THEN
                  fSetReasonCode;
                //#6683
                IF ("Account Type" = "Account Type"::Vendor) THEN BEGIN
                  Vend.GET("Account No.");
                  IF lPaymentMethod.GET(Vend."Payment Method Code") THEN
                    "Bill Type" := lPaymentMethod."Bill Type";
                  IF ("Payment Type"= "Payment Type"::Bill) AND ("Bill Type" = "Bill Type"::" ") THEN
                    "Bill Type" := "Bill Type"::"Not Accepted"
                END;
                //#6683//
                DELETE */
                //+PMT+PAYMENT//

            end;
        }
    }
    keys
    {

        key(Key11; "Journal Template Name", "Journal Batch Name", "Due Date")
        {
            MaintainSQLIndex = false;
        }

        /*GL2024  key(Key12;"Journal Template Name","Account Type","Account No.","Value Date","Posting Date")
          {
          SumIndexFields = "Amount (LCY)";
          }*/

        key(Key13; "Applies-to Doc. No.", "Journal Template Name", "Journal Batch Name", "Posting Date", "Account Type", "Account No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Job No.", "Reason Code")
        {
        }

        key(Key14; "Source Code", "Document No.", "Posting Date")
        {
        }
    }


    trigger OnAfterInsert()
    var
        lPaymentIntegration: Codeunit "Payment Integration";
    begin
        //+PMT+PAYMENT
        //fCheckBalBankAccount;
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            lPaymentIntegration.GJLCheckBalBankAccount(Rec);
        //+PMT+PAYMENT//
    end;

    trigger OnAfterModify()
    VAR
        lPaymentIntegration: Codeunit "Payment Integration";
    begin
        //+PMT+PAYMENT
        //fCheckBalBankAccount;
        IF gAddOnLicencePermission.HasPermissionPMT() THEN
            lPaymentIntegration.GJLCheckBalBankAccount(Rec);
        //+PMT+PAYMENT//
        //++ABO++
        IF "Subscription Entry No." <> 0 THEN
            TESTFIELD("Subscription Entry No.", 0);
        //++ABO++//
    end;


    trigger OnAfterDelete()
    var
        wGenJnlLine: Record "Gen. Journal Line";
        wGLEntry: Record "G/L Entry";
        lLsvSetup: Record "LSV Journal";
        lLsvMgt: Codeunit LsvMgt;
        lAnaDistribIntegr: Codeunit "Analytical Distrib.Integr.";
    begin
        //+REP+
        IF gAddOnLicencePermission.HasPermissionREP() THEN
            lAnaDistribIntegr.DeleteAnaDistribFromGen(Rec, FALSE);
        //+REP+//
        // CH2300.begin
        IF DtaSetup.READPERMISSION THEN
            DtaMgt.ReleaseVendorLedgerEntries(Rec);
        // CH2300.end

        // CH2800.begin
        IF lLsvSetup.READPERMISSION THEN
            lLsvMgt.ReleaseCustLedgEntries(Rec);
        // CH2800.end
    end;








    procedure UpdateLineBalanceTestReport()
    begin
        //BE_FINJNL
        wTestReportBE := true;
        UpdateLineBalance;
        wTestReportBE := false;
        //BE_FINJNL//
    end;

    local procedure UpdateCurrencyFactor()
    begin
        if "Job Currency Code" <> '' then begin
            if ("Posting Date" = 0D) then
                CurrencyDate := WorkDate
            else
                CurrencyDate := "Posting Date";

            "Job Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Job Currency Code");
            Validate(
              "Job Total Cost", ROUND(CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", "Job Currency Code",
              "Job Total Cost (LCY)", "Job Currency Factor"), JobCurrency."Amount Rounding Precision"));
            Validate(
              "Job Unit Cost", ROUND(CurrExchRate.ExchangeAmtLCYToFCY("Posting Date", "Job Currency Code",
              "Job Unit Cost (LCY)", "Job Currency Factor"), JobCurrency."Unit-Amount Rounding Precision"));
        end else
            "Job Currency Factor" := 0;
    end;

    procedure GetJob()
    begin
        TestField("Job No.");
        if "Job No." <> Job."No." then begin
            Job.Get("Job No.");
            if Job."Currency Code" = '' then
                JobCurrency.InitRoundingPrecision
            else begin
                JobCurrency.Get(Job."Currency Code");
                JobCurrency.TestField("Amount Rounding Precision");
            end;
        end;
    end;

    local procedure GetJobCurrency()
    begin
        if "Job Currency Code" = '' then begin
            Clear(JobCurrency);
            JobCurrency.InitRoundingPrecision
        end else begin
            JobCurrency.Get("Job Currency Code");
            JobCurrency.TestField("Amount Rounding Precision");
            JobCurrency.TestField("Unit-Amount Rounding Precision");
        end;
    end;

    local procedure UpdateJobJnlLine()
    begin
        TestField("Posting Date");
        Clear(JobJnlLine);
        JobJnlLine.DontCheckStdCost;
        JobJnlLine.Validate("Job No.", "Job No.");
        JobJnlLine.Validate("Job Task No.", "Job Task No.");
        if CurrFieldNo <> FieldNo("Posting Date") then
            JobJnlLine.Validate("Posting Date", "Posting Date")
        else
            JobJnlLine.Validate("Posting Date", xRec."Posting Date");
        JobJnlLine.SetCurrencyFactor("Job Currency Factor");
        JobJnlLine.Validate(Type, JobJnlLine.Type::"G/L Account");
        JobJnlLine.Validate("No.", "Account No.");
        //#7869
        if "Gen. Posting Type" = "gen. posting type"::Sale then
            JobJnlLine."Cost Factor" := 1;
        //#7869//
        JobJnlLine.Validate(Quantity, "Job Quantity");
        if "Job Quantity" <> 0 then
            JobJnlLine.Validate("Total Cost (LCY)", "Job Total Cost (LCY)");
    end;

    procedure fSignJobQuantity(pCondition: Boolean) return: Decimal
    begin
        if pCondition then
            return := 1
        else
            return := -1;
    end;

    local procedure JTUpdateGLJnlLinePrices()
    begin
        "Job Unit Price" := JobJnlLine."Unit Price";
        "Job Total Price" := JobJnlLine."Total Price";
        "Job Unit Price (LCY)" := JobJnlLine."Unit Price (LCY)";
        "Job Total Price (LCY)" := JobJnlLine."Total Price (LCY)";
        "Job Line Amount (LCY)" := JobJnlLine."Line Amount (LCY)";
        "Job Line Disc. Amount (LCY)" := JobJnlLine."Line Discount Amount (LCY)";
        "Job Line Amount" := JobJnlLine."Line Amount";
        "Job Line Discount %" := JobJnlLine."Line Discount %";
        "Job Line Discount Amount" := JobJnlLine."Line Discount Amount";
        "Job Unit Cost (LCY)" := JobJnlLine."Unit Cost (LCY)";
        "Job Unit Cost" := JobJnlLine."Unit Cost";
        "Job Total Cost" := JobJnlLine."Total Cost";
    end;

    procedure TestJobTask(): Boolean
    begin
        exit(("Job No." <> '') and ("Job Task No." <> '') and ("Account Type" = "account type"::"G/L Account"));
    end;

    local procedure JobSetCurrencyFactor()
    begin
        TestField("Posting Date");
        Clear(JobJnlLine);
        JobJnlLine.DontCheckStdCost;
        JobJnlLine.Validate("Job No.", "Job No.");
        JobJnlLine.Validate("Job Task No.", "Job Task No.");
        JobJnlLine.Validate("Posting Date", "Posting Date");
        "Job Currency Factor" := JobJnlLine."Currency Factor";
    end;

    procedure fSetReasonCode()
    var
        lBankPaymentType: Record "Bank Payment Type";
    begin
        //+PMT+PAYMENT
        if "Payment Type" = 0 then
            exit;
        if "Bal. Account No." <> '' then
            lBankPaymentType.Get("Bal. Account No.", "Payment Type");
        if lBankPaymentType."Reason Code" <> '' then
            "Reason Code" := lBankPaymentType."Reason Code";
        //+PMT+PAYMENT//
    end;

    procedure fCheckBalBankAccount()
    var
        lBalBankAccount: Record "Bank Account";
        tDifferentCurrency: label 'The currency must be the same one as the currency of the bank %1.';
    begin
        //+PMT+PAYMENT
        if "Bal. Account Type" = "bal. account type"::"Bank Account" then begin
            if lBalBankAccount.Get("Bal. Account No.") then
                if ("Due Date" = 0D) and (lBalBankAccount."Bank Type" = lBalBankAccount."bank type"::" ") then
                    Validate("Due Date", "Document Date");
            if (lBalBankAccount."Currency Code" <> "Currency Code") and
               (lBalBankAccount."Bank Type" = lBalBankAccount."bank type"::Receivable) then
                Error(tDifferentCurrency, lBalBankAccount."Currency Code");
        end;
        //+PMT+PAYMENT//
    end;



    var
        Job: Record Job;
        //Job : 167;
        JobJnlLine: Record "Job Journal Line" TEMPORARY;
        // JobJnlLine:  Record "Job Journal Line"
        JobCurrency: Record Currency;
        gAddOnLicencePermission: Codeunit IntegrManagement;
        tSubsriptionDate: label '%1 must be inferior than %2';
        wCpteBqeContrePartie: Record "Bank Account";
        Text8001400: label 'The currency must be the same one as the currency of the bank %1.';
        wTestReportBE: Boolean;
        DtaSetup: Record "DTA Setup";
        DtaMgt: Codeunit DtaMgt;
        gPaymentMethod: Record "Payment Method";
        CustBankAcc: Record "Customer Bank Account";
        VendBankAcc: Record "Vendor Bank Account";
        CurrencyDate: Date;


}

