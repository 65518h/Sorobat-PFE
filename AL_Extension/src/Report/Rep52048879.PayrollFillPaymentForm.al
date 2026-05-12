report 52048879 "Payroll : Fill Payment Form"
{
    //GL2024  ID dans Nav 2009 : "39001400
    Caption = 'Remplir feuille de calcul';


    ProcessingOnly = true;

    dataset
    {
        dataitem("Salary Headers"; "Salary Headers")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("No." = FILTER(<> 'SIMULATION'));
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Status = FILTER(Active), Blocked = FILTER(false));
                RequestFilterFields = "No.", "Catégorie soc.", "Statistics Group Code", Service;

                trigger OnAfterGetRecord()
                begin
                    ManagementSalary.CalculerPrimeAncienneté("No.");
                    RecPramRessHum.GET();
                    d.UPDATE(2, Employee."No." + ' : ' + Employee.FullName());
                    IF ("Salary Headers".Month < 12) OR ("Salary Headers".Month = 14) OR ("Salary Headers".Month = 15) THEN BEGIN
                        ManagementSalary.CréerLigneSalaire("Salary Headers", Employee, 1);
                        SalaryLine.RESET;
                        SalaryLine.SETRANGE("No.", "Salary Headers"."No.");
                        SalaryLine.SETRANGE(Employee, Employee."No.");
                        IF SalaryLine.FIND('-') THEN
                            IF "Salary Headers"."Désactiver calcul des prêts" = FALSE THEN
                                MgmtLoansAdvances.CréerLigneRembourcement(SalaryLine);
                    END ELSE IF "Salary Headers".Month = 13 THEN
                            ManagementSalary.CréerLigneSalaire("Salary Headers", Employee, 1)
                    ELSE BEGIN
                        ManagementSalary.CréerLignePrime("Salary Headers", Employee);
                        SalaryLine.RESET;
                        SalaryLine.SETRANGE("No.", "Salary Headers"."No.");
                        SalaryLine.SETRANGE(Employee, Employee."No.");
                        IF SalaryLine.FIND('-') THEN BEGIN
                            IF "Salary Headers"."Désactiver calcul des prêts" = FALSE THEN
                                MgmtLoansAdvances.CréerLigneRembourcement(SalaryLine);

                        END;

                    END;
                    IF "Salary Headers".Month = 15 THEN BEGIN
                        LSalaryLine.RESET;
                        LSalaryLine.SETRANGE("No.", 'SIMULATION');
                        LSalaryLine.SETRANGE(Employee, "No.");
                        IF LSalaryLine.FIND('-') THEN ManagementSalary.DeleteLine(LSalaryLine);
                        ManagementSalary.CréerSimulationPaie(Employee);
                        SalaryLine.RESET;
                        SalaryLine.SETRANGE("No.", "Salary Headers"."No.");
                        SalaryLine.SETRANGE(Employee, Employee."No.");
                        IF SalaryLine.FIND('-') THEN BEGIN
                            LSalaryLine.RESET;
                            LSalaryLine.SETRANGE("No.", 'SIMULATION');
                            LSalaryLine.SETRANGE(Employee, Employee."No.");
                            IF LSalaryLine.FIND('-') THEN SalaryLine."Net Simuler" := LSalaryLine."Net salary";
                            SalaryLine.MODIFY;

                        END;
                    END;

                    d.UPDATE(3, ROUND((i / Employee.COUNT) * 10000, 1));
                    i := i + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                d.UPDATE(1, "Salary Headers"."No." + '' + "Salary Headers".Description);
                i := 1;
            end;

            trigger OnPreDataItem()
            begin
                d.OPEN(dialogWindow
                        + '\#########################1#'
                        + '\#########################2#'
                        + '\@@@@@@@@@@@@@@@@@@@@@@@@@3@');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Employee.SETRANGE(Status, 0);
    end;

    trigger OnPostReport()
    begin
        d.CLOSE;
    end;

    trigger OnPreReport()
    begin
        /*DAT := 0D;
        sal.RESET;
        sal.SETFILTER(Status,'%1',sal.Status::Active);
        //sal.SETFILTER("Relation de travail",'%1',sal."Relation de travail"::"C.D.I");
        sal.SETFILTER("Relation de travail",'%1',sal."Relation de travail"::Titulaire);
        sal.FIND('-');
        REPEAT
          IF sal.Echelon <= 3 THEN
            BEGIN
              IF WORKDATE >= sal."Upgrading date Cat/Echelon" THEN
              ERROR('Vérifié les echellons ainsi les dates passage echellon ');
            END
          ELSE
            //DAT := CALCDATE ('<2Y>',sal."Upgrading date Cat/Echelon");MEHDI
            BEGIN
              DAT :=  sal."Upgrading date Cat/Echelon";
              IF WORKDATE >= DAT THEN
                ERROR('Vérifié les echellons ainsi les dates passage echellon ');
            END;
        UNTIL sal.NEXT = 0;
        */

    end;

    var
        ManagementSalary: Codeunit "Management of salary";
        d: Dialog;
        dialogWindow: Label 'Creating salary calculation lines.';
        i: Integer;
        SalaryLine: Record "Salary Lines";
        confMess: Label 'Replace the existing lines ?';
        MgmtLoansAdvances: Codeunit "Mgmt. of Loans and Advances";
        errEmpty: Label 'Payment No. empty.';
        DAT: Date;
        sal: Record 5200;
        "ContrôleDatePEch": Label 'Vous devez Vérifier la date de passage echellon pour le salarié %1';
        "ContrôleDateFINCONTRAT": Label 'Vous devez Vérifier la date de fin de contrat pour le salarié %1';
        RecPramRessHum: Record 5218;
        RecEmployementContract: Record 5211;
        LoanAD: Record "Loan & Advance Header";
        calculPret: Boolean;
        LSalaryLine: Record "Salary Lines";
}

