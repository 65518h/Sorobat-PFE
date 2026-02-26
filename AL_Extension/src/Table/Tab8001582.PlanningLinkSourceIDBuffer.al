Table 8001582 "Planning Link Source ID Buffer"
{
    //GL2024  ID dans Nav 2009 : "8035012"
    Caption = 'Planning Link Source ID Buffer';

    fields
    {
        field(1; "Planning Task No."; Text[20])
        {
            Caption = 'Planning Task No.';
        }
        field(100; "Source Record ID"; RecordID)
        {
            Caption = 'Source Record ID';
        }
        field(101; "Source Line No."; Integer)
        {
            Caption = 'N° ligne doc. origine';
        }
        field(102; "Task Load %"; Decimal)
        {
            Caption = 'Task Load %';
            MaxValue = 100;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Planning Task No.", "Source Record ID", "Source Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }
}

