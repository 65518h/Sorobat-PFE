Table 8001413 "Setup Comment Line"
{
    // //+BGW+MEMOPAD CW 09/02/05 New Table for setup descriptions

    Caption = 'Description Line';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
        }
        field(2; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Comment; Text[100])
        {
            Caption = 'Description';
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Table ID", "Language Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lDescLine: Record "Setup Comment Line";
    begin
        if "Line No." = 0 then begin
            lDescLine.SetRange("Table ID", "Table ID");
            lDescLine.SetRange("Language Code", "Language Code");
            if lDescLine.Find('+') then
                "Line No." := lDescLine."Line No." + 10000
            else
                "Line No." := 10000;
        end;
    end;
}

