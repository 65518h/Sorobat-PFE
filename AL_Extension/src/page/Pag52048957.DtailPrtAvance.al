page 52048957 "Détail Prêt Avance"
{//GL2024  ID dans Nav 2009 : "39001478"
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Loan & Advance Entry";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Détail Prêt Avance';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Document type"; Rec."Document type")
                {
                    ApplicationArea = Basic;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic;
                }
                field("Date Paie"; Rec."Date Paie")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Payment No."; Rec."Payment No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Entry type"; Rec."Entry type")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Global dimension 1"; Rec."Global dimension 1")
                {
                    ApplicationArea = Basic;
                }
                field("Global dimension 2"; Rec."Global dimension 2")
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

