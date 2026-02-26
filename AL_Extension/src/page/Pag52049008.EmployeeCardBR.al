// page 52049008 "Employee Card BR"
// {
//     //GL2024  ID dans Nav 2009 : "39001536"
//     Caption = 'Fiche salarié BR';
//     SourceTable = Employee;
//     SourceTableView = WHERE(BR = CONST(true));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     PageType = Card;
//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Editable = EditablePage;
//                 Caption = 'General';
//                 field(Matricule; rec."No.")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit() THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field("<Nom Et Prénom>"; rec."First Name")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Date de naissance1>"; rec."Birth Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Lieu de Naissance1"; rec."Birth place A")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Sexe>"; rec.Gender)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Sexe';
//                 }
//                 field("<Chef de famille1>"; rec."Familly chief")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Situation de famille A1>"; rec."Marital Status")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Situation de famille A';
//                 }
//                 field("Dédut Enfant à charge"; rec."Deduction Loaded child")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Enfants à charge1>"; rec."Loaded childs")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Nombre Enfant1>"; rec."Nombre Enfant")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nombre Enfant';
//                 }
//                 field("<Adresse>"; rec.Address)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<N° téléphone mobile1>"; rec."Mobile Phone No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<N° CIN1>"; rec."N° CIN")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'N° CIN';
//                 }
//                 field("<Délivrée le1>"; rec."Délivrée le")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Délivrée le';
//                 }
//                 field("N ° CNSS1"; rec."Social Security No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Bloqué>"; rec.Blocked)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Motif STC>"; rec."Motif STC")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Motif STC';
//                 }
//                 field("<BR>"; rec.BR)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'BR';
//                 }
//                 field("<Code STC>"; rec."Code STC")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code STC';
//                 }
//                 field("<RIB>"; rec.RIB)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'RIB';
//                 }
//                 field("Catégorie1"; rec.Collège)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Taux; rec."Basis salary")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salaire Base Horaire"; rec."Salaire De Base Horaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Total Indemnités1"; rec."Total Indemnité Par Defaut")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salaire Brut1"; SalaireBrut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salaire Net Simulé"; rec."Salaire Net Simulé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Date Creation>"; rec."Date Creation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Creation';
//                 }
//             }
//             group(Communication)
//             {
//                 Editable = EditablePage;
//                 Caption = 'Communication';
//                 field("<N° téléphone mobile>"; rec."Mobile Phone No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Pager>"; rec.Pager)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<N° téléphone>"; rec."Phone No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<E-mail>"; rec."E-Mail")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Prime BR1>"; rec."Prime BR")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prime BR';
//                 }
//                 field("<Code adresse secondaire>"; rec."Alt. Address Code")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Administration)
//             {
//                 Editable = EditablePage;
//                 Caption = 'Administration';
//                 field("<Statut>"; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Relation de travail>"; rec."Relation de travail")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Relation de travail';
//                 }
//                 field("<Type salarié>"; rec."Employee's type")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Date d'entrée>"; rec."Employment Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Code contrat de travail>"; rec."Emplymt. Contract Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Employee's Type Contrat>"; rec."Employee's Type Contrat")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Employee''s Type Contrat';
//                 }
//                 field("<date debut contrat>"; rec."date debut contrat")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'date debut contrat';
//                 }
//                 field("<Date fin de contrat>"; rec."Termination Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Nombre de contrat>"; rec."Nombre de contrat")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Nombre de contrat';
//                 }
//                 field("<Code motif fin de contrat>"; rec."Grounds for Term. Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Date indisponibilité>"; rec."Inactive Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Code motif indisponibilité>"; rec."Cause of Inactivity Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 label(Affectation)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Affectation';
//                 }
//                 field("Groupe compta salarié"; rec."Employee Posting Group")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Groupe compta. salarié DESC>"; rec."Employee Posting Group DESC")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Affectation>"; rec.Affectation)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Affectation';
//                 }
//                 field("<Deccription Affectation>"; rec."Deccription Affectation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Deccription Affectation';
//                 }
//                 field("Type Affectation"; rec."Type Affectation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Type Affectation';
//                 }
//                 field("<Description Type Affectation>"; rec."Description Type Affectation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Description Type Affectation';
//                 }
//                 field("<Qualification>"; rec.Qualification)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Qualification';
//                 }
//                 field("<Description Qualification>"; rec."Description Qualification")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Description Qualification';
//                 }
//                 field("<Groupe Qualification>"; rec."Groupe Qualification")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Groupe Qualification';
//                 }
//                 field("<Description Group Qualif>"; rec."Description Group Qualif")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Description Group Qualif';
//                 }
//             }
//             group(Paiement)
//             {
//                 Editable = EditablePage;
//                 Caption = 'Paiment';
//                 field("Catégorie"; rec.Collège)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Entreé En Vigueur"; rec."Entry date Cat/Echelon")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salaire de base / Taux H."; rec."Basis salary")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Salaire De Base Horaire>"; rec."Salaire De Base Horaire")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Salaire De Base Horaire';
//                 }
//                 field("<Date de passage Cat/Echelon>"; rec."Upgrading date Cat/Echelon")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Prime BR>"; rec."Prime BR")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Prime BR';
//                 }
//                 field("<Base Heure Sup>"; rec."Base Heure Sup")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Base Heure Sup';
//                 }
//                 field("Total Indemnités"; rec."Total Indemnité Par Defaut")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Salaire Brut"; SalaireBrut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Salaire Net Simulé>"; rec."Salaire Net Simulé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Salaire Net Simulé';
//                 }
//                 field("Hors Grille"; rec."Hors Grille")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Mode de règlement>"; rec."Mode de règlement")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mode de règlement';
//                 }
//                 field("<Domiciliation bancaire>"; rec."Domiciliation bancaire")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Domiciliation bancaire';
//                 }
//                 field("<Date de domiciliation>"; rec."Date de domiciliation")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date de domiciliation';
//                 }
//                 field("<Compte bancaire par défaut>"; rec."Default Bank Account Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Compte Bancaire Societe>"; rec."Compte Bancaire Societe")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Compte Bancaire Societe';
//                 }
//             }
//             group(Personnel)
//             {
//                 Editable = EditablePage;
//                 Caption = 'Personnel';
//                 group(Identification)
//                 {

