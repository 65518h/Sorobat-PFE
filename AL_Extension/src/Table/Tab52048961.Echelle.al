
Table 52048961 Echelle
{
    //GL2024  ID dans Nav 2009 : "39001456"
    LookupPageID = Echelle;

    fields
    {
        field(1; "Catégorie"; Code[10])
        {
            TableRelation = CATEGORIES.Code;
        }
        field(2; Echelle; Code[10])
        {
        }
        field(3; Description; Text[30])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Catégorie", Echelle)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

