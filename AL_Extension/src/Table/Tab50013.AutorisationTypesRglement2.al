table 50013 "Autorisation Types Réglement2"
{
    DrillDownPageID = "Caisse Chantier";
    LookupPageID = "Caisse Chantier";

    fields
    {
        field(1; Utilisateur; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(2; "Type réglement"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; Utilisateur, "Type réglement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

