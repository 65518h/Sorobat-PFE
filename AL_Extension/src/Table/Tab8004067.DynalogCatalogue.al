Table 8004067 "Dynalog - Catalogue"
{
    // //MULTI-DEVIS GESWAY 16/10/02 Interface Multi-Devis Express


    fields
    {
        field(1; Type; Integer)
        {
        }
        field(2; "Code"; Code[18])
        {
        }
        field(3; Ordre; Integer)
        {
        }
        field(4; Fournisseur; Code[15])
        {
        }
        field(5; CodeEltFrn; Code[18])
        {
        }
        field(6; Date; Text[20])
        {
        }
        field(7; Fabricant; Code[15])
        {
        }
        field(8; PrixTarif; Decimal)
        {
        }
        field(9; Remise; Decimal)
        {
        }
        field(10; RemiseComp; Decimal)
        {
        }
        field(11; PAU; Decimal)
        {
        }
        field(12; FraisCommande; Decimal)
        {
        }
        field(13; QteComMini; Decimal)
        {
        }
        field(14; Choix; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; Type, "Code", Ordre)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

