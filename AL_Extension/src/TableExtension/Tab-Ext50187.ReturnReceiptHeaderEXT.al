TableExtension 50187 "Return Receipt HeaderEXT" extends "Return Receipt Header"
{
    fields
    {
        modify("Warehouse Handling Time")
        {
            Caption = 'Warehouse Handling Time';
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job;

            trigger OnValidate()
            var
                lContributor: Record "Sales Contributor";
                lContributor2: Record "Sales Contributor";
                //  lJobStatusMgt: Codeunit "Job Status Management";
                lJobStatus: Record "Job Status";
            begin
            end;
        }
    }
}

