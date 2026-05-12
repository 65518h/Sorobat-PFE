PageExtension 50164 "Job Task Lines_PagEXT" extends "Job Task Lines"
{

    layout
    {



    }
    actions
    {
        modify("Copy Job Planning Lines &from...")
        {
            Visible = false;
        }
        modify("Copy Job Planning Lines &to...")
        {
            Visible = false;
        }

        addafter("Copy Job Planning Lines &to..._Promoted")
        {
            actionref("Copy Job Planning Lines &from2...1"; "Copy Job Planning Lines &from2...")
            {

            }

            actionref("Copy Job Planning Lines &to2...1"; "Copy Job Planning Lines &to2...")
            {


            }
        }
        addafter("Copy Job Planning Lines &to...")
        {
            action("Copy Job Planning Lines &from2...")
            {
                ApplicationArea = Jobs;
                Caption = 'Copy Project Planning Lines &from...';
                Ellipsis = true;
                Image = CopyToTask;
                ToolTip = 'Use a batch job to help you copy planning lines from one project task to another. You can copy from a project task within the project you are working with or from a project task linked to a different project.';

                trigger OnAction()
                var
                    CopyJobPlanningLines: Page "Copy Job Planning Lines";
                begin
                    Rec.TestField("Job Task Type", Rec."Job Task Type"::Posting);
                    //CopyJobPlanningLines.SetToJobTask(Rec);
                    CopyJobPlanningLines.RunModal();
                end;
            }
            action("Copy Job Planning Lines &to2...")
            {
                ApplicationArea = Jobs;
                Caption = 'Copy Project Planning Lines &to...';
                Ellipsis = true;
                Image = CopyFromTask;
                ToolTip = 'Use a batch job to help you copy planning lines from one project task to another. You can copy from a project task within the project you are working with or from a project task linked to a different project.';

                trigger OnAction()
                var
                    CopyJobPlanningLines: Page "Copy Job Planning Lines";
                begin
                    Rec.TestField("Job Task Type", Rec."Job Task Type"::Posting);
                    // CopyJobPlanningLines.SetFromJobTask(Rec);
                    CopyJobPlanningLines.RunModal();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.SetRange("Job Task Type", rec."Job Task Type"::Posting);
    end;


    var

}
