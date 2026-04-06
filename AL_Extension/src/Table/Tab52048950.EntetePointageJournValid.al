
Table 52048950 "Entete Pointage Journ. Validé"
{
    //GL2024  ID dans Nav 2009 : "39001442"
    fields
    {
        field(1; Sequence; Integer)
        {
        }
        field(2; Journee; Date)
        {
        }
        field(3; Annee; Integer)
        {
        }
        field(4; Periode; Integer)
        {
        }
        field(5; Jours; Integer)
        {
        }
        field(6; Salarie; Code[20])
        {
        }
        field(7; "Temps De Travail En Minute"; Integer)
        {
        }
        field(8; "Temps De Travail En Heure"; Decimal)
        {
        }
        field(9; Affecation; Code[20])
        {
            TableRelation = "Tranche STC";
        }
        field(50000; "Mois Attachement"; Option)
        {
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        }
        field(50001; Semaine; Option)
        {
            OptionMembers = S1,S2,S3,S4,S5;
        }
    }

    keys
    {
        key(STG_Key1; Affecation, Annee, "Mois Attachement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