//                     field("<N° Passeport>"; rec."N° Passeport")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'N° Passeport';
//                     }
//                     field("N ° CNSS"; rec."Social Security No.")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Délivrée le>"; rec."Délivrée le")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Délivrée le';
//                     }
//                     field("<N° CIN>"; rec."N° CIN")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'N° CIN';
//                     }
//                     field("<Date de naissance>"; rec."Birth Date")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Carte Séjour>"; rec."Carte Séjour")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Carte Séjour';
//                     }
//                     field("<Identification>"; rec."Délivrée le")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Identification';
//                     }
//                     field("<Nationalité>"; rec.Nationalité)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Nationalité';
//                     }
//                     field("Lieu de Naissance"; rec."Birth place A")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Lieu de Naissance';
//                     }
//                 }
//                 group("Situation familiale")
//                 {

//                     field("<Chef de famille>"; rec."Familly chief")
//                     {
//                         ApplicationArea = all;
//                     }
//                     label("Vérifié !!!!")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Vérifié !!!!';
//                     }
//                     field("<Situation de famille A>"; rec."Marital Status")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Déduction Enfant à charge>"; rec."Deduction Loaded child")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Enfants à charge>"; rec."Loaded childs")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Nombre Enfant>"; rec."Nombre Enfant")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Nombre Enfant';
//                     }
//                     field("<Nom Conjoint>"; rec."Nom Conjoint")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Nom Conjoint';
//                     }
//                 }
//             }
//             group(Statistiques)
//             {
//                 Editable = EditablePage;
//                 Caption = 'Statistiques';
//                 group("Absences && Congés")
//                 {
//                     Caption = 'Absences && Days off';

