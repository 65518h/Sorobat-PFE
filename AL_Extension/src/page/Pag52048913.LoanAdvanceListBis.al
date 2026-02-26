page 52048913 "Loan & Advance List Bis"
{
    //GL2024  ID dans Nav 2009 : "39001434"
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan & Advance";
    Caption = '"Loan & Advance List Bis';
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Document type"; Rec."Document type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Interest %"; Rec."Interest %")
                {
                    ApplicationArea = Basic;
                }
                field("Total to repay"; Rec."Total to repay")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment slices"; Rec."Repayment slices")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

