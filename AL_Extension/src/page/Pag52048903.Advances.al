page 52048903 Advances
{
    //GL2024  ID dans Nav 2009 : "39001424"
    Caption = 'Avance';
    PageType = Card;
    SourceTable = "Loan & Advance";
    SourceTableView = where(Type = filter(Advance));
    ApplicationArea = all;
    UsageCategory = Administration;
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
                    Editable = false;

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
                // field("N° Bon Caisse"; Rec."N° Bon Caisse")
                // {
                //     ApplicationArea = Basic;
                //     Editable = true;
                //     Style = Unfavorable;
                //     StyleExpr = true;
                // }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Advance)
            {
                Caption = 'Avance';
                field("Date d'effet"; Rec."Date d'effet")
                {
                    ApplicationArea = Basic;
                }
                field("Date fin Prêt"; Rec."Date fin Prêt")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date fin Avance';
                }
                field("Date Comptabilisation"; Rec."Date Comptabilisation")
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
                field("Repayment slices"; Rec."Repayment slices")
                {
                    ApplicationArea = Basic;
                }
                field("Montant tranche"; Rec."Montant tranche")
                {
                    ApplicationArea = Basic;
                }
                field("Total to repay"; Rec."Total to repay")
                {
                    ApplicationArea = Basic;
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
                field(Control1000000000; Rec."Montant tranche")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }

                group(InfoSal)
                {
                    ShowCaption = false;
                    field("Heure Travailé"; Rec."Heure Travailé")
                    {
                        ApplicationArea = Basic;
                        Visible = "Heure TravailéVisible";
                    }
                    field("Salaire de Base"; Rec."Salaire de Base")
                    {
                        ApplicationArea = Basic;
                        Visible = "Salaire de BaseVisible";
                    }
                    field("jour Absence"; Rec."jour Absence")
                    {
                        ApplicationArea = Basic;
                        Visible = "jour AbsenceVisible";
                    }
                    field("Montant H Travail"; Rec."Montant H Travail")
                    {
                        ApplicationArea = Basic;
                        Visible = "Montant H TravailVisible";
                    }
                    field("Montant H sup"; Rec."Montant H sup")
                    {
                        ApplicationArea = Basic;
                    }
                    field(calcsb1; calcsb)
                    {
                        ApplicationArea = Basic;
                        AutoFormatType = 2;
                        Caption = 'Salaire de base réel';
                        Editable = false;
                    }
                    field("Total Avance Mois"; Rec."Total Avance Mois")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Avance Sur Prime"; Rec."Avance Sur Prime")
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



            /*GL2024  actionref("Test Report1"; "Test Report") { }
              actionref("Impression liste1"; "Impression liste") { }*/
            actionref(Imprimer1; Imprimer) { }
            actionref("P&ost1"; "P&ost") { }
            actionref("Post and &Print1"; "Post and &Print") { }

        }
        area(processing)
        {

            /*GL2024  action("Test Report")
              {
                  ApplicationArea = Basic;
                  Caption = 'Impression test';
                  Ellipsis = true;
                  Image = TestReport;

                  trigger OnAction()
                  begin
                      HumRessSetup.Get();
                      LoanAdvance.SetRange("No.", Rec."No.");
                      Report.Run(39001405, true, true, LoanAdvance);
                  end;
              }
              action("Impression liste")
              {
                  ApplicationArea = Basic;
                  Caption = 'Impression liste';

                  trigger OnAction()
                  begin
                      LoanAdvance.SetRange(Type, 0);
                      Report.Run(39001405, true, true, LoanAdvance);
                  end;
              }*/
            action(Imprimer)
            {
                ApplicationArea = Basic;
                Caption = 'Imprimer';
                Image = Print;

                trigger OnAction()
                begin
                    HumRessSetup.Get();
                    LoanAdvance.SetRange("No.", Rec."No.");
                    /*  LoanAdvance.SetRange("Document type", Rec."Document type");
                      LoanAdvance.SetRange(Type, Rec.Type);*/


                    Report.RunModal(Report::"List Loans & Advances", true, true, LoanAdvance);
                end;
            }
            action("P&ost")
            {
                ApplicationArea = Basic;
                Caption = '&Valider';
                Image = Post;

                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    LoanAdvance.SetRange("No.", Rec."No.");
                    LoanAdvance.SetRange("Document type", Rec."Document type");
                    LoanAdvance.SetRange(Type, Rec.Type);

                    if LoanAdvance.Find('-') then begin
                        //IF MgmtLoansAdvances.TestValiditeDocument(LoanAdvance) THEN
                        Report.RunModal(Report::"Payroll : Post Loan & Advance", true, true, LoanAdvance);
                    end;

                    CurrPage.Update;
                end;
            }
            action("Post and &Print")
            {
                ApplicationArea = Basic;
                Caption = 'Valider et i&mprimer';
                Image = PostPrint;

                ShortCutKey = 'Ctrl+F7';
                Visible = false;

                trigger OnAction()
                begin
                    HumRessSetup.Get();
                    LoanAdvance.SetRange("No.", Rec."No.");
                    LoanAdvance.SetRange("Document type", Rec."Document type");
                    LoanAdvance.SetRange(Type, Rec.Type);

                    //REPORT.RUN(50160,FALSE,FALSE,LoanAdvance);


                    if LoanAdvance.Find('-') then begin
                        if MgmtLoansAdvances.TestValiditeDocument(LoanAdvance) then;
                        // Report.RunModal(Report::"Payroll : Post Loan & Advance", true, true, LoanAdvance);
                    end;

                    CurrPage.Update;
                end;

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Montant H TravailVisible" := true;
        "Heure TravailéVisible" := true;
        "jour AbsenceVisible" := true;
        "Salaire de BaseVisible" := true;
        datet := WorkDate;
        datet := Dmy2date(1, Date2dmy(datet, 2), Date2dmy(datet, 3));
        Rec.SetFilter("Filtre Date", '%1..%2', datet, CalcDate('+FM', datet));
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := 0;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    var
        HumRessSetup: Record "Human Resources Setup";
        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
        LoanAdvance: Record "Loan & Advance";
        Cnt: Record "Employment Contract";
        sl: Record Employee;
        reg: record "Regimes of work";
        datet: Date;
        sal: Record Employee;
        [InDataSet]
        "Salaire de BaseVisible": Boolean;
        [InDataSet]
        "jour AbsenceVisible": Boolean;
        [InDataSet]
        "Heure TravailéVisible": Boolean;
        [InDataSet]
        "Montant H TravailVisible": Boolean;


    procedure calcsb() SalaireB: Decimal
    begin
        SalaireB := 0;
        if Rec.Employee <> '' then begin
            Clear(sl);
            sl.Get(Rec.Employee);
            Clear(Cnt);
            Cnt.Get(sl."Emplymt. Contract Code");
            Clear(reg);
            reg.Get(Cnt."Regimes of work");
            case Rec."Type Salarié" of
                0:
                    SalaireB := Rec."Montant H Travail" + Rec."Montant H sup";
                1:
                    SalaireB := (Rec."Salaire de Base" * Rec."jour Absence" / reg."Worked Day Per Month") + Rec."Montant H sup";
            end;
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        case Rec."Type Salarié" of
            0:
                begin
                    "Salaire de BaseVisible" := false;
                    "jour AbsenceVisible" := false;
                    "Heure TravailéVisible" := true;
                    "Montant H TravailVisible" := true;
                end;
            1:
                begin
                    "Salaire de BaseVisible" := true;
                    "jour AbsenceVisible" := true;
                    "Heure TravailéVisible" := false;
                    "Montant H TravailVisible" := false;

                end;
        end;
        datet := 0D;
        if Format(Rec."Date Comptabilisation") <> '' then
            datet := Rec."Date Comptabilisation"
        else
            datet := WorkDate;
        datet := Dmy2date(1, Date2dmy(datet, 2), Date2dmy(datet, 3));
        Rec.SetFilter("Filtre Date", '%1..%2', datet, CalcDate('+FM', datet));


        /*sal.RESET;
        sal.SETRANGE("No.",Employee);
        IF sal.FIND('-') THEN
          BEGIN
            IF sal.Confidentiel=TRUE THEN CurrForm.InfoSal.VISIBLE:=FALSE;
            IF sal.Confidentiel=FALSE THEN CurrForm.InfoSal.VISIBLE:=TRUE;
            //MESSAGE('OK  '+Employee + '  '+FORMAT(sal.Confidentiel));
          END ELSE
          BEGIN
          CurrForm.InfoSal.VISIBLE:=FALSE;
          //MESSAGE('non trouvé');
        END; */

    end;
}

