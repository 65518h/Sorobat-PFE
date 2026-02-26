Table 8004002 "Working Time Line"
{
    // //POINTAGE GESWAY 07/06/02 Saisie des pointages en matrice

    Caption = 'Working Time Line';
    // DrillDownPageID = 8004004;
    // LookupPageID = 8004004;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job where(Status = const(Open),
                                       Blocked = const(" "));
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(8; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; Quantity; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(33; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type".Code;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = if ("Job No." = filter(<> '')) "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Posting Date", "Job No.", "Job Task No.", "Work Type Code")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }
}