//                     field("<Contrôle1102752035>"; DATE2DMY(WORKDATE, 3) - 1)
//                     {
//                         ApplicationArea = all;
//                         ShowCaption = false;
//                         Style = StandardAccent;
//                     }
//                     field("<JT d'absence non payées1>"; NonPayed[1])
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Non paid days';
//                     }
//                     field("<Droit congé>"; DroitCong[1])
//                     {
//                         Caption = 'Day off Right';
//                     }
//                     field("<Consommation congé1>"; ConSCong[1])
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Day off consumed';
//                     }
//                     field("Solde jours de congés1"; SoldeCong[1])
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Days off remaining';
//                     }
//                     field("<Contrôle1102752036>"; DATE2DMY(WORKDATE, 3))
//                     {
//                         ApplicationArea = all;
//                         ShowCaption = false;
//                         Style = StandardAccent;
//                     }
//                     field("<JT d'absence non payées>"; NonPayed[2])
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Non paid days';
//                     }
//                     field("<Droit congé1>"; DroitCong[2])
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Day off Right';
//                     }
//                     field("<Consommation congé>"; ConSCong[2])
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Day off consumed';
//                     }
//                     field("Solde jours de congés"; SoldeCong[2])
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Days off remaining';
//                     }
//                 }
//                 group(Recuperation)
//                 {

//                     field("<Droit de Jours Recup.>"; rec."Days off + Recup")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Jour Recup Consomation>"; rec."Days off  Recup-")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Solde de Jours Recup.>"; rec."Days off = Recup")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("<Note>"; rec.Note)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Note';
//                     }
//                 }
//             }
//             group("Prét Et Avance")
//             {
//                 Editable = EditablePage;
//                 Caption = 'Prét Et Avance';

//                 label("Solde Salarié")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Solde Prêts>"; rec."Loans balance")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Solde Avances>"; rec."Advances balance")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Historique contrat de travail")
//             {
//                 Editable = EditablePage;
//                 part(HISTORIQE; "Liste Hist contrat de travail")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = Code = FIELD("Emplymt. Contract Code");
//                 }
//             }
//             group("Indemnité")
//             {
//                 Editable = EditablePage;

//                 part("Employment Contracts List Ind"; "Employment Contracts List Ind")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Employment Contract Code" = FIELD("Emplymt. Contract Code");
//                 }
//             }
//             group("Cotisation Social")
//             {
//                 Editable = EditablePage;
//                 part("Employment Contracts List Cot"; "Employment Contracts List Cot")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Employment Contract Code" = FIELD("Emplymt. Contract Code");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group(Fonctions1)
//             {
//                 Caption = 'Functions';

//                 actionref("Calcul Paie Inverse1"; "Calcul Paie Inverse") { }

//                 group("Export vers Word1")
//                 {
//                     Caption = 'Export vers Word';

//                     group("Attestation de travai1l")
//                     {

//                         Caption = 'Attestation de travail';

//                         actionref(Depuis1; Depuis) { }
//                         actionref("Périod1e"; "Période") { }
//                     }
//                     actionref("Cértificat de travail1"; "Cértificat de travail") { }
//                 }
//                 actionref("Archiver contrat de travail1"; "Archiver contrat de travail") { }
//                 actionref("Modifier Fiche1"; "Modifier Fiche") { }
//                 actionref("Calcul Paie Inverse En Lot1"; "Calcul Paie Inverse En Lot")
//                 {
//                     Visible = false;
//                 }
//             }





//             group("&Salarié1")
//             {
//                 Caption = 'E&mployee';

//                 actionref("Co&mmentaires1"; "Co&mmentaires") { }
//                 actionref("A&xes analytiques1"; "A&xes analytiques") { }
//                 actionref("Ima&ge1"; "Ima&ge") { }
//                 actionref("Adresses secondaires1"; "Adresses secondaires") { }
//                 actionref("Lien&s de parenté1"; "Lien&s de parenté") { }
//                 actionref("Categorie Employée1"; "Categorie Employée") { }
//                 actionref("Informations &objets confiés1"; "Informations &objets confiés") { }
//                 actionref("Informations confidentielles1"; "Informations confidentielles") { }
//                 actionref(Qualifications1; Qualifications) { }

//                 group("A&bsences1")
//                 {

//                     Caption = 'A&bsences';

//                     actionref("En cours1"; "En cours") { }
//                     actionref("Validées1"; "Validées") { }

//                     actionref("Détail de consommation congé1"; "Détail de consommation congé") { }

