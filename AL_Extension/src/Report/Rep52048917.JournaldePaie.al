report 52048917 "Journal de Paie -"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/JournaldePaie.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = SORTING("Primary Key")
                                ORDER(Ascending);
            column(FORMAT_RECENTETSALAIRE_Description_________FORMAT_RECENTETSALAIRE_Month___________FORMAT_RECENTETSALAIRE_Year___; FORMAT(RECENTETSALAIRE.Description) + '  ' + FORMAT(RECENTETSALAIRE.Month) + '  ' + FORMAT(RECENTETSALAIRE.Year))
            {
            }
            column(Page_____FORMAT__CurrReport_PAGENO_; 'Page : ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(Company_Information__Company_Information___Name_2_; "Company Information"."Name 2")
            {
            }
            column(Adresse________Company_Information___Address_2_; 'Adresse : ' + "Company Information"."Address 2")
            {
            }
            column(Journal_de_Paie_Caption; Journal_de_Paie_CaptionLbl)
            {
            }
            column(Company_Information_Primary_Key; "Primary Key")
            {
            }
            dataitem("Salary Headers"; "Salary Headers")
            {
                column(Salary_Headers__Salary_basis_total_; "Salary basis total")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGINDTRANS; TOTGINDTRANS)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Loans_repaiment_total_; "Loans repaiment total")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Advances_repaiment_total_; "Advances repaiment total")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Taxes_total_; "Taxes total")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Net_salary_total_; "Net salary total")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Net_salary_cashed_; "Net salary cashed")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Total_Gross_salary_; "Total Gross salary")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGASSGPE; TOTGASSGPE)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Total_Supp__Hours_; "Total Supp. Hours")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__No__; "No.")
                {
                }
                column(Salary_Headers_Month; Month)
                {
                }
                column(Salary_Headers_Year; Year)
                {
                }
                column(TOTGCNS; TOTGCNS)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGINDPRESENCE; TOTGINDPRESENCE)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGINDENCOURAGE; TOTGINDENCOURAGE)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGINDLOGEMENT; TOTGINDLOGEMENT)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGINDFONCTION; TOTGINDFONCTION)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGINDPANIER; TOTGINDPANIER)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGICP; TOTGICP)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Report_en___; "Report en -")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Ajout_en___; "Ajout en +")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGCONGE; TOTGCONGE)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGPRLOG; TOTGPRLOG)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(TOTGPRREND; TOTGPRREND)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salary_Headers__Total_taxable_; "Total taxable")
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Salaire_de_baseCaption; Salaire_de_baseCaptionLbl)
                {
                }
                column(Prime_de_TransportCaption; Prime_de_TransportCaptionLbl)
                {
                }
                column("PrêtsCaption"; PrêtsCaptionLbl)
                {
                }
                column(AvancesCaption; AvancesCaptionLbl)
                {
                }
                column(Salary_Headers__Taxes_total_Caption; FIELDCAPTION("Taxes total"))
                {
                }
                column(NetCaption; NetCaptionLbl)
                {
                }
                column(Salary_Headers__Net_salary_cashed_Caption; FIELDCAPTION("Net salary cashed"))
                {
                }
                column(Salaire_BrutCaption; Salaire_BrutCaptionLbl)
                {
                }
                column(Assurance_GroupeCaption; Assurance_GroupeCaptionLbl)
                {
                }
                column(Heures_Sup_Caption; Heures_Sup_CaptionLbl)
                {
                }
                column(TotalisationCaption; TotalisationCaptionLbl)
                {
                }
                column(Salary_Headers__No__Caption; FIELDCAPTION("No."))
                {
                }
                column(Salary_Headers_MonthCaption; FIELDCAPTION(Month))
                {
                }
                column(Salary_Headers_YearCaption; FIELDCAPTION(Year))
                {
                }
                column(C_N_S_SCaption; C_N_S_SCaptionLbl)
                {
                }
                column("Prime_de_PrésenceCaption"; Prime_de_PrésenceCaptionLbl)
                {
                }
                column(Prime_d_encouragementCaption; Prime_d_encouragementCaptionLbl)
                {
                }
                column(RappelCaption; RappelCaptionLbl)
                {
                }
                column(Ind__fonctionCaption; Ind__fonctionCaptionLbl)
                {
                }
                column(Prime_de_PanierCaption; Prime_de_PanierCaptionLbl)
                {
                }
                column(I_C_PCaption; I_C_PCaptionLbl)
                {
                }
                column(Report_en__Caption; Report_en__CaptionLbl)
                {
                }
                column(Report_en__Caption_Control1120100; Report_en__Caption_Control1120100Lbl)
                {
                }
                column(CONGECaption; CONGECaptionLbl)
                {
                }
                column(Ind__LogementCaption; Ind__LogementCaptionLbl)
                {
                }
                column(pr__RendementCaption; pr__RendementCaptionLbl)
                {
                }
                column(Salaires_imposablesCaption; Salaires_imposablesCaptionLbl)
                {
                }
                dataitem("Salary Lines"; "Salary Lines")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemTableView = SORTING("Statistics Group Code", Employee)
                                        ORDER(Ascending);
                    RequestFilterFields = "Statistics Group Code";
                    column("Département_____________Statistics_Group_Code__________CodDepartement"; 'Département : ' + ' ' + "Statistics Group Code" + ' ' + CodDepartement)
                    {
                    }
                    column(Salary_Lines_Name; Name)
                    {
                    }
                    column(Salary_Lines__Supp__hours_; "Supp. hours")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Real_basis_salary_; "Real basis salary")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Gross_Salary_; "Gross Salary")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(CNS; CNS)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Taxable_salary_; "Taxable salary")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Taxe__Month__; "Taxe (Month)")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines_Loans; Loans)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines_Advances; Advances)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines_Employee; Employee)
                    {
                    }
                    column(NBJOURS; NBJOURS)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(INDTRANS; INDTRANS)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(INDPRESENCE; INDPRESENCE)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(INDENCOURAGE; INDENCOURAGE)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(INDLOGEMENT; INDLOGEMENT)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(INDFONCTION; INDFONCTION)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(INDPANIER; INDPANIER)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(ICP; ICP)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Taxe__Month___Control1120071; "Taxe (Month)")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Taxe__Month___Control1120072; "Taxe (Month)")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Ajout__en___; "Ajout  en +")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Report_en___; "Report en -")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Net_salary_cashed_; "Net salary cashed")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Real_basis_salary__Control1180250088; "Real basis salary")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTCNS; TOTCNS)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Supp__hours__Control1180250093; "Supp. hours")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Taxable_salary__Control1180250096; "Taxable salary")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Taxe__Month___Control1180250103; "Taxe (Month)")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines_Loans_Control1180250106; Loans)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines_Advances_Control1180250107; Advances)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Net_salary_cashed__Control1180250109; "Net salary cashed")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Gross_Salary__Control1180250110; "Gross Salary")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column("Total_Département_____________Statistics_Group_Code__________CodDepartement"; 'Total Département : ' + ' ' + "Statistics Group Code" + ' ' + CodDepartement)
                    {
                    }
                    column(Salary_Lines__Ajout__en____Control1120012; "Ajout  en +")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(Salary_Lines__Report_en____Control1120015; "Report en -")
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTINDTRANS; TOTINDTRANS)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTINDENCOURAGE; TOTINDENCOURAGE)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTINDPRESENCE; TOTINDPRESENCE)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTINDLOGEMENT; TOTINDLOGEMENT)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTINDFONCTION; TOTINDFONCTION)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTICP; TOTICP)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(TOTINDPANIER; TOTINDPANIER)
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(EmployeeCaption; EmployeeCaptionLbl)
                    {
                    }
                    column(EmployeeCaption_Control1120008; EmployeeCaption_Control1120008Lbl)
                    {
                    }
                    column(Salaire_de_baseCaption_Control1120010; Salaire_de_baseCaption_Control1120010Lbl)
                    {
                    }
                    column("Heures_supplém_Caption"; Heures_supplém_CaptionLbl)
                    {
                    }
                    column(C_N_S_SCaption_Control1120018; C_N_S_SCaption_Control1120018Lbl)
                    {
                    }
                    column(Salaire_ImposableCaption; Salaire_ImposableCaptionLbl)
                    {
                    }
                    column("Impôt__mois_Caption"; Impôt__mois_CaptionLbl)
                    {
                    }
                    column("PrêtsCaption_Control1120032"; PrêtsCaption_Control1120032Lbl)
                    {
                    }
                    column(AvancesCaption_Control1120034; AvancesCaption_Control1120034Lbl)
                    {
                    }
                    column("Salaire_Net_PerçuCaption"; Salaire_Net_PerçuCaptionLbl)
                    {
                    }
                    column(Prime_de_TransportCaption_Control1120005; Prime_de_TransportCaption_Control1120005Lbl)
                    {
                    }
                    column(Salaire_BrutCaption_Control1120028; Salaire_BrutCaption_Control1120028Lbl)
                    {
                    }
                    column(NB_Heure_JourCaption; NB_Heure_JourCaptionLbl)
                    {
                    }
                    column("Prime_de_PrésenceCaption_Control1120043"; Prime_de_PrésenceCaption_Control1120043Lbl)
                    {
                    }
                    column(RappelCaption_Control1120044; RappelCaption_Control1120044Lbl)
                    {
                    }
                    column(Prime_d__Encourag_Caption; Prime_d__Encourag_CaptionLbl)
                    {
                    }
                    column(I_C_PCaption_Control1120050; I_C_PCaption_Control1120050Lbl)
                    {
                    }
                    column(PanierCaption; PanierCaptionLbl)
                    {
                    }
                    column("Indemnité_de_FonctionCaption"; Indemnité_de_FonctionCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(EmptyStringCaption_Control1120075; EmptyStringCaption_Control1120075Lbl)
                    {
                    }
                    column(Salary_Lines_No_; "No.")
                    {
                    }
                    column(Salary_Lines_Statistics_Group_Code; "Statistics Group Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CodDepartement := '';
                        IF RecEmployeeStatisticsGroup.GET("Statistics Group Code") THEN
                            CodDepartement := RecEmployeeStatisticsGroup.Description;
                        //NBJOURS
                        IF "Employee's type" = 1 THEN
                            NBJOURS := "Paied days"
                        ELSE
                            NBJOURS := "Worked hours";

                        //CNSS
                        RecSocialContributions.RESET;
                        CNS := 0;
                        RecSocialContributions.SETRANGE("No.", "No.");
                        RecSocialContributions.SETRANGE(Employee, Employee);
                        RecSocialContributions.SETFILTER("Social Contribution", '%1|%2|%3', 'CNSS', 'CNSS5', 'CNSS7');
                        IF RecSocialContributions.FIND('-') THEN BEGIN
                            CNS := RecSocialContributions."Real Amount : Employee";
                            //TOTCNS := TOTCNS + CNS;
                            TOTGCNS := TOTGCNS + CNS;
                        END;
                        //ASSURANCE GROUPE
                        RecSocialContributions.RESET;
                        ASSGPE := 0;
                        RecSocialContributions.SETRANGE("No.", "No.");
                        RecSocialContributions.SETRANGE(Employee, Employee);
                        RecSocialContributions.SETFILTER("Social Contribution", '%1', 'ASSG');
                        IF RecSocialContributions.FIND('-') THEN BEGIN
                            ASSGPE := RecSocialContributions."Real Amount : Employee";
                            TOTGASSGPE := TOTGASSGPE + ASSGPE;
                        END;

                        //IND TRANSPORT
                        RecIndemnities.RESET;
                        INDTRANS := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'IND-TRANS');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            INDTRANS := RecIndemnities."Real Amount";
                            //TOTINDTRANS := TOTINDTRANS+RecIndemnities."Real Amount";
                            TOTGINDTRANS := TOTGINDTRANS + RecIndemnities."Real Amount";
                        END;

                        //IND PRESENCE
                        RecIndemnities.RESET;
                        INDPRESENCE := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'IND-PRES');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            INDPRESENCE := RecIndemnities."Real Amount";
                            //TOTINDPRESENCE := TOTINDPRESENCE+RecIndemnities."Real Amount";
                            TOTGINDPRESENCE := TOTGINDPRESENCE + RecIndemnities."Real Amount";
                        END;

                        //IND ENCOURAGEMENT
                        RecIndemnities.RESET;
                        INDENCOURAGE := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'PR-ENC');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            INDENCOURAGE := RecIndemnities."Real Amount";
                            TOTGINDENCOURAGE := TOTGINDENCOURAGE + RecIndemnities."Real Amount";
                        END;

                        //IND PR-RAPP
                        RecIndemnities.RESET;
                        INDLOGEMENT := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'RAPPEL');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            INDLOGEMENT := RecIndemnities."Real Amount";
                            //TOTINDLOGEMENT := TOTINDLOGEMENT+RecIndemnities."Real Amount";
                            TOTGINDLOGEMENT := TOTGINDLOGEMENT + RecIndemnities."Real Amount";
                        END;

                        //IND FONCTION
                        RecIndemnities.RESET;
                        INDFONCTION := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'IND-FON');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            INDFONCTION := RecIndemnities."Real Amount";
                            //TOTINDFONCTION := TOTINDFONCTION+RecIndemnities."Real Amount";
                            TOTGINDFONCTION := TOTGINDFONCTION + RecIndemnities."Real Amount";
                        END;

                        //IND PANIER
                        RecIndemnities.RESET;
                        INDPANIER := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'PR-TRV-C');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            INDPANIER := RecIndemnities."Real Amount";
                            //TOTINDPANIER := TOTINDPANIER+RecIndemnities."Real Amount";
                            TOTGINDPANIER := TOTGINDPANIER + RecIndemnities."Real Amount";
                        END;

                        //IND ICP
                        RecIndemnities.RESET;
                        ICP := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'ICP');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            ICP := RecIndemnities."Real Amount";
                            //TOTICP := TOTICP+RecIndemnities."Real Amount";
                            TOTGICP := TOTGICP + RecIndemnities."Real Amount";
                        END;

                        //>>MBY 09/04/2009
                        //PR RENDEMENT
                        RecIndemnities.RESET;
                        PRREND := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'PR-REND');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            PRREND := RecIndemnities."Real Amount";
                            TOTGPRREND := TOTGPRREND + RecIndemnities."Real Amount";
                        END;
                        //<<MBY

                        //>>MBY 09/04/2009
                        //PR-LOG
                        RecIndemnities.RESET;
                        PRLOG := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'PR-LOG');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            PRLOG := RecIndemnities."Real Amount";
                            TOTGPRLOG := TOTGPRLOG + RecIndemnities."Real Amount";
                        END;
                        //<<MBY

                        //>>MBY 09/04/2009
                        //CONGE
                        RecIndemnities.RESET;
                        CONGE := 0;
                        RecIndemnities.SETRANGE("No.", "No.");
                        RecIndemnities.SETRANGE("Employee No.", Employee);
                        RecIndemnities.SETRANGE(Indemnity, 'CONGE');
                        IF RecIndemnities.FIND('-') THEN BEGIN
                            CONGE := RecIndemnities."Real Amount";
                            TOTGCONGE := TOTGCONGE + RecIndemnities."Real Amount";
                        END;
                        //<<MBY

                        TOTCAV := TOTCAV + CAV;
                        TOTCNS := TOTCNS + CNS;
                        //TOTCNS           := TOTCNS;
                        TOTINDTRANS := TOTINDTRANS + INDTRANS;
                        TOTINDPRESENCE := TOTINDPRESENCE + INDPRESENCE;
                        TOTINDENCOURAGE := TOTINDENCOURAGE + INDENCOURAGE;
                        TOTINDLOGEMENT := TOTINDLOGEMENT + INDLOGEMENT;
                        TOTINDFONCTION := TOTINDFONCTION + INDFONCTION;
                        TOTINDPANIER := TOTINDPANIER + INDPANIER;
                        TOTICP := TOTICP + ICP;

                        compteur := compteur + 1;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    TOTGCNS := 0;
                    TOTGINDTRANS := 0;
                    TOTGINDPRESENCE := 0;
                    TOTGINDENCOURAGE := 0;
                    TOTGINDLOGEMENT := 0;
                    TOTGINDFONCTION := 0;
                    TOTGINDPANIER := 0;
                    TOTGICP := 0;
                    TOTGPRREND := 0;
                    TOTGPRLOG := 0;
                    TOTGCONGE := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                RECENTETSALAIRE.FIND('-');
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
        PrintStatPages := TRUE;
    end;

    trigger OnPreReport()
    begin
        compteur := 0;
    end;

    var
        PrintStatPages: Boolean;
        TypeLA: Record "Loan & Advance Type";
        detail: Text[50];
        CNS: Decimal;
        CAV: Decimal;
        TOTCAV: Decimal;
        TOTCNS: Decimal;
        TOTGCNS: Decimal;
        RecSocialContributions: Record "Social Contributions";
        RecSocialContributions1: Record "Rec. Social Contributions";
        compteur: Integer;
        RecIndemnities: Record Indemnities;
        INDTRANS: Decimal;
        TOTINDTRANS: Decimal;
        TOTGINDTRANS: Decimal;
        INDPRESENCE: Decimal;
        TOTINDPRESENCE: Decimal;
        TOTGINDPRESENCE: Decimal;
        INDENCOURAGE: Decimal;
        TOTINDENCOURAGE: Decimal;
        TOTGINDENCOURAGE: Decimal;
        INDLOGEMENT: Decimal;
        TOTINDLOGEMENT: Decimal;
        TOTGINDLOGEMENT: Decimal;
        INDFONCTION: Decimal;
        TOTINDFONCTION: Decimal;
        TOTGINDFONCTION: Decimal;
        INDPANIER: Decimal;
        TOTINDPANIER: Decimal;
        TOTGINDPANIER: Decimal;
        ICP: Decimal;
        TOTICP: Decimal;
        TOTGICP: Decimal;
        NBJOURS: Decimal;
        CodDepartement: Code[50];
        RecEmployeeStatisticsGroup: Record 5212;
        RECENTETSALAIRE: Record "Salary Headers";
        PRREND: Decimal;
        TOTGPRREND: Decimal;
        PRLOG: Decimal;
        TOTGPRLOG: Decimal;
        CONGE: Decimal;
        TOTGCONGE: Decimal;
        TOTGASSGPE: Decimal;
        ASSGPE: Decimal;
        Journal_de_Paie_CaptionLbl: Label 'Journal de Paie ';
        Salaire_de_baseCaptionLbl: Label 'Salaire de base';
        Prime_de_TransportCaptionLbl: Label 'Prime de Transport';
        "PrêtsCaptionLbl": Label 'Prêts';
        AvancesCaptionLbl: Label 'Avances';
        NetCaptionLbl: Label 'Net';
        Salaire_BrutCaptionLbl: Label 'Salaire Brut';
        Assurance_GroupeCaptionLbl: Label 'Assurance Groupe';
        Heures_Sup_CaptionLbl: Label 'Heures Sup.';
        TotalisationCaptionLbl: Label 'Totalisation';
        C_N_S_SCaptionLbl: Label 'C.N.S.S';
        "Prime_de_PrésenceCaptionLbl": Label 'Prime de Présence';
        Prime_d_encouragementCaptionLbl: Label 'Prime d''encouragement';
        RappelCaptionLbl: Label 'Rappel';
        Ind__fonctionCaptionLbl: Label 'Ind. fonction';
        Prime_de_PanierCaptionLbl: Label 'Prime de Panier';
        I_C_PCaptionLbl: Label 'I.C.P';
        Report_en__CaptionLbl: Label 'Report en -';
        Report_en__Caption_Control1120100Lbl: Label 'Report en +';
        CONGECaptionLbl: Label 'CONGE';
        Ind__LogementCaptionLbl: Label 'Ind. Logement';
        pr__RendementCaptionLbl: Label 'pr. Rendement';
        Salaires_imposablesCaptionLbl: Label 'Salaires imposables';
        EmployeeCaptionLbl: Label 'Employee';
        EmployeeCaption_Control1120008Lbl: Label 'Employee';
        Salaire_de_baseCaption_Control1120010Lbl: Label 'Salaire de base';
        "Heures_supplém_CaptionLbl": Label 'Heures supplém.';
        C_N_S_SCaption_Control1120018Lbl: Label 'C.N.S.S';
        Salaire_ImposableCaptionLbl: Label 'Salaire Imposable';
        "Impôt__mois_CaptionLbl": Label 'Impôt (mois)';
        "PrêtsCaption_Control1120032Lbl": Label 'Prêts';
        AvancesCaption_Control1120034Lbl: Label 'Avances';
        "Salaire_Net_PerçuCaptionLbl": Label 'Salaire Net Perçu';
        Prime_de_TransportCaption_Control1120005Lbl: Label 'Prime de Transport';
        Salaire_BrutCaption_Control1120028Lbl: Label 'Salaire Brut';
        NB_Heure_JourCaptionLbl: Label 'NB Heure Jour';
        "Prime_de_PrésenceCaption_Control1120043Lbl": Label 'Prime de Présence';
        RappelCaption_Control1120044Lbl: Label 'Rappel';
        Prime_d__Encourag_CaptionLbl: Label 'Prime d'' Encourag.';
        I_C_PCaption_Control1120050Lbl: Label 'I.C.P';
        PanierCaptionLbl: Label 'Panier';
        "Indemnité_de_FonctionCaptionLbl": Label 'Indemnité de Fonction';
        EmptyStringCaptionLbl: Label '+';
        EmptyStringCaption_Control1120075Lbl: Label '-';
}

