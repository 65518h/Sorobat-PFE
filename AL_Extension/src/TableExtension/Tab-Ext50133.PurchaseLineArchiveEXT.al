TableExtension 50133 "Purchase Line ArchiveEXT" extends "Purchase Line Archive"
{
    fields
    {


        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(50000; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50001; "Request Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50002; "N° Dossier"; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';
        }
        field(50003; "Fournisseur Offre DE Prix"; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';
            TableRelation = Vendor;

            trigger OnValidate()
            var
                RecLPurchasePrice: Record "7012";
                TextL001: Label 'Vouler Vous Ajouter Cette Fournisseur a la Liste Des Prix de Cet Article';
            begin
            end;
        }
        field(50004; Rechercher; Code[20])
        {
            Description = 'HJ DSFT 03-05-2012';
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
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8003900; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(8003901; "Job Task No.2"; Code[20])
        {
            Caption = 'Job Task No.';
            Description = '#8880';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."),
                                                             Blocked = filter(False));
        }
        field(8003910; "Outst. Amount Excl. VAT (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount Excl. VAT (LCY)';
            Editable = false;

            trigger OnValidate()
            var
                lCurrency2: Record Currency;
            begin
            end;
        }
        field(8003911; "Amt.Rcd. Not Inv.Excl. VAT LCY"; Decimal)
        {
            Caption = 'Amt. Rcd. Not Invoiced Excl. VAT (LCY)';

            trigger OnValidate()
            var
                lCurrency2: Record Currency;
            begin
            end;
        }
        field(8003912; "Engaged Cost (LCY)"; Decimal)
        {
            Caption = 'Engaged Cost (LCY)';
        }
        field(8003950; "Invoicing Unit"; Code[10])
        {
            Caption = 'Invoicing Unit';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));

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
        field(8004090; "Attached to Doc. No."; Code[20])
        {
            Caption = 'Attached to Doc. No.';
        }
        field(8004091; "Attached to Doc. Type"; Option)
        {
            Caption = 'Attached to Doc. Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004092; "Selected Doc. No."; Code[20])
        {
            Caption = 'Selected Doc. No.';
            TableRelation = "Purchase Line"."Document No.";
        }
        field(8004093; "Selected Doc. Line No."; Integer)
        {
            Caption = 'Selected Doc. Line No.';
        }
        field(8004094; "Ordered Line"; Boolean)
        {
            Caption = 'Ordered Line';
        }
        field(8004095; "Price Offer No."; Code[20])
        {
            Caption = 'Price Offer No.';
        }
        field(8004096; "Offer Comments"; Text[30])
        {
            Caption = 'Offer Comments';
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
        field(8004100; "Job Status"; Option)
        {
            Caption = 'Job Status';
            OptionCaption = 'Template,Quote,Order,Completed';
            OptionMembers = Template,Quote,"Order",Completed;
        }
        field(8004150; "Sales Document Type"; Option)
        {
            Caption = 'Sales Document Type';
            OptionCaption = ' ,Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
    }

    local procedure wQtyGetCaptionClass(FieldNumber: Integer): Text[80]
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

