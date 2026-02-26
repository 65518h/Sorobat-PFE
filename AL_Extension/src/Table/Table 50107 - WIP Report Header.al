table 50062 "WIP Report Header"
{
    DataClassification = ToBeClassified;
    Caption = 'WIP Report Header', Comment = 'En-tête Rapport Chantier';
    fields
    {
        field(1; "No."; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.', Comment = 'N°';
            Editable = false;
        }
        field(2; "Report Description"; text[100])
        {
            Caption = 'Description', Comment = 'Description';
        }
        field(3; "Job No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Job;
            Caption = 'Job No.', Comment = 'N° Affaire';
            trigger OnValidate()
            var
                WipReportLine: Record "WIP Report Line";
                JobReportLine: Record "Job Report Line";
            begin
                if Rec."Job No." <> xRec."Job No." then begin
                    WipReportLine.Reset();
                    WipReportLine.SetRange("WIP Report No.", Rec."No.");
                    if WipReportLine.FindSet() then
                        WipReportLine.ModifyAll("Job No.", Rec."Job No.");

                    JobReportLine.Reset();
                    JobReportLine.SetRange("WIP Report No.", Rec."No.");
                    if JobReportLine.FindSet() then
                        JobReportLine.ModifyAll("Job No.", Rec."Job No.", true);
                    if RecProject.Get(Rec."Job No.") then
                        "project description" := RecProject.Description;
                end;
            end;
        }
        field(4; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location where("Use As In-Transit" = const(FALSE), "Project Location" = const(true));
            Caption = 'Location Code', Comment = 'Code Magasin';
        }
        field(5; "WIP Report Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'WIP Report Date', Comment = 'Date Rapport Chantier';
        }
        // field(6; "Job Description"; text[100])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(job.Description where("No." = field("Job No.")));
        //     Editable = false;
        //     Caption = 'Job Description';
        // }
        field(7; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Creation Date', Comment = 'Date de création';
        }
        field(8; "Created By"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
            Editable = false;
            Caption = 'Created By', Comment = 'Créé par';
        }
        field(9; "No Series"; Code[10])
        {
            Caption = 'No Series', Comment = 'N° Série';
            TableRelation = "No. Series";
            Editable = false;
        }
        field(10; "Sum all Lines"; Decimal)
        {
            Caption = 'Sum all Lines', Comment = 'Total Lignes';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("WIP Report Line"."Wip Total Line" where("WIP Report No." = field("No.")));
        }
        field(11; Status; Enum "Dys Purchase Request status")
        {
            Caption = 'Status', Comment = 'Statut';
            DataClassification = ToBeClassified;
            ValuesAllowed = 0, 1;
            Editable = false;
        }
        field(12; "Ending date"; date)
        {
            Caption = 'Ending date', Comment = 'Date Fin';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                WipReportLine: Record "WIP Report Line";
            begin
                if Rec."Ending date" <> xRec."Ending date" then begin
                    WipReportLine.Reset();
                    WipReportLine.SetRange("WIP Report No.", Rec."No.");
                    if WipReportLine.FindSet() then
                        WipReportLine.ModifyAll("Posting Date", Rec."Ending date");

                end;
            end;
        }
        field(13; "Starting date"; Date)
        {
            Caption = 'Starting date', Comment = 'Date Début';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Ending date" := "Starting date";
            end;
        }
        field(14; "Data Entry agent"; Code[50])
        {
            Caption = 'Data Entry agent', Comment = 'Agent de Saisie';

        }
        field(15; "Data Entry Date"; Date)
        {
            Editable = false;
            Caption = 'Data Entry Date', Comment = 'Date de Saisie';
        }
        field(1000; "Job Task No."; Code[20])
        {
            Caption = 'Project Task No.', Comment = 'N° Tâche Projet';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
            trigger OnValidate()
            var
                WipReportLine: Record "WIP Report Line";
                JobReportLine: Record "Job Report Line";
            begin
                if Rec."Job Task No." <> xRec."Job Task No." then begin
                    WipReportLine.Reset();
                    WipReportLine.SetRange("WIP Report No.", Rec."No.");
                    if WipReportLine.FindSet() then
                        WipReportLine.ModifyAll("Job Task No.", Rec."Job Task No.");
                    JobReportLine.Reset();
                    JobReportLine.SetRange("WIP Report No.", Rec."No.");
                    if JobReportLine.FindSet() then
                        JobReportLine.ModifyAll("Job Task No.", Rec."Job Task No.", true);
                    RecJobTask.Reset();
                    RecJobTask.SetRange("Job No.", Rec."Job No.");
                    RecJobTask.SetRange("Job Task No.", Rec."Job Task No.");
                    if RecJobTask.FindFirst() then
                        "Project Task No. description" := RecJobTask.Description;
                end;
            end;

        }
        field(16; "project description"; Text[100])
        {
            Caption = 'Project description', Comment = 'Description Projet';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Project Task No. description"; Text[100])
        {
            Caption = 'Project Task No. description', Comment = 'Description Tâche Projet';
            DataClassification = ToBeClassified;
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        RecJobSetup: Record "Jobs Setup";
        NoSeries: Codeunit "No. Series";
        NoSeriesBatch: Codeunit "No. Series - Batch";

    begin

        if "No." = '' then begin
            RecJobSetup.Get();
            RecJobSetup.TestField("WIP Report Nos.");
            if NoSeries.AreRelated(RecJobSetup."WIP Report Nos.", xRec."No Series") then
                "No Series" := xRec."No Series"
            else
                "No Series" := RecJobSetup."WIP Report Nos.";
            "No." := NoSeries.GetNextNo("No Series", WorkDate());
            "Data Entry Date" := Today;
            "Data Entry agent" := UserId;
        end;
    end;



    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        RecProject: Record Job;
        RecJobTask: Record "Job Task";
}