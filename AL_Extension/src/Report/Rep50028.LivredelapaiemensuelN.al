report 50028 "Livre de la paie mensuelN"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/LivredelapaiemensuelN.rdlc';

    dataset
    {
        dataitem(Initialisation; 2000000026)
        {
            DataItemTableView = SORTING(Number);
            column(VTotJour; VTotJour)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotSBase; VTotSBase)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotSursalaire; VTotSursalaire)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotHeureSupp; VTotHeureSupp)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotITS; VTotITS)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotTPA; VTotTPA)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotAvance; VTotAvance)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotPret; VTotPret)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotRegimeRetraite; VTotRegimeRetraite)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotNet; VTotNet)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VIndemniteNonImposable; VIndemniteNonImposable)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VIndemniteImposable_VTotSursalaire; VIndemniteImposable - VTotSursalaire)
            {
                DecimalPlaces = 0 : 3;
            }
            column(JoursCaption; JoursCaptionLbl)
            {
            }
            column(Salaire_de_BaseCaption; Salaire_de_BaseCaptionLbl)
            {
            }
            column(SursalaireCaption; SursalaireCaptionLbl)
            {
            }
            column(Heure_SuppCaption; Heure_SuppCaptionLbl)
            {
            }
            column(IUTSCaption; IUTSCaptionLbl)
            {
            }
            column(TPACaption; TPACaptionLbl)
            {
            }
            column(AvanceCaption; AvanceCaptionLbl)
            {
            }
            column(PretCaption; PretCaptionLbl)
            {
            }
            column(CNSSCaption; CNSSCaptionLbl)
            {
            }
            column(NETCaption; NETCaptionLbl)
            {
            }
            column("Indemnité_Non_ImposableCaption"; Indemnité_Non_ImposableCaptionLbl)
            {
            }
            column("Indemnité_ImposableCaption"; Indemnité_ImposableCaptionLbl)
            {
            }
            column(Initialisation_Number; Number)
            {
            }
            column(GroupingNumber; Number)
            {
            }
            dataitem(Employe; 2000000026)
            {
                DataItemLink = Number = FIELD(Number);
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending)
                                    WHERE(Number = FILTER(1 .. 100));
                column(GroupingNumber2; Initialisation.Number)
                {
                }
                column(EmployeeCodesi1; EmployeeCodes[i1])
                {
                }
                column(EmployeeCodesi2; EmployeeCodes[i2])
                {
                }
                column(EmployeeCodesi3; EmployeeCodes[i3])
                {
                }
                column(EmployeeCodesi4; EmployeeCodes[i4])
                {
                }
                column(EmployeeCodesi5; EmployeeCodes[i5])
                {
                }
                column(EmployeeCodesi6; EmployeeCodes[i6])
                {
                }
                column(EmployeeCodesi7; EmployeeCodes[i7])
                {
                }
                column(EmployeeCodesi8; EmployeeCodes[i8])
                {
                }
                column(EmployeeCodesi9; EmployeeCodes[i9])
                {
                }
                column(EmployeeCodesi10; EmployeeCodes[i10])
                {
                }
                column(EmployeeNamesi2; EmployeeNames[i2])
                {
                }
                column(EmployeeNamesi3; EmployeeNames[i3])
                {
                }
                column(EmployeeNamesi4; EmployeeNames[i4])
                {
                }
                column(EmployeeNamesi5; EmployeeNames[i5])
                {
                }
                column(EmployeeNamesi6; EmployeeNames[i6])
                {
                }
                column(EmployeeNamesi7; EmployeeNames[i7])
                {
                }
                column(EmployeeNamesi8; EmployeeNames[i8])
                {
                }
                column(EmployeeNamesi9; EmployeeNames[i9])
                {
                }
                column(EmployeeNamesi10; EmployeeNames[i10])
                {
                }
                column(EmployeeNamesi1; EmployeeNames[i1])
                {
                }
                column(WORKDATE; WORKDATE)
                {
                }
                column(TIME; TIME)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(UPPERCASE_COMPANYNAME; UPPERCASE(COMPANYNAME))
                {
                }
                column("Année___Mois___"; 'Année / Mois :')
                {
                }
                column(Anne_Mois_; 'Année / Mois :')
                {
                }
                column(SalaryHeadersYear____FORMAT_SalaryHeadersMonth; FORMAT(SalaryHeaders.Year) + ' /  ' + FORMAT(SalaryHeaders.Month))
                {
                }
                column("Ventilation_par_SalariéCaption"; Ventilation_par_SalariéCaptionLbl)
                {
                }
                column(Date_du_jour_Caption; Date_du_jour_CaptionLbl)
                {
                }
                column(Heure_Caption; Heure_CaptionLbl)
                {
                }
                column(LIVRE_DE_PAIE_MENSUELCaption; LIVRE_DE_PAIE_MENSUELCaptionLbl)
                {
                }
                column(Page_Caption; Page_CaptionLbl)
                {
                }
                column("Société_Caption"; Société_CaptionLbl)
                {
                }
                column(RubriquesCaption; RubriquesCaptionLbl)
                {
                }
                column(Employe_Number; Number)
                {
                }

                dataitem(Jours; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(V1_; '1')
                    {
                    }
                    column(Nbre_de_jours_imposable_; 'Nbre de jours imposable')
                    {
                    }
                    column(VJoursi1; VJours[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi2; VJours[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi3; VJours[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi4; VJours[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi5; VJours[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi6; VJours[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi7; VJours[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi8; VJours[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi9; VJours[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VJoursi10; VJours[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Jours_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i1]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i1] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i2]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i2] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i3]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i3] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i4]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i4] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i5]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i5] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i6]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i6] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i7]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i7] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i8] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i9] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VJours[i10] := SalaryLines."Paied days";
                            TotalCotisations[1] := SalaryLines."Paied days";
                        END;
                        //VTotJour+=VJours[i1]+VJours[i2]+VJours[i3]+VJours[i4]+VJours[i5]+VJours[i6]+VJours[i7]+VJours[i8]+VJours[i9]+VJours[i10];
                    end;
                }
                dataitem(SalaireDeBase; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(V100_; '100')
                    {
                    }
                    column(salaire_de_base_; 'salaire de base')
                    {
                    }
                    column(Sbasei1; Sbase[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei2; Sbase[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei3; Sbase[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei4; Sbase[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei5; Sbase[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei6; Sbase[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei7; Sbase[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei8; Sbase[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei9; Sbase[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Sbasei10; Sbase[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(SalaireDeBase_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i1]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i1] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i2]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i2] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i3]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i3] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i4]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i4] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i5]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i5] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i6]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i6] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i7]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i7] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i8] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i9] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            Sbase[i10] := SalaryLines."Real basis salary";
                            TotalCotisations[1] := SalaryLines."Real basis salary";
                        END;
                    end;
                }
                dataitem(IndemniteImposable; "Indemnity")
                {
                    DataItemTableView = SORTING(Code)
                                        WHERE(Type = CONST(Imposable));
                    column(Description; Description)
                    {
                    }
                    column(Code2; Code)
                    {
                    }
                    column(Description2; Description)
                    {
                    }
                    column("Code"; Code)
                    {
                    }
                    column(IndemImpoi1_j; IndemImpo[i1, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi2_j; IndemImpo[i2, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi3_j; IndemImpo[i3, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi4_j; IndemImpo[i4, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi5_j; IndemImpo[i5, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi6_j; IndemImpo[i6, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi7_j; IndemImpo[i7, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi8_j; IndemImpo[i8, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi9_j; IndemImpo[i9, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemImpoi10_j; IndemImpo[i10, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    trigger OnAfterGetRecord()
                    begin

                        j += 1;
                        Afficher := FALSE;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i1], Code) THEN BEGIN
                            IndemImpo[i1, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i2], Code) THEN BEGIN
                            IndemImpo[i2, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i3], Code) THEN BEGIN
                            IndemImpo[i3, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i4], Code) THEN BEGIN
                            IndemImpo[i4, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i5], Code) THEN BEGIN
                            IndemImpo[i5, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i6], Code) THEN BEGIN
                            IndemImpo[i6, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i7], Code) THEN BEGIN
                            IndemImpo[i7, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i8], Code) THEN BEGIN
                            IndemImpo[i8, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i9], Code) THEN BEGIN
                            IndemImpo[i9, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i10], Code) THEN BEGIN
                            IndemImpo[i10, j] := RecIndemnities."Real Amount";
                            IF RecIndemnities."Real Amount" > 0 THEN Afficher := TRUE;
                        END;
                        CurrReport.SHOWOUTPUT(Afficher = TRUE);
                    end;
                }
                dataitem("HeureSupp15%"; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column("H_Sup_à_15__"; 'H.Sup à 15%')
                    {
                    }
                    column(HSupp15i1; HSupp15[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i2; HSupp15[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i3; HSupp15[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i4; HSupp15[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i5; HSupp15[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i6; HSupp15[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i7; HSupp15[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i8; HSupp15[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i9; HSupp15[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp15i10; HSupp15[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V205_; '205')
                    {
                    }
                    column(HeureSupp15__Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i1]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i1] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i2]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i2] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i3]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i3] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i4]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i4] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i5]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i5] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i6]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i6] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i7]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i7] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i8]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i8] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i9]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i9] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.15);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i10]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp15[i10] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                    end;
                }
                dataitem("HeureSupp35%"; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column("H_Sup_à_35__"; 'H.Sup à 35%')
                    {
                    }
                    column(HSupp50i1; HSupp50[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i2; HSupp50[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i3; HSupp50[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i4; HSupp50[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i5; HSupp50[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i6; HSupp50[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i7; HSupp50[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i8; HSupp50[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i9; HSupp50[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp50i10; HSupp50[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V206_; '206')
                    {
                    }
                    column(HeureSupp35__Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i1]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i1] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i2]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i2] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i3]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i3] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i4]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i4] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i5]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i5] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i6]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i6] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i7]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i7] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i8]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i8] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i9]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i9] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.35);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i10]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp50[i10] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                    end;
                }
                dataitem("HeureSupp50%"; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column("H_Sup_à_50__"; 'H.Sup à 50%')
                    {
                    }
                    column(HSupp75i1; HSupp75[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i2; HSupp75[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i3; HSupp75[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i4; HSupp75[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i5; HSupp75[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i6; HSupp75[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i7; HSupp75[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i8; HSupp75[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i9; HSupp75[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp75i10; HSupp75[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V207_; '207')
                    {
                    }
                    column(HeureSupp50__Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i1]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i1] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i2]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i2] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i3]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i3] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i4]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i4] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i5]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i5] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i6]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i6] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i7]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i7] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i8]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i8] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i9]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i9] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.5);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i10]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp75[i10] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                    end;
                }
                dataitem("HeureSupp60%"; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column("H_Sup_à_60__"; 'H.Sup à 60%')
                    {
                    }
                    column(HSupp100i1; HSupp100[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i2; HSupp100[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i3; HSupp100[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i4; HSupp100[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i5; HSupp100[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i6; HSupp100[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i7; HSupp100[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i8; HSupp100[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i9; HSupp100[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp100i10; HSupp100[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V8_; '8')
                    {
                    }
                    column(HeureSupp60__Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i1]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i1] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i2]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i2] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i3]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i3] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i4]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i4] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i5]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i5] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i6]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i6] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i7]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i7] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i8]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i8] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i9]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i9] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 1.6);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i10]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp100[i10] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                    end;
                }
                dataitem("HeureSupp120%"; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column("H_Sup_à_120__"; 'H.Sup à 120%')
                    {
                    }
                    column(HSupp120i1; HSupp120[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i2; HSupp120[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i3; HSupp120[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i4; HSupp120[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i5; HSupp120[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i6; HSupp120[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i7; HSupp120[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i8; HSupp120[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i9; HSupp120[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(HSupp120i10; HSupp120[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V8__Control1000000222; '8')
                    {
                    }
                    column(HeureSupp120__Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i1]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i1] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i2]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i2] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i3]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i3] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i4]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i4] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i5]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i5] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i6]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i6] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i7]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i7] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i8]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i8] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i9]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i9] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                        HeuresSupEnregistré.RESET;
                        HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                        HeuresSupEnregistré.SETRANGE("Taux de majoration", 2.2);
                        HeuresSupEnregistré.SETRANGE("N° Salarié", EmployeeCodes[i10]);
                        IF HeuresSupEnregistré.FINDFIRST THEN BEGIN
                            HSupp120[i10] := HeuresSupEnregistré."Montant ligne";
                            TotalCotisations[1] := HeuresSupEnregistré."Montant ligne";
                        END;
                    end;
                }
                dataitem(IUTS; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(IUTS_; 'IUTS')
                    {
                    }
                    column(EmployeeValuesi1; EmployeeValues[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi2; EmployeeValues[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi3; EmployeeValues[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi4; EmployeeValues[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi5; EmployeeValues[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi6; EmployeeValues[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi7; EmployeeValues[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi8; EmployeeValues[i8])
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(EmployeeValuesi9; EmployeeValues[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(EmployeeValuesi10; EmployeeValues[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V500_; '500')
                    {
                    }
                    column(IUTS_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i1]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i1] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i2]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i2] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i3]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i3] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i4]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i4] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i5]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i5] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i6]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i6] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i7]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i7] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i8] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i9] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            EmployeeValues[i10] := SalaryLines."IUTS Net";
                            TotalCotisations[1] := SalaryLines."IUTS Net";
                        END;
                    end;
                }
                dataitem(TPA; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(TPA_; 'TPA')
                    {
                    }
                    column(VCNi1; VCN[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi2; VCN[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi3; VCN[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi4; VCN[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi5; VCN[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi6; VCN[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi7; VCN[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi8; VCN[i8])
                    {
                        DecimalPlaces = 3 : 3;
                    }
                    column(VCNi9; VCN[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VCNi10; VCN[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V503_; '503')
                    {
                    }
                    column(TPA_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i1]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i1] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i2]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i2] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i3]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i3] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i4]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i4] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i5]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i5] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i6]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i6] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i7]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i7] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i8] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i9] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VCN[i10] := SalaryLines.TPA;
                            TotalCotisations[1] := SalaryLines.TPA;
                        END;
                    end;
                }
                dataitem(CNSS; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CNSS_; 'CNSS')
                    {
                    }
                    column(RegimeRetraitei1; RegimeRetraite[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei2; RegimeRetraite[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei3; RegimeRetraite[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei4; RegimeRetraite[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei5; RegimeRetraite[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei6; RegimeRetraite[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei7; RegimeRetraite[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei8; RegimeRetraite[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei9; RegimeRetraite[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(RegimeRetraitei10; RegimeRetraite[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(V533_; '533')
                    {
                    }
                    column(CNSS_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i1]);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i1] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i2]);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i2] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i3]);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i3] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i4]);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i4] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i5]);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i5] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i6]);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i6] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i7]);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i7] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i8] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i9] := RecSocialContributions."Real Amount : Employee";
                        END;
                        RecSocialContributions.RESET;
                        RecSocialContributions.SETRANGE("No.", NumPaie);
                        RecSocialContributions.SETRANGE("Social Contribution", '534');
                        RecSocialContributions.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF RecSocialContributions.FINDFIRST THEN BEGIN
                            RegimeRetraite[i10] := RecSocialContributions."Real Amount : Employee";
                        END;
                    end;
                }
                dataitem(IndemniteNonImposable; "Indemnity")
                {
                    DataItemTableView = SORTING(Code)
                                        WHERE(Type = CONST("Non imposable"));
                    column(IndemniteNonImposable_Description; Description)
                    {
                    }
                    column(IndemniteNonImposable_Code; Code)
                    {
                    }
                    column(IndemNonImpoi1_k; IndemImpo[i1, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi2_k; IndemImpo[i2, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi3_k; IndemImpo[i3, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi4_k; IndemImpo[i4, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi5_k; IndemImpo[i5, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi6_k; IndemImpo[i6, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi7_k; IndemImpo[i7, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi8_k; IndemImpo[i8, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi9_k; IndemImpo[i9, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(IndemNonImpoi10_k; IndemImpo[i10, j])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    trigger OnAfterGetRecord()
                    begin

                        j += 1;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i1], Code, FALSE) THEN BEGIN
                            IndemImpo[i1, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i2], Code, FALSE) THEN BEGIN
                            IndemImpo[i2, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i3], Code, FALSE) THEN BEGIN
                            IndemImpo[i3, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i4], Code, FALSE) THEN BEGIN
                            IndemImpo[i4, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i5], Code, FALSE) THEN BEGIN
                            IndemImpo[i5, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i6], Code, FALSE) THEN BEGIN
                            IndemImpo[i6, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i7], Code, FALSE) THEN BEGIN
                            IndemImpo[i7, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i8], Code, FALSE) THEN BEGIN
                            IndemImpo[i8, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i9], Code, FALSE) THEN BEGIN
                            IndemImpo[i9, j] := RecIndemnities."Real Amount";
                        END;
                        IF RecIndemnities.GET(NumPaie, EmployeeCodes[i10], Code, FALSE) THEN BEGIN
                            IndemImpo[i10, j] := RecIndemnities."Real Amount";
                        END;
                    end;
                }
                dataitem(Avance; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Avance_Sur_Salaire_; 'Avance Sur Salaire')
                    {
                    }
                    column(V712_; '712')
                    {
                    }
                    column(VAvancei1; VAvance[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei2; VAvance[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei3; VAvance[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei4; VAvance[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei5; VAvance[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei6; VAvance[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei7; VAvance[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei8; VAvance[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei9; VAvance[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VAvancei10; VAvance[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Avance_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i1]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i1] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i2]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i2] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i3]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i3] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i4]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i4] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i5]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i5] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i6]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i6] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i7]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i7] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i8] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i9] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VAvance[i10] := SalaryLines.Advances;
                            TotalCotisations[1] := SalaryLines.Advances;
                        END;
                    end;
                }
                dataitem(Pret; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column("Prêt_"; 'Prêt')
                    {
                    }
                    column(V713_; '713')
                    {
                    }
                    column(VPreti1; VPret[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti2; VPret[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti3; VPret[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti4; VPret[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti5; VPret[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti6; VPret[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti7; VPret[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti8; VPret[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti9; VPret[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VPreti10; VPret[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(Pret_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i1]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i1] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i2]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i2] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i3]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i3] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i4]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i4] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i5]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i5] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i6]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i6] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i7]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i7] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i8] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i9] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VPret[i10] := SalaryLines.Loans;
                            TotalCotisations[1] := SalaryLines.Loans;
                        END;
                    end;
                }
                dataitem(SalaireNET; 2000000026)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(V999_; '999')
                    {
                    }
                    column("Net_à_Payer_"; 'Net à Payer')
                    {
                    }
                    column(VNETi1; VNET[i1])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi2; VNET[i2])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi3; VNET[i3])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi4; VNET[i4])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi5; VNET[i5])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi6; VNET[i6])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi7; VNET[i7])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi8; VNET[i8])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi9; VNET[i9])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(VNETi10; VNET[i10])
                    {
                        DecimalPlaces = 0 : 3;
                    }
                    column(SalaireNET_Number; Number)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin

                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i1]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i1] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i2]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i2] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i3]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i3] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i4]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i4] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i5]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i5] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i6]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i6] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i7]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i7] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i8]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i8] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i9]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i9] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                        SalaryLines.RESET;
                        SalaryLines.SETRANGE("No.", NumPaie);
                        SalaryLines.SETRANGE(Employee, EmployeeCodes[i10]);
                        IF SalaryLines.FINDFIRST THEN BEGIN
                            VNET[i10] := SalaryLines."Net salary cashed";
                            TotalCotisations[1] := SalaryLines."Net salary cashed";
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    /*i:=1;
                    NombreEmplyee:=0;
                    Employee.RESET;
                    Employee.SETRANGE(Blocked,FALSE);
                    IF (SalaryLines3.FINDFIRST)  THEN
                    IF Employee.FINDSET THEN BEGIN
                        REPEAT
                          i1:= Initialisation.Number*10-9;
                          i2:= Initialisation.Number*10-8;
                          i3:= Initialisation.Number*10-7;
                          i4:= Initialisation.Number*10-6;
                          i5:= Initialisation.Number*10-5;
                          i6:= Initialisation.Number*10-4;
                          i7:= Initialisation.Number*10-3;
                          i8:= Initialisation.Number*10-2;
                          i9:= Initialisation.Number*10-1;
                          i10:=Initialisation.Number*10;

                            EmployeeCodes[i]:=Employee."No.";
                            EmployeeNames[i]:=Employee."First Name"+ ' ' +Employee."Last Name";
                            i:=i+1;
                            NombreEmplyee+=1;

                        UNTIL (Employee.NEXT =0);
                    END; */
                    i := 1;
                    NombreEmplyee := 0;
                    SalaryLines3.SETRANGE("No.", NumPaie);
                    IF SalaryLines3.FINDFIRST THEN
                        //IF Employee.FINDSET THEN BEGIN
                        REPEAT

                            i1 := Initialisation.Number * 10 - 9;
                            i2 := Initialisation.Number * 10 - 8;
                            i3 := Initialisation.Number * 10 - 7;
                            i4 := Initialisation.Number * 10 - 6;
                            i5 := Initialisation.Number * 10 - 5;
                            i6 := Initialisation.Number * 10 - 4;
                            i7 := Initialisation.Number * 10 - 3;
                            i8 := Initialisation.Number * 10 - 2;
                            i9 := Initialisation.Number * 10 - 1;
                            i10 := Initialisation.Number * 10;

                            EmployeeCodes[i] := SalaryLines3.Employee;
                            EmployeeNames[i] := SalaryLines3.Name;

                            i := i + 1;
                            NombreEmplyee += 1;

                        UNTIL (SalaryLines3.NEXT = 0);
                    //  UNTIL (Employee.NEXT =0);
                    //END;

                end;
            }

            trigger OnAfterGetRecord()
            begin
                /*
                  //---------------------------------------------REMPLISSAGE ENTETE SALARIES--------------------------------------------------------
                -
                //IF CurrReport.PAGENO=1 THEN
                //BEGIN
                //END;
                  //-----------------------------------------------------AJOUT SALAIRE DE BASE------------------------------------------------------
                --
                EXIT;
                i:=1;
                j:=1;
                Employee.RESET;
                Employee.SETCURRENTKEY(Rang,Bloqué);
                Employee.SETRANGE(Bloqué,FALSE);
                Employee.SETRANGE(Rang,Rangdebut,RangFin);
                IF Employee.FINDSET THEN BEGIN
                Rubriques[i]:='Salaire de base Catégoriel';
                REPEAT

                    EmployeeValues[i,j]:=Employee."Basis salary";
                    TotalBrut[j] +=Employee."Basis salary";
                    j:=j+1;
                UNTIL (Employee.NEXT =0);
                END;
                //-----------------------------------------AJOUT JOURS TRAVAILLES----------------------------------------------------------
                //----------------------------------------------------AJOUT TOTAL BRUT---------------------------------------------------------

                //-----------------------------------------AJOUT INDEMNITES IMPOSABLES----------------------------------------------------------
                i:=2;
                Indemnite.RESET;
                Indemnite.SETRANGE(Type,Indemnite.Type::Imposable);
                Indemnite.SETRANGE("Type STC",0);
                IF Indemnite.FINDSET THEN BEGIN
                REPEAT
                  Rubriques[i]:=Indemnite.Description;
                  RecIndemnities.RESET;
                  RecIndemnities.SETRANGE("No.",NumPaie);
                  RecIndemnities.SETRANGE(Description,Indemnite.Description);
                  FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                     RecIndemnities.SETRANGE("Employee No.",EmployeeCodes[j]);
                     IF RecIndemnities.FINDFIRST THEN  BEGIN
                        EmployeeValues[i,j]:=RecIndemnities."Real Amount";
                        TotalBrut[j] +=RecIndemnities."Real Amount";
                     END
                     ELSE  EmployeeValues[i,j]:=0;
                  END;
                  i:=i+1;
                UNTIL(Indemnite.NEXT = 0);
                END;
                //----------------------------------------------------AJOUT TOTAL BRUT---------------------------------------------------------
                //i:=i+1;
                Rubriques[i]:='Total Brut';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                    EmployeeValues[i,j] :=TotalBrut[j];
                END;
                //----------------------------------------------------AJOUT ITS, CN & IGR---------------------------------------------------------
                SalaryLines.RESET;
                SalaryLines.SETRANGE("No.",NumPaie);
                i:=i+1;
                Rubriques[i]:='Impôt sur trait. et sal.(ITS)';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN BEGIN
                      EmployeeValues[i,j]:=SalaryLines.ITS;
                      TotalCotisations[j] +=SalaryLines.ITS;
                   END
                   ELSE  EmployeeValues[i,j]:=0;
                END;
                i:=i+1;
                Rubriques[i]:='Contribution Nationale (CN)';
                  FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                     SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                     IF SalaryLines.FINDFIRST THEN BEGIN
                        EmployeeValues[i,j]:=SalaryLines.CN;
                        TotalCotisations[j] +=SalaryLines.CN;
                     END
                     ELSE  EmployeeValues[i,j]:=0;
                  END;
                i:=i+1;
                Rubriques[i]:='Impôt Général sur Revenu (IGR)';
                  FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                     SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                     IF SalaryLines.FINDFIRST THEN BEGIN
                        EmployeeValues[i,j]:=SalaryLines.IGR;
                        TotalCotisations[j] +=SalaryLines.IGR;
                     END
                     ELSE  EmployeeValues[i,j]:=0;
                  END;
                  //----------------------------------------------------AJOUT COTISATIONS SOCIALES--------------------------------------------------
                --
                i:=i+1;
                SocialContributions.RESET;
                SocialContributions.SETFILTER("Employee's part",'<>%1',0);
                IF SocialContributions.FINDSET THEN BEGIN
                REPEAT
                  Rubriques[i]:=SocialContributions.Description;
                  RecSocialContributions.RESET;
                  RecSocialContributions.SETRANGE("No.",NumPaie);
                  RecSocialContributions.SETRANGE(Description,SocialContributions.Description);
                  FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                     RecSocialContributions.SETRANGE(Employee,EmployeeCodes[j]);
                     IF RecSocialContributions.FINDFIRST THEN BEGIN
                          EmployeeValues[i,j]:=RecSocialContributions."Real Amount : Employee";
                          TotalCotisations[j] +=RecSocialContributions."Real Amount : Employee";
                          TotalCotisationsPat[j] +=RecSocialContributions."Real Amount : Employer";
                     END
                     ELSE  EmployeeValues[i,j]:=0;
                  END;
                  i:=i+1;
                UNTIL(SocialContributions.NEXT = 0);
                END;
                  //----------------------------------------------------AJOUT TOTAL COTISATIONS-----------------------------------------------------
                --
                //i:=i+1;
                Rubriques[i]:='Total Cotisation';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                    EmployeeValues[i,j] :=TotalCotisations[j];
                END;

                  //-------------------------------------------------AJOUT INDEMNITES NON IMPOSABLES------------------------------------------------
                --
                i:=i+1;
                Indemnite.RESET;
                Indemnite.SETRANGE(Type,Indemnite.Type::"Non imposable");
                IF Indemnite.FINDSET THEN BEGIN
                REPEAT
                  Rubriques[i]:=Indemnite.Description;
                  RecIndemnities.RESET;
                  RecIndemnities.SETRANGE("No.",NumPaie);
                  RecIndemnities.SETRANGE(Description,Indemnite.Description);
                  FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                     RecIndemnities.SETRANGE("Employee No.",EmployeeCodes[j]);
                     IF RecIndemnities.FINDFIRST THEN EmployeeValues[i,j]:=RecIndemnities."Real Amount"
                     ELSE  EmployeeValues[i,j]:=0;
                  END;
                  i:=i+1;
                UNTIL(Indemnite.NEXT = 0);
                END;
                  //-------------------------------------------------AJOUT HEURES NORMALES----------------------------------------------------------
                --
                //i:=i+1;
                Rubriques[i]:='Heures Normales';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   EmployeeValues[i,j]:=173;
                END;
                  //------------------------------------------------AJOUT TOTAL BRUT ET COTISATIONS-------------------------------------------------
                --
                i:=i+1;
                Rubriques[i]:='Brut';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   EmployeeValues[i,j]:=TotalBrut[j];
                END;
                i:=i+1;
                Rubriques[i]:='Cotisations salariales';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   EmployeeValues[i,j]:=TotalCotisations[j];
                END;
                i:=i+1;
                Rubriques[i]:='Cotisations patronales';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   EmployeeValues[i,j]:=TotalCotisationsPat[j];
                END;
                  //----------------------------------------------------AJOUT NET A PAYER-----------------------------------------------------------
                --
                SalaryLines.RESET;
                SalaryLines.SETRANGE("No.",NumPaie);
                i:=i+1;
                Rubriques[i]:='Net à payer';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN
                      EmployeeValues[i,j]:=SalaryLines."Net salary cashed";
                END;
                  //----------------------------------------------------AJOUT HEURES ET CONGES------------------------------------------------------
                --
                SalaryLines.RESET;
                SalaryLines.SETRANGE("No.",NumPaie);
                i:=i+1;
                Rubriques[i]:='Total des heures travaillées';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN
                      EmployeeValues[i,j]:=SalaryLines."Worked hours";
                END;

                i:=i+1;
                Rubriques[i]:='Total des heures supplémentaires';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN
                      EmployeeValues[i,j]:=SalaryLines."Nombre d'heures suppl.";
                END;

                i:=i+1;
                Rubriques[i]:='Total des heures complémentaires';
                //heures complémentaires


                i:=i+1;
                Rubriques[i]:='Absence';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN
                      EmployeeValues[i,j]:=SalaryLines.Absences;
                END;
                i:=i+1;
                Rubriques[i]:='Congés acquis';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN
                      EmployeeValues[i,j]:=SalaryLines."droit de congé du mois";
                END;

                i:=i+1;
                Rubriques[i]:='Congés pris';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN
                      EmployeeValues[i,j]:=SalaryLines.congé;
                END;

                i:=i+1;
                Rubriques[i]:='Total des heures de présence';
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   SalaryLines.SETRANGE(Employee,EmployeeCodes[j]);
                   IF SalaryLines.FINDFIRST THEN
                      EmployeeValues[i,j]:=SalaryLines."Worked hours";
                END;
                  //----------------------------------------------------AJOUT HEURES ET CONGES------------------------------------------------------
                --
                i:=i+1;
                Rubriques[i]:='Cout total';
                RecIndemnities.RESET;
                RecIndemnities.SETRANGE("No.",NumPaie);
                RecIndemnities.SETRANGE(Indemnity,'001');
                FOR j:=1 TO ARRAYLEN(EmployeeCodes) DO BEGIN
                   RecIndemnities.SETRANGE("Employee No.",EmployeeCodes[j]);
                   IF RecIndemnities.FINDFIRST THEN
                      EmployeeValues[i,j]:=TotalBrut[j]+TotalCotisationsPat[j]+RecIndemnities."Real Amount"
                   ELSE  EmployeeValues[i,j]:=TotalBrut[j]+TotalCotisationsPat[j];
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                //Employee.RESET;
                //Employee.SETRANGE(Blocked,FALSE);
                //SETRANGE(Number,1,ROUND(Employee.COUNT/10,1));
                SalaryLines3.SETRANGE("No.", NumPaie);
                //
                //SETRANGE(Number,1,ROUND(Employee.COUNT/10,1));
                SETRANGE(Number, 1, ROUND(SalaryLines3.COUNT / 10 + 1, 1));
                //Jours Trvail
                SalaryLines.RESET;
                SalaryLines.SETRANGE("No.", NumPaie);
                IF SalaryLines.FINDFIRST THEN
                    REPEAT
                        VTotJour += SalaryLines."Paied days";
                        VTotITS += SalaryLines."IUTS Net";
                        VTotTPA += ROUND(SalaryLines.TPA, 1);
                        // VTotIGR +=SalaryLines.IGR;
                        VTotAvance += SalaryLines.Advances;
                        VTotPret += SalaryLines.Loans;
                        VTotNet += SalaryLines."Net salary cashed";
                    UNTIL SalaryLines.NEXT = 0;
                // Salaire de Base
                SalaryLines.RESET;
                SalaryLines.SETRANGE("No.", NumPaie);
                IF SalaryLines.FINDFIRST THEN
                    REPEAT
                        VTotSBase += SalaryLines."Real basis salary";
                    UNTIL SalaryLines.NEXT = 0;

                // Sursalaire
                RecIndemnities.RESET;
                RecIndemnities.SETRANGE("No.", NumPaie);
                RecIndemnities.SETRANGE(Indemnity, '100');
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT
                        VTotSursalaire += ROUND(RecIndemnities."Real Amount", 1);
                    UNTIL RecIndemnities.NEXT = 0;

                // Indemnite Imposable
                RecIndemnities.RESET;
                RecIndemnities.SETRANGE("No.", NumPaie);
                RecIndemnities.SETRANGE(Type, 0);
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT
                        VIndemniteImposable += ROUND(RecIndemnities."Real Amount", 1);
                    UNTIL RecIndemnities.NEXT = 0;
                // Heure Sup
                HeuresSupEnregistré.RESET;
                HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                IF HeuresSupEnregistré.FINDFIRST THEN
                    REPEAT
                        VTotHeureSupp += HeuresSupEnregistré."Montant ligne";
                    UNTIL HeuresSupEnregistré.NEXT = 0;
                // Regime Retraite
                RecSocialContributions.RESET;
                RecSocialContributions.SETRANGE("No.", NumPaie);
                RecSocialContributions.SETRANGE("Social Contribution", '534');
                IF RecSocialContributions.FINDFIRST THEN
                    REPEAT
                        VTotRegimeRetraite += RecSocialContributions."Real Amount : Employee";
                    UNTIL RecSocialContributions.NEXT = 0;
                //
                // Indemnite Non Imposable
                RecIndemnities.RESET;
                RecIndemnities.SETRANGE("No.", NumPaie);
                RecIndemnities.SETRANGE(Type, 1);
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT
                        VIndemniteNonImposable += ROUND(RecIndemnities."Real Amount", 1);
                    UNTIL RecIndemnities.NEXT = 0;
            end;
        }
        /*dataitem(Total; 2000000026)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));
            column(VTotJour; VTotJour)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotSBase; VTotSBase)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotSursalaire; VTotSursalaire)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotHeureSupp; VTotHeureSupp)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotITS; VTotITS)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotTPA; VTotTPA)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotAvance; VTotAvance)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotPret; VTotPret)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotRegimeRetraite; VTotRegimeRetraite)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VTotNet; VTotNet)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VIndemniteNonImposable; VIndemniteNonImposable)
            {
                DecimalPlaces = 0 : 3;
            }
            column(VIndemniteImposable_VTotSursalaire; VIndemniteImposable - VTotSursalaire)
            {
                DecimalPlaces = 0 : 3;
            }
            column(JoursCaption; JoursCaptionLbl)
            {
            }
            column(Salaire_de_BaseCaption; Salaire_de_BaseCaptionLbl)
            {
            }
            column(SursalaireCaption; SursalaireCaptionLbl)
            {
            }
            column(Heure_SuppCaption; Heure_SuppCaptionLbl)
            {
            }
            column(IUTSCaption; IUTSCaptionLbl)
            {
            }
            column(TPACaption; TPACaptionLbl)
            {
            }
            column(AvanceCaption; AvanceCaptionLbl)
            {
            }
            column(PretCaption; PretCaptionLbl)
            {
            }
            column(CNSSCaption; CNSSCaptionLbl)
            {
            }
            column(NETCaption; NETCaptionLbl)
            {
            }
            column("Indemnité_Non_ImposableCaption"; Indemnité_Non_ImposableCaptionLbl)
            {
            }
            column("Indemnité_ImposableCaption"; Indemnité_ImposableCaptionLbl)
            {
            }
            column(Total_Number; Number)
            {
            }
            trigger OnAfterGetRecord()
            begin

                //Jours Trvail
                SalaryLines.RESET;
                SalaryLines.SETRANGE("No.", NumPaie);
                IF SalaryLines.FINDFIRST THEN
                    REPEAT
                        VTotJour += SalaryLines."Paied days";
                        VTotITS += SalaryLines."IUTS Net";
                        VTotTPA += ROUND(SalaryLines.TPA, 1);
                        // VTotIGR +=SalaryLines.IGR;
                        VTotAvance += SalaryLines.Advances;
                        VTotPret += SalaryLines.Loans;
                        VTotNet += SalaryLines."Net salary cashed";
                    UNTIL SalaryLines.NEXT = 0;
                // Salaire de Base
                SalaryLines.RESET;
                SalaryLines.SETRANGE("No.", NumPaie);
                IF SalaryLines.FINDFIRST THEN
                    REPEAT
                        VTotSBase += SalaryLines."Real basis salary";
                    UNTIL SalaryLines.NEXT = 0;

                // Sursalaire
                RecIndemnities.RESET;
                RecIndemnities.SETRANGE("No.", NumPaie);
                RecIndemnities.SETRANGE(Indemnity, '100');
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT
                        VTotSursalaire += ROUND(RecIndemnities."Real Amount", 1);
                    UNTIL RecIndemnities.NEXT = 0;

                // Indemnite Imposable
                RecIndemnities.RESET;
                RecIndemnities.SETRANGE("No.", NumPaie);
                RecIndemnities.SETRANGE(Type, 0);
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT
                        VIndemniteImposable += ROUND(RecIndemnities."Real Amount", 1);
                    UNTIL RecIndemnities.NEXT = 0;
                // Heure Sup
                HeuresSupEnregistré.RESET;
                HeuresSupEnregistré.SETRANGE("Paiement No.", NumPaie);
                IF HeuresSupEnregistré.FINDFIRST THEN
                    REPEAT
                        VTotHeureSupp += HeuresSupEnregistré."Montant ligne";
                    UNTIL HeuresSupEnregistré.NEXT = 0;
                // Regime Retraite
                RecSocialContributions.RESET;
                RecSocialContributions.SETRANGE("No.", NumPaie);
                RecSocialContributions.SETRANGE("Social Contribution", '534');
                IF RecSocialContributions.FINDFIRST THEN
                    REPEAT
                        VTotRegimeRetraite += RecSocialContributions."Real Amount : Employee";
                    UNTIL RecSocialContributions.NEXT = 0;
                //
                // Indemnite Non Imposable
                RecIndemnities.RESET;
                RecIndemnities.SETRANGE("No.", NumPaie);
                RecIndemnities.SETRANGE(Type, 1);
                IF RecIndemnities.FINDFIRST THEN
                    REPEAT
                        VIndemniteNonImposable += ROUND(RecIndemnities."Real Amount", 1);
                    UNTIL RecIndemnities.NEXT = 0;
            end;
        }*/
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NumPaie; NumPaie)
                    {
                        ApplicationArea = Basic;
                        Caption = 'N  Paie:';
                        TableRelation = "Rec. Salary Headers";
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF SalaryHeaders.GET(NumPaie) THEN;
    end;

    var
        IndemImpo: array[600, 1600] of Decimal;
        EmployeeCodes: array[5000] of Code[100];
        VCN: array[1000] of Decimal;
        VNET: array[1000] of Decimal;
        HSupp15: array[1000] of Decimal;
        HSupp50: array[1000] of Decimal;
        HSupp75: array[1000] of Decimal;
        HSupp100: array[1000] of Decimal;
        HSupp120: array[1000] of Decimal;
        VAvance: array[1000] of Decimal;
        VPret: array[1000] of Decimal;
        VJours: array[1000] of Decimal;
        Sbase: array[1000] of Decimal;
        RegimeRetraite: array[1000] of Decimal;
        IGR: array[1000] of Decimal;
        SalaryLines2: Record "Salary Lines";
        SalaryHeaders: Record "Salary Headers";
        EmployeeNames: array[5000] of Text[100];
        EmployeeValues: array[10000] of Decimal;
        i: Integer;
        j: Integer;
        "HeuresSupEnregistré": Record "Heures sup. eregistrées m";
        Employee: Record 5200;
        RecIndemnities: Record "Indemnities";
        RecSocialContributions: Record "Social Contributions";
        "NomIndemnité": Text[100];
        Rubriques: array[1000] of Text[100];
        Indemnite: Record "Indemnity";
        SocialContributions: Record "Social Contribution";
        NumPaie: Code[20];
        TotalBrut: array[1000] of Decimal;
        TotalCotisations: array[1000] of Decimal;
        SalaryLines: Record "Salary Lines";
        TotalCotisationsPat: array[1000] of Decimal;
        newDataItem: Boolean;
        NombreEmplyee: Integer;
        Rangdebut: Integer;
        RangFin: Integer;
        Range: Integer;
        Text001: Label 'Traitement Achever Avec Succée';
        i1: Integer;
        i2: Integer;
        i3: Integer;
        i4: Integer;
        i5: Integer;
        i6: Integer;
        i7: Integer;
        i8: Integer;
        i9: Integer;
        i10: Integer;
        V1: Decimal;
        Compteur: Integer;
        VTotJour: Decimal;
        VTotSBase: Decimal;
        VIndemniteImposable: Decimal;
        VTotHeureSupp: Decimal;
        VTotITS: Decimal;
        VTotTPA: Decimal;
        VTotIGR: Decimal;
        VTotAvance: Decimal;
        VTotPret: Decimal;
        VTotNet: Decimal;
        VTOTReprise: Decimal;
        VTotRegimeRetraite: Decimal;
        VIndemniteNonImposable: Decimal;
        VTotSursalaire: Decimal;
        SalaryLines3: Record "Salary Lines";
        Afficher: Boolean;
        "Ventilation_par_SalariéCaptionLbl": Label 'Ventilation par Salarié';
        Date_du_jour_CaptionLbl: Label 'Date du jour:';
        Heure_CaptionLbl: Label 'Heure:';
        LIVRE_DE_PAIE_MENSUELCaptionLbl: Label 'LIVRE DE PAIE MENSUEL';
        Page_CaptionLbl: Label 'Page:';
        "Société_CaptionLbl": Label 'Société:';
        RubriquesCaptionLbl: Label 'Rubriques';
        JoursCaptionLbl: Label 'Jours';
        Salaire_de_BaseCaptionLbl: Label 'Salaire de Base';
        SursalaireCaptionLbl: Label 'Sursalaire';
        Heure_SuppCaptionLbl: Label 'Heure Supp';
        IUTSCaptionLbl: Label 'IUTS';
        TPACaptionLbl: Label 'TPA';
        AvanceCaptionLbl: Label 'Avance';
        PretCaptionLbl: Label 'Pret';
        CNSSCaptionLbl: Label 'CNSS';
        NETCaptionLbl: Label 'NET';
        "Indemnité_Non_ImposableCaptionLbl": Label 'Indemnité Non Imposable';
        "Indemnité_ImposableCaptionLbl": Label 'Indemnité Imposable';


    procedure GETNumPaie(ParaNumPaie: Code[20])
    begin
        NumPaie := ParaNumPaie;
    end;
}

