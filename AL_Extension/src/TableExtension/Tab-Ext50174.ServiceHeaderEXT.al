TableExtension 50174 "Service HeaderEXT" extends "Service Header"
{
    //DYS permission non compatible dasn page extension
    // Permissions = TableData 5907 = rmd,
    //               TableData 5914 = d,
    //                TableData 5950 = rimd;
    fields
    {


        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job where("Job Type" = const(External),
                                       "IC Partner Code" = const());

            trigger OnValidate()
            var
                lJob: Record Job;
                lJobStatus: Record "Job Status";
                lJobStatusMgt: Codeunit "Job Status Management";
                DimSource: List of [Dictionary of [Integer, Code[20]]];
                DimDictionary: Dictionary of [Integer, Code[20]];
            begin
                //JOB_SERVICE
                lJob.wCheckBlockedJob("Job No.");

                if "Job No." <> '' then
                    lJobStatusMgt.Check("Job No.", lJobStatus.FieldNo(lJobStatus."Sales Posting"));

                if not lJob.Get("Job No.") then
                    lJob.Init;

                if "Currency Code" <> '' then
                    if lJob."Currency Code" <> '' then
                        TestField("Currency Code", lJob."Currency Code");

                if lJob."Description 2" <> '' then
                    Validate("Ship-to Name", CopyStr(lJob."Description 2", 1, MaxStrLen("Ship-to Name")));
                if lJob."Job Address" <> '' then begin
                    "Ship-to Code" := '';
                    "Ship-to Address" := lJob."Job Address";
                    "Ship-to Address 2" := lJob."Job Address 2";
                    "Ship-to City" := lJob."Job City";
                    "Ship-to Post Code" := lJob."Job Post Code";
                    "Ship-to Country/Region Code" := lJob."Job Country Code";
                    "Ship-to County" := lJob."Job County";
                end;

                if ServLineExists then
                    //GL2024  UpdateServLines(FieldCaption("Job No."), CurrFieldNo <> 0);
                    UpdateServLinesByFieldNo(FieldNo("Job No."), CurrFieldNo <> 0);

                /*  GL2024    CreateDim(
                  Database::Job, "Job No.",
                  Database::Customer, "Bill-to Customer No.",
                  Database::"Salesperson/Purchaser", "Salesperson Code",
                  Database::"Responsibility Center", "Responsibility Center",
                  Database::"Service Order Type", "Service Order Type",
                  Database::"Service Contract Header", "Contract No.");*/



                //GL2024
                DimDictionary.Add(DATABASE::Job, "Job No.");
                DimDictionary.Add(DATABASE::Customer, "Bill-to Customer No.");
                DimDictionary.Add(DATABASE::"Salesperson/Purchaser", "Salesperson Code");
                DimDictionary.Add(DATABASE::"Responsibility Center", "Responsibility Center");
                DimDictionary.Add(DATABASE::"Service Order Type", "Service Order Type");
                DimDictionary.Add(DATABASE::"Service Contract Header", "Contract No.");
                DimSource.Add(DimDictionary);
                CreateDim(DimSource);
                //GL2024 FIN


                //JOB_SERVICE//
            end;
        }
    }



    var
        Text059: label 'The %1 field in the %2 table has not been filled in for record %3=%4,%5=%6.';
}

