Table 8001411 Translation2
{
    // #5467 CLA 25/01/08
    // //+BGW+TRANSLATION GESWAY 26/01/02 New table for Code translation

    //DrillDownPageID = 8001425;
    //LookupPageID = 8001423;

    fields
    {
        field(1; TableID; Integer)
        {
            Caption = 'ID Table';
        }
        field(2; FieldID; Integer)
        {
        }
        field(3; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(4; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(Key1; TableID, FieldID, "Code", "Language Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure FindTranslation(var pRec: Record Translation2; pTableID: Integer; pFieldID: Integer; pCode: Code[20]; pLanguageCode: Code[10]): Boolean

    begin
        with pRec do begin
            SetRange(TableID, pTableID);
            SetRange(FieldID, pFieldID);
            SetRange(Code, pCode);
            SetRange("Language Code", pLanguageCode);
            if FindSet then
                exit(true)
            else begin
                SetRange("Language Code", '');
                exit(FindSet);
            end;
        end;
    end;
}

