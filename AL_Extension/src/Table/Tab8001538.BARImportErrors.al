Table 8001538 "BAR : Import Errors"
{
    //GL2024  ID dans Nav 2009 : "8001606"
    // //+RAP+RAPPRO GESWAY 26/06/02 Table d'anomalies d'import

    Caption = 'B.A.R. : Import Error';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(3; Text; Text[250])
        {
            Caption = 'Text';
        }
        field(4; Filename; Text[130])
        {
            Caption = 'Filename';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Errors,Import Finish';
            OptionMembers = Errors,"Import Finish";
        }
        field(6; "Record No."; Integer)
        {
            Caption = 'Record No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Type, Filename, Date, "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

