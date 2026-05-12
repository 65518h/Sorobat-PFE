page 52048914 "Repayment lines"
{
    //GL2024  ID dans Nav 2009 : "39001435"
    Caption = 'Lignes de remboursement';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan & Advance Lines";
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
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principal Amount"; Rec."Principal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Document type"; Rec."Document type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Line %"; Rec."Line %")
                {
                    ApplicationArea = Basic;
                }
                field("Payment No."; Rec."Payment No.")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
                field(Paid; Rec.Paid)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        Header: Record "Loan & Advance Header";
        errAmount: label 'Error on the inserted Amount.';
}

