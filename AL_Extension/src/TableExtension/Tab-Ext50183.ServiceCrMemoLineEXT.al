TableExtension 50183 "Service Cr.Memo LineEXT" extends "Service Cr.Memo Line"
{
    fields
    {
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
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

