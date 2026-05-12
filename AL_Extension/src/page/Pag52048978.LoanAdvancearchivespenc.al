page 52048978 "Loan Advance archives p. en c."
{ //GL2024  ID dans Nav 2009 : "39001505"
    Caption = 'Archives Prêts En Cours';
    DataCaptionExpression = FORMAT(rec.Type) + ' ' + rec."No." + '-->' + rec.Name;
    DataCaptionFields = Type, "No.", Name;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Loan & Advance Header";
    SourceTableView = SORTING("No.") WHERE(Type = FILTER(Loan), Status = FILTER("In progress"));


    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Employee; rec.Employee)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("EmplSocial Security No."; Empl."Social Security No.")
                {
                    ApplicationArea = all;
                    Caption = 'Matricule CNSS';
                    Editable = false;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Job Title"; rec."Job Title")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Not include"; rec."Not include")
                {
                    ApplicationArea = all;
                }
                //    field("N° CNPS"; Empl."N° CNPS") { ApplicationArea = all; }
                field("Avance sur congé"; rec."Avance sur congé")
                {
                    ApplicationArea = all;
                    Caption = 'Prêt sur congé';
                }
                field("Double tranche"; rec."Double tranche")
                {
                    ApplicationArea = all;
                }
                field("Avance Sur Prime"; rec."Avance Sur Prime")
                {
                    ApplicationArea = all;
                    Caption = 'Prêt Sur Prime';
                }
                field("Employee Posting Group"; rec."Employee Posting Group")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Global dimension 1"; rec."Global dimension 1")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 2"; rec."Global dimension 2")
                {
                    ApplicationArea = all;
                }
                field("Document type"; rec."Document type")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Date d'effet1"; rec."Date d'effet")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Solde; rec."Total to repay" - rec."Repaid amount") { ApplicationArea = all; }
                //   field(Amount; rec."Amount) { ApplicationArea = all; }
                field("N° document Extr."; rec."N° document Extr.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                // field("Pret CNSS"; rec."Pret CNSS")
                // {
                //     ApplicationArea = all;
                //     Visible = false;
                // }
            }
            part(Line; "Loan Advance lines")
            {
                ApplicationArea = all;
                Editable = false;
                SubPageLink = "No." = FIELD("No.");
                SubPageView = SORTING("No.", "Entry No.") ORDER(Ascending);
            }
            group(Remboursement)
            {
                Caption = 'Remboursement';
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Total to repay1"; rec."Total to repay")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Repayment slices"; rec."Repayment slices")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("%Repaid"; "%Repaid")
                {
                    ApplicationArea = all;
                    ExtendedDatatype = Ratio;
                }
                field("Montant tranche"; rec."Montant tranche")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Repaiment lines"; rec."Repaiment lines")
                {
                    ApplicationArea = all;
                }
                field("Date d'effet"; rec."Date d'effet")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field("Date fin Prêt"; rec."Date fin Prêt")
                {
                    ApplicationArea = all;
                }
                field("Repaid amount"; rec."Repaid amount")
                {
                    ApplicationArea = all;
                }
                field("Repaid %"; rec."Repaid %")
                {
                    ApplicationArea = all;
                }
                field("Total to repay-Repaid amount"; rec."Total to repay" - rec."Repaid amount")
                {
                    ApplicationArea = all;
                    Caption = 'Solde';
                    DecimalPlaces = 3 : 3;
                }
                field("Principal Amount"; rec."Principal Amount")
                {
                    ApplicationArea = all;
                }
                field("Interest Amount"; rec."Interest Amount")
                {
                    ApplicationArea = all;
                }
                field("Interest %"; rec."Interest %")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {

            group(FctButton1)
            {
                Caption = 'Fonction&s';
                actionref(So1; So) { }
                actionref("Remboursement Anticipé1"; "Remboursement Anticipé") { }
                actionref("Clôturer1"; "Clôturer") { }
                actionref("Tableau Amorissement1"; "Tableau Amorissement") { }
                actionref(Annulation1; Annulation) { }

            }

            actionref(imp1; imp) { }
        }
        area(navigation)
        {
            group(FctButton)
            {
                Caption = 'Fonction&s';
                action(So)
                {
                    ApplicationArea = all;
                    Caption = 'Solder document';
                    Image = AmountByPeriod;
                    trigger OnAction()
                    var
                        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
                        LoanAdvanceHeader: Record "Loan & Advance Header";
                    begin
                        LoanAdvanceHeader.RESET;
                        LoanAdvanceHeader.SETFILTER("No.", rec."No.");
                        REPORT.RUN(Report::"Solder Prêt", TRUE, FALSE, LoanAdvanceHeader);
                    end;
                }
                separator(separator100)
                {
                }
                action("Remboursement Anticipé")
                {
                    ApplicationArea = all;
                    Caption = 'Remboursement Anticipé';


                    trigger OnAction()
                    begin

                        RemoursementAnticipé;
                        EXIT;
                        Wind.OPEN('Montant a Rembourser #1############## ');
                        //DYS fonction obsolet
                        //Wind.INPUT(1, MntRemb);
                        Wind.CLOSE;
                        DocExt := 'R-ANT/' + rec."No.";
                        MgmtLoansAdvances.ReglerMnt(Rec, rec."Validation date", 0, rec."Bal. Account No.", DocExt, MntRemb, WORKDATE);

                    end;


                }
                action("Clôturer")
                {
                    ApplicationArea = all;
                    Caption = 'Clôturer';

                    trigger OnAction()
                    begin
                        MgmtLoansAdvances.CloturerDocument(Rec);
                    end;
                }
                action("Tableau Amorissement")
                {
                    ApplicationArea = all;
                    Caption = 'Tableau Amorissement';
                    Image = print;

                    trigger OnAction()
                    var
                        T1: Record "Loan & Advance Header";
                    begin
                        CLEAR(T1);
                        T1.RESET;
                        T1.SETFILTER("No.", rec."No.");
                        REPORT.RUN(report::"Tableau Amortissement Prêt en@", TRUE, FALSE, T1);
                    end;
                }
                separator(separato200)
                {
                }
                action(Annulation)
                {
                    ApplicationArea = all;
                    Caption = 'Annulation';
                    Image = Cancel;

                    trigger OnAction()
                    begin
                        IF rec.Status = 0 THEN
                            MgmtLoansAdvances.AnnEnregDocument(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            action(imp)
            {
                ApplicationArea = all;
                Caption = 'Imprimer Pièce Recette';

                Visible = false;

                trigger OnAction()
                var
                    T1: Record "Loan & Advance Header";
                begin
                    CurrPage.Line.page.ImprPRecette;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Empl.GET(rec.Employee) THEN;

        rec.CALCFIELDS("Repaid amount", rec."Repaid %");
        IF ((rec."Repaid amount" <> 0) AND (rec."Repaid %" <> 0)) THEN BEGIN
            "%Amont" := ROUND((rec."Repaid amount" / rec."Total to repay") * 10000, 1);
            "%Repaid" := ROUND((rec."Repaid %" / 100) * 10000, 1);
        END
        ELSE BEGIN
            "%Amont" := 0;
            "%Repaid" := 0;
        END;

        FctButtonEnable := rec.Status = 0;
    end;

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
        FctButtonEnable := TRUE;
        IF Empl.GET(rec.Employee) THEN;
    end;

    trigger OnOpenPage()
    begin
        OnActivateForm;
    end;

    var
        "%Amont": Integer;
        "%Repaid": Integer;
        Empl: Record Employee;
        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
        MntRemb: Decimal;
        Wind: Dialog;
        DocExt: Code[20];
        [InDataSet]
        FctButtonEnable: Boolean;


    procedure "RemoursementAnticipé"()
    var
        LoanAdvanceLiner: Record "Loan & Advance Lines";
        SalaryLine: Record "Salary Lines";
        TextL001: Label 'Confirmer Cette Action ?';
    begin
        // >> HJ 12-10-2018
        IF NOT CONFIRM(TextL001) THEN EXIT;
        LoanAdvanceLiner.SETRANGE("No.", rec."No.");
        LoanAdvanceLiner.SETRANGE(Paid, FALSE);
        LoanAdvanceLiner.SETRANGE(Type, LoanAdvanceLiner.Type::Loan);
        IF LoanAdvanceLiner.FINDFIRST THEN BEGIN
            SalaryLine.SETRANGE("No.", LoanAdvanceLiner."Payment No.");
            SalaryLine.SETRANGE(Employee, LoanAdvanceLiner.Employee);
            IF SalaryLine.FINDFIRST THEN BEGIN
                SalaryLine.Loans -= LoanAdvanceLiner."Line Amount";
                SalaryLine."Net salary cashed" += LoanAdvanceLiner."Line Amount";
                SalaryLine.MODIFY;
            END;
            //    LoanAdvanceLiner."Remboursement Anticipé" := TRUE;
            LoanAdvanceLiner.MODIFY;
        END;
        // >> HJ 12-10-2018
    end;

    local procedure OnActivateForm()
    begin
        IF Empl.GET(rec.Employee) THEN;
        FctButtonEnable := rec.Status = 0;
        //Currpage.imp.VISIBLE(Status = 1);
        //Currpage.imp.ENABLED(Status = 1);
    end;
}