//                 }
//                 actionref("Détail objets confiés1"; "Détail objets confiés") { }
//                 //GL2024    actionref("Détail i&nformations confidentielles1"; "Détail i&nformations confidentielles") { }
//                 actionref("Comptes &bancaires1"; "Comptes &bancaires") { }
//                 actionref("Contrat de travail1"; "Contrat de travail") { }
//                 actionref("Contrat de travail archivé1"; "Contrat de travail archivé") { }
//                 actionref("Salaires enreg.1"; "Salaires enreg.") { }
//                 actionref(Calendrier1; Calendrier) { }

//                 group("Engagements Salariée encours1")
//                 {

//                     Caption = 'Engagements Salariée encours';
//                     actionref("Prêts11"; "Prêts1") { }
//                     actionref(Avances11; Avances1) { }
//                 }

//                 group("Engagements Clôturer1")
//                 {

//                     Caption = 'Engagements Clôturer';
//                     actionref("Prêts2"; "Prêts") { }
//                     actionref(Avances2; Avances) { }
//                 }

//             }
//         }
//         area(processing)
//         {
//             group(Fonctions)
//             {
//                 Caption = 'Functions';
//                 action("Calcul Paie Inverse")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAction()
//                     begin
//                         SalaryLine.SETRANGE("No.", 'SIMULATION');
//                         SalaryLine.SETRANGE(Employee, rec."No.");
//                         IF SalaryLine.FIND('-') THEN
//                             MngtSalary.DeleteLine(SalaryLine);

//                         MngtSalary.CréerSimulationPaie(Rec);
//                         COMMIT;
//                         IF contrat.GET(rec."No.") THEN;
//                         IF regimeofwork.GET(contrat."Regimes of work") THEN;
//                         SalaryLine.SETRANGE("No.", 'SIMULATION');
//                         SalaryLine.SETRANGE(Employee, rec."No.");
//                         IF SalaryLine.FIND('-') THEN BEGIN
//                             IF SalaryLine."Employee's type" = 0 THEN BEGIN
//                                 SalaryLine."Worked hours" := regimeofwork."Work Hours per month";
//                                 SalaryLine."Basis salary" := rec."Basis salary" * regimeofwork."Work Hours per month";
//                                 SalaryLine."Employee's type" := 1;
//                                 SalaryLine."Worked hours" := regimeofwork."Work Hours per month";
//                                 MngtSalary.CalculerLigneSalaire(SalaryLine, FALSE, 0, 0, FALSE);

//                                 IF RecEmployee.GET(rec."No.") THEN BEGIN
//                                     RecEmployee."Salaire Net Simulé" := SalaryLine."Net salary";
//                                     RecEmployee.MODIFY;
//                                 END;

//                             END;
//                             page.RUN(page::"Employee : Salary calculation", SalaryLine);
//                         END;
//                     end;
//                 }
//                 separator(separator25)
//                 {
//                 }
//                 group("Export vers Word")
//                 {
//                     Caption = 'Export vers Word';

//                     group("Attestation de travail")
//                     {

//                         Caption = 'Attestation de travail';
//                         action(Depuis)
//                         {

//                             trigger OnAction()
//                             begin
//                                 CLEAR(Dot);
//                                 Dot.AttestationDepuis(Rec);
//                             end;
//                         }
//                         action("Période")
//                         {
//                             ApplicationArea = all;

//                             trigger OnAction()
//                             begin
//                                 CLEAR(Dot);
//                                 Dot.AttestationPeriode(Rec)
//                             end;
//                         }
//                     }
//                     action("Cértificat de travail")
//                     {
//                         ApplicationArea = all;

//                         trigger OnAction()
//                         begin
//                             CLEAR(Dot);
//                             Dot.CertifDeTravail(Rec)
//                         end;
//                     }
//                 }

//                 action("Archiver contrat de travail")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAction()
//                     var
//                         RecGEmployee: Record Employee;
//                         RecGEmploymentContract: Record "Employment Contract";
//                         RecGDefaultIndemnity: Record "Default Indemnities";
//                         RecGDefaultSocialCont: Record "Default Soc. Contribution";
//                         RecGHistoriqueContratTravail: Record "Historique contrat de travail";
//                         RecLHisrtDefaultindemties: Record "Hist. Default Indemnities";
//                         RecHistDefaultSocialCont: Record "Hist. Soc. Contribution";
//                     begin

