PageExtension 50129 "Jobs Setup_PagEXT" extends "Jobs Setup"
{

    layout
    {
        addlast(General)
        {
            field("WIP Report Nos."; Rec."WIP Report Nos.") { ApplicationArea = all; }
            field("Journal Template Name"; Rec."Journal Template Name") { ApplicationArea = all; }
            field("Job Journal Batch"; Rec."Job Journal Batch") { ApplicationArea = all; }

        }
        addbefore(Archiving)
        {
            group(Dimensions)
            {
                field("Job Dimension Code"; Rec."Job Dimension Code")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Automatic Update Job Item Cost")
        {
            group(Sales)
            {
                Caption = 'Sales';
                field("Check sale prod. posting Gr."; Rec."Check sale prod. posting Gr.")
                {
                    ApplicationArea = all;
                }
                field("Check sale work type code"; Rec."Check sale work type code")
                {
                    ApplicationArea = all;
                }


            }
            group(Usage)
            {
                Caption = 'Usage';
                field("Check usage prod. posting Gr."; Rec."Check usage prod. posting Gr.")
                {
                    ApplicationArea = all;
                }
                field("Check usage work type code"; Rec."Check usage work type code")
                {
                    ApplicationArea = all;
                }

            }
        }
        addafter("Job Nos.")
        {
            field("Sub-Job Format"; Rec."Sub-Job Format")
            {
                ApplicationArea = all;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            field("Default Job Posting Group2"; Rec."Default Job Posting Group")
            {
                ApplicationArea = all;
            }
        }

        addafter(Numbering)
        {
            group(Specifique)
            {

                field("JouranTemplate Consommation"; Rec."JouranTemplate Consommation")
                {
                    ApplicationArea = all;
                }
                field("Batch Template"; Rec."Batch Template")
                {
                    ApplicationArea = all;
                }
                field("Code Journal"; Rec."Code Journal")
                {
                    ApplicationArea = all;
                }
                field("N° Rapport DG"; Rec."N° Rapport DG")
                {
                    ApplicationArea = all;
                }
            }
        }

    }


    actions
    {

    }


}

