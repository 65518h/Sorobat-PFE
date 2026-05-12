page 52048933 "Calculation of salaries"
{
    //GL2024  ID dans Nav 2009 : "39001454"
    Caption = 'Calcul des salaires';
    PageType = Card;
    SourceTable = "Salary Headers";
    // SourceTableView = WHERE(STC = CONST(false)); 


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';
                group("Salary header")
                {
                    Caption = 'En-tête de Salaire';
                    field("No."; rec."No.")
                    {
                        ApplicationArea = all;
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            IF rec.AssistEdit(xRec) THEN
                                CurrPage.UPDATE;
                        end;
                    }
                    field("Posting Date"; rec."Posting Date")
                    {
                        ApplicationArea = all;
                        Caption = 'Date Comptabilisation';
                    }
                    // field("Integrer Rappel"; rec."Integrer Rappel")
                    // {
                    //     ApplicationArea = all;
                    // }
                    // field("Année Rappel"; rec."Année Rappel")
                    // {
                    //     ApplicationArea = all;
                    // }

                    field(Description; rec.Description)
                    {
                        ApplicationArea = all;
                        Caption = 'Description';
                    }
                    field(Month; rec.Month)
                    {
                        ApplicationArea = all;
                        Caption = 'Mois';

                        trigger OnValidate()
                        begin
                            MonthOnAfterValidate;
                        end;
                    }
                    field(Year; rec.Year)
                    {
                        ApplicationArea = all;
                        Caption = 'Année';
                    }
                    field("year of Calculate"; rec."year of Calculate")
                    {
                        ApplicationArea = all;
                        //  Visible = "year of CalculateVisible";
                        Visible = false;
                        Caption = 'Année du calcul';
                    }
                }
            }
            part(SalaryLinepage; "Calculation lines")
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }


            group("Cumulated salaries")
            {
                Caption = 'Salaires cumulés';
                field("Employee No. filter1"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre N° salarié';
                }
                field("Employee posting grp. filter1"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Salary basis total1"; rec."Salary basis total")
                {
                    ApplicationArea = all;
                }
                field("Total Supp. Hours1"; rec."Total Supp. Hours")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities total1"; rec."Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Total Gross salary1"; rec."Total Gross salary")
                {
                    ApplicationArea = all;
                }
                field("Non Taxable Soc. Contrib.1"; rec."Non Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities (Not Gross1"; rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                }
                field("Total taxable"; rec."Total taxable")
                {
                    ApplicationArea = all;
                }
                field("Taxable Soc. Contrib.1"; rec."Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                }
                field("Taxes total1"; rec."Taxes total")
                {
                    ApplicationArea = all;
                }
                field("Non Taxable indemnities total1"; rec."Non Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Mission expenses total1"; rec."Mission expenses total")
                {
                    ApplicationArea = all;
                }
                field("Net salary total"; rec."Net salary total")
                {
                    ApplicationArea = all;
                }
                field("Loans repaiment total1"; rec."Loans repaiment total")
                {
                    ApplicationArea = all;
                }
                field("Advances repaiment total1"; rec."Advances repaiment total")
                {
                    ApplicationArea = all;
                }
                field("Ajout en +1"; rec."Ajout en +")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Report en -1"; rec."Report en -")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Net salary cashed1"; rec."Net salary cashed")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Filter1"; rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre département';
                }
                field("Global Dimension 2 Filter1"; rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre dossier';
                }
                field("Salary lines1"; rec."Salary lines")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic1"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
                // field("Filter Direction"; rec."Filter Direction")
                // {
                //     ApplicationArea = all;
                // }
                // field("Filter Service"; rec."Filter Service")
                // {
                //     ApplicationArea = all;
                // }
                // field("Filter Section"; rec."Filter Section")
                // {
                //     ApplicationArea = all;
                // }
            }
            group("Paiement balance")
            {
                Caption = 'Balance de paie';
                field("Employee No. filter2"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre N° salarié';
                }
                field("Employee posting grp. filter2"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Salary lines2"; rec."Salary lines")
                {
                    ApplicationArea = all;
                }
                label(Débit)
                {
                    ApplicationArea = all;
                    Caption = 'Débit';
                }
                field("Salary basis total2"; rec."Salary basis total")
                {
                    ApplicationArea = all;
                }
                field("Total Supp. Hours2"; rec."Total Supp. Hours")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities total2"; rec."Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities (Not Gross2"; rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                }
                field("Non Taxable indemnities total2"; rec."Non Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Mission expenses total2"; rec."Mission expenses total")
                {
                    ApplicationArea = all;
                }
                field("Total1"; rec."Total Gross salary" + rec."Mission expenses total" + rec."Non Taxable indemnities total" + rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    Caption = 'Total';
                    DecimalPlaces = 3 : 3;
                }
                field("Global Dimension 1 Filter2"; rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre département';
                }
                field("Global Dimension 2 Filter2"; rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre dossier';
                }
                field("Filter gpe statistic2"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
                label(Crédit)
                {
                    ApplicationArea = all;
                    Caption = 'Crédit';
                }
                field("Non Taxable Soc. Contrib."; rec."Non Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                }
                field("Taxable Soc. Contrib.2"; rec."Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                }
                field("Loans repaiment total"; rec."Loans repaiment total")
                {
                    ApplicationArea = all;
                }
                field("Advances repaiment total"; rec."Advances repaiment total")
                {
                    ApplicationArea = all;
                }
                field("Taxes total"; rec."Taxes total")
                {
                    ApplicationArea = all;
                }
                field("Net salary cashed"; rec."Net salary cashed")
                {
                    ApplicationArea = all;
                }
                field("Ajout en +"; rec."Ajout en +")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = true;
                }
                field("Report en -"; rec."Report en -")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = true;
                }
                field("Total"; rec."Taxable Soc. Contrib." + rec."Non Taxable Soc. Contrib." + rec."Loans repaiment total" + rec."Advances repaiment total" + rec."Taxes total" + rec."Net salary cashed" + rec."Report en -" - rec."Ajout en +")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    Caption = 'Total';
                    DecimalPlaces = 3 : 3;
                }
            }
            group("Human Ress. cost")
            {
                Caption = 'Coût Ressources humaines';

                field("Employee No. filter"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre N° salarié';
                }
                field("Employee posting grp. filter"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Filter"; rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filter département';
                }
                field("Global Dimension 2 Filter"; rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre dossier';
                }
                field("Salary lines"; rec."Salary lines")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
                field("Salary basis total4"; rec."Salary basis total")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities total"; rec."Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities (Not Gross"; rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                }
                field("Non Taxable indemnities total"; rec."Non Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Mission expenses total"; rec."Mission expenses total")
                {
                    ApplicationArea = all;
                }
                field("Total Supp. Hours"; rec."Total Supp. Hours")
                {
                    ApplicationArea = all;
                }
                field("Total Charges patronales"; rec."Total Charges patronales")
                {
                    ApplicationArea = all;
                }
                field("Coût total"; rec."Salary basis total" + rec."Taxable indemnities total" + rec."Non Taxable indemnities total" + rec."Mission expenses total" + rec."Total Supp. Hours" + rec."Total Charges patronales" + rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                    AutoFormatType = 2;
                }
                field("Coût moyen salarié"; rec."Salary basis total" + rec."Taxable indemnities total" + rec."Non Taxable indemnities total" + rec."Mission expenses total" + rec."Total Supp. Hours" + rec."Total Charges patronales" + rec."Taxable indemnities (Not Gross" / Nvl(rec."Salary lines", 1))
                {
                    ApplicationArea = all;
                    AutoFormatType = 2;
                }
            }
            group("Absences/Days off")
            {
                Caption = 'Congés/Absences';
                field("Employee No. filter3"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre N° salarié';
                }
                field("Employee posting grp. filter3"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Filter3"; rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre département';
                }
                field("Global Dimension 2 Filter3"; rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre dossier';
                }
                field("Salary lines3"; rec."Salary lines")
                {
                    ApplicationArea = all;
                }
                field(Abcences; rec.Abcences)
                {
                    ApplicationArea = all;
                }
                field("Congés pris"; rec."Congés pris")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic3"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
            }
            group("Loans/Advances")
            {
                Caption = 'Prêts/Avanaces';
                field("Employee No. filter4"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre N° salarié';
                }
                field("Employee posting grp. filter4"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Loan & Advance Type filter"; rec."Loan & Advance Type filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre Type Prêts/Avances';
                }
                field("Global Dimension 1 Filter4"; rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre département';
                }
                field("Global Dimension 2 Filter4"; rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre dossier';
                }
                field("Loans repaiment total4"; rec."Loans repaiment total")
                {
                    ApplicationArea = all;
                }
                field("Advances repaiment total4"; rec."Advances repaiment total")
                {
                    ApplicationArea = all;
                }
                field("Désactiver calcul des prêts"; rec."Désactiver calcul des prêts")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic4"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Print...1")
            {
                Image = Print;
                Caption = 'Imprimer';
                actionref("Impression Fiche de Paie2"; "Impression Fiche de Paie") { }

                actionref("Impression Journal de Paie2"; "Impression Journal de Paie") { }

                actionref("Impression Ordre de virement2"; "Impression Ordre de virement") { }
                actionref("Liste des salaires Net2"; "Liste des salaires Net") { }


                /* actionref("Fiche de paie Rappel1"; "Fiche de paie Rappel") { }

                 actionref("Impression Fiche De Paie Matricielle1"; "Impression Fiche De Paie Matricielle") { }

                 actionref("Impression Fiche De Paie Normal1"; "Impression Fiche De Paie Normal") { }

                 actionref("Impression test Journal de Paie1"; "Impression test Journal de Paie") { }
                 actionref("Impression test Journal de Paie détaillé1"; "Impression test Journal de Paie détaillé") { }
                 actionref("Impression Journal de Paie Spécifique1"; "Impression Journal de Paie Spécifique") { }
                 actionref("Impression Récap. Paie1"; "Impression Récap. Paie") { }

                 actionref("Impression Ordre de virement1"; "Impression Ordre de virement") { }
                 actionref("Impression Ordre de paiement chèque1"; "Impression Ordre de paiement chèque") { }
                 actionref("Impression test Paiement Escpèce1"; "Impression test Paiement Escpèce") { }
                 actionref("Impression Fiche de Paie1"; "Impression Fiche de Paie") { }
                 actionref("FICHE DE PAIE ALTEK1"; "FICHE DE PAIE ALTEK") { }
                 actionref("Impression Recape de paie détaillé1"; "Impression Recape de paie détaillé") { }*/

            }

            group("Fonction&s1")
            {
                Caption = 'Fonction&s';
                Image = Post;
                actionref("Extraire les Ind. par type1"; "Extraire les Ind. par type") { }
                actionref("Proposer Lignes de salaires1"; "Proposer Lignes de salaires") { }
                actionref("Calculer Lignes de salaires1"; "Calculer Lignes de salaires") { }
                actionref("Paie inverse1"; "Paie inverse") { }
                actionref(Valider1; Valider) { }
                actionref("Enreg. paie1"; "Enreg. paie") { }
                group("Changer Mode Paiement1")
                {
                    Caption = 'Changer Mode Paiement';
                    actionref("Espèse1"; "Espèse") { }
                    actionref(Virement1; Virement) { }

                }
                actionref("Generer Reglement Cheque1"; "Generer Reglement Cheque") { }
                actionref("Generer Reglement Virement1"; "Generer Reglement Virement") { }

            }
        }
        area(navigation)
        {
            group("Print...")
            {
                Caption = 'Print...';
                Image = Print;
                action("Impression Fiche de Paie")
                {

                    ApplicationArea = all;
                    Image = Print;
                    Caption = 'Impression Fiche de Paie';

                    trigger OnAction()
                    begin

                        Currpage.SalaryLinepage.page.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(REPORT::"Fiche de Paie", TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Impression Journal de Paie")
                {
                    Image = Print;
                    ApplicationArea = all;
                    Caption = 'Impression Journal de Paie';

                    trigger OnAction()
                    begin

                        //Header.SETRANGE ("No.","No.");
                        //REPORT.RUN(REPORT::"Journal de Paie - Test",TRUE,TRUE,Header);
                        LivrePaieMensuelN.GETNumPaie(rec."No.");
                        LivrePaieMensuelN.RUN;
                        //REPORT.RUN(REPORT::"Livre de la paie mensuelN",TRUE,TRUE);
                    end;
                }
                action("Impression Ordre de virement")
                {
                    Image = Print;
                    ApplicationArea = all;
                    Caption = 'Impression Ordre de virement';

                    trigger OnAction()
                    begin

                        SalaryLine.SETRANGE("No.", rec."No.");
                        REPORT.RUN(REPORT::"Ordre de virement -Enrg", TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Liste des salaires Net")
                {
                    Image = Print;
                    ApplicationArea = all;
                    Caption = 'Liste des salaires Net';

                    trigger OnAction()
                    begin

                        SalaryLine.SETRANGE("No.", rec."No.");
                        REPORT.RUN(REPORT::"Liste des Avances", TRUE, TRUE, SalaryLine);
                    end;
                }


                action("Fiche de paie Matricielle SETT")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Fiche de paie Matricielle SETT';

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(52048919, TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Fiche de paie Matricielle SORO")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Fiche de paie Matricielle SORO';

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(52048918, TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Fiche de paie Matricielle FC")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Fiche de paie Matricielle FC';

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(50057, TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Fiche de paie Rappel")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Fiche de paie Rappel';

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(50171, TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Impression Fiche De Paie Matricielle")
                {
                    ApplicationArea = all;
                    Caption = 'Impression Fiche De Paie Matricielle';
                    Visible = false;

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        //REPORT.RUN(REPORT::"STC Salarie V2", TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Impression Fiche De Paie Normal")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Caption = 'Impression Fiche De Paie Normal';

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(REPORT::"Fiche de Paie", TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Impression test Journal de Paie")
                {
                    ApplicationArea = all;
                    Caption = 'Impression test Journal de Paie';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        //REPORT.RUN(REPORT::"Journal de Paie - Test",TRUE,TRUE,Header);
                        REPORT.RUN(REPORT::"Journal de Paie  MTT", TRUE, TRUE, Header);
                    end;
                }
                action("Impression test Journal de Paie détaillé")
                {
                    ApplicationArea = all;
                    Caption = 'Impression test Journal de Paie détaillé';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        //REPORT.RUN(REPORT::"Journal de Paie - Test",TRUE,TRUE,Header);
                        REPORT.RUN(REPORT::"Journal de Paie  MTT11", TRUE, TRUE, Header);
                    end;
                }

                action("Impression Journal de Paie Spécifique")
                {
                    ApplicationArea = all;
                    Caption = 'Impression Journal de Paie Spécifique';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUN(REPORT::"Liste des Compléments Salaire", TRUE, TRUE, Header);
                    end;
                }
                action("Impression Récap. Paie")
                {
                    ApplicationArea = all;
                    Caption = 'Impression Récap. Paie';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        //REPORT.RUN(REPORT::"Bon de prélèvement",TRUE,TRUE,Header);
                        REPORT.RUN(52048915);
                    end;
                }
                action("Impression Ordre de virement1")
                {
                    ApplicationArea = all;
                    Caption = 'Impression Ordre de virement';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(REPORT::"Bordereau De Paie Espece", TRUE, TRUE, Header);
                    end;
                }
                action("Impression Ordre de paiement chèque")
                {
                    ApplicationArea = all;
                    Caption = 'Impression Ordre de paiement chèque';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(39001487, TRUE, TRUE, Header);
                    end;
                }
                action("Impression test Paiement Escpèce")
                {
                    ApplicationArea = all;
                    Caption = 'Impression test Paiement Escpèce';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUN(39001423, TRUE, TRUE, Header);//REPORT::"Ordre de virement - Test",TRUE,TRUE,Header);
                    end;
                }
                separator(separator1)
                {
                }
                action("Impression Fiche de Paie1")
                {
                    ApplicationArea = all;
                    Caption = 'Impression Fiche de Paie';
                    Visible = false;

                    trigger OnAction()
                    begin
                        SalaryLine.RESET;
                        SalaryLine.SETRANGE("No.", rec."No.");
                        //SalaryLine.SETRANGE (Employee,Line.Employee);
                        REPORT.RUN(REPORT::"Fiche de Paie", TRUE, TRUE, SalaryLine);
                    end;
                }
                action("FICHE DE PAIE ALTEK")
                {
                    ApplicationArea = all;
                    Caption = 'FICHE DE PAIE ALTEK';
                    Visible = false;

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryLine.SETRANGE("No.", Line."No.");
                        SalaryLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(REPORT::"PV Reception", TRUE, TRUE, SalaryLine);
                    end;
                }
                action("Impression Recape de paie détaillé")
                {
                    ApplicationArea = all;
                    Caption = 'Impression Recape de paie détaillé';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(39001441, TRUE, TRUE);
                    end;
                }
            }
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                Image = Post;
                action("Extraire les Ind. par type")
                {
                    ApplicationArea = all;
                    Caption = 'Extraire les Ind. par type';
                    Visible = false;
                    trigger OnAction()
                    begin
                        Ind.RESET;
                        CLEAR(listeInd);
                        Header.FIND('-');
                        IF listeInd.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            listeInd.GETRECORD(Ind);
                            IndLN.SETRANGE("No.", Header."No.");
                            IndLN.SETRANGE(Indemnity, Ind.Code);
                            PAGE.RUN(39001456, IndLN)
                        END;
                    end;
                }
                separator(separator2)
                {
                }
                action("Proposer Lignes de salaires")
                {
                    ApplicationArea = all;
                    Image = SuggestLines;
                    Caption = 'Proposer Lignes de salaires';

                    trigger OnAction()
                    begin
                        IF rec."No." = '' THEN
                            ERROR('Error');


                        Header.RESET;
                        Header.SETRANGE("No.", rec."No.");
                        IF Header.FIND('-') THEN
                            IF Header."Posting Date" = 0D THEN
                                ERROR('Précisez la date de comptabilisation');

                        IF Header.FIND('-') THEN;
                        REPORT.RUNMODAL(REPORT::"Payroll : Fill Payment Form", TRUE, TRUE, Header);


                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(TRUE);
                    end;
                }

                action("Calculer Lignes de salaires")
                {
                    ApplicationArea = all;
                    Caption = 'Calculer Lignes de salaires';
                    ShortCutKey = 'Ctrl+F7';
                    Image = Calculate;

                    trigger OnAction()
                    begin
                        Salary.RESET;
                        Salary.SETRANGE("No.", 'SIMULATION');
                        IF Salary.FIND('-') THEN
                            Salary.DELETE(TRUE);
                        COMMIT;
                        Header.RESET;
                        Header.SETRANGE("No.", rec."No.");
                        IF Header.FIND('-') THEN
                            REPORT.RUNMODAL(REPORT::"Payroll : Calculate Payment", TRUE, TRUE, Header);

                        CurrPage.SAVERECORD;
                        CurrPage.UPDATE(TRUE);
                    end;
                }
                separator(separator3)
                {
                }
                action("Paie inverse")
                {
                    ApplicationArea = all;
                    Caption = 'Paie inverse';
                    Visible = false;

                    trigger OnAction()
                    var
                        Temp1: Decimal;
                        Temp2: Decimal;
                        w: Dialog;
                        SBDepart: Decimal;
                        NetVoulu: Decimal;
                        Ecart: Decimal;
                        Coef: Decimal;
                        NewLine: Record "Salary Lines";
                    begin
                        CLEAR(Line);
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        "Management of salary".PaieInverseFeuilleCalcul(Line, Line."Basis salary", Line."Net salary", 1);
                    end;
                }
                separator(separator4)
                {
                }
                action(Valider)
                {
                    ApplicationArea = all;
                    Caption = 'Valider';
                    Enabled = false;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        IF Header.FIND('-') THEN
                            REPORT.RUN(REPORT::"Payroll : Post Payment @", TRUE, TRUE, Header);
                        //Currpage.UPDATE(FALSE);
                    end;
                }
                action("Enreg. paie")
                {
                    ApplicationArea = all;
                    Caption = 'Enreg. paie';
                    ShortCutKey = 'F9';
                    Image = Post;

                    trigger OnAction()
                    begin
                        // >> HJ SORO 20-09-2018
                        /*  SalaryLine.RESET;
                          SalaryLine.SETRANGE("No.", rec."No.");
                          IF SalaryLine.FINDFIRST THEN
                              REPEAT
                                  IF SalaryLine."Net salary cashed" = 0 THEN ERROR(Text001, SalaryLine.Employee);
                              UNTIL SalaryLine.NEXT = 0;*/
                        // >> HJ SORO 20-09-2018
                        IF CONFIRM(MESSG1) THEN BEGIN

                            /*  SalaryLine3.RESET;
                              SalaryLine3.SETRANGE("No.", rec."No.");

                              // Solde Congé STC
                              IF rec.STC THEN BEGIN
                                  IF ParamRsh.GET THEN;
                                  i := 0;
                                  EmployeeAbsence.DELETEALL;
                                  EmployeeAbsence.LOCKTABLE;
                                  SalaryLine.RESET;
                                  SalaryLine.SETRANGE("No.", rec."No.");
                                  IF SalaryLine.FINDFIRST THEN
                                      REPEAT
                                          IF Emp.GET(SalaryLine.Employee) THEN;
                                          Emp.CALCFIELDS(Emp."Days off =");
                                          i += 1;
                                          EmployeeAbsence.INIT;
                                          EmployeeAbsence."Entry No." := i;
                                          EmployeeAbsence.VALIDATE("Employee No.", SalaryLine.Employee);
                                          EmployeeAbsence."From Date" := DMY2DATE(1, SalaryLine.Month + 1, SalaryLine.Year);
                                          EmployeeAbsence."To Date" := DMY2DATE(1, SalaryLine.Month + 1, SalaryLine.Year);
                                          EmployeeAbsence.VALIDATE("Cause of Absence Code", ParamRsh."Code Solde Congé STC");
                                          EmployeeAbsence.VALIDATE(Quantity, Emp."Days off =");
                                          EmployeeAbsence.INSERT;
                                          Emp.Blocked := TRUE;
                                          Emp.MODIFY;
                                      UNTIL SalaryLine.NEXT = 0;
                                  IF EmployeeAbsence.FIND('-') THEN BEGIN
                                      ManagementOfabsences.ValidAbsence(EmployeeAbsence);
                                  END;
                              END;*/
                            // Solde Congé STC
                            "Management of salary".EnregPaie(Rec);
                            IF rec.Month = 14 THEN BEGIN
                                RECNotes.DELETEALL;
                            END;
                            rec.DELETE;
                        END
                        ELSE
                            MESSAGE(MESSG2);
                    end;
                }
                separator(separator5)
                {
                }
                group("Changer Mode Paiement")
                {
                    Caption = 'Changer Mode Paiement';
                    action("Espèse")
                    {
                        ApplicationArea = all;
                        Caption = 'Espèse';
                        //Visible = false;
                        trigger OnAction()
                        begin
                            ModeP := 0;
                            CurrPage.SalaryLinepage.PAGE.ChangerModePaiement(ModeP);
                            CurrPage.UPDATE;
                        end;
                    }
                    action(Virement)
                    {
                        ApplicationArea = all;
                        Caption = 'Virement';
                        //Visible = false;
                        trigger OnAction()
                        begin
                            ModeP := 2;
                            CurrPage.SalaryLinepage.PAGE.ChangerModePaiement(ModeP);
                            CurrPage.UPDATE;
                        end;
                    }
                }
                separator(separator6)
                {
                }
                action("Generer Reglement Cheque")
                {
                    ApplicationArea = all;
                    Caption = 'Generer Reglement Cheque';
                    Visible = false;
                    trigger OnAction()
                    begin
                        //Header.SETRANGE ("No.","No.");
                        //REPORT.RUN(5213,TRUE,TRUE,Header);//REPORT::"Ordre de virement - Test",TRUE,TRUE,Header);
                        Line.RESET;
                        Line.SETRANGE("No.", rec."No.");
                        Line.SETRANGE("Code Mode Réglement", 1);
                        IF Line.FINDFIRST THEN
                            REPORT.RUN(REPORT::"Recap Paie V02", TRUE, FALSE, Line)
                    end;
                }
                action("Generer Reglement Virement")
                {
                    ApplicationArea = all;
                    Caption = 'Generer Reglement Virement';
                    Visible = false;
                    trigger OnAction()
                    begin
                        Line.RESET;
                        Line.SETRANGE("No.", rec."No.");
                        Line.SETRANGE("Code Mode Réglement", 2);
                        IF Line.FINDFIRST THEN
                            REPORT.RUN(REPORT::"Update Materiaux Rapport DG", TRUE, FALSE, Line)
                    end;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        IF rec."Up to date" THEN
            pictVisible := FALSE
        ELSE
            pictVisible := TRUE;
        IF rec.Month <> rec.Month::Prime THEN
            "year of CalculateVisible" := FALSE
        ELSE
            "year of CalculateVisible" := TRUE;
    end;

    trigger OnInit()
    begin
        pictVisible := TRUE;
        "year of CalculateVisible" := TRUE;
        rec.SETFILTER("No.", '<> SIMULATION')
    end;

    trigger OnOpenPage()
    begin
        Test := 0;
        /*  IF rec.Month <> rec.Month::Prime THEN
              "year of CalculateVisible" := FALSE
          ELSE
              "year of CalculateVisible" := TRUE;*/
        ParamRsh.GET;
    end;

    var
        "Management of salary": Codeunit "Management of salary";
        //GL2024 FillPaymentForm: report 52048879;
        CalculatePayment: Report "Payroll : Calculate Payment";
        Header: Record "Salary Headers";
        Line: Record "Salary Lines";
        msg1: Label '- Certaines lignes de salaires présentent des montants Nets à payer négatifs.\';
        msg2: Label '- La mise à jour de ce formulaire n''a pas été faite. Le lancementt de la procèdure de calcul est obligatoire.\';
        SalaryLine: Record "Salary Lines";
        SalaryLine3: Record "Salary Lines";
        EtatMensuelDePaie: Record "Etat Mensuelle Paie";
        //EtatMensuelDePaieHist: Record "Etat Mensuelle Paie Hist";
        systMsg1: Text[500];
        std: Label 'Impossible de valider ce document :\';
        systMsg2: Text[500];
        Test: Integer;
        listeInd: page Indemnity;
        Ind: record Indemnity;
        IndLN: Record Indemnities;
        Salary: Record "Salary Headers";
        ModeP: Option Virement,"Espèse";
        ParamRsh: Record "Human Resources Setup";
        MESSG1: Label 'Attetion : Validation ne peut pas être annuler, Voulez vous continuer';
        MESSG2: Label 'Enregistrement annulé';
        RECNotes: Record "Ligne Pointage Salarié Chanti";
        RecGRegimesofwork: record "Regimes of work";
        Emp: Record Employee;
        EmployeeAbsence: Record "Employee Absence";
        ManagementOfabsences: Codeunit "Management of absences";
        i: Integer;
        Text001: Label 'Le Salaire Net de l''Employé N° %1  est egale a zéro, Veuillez corriger cette erreur.';
        [InDataSet]
        "year of CalculateVisible": Boolean;
        [InDataSet]
        pictVisible: Boolean;

        LivrePaieMensuelN: Report "Livre de la paie mensuelN";



    procedure Nvl(Var1: Decimal; Var2: Decimal) SlrMoyen: Decimal
    begin
        SlrMoyen := Var1;
        IF Var1 = 0 THEN
            SlrMoyen := Var2;
    end;

    local procedure MonthOnAfterValidate()
    begin
        IF rec.Month <> rec.Month::Prime THEN
            "year of CalculateVisible" := FALSE
        ELSE
            "year of CalculateVisible" := TRUE;
    end;



}

