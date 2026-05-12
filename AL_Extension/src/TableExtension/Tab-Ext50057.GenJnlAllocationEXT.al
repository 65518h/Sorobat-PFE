TableExtension 50057 "Gen. Jnl. AllocationEXT" extends "Gen. Jnl. Allocation"
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
            Editable = true;
            TableRelation = Job;

            trigger OnValidate()
            var
                lJob: Record Job;
                DimSource: List of [Dictionary of [Integer, Code[20]]];
                DimDictionary: Dictionary of [Integer, Code[20]];
            begin
                //PROJET
                //GL2024    CreateDim(Database::Job, "Job No.");
                //GL2024
                DimDictionary.Add(DATABASE::Job, "Job No.");
                DimSource.Add(DimDictionary);
                CreateDim(DimSource);
                //GL2024 FIN 
                if "Job No." <> '' then
                    lJob.Get("Job No.")
                else
                    lJob.Init;
                Validate("Job Task No.", lJob.gGetDefaultJobTask);
                //PROJET//
            end;
        }
        field(8003901; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
    }
}

