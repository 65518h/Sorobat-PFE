TableExtension 50010 CustomerEXT extends Customer
{
    fields
    {
        modify("Outstanding Orders")
        {
            Description = 'Modification CalcFormula (Order type = 0)';
        }
        modify("Shipped Not Invoiced")
        {
            Description = 'Modification CalcFormula (Order type = 0)';
        }
        modify("Outstanding Orders (LCY)")
        {
            Description = 'Modification CalcFormula (Order type = 0)';
        }
        modify("Shipped Not Invoiced (LCY)")
        {
            Description = 'Modification CalcFormula (Order type = 0)';
        }

        field(50000; "Default Bank Account Code1"; Code[10])
        {
            Caption = 'Default Bank Account Code';
            TableRelation = "Customer Bank Account".Code where("Customer No." = field("No."));
        }
        field(50001; "Payment in progress (LCY)1"; Decimal)
        {
            CalcFormula = - sum("Payment Line"."Amount (LCY)" where("Account Type" = const(Customer),
                                                                    "Account No." = field("No."),
                                                                    "Copied To Line" = const(0),
                                                                    "Payment in Progress" = const(true)));
            Caption = 'Payment in progress (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Ancien Code"; Code[20])
        {
            Caption = 'Ancien Code';
            Description = 'BSK 24042012';
        }
        field(50003; Statut; Option)
        {
            Description = 'HJ DSFT 24-03-2012';
            Editable = false;
            OptionMembers = "En Attente","Validé";

            trigger OnValidate()
            begin
                CheckFields;
            end;
        }
        field(50004; Synchronise; Boolean)
        {
        }
        field(50005; "Num Sequence Syncro"; Integer)
        {
        }
        field(50006; "IFU"; CODE[9])
        {
        }
        field(50007; "RCCM"; CODE[13])
        {
        }
        field(50008; "Forme juridique"; Option)
        {
            OptionMembers = " ",Morale,Physique;
        }
        field(50009; "Activité"; Text[40])
        {
        }
        field(50010; "Montant Impayés"; Decimal)
        {
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = const('41600000'),
                                                        Lettre = filter(' '),
                                                        "Source Type" = filter(Customer),
                                                        "Source No." = field("No.")));
            Description = 'RB SORO 20/01/2017';
            FieldClass = FlowField;
        }
        field(50011; "Montant Cheque En Coffre"; Decimal)
        {
            Description = 'RB SORO 20/01/2017';
        }
        field(50012; "Montant Facture Non Lettré"; Decimal)
        {
            CalcFormula = sum("Cust. Ledger Entry"."Remaining Amount" where("Document Type" = filter(Invoice | "Credit Memo"),
                                                                             "Customer No." = field("No.")));
            Description = 'RB SORO 20/01/2017';
            FieldClass = FlowField;
        }
        //New
        field(50013; "Montant Ret"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Description = 'KA 07/09/2024';

        }
        field(50170; "Type Declaration"; Option)
        {
            OptionCaption = ' ,Non Résident physique,Non Résident Morale,Résident Morale,Résident Physique,Régime réel';
            OptionMembers = " ","Non Résident physique","Non Résident Morale","Résident Morale","Résident Physique","Régime réel";
        }

        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(99999; "Domiciliation No."; Text[12])
        {
            Caption = 'Domiciliation No.';
            Description = '2000020';
        }
        field(8001301; "Criteria 1"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99003';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001301));
        }
        field(8001302; "Criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99004';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001302));
        }
        field(8001303; "Criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99005';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001303));
        }
        field(8001304; "Criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99006';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001304));
        }
        field(8001305; "Criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99007';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001305));
        }
        field(8001306; "Criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99008';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001306));
        }
        field(8001307; "Criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99009';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001307));
        }
        field(8001308; "Criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99010';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001308));
        }
        field(8001309; "Criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99011';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001309));
        }
        field(8001310; "Criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99012';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001310));
        }
        field(8004111; "Payments not Due (LCY)"; Decimal)
        {
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                  "Initial Document Type" = const(Payment),
                                                                                  "Entry Type" = const("Initial Entry"),
                                                                                  "Initial Entry Due Date" = field("Due Date Filter")));
            Caption = 'Payments not Due (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004112; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            FieldClass = FlowFilter;
        }
        field(8004113; "Sell-to Cust. Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter"),
                                                                                 "Sell-to Customer No." = field("No.")));
            Caption = 'Balance (LCY) Sell-to Cust.';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key23; Synchronise)
        {
        }
    }



    trigger OnBeforeInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
        NoSeries: Codeunit "No. Series";
        Customer: record Customer;
        DimMgt2: Codeunit DimensionManagement;
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("Customer Nos.");
#if not CLEAN24
            NoSeriesMgt.RaiseObsoleteOnBeforeInitSeries(SalesSetup."Customer Nos.", xRec."No. Series", 0D, "No.", "No. Series", IsHandled);
            // if not IsHandled then begin
