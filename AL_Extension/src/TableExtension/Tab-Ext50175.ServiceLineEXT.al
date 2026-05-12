TableExtension 50175 "Service LineEXT" extends "Service Line"
{
    fields
    {
        modify("Job No.")
        {
            Description = 'Modification TableRelation';
            TableRelation = Job where("Job Type" = const(External),
                                       "IC Partner Code" = const());
            Caption = 'Job No.';

        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';
        }
        modify("Job Line Type")
        {
            Caption = 'Job Line Type';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }

        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
        }
    }




}

