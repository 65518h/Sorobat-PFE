
Table 52048967 "Prime de Motivation SIE"
{
    //GL2024  ID dans Nav 2009 : "39001467"
    fields
    {
        field(1; "Code Employée"; Code[10])
        {
            TableRelation = Employee."No.";
        }
        field(2; "Nom Employée"; Text[100])
        {
        }
        field(3; Fonction; Code[50])
        {
        }
        field(4; "Groupe Compta."; Code[10])
        {
            TableRelation = "Employee Posting Group2";
        }
        field(5; "Groupe Statistique"; Code[10])
        {
            TableRelation = "Employee Statistics Group";
        }
        field(6; Qualification; Code[10])
        {
            TableRelation = Qualification.Code;
        }
        field(7; "Mois de Prime"; Integer)
        {
        }
        field(8; "Année de Prime"; Integer)
        {
        }
        field(9; "Posting Date"; Date)
        {
        }
        field(10; Absence; Integer)
        {
        }
        field(11; Dicipline; Integer)
        {
        }
        field(12; Rendement; Integer)
        {
        }
        field(13; "Qualité"; Integer)
        {
        }
        field(14; "Heures Sup."; Integer)
        {
        }
        field(15; "Classe Prime"; Code[10])
        {
            TableRelation = "Prime Ancienneté"."Plage Min";
        }
        field(16; "Prime Imi"; Decimal)
        {
        }
        field(17; "Prime Img"; Decimal)
        {
        }
        field(18; "Prime Imp"; Decimal)
        {
        }
        field(19; "Taux Assiduite"; Integer)
        {
        }
        field(20; "Taux Dicipline"; Integer)
        {
        }
        field(21; "Taux Rendement"; Integer)
        {
        }
        field(22; "Taux Qualité"; Integer)
        {
        }
        field(23; "Taux Disponibilité"; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code Employée")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

