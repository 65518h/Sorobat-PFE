Table 8003945 Mask
{
    // //SECURITE GESWAY 30/05/02 Groupe de sécurité

    Caption = 'Mask';
    // DrillDownPageID = 8003945;
    //LookupPageID = 8003945;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
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

