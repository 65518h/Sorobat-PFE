Table 50058 "Correspondan Rapport DG"
{

    fields
    {
        field(1; "Marché"; Code[20])
        {
            TableRelation = Job."No.";
        }
        field(2; "Désignation"; Text[150])
        {
        }
        field(3; "Correspandance Decompte"; Text[250])
        {
        }
        field(4; "Correspandance Article"; Text[250])
        {
        }
        field(5; Niveau; Integer)
        {
        }
        field(6; Type; Option)
        {
            OptionMembers = " ",Depense,Rendement,"Frais Annexe";
        }
        field(7; "Type Operation"; Option)
        {
            OptionMembers = " ",Division,Multiplication;
        }
        field(8; Coeficion; Decimal)
        {
        }
        field(39; "Type Diff"; Option)
        {
            OptionMembers = " ",D,S;
        }
        field(40; "Taux Foisonnement"; Decimal)
        {
        }
        field(41; "Regroupement Difference"; Code[20])
        {
            TableRelation = "Regroupement Rapport DG";
        }
        field(42; "Regroupement Bilan"; Code[20])
        {
            TableRelation = "Regroupement Rapport DG" where(Type = const(Bilan));
        }
        field(43; "Non Inclu Reste à facturer"; Boolean)
        {
        }
        field(44; Observation; Text[200])
        {
        }
        field(45; "Prix Marché"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Marché", "Désignation")
        {
            Clustered = true;
        }
        key(Key2; Niveau)
        {
        }
        key(Key3; "Marché", Niveau)
        {
        }
    }

    fieldgroups
    {
    }
}

