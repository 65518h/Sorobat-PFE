Table 52048908 "Entete Pointage Salarié Chanti"
{//GL2024  ID dans Nav 2009 : "39001438"
 // DrillDownPageID = "Alerte Imminente DA";
 // LookupPageID = "Alerte Imminente DA";

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
            tableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service));
        }
        field(50000; "Mois Attachement"; Option)
        {
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        }
        field(50001; Semaine; Option)
        {
            OptionMembers = S1,S2,S3,S4,S5;
        }
        field(50081; Statut; Option)
        {
            OptionMembers = Ouvert,Valider;
        }
    }

    keys
    {
        key(Key1; Affecation, Annee, "Mois Attachement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

