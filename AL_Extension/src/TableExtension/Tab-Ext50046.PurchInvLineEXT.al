TableExtension 50046 "Purch. Inv. LineEXT" extends "Purch. Inv. Line"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Vendor No.';
            //GL2024   Editable = true;

        }

        /*   //GL2024     modify("VAT %")
              {

                   Editable = true;
              }
              modify("Pay-to Vendor No.")
              {

                   Editable = true;
              }
              
              modify("VAT Base Amount")
              {

                   Editable = true;
              }
              
                modify("Unit Cost")
              {

                   Editable = true;
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
        field(50016; "Sous Affectation Marche"; Code[20])
        {
            TableRelation = "Sous Affectation Marche" WHERE(Marche = FIELD("Job No."));
        }
        field(50017; "Affectation Marche"; Code[20])
        {
            TableRelation = "Affectation Marche" WHERE(Marche = FIELD("Job No."));
        }
        field(50053; "Materiel"; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(85000; "DYSJob No."; code[20])
        {
            Caption = 'Marche';
            TableRelation = Job;

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
        field(50058; "BL Fournisseur"; Code[20])
        {
            Editable = false;
        }
        field(50059; Chauffeur; Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(50060; "Article Lié Au Frais Annexe"; Code[20])
        {
            TableRelation = Item;
        }
        field(50100; "N° Bon Reception"; Code[20])
        {
        }
        field(50101; "N° Ligne Bon Reception"; Integer)
        {
        }
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51001; "Request No."; Code[20])
        {
            Caption = 'Request No.';
        }
        field(51002; "Request Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        // field(51003; "Description 2 Soroubat"; text[100])
        // {

        // }
        field(60001; "N° BL Fournisseur"; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."Vendor Shipment No." where("No." = field("N° Bon Reception")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
            Description = 'New';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
            Description = 'New';
        }
        field(8001902; "Subscription Posting Date"; Date)
        {
            Caption = 'Subscription Posting Date';
            Editable = false;
        }
        field(8001903; "Contract Base Unit Price"; Decimal)
        {
            Caption = 'Contract Base Unit Cost';
        }
        field(8003900; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(8003901; "Amount Ordered (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Ordered (LCY)';
            Editable = true;
        }
        field(8003902; "Charge To Order No."; Code[20])
        {
            Caption = 'Charge To Order No.';
            TableRelation = "Purchase Header Archive"."No." where("Document Type" = const(Order));
        }
        field(8003921; "Order No.2"; Code[20])
        {
            Caption = 'N° Commande';
        }
        field(8003950; "Invoicing Unit"; Code[10])
        {
            Caption = 'Invoicing Unit';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));

            trigger OnValidate()
            var
                ItemUnitOfMeasure: Record "Item Unit of Measure";
            begin
            end;
        }
        field(8003951; "Qty. Per Invoicing Unit"; Decimal)
        {
            //blankzero = true;
            Caption = 'Qty. Per Invoicing Unit';
            Editable = false;
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
        field(8004097; "Discount 1 %"; Decimal)
        {
            Caption = 'Discount 1 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(8004098; "Discount 2 %"; Decimal)
        {
            Caption = 'Discount 2 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(8004099; "Discount 3 %"; Decimal)
        {
            Caption = 'Discount 3 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
    }
    keys
    {


        key(STG_Key7; "Job No.", "Gen. Prod. Posting Group", "Job Task No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code")
        {
            //GL2024  SumIndexFields = "Amount Ordered (LCY)";
        }

        /*GL2024    key(STG_Key8;"N° Bon Reception","N° Ligne Bon Reception",Type,"No.")
            {
            }

            key(STG_Key9;"N° dossier","Document No.","No.","Line No.")
            {
            }*/

        key(STG_Key10; "VAT %")
        {
        }

        key(STG_Key11; "Document No.", "No.", "Job No.")
        {
        }

        key(STG_Key12; "Job No.", Type, "No.", "Posting Date")
        {
        }
    }

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
}

