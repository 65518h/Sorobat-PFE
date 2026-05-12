TableExtension 50181 "Service Invoice LineEXT" extends "Service Invoice Line"
{
    fields
    {

        modify("Contract No.")
        {
            //GL2024   Editable =true
            //GL2024  TestTableRelation = false;
            Description = 'Editable=No';
        }
        field(8003900; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job where("Job Type" = const(External),
                                       "IC Partner Code" = const());
        }
        field(8003901; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
    }
}

