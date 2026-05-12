Table 8001522 "Statistic definition"
{
    //GL2024  ID dans Nav 2009 : "8001315"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic definitions by user

    Caption = 'Statistic definition';

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
        field(10; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(STG_Key1; "User ID", "Statistic code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

