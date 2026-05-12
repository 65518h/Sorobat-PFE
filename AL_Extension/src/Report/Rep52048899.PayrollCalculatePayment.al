report 52048899 "Payroll : Calculate Payment"
{
    // //GL2024  ID dans Nav 2009 : "39001401"
    // Caption = 'Calculer salaires';
    // ProcessingOnly = true;
    Caption = 'Calculer salaires';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Salary Headers"; "Salary Headers")
        {
            DataItemTableView = sorting("No.") order(ascending);
            column(ReportForNavId_1; 1)
            {
            }
            dataitem("Salary Lines"; "Salary Lines")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.", Employee) order(ascending);
                RequestFilterFields = Employee;
                column(ReportForNavId_2; 2)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    d.Update(2, "Salary Lines".Employee + ' : ' + "Salary Lines".Name + ' ( ' + "Salary Lines"."Employee Posting Group" + ' )');
                    Clear(ManagementSalary);
                    if ("Salary Headers".Month < 12) or ("Salary Headers".Month = 14) or ("Salary Headers".Month = 15) then
                        ManagementSalary.CalculerLigneSalaire("Salary Lines", solder, 1, Nbrej, false)
                    else
                        case "Salary Headers".Month of
                            12:
                                ManagementSalary.CalculerLignePrime("Salary Lines", solder, 1, Nbrej);
                            13:
                                ManagementSalary.CalculerLigneConge("Salary Lines", solder, 1, Nbrej, false);
                            14:
                                ManagementSalary.CalculerLignePrimeRend("Salary Lines", solder, 1, Nbrej, DatGDateDebut, DatGDateFin);
                            16:
                                ManagementSalary.CalculerLigneConge("Salary Lines", true, 1, Nbrej, false);
                            15:
                                ManagementSalary.CalculerLigneSalaireRetraite("Salary Lines", solder, 1, Nbrej, false)
                        end;
                    if "Salary Lines".Count <> 0 then
                        d.Update(3, ROUND((i / "Salary Lines".Count) * 10000, 1));
                    i := i + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                d.Update(1, "Salary Headers"."No." + ' : ' + "Salary Headers".Description);
                i := 1;
                SalaryLines.SetRange("No.", "Salary Headers"."No.");
                if (("Salary Headers"."Paid days" = 0) or ("Salary Headers"."Worked days" = 0)) then
                    Error('Erreur : Nombre de Jour / Nombre de jours ouvrables ne peuvent pas être nuls.');
                if not SalaryLines.Find('-') then
                    Error(errNoLines);
                "Salary Headers"."Taxes regulation" := SetupGRH."Taxes regulation";
                "Salary Headers"."Number of monthes" := SetupGRH."Number of monthes";
                "Salary Headers".Modify;
            end;

            trigger OnPreDataItem()
            begin
                d.Open(dialogWindow
                        + '\#######################################1#'
                        + '\#######################################2#'
                        + '\@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@3@');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(solder; solder)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Solder droit congé';
                        Visible = true;
                        trigger OnValidate()
                        begin

                            IF solder THEN
                                nbj := TRUE
                            ELSE BEGIN
                                nbj := FALSE;
                                Nbrej := 0;
                            END;
                        end;
                    }
                    field(nbj; Nbrej)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Nbre de Jours a Solder';
                        DecimalPlaces = 0 : 2;
                        Visible = true;
                        Editable = nbj;
                    }
                    field(DatGDateDebut; DatGDateDebut)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Date Début';
                    }
                    field(DatGDateFin; DatGDateFin)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Date Fin';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Nbrej := 0;


            nbj := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        SetupGRH.Get();
    end;

    trigger OnPostReport()
    begin
        "Salary Headers"."Up to date" := true;
        "Salary Headers".Modify;
        d.Close;
    end;

    var
        SetupGRH: Record "Human Resources Setup";
        ManagementSalary: Codeunit "Management of salary";
        d: Dialog;
        dialogWindow: label 'Calcul des salaires en cours';
        i: Integer;
        SalaryLines: Record "Salary Lines";
        confMess: label 'Remplacer les lignes existantes ?';
        solder: Boolean;
        errNoLines: label 'Pas de lignes de salaires sur le formulaire en cours. Impossible de poursuivre.';
        Nbrej: Decimal;
        DatGDateDebut: Date;
        DatGDateFin: Date;
        nbj: Boolean;
}