//                         //>>DSFT AGA 25/03/2010
//                         RecGEmploymentContract.GET(rec."Emplymt. Contract Code");
//                         RecGHistoriqueContratTravail.SETFILTER(Code, rec."Emplymt. Contract Code");
//                         IF RecGHistoriqueContratTravail.FIND('+') THEN
//                             RecGHistoriqueContratTravail."Code contrat archivé" := RecGHistoriqueContratTravail."Code contrat archivé" + 10000
//                         ELSE
//                             RecGHistoriqueContratTravail."Code contrat archivé" := 10000;
//                         RecGHistoriqueContratTravail.INIT;
//                         RecGHistoriqueContratTravail.Code := RecGEmploymentContract.Code;
//                         RecGHistoriqueContratTravail.Description := RecGEmploymentContract.Description;
//                         RecGHistoriqueContratTravail."Job Title" := rec."Job Title";
//                         RecGHistoriqueContratTravail.Address := rec.Address;
//                         RecGHistoriqueContratTravail.City := rec.City;
//                         RecGHistoriqueContratTravail."Phone No." := rec."Phone No.";
//                         RecGHistoriqueContratTravail."Social Security No." := rec."Social Security No.";
//                         RecGHistoriqueContratTravail.Sex := rec.Gender;
//                         RecGHistoriqueContratTravail."Statistics Group Code" := rec."Statistics Group Code";
//                         RecGHistoriqueContratTravail."Employment Date" := rec."Employment Date";
//                         RecGHistoriqueContratTravail.Status := rec.Status;
//                         RecGHistoriqueContratTravail."Inactive Date" := rec."Inactive Date";
//                         RecGHistoriqueContratTravail."Cause of Inactivity Code" := rec."Cause of Inactivity Code";
//                         RecGHistoriqueContratTravail."Termination Date" := rec."Termination Date";
//                         RecGHistoriqueContratTravail."Grounds for Term. Code" := rec."Grounds for Term. Code";
//                         RecGHistoriqueContratTravail."Family Situation A" := rec."Marital Status";
//                         RecGHistoriqueContratTravail."Relation de travail" := rec."Relation de travail";
//                         RecGHistoriqueContratTravail."Employee's type Contrat" := RecGEmploymentContract."Employee's type Contrat";
//                         RecGHistoriqueContratTravail.Spécialité := rec.Spécialité;
//                         RecGHistoriqueContratTravail."date debut contrat" := rec."date debut contrat";
//                         RecGHistoriqueContratTravail.Nationalité := rec.Nationalité;
//                         RecGHistoriqueContratTravail."Hors Grille" := rec."Hors Grille";
//                         RecGHistoriqueContratTravail."Regular payments" := RecGEmploymentContract."Regular payments";
//                         RecGHistoriqueContratTravail."Temporary payments" := RecGEmploymentContract."Temporary payments";
//                         RecGHistoriqueContratTravail."Adjust indemnity amount" := RecGEmploymentContract."Adjust indemnity amount";
//                         RecGHistoriqueContratTravail."Regimes of work" := RecGEmploymentContract."Regimes of work";
//                         RecGHistoriqueContratTravail."Salary grid" := RecGEmploymentContract."Salary grid";
//                         RecGHistoriqueContratTravail.Taxable := RecGEmploymentContract.Taxable;
//                         RecGHistoriqueContratTravail."Take in account deductions" := RecGEmploymentContract."Take in account deductions";
//                         RecGHistoriqueContratTravail."Calculation mode of the taxes" := RecGEmploymentContract."Calculation mode of the taxes";
//                         RecGHistoriqueContratTravail."Inclusive ratio" := RecGEmploymentContract."Inclusive ratio";
//                         RecGHistoriqueContratTravail.Grade := rec.Grade;
//                         //RecGHistoriqueContratTravail.Echelle:=Echelle;
//                         RecGHistoriqueContratTravail.Classe := rec.Classe;
//                         RecGHistoriqueContratTravail."Type Calendar" := RecGEmploymentContract."Type Calendar";
//                         RecGHistoriqueContratTravail."Code Calendar" := RecGEmploymentContract."Code Calendar";
//                         RecGHistoriqueContratTravail."Appliquer Heure Supp" := RecGEmploymentContract."Appliquer Heure Supp";
//                         RecGHistoriqueContratTravail.Note := rec.Note;
//                         RecGHistoriqueContratTravail."Gross Salary" := rec."Indemnité imposable";
//                         RecGHistoriqueContratTravail."Basis salary" := rec."Basis salary";
//                         RecGHistoriqueContratTravail."National Identity Card No." := rec."National Identity Card No.";
//                         RecGHistoriqueContratTravail."Employee Posting Group" := rec."Employee Posting Group";
//                         RecGHistoriqueContratTravail.Collège := rec.Collège;
//                         //RecGHistoriqueContratTravail.Echelon:=Echelons;
//                         RecGHistoriqueContratTravail."Entry date Cat/Echelon" := rec."Entry date Cat/Echelon";
//                         RecGHistoriqueContratTravail."Upgrading date Cat/Echelon" := rec."Upgrading date Cat/Echelon";
//                         RecGHistoriqueContratTravail."Loaded childs" := rec."Loaded childs";
//                         RecGHistoriqueContratTravail."Days off -" := rec."Days off -";
//                         RecGHistoriqueContratTravail."Days off +" := rec."Days off +";
//                         RecGHistoriqueContratTravail."Days off =" := rec."Days off =";
//                         RecGHistoriqueContratTravail."Date denier passage Cat/ech" := rec."Date denier passage Cat/ech";
//                         RecGHistoriqueContratTravail.INSERT;

