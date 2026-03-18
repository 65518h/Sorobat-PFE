Table 50027 "Ecriture Pointage Journalier"
{
    DrillDownPageId = "Ecriture Pointage Journalier";
    LookupPageId = "Ecriture Pointage Journalier";
    fields
    {
        field(1; "No. Pointage"; Code[60])
        {
            Caption = 'No. Pointage';
        }
        field(2; "Day Number"; integer)
        {
            caption = 'Day Number';
        }
        field(3; "Mois Attachement"; Option)
        {
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Jiun,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        }
        field(4; "Annee Attachement"; Integer)
        {
        }

        field(5; Affectation; Code[20])
        {
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service));


        }
        field(6; Statut; Option)
        {

            OptionMembers = Ouvert,Valider;
        }
        field(7; "Entry No."; Integer)
        {

        }
        field(8; Heure; Decimal)
        {
        }
        field(9; Day; Decimal)
        {
        }
        field(10; week; Integer)
        {
        }
        field(11; Date; Date)
        {
        }

        field(12; Matricule; Code[10])
        {
            SQLDataType = Integer;
            TableRelation = Employee."No.";


        }

        field(13; "First week"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = min("Ecriture Pointage Journalier".week where("No. Pointage" = field("No. Pointage")));
        }
        field(14; "week Number"; Integer)
        {
        }
        field(15; "HSup 15"; Decimal)
        {
        }
        field(35; "HSup 35"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "No. Pointage", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }



}

