TableExtension 50013 "Vendor Ledger EntryEXT" extends "Vendor Ledger Entry"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Vendor No.';
        }
        modify("Due Date")
        {
            /* trigger OnbeforeValidate()
             begin
                 //+RAP+TRESO
                 IF (CurrFieldNo = FIELDNO("Due Date")) OR NOT gAddOnLicencePermission.HasPermissionRAP THEN
                     //+RAP+TRESO//
                     TESTFIELD(Open, TRUE);
             end;*/

            trigger OnAfterValidate()
            var
            begin
                //+RAP+TRESO
                IF gAddOnLicencePermission.HasPermissionRAP THEN
                    lBARMgt.SetValueDate2VLE(Rec);
                //+RAP+TRESO//
            end;
        }

        modify("Remaining Pmt. Disc. Possible")
        {
            trigger OnbeforeValidate()
            begin
                //PMT_DIRECT
                IF "Remaining Pmt. Disc. Possible" <> 0 THEN
                    TESTFIELD("Apply-to Sales Order No.", '');
                //PMT_DIRECT//
            end;


        }

        field(50000; Lettre; Text[4])
        {
            Description = 'HJ SORO 03-05-2015';
        }
        /* field(50002; Avance; Boolean)
         {
             CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
             Description = 'RB SORO 27/03/2015';
             FieldClass = FlowField;
         }
         field(50020; "Folio N°"; Code[20])
         {
             CalcFormula = lookup("G/L Entry"."Folio N°" where("Source Type" = filter("Bank Account"),
                                                                "Document No." = field("Document No.")));
             FieldClass = FlowField;
         }
         field(50021; "Date Préparation Payement"; Date)
         {
             CalcFormula = lookup("Purch. Inv. Header"."Date Préparation Payement" where("Buy-from Vendor No." = field("Vendor No."),
                                                                                          "No." = field("Document No.")));
             Description = 'HJ SORO 24-10-2014';
             FieldClass = FlowField;
         }
         field(50022; "Date Signature"; Date)
         {
             CalcFormula = lookup("Purch. Inv. Header"."Date Signature" where("Buy-from Vendor No." = field("Vendor No."),
                                                                               "No." = field("Document No.")));
             Description = 'HJ SORO 24-10-2014';
             FieldClass = FlowField;
         }
         field(50023; "Date Paiement"; Date)
         {
             CalcFormula = lookup("Purch. Inv. Header"."Date Paiement" where("Buy-from Vendor No." = field("Vendor No."),
                                                                              "No." = field("Document No.")));
             Description = 'HJ SORO 24-10-2014';
             FieldClass = FlowField;
         }
         field(50042; Simulation; Boolean)
         {
             Description = 'RB SORO 16/03/2016';
         }*/
        field(50050; "Statut Facture"; Option)
        {
            CalcFormula = lookup("Purch. Inv. Header"."Statut Facture" where("Buy-from Vendor No." = field("Vendor No."),
                                                                              "No." = field("Document No.")));
            Description = 'HJ SORO 24-10-2014';
            FieldClass = FlowField;
            OptionMembers = "Vérifié Et Comptabilisé","En Cours De Paiement","En Cours De Signature",Signée,Payée,"Payé Et Archivée",;
        }
        /*field(50051; "Date En Cours Signature"; Date)
        {
            CalcFormula = lookup("Purch. Inv. Header"."Date En Cours Signature" where("Buy-from Vendor No." = field("Vendor No."),
                                                                                       "No." = field("Document No.")));
            Description = 'HJ SORO 24-10-2014';
            FieldClass = FlowField;
        }
        field(50052; "Date Vérification"; Date)
        {
            CalcFormula = lookup("Purch. Inv. Header"."Date Vérification" where("Buy-from Vendor No." = field("Vendor No."),
                                                                                 "No." = field("Document No.")));
            Description = 'HJ SORO 24-10-2014';
            FieldClass = FlowField;
        }
        field(50055; "Folio N° RS"; Code[20])
        {
            CalcFormula = lookup("G/L Entry"."Folio N° RS" where("Document No." = field("Document No.")));
            Description = 'RB SORO 15/02/2016';
            FieldClass = FlowField;
        }
        field(50056; "Commande N°"; Code[20])
        {
            CalcFormula = lookup("Payment Line"."Commande N°" where("Account Type" = filter(Vendor),
                                                                     "Account No." = field("Vendor No."),
                                                                     "No." = field("Document No.")));
            Description = 'RB SORO 08/09/2017';
            FieldClass = FlowField;
        }
        field(50057; "Facture N°"; Code[20])
        {
            CalcFormula = lookup("Payment Line"."Facture N°" where("Account Type" = filter(Vendor),
                                                                    "Account No." = field("Vendor No."),
                                                                    "No." = field("Document No.")));
            Description = 'RB SORO 08/09/2017';
            FieldClass = FlowField;
        }
        field(50060; "Etat Facture"; Option)
        {
            CalcFormula = lookup("Purch. Inv. Header"."En instance Controle Facture" where("No." = field("Document No.")));
            Description = 'MH SORO 27-01-2021';
            FieldClass = FlowField;
            OptionMembers = " ","En Instance chez Contrôle Facture";
        }
        field(50100; "Code Lettrage"; Text[3])
        {
            Description = 'HJ SORO 11-04-2015';
            Editable = false;
            FieldClass = Normal;
        }
        field(50101; Boolean; Boolean)
        {

            trigger OnValidate()
            begin
                CduPurchasePost.MiseAJourEcritureComptable("Entry No.", Boolean, false, '');
            end;
        }*/
        field(3010541; "Reference No."; Code[30])
        {
            Caption = 'Reference No.';
        }
        field(8001600; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(8003924; "Apply-to Sales Order No."; Code[20])
        {
            Caption = 'Apply-to Sales Doc. No.';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order),
                                                        "No." = field("Apply-to Sales Order No."),
                                                        "Order Type" = const(" "));

            trigger OnValidate()
            begin
                //PMT_DIRECT
                TestField(Open);
                if "Apply-to Sales Order No." <> '' then begin
                    "Original Pmt. Disc. Possible" := 0;
                    "Remaining Pmt. Disc. Possible" := 0;
                end;
                //PMT_DIRECT//
            end;
        }
        field(8004100; "Bank Code"; Code[10])
        {
            Caption = 'Code Banque';
            TableRelation = "Vendor Bank Account".Code where("Vendor No." = field("Vendor No."));
        }
    }
    keys
    {
        //GL2024
        //key(STG_Key26; "Open", "Value Date") { }
        key(STG_Key27; "Vendor No.", "Vendor Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Due Date") { }
        key(STG_Key28; "Vendor No.", "Vendor Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code", "Currency Code", "Posting Date") { }
        key(STG_Key29; "Apply-to Sales Order No.") { }
        key(STG_Key30; "Job No.") { }
        key(STG_Key31; "Applies-to ID") { }
        key(STG_Key32; "Source Code", "Posting Date") { }
        key(STG_Key33; "Source Code", "Posting Date", "Document No.") { }
        key(STG_Key34;
        "Document Type")
        { }
        key(STG_Key35;
        "Vendor No.", "Document No.", Open)
        { }
        key(STG_Key36;
        Lettre)
        { }
        key(STG_Key37;
        "Document Type", "Vendor No.", "Due Date")
        { }





    }




    var
        gAddOnLicencePermission: Codeunit IntegrManagement;
        CduPurchasePost: Codeunit PurchPostEvent;
        lBARMgt: Codeunit "BAR Management";
        c: Page "CrossIntercompany Modify Setup";





}

