TableExtension 50029 "BOM ComponentEXT" extends "BOM Component"
{

    fields
    {
        modify(Description)
        {
            Description = 'Navibat ';
        }
        modify("BOM Description")
        {
            Description = 'Navibat ';
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate()
            begin
                //DEVIS
                wCalcQty.wCalcQtyBOMItem(Rec);
                //DEVIS//
            end;
        }


        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8004066; "Value 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(1);
            Caption = 'Value 1';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004067; "Value 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(2);
            Caption = 'Value 2';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004068; "Value 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(3);
            Caption = 'Value 3';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004069; "Value 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(4);
            Caption = 'Value 4';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004070; "Value 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(5);
            Caption = 'Value 5';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004071; "Value 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(6);
            Caption = 'Value 6';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004072; "Value 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(7);
            Caption = 'Value 7';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004073; "Value 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(8);
            Caption = 'Quantity 8';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004074; "Value 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(9);
            Caption = 'Quantity 9';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
        field(8004075; "Value 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wQtyGetCaptionClass(10);
            Caption = 'Quantity 10';

            trigger OnValidate()
            begin
                wCalcQty.wCalcQtyBOMItem(Rec);
            end;
        }
    }


    trigger OnAfterInsert()
    begin
        //+BAT+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+BAT+REPLIC//

    end;

    trigger OnAfterModify()
    var

        lReplicationRef: RecordRef;
    begin
        //+BAT+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+BAT+REPLIC//

    end;

    trigger OnDelete()
    begin
        //+BAT+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+BAT+REPLIC//

    end;

    trigger OnAfterRename()
    VAR
        lReplicationRef: RecordRef;
    begin
        //+BAT+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+BAT+REPLIC//

    end;

    LOCAL PROCEDURE wQtyGetCaptionClass(FieldNumber: Integer): Text[80];
    VAR
        lQtySetup: Record "Quantity Setup";
    BEGIN
        IF NOT lQtySetup.GET THEN
            lQtySetup.INIT;
        IF lQtySetup."Value 1 Name" = '' THEN
            lQtySetup."Value 1 Name" := FIELDCAPTION("Value 1");
        IF lQtySetup."Value 2 Name" = '' THEN
            lQtySetup."Value 2 Name" := FIELDCAPTION("Value 2");
        IF lQtySetup."Value 3 Name" = '' THEN
            lQtySetup."Value 3 Name" := FIELDCAPTION("Value 3");
        IF lQtySetup."Value 4 Name" = '' THEN
            lQtySetup."Value 4 Name" := FIELDCAPTION("Value 4");
        IF lQtySetup."Value 5 Name" = '' THEN
            lQtySetup."Value 5 Name" := FIELDCAPTION("Value 5");
        IF lQtySetup."Value 6 Name" = '' THEN
            lQtySetup."Value 6 Name" := FIELDCAPTION("Value 6");
        IF lQtySetup."Value 7 Name" = '' THEN
            lQtySetup."Value 7 Name" := FIELDCAPTION("Value 7");
        IF lQtySetup."Value 8 Name" = '' THEN
            lQtySetup."Value 8 Name" := FIELDCAPTION("Value 8");
        IF lQtySetup."Value 9 Name" = '' THEN
            lQtySetup."Value 9 Name" := FIELDCAPTION("Value 9");
        IF lQtySetup."Value 10 Name" = '' THEN
            lQtySetup."Value 10 Name" := FIELDCAPTION("Value 10");

        CASE FieldNumber OF
            1:
                EXIT('8004050,' + lQtySetup."Value 1 Name");
            2:
                EXIT('8004050,' + lQtySetup."Value 2 Name");
            3:
                EXIT('8004050,' + lQtySetup."Value 3 Name");
            4:
                EXIT('8004050,' + lQtySetup."Value 4 Name");
            5:
                EXIT('8004050,' + lQtySetup."Value 5 Name");
            6:
                EXIT('8004050,' + lQtySetup."Value 6 Name");
            7:
                EXIT('8004050,' + lQtySetup."Value 7 Name");
            8:
                EXIT('8004050,' + lQtySetup."Value 8 Name");
            9:
                EXIT('8004050,' + lQtySetup."Value 9 Name");
            10:
                EXIT('8004050,' + lQtySetup."Value 10 Name");
        END;
    END;


    var

        wReplicationRef: RecordRef;
        wCalcQty: Codeunit "Calculate Quantity";
        wReplicationTrigger: Codeunit "Replication Trigger";

}