//                         //>> DSFT AGA 25/03/2010
//                         // Achive indemnité
//                         RecGDefaultIndemnity.SETFILTER("Employment Contract Code", rec."Emplymt. Contract Code");
//                         IF RecGDefaultIndemnity.FIND('-') THEN
//                             REPEAT
//                                 RecLHisrtDefaultindemties.TRANSFERFIELDS(RecGDefaultIndemnity);
//                                 RecLHisrtDefaultindemties."Code contrat archivé" := RecGHistoriqueContratTravail."Code contrat archivé";
//                                 RecLHisrtDefaultindemties.INSERT;
//                             UNTIL RecGDefaultIndemnity.NEXT = 0;

//                         RecGDefaultSocialCont.SETFILTER("Employment Contract Code", rec."Emplymt. Contract Code");
//                         IF RecGDefaultSocialCont.FIND('-') THEN
//                             REPEAT
//                                 RecHistDefaultSocialCont.TRANSFERFIELDS(RecGDefaultSocialCont);
//                                 RecHistDefaultSocialCont."Code contrat archivé" := RecGHistoriqueContratTravail."Code contrat archivé";
//                                 RecHistDefaultSocialCont.INSERT;
//                             UNTIL RecGDefaultSocialCont.NEXT = 0;
//                         MESSAGE('Contrat de travail ' + FORMAT(rec."Emplymt. Contract Code") + ' Archivé avec succée');
//                     end;
//                 }
//                 action("Modifier Fiche")
//                 {
//                     ApplicationArea = all;
//                     ShortCutKey = 'Ctrl+M';

//                     trigger OnAction()
//                     begin
//                         //IF CduUserSetupManagement.GetAutorisationLancerDevis(UPPERCASE(USERID)) THEN
//                         IF RecUser.GET(USERID) THEN
//                             IF RecUser."Modif Salarie" THEN
//                                 EditablePage := TRUE;
//                         //CurrForm.EDITABLE:=TRUE;
//                     end;
//                 }
//                 action("Calcul Paie Inverse En Lot")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAction()
//                     begin
//                         IF RecEmployee.FINDFIRST THEN
//                             REPEAT
//                                 SalaryLine.SETRANGE("No.", 'SIMULATION');
//                                 SalaryLine.SETRANGE(Employee, RecEmployee."No.");
//                                 IF SalaryLine.FIND('-') THEN
//                                     MngtSalary.DeleteLine(SalaryLine);

