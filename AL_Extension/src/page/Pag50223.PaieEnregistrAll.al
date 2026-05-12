Page 50223 "Paie Enregistré All"
{
    Editable = false;
    PageType = List;
    SourceTable = "Rec. Salary Lines";
    //ABZ ApplicationArea = all;
    Caption = 'Paie Enregistré All';
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field(Employee; REC.Employee)
                {
                    ApplicationArea = all;
                }
                field(Name; REC.Name)
                {
                    ApplicationArea = all;
                }
                // field(RIB; REC.RIB)
                // {
                //     ApplicationArea = all;
                // }
                // field("Impot Annuelle 2"; REC."Impot Annuelle 2")
                // {
                //     ApplicationArea = all;
                // }
                field("Employee Posting Group"; REC."Employee Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Regime of work"; REC."Regime of work")
                {
                    ApplicationArea = all;
                }
                field("Emplymt. Contract Code"; REC."Emplymt. Contract Code")
                {
                    ApplicationArea = all;
                }
                // field("Contribution Social"; REC."Contribution Social")
                // {
                //     ApplicationArea = all;
                // }
                field("Bank Account Code"; REC."Bank Account Code")
                {
                    ApplicationArea = all;
                }
                field("Employee's type"; REC."Employee's type")
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field(Note; REC.Note)
                {
                    ApplicationArea = all;
                }
                field(Pourcentage; REC.Pourcentage)
                {
                    ApplicationArea = all;
                }
                field("Mois travaillés"; REC."Mois travaillés")
                {
                    ApplicationArea = all;
                }
                field(Month; REC.Month)
                {
                    ApplicationArea = all;
                }
                field(Year; REC.Year)
                {
                    ApplicationArea = all;
                }
                field(Quarter; REC.Quarter)
                {
                    ApplicationArea = all;
                }
                field("Days off remaining"; REC."Days off remaining")
                {
                    ApplicationArea = all;
                }
                field("Days off balacement"; REC."Days off balacement")
                {
                    ApplicationArea = all;
                }
                field(Absences; REC.Absences)
                {
                    ApplicationArea = all;
                }
                field("Adjustment of absences"; REC."Adjustment of absences")
                {
                    ApplicationArea = all;
                }
                field("Days off"; REC."Days off")
                {
                    ApplicationArea = all;
                }
                field("Assiduity (Paid days)"; REC."Assiduity (Paid days)")
                {
                    ApplicationArea = all;
                }
                field("Assiduity (Worked days)"; REC."Assiduity (Worked days)")
                {
                    ApplicationArea = all;
                }
                field("Congé Pris"; REC."Congé Pris")
                {
                    ApplicationArea = all;
                }
                field("Worked hours"; REC."Worked hours")
                {
                    ApplicationArea = all;
                }
                field("Basis hours"; REC."Basis hours")
                {
                    ApplicationArea = all;
                }
                field("Amount Days Off balacement"; REC."Amount Days Off balacement")
                {
                    ApplicationArea = all;
                }
                field("Assiduity (days off balacement"; REC."Assiduity (days off balacement")
                {
                    ApplicationArea = all;
                }
                field("Hours off Balacement"; REC."Hours off Balacement")
                {
                    ApplicationArea = all;
                }
                field("Basis salary"; REC."Basis salary")
                {
                    ApplicationArea = all;
                }
                field("Taxable indemnities"; REC."Taxable indemnities")
                {
                    ApplicationArea = all;
                }
                field("Supp. hours"; REC."Supp. hours")
                {
                    ApplicationArea = all;
                }
                field("Real basis salary"; REC."Real basis salary")
                {
                    ApplicationArea = all;
                }
                field("Gross Salary"; REC."Gross Salary")
                {
                    ApplicationArea = all;
                }
                field(CNSS; REC.CNSS)
                {
                    ApplicationArea = all;
                }
                field("Gross Salary (sans Av)"; REC."Gross Salary (sans Av)")
                {
                    ApplicationArea = all;
                }
                field("Indm. Impo. (N. Déd. Cot. Sc)"; REC."Indm. Impo. (N. Déd. Cot. Sc)")
                {
                    ApplicationArea = all;
                }
                field("Gross Salary (sans Av) PR"; REC."Gross Salary (sans Av) PR")
                {
                    ApplicationArea = all;
                }
                field("Taxable salary"; REC."Taxable salary")
                {
                    ApplicationArea = all;
                }
                field("Deduction Family chief"; REC."Deduction Family chief")
                {
                    ApplicationArea = all;
                }
                field("Deduction Loaded child"; REC."Deduction Loaded child")
                {
                    ApplicationArea = all;
                }
                field("Deduction Prof. expenses"; REC."Deduction Prof. expenses")
                {
                    ApplicationArea = all;
                }
                field("Real taxable"; REC."Real taxable")
                {
                    ApplicationArea = all;
                }
                field("Total taxable rec."; REC."Total taxable rec.")
                {
                    ApplicationArea = all;
                }
                field("Rec. payments"; REC."Rec. payments")
                {
                    ApplicationArea = all;
                }
                field("Real taxable (Year)"; REC."Real taxable (Year)")
                {
                    ApplicationArea = all;
                }
                field("Taxe (Year)"; REC."Taxe (Year)")
                {
                    ApplicationArea = all;
                }
                field("Total taxes rec."; REC."Total taxes rec.")
                {
                    ApplicationArea = all;
                }
                field("Taxe (Month)"; REC."Taxe (Month)")
                {
                    ApplicationArea = all;
                }
                field("Non Taxable indemnities"; REC."Non Taxable indemnities")
                {
                    ApplicationArea = all;
                }
                field("Taxable Soc. Contrib."; REC."Taxable Soc. Contrib.")
                {
                    ApplicationArea = all;
                }
                field("Mission expenses"; REC."Mission expenses")
                {
                    ApplicationArea = all;
                }
                field("Net salary"; REC."Net salary")
                {
                    ApplicationArea = all;
                }
                field(Loans; REC.Loans)
                {
                    ApplicationArea = all;
                }
                field(Advances; REC.Advances)
                {
                    ApplicationArea = all;
                }
                field("Net salary cashed"; REC."Net salary cashed")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 1"; REC."Global dimension 1")
                {
                    ApplicationArea = all;
                }
                field("Global dimension 2"; REC."Global dimension 2")
                {
                    ApplicationArea = all;
                }
                field("Gross Salary PR"; REC."Gross Salary PR")
                {
                    ApplicationArea = all;
                }
                field("Non Taxable Soc. Contrib. PR"; REC."Non Taxable Soc. Contrib. PR")
                {
                    ApplicationArea = all;
                }
                field("Taxable indem. PR (Not Gross)"; REC."Taxable indem. PR (Not Gross)")
                {
                    ApplicationArea = all;
                }
                field("Taxable salary PR"; REC."Taxable salary PR")
                {
                    ApplicationArea = all;
                }
                field("6 * SMIG"; REC."6 * SMIG")
                {
                    ApplicationArea = all;
                }
                field("Type Prime"; REC."Type Prime")
                {
                    ApplicationArea = all;
                }
                field("Heures consomation congé"; REC."Heures consomation congé")
                {
                    ApplicationArea = all;
                }
                field("year of Calculate"; REC."year of Calculate")
                {
                    ApplicationArea = all;
                }
                field("Num Compte"; REC."Num Compte")
                {
                    ApplicationArea = all;
                }

                field(Service; REC.Service)
                {
                    ApplicationArea = all;
                }
                field(section; REC.section)
                {
                    ApplicationArea = all;
                }
                field("Montant retenu caisse FS"; REC."Montant retenu caisse FS")
                {
                    ApplicationArea = all;
                }
                field("Montant Congé de maladie"; REC."Montant Congé de maladie")
                {
                    ApplicationArea = all;
                }
                field("Montant accident de travail"; REC."Montant accident de travail")
                {
                    ApplicationArea = all;
                }
                field("Montant Jours Fériés travaillé"; REC."Montant Jours Fériés travaillé")
                {
                    ApplicationArea = all;
                }
                // field("Base RCGC"; REC."Base RCGC")
                // {
                //     ApplicationArea = all;
                // }
                // field("Retenue CGC"; REC."Retenue CGC")
                // {
                //     ApplicationArea = all;
                // }
                field("Nombre de jours"; REC."Nombre de jours")
                {
                    ApplicationArea = all;
                }
                // field("NB Mois Gratif"; REC."NB Mois Gratif")
                // {
                //     ApplicationArea = all;
                // }
                // field(Control1000000155; REC.RIB)
                // {
                //     ApplicationArea = all;
                // }
                // field(Affectation; REC.Affectation)
                // {
                //     ApplicationArea = all;
                // }
                // field(Qualification; REC.Qualification)
                // {
                //     ApplicationArea = all;
                // }
                // field("Jours Deplacements"; REC."Jours Deplacements")
                // {
                //     ApplicationArea = all;
                // }
                // field(Rappel; REC.Rappel)
                // {
                //     ApplicationArea = all;
                // }
                // field(Retenu; REC.Retenu)
                // {
                //     ApplicationArea = all;
                // }
                // field(Cession; REC.Cession)
                // {
                //     ApplicationArea = all;
                // }
                // field("Credit Habitat"; REC."Credit Habitat")
                // {
                //     ApplicationArea = all;
                // }
                field("Site de travail"; REC."Site de travail")
                {
                    ApplicationArea = all;
                }
                field(Imposable; REC.Imposable)
                {
                    ApplicationArea = all;
                }
                // field("Taxe Redevance"; REC."Taxe Redevance")
                // {
                //     ApplicationArea = all;
                // }
                // field(Kilometrage; REC.Kilometrage)
                // {
                //     ApplicationArea = all;
                // }
                // field("Lot Virement Salaire"; REC."Lot Virement Salaire")
                // {
                //     ApplicationArea = all;
                // }
                // field("Code Banque Virement"; REC."Code Banque Virement")
                // {
                //     ApplicationArea = all;
                // }
                // field("Inserer Lot Virement"; REC."Inserer Lot Virement")
                // {
                //     ApplicationArea = all;
                // }
                // field("Ordre Virement Salaire"; REC."Ordre Virement Salaire")
                // {
                //     ApplicationArea = all;
                // }
                field(Trimestre; REC.Trimestre)
                {
                    ApplicationArea = all;
                }
                field("Ajout  en +"; REC."Ajout  en +")
                {
                    ApplicationArea = all;
                }
                field("Report en -"; REC."Report en -")
                {
                    ApplicationArea = all;
                }
                field("Statistics Group Code"; REC."Statistics Group Code")
                {
                    ApplicationArea = all;
                }
                field("Employee's Type Contrat"; REC."Employee's Type Contrat")
                {
                    ApplicationArea = all;
                }
                field("Num CNSS"; REC."Num CNSS")
                {
                    ApplicationArea = all;
                }
                field("Num CIN"; REC."Num CIN")
                {
                    ApplicationArea = all;
                }
                field("Code Mode Réglement"; REC."Code Mode Réglement")
                {
                    ApplicationArea = all;
                }
                // field("Type Contrat Employee"; REC."Type Contrat Employee")
                // {
                //     ApplicationArea = all;
                // }
                // field("Droit Acquis Par Ancienneté"; REC."Droit Acquis Par Ancienneté")
                // {
                //     ApplicationArea = all;
                // }
                // field(Conducteur; REC.Conducteur)
                // {
                //     ApplicationArea = all;
                // }
                // field(Chantier; REC.Chantier)
                // {
                //     ApplicationArea = all;
                // }
                // field("Salaire Net sur fiche"; REC."Salaire Net sur fiche")
                // {
                //     ApplicationArea = all;
                // }
                field("User ID"; REC."User ID")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; REC."Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; REC."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Heure Jours Free"; REC."Heure Jours Free")
                {
                    ApplicationArea = all;
                }
                field(Quinzainea; REC.Quinzainea)
                {
                    ApplicationArea = all;
                }
                field(Charge; REC.Charge)
                {
                    ApplicationArea = all;
                }
                field("droit de congé du mois"; REC."droit de congé du mois")
                {
                    ApplicationArea = all;
                }
                field("Salaire Impos. Ann. Conge"; REC."Salaire Impos. Ann. Conge")
                {
                    ApplicationArea = all;
                }
                field("Taux Tranche Impos. Conge"; REC."Taux Tranche Impos. Conge")
                {
                    ApplicationArea = all;
                }
                field("Paied days"; REC."Paied days")
                {
                    ApplicationArea = all;
                }
                field("Compte Bancaire Societe"; REC."Compte Bancaire Societe")
                {
                    ApplicationArea = all;
                }
                field("Droit de congé ancienneté"; REC."Droit de congé ancienneté")
                {
                    ApplicationArea = all;
                }
                field("Code grille de salaire"; REC."Code grille de salaire")
                {
                    ApplicationArea = all;
                }
                field("Catégorie"; REC.Catégorie)
                {
                    ApplicationArea = all;
                }
                field(Echellon; REC.Echellon)
                {
                    ApplicationArea = all;
                }
                field("salaire de base grille"; REC."salaire de base grille")
                {
                    ApplicationArea = all;
                }
                field("Montant Heures"; REC."Montant Heures")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

