Table 59997 "Affectation Utlisateur"
{

    fields
    {
        field(1; USERID; Code[20])
        {
        }
        field(2; "User Name"; Text[200])
        {
        }
        field(3; Affecter; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; USERID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