#endif
            "No. Series" := SalesSetup."Customer Nos.";
            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
            Customer.ReadIsolation(IsolationLevel::ReadUncommitted);
            Customer.SetLoadFields("No.");
            while Customer.Get("No.") do
                "No." := NoSeries.GetNextNo("No. Series");
#if not CLEAN24
            NoSeriesMgt.RaiseObsoleteOnAfterInitSeries("No. Series", SalesSetup."Customer Nos.", 0D, "No.");
            // end;
#endif
        end;

        if "Invoice Disc. Code" = '' then
            "Invoice Disc. Code" := "No.";

        //  if (not (InsertFromContact or (InsertFromTemplate and (Contact <> '')) or IsTemporary)) or ForceUpdateContact then
        //   UpdateContFromCust.OnInsert(Rec);

        if "Salesperson Code" = '' then
            SetDefaultSalesperson();

        DimMgt2.UpdateDefaultDim(
          DATABASE::Customer, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        UpdateReferencedIds();
        SetLastModifiedDateTime();

    end;




    trigger OnafterInsert()
    var
    begin
        //GL2024     //Il n'y a pas d'événement pour entrer un code spécifique entre la ligne standard ou supprimer le code standard.
        // HJDSFT STD 29 05 2013 IF NOT InsertFromContact THEN
        // HJDSFT STD 29 05 2013  UpdateContFromCust.OnInsert(Rec); //GL2024FIN



        //+REF+TEMPLATE
        DimMgt.fSetDefaultDim(DATABASE::Customer, "No.", 1, "Global Dimension 1 Code");
        DimMgt.fSetDefaultDim(DATABASE::Customer, "No.", 2, "Global Dimension 2 Code");
        //+REF+TEMPLATE//
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC// 
    end;

    trigger OnafterModify()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        lReplicationRef.GETTABLE(xRec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnafterDelete()
    var

    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    end;


    trigger OnafterRename()
    var
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;



    procedure wInitDueDateFilter()
    var
        GLSetup: Record "General Ledger Setup";
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        //+PMT+PAYMENT
        //PERF
        lSingleInstance.wGetGLAccount(GLSetup);
        // IF GLSetup.FIND('-') THEN
        //PERF//
        SetFilter("Due Date Filter",
          StrSubstNo('%1..', CalcDate(GLSetup."Bank Waiting Period", WorkDate)));
        //+PMT+PAYMENT//
    end;

    procedure wShowContactList()
    var
        ContBusRel: Record "Contact Business Relation";
        Cont: Record Contact;
    begin
        if "No." = '' then
            exit;
        ContBusRel.SetCurrentkey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
        ContBusRel.SetRange("No.", "No.");
        if not ContBusRel.Find('-') then begin
            if not Confirm(Text002, false, TableCaption, "No.") then
                exit;
            UpdateContFromCust.InsertNewContact(Rec, false);
            ContBusRel.Find('-');
        end;
        Commit;

        Cont.SetCurrentkey("Company No.");
        Cont.SetRange("Company No.", ContBusRel."Contact No.");
        if Page.RunModal(Page::"Contact List", Cont) = Action::LookupOK then
            Page.Run(Page::"Contact Card", Cont);
    end;

    procedure "// HJ DSFT"()
    begin
    end;

    procedure CheckFields()
    var
        TemplateMgt: Codeunit SoroubatFucntion;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        TemplateMgt.CheckMandatoriesFields(RecRef);
    end;

    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        UpdateContFromCust: Codeunit "CustCont-Update";
        DimMgt: Codeunit DimensionManagementEvent;

        SS: page "Change Exchange Rate";
        Text002: Label 'Do you wish to create a contact for %1 %2?';

}

