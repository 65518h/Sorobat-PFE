page 52048904 Loans
{
    //GL2024  ID dans Nav 2009 : "39001425"

    Caption = 'Prêt';
    PageType = Card;
    SourceTable = "Loan & Advance";
    // SourceTableView = where(Type = filter(Loan), "Generer Par Caisse" = const(false));
    SourceTableView = WHERE(Type = FILTER(Loan));
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
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
                field("Global dimension 1"; Rec."Global dimension 1")
                {
                    ApplicationArea = Basic;
                }
                field("Global dimension 2"; Rec."Global dimension 2")
                {
                    ApplicationArea = Basic;
                }
                // field("Type Pret"; Rec."Type Pret")
                // {
                //     ApplicationArea = Basic;
                // }
                // field("N° Bon Caisse"; Rec."N° Bon Caisse")
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;
                //     Style = Unfavorable;
                //     StyleExpr = true;
                // }
            }
            group(Control1907111301)
            {
                Caption = 'Prêt';
                field("Date d'effet"; Rec."Date d'effet")
                {
                    ApplicationArea = Basic;
                }
                field("Date fin Prêt"; Rec."Date fin Prêt")
                {
                    ApplicationArea = Basic;
                }
                field("Date Deblocage"; Rec."Date Deblocage")
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
                field("Montant tranche"; Rec."Montant tranche")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Document type"; Rec."Document type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("N° document Extr."; Rec."N° document Extr.")
                {
                    ApplicationArea = Basic;
                }
                field("type amortissement"; Rec."type amortissement")
                {
                    ApplicationArea = Basic;
                }
                field("Date Comptabilisation"; Rec."Date Comptabilisation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {

            actionref("Tableau D'amortissement1"; "Tableau D'amortissement")
            { }


            actionref("P&ost1"; "P&ost")

            {

            }
            actionref("Test Report1"; "Test Report")

            {

            }




        }
        area(navigation)
        {


            action("Tableau D'amortissement")
            {
                ApplicationArea = Basic;
                Caption = 'Tableau D''amortissement';
                Image = print;

                trigger OnAction()
                begin
                    Clear(T1);
                    T1.Reset;
                    T1.SetFilter("No.", Rec."No.");
                    Report.Run(Report::"Tableau Amortissement Prêt @", true, false, T1);
                end;
            }


            action("Test Report")
            {
                ApplicationArea = Basic;
                Caption = 'Imprimer';
                Image = Print;



                trigger OnAction()
                begin
                    HumRessSetup.Get();
                    LoanAdvance.SetRange("No.", Rec."No.");


                    Report.RunModal(Report::"List Loans & Advances", true, true, LoanAdvance);
                end;
            }
            /*GL2024    action("Impression liste")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impression liste';

                    trigger OnAction()
                    begin
                        LoanAdvance.SetRange(Type, 1);
                        Report.Run(39001405, true, true, LoanAdvance);
                    end;
                }*/
            action("P&ost")
            {
                ApplicationArea = Basic;
                Caption = '&Valider';
                Image = Post;

                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    LoanAdvance.SetRange("No.", Rec."No.");
                    if LoanAdvance.Find('-') then begin
                        //IF MgmtLoansAdvances.TestValiditeDocument(LoanAdvance) THEN
                        Report.RunModal(Report::"Payroll : Post Loan & Advance", true, true, LoanAdvance);
                    end;

                    CurrPage.Update(true);
                end;
            }
            action("Post and &Print")
            {
                ApplicationArea = Basic;
                Caption = 'Valider et i&mprimer';
                Image = PostPrint;
                Visible = false;

                ShortCutKey = 'Ctrl+F7';

                trigger OnAction()
                begin
                    HumRessSetup.Get();
                    LoanAdvance.SetRange("No.", Rec."No.");
                    Report.Run(52048915, false, false, LoanAdvance);
                    if LoanAdvance.Find('-') then begin
                        if MgmtLoansAdvances.TestValiditeDocument(LoanAdvance) then;
                        //  Report.RunModal(Report::"Payroll : Post Loan & Advance", true, true, LoanAdvance);
                        // REPORT.RUNMODAL (REPORT::Report8099010,TRUE,TRUE,LoanAdvance);
                    end;
                    CurrPage.Update(true);
                end;


            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := 1;
    end;

    var
        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
        HumRessSetup: Record "Human Resources Setup";
        LoanAdvance: Record "Loan & Advance";
        T1: Record "Loan & Advance";
}

