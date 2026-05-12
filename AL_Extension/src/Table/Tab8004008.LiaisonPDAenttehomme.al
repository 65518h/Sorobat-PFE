Table 8004008 "Liaison PDA : en-tête homme"
{
    // //LIBRE GESWAY 18/12/02 Libre

    //DrillDownPageID = 8004004;
    //LookupPageID = 8004004;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Job No."; Code[20])
        {
            //CaptionClass = '8003900,1,2';
            Caption = 'Job No.';
            //GL2024     TableRelation = "Job" where(Status = const(Order),Blocked = const(false));
            TableRelation = "Job" where(Status = const(Open), Blocked = const(" "));
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
        field(45; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
            //GL2024 TableRelation = Table8003902.Field2 where(Field1 = field("Job No."),  Field34 = const(false));
        }
        field(46; "Task Code"; Code[10])
        {
            Caption = 'Task Code';
            //GL2024  TableRelation = Task;
        }
        field(47; "Step Code"; Code[10])
        {
            Caption = 'Step Code';
            //GL2024   TableRelation = Table163;
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "No.", "Posting Date", "Job No.", "Phase Code", "Task Code", "Step Code", "Work Type Code")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }



}