
Table 52049032 "Article Par Magasin"
{
    //GL2024  ID dans Nav 2009 : "39001516"
    fields
    {
        field(1; Article; Code[20])
        {
        }
        field(2; Magasin; Code[20])
        {
        }
        field(3; "Quantité"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; Article, Magasin)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

