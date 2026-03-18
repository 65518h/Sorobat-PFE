table 52048923 "FOR-Themes Formations"
{
    //GL2024  ID dans Nav 2009 : "39001472"


    // DrillDownPageID = "FOR-Themes Formations";
    // LookupPageID = "FOR-Themes Formations";

    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = "FOR-Centres Formations".Code;
        }
        field(2; "Topic Code"; Code[20])
        {
            Caption = 'Code thème';
        }
        field(3; Description; Text[50])
        {
            Caption = 'Désignation';
        }
        field(4; "Day number"; Decimal)
        {
            Caption = 'Nombre jours';
        }
        field(5; Cost; Decimal)
        {
            Caption = 'Coût';
        }
    }

    keys
    {
        key(STG_Key1; "Code", "Topic Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

