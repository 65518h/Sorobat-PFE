TableExtension 50182 "Service Cr.Memo HeaderEXT" extends "Service Cr.Memo Header"
{
    fields
    {
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job where("Job Type" = const(External),
                                       "IC Partner Code" = const());
        }
    }

}

