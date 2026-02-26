TableExtension 50044 "Purch. Rcpt. LineEXT" extends "Purch. Rcpt. Line"
{
    fields
    {
        /*GL2024   modify("Buy-from Vendor No.")
           {
               Caption = 'Buy-from Vendor No.';
               Editable=true

           }
            modify("Qty. Rcd. Not Invoiced")
           {
               Editable=true

           }
            modify("Quantity Invoiced") 
           {
               Editable=true

           }
            modify("Qty. per Unit of Measure")
           {
               Editable=true

           }
               modify("Qty. Invoiced (Base)")
           {
               Editable=true

           }
           */


        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';
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
        modify("Job Line Amount")
        {
            Caption = 'Job Line Amount';
        }
        modify("Job Line Discount Amount")
        {
            Caption = 'Job Line Discount Amount';
        }
        modify("Job Line Discount %")
        {
            Caption = 'Job Line Discount %';
        }
        modify("Job Unit Price (LCY)")
        {
            Caption = 'Job Unit Price (LCY)';
        }
        modify("Job Total Price (LCY)")
        {
            Caption = 'Job Total Price (LCY)';
        }
        modify("Job Line Amount (LCY)")
        {
            Caption = 'Job Line Amount (LCY)';
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            Caption = 'Job Line Disc. Amount (LCY)';
        }
        modify("Job Currency Factor")
        {
            Caption = 'Job Currency Factor';
        }
        modify("Job Currency Code")
        {
            Caption = 'Job Currency Code';
        }


        field(50002; "N° dossier"; Code[20])
        {
            TableRelation = "Dossiers d'Importation"."N° Dossier" where(Statut = filter(<> Clôturé));
        }
        field(50003; "Fournisseur Transport"; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';
            TableRelation = Vendor;

            trigger OnValidate()
            var
                RecLPurchasePrice: Record "Purchase Price";
                TextL001: label 'Vouler Vous Ajouter Cette Fournisseur a la Liste Des Prix de Cet Article';
            begin
            end;
        }
        field(50004; Rechercher; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';

            trigger OnValidate()
            begin
                // >> HJ DSFT 05-05-2012
            end;
        }
        field(50005; "PV Generer"; Boolean)
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50006; "Sequence PV"; Integer)
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50007; Synchronise; Boolean)
        {
        }
        field(50008; "Num Sequence Syncro"; Integer)
        {
        }
        field(50011; "Purchase Request No."; Code[20])
        {
            Caption = 'Purchase Request No.';
            DataClassification = ToBeClassified;
        }
        field(50016; "Sous Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 24-11-2015';
            TableRelation = "Sous Affectation Marche" WHERE(Marche = FIELD("Job No."));
        }
        field(50017; "Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 11-10-2016';
            TableRelation = "Affectation Marche" WHERE(Marche = FIELD("Job No."));
        }
        field(50018; Provenance; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50019; Destination; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50020; "Distance Parcourus"; Decimal)
        {
        }
        field(50021; Volume; Integer)
        {
        }
        field(50022; "Num BL Fournisseur"; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."Vendor Shipment No." where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50023; Utilisateur; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."User ID" where("No." = field("Document No.")));
            Description = 'HJ SORO 17-09-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Durée Theorique (Minute)"; Decimal)
        {
        }
        field(50025; Heure; Time)
        {

            trigger OnValidate()
            begin
                "Date Saisie" := CurrentDatetime;
            end;
        }
        field(50026; "Date Saisie"; DateTime)
        {
        }
        field(50050; "affectation Frais annexe"; Boolean)
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50051; "Filtre Article"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
        }
        field(50052; "Ancien Groupe Cpt Marche TVA"; Code[10])
        {
            Description = 'HJ DSFT 06-02-2014';
        }
        field(50053; "Materiel"; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(50055; Status; Option)
        {
            Caption = 'Status';
            Description = 'HJ SORO 09-01-2015';
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Archived';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Archived,"En Cours De Verification",Reclamation;
        }
        field(50056; "Ligne Fodec"; Boolean)
        {
            Description = 'HJ SORO 20-01-2015';
        }
        field(50057; Vehicule; Code[20])
        {
            Description = 'HJ SORO 20-01-2015';
            TableRelation = Véhicule;
        }
        field(50058; "N° BL Fournisseur"; Code[20])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50170; "Type article"; Enum "Item Type")
        {

            trigger OnValidate()
            var
            begin

            end;
        }
        field(50059; Chauffeur; Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(50060; "Article Lié Au Frais Annexe"; Code[20])
        {
            TableRelation = Item;
        }
        field(50061; "Quantités Initaile"; Decimal)
        {
            Description = 'RB SORO 07/04/2015';
        }
        field(50062; "Observation"; Text[250])
        {

        }
        field(50067; "Nom Fournisseur"; Text[50])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Buy-from Vendor No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            var
                PurchRcptLine: Record "Purch. Rcpt. Line";
            begin
            end;
        }
        field(50999; "Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
        }
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60000; Inventory; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Location Code" = field("Location Filter")));
            Caption = 'Stock';
            DecimalPlaces = 0 : 5;
            Description = 'HJ SORO 18-04-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85000; "DYSJob No."; code[20])
        {
            Caption = 'Marche';
            TableRelation = Job;
            Editable = true;

        }
        field(85001; "DYSJob Task No."; code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("DYSjob No."));

        }
        field(85002; "DYSJob Planning Line No."; Integer)
        {
            Caption = 'Job Planning Line No.';
            TableRelation = "Job Planning Line"."Line No." where("Job No." = field("DYSJob No."), "Job Task No." = field("DYSJob Task No."));

        }
        field(60001; "Location Filter"; Code[20])
        {
            Description = 'HJ SORO 18-04-2015';
            FieldClass = FlowFilter;
        }
        field(60002; "Vendor Ship No."; Code[20])
        {
            Caption = 'Vendor Ship No.';
        }
        field(8001401; "Qty. Not In Conformity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Dont qté non conforme';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                lConformDateRef: Date;
            begin
                //+REF+COTFRN
                TestField(Type, Type::Item);
                if "Qty. Not In Conformity" > Quantity then
                    Error(Text8001400, FieldCaption("Qty. Not In Conformity"), FieldCaption(Quantity));

                if "Promised Receipt Date" <> 0D then
                    lConformDateRef := "Promised Receipt Date"
                else
                    lConformDateRef := "Requested Receipt Date";

                "Not In Conformity" :=
                  ("Posting Date" > lConformDateRef) or
                  ("Remainder Quantity" <> 0) or
                  ("Qty. Not In Conformity" <> 0);

                if "Qty. Not In Conformity" = 0 then
                    "Not In Conformity Code" := '';
                //+REF+COTFRN//
            end;
        }
        field(8001402; "Not In Conformity Code"; Code[10])
        {
            Caption = 'Code de non conformité';
            TableRelation = Code.Code where("Table No" = const(39),
                                             "Field No" = const(8001402));

            trigger OnValidate()
            begin
                //+REF+COTFRN
                TestField(Type, Type::Item);
                if "Not In Conformity Code" = '' then
                    "Qty. Not In Conformity" := 0;
                //+REF+COTFRN//
            end;
        }
        field(8001403; "Remainder Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantité reliquat';
            DecimalPlaces = 0 : 5;
        }
        field(8001408; "Order Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Order Line Amount';
        }
        field(8001420; "Not In Conformity"; Boolean)
        {
            Caption = 'Non Conforme';
        }
        field(8003900; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(8003902; "Charge To Order No."; Code[20])
        {
            Caption = 'Charge To Order No.';
            TableRelation = "Purchase Header Archive"."No." where("Document Type" = const(Order));
        }
        field(8004066; "Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Value 1';
            DecimalPlaces = 0 : 5;
        }
        field(8004067; "Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Value 2';
            DecimalPlaces = 0 : 5;
        }
        field(8004068; "Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Value 3';
            DecimalPlaces = 0 : 5;
        }
        field(8004069; "Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Value 4';
            DecimalPlaces = 0 : 5;
        }
        field(8004070; "Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Value 5';
            DecimalPlaces = 0 : 5;
        }
        field(8004071; "Value 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Value 6';
            DecimalPlaces = 0 : 5;
        }
        field(8004072; "Value 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Value 7';
            DecimalPlaces = 0 : 5;
        }
        field(8004073; "Value 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Value 8';
            DecimalPlaces = 0 : 5;
        }
        field(8004074; "Value 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Value 9';
            DecimalPlaces = 0 : 5;
        }
        field(8004075; "Value 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Value 10';
            DecimalPlaces = 0 : 5;
        }

        field(8214075; "Product Group Code2"; Code[10])
        {

        }
    }
    keys
    {

        key(Key9; "Sales Order No.", "Sales Order Line No.")
        {
            SumIndexFields = "Quantity (Base)";
        }

        key(Key10; "Job No.", Type, "No.", "Posting Date")
        {
            SumIndexFields = "Qty. Rcd. Not Invoiced";
        }
        key(Key11; Synchronise)
        {
        }

        key(Key12; "Job No.", "Buy-from Vendor No.", "No.")
        {
            SumIndexFields = Quantity;
        }

        key(Key13; "No.", "Buy-from Vendor No.", "Posting Date")
        {
        }
    }
    trigger OnModify()
    VAR
        lConformDateRef: Date;
    begin
        //+REF+COTFRN
        IF "Promised Receipt Date" <> 0D THEN
            lConformDateRef := "Promised Receipt Date"
        ELSE
            lConformDateRef := "Requested Receipt Date";

        "Not In Conformity" :=
          ("Not In Conformity Code" <> '') OR ("Remainder Quantity" <> 0) OR (lConformDateRef > "Posting Date");

        IF "Qty. Not In Conformity" <> 0 THEN
            TESTFIELD("Not In Conformity Code");
        IF "Not In Conformity Code" <> '' THEN
            TESTFIELD("Qty. Not In Conformity");
        //+REF+COTFRN//


    end;

    procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lQtySetup: Record "Quantity Setup";
    begin
        if not lQtySetup.Get then
            lQtySetup.Init;
        if lQtySetup."Value 1 Name" = '' then
            lQtySetup."Value 1 Name" := FieldCaption("Value 1");
        if lQtySetup."Value 2 Name" = '' then
            lQtySetup."Value 2 Name" := FieldCaption("Value 2");
        if lQtySetup."Value 3 Name" = '' then
            lQtySetup."Value 3 Name" := FieldCaption("Value 3");
        if lQtySetup."Value 4 Name" = '' then
            lQtySetup."Value 4 Name" := FieldCaption("Value 4");
        if lQtySetup."Value 5 Name" = '' then
            lQtySetup."Value 5 Name" := FieldCaption("Value 5");
        if lQtySetup."Value 6 Name" = '' then
            lQtySetup."Value 6 Name" := FieldCaption("Value 6");
        if lQtySetup."Value 7 Name" = '' then
            lQtySetup."Value 7 Name" := FieldCaption("Value 7");
        if lQtySetup."Value 8 Name" = '' then
            lQtySetup."Value 8 Name" := FieldCaption("Value 8");
        if lQtySetup."Value 9 Name" = '' then
            lQtySetup."Value 9 Name" := FieldCaption("Value 9");
        if lQtySetup."Value 10 Name" = '' then
            lQtySetup."Value 10 Name" := FieldCaption("Value 10");

        case FieldNumber of
            1:
                exit('8004050,' + lQtySetup."Value 1 Name");
            2:
                exit('8004050,' + lQtySetup."Value 2 Name");
            3:
                exit('8004050,' + lQtySetup."Value 3 Name");
            4:
                exit('8004050,' + lQtySetup."Value 4 Name");
            5:
                exit('8004050,' + lQtySetup."Value 5 Name");
            6:
                exit('8004050,' + lQtySetup."Value 6 Name");
            7:
                exit('8004050,' + lQtySetup."Value 7 Name");
            8:
                exit('8004050,' + lQtySetup."Value 8 Name");
            9:
                exit('8004050,' + lQtySetup."Value 9 Name");
            10:
                exit('8004050,' + lQtySetup."Value 10 Name");
        end;
    end;

    var
        Text8001400: label '%1 must not be greater than %2.';
        Text8004101: label 'Order No. %1 - Receipt No. %2 - Shipment No. %3';
        "// HJ": Integer;
        PurchRcptLine: Record "Purch. Rcpt. Line";
}

