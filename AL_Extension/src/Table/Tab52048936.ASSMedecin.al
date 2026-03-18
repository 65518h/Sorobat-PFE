table 52048936 "ASS-Medecin"
{//GL2024  ID dans Nav 2009 : "39001494"
 // DrillDownPageID = "ASS-Liste Medecin";
 // LookupPageID = "ASS-Liste Medecin";

    fields
    {
        field(1; "No."; Integer)
        {
        }
        field(2; Nom; Text[30])
        {
        }
        field(3; Prix; Decimal)
        {
        }
        field(4; PrixVisite; Decimal)
        {
        }
        field(5; "Type medcin"; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "No.", Nom)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

