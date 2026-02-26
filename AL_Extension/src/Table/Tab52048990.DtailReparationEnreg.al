Table 52048990 "Détail Reparation Enreg."
{
    //GL2024  ID dans Nav 2009 : "39004697"
    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(3; "Type Réparation"; Option)
        {
            OptionCaption = 'Reparer,Changer';
            OptionMembers = Reparer,Changer;
        }
        field(4; "Code Réparation"; Code[10])
        {
            TableRelation = Pannes;
        }
        field(5; "Désignation"; Text[100])
        {
        }
        field(6; "Montant Reparation"; Decimal)
        {
            AutoFormatType = 1;
        }
        field(7; "N° Véhicule"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "N° Reparation", "N° Ligne")
        {
            Clustered = true;
            SumIndexFields = "Montant Reparation";
        }
    }

    fieldgroups
    {
    }

    var
        LigRep: Record "Détail Reparation";
        Panne: Record Pannes;
        Repa: Record "Réparation Véhicule Enreg.";
}

