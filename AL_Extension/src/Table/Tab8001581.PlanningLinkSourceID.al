Table 8001581 "Planning Link Source ID"
{
    //GL2024  ID dans Nav 2009 : "8035011"
    Caption = 'Planning Link Source ID';

    fields
    {
        field(1; "Planning Task No."; Text[20])
        {
            Caption = 'Planning Task No.';
        }
        field(100; "Source Record ID"; RecordID)
        {
            CalcFormula = lookup("Planning Line"."Source Record ID" where("Task No." = field("Planning Task No.")));
            Caption = 'Source Record ID';
            FieldClass = FlowField;
        }
        field(101; "Source Line No."; Integer)
        {
            Caption = 'N° ligne doc. origine';
        }
        field(102; "Task Load Purcent"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Planning Task No.", "Source Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = "Task Load Purcent";
        }
    }

    fieldgroups
    {
    }
}

