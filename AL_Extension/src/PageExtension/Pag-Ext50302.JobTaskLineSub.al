pageextension 50302 "Job Task Line Sub" extends "Job Task Lines Subform"
{
    layout
    {

        addafter("Job Task Type")
        {
            field("Initial Quantity"; Rec."Initial Quantity")
            {
                ApplicationArea = all;
            }
            field("Initial Unit Of Measure"; Rec."Initial Unit Of Measure") { ApplicationArea = all; }
            field("Initial Unit Price"; Rec."Initial Unit Price") { ApplicationArea = all; }
            field("Initial Amount"; Rec."Initial Amount") { ApplicationArea = all; }
        }
        // Add changes to page layout here
        addafter("Amt. Rcd. Not Invoiced")
        {
            field("DYSAmt. Rcd. Not Invoiced"; Rec."DYSAmt. Rcd. Not Invoiced")
            {
                ApplicationArea = All;
                Caption = 'Amt. Rcd. Not Invoiced';
                BlankZero = true;//
            }

        }
        modify("Amt. Rcd. Not Invoiced")
        {
            Visible = false;
            BlankZero = true;
        }
        addafter("Outstanding Orders")
        {
            field("DYSOutstanding Orders"; Rec."DYSOutstanding Orders")
            {
                ApplicationArea = All;
                Caption = 'Outstanding Orders';
                BlankZero = true;
            }
        }
        modify("Outstanding Orders")
        {
            Visible = false;
            BlankZero = true;
        }
        movebefore("Amt. Rcd. Not Invoiced"; "Outstanding Orders")

        addlast(Control1)
        {
            field(DecGVariance; DecGVariance)
            {
                ApplicationArea = all;
                Caption = 'Variance';
                StyleExpr = EcartStyle;
                BlankZero = true;
                Editable = false;
            }
            field(expectedvariation; expectedvariation)
            {
                ApplicationArea = all;
                Caption = 'Expected Variance';
                StyleExpr = EcartStyle;
                BlankZero = true;
                Editable = false;

            }
        }
    }

    actions
    {
        addafter(Line)
        {
            action(JobPlanningLines2)
            {
                ApplicationArea = all;
                Caption = 'Lignes planning projet B/F';
                Image = JobLines;
                Scope = Repeater;
                ToolTip = 'View all planning lines for the project. You use this window to plan what items, resources, and general ledger expenses that you expect to use on a project (budget) or you can specify what you actually agreed with your customer that he should pay for the project (billable).';

                trigger OnAction()
                var
                    JobPlanningLine: Record "Job Planning Line";
                    JobPlanningLines: Page "Lignes planning projet B/F";
                    IsHandled: Boolean;
                begin
                    IsHandled := false;

                    if IsHandled then
                        exit;
                    Rec.TestField("Job No.");
                    JobPlanningLine.FilterGroup(2);
                    JobPlanningLine.SetRange("Job No.", Rec."Job No.");
                    JobPlanningLine.SetRange("Job Task No.", Rec."Job Task No.");
                    JobPlanningLine.FilterGroup(0);
                    JobPlanningLines.SetTableView(JobPlanningLine);
                    JobPlanningLines.Editable := true;
                    JobPlanningLines.Run();
                end;
            }
        }

        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    begin
        rec.CalcFields("Usage (Total Cost)", "Schedule (Total Cost)", "Amt. Rcd. Not Invoiced", "DYSAmt. Rcd. Not Invoiced");
        // DecGVariance := Rec."Schedule (Total Cost)" - rec."Usage (Total Cost)" - Rec."Amt. Rcd. Not Invoiced";
        // expectedvariation := Rec."Usage (Total Cost)" - Rec."DYSAmt. Rcd. Not Invoiced" - Rec."DYSOutstanding Orders";
        DecGVariance := Rec."Initial Amount" - rec."Usage (Total Cost)" - Rec."Amt. Rcd. Not Invoiced";
        expectedvariation := Rec."Initial Amount" - Rec."Usage (Total Cost)" - Rec."DYSAmt. Rcd. Not Invoiced" - Rec."DYSOutstanding Orders";

        IF (DecGVariance <= 0) or (expectedvariation <= 0) then
            EcartStyle := 'Unfavorable'
        else
            EcartStyle := 'Favorable';

    end;

    var
        DecGVariance: Decimal;
        EcartStyle: Text;
        expectedvariation: Decimal;
}