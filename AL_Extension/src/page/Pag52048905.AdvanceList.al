page 52048905 "Advance List"
{
    //GL2024  ID dans Nav 2009 : "39001426"
    //GL2024 NOM Page dans Nav 2009 : "Loan & Advance List"
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan & Advance";
    Caption = 'Liste Avance';
    ApplicationArea = all;
    CardPageId = Advances;
    UsageCategory = Lists;
    SourceTableView = where(Type = filter(Advance));

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
                    Caption = 'N°';
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salarié';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fonction';
                }
                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    Caption = 'Groupe compta. salarié';
                    ApplicationArea = Basic;
                }
                field("Document type"; Rec."Document type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Type Document ';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Caption = 'Montant';
                }
                field("Interest %"; Rec."Interest %")
                {
                    ApplicationArea = Basic;
                    Caption = '% d''Interêt';
                }
                field("Total to repay"; Rec."Total to repay")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total à rembourser';
                }
                field("Repayment slices"; Rec."Repayment slices")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tranches de remboursement';
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {


            actionref("P&ost1"; "P&ost") { }
            /*GL2024  actionref("Post and &Print1"; "Post and &Print") { }
               actionref("Test Report1"; "Test Report") { }*/

        }
        area(processing)
        {
            group("P&osting")
            {
                Caption = 'Validation';
                /*GL2024  action("Test Report")
                  {
                      ApplicationArea = Basic;
                      Caption = 'Impression test';
                      Ellipsis = true;
                      Image = TestReport;

                      trigger OnAction()
                      begin
                          HumRessSetup.Get();
                          //CurrForm.SETSELECTIONFILTER (LoanAdvance);
                          LoanAdvance.SetFilter(Type, '%1', Rec.Type);
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
                        CurrPage.SetSelectionFilter(LoanAdvance);
                        Report.Run(Report::"Payroll : Post Loan & Advance", true, true, LoanAdvance);

                        CurrPage.Update(false);
                    end;
                }
                /*GL2024   action("Post and &Print")
                   {
                       ApplicationArea = Basic;
                       Caption = 'Valider et i&mprimer';
                       Image = PostPrint;

                       ShortCutKey = 'Ctrl+F7';

                       trigger OnAction()
                       begin
                           Report.Run(39001405, true, true, LoanAdvance);
                           CurrPage.SetSelectionFilter(LoanAdvance);
                           //GL2024  Report.Run(Report::8099011, true, true, LoanAdvance);

                           CurrPage.Update;
                       end;
                   }*/
            }
        }
    }

    var
        HumRessSetup: Record "Human Resources Setup";
        LoanAdvance: Record "Loan & Advance";
}