//                                 MngtSalary.CréerSimulationPaie(RecEmployee);
//                                 COMMIT;
//                                 SalaryLine.SETRANGE("No.", 'SIMULATION');
//                                 SalaryLine.SETRANGE(Employee, RecEmployee."No.");
//                                 IF SalaryLine.FINDFIRST THEN;
//                                 RecEmployee."Salaire Net Simulé" := SalaryLine."Net salary";
//                                 RecEmployee.MODIFY;
//                             UNTIL RecEmployee.NEXT = 0;
//                         MESSAGE(Text001);
//                         EXIT;
//                     end;
//                 }
//             }
//             group("&Salarié")
//             {
//                 Caption = '&Salarié';
//                 // action(Lister)
//                 // {
//                 //     ApplicationArea = all;
//                 //     Caption = '&List';
//                 // }
//                 action("Co&mmentaires")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Co&mmentaires';
//                     RunObject = Page "Human Resource Comment Sheet";
//                     RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
//                 }
//                 action("A&xes analytiques")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'A&xes analytiques';
//                     RunObject = Page "Default Dimensions";
//                     RunPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
//                 }
//                 action("Ima&ge")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Ima&ge';
//                     RunObject = Page "Employee Picture";
//                     RunPageLink = "No." = FIELD("No.");
//                 }
//                 action("Adresses secondaires")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Adresses secondaires';
//                     RunObject = Page "Alternative Address Card";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Lien&s de parenté")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Lien&s de parenté';
//                     RunObject = Page "Employee Relatives";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Categorie Employée")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Categorie Employée';
//                     RunObject = page "Employee Categorie";
//                     RunPageLink = "No." = FIELD("No.");
//                 }
//                 action("Informations &objets confiés")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Informations &objets confiés';
//                     RunObject = Page "Misc. Article Information";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action("Informations confidentielles")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Informations confidentielles';
//                     RunObject = Page "Confidential Information";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 action(Qualifications)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Qualifications';
//                     RunObject = Page "Employee Qualifications";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 /* //GL3900    action("Historiques Carière")
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Historiques Carière';
//                        //GL3900    RunObject = page "Historique Transaction";
//                        //GL3900   RunPageLink = employee = FIELD("No.");
//                    }
//                    action("Ecriture Pointages")
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Ecriture Pointages';
//                        RunObject = Page "Autorisation Type Réglement";
//                        //GL2024  RunPageLink = Field4 = FIELD("No.");
//                        //GL2024  RunPageView = SORTING(Field4, "Type réglement");
//                    }*/
//                 separator(separator26)
//                 {
//                 }
//                 group("A&bsences")
//                 {

//                     Caption = 'A&bsences';

//                     action("En cours")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'En cours';
//                         RunObject = Page "Empl. Absences by Categories";
//                         RunPageLink = "No." = FIELD("No."), "Employee No. Filter" = FIELD("No.");
//                     }
//                     action("Validées")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Validées';
//                         RunObject = Page "Absence Overview by Categories";
//                         RunPageLink = "No." = FIELD("No.");
//                     }
//                     action("Détail de consommation congé")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Détail de consommation congé';
//                         RunObject = page "Detail consommation conge";
//                         RunPageLink = Salarié = FIELD("No.");
//                     }
//                 }
//                 action("Détail objets confiés")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Détail objets confiés';
//                     RunObject = Page "Misc. Articles Overview";
//                 }
//                 /*L2024  action("Détail i&nformations confidentielles")
//                   {
//                       ApplicationArea = all;
//                       Caption = 'Détail i&nformations confidentielles';
//                       RunObject = Page "Confidential Info. Overview";
//                   }*/
//                 separator(separator100)
//                 {
//                 }
//                 action("Comptes &bancaires")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comptes &bancaires';
//                     RunObject = page "Employee Bank Account Card";
//                     RunPageLink = "Employee No." = FIELD("No.");
//                 }
//                 separator(separator300)
//                 {
//                 }
//                 action("Contrat de travail")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Contrat de travail';
//                     RunObject = page "Employment Contract NE";
//                     RunPageLink = Code = FIELD("Emplymt. Contract Code");
//                 }
//                 action("Contrat de travail archivé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Contrat de travail archivé';

//                     trigger OnAction()
//                     begin

