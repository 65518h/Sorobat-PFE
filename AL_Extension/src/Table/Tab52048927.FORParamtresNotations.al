table 52048927 "FOR-Paramétres Notations"
{

    //GL2024  ID dans Nav 2009 : "39001478"
    //  DrillDownPageID = 70095;
    // LookupPageID = 70095;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
        {
            Caption = 'Désignation';
        }
        field(3; Periodicity; DateFormula)
        {
            Caption = 'Périodicité';
        }
        field(4; "Echele Notation"; Integer)
        {
            Caption = 'Echèle de notation';
        }
        field(5; "Partie Ponctualité"; Decimal)
        {
        }
        field(6; "Partie Sécurité"; Decimal)
        {
        }
        field(7; "Partie Productivité"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

