Table 8004021 Mission
{
    // //INTERIM GESWAY 19/08/02 Nouvelle table des code missions intérim

    Caption = 'Mission';
    //LookupPageID = 8004021;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Bal. Job No."; Code[20])
        {
            Caption = 'Bal. Job No.';
            TableRelation = Job;
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

