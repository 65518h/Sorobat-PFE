page 52048938 "Recorded salaries"
{
    //GL2024  ID dans Nav 2009 : "39001459"
    Caption = 'Salaires enregistrés';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Rec. Salary Headers";
    //SourceTableView = SORTING("Posting Date", "No.") WHERE(STC = CONST(false));
    SourceTableView = SORTING("Posting Date", "No.");
    UsageCategory = Administration;
    //ABZApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Général';

                Editable = false;
                label("Recorded salaries")
                {
                    ApplicationArea = all;
                    Caption = 'Paie enregistrée';
                    //CaptionClass = Text19029024;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Month; rec.Month)
                {
                    ApplicationArea = all;
                    Caption = 'Mois';
                }
                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                    Caption = 'Année';
                }
                field("Salary lines1"; rec."Salary lines")
                {
                    ApplicationArea = all;
                    Caption = 'Lignes de salaire';
                }
                // field("Liquidation RCGC"; rec."Liquidation RCGC")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Liquidation RCGC';
                // }

                // field(STC; rec.STC)
                // {
                //     ApplicationArea = all;
                // }



                field("Paid days"; rec."Paid days")
                {
                    ApplicationArea = all;
                    Caption = 'Nombre de jours payés';
                    Editable = false;
                }
                field("Worked days"; rec."Worked days")
                {
                    ApplicationArea = all;
                    Caption = 'Nombre de jours ouvrés';
                    Editable = false;
                }
                field("Regime quinzaine"; rec."Regime quinzaine")
                {
                    ApplicationArea = all;
                    Caption = 'Regime quinzaine';
                    Editable = false;
                }
                field(Quinzaine; rec.Quinzaine)
                {
                    ApplicationArea = all;
                    Editable = false;
                }


            }
            part(SalaryLinePage; "Recorded Salary Lines")
            {
                Caption = 'Ligne de salaire enreg.';
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
            group("Cumulated salaries")
            {
                Caption = 'Salaires cumulés';
                field("Employee No. filter1"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                }
                field("Employee posting grp. filter1"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Salary lines11"; rec."Salary lines")
                {
                    ApplicationArea = all;
                }
                field("Salary basis total1"; rec."Salary basis total")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Total Supp. Hours1"; rec."Total Supp. Hours")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Taxable indemnities total1"; rec."Taxable indemnities total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Total Gross salary"; rec."Total Gross salary")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Non Taxable Soc. Contrib."; rec."Non Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities (Not Gross1"; rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Total taxable"; rec."Total taxable")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Taxable Soc. Contrib."; rec."Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Taxes total"; rec."Taxes total")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Non Taxable indemnities total1"; rec."Non Taxable indemnities total")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Mission expenses total1"; rec."Mission expenses total")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Net salary total"; rec."Net salary total")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Loans repaiment total"; rec."Loans repaiment total")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Advances repaiment total"; rec."Advances repaiment total")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Net salary cashed"; rec."Net salary cashed")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Global dimension 1 Filter1"; rec."Global dimension 1 Filter")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 2 Filter1"; rec."Global dimension 2 Filter")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic1"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
            }
            group("Paiement balance")
            {
                Caption = 'Balance de paie';

                field("Employee No. filter"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                }
                field("Employee posting grp. filter"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 1 Filter"; rec."Global dimension 1 Filter")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 2 Filter"; rec."Global dimension 2 Filter")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
                field("Salary lines"; rec."Salary lines")
                {
                    ApplicationArea = all;
                }
                label(Débit)
                {
                    Caption = 'Débit';
                }

                field("Salary basis total"; rec."Salary basis total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Total Supp. Hours"; rec."Total Supp. Hours")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Taxable indemnities total"; rec."Taxable indemnities total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Taxable indemnities (Not Gross"; rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Non Taxable indemnities total"; rec."Non Taxable indemnities total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Mission expenses total"; rec."Mission expenses total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field(MntJourFerTrav; MntJourFerTrav)
                {
                    ApplicationArea = all;
                    Caption = 'Montant jour férie travaillé';
                    Enabled = false;
                }
                field(Total; ROUND(rec."Salary basis total" + rec."Total Supp. Hours" + rec."Taxable indemnities total" + rec."Mission expenses total" + rec."Non Taxable indemnities total" + rec."Taxable indemnities (Not Gross", 0.001) + MntJourFerTrav)
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                label(Crédit)
                {
                    ApplicationArea = all;
                    Caption = 'Crédit';
                }
                field("Non Taxable Soc. Contrib.1"; rec."Non Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Taxable Soc. Contrib.1"; rec."Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Loans repaiment total1"; rec."Loans repaiment total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Advances repaiment total1"; rec."Advances repaiment total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Taxes total1"; rec."Taxes total")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Ajout en +"; rec."Ajout en +")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }
                field("Report en -"; rec."Report en -")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }
                field("Net salary cashed1"; rec."Net salary cashed")
                {
                    ApplicationArea = all;
                    AutoFormatType = 0;
                    DecimalPlaces = 3 : 3;
                }
                field("Caisse fond social"; rec."Caisse fond social")
                {
                    ApplicationArea = all;
                }
                field(Toatl2; ROUND(rec."Taxable Soc. Contrib." + rec."Non Taxable Soc. Contrib." + rec."Loans repaiment total" + rec."Advances repaiment total" + rec."Taxes total" + rec."Net salary cashed" + rec."Report en -" - rec."Ajout en +", 0.001) + rec."Caisse fond social")
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

                field("Employee No. filter2"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                }
                field("Employee posting grp. filter2"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 1 Filter2"; rec."Global dimension 1 Filter")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 2 Filter2"; rec."Global dimension 2 Filter")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic2"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
                }
                field("Salary lines2"; rec."Salary lines")
                {
                    ApplicationArea = all;
                }
                field("Salary basis total2"; rec."Salary basis total")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities total2"; rec."Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Non Taxable indemnities total2"; rec."Non Taxable indemnities total")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities (Not Gross2"; rec."Taxable indemnities (Not Gross")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Mission expenses total2"; rec."Mission expenses total")
                {
                    ApplicationArea = all;
                }
                field("Total Supp. Hours2"; rec."Total Supp. Hours")
                {
                    ApplicationArea = all;
                }
                field("Total Charges patronales"; rec."Total Charges patronales")
                {
                }
                field("Coût total"; rec."Salary basis total" + rec."Taxable indemnities total" + rec."Non Taxable indemnities total" + rec."Mission expenses total" + rec."Total Supp. Hours" + rec."Total Charges patronales")
                {
                    ApplicationArea = all;
                    AutoFormatType = 2;
                    Caption = 'Coût total';
                }
            }
            group("Absences/Days off")
            {
                Caption = 'Congés/Absences';
                field("Employee No. filter3"; rec."Employee No. filter")
                {
                    ApplicationArea = all;
                }
                field("Employee posting grp. filter3"; rec."Employee posting grp. filter")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 1 Filter3"; rec."Global dimension 1 Filter")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 2 Filter3"; rec."Global dimension 2 Filter")
                {
                    ApplicationArea = all;
                }
                field("Filter gpe statistic3"; rec."Filter gpe statistic")
                {
                    ApplicationArea = all;
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
            }
        }
    }

    actions
    {
        area(Promoted)

        {
            group("Print...1")
            {
                Caption = 'Imprimer';
                actionref("Journal de Paie1"; "Journal de Paie") { }
                actionref("Journal de Paie détaillé1"; "Journal de Paie détaillé") { }
                actionref("Fiche de Paie Matricielle1"; "Fiche de Paie Matricielle") { }

                actionref("Fiche de Paie A41"; "Fiche de Paie A4") { }
                actionref("Journal de Paie A31"; "Journal de Paie A3") { }
                actionref("Journal de Paie / Service1"; "Journal de Paie / Service") { }
                actionref("Récap Paie1"; "Récap Paie") { }
                actionref("Ordre de virement1"; "Ordre de virement") { }
                actionref("Ordre de Paiement Espèse1"; "Ordre de Paiement Espèse") { }
                actionref("Ordre de paiement chèque1"; "Ordre de paiement chèque") { }
            }
            group("Fonction&s1")
            {
                Caption = 'Fonction&s';
                group("Changer Mode Paiement1")

                {
                    Caption = 'Changer Mode Paiement';

                    actionref("Espèse1"; "Espèse") { }
                    actionref(Virement1; Virement) { }
                }

            }

        }

        area(navigation)
        {
            group("Print...")
            {
                Caption = 'Imprimer...';
                action("Journal de Paie")
                {
                    ApplicationArea = all;
                    Caption = 'Journal de Paie';
                    Visible = true;
                    Image = Print;
                    trigger OnAction()
                    begin
                        // CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        // SalaryRecLine.SETRANGE("No.", Line."No.");
                        // SalaryRecLine.SETRANGE(Employee, Line.Employee);
                        // Header.SETRANGE("No.", rec."No.");
                        // //REPORT.RUN (REPORT::"Fiche de Paie - final",TRUE,TRUE,SalaryRecLine);
                        // REPORT.RUN(39001483, TRUE, TRUE, Header);
                        //GL2025 LivrePaieMensuelN.GetNumPaie(Rec."No.");

                        LivrePaieMensuelN.GetNumPaie(Rec."No.");
                        LivrePaieMensuelN.RUN;
                    end;
                }
                action("Journal de Paie détaillé")
                {
                    ApplicationArea = all;
                    Caption = 'Journal de Paie détaillé';
                    Visible = false;

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);
                        Header.SETRANGE("No.", rec."No.");
                        SalaryRecLine.SETRANGE("No.", Line."No.");
                        SalaryRecLine.SETRANGE(Employee, Line.Employee);
                        //REPORT.RUN (REPORT::"Fiche de Paie - final",TRUE,TRUE,SalaryRecLine);
                        REPORT.RUN(39001485, TRUE, TRUE, Header);
                    end;
                }
                action("Fiche de Paie 2P")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche de Paie 2P';
                    Visible = false;


                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinePage.page.GETRECORD(Line);

                        SalaryRecLine.SETRANGE("No.", Line."No.");
                        SalaryRecLine.SETRANGE(Employee, Line.Employee);

                        //REPORT.RUN (REPORT::"Fiche de Paie - final",TRUE,TRUE,SalaryRecLine);
                        REPORT.RUN(39001482, TRUE, TRUE, SalaryRecLine);
                    end;
                }
                action("Fiche de Paie Matricielle")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche de Paie Matricielle';
                    Visible = false;

                    trigger OnAction()
                    begin
                        CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        SalaryRecLine.SETRANGE("No.", Line."No.");
                        SalaryRecLine.SETRANGE(Employee, Line.Employee);

                        //REPORT.RUN (REPORT::"Fiche de Paie - final",TRUE,TRUE,SalaryRecLine);
                        REPORT.RUN(50083, TRUE, TRUE, SalaryRecLine);
                    end;
                }
                action("Fiche de Paie A4")
                {
                    ApplicationArea = all;
                    Caption = 'Fiche de Paie A4';
                    Image = Print;
                    trigger OnAction()
                    begin
                        // CurrPage.SalaryLinepage.PAGE.GETRECORD(Line);

                        // SalaryRecLine.SETRANGE("No.", Line."No.");
                        // SalaryRecLine.SETRANGE(Employee, Line.Employee);

                        // //REPORT.RUN (REPORT::"Fiche de Paie - final",TRUE,TRUE,SalaryRecLine);
                        // REPORT.RUN(50084, TRUE, TRUE, SalaryRecLine);

                        Currpage.SalaryLinepage.page.GETRECORD(Line);

                        SalaryRecLine.SETRANGE("No.", Line."No.");
                        SalaryRecLine.SETRANGE(Employee, Line.Employee);

                        REPORT.RUN(REPORT::"Fiche de PaieEnrg", TRUE, TRUE, SalaryRecLine);
                    end;
                }
                action("Journal de Paie A3")
                {
                    ApplicationArea = all;
                    Caption = 'Journal de Paie A3';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        //  REPORT.RUN(REPORT::"Journal de Paie - eng", TRUE, TRUE, Header);
                    end;
                }

                action("Journal de Paie / Service")
                {
                    ApplicationArea = all;
                    Caption = 'Journal de Paie / Service';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUN(39001465, TRUE, TRUE, Header);
                    end;
                }
                action("Récap Paie")
                {
                    ApplicationArea = all;
                    Caption = 'Récap Paie';
                    Visible = false;
                    trigger OnAction()
                    begin
                        REPORT.RUN(39001417, TRUE);
                        //REPORT.RUN(50105,TRUE);
                    end;
                }
                action("Ordre de virement")
                {
                    ApplicationArea = all;
                    Caption = 'Ordre de virement';
                    Image = Print;
                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUN(REPORT::"Ordre de virement -Enrg", TRUE, TRUE, Header);
                    end;
                }
                action("Ordre de Paiement Espèse")
                {
                    ApplicationArea = all;
                    Caption = 'Ordre de Paiement Espèse';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUN(52048902, TRUE, TRUE, Header);
                        //REPORT.RUN(50014);
                    end;
                }
                action("Ordre de paiement chèque")
                {
                    ApplicationArea = all;
                    Caption = 'Ordre de paiement chèque';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Header.SETRANGE("No.", rec."No.");
                        REPORT.RUN(39001488, TRUE, TRUE, Header);
                    end;
                }
            }
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                separator(separator100)
                {
                }
                group("Changer Mode Paiement")
                {
                    Caption = 'Changer Mode Paiement';
                    action("Espèse")
                    {
                        ApplicationArea = all;
                        Caption = 'Espèse';

                        trigger OnAction()
                        begin
                            ModeP := 1;
                            CurrPage.SalaryLinepage.PAGE.ChangerModePaiement(ModeP);
                            CurrPage.UPDATE;
                        end;
                    }

                    action(Virement)
                    {
                        ApplicationArea = all;
                        Caption = 'Virement';

                        trigger OnAction()
                        begin
                            ModeP := 0;
                            CurrPage.SalaryLinepage.PAGE.ChangerModePaiement(ModeP);
                            CurrPage.UPDATE;
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MntJourFerTrav := 0;
        SalaryRecLine.SETCURRENTKEY("No.");
        SalaryRecLine.SETFILTER("No.", rec."No.");
        IF SalaryRecLine.FIND('-') THEN BEGIN
            REPEAT
                SalaryRecLine.CALCFIELDS("Montant Jours Fériés travaillé");
                MntJourFerTrav := MntJourFerTrav + SalaryRecLine."Montant Jours Fériés travaillé";
            UNTIL SalaryRecLine.NEXT = 0;
        END;
    end;

    var
        SalaryRecLine: Record "Rec. Salary Lines";
        Line: Record "Rec. Salary Lines";
        Header: Record "Rec. Salary Headers";
        ModeP: Option Virement,"Espèse";
        MntJourFerTrav: Decimal;
        Text19029024: Label 'Recorded salaries';
        Text19037584: Label 'Débit';
        Text19060208: Label 'Coût total';
        Text19028226: Label 'Total';
        Text19070579: Label 'Lignes de salaire';
        Text19011653: Label 'Crédit';
        LivrePaieMensuelN: Report "Livre de la paie mensuelE";
}

