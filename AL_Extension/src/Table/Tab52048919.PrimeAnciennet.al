table 52048919 "Prime Ancienneté"
{
    //GL2024  ID dans Nav 2009 : "39001466"

    DrillDownPageID = "Entete Pointage Journalier";
    LookupPageID = "Entete Pointage Journalier";

    fields
    {
        field(1; "Plage Min"; Integer)
        {
            Caption = 'Plage Min (Mois)';
        }
        field(2; "Plage Max"; Integer)
        {
            Caption = 'Plage Max (Mois)';
        }
        field(3; Taux; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Plage Min")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

