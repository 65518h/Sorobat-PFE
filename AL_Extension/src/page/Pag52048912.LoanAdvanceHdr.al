page 52048912 "Loan & Advance Hdr"
{
    //GL2024  ID dans Nav 2009 : "39001433"
    Caption = 'Liste Archives Avances En Cours';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Loan & Advance Header";
    //GL2024 SourceTableView = SORTING("Date d'effet");
    //GL2024
    SourceTableView = SORTING("No.") WHERE(Type = FILTER(Advance), Status = FILTER("In progress"));
    //GL2024
    ApplicationArea = all;
    UsageCategory = Lists;
    CardPageId = "Loan Advance archives en cours";
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                // field("N° Bon Caisse"; rec."N° Bon Caisse")
                // {
                //     ApplicationArea = all;
                //     Style = Strong;
                //     StyleExpr = TRUE;
                // }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Employee; rec.Employee)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field("Date d'effet"; rec."Date d'effet")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Date fin Prêt"; rec."Date fin Prêt")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Repayment slices1"; rec."Repayment slices")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Montant tranche"; rec."Montant tranche")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Repaid %"; rec."Repaid %")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field("Employee Posting Group"; rec."Employee Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Document type"; rec."Document type")
                {
                    ApplicationArea = all;
                }
                field("Interest %"; rec."Interest %")
                {
                    ApplicationArea = all;
                }
                field("Total to repay1"; rec."Total to repay")
                {
                    ApplicationArea = all;
                }
                field("Repaid amount"; rec."Repaid amount")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Total to repay -Repaid amount"; rec."Total to repay" - rec."Repaid amount")
                {
                    ApplicationArea = all;
                    Caption = 'Solde';
                }
                field("Repayment slices"; rec."Repayment slices")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Fiche)
            {
                Caption = 'Fiche';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Loan Advance";
                RunPageLink = "No." = FIELD("No."), Type = FIELD(Type), "Document type" = FIELD("Document type");
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}

