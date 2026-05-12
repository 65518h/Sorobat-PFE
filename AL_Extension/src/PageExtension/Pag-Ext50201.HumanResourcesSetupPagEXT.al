PageExtension 50201 "Human Resources Setup_PagEXT" extends "Human Resources Setup"

{


    layout
    {
        addafter("Employee Nos.")
        {
            field("Loan & Advance Nos."; Rec."Loan & Advance Nos.")
            {
                ApplicationArea = all;
            }
            field("Paiment Nos."; Rec."Paiment Nos.")
            {
                ApplicationArea = all;
            }
            field("Employment Contract Nos."; Rec."Employment Contract Nos.")
            {
                ApplicationArea = all;
            }
            field("Salary grid Nos."; Rec."Salary grid Nos.")
            {
                ApplicationArea = all;
            }
            field("Supp. hours Nos."; Rec."Supp. hours Nos.")
            {
                ApplicationArea = all;
            }
            field("Plafond Cotisation Social"; Rec."Plafond Cotisation Social")
            {
                ApplicationArea = all;
            }
            field("Taux Plafond Cotisation"; Rec."Taux Plafond Cotisation")
            {
                ApplicationArea = all;
            }
            field("Taux TPA"; Rec."Taux TPA")
            {
                ApplicationArea = all;
            }
            field("Filtre Departement"; Rec."Filtre Departement")
            {
                ApplicationArea = all;
            }
            field("Appliquer Retenue FSP"; Rec."Appliquer Retenue FSP")
            {
                ApplicationArea = all;
            }
            field("Taux Retenue FSP"; Rec."Taux Retenue FSP")
            {
                ApplicationArea = all;
            }
            field("Pointage Salarié"; rec."Pointage Salarié")
            {
                ApplicationArea = all;
            }



        }
        addafter("Base Unit of Measure")
        {
            field("STC Salarie"; Rec."STC Salarie")
            {
                ApplicationArea = all;
            }
            field("Lot Paie"; Rec."Lot Paie")
            {
                ApplicationArea = all;
            }
            field("Bordereau Paie"; Rec."Bordereau Paie")
            {
                ApplicationArea = all;
            }
            field("Rejet Salaire"; Rec."Rejet Salaire")
            {
                ApplicationArea = all;
            }
        }
        addafter(Numbering)
        {
            group("Constantes")
            {
                Caption = 'Constants';


                field("Deduction for Familly Chief"; rec."Deduction for Familly Chief")
                {
                    ApplicationArea = all;
                }
                field("% professional expenses"; rec."% professional expenses")
                {
                    ApplicationArea = all;
                }
                // field("Plafond TP"; rec."Plafond TP")
                // {
                //     ApplicationArea = all;
                // }
                field("Taux CNSS"; rec."Taux CNSS")
                {
                    ApplicationArea = all;
                }
                field("Plafond Exonération Impot"; rec."Plafond Exonération Impot")
                {
                    ApplicationArea = all;
                }
                field("Minimum wage guarantee"; rec."Minimum wage guarantee")
                {
                    ApplicationArea = all;
                }
                field("Base Prime Panier F"; rec."Base Prime Panier F")
                {
                    ApplicationArea = all;
                }
                field("Paid days"; rec."Paid days")
                {
                    ApplicationArea = all;
                }
                field("Worked days"; rec."Worked days")
                {
                    ApplicationArea = all;
                }
                field("From Work day to Work hour"; rec."From Work day to Work hour")
                {
                    ApplicationArea = all;
                }
                field("Nombre Heure Travail Par Mois"; rec."Nombre Heure Travail Par Mois")
                {
                    ApplicationArea = all;
                }
                field("Taxes regulation"; rec."Taxes regulation")
                {
                    ApplicationArea = all;
                }
                field("Number of monthes"; rec."Number of monthes")
                {
                    ApplicationArea = all;
                }
                field("Montant Arrondi"; rec."Montant Arrondi")
                {
                    ApplicationArea = all;
                }
                field("Date de Calcul de Paie"; rec."Date de Calcul de Paie")
                {
                    ApplicationArea = all;
                }
                field("Code Calendar"; rec."Code Calendar")
                {
                    ApplicationArea = all;
                }
                field("Type calcul congé"; rec."Type calcul congé")
                {
                    ApplicationArea = all;
                }

                field("Indem Ancienneté"; rec."Indem Ancienneté")
                {
                    ApplicationArea = all;
                }
                field("Indem Sursalaire"; rec."Indem Sursalaire")
                {
                    ApplicationArea = all;
                }
                field(Valeur; Rec.Valeur)
                {
                    ApplicationArea = all;
                }
                field("Mode limite avance prêt"; rec."Mode limite avance prêt")
                {
                    ApplicationArea = all;
                }

                field("Type Calcul prêt"; rec."Type Calcul prêt")
                {
                    ApplicationArea = all;
                }
                // field("Indemnite Deplacement"; rec."Indemnite Deplacement")
                // {
                //     ApplicationArea = all;
                // }
                // field("Indemnite Transport"; rec."Indemnite Transport")
                // {
                //     ApplicationArea = all;
                // }
                field("Montant Indem Deplacement"; rec."Montant Indem Deplacement")
                {
                    ApplicationArea = all;
                }
                field("Indemnite Rappel"; rec."Indemnite Rappel")
                {
                    ApplicationArea = all;
                }
                field("Indemnite Retenu"; rec."Indemnite Retenu")
                {
                    ApplicationArea = all;
                }
                field("Indemnite Cession"; rec."Indemnite Cession")
                {
                    ApplicationArea = all;
                }
                field("Bon Reglement N°"; rec."Bon Reglement N°")
                {
                    ApplicationArea = all;
                }
                field("Plafond Heure Supp"; rec."Plafond Heure Supp")
                {
                    ApplicationArea = all;
                }
                field("Code Solde Congé STC"; rec."Code Solde Congé STC")
                {
                    ApplicationArea = all;
                }
                group(Redevance)
                {
                    Caption = 'Royalty';
                    field("Appliqué taxe redevance"; rec."Appliqué taxe redevance")
                    {
                        ApplicationArea = all;
                    }
                    field("Taux redevance sur salaire"; rec."Taux redevance sur salaire")
                    {
                        ApplicationArea = all;
                    }
                    field("Plafond redevance"; rec."Plafond redevance")
                    {
                        ApplicationArea = all;
                    }
                    field("Limite Redevance"; rec."Limite Redevance")
                    {
                        ApplicationArea = all;
                    }
                }




                field("Appliquer Exo Impot"; rec."Appliquer Exo Impot")
                {
                    ApplicationArea = all;
                }
                field("Conge Base Salaire De Base"; rec."Conge Base Salaire De Base")
                {
                    ApplicationArea = all;
                }
                field("Indemnite Kilometrage"; rec."Indemnite Kilometrage")
                {
                    ApplicationArea = all;
                }
                field("Montant Indem Kilometrage"; rec."Montant Indem Kilometrage")
                {
                    ApplicationArea = all;
                }
                field("Indemnite Panier"; rec."Indemnite Panier")
                {
                    ApplicationArea = all;
                }
                field("Taux Part salariale CNSS"; rec."Taux Part salariale CNSS")
                {
                    ApplicationArea = all;
                }

                field("Taux Part patronale CNSS"; rec."Taux Part patronale CNSS")
                {
                    ApplicationArea = all;
                }
                field("Taux Accidents du travail CNSS"; rec."Taux Accidents du travail CNSS")
                {
                    ApplicationArea = all;
                }


                field("Total Cotisation CNSS"; rec."Total Cotisation CNSS")
                {
                    ApplicationArea = all;
                }


            }

            group(Comptabilité)
            {
                Caption = 'Accounting';
                field("General Journal Template"; rec."General Journal Template")
                {
                    ApplicationArea = all;
                }
                field("Gen. Journal Batch (Payroll)"; rec."Gen. Journal Batch (Payroll)")
                {
                    ApplicationArea = all;
                }
                field("Gen. Journal Batch (L&A)"; rec."Gen. Journal Batch (L&A)")
                {
                    ApplicationArea = all;
                }
                field("Loss on rounding amounts"; rec."Loss on rounding amounts")
                {
                    ApplicationArea = all;
                }
                field("Recap Paie"; rec."Recap Paie")
                {
                    ApplicationArea = all;
                }
                group("Cotisation Sociale")
                {
                    Caption = 'Social contribution';
                    field(CNSS; rec.CNSS)
                    {
                        ApplicationArea = all;
                    }
                    field("Prestations Familiale"; rec."Prestations Familiale")
                    {
                        ApplicationArea = all;
                    }
                    field("Risque Professionnel"; rec."Risque Professionnel")
                    {
                        ApplicationArea = all;
                    }
                    field("Assurance Vieillesse"; rec."Assurance Vieillesse")
                    {
                        ApplicationArea = all;
                    }
                }
            }





            group(Image)
            {
                Caption = 'Image';
                field("Filtre Affectation1"; rec."Filtre Affectation1")
                {
                    ApplicationArea = all;
                }
                field("Filtre Affectation2"; rec."Filtre Affectation2")
                {
                    ApplicationArea = all;
                }
                field("Filtre Affectation3"; rec."Filtre Affectation3")
                {
                    ApplicationArea = all;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the picture that has been set up for the company, such as a company logo.';

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }

            }



        }


    }
    actions
    {

    }

    VAR
        txt1: Text[60];
        Ind: record Indemnity;
        SocialContribution: record "Social Contribution";
}