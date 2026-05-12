TableExtension 50117 "Prepayment Inv. Line BufferEXT" extends "Prepayment Inv. Line Buffer"
{
    fields
    {
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        field(8003900; "Job Task No.2"; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(8003916; Marker; Code[20])
        {
            Caption = 'Marker';
        }
    }
    keys
    {

    }
}

