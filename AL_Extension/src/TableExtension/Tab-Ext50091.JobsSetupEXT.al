TableExtension 50091 "Jobs SetupEXT" extends "Jobs Setup"
{
    Caption = 'Jobs Setup';
    fields
    {
        modify("Job Nos.")
        {
            Caption = 'Job Nos.';
        }

        field(50000; "JouranTemplate Consommation"; Code[20])
        {
            Description = 'HJ DSFT 27-06-2012';
            TableRelation = "Job Journal Template";
        }
        field(50001; "Batch Template"; Code[20])
        {
            Description = 'HJ DSFT 27-06-2012';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("JouranTemplate Consommation"));
        }
        field(50002; "Code Journal"; Code[20])
        {
            Description = 'HJ DSFT 27-06-2012';
            TableRelation = "Source Code";
        }
        field(50003; "N° Rapport DG"; Code[20])
        {
            Caption = 'Posting No. Series';
            Description = 'HJ SORO 16-01-2018';
            TableRelation = "No. Series";
        }
        field(50100; "Job Dimension Code"; code[20])
        {
            Caption = 'Job Dimension Code';
            TableRelation = Dimension;
        }

        field(50102; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Job Journal Template";
        }
        field(50103; "Job Journal Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Job Journal Batch';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(8001407; "Check sale work type code"; Option)
        {
            Caption = 'Check sale work type code';
            OptionCaption = 'No,Item,Resource,Account (G/L),Item and resource,Item and Account (G/L),Resource and Account (G/L),Item resource and Account (G/L)';
            OptionMembers = No,Item,Resource,"Account (G/L)","Item and resource","Item and Account (G/L)","Resource and Account (G/L)","Item resource and Account (G/L)";
        }

        field(50101; "WIP Report Nos."; code[20])
        {
            Caption = 'WIP Report Nos.';
            TableRelation = "No. Series";
        }
        field(8001408; "Check usage work type code"; Option)
        {
            Caption = 'Check usage work type code';
            OptionCaption = 'No,Item,Resource,Account (G/L),Item and resource,Item and Account (G/L),Resource and Account (G/L),Item resource and Account (G/L)';
            OptionMembers = No,Item,Resource,"Account (G/L)","Item and resource","Item and Account (G/L)","Resource and Account (G/L)","Item resource and Account (G/L)";
        }
        field(8001409; "Check sale prod. posting Gr."; Option)
        {
            Caption = 'Check sale prod. posting Gr.';
            OptionCaption = 'No,Item,Resource,Account (G/L),Item and resource,Item and Account (G/L),Resource and Account (G/L),Item resource and Account (G/L)';
            OptionMembers = No,Item,Resource,"Account (G/L)","Item and resource","Item and Account (G/L)","Resource and Account (G/L)","Item resource and Account (G/L)";
        }
        field(8001410; "Check usage prod. posting Gr."; Option)
        {
            Caption = 'Check usage prod. posting Gr.';
            OptionCaption = 'No,Item,Resource,Account (G/L),Item and resource,Item and Account (G/L),Resource and Account (G/L),Item resource and Account (G/L)';
            OptionMembers = No,Item,Resource,"Account (G/L)","Item and resource","Item and Account (G/L)","Resource and Account (G/L)","Item resource and Account (G/L)";
        }
        field(8003909; "Sub-Job Format"; Code[20])
        {
            Caption = 'Sub-Job Format';
        }
        field(8003910; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(8003911; "Default Sub-Job Status"; Code[10])
        {
            Caption = 'Default Sub-Job Status';
            TableRelation = "Job Status";
        }
    }
}