//                         CurrPAGE.HISTORIQE.PAGE.afficherencour
//                     end;
//                 }
//                 separator(separator27)
//                 {
//                 }
//                 action("Salaires enreg.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Salaires enreg.';
//                     RunObject = page "Recorded Payment lines";
//                     RunPageLink = Employee = FIELD("No.");
//                 }
//                 separator(separato8)
//                 {
//                 }
//                 action(Calendrier)
//                 {
//                     Caption = 'Calendrier';
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         //GL2024
//                         CLEAR(Calendform);
//                         Calendform.SetSalN(rec."No.");
//                         Calendform.RUNMODAL;

//                     end;
//                 }
//                 group("Engagements Salariée encours")
//                 {

//                     Caption = 'Engagements Salariée encours';

//                     action("Prêts1")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Prêts';
//                         RunObject = page "Loan & Advance Hdr";
//                         RunPageLink = Employee = FIELD("No.");
//                         RunPageView = SORTING(Employee, Type, "Status", "No.", "Avance Sur Prime") ORDER(Ascending) WHERE(Status = FILTER("In progress"), Type = FILTER(Loan));
//                     }
//                     action(Avances1)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Avances';
//                         RunObject = page "Loan & Advance Hdr";
//                         RunPageLink = Employee = FIELD("No.");
//                         RunPageView = SORTING(Employee, Type, "Status", "No.", "Avance Sur Prime") ORDER(Ascending) WHERE(Status = FILTER("In progress"), Type = FILTER(Advance));
//                     }
//                 }
//                 group("Engagements Clôturer")
//                 {

//                     Caption = 'Engagements Clôturer';

//                     action("Prêts")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Prêts';
//                         RunObject = page "Loan & Advance Hdr";
//                         RunPageLink = Employee = FIELD("No.");
//                         RunPageView = SORTING(Employee, Type, "Status", "No.", "Avance Sur Prime") ORDER(Ascending) WHERE(Status = FILTER(Enclosed), Type = FILTER(Loan));
//                     }
//                     action(Avances)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Avances';
//                         RunObject = page "Loan & Advance Hdr";
//                         RunPageLink = Employee = FIELD("No.");
//                         RunPageView = SORTING(Employee, Type, "Status", "No.", "Avance Sur Prime") ORDER(Ascending) WHERE(Status = FILTER(Enclosed), Type = FILTER(Advance));
//                     }
//                 }



//                 action(Commentaires)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Commentaires';
//                     RunObject = Page "Human Resource Comment Sheet";
//                     RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
//                 }
//             }
//         }
//     }
//     trigger OnOpenPage()
//     begin
//         EditablePage := false;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         EditablePage := true;
//         rec.BR := true;

//     end;

//     var
//         Mail: Codeunit Mail;
//         MngtSalary: Codeunit "Management of salary";
//         SalaryLine: Record "Salary Lines";
//         PostCode: Record "Post Code";
//         CalendForm: page "Monthly Personal Calendar";
//         NonPayed: array[2] of Decimal;
//         DroitCong: array[2] of Decimal;
//         ConSCong: array[2] of Decimal;
//         i: Integer;
//         SoldeCong: array[2] of Decimal;
//         //GL2024  MemberOf: Record 2000000003;
//         Sal: Record Employee;
//         Dot: Codeunit Dots;
//         QualificationEmploye: Record "Employee Qualification";
//         FormListehistoriqueContrat: page "Liste Hist contrat de travail";
//         regimeofwork: record "Regimes of work";
//         contrat: Record "Employment Contract";
//         SetEditable: Boolean;
//         CduUserSetupManagement: Codeunit "User Setup Management";
//         RecUser: Record "User Setup";
//         SalaireBrut: Decimal;
//         Empl: Record Employee;
//         NonPayed1: array[3] of Decimal;
//         DroitCong1: array[3] of Decimal;
//         ConSCong1: array[3] of Decimal;
//         SoldeCong1: array[3] of Decimal;
//         RecDetailConge: Record "Detail de congé consommé";
//         DecResteCons: Decimal;
//         RecEmployee: Record Employee;
//         EmpCont: Record "Employment Contract";
//         RegWork: record "Regimes of work";
//         Text001: Label 'Tache Achevéé';
//         EditablePage: Boolean;
// }

