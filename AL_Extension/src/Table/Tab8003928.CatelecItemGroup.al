Table 8003928 "Catelec Item Group"
{
    // //CATELEC GESWAY 07/10/04 Création des familles catelec

    Caption = 'Catelec Item Group';
    //LookupPageID = 60404;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
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

