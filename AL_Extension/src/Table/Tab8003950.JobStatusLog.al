Table 8003950 "Job Status Log"
{
    // //JOB_STATUS CW 24/10/05 Job Status Log

    Caption = 'Job Status Log';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                lJobStatus: Record "Job Status";
            begin
            end;
        }
        field(3; Date; Date)
        {
            Caption = 'Date and Time';
        }
        field(4; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(6; "Old Value"; Text[10])
        {
            Caption = 'Old Value';
            TableRelation = "Job Status";
        }
        field(7; "New Value"; Text[10])
        {
            Caption = 'New Value';
            TableRelation = "Job Status";
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Job No.", Date)
        {
        }
    }

    fieldgroups
    {
    }

    var
        tStatusNotEnable: label 'not enable for this status on job %1';
}

