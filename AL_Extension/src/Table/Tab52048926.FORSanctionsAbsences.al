table 52048926 "FOR-Sanctions/Absences"
{
    //  DrillDownPageID = Form70094;
    //  LookupPageID = Form70094;
    //GL2024  ID dans Nav 2009 : "39001477"


    fields
    {
        field(1; "Cause Absence"; Code[20])
        {
            Caption = 'Motif Absence';
            TableRelation = "Cause of Absence".Code;
        }
        field(2; "Number of times"; Integer)
        {
            Caption = 'Nombre de fois';
        }
        field(3; "Deductibles points"; Decimal)
        {
            Caption = 'Points sanctionées';
        }
        field(4; "Deduction rate"; Decimal)
        {
            Caption = 'Taux de déduction';
        }
        field(5; "Deductible PPPS"; Boolean)
        {
            Caption = 'Déductible de la note PPPS';
        }
        field(6; "Deductible Prime"; Boolean)
        {
            Caption = 'Déductible de la note Prime';
        }
        field(7; "Code Note"; Code[20])
        {
            // TableRelation = Table70048;
        }
    }

    keys
    {
        key(Key1; "Cause Absence", "Code Note", "Number of times")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

