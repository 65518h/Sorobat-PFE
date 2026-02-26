Table 8004063 "Dynalog - Famille"
{
    // //MULTI-DEVIS GESWAY 16/10/02 Interface Multi-Devis Express


    fields
    {
        field(1; Type; Integer)
        {
        }
        field(2; Parent; Text[19])
        {
        }
        field(3; Ordre; Integer)
        {
        }
        field(4; IdHier; Text[21])
        {
        }
        field(5; Libelle; Text[80])
        {
        }
        field(6; CodeFam; Text[18])
        {
            Description = 'Code interne utilisé par module import';
        }
    }

    keys
    {
        key(Key1; Type, Parent, Ordre)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

