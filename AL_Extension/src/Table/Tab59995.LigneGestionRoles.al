Table 59995 "Ligne Gestion Roles"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Id Formulaire"; Integer)
        {
        }
        field(3; "Nom Formulaire"; Text[200])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(4; Affecter; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code", "Id Formulaire")
        {
            Clustered = true;
        }
        key(STG_Key2; "Id Formulaire")
        {
        }
    }

    fieldgroups
    {
    }
}

