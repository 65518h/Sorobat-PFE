// page 52049026 "STC Enregistré All"
// {
//     //GL2024  ID dans Nav 2009 : "39001554"
//     Editable = false;
//     PageType = List;
//     SourceTable = "Rec. Salary Lines";
//     SourceTableView = where("No." = filter('STC*'));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'STC Enregistré All';
//     layout
//     {
//         area(content) 
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'N°';
//                 }
//                 field(Employee; Rec.Employee)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Salarié';
//                 }
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Motif STC"; Rec."Motif STC")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee Posting Group"; Rec."Employee Posting Group")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Regime of work"; Rec."Regime of work")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Bank Account Code"; Rec."Bank Account Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee's type"; Rec."Employee's type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Note; Rec.Note)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Pourcentage; Rec.Pourcentage)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mois travaillés"; Rec."Mois travaillés")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Month; Rec.Month)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Year; Rec.Year)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Quarter; Rec.Quarter)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Days off remaining"; Rec."Days off remaining")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Days off balacement"; Rec."Days off balacement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Absences; Rec.Absences)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Adjustment of absences"; Rec."Adjustment of absences")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Days off"; Rec."Days off")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Assiduity (Paid days)"; Rec."Assiduity (Paid days)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Assiduity (Worked days)"; Rec."Assiduity (Worked days)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Congé Pris"; Rec."Congé Pris")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Worked hours"; Rec."Worked hours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Basis hours"; Rec."Basis hours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Amount Days Off balacement"; Rec."Amount Days Off balacement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Assiduity (days off balacement"; Rec."Assiduity (days off balacement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Hours off Balacement"; Rec."Hours off Balacement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Basis salary"; Rec."Basis salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable indemnities"; Rec."Taxable indemnities")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Supp. hours"; Rec."Supp. hours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Real basis salary"; Rec."Real basis salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Gross Salary"; Rec."Gross Salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(CNSS; Rec.CNSS)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Gross Salary (sans Av)"; Rec."Gross Salary (sans Av)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Indm. Impo. (N. Déd. Cot. Sc)"; Rec."Indm. Impo. (N. Déd. Cot. Sc)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Gross Salary (sans Av) PR"; Rec."Gross Salary (sans Av) PR")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable salary"; Rec."Taxable salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Deduction Family chief"; Rec."Deduction Family chief")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Deduction Loaded child"; Rec."Deduction Loaded child")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Deduction Prof. expenses"; Rec."Deduction Prof. expenses")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Real taxable"; Rec."Real taxable")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Total taxable rec."; Rec."Total taxable rec.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Rec. payments"; Rec."Rec. payments")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Real taxable (Year)"; Rec."Real taxable (Year)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxe (Year)"; Rec."Taxe (Year)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Total taxes rec."; Rec."Total taxes rec.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxe (Month)"; Rec."Taxe (Month)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Non Taxable indemnities"; Rec."Non Taxable indemnities")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable Soc. Contrib."; Rec."Taxable Soc. Contrib.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Mission expenses"; Rec."Mission expenses")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Net salary"; Rec."Net salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Loans; Rec.Loans)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Advances; Rec.Advances)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Net salary cashed"; Rec."Net salary cashed")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global dimension 1"; Rec."Global dimension 1")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Global dimension 2"; Rec."Global dimension 2")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Gross Salary PR"; Rec."Gross Salary PR")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Non Taxable Soc. Contrib. PR"; Rec."Non Taxable Soc. Contrib. PR")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable indem. PR (Not Gross)"; Rec."Taxable indem. PR (Not Gross)")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxable salary PR"; Rec."Taxable salary PR")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("6 * SMIG"; Rec."6 * SMIG")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Type Prime"; Rec."Type Prime")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Heures consomation congé"; Rec."Heures consomation congé")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("year of Calculate"; Rec."year of Calculate")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Num Compte"; Rec."Num Compte")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Direction; Rec.Direction)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Service; Rec.Service)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(section; Rec.section)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant retenu caisse FS"; Rec."Montant retenu caisse FS")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant Congé de maladie"; Rec."Montant Congé de maladie")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant accident de travail"; Rec."Montant accident de travail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant Jours Fériés travaillé"; Rec."Montant Jours Fériés travaillé")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Base RCGC"; Rec."Base RCGC")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Retenue CGC"; Rec."Retenue CGC")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nombre de jours"; Rec."Nombre de jours")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("NB Mois Gratif"; Rec."NB Mois Gratif")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(RIB; Rec.RIB)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Affectation; Rec.Affectation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Description Affectation"; Rec."Description Affectation")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Qualification; Rec.Qualification)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Description Qualification"; Rec."Description Qualification")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Jours Deplacements"; Rec."Jours Deplacements")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Rappel; Rec.Rappel)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Retenu; Rec.Retenu)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Cession; Rec.Cession)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Credit Habitat"; Rec."Credit Habitat")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Site de travail"; Rec."Site de travail")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Imposable; Rec.Imposable)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taxe Redevance"; Rec."Taxe Redevance")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Kilometrage; Rec.Kilometrage)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Lot Virement Salaire"; Rec."Lot Virement Salaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Banque Virement"; Rec."Code Banque Virement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Inserer Lot Virement"; Rec."Inserer Lot Virement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Ordre Virement Salaire"; Rec."Ordre Virement Salaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Trimestre; Rec.Trimestre)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Ajout  en +"; Rec."Ajout  en +")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Report en -"; Rec."Report en -")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Statistics Group Code"; Rec."Statistics Group Code")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee's Type Contrat"; Rec."Employee's Type Contrat")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Num CNSS"; Rec."Num CNSS")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Num CIN"; Rec."Num CIN")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code Mode Réglement"; Rec."Code Mode Réglement")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Type Contrat Employee"; Rec."Type Contrat Employee")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Droit Acquis Par Ancienneté"; Rec."Droit Acquis Par Ancienneté")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Conducteur; Rec.Conducteur)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Chantier; Rec.Chantier)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Salaire Net sur fiche"; Rec."Salaire Net sur fiche")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("User ID"; Rec."User ID")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Last Date Modified"; Rec."Last Date Modified")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Heure Jours Free"; Rec."Heure Jours Free")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Quinzainea; Rec.Quinzainea)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Charge; Rec.Charge)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("droit de congé du mois"; Rec."droit de congé du mois")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Salaire Impos. Ann. Conge"; Rec."Salaire Impos. Ann. Conge")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Taux Tranche Impos. Conge"; Rec."Taux Tranche Impos. Conge")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Paied days"; Rec."Paied days")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Compte Bancaire Societe"; Rec."Compte Bancaire Societe")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Droit de congé ancienneté"; Rec."Droit de congé ancienneté")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code grille de salaire"; Rec."Code grille de salaire")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Catégorie"; Rec.Catégorie)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Echellon; Rec.Echellon)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("salaire de base grille"; Rec."salaire de base grille")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Montant Heures"; Rec."Montant Heures")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

