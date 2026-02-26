Table 8003949 "Job Status Matrix"
{
    // //JOB_STATUS CW 24/10/05 Enable Change From To

    Caption = 'Job Status Matrix';

    fields
    {
        field(1; "From Status"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Job Status";
        }
        field(2; "To Status Code"; Code[10])
        {
            Caption = 'Description';
            TableRelation = "Job Status";
        }
    }

    keys
    {
        key(Key1; "From Status", "To Status Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        tStatusNotEnable: label 'not enable for this status on job %1';
}

