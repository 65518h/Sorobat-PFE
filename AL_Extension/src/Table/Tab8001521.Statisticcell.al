Table 8001521 "Statistic cell"
{
    //GL2024  ID dans Nav 2009 : "8001314"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statatistic cells by user

    Caption = 'Statistic cell';

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(3; "Statistic code"; Code[10])
        {
            Caption = 'Statistic code';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(11; "Column No."; Integer)
        {
            Caption = 'Column No.';
        }
        field(20; "Computed result"; Decimal)
        {
            Caption = 'Computed result';
        }
        field(21; "Printed result"; Text[30])
        {
            Caption = 'Printed result';
        }
    }

    keys
    {
        key(Key1; "User ID", "Statistic code", "Line No.", "Column No.")
        {
            Clustered = true;
            SumIndexFields = "Computed result";
        }
    }

    fieldgroups
    {
    }
}

