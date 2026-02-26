page 50339 "Liste Salarié BR"
{
    //GL2024 NEW PAGE
    Caption = 'Fiche salarié BR';
    SourceTable = Employee;
    SourceTableView = WHERE(BR = CONST(true));
    //ABZ ApplicationArea = all;
    UsageCategory = lists;
    PageType = List;
    //    CardPageID = "Employee Card BR";
    layout
    {
        area(content)
        {
            repeater(Control1180250000)
            {
                ShowCaption = false;
                Editable = false;
                Caption = 'General';

                field(Matricule; rec."No.")
                {
                    ApplicationArea = all;


                }
                field("Nom"; rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Prénom"; rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("Date de naissance1"; rec."Birth Date")
                {
                    ApplicationArea = all;
                }
                field("Lieu de Naissance1"; rec."Birth place A")
                {
                    ApplicationArea = all;
                }
                field("Sexe"; rec.Gender)
                {
                    ApplicationArea = all;
                    Caption = 'Sexe';
                }
                field("Chef de famille1"; rec."Familly chief")
                {
                    ApplicationArea = all;
                    Caption = 'Chef Famille';
                }
                field("Situation de famille A1"; rec."Marital Status")
                {
                    ApplicationArea = all;
                    Caption = 'Situation de famille A';
                }
                field("Dédut Enfant à charge"; rec."Deduction Loaded child")
                {
                    ApplicationArea = all;
                    Caption = 'Déduction Enfant à charge';
                }
                field("Enfants à charge1"; rec."Loaded childs")
                {
                    ApplicationArea = all;
                }
                // field("Nombre Enfant1"; rec."Nombre Enfant")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Nombre Enfant';
                // }
                field("Adresse"; rec.Address)
                {
                    ApplicationArea = all;
                }
                field("N° téléphone mobile1"; rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                }
                // field("N° CIN1"; rec."N° CIN")
                // {
                //     ApplicationArea = all;
                //     Caption = 'N° CIN';
                // }
                field("Délivrée le1"; rec."Délivrée le")
                {
                    ApplicationArea = all;
                    Caption = 'Délivrée le';
                }
                field("N ° CNSS1"; rec."Social Security No.")
                {
                    ApplicationArea = all;
                }
                field("Bloqué"; rec.Blocked)
                {
                    ApplicationArea = all;
                }
                // field("Motif STC"; rec."Motif STC")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Motif STC';
                // }
                field("BR"; rec.BR)
                {
                    ApplicationArea = all;
                    Caption = 'BR';
                }
                // field("Code STC"; rec."Code STC")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Code STC';
                // }
                field("RIB"; rec.RIB)
                {
                    Caption = 'RIB';
                }
                field("Catégorie1"; rec."Catégorie")
                {
                    Caption = 'Catégorie';
                    ApplicationArea = all;
                }
                field(Taux; rec."Basis salary")
                {
                    Caption = 'Taux';
                    ApplicationArea = all;
                }
                // field("Salaire Base Horaire"; rec."Salaire De Base Horaire")
                // {
                //     ApplicationArea = all;
                // }
                // field("Total Indemnités1"; rec."Total Indemnité Par Defaut")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Total Indemnité';
                // }

                field("Salaire Net Simulé"; rec."Salaire Net Simulé")
                {
                    ApplicationArea = all;
                }
                // field("Date Creation"; rec."Date Creation")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Date Creation';
                // }




                field("N° téléphone mobile"; rec."Mobile Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Pager"; rec.Pager)
                {
                    ApplicationArea = all;
                }
                field("N° téléphone"; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("E-mail"; rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                // field("Prime BR"; rec."Prime BR")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Prime BR';
                // }
                field("Code adresse secondaire"; rec."Alt. Address Code")
                {
                    ApplicationArea = all;
                }

                field("Statut"; rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Relation de travail"; rec."Relation de travail")
                {
                    ApplicationArea = all;
                    Caption = 'Relation de travail';
                }
                field("Type salarié"; rec."Employee's type")
                {
                    ApplicationArea = all;
                    Caption = 'Type Salarié';
                }
                field("Date d'entrée"; rec."Employment Date")
                {
                    ApplicationArea = all;
                    Caption = 'Date de Recrutement';
                }
                field("Code contrat de travail"; rec."Emplymt. Contract Code")
                {
                    ApplicationArea = all;
                    Caption = 'Contrat de travail';
                }
                field("Employee's Type Contrat"; rec."Employee's Type Contrat")
                {
                    ApplicationArea = all;
                    Caption = 'Type de contrat';
                }
                field("date debut contrat"; rec."date debut contrat")
                {
                    ApplicationArea = all;
                    Caption = 'date debut contrat';
                }
                field("Date fin de contrat"; rec."Termination Date")
                {
                    ApplicationArea = all;
                }
                field("Nombre de contrat"; rec."Nombre de contrat")
                {
                    ApplicationArea = all;
                    Caption = 'Nombre de contrat';
                }
                field("Code motif fin de contrat"; rec."Grounds for Term. Code")
                {
                    ApplicationArea = all;
                }
                field("Date indisponibilité"; rec."Inactive Date")
                {
                    ApplicationArea = all;
                }
                field("Code motif indisponibilité"; rec."Cause of Inactivity Code")
                {
                    ApplicationArea = all;
                }
                label(Affectation1)
                {
                    ApplicationArea = all;
                    Caption = 'Affectation';
                }
                field("Groupe compta salarié"; rec."Employee Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Groupe compta. salarié DESC"; rec."Employee Posting Group DESC")
                {
                    ApplicationArea = all;
                }
                // field("Affectation"; rec.Affectation)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Affectation';
                // }
                // field("Deccription Affectation"; rec."Deccription Affectation")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Deccription Affectation';
                // }
                // field("Type Affectation"; rec."Type Affectation")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Type Affectation';
                // }
                // field("Description Type Affectation"; rec."Description Type Affectation")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Description Type Affectation';
                // }
                // field("Qualification"; rec.Qualification)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Qualification';
                // }
                // field("Description Qualification"; rec."Description Qualification")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Description Qualification';
                // }
                // field("Groupe Qualification"; rec."Groupe Qualification")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Groupe Qualification';
                // }
                // field("Description Group Qualif"; rec."Description Group Qualif")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Description Group Qualif';
                // }


                // field("Catégorie"; rec.Collège)
                // {
                //     Caption = 'Catégorie';
                //     ApplicationArea = all;
                // }
                field("Date Entreé En Vigueur"; rec."Entry date Cat/Echelon")
                {
                    ApplicationArea = all;
                }
                field("Salaire de base / Taux H."; rec."Basis salary")
                {
                    ApplicationArea = all;
                    Caption = 'Salaire de base / Taux H.';
                }
                // field("Salaire De Base Horaire"; rec."Salaire De Base Horaire")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Salaire De Base Horaire';
                // }
                field("Date de passage Cat/Echelon"; rec."Upgrading date Cat/Echelon")
                {
                    ApplicationArea = all;
                }
                // field("Total Indemnités"; rec."Total Indemnité Par Defaut")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Total Indemnités';
                // }

                field("Salaire Net Simulé1"; rec."Salaire Net Simulé")
                {
                    ApplicationArea = all;
                    Caption = 'Salaire Net Simulé';
                }
                field("Hors Grille"; rec."Hors Grille")
                {
                    ApplicationArea = all;
                }
                field("Mode de règlement"; rec."Mode de règlement")
                {
                    ApplicationArea = all;
                    Caption = 'Mode de règlement';
                }
                field("Domiciliation bancaire"; rec."Domiciliation bancaire")
                {
                    ApplicationArea = all;
                    Caption = 'Domiciliation bancaire';
                }
                field("Date de domiciliation"; rec."Date de domiciliation")
                {
                    ApplicationArea = all;
                    Caption = 'Date de domiciliation';
                }
                field("Compte bancaire par défaut"; rec."Default Bank Account Code")
                {
                    ApplicationArea = all;
                }
                field("Compte Bancaire Societe"; rec."Compte Bancaire Societe")
                {
                    ApplicationArea = all;
                    Caption = 'Compte Bancaire Societe';
                }


                field("N° Passeport"; rec."N° Passeport")
                {
                    ApplicationArea = all;
                    Caption = 'N° Passeport';
                }
                field("N ° CNSS"; rec."Social Security No.")
                {
                    ApplicationArea = all;
                }
                field("Délivrée le"; rec."Délivrée le")
                {
                    ApplicationArea = all;
                    Caption = 'Délivrée le';
                }
                // field("N° CIN"; rec."N° CIN")
                // {
                //     ApplicationArea = all;
                //     Caption = 'N° CIN';
                // }
                field("Date de naissance"; rec."Birth Date")
                {
                    ApplicationArea = all;
                }
                field("Carte Séjour"; rec."Carte Séjour")
                {
                    ApplicationArea = all;
                    Caption = 'Carte Séjour';
                }
                field("Identification"; rec."Délivrée le")
                {
                    ApplicationArea = all;
                    Caption = 'Identification';
                }
                field("Nationalité"; rec.Nationalité)
                {
                    ApplicationArea = all;
                    Caption = 'Nationalité';
                }
                field("Lieu de Naissance"; rec."Birth place A")
                {
                    ApplicationArea = all;
                    Caption = 'Lieu de Naissance';
                }


                field("Chef de famille"; rec."Familly chief")
                {
                    ApplicationArea = all;
                }
                label("Vérifié !!!!")
                {
                    ApplicationArea = all;
                }
                field("Situation de famille A"; rec."Marital Status")
                {
                    ApplicationArea = all;
                }
                field("Déduction Enfant à charge"; rec."Deduction Loaded child")
                {
                    ApplicationArea = all;
                }
                field("Enfants à charge"; rec."Loaded childs")
                {
                    Caption = 'Enfants à charge';
                    ApplicationArea = all;
                }
                // field("Nombre Enfant"; rec."Nombre Enfant")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Nombre Enfant';
                // }
                field("Nom Conjoint"; rec."Nom Conjoint")
                {
                    ApplicationArea = all;
                    Caption = 'Nom Conjoint';
                }


                field("Contrôle1102752035"; DATE2DMY(WORKDATE, 3) - 1)
                {
                    ApplicationArea = all;
                    Caption = ' ';

                }


                field("Droit de Jours Recup."; rec."Days off + Recup")
                {
                    ApplicationArea = all;
                }
                field("Jour Recup Consomation"; rec."Days off  Recup-")
                {
                    ApplicationArea = all;
                }
                field("Solde de Jours Recup."; rec."Days off = Recup")
                {
                    ApplicationArea = all;
                }
                field("Note"; rec.Note)
                {
                    ApplicationArea = all;
                    Caption = 'Note';
                }



                field("Solde Prêts"; rec."Loans balance")
                {
                    ApplicationArea = all;
                }
                field("Solde Avances"; rec."Advances balance")
                {
                    ApplicationArea = all;
                }
            }




        }

    }






}

