PageExtension 50189 "Employee Card_PagEXT" extends "Employee Card"

{
    /* GL2024  SourceTableView = WHERE(Blocked = CONST(false),
                             BR = CONST(false));*/


    layout
    {

        modify("Statistics Group Code")
        {
            visible = false;
            Enabled = false;
        }
        addafter("Statistics Group Code")
        {

            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
                Style = Unfavorable;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
            }
            field("Global Dimension 1 desc"; Rec."Global Dimension 1 desc")
            {
                ApplicationArea = All;
                Style = Unfavorable;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
                ShowMandatory = true;
                Style = Unfavorable;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
            }
            field("Global Dimension 2 desc"; Rec."Global Dimension 2 desc")
            {
                ApplicationArea = All;
                Style = Unfavorable;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.', Comment = '%';
            }
        }
        modify(General)
        {
            Editable = SetEditable;
        }
        modify("Address & Contact")
        {
            Editable = SetEditable;
        }
        modify(Administration)
        {
            Editable = SetEditable;
        }
        modify(Personal)
        {
            Editable = SetEditable;
        }
        modify(Payments)
        {
            Editable = SetEditable;
            Visible = false;
        }
        // modify("Middle Name")
        // {
        //     Visible = false;
        // }
        // modify("Last Name")
        // {
        //     Visible = false;
        // }
        modify("First Name")
        {
            Caption = 'Nom Et Prénom';
            Style = Strong;
        }

        modify("Last Name")
        {
            Style = Strong;
        }
        modify(Initials)
        {
            Visible = false;
        }
        modify("Middle Name")
        {
            Visible = false;
            Style = Strong;
        }
        addbefore("First Name")
        {
            field(Fonction; rec.Fonction)
            {
                ApplicationArea = all;
            }
        }
        modify("Job Title")
        {
            Visible = false;
        }
        addafter("Last Name")
        {
            // field("Nom Salarier"; rec."Nom Salarier") 
            // {
            //     ApplicationArea = all;
            //     Caption = 'Nom';
            // }

            // field("Prénom Salarier"; rec."Prénom Salarier")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Prénom';
            // }
            field(Title; Rec.Title)
            {
                ApplicationArea = all;
            }
            field("Niveau D'Instruction"; rec."Niveau D'Instruction")
            {
                ApplicationArea = all;
            }
            field(Diplome; Rec.Diplome)
            {
                ApplicationArea = all;
            }
            field("Année Diplome"; rec."Année Diplome")
            {
                ApplicationArea = all;
            }

            field("Expérience Professionnelle"; rec."Expérience Professionnelle")
            {
                ApplicationArea = all;
            }
            field("Qualification Code"; rec."Qualification Code")
            {
                ApplicationArea = all;
            }


            // field("Country Code"; rec."Country Code")
            // {
            //     ApplicationArea = all;
            // }

            field("Heure Supp Sbase+Sursalaire"; rec."Heure Supp Sbase+Sursalaire")
            {
                ApplicationArea = all;
            }
            field("MO Attaché"; rec."MO Attaché")
            {
                ApplicationArea = all;
            }

            // field("Adresee Secondaire"; rec."Adresee Secondaire")
            // {
            //     ApplicationArea = all;
            // }
            // field("Description Service"; rec."Description Service")
            // {
            //     ApplicationArea = all;
            // }
            // // field("Departement Salarié"; rec."Departement Salarié")
            // // {
            // //     ApplicationArea = all;
            // // }
            // field("Description Section"; rec."Description Section")
            // {
            //     ApplicationArea = all;
            // }


            // field("Birth place A"; rec."Birth place A")
            // {
            //     ApplicationArea = all;
            // }
            // field("Familly chief"; rec."Familly chief")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Chef Famille';
            // }
            // // field("Nombre Enfant"; rec."Nombre Enfant")
            // // {
            // //     Editable = NombreEnfantEDITABLE;

            // //     ApplicationArea = all;
            // // }

            // field("Loaded childs"; rec."Loaded childs")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Enfants à charge';
            //     Editable = LoadedchildsEDITABLE;
            // }
            // field("Deduction Loaded child"; rec."Deduction Loaded child")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Déduction Enfant à charge';
            // }

        }
        modify("No.")
        {
            Caption = 'Matricule';
            Style = Attention;
            StyleExpr = true;
        }


        addafter("Privacy Blocked")
        {

            field(Blocked; rec.Blocked)
            {
                ApplicationArea = all;
            }
            // field(BR; rec.BR)
            // {
            //     ApplicationArea = all;
            // }




            // field("N° CIN"; rec."N° CIN")
            // {
            //     ApplicationArea = all;
            // }
            // field("Délivrée le"; rec."Délivrée le")
            // {
            //     ApplicationArea = all;
            // }
            // field("Exclu De Dec Trim CNSS"; rec."Exclu De Dec Trim CNSS")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
            // field("Declarer CNSS"; rec."Declarer CNSS")
            // {
            //     ApplicationArea = all;
            // }
            // field("Social Security No.2"; rec."Social Security No.")
            // {
            //     ApplicationArea = all;
            //     Caption = 'CNSS';
            // }
            // field(RIB; rec.RIB)
            // {
            //     ApplicationArea = all;
            // }
            // }
            // field("Banque Salarié"; rec."Banque Salarié")
            // {
            //     ApplicationArea = all;
            // }
            // field("Code Swift Banque"; rec."Code Swift Banque")
            // {
            //     ApplicationArea = all;
            // }

            // field("Motif STC"; rec."Motif STC")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            // field("Code STC"; rec."Code STC")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }



            /*  field("Basis salary"; rec."Basis salary")
              {
                  Caption = 'Taux';
                  ApplicationArea = all;
                  Style = Attention;
                  StyleExpr = true;

                  Editable = BasisSalaryEDITABLE;
              }*/
            // }
            // field("Salaire De Base Horaire"; rec."Salaire De Base Horaire")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            // field("Total Indemnité Par Defaut"; rec."Total Indemnité Par Defaut")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Total Indemnité';
            //     Editable = false;
            //     Style = Attention;
            //     StyleExpr = true;
            // }
            /*  field("Salaire Brut"; SalaireBrut)
              {
                  ApplicationArea = all;
                  Caption = 'Salaire Brut';
                  Editable = false;
                  Style = Attention;
                  StyleExpr = true;
              }*/

            // field("Moyenne 6 Der Sal Brut"; rec."Moyenne 6 Der Sal Brut")
            // {
            //     ApplicationArea = all;

            // }



            // field("N° CNPS"; rec."N° CNPS")
            // {
            //     ApplicationArea = all;
            // }
            // field("Birth Date"; rec."Birth Date")
            // {
            //     ApplicationArea = all;
            // }

            /*  field("Salaire Net Simulé"; rec."Salaire Net Simulé")
              {
                  ApplicationArea = all;
                  Editable = false;
                  Style = AttentionAccent;
              }*/
            // field("Date Creation"; rec."Date Creation")
            // {
            //     ApplicationArea = all;
            // }
            // field(Zone; rec.Zone)
            // {
            //     ApplicationArea = all;
            // }
            // field("Maitrisard cadre"; rec."Maitrisard cadre")
            // {
            //     ApplicationArea = all;
            // }
            // field(Horaire; rec.Horaire)
            // {
            //     ApplicationArea = all;
            // }
            // field("Diplôme Sal"; rec."Diplôme Sal")
            // {
            //     ApplicationArea = all;
            // }



            // field("Impot Simule"; rec."Impot Simule")
            // {
            //     ApplicationArea = all;
            //     Style = Attention;
            //     StyleExpr = true;
            // }



            // field(Approuvé; rec.Approuvé)
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            // field("Approuvé par"; rec."Approuvé par")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
            // field("Date Approbation"; rec."Date Approbation")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }



        }

        // addafter("E-Mail")
        // {
        //     field("Prime BR"; Rec."Prime BR")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        modify("Alt. Address Code")
        {
            Visible = false;
        }
        modify(Status)
        {
            Style = Attention;
            StyleExpr = true;
            Visible = false;
        }



        modify("Employment Date")
        {
            Visible = false;
        }
        addbefore("Employment Date")
        {
            field(Status1; Rec.Status)
            {
                Style = Attention;
                StyleExpr = true;
            }
        }

        addafter("Employment Date")
        {
            // field("Lieu Recrutement"; rec."Lieu Recrutement")
            // {
            //     ApplicationArea = all;
            // }
            field("Relation de travail"; rec."Relation de travail")
            {
                ApplicationArea = all;
                Style = Attention;
                StyleExpr = true;
            }
            field("Employee's type"; rec."Employee's type")
            {
                ApplicationArea = all;
                Caption = 'Type Salarié';
                Style = Attention;
                StyleExpr = true;
            }
            field("Employment Date1"; rec."Employment Date")

            {
                Caption = 'Date de recrutement';
            }


            field("Emplymt. Contract Code2"; rec."Emplymt. Contract Code")
            {
                Caption = 'Contrat de travail';
                Style = Attention;
                StyleExpr = true;
                ApplicationArea = all;
            }
            field("Employee's Type Contrat"; rec."Employee's Type Contrat")
            {
                ApplicationArea = all;
                Caption = 'Type de contrat';
            }

        }
        modify("Termination Date")
        {
            Style = Strong;
            StyleExpr = true;
        }
        addbefore("Termination Date")
        {
            field("date debut contrat"; rec."date debut contrat")
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = true;
            }
        }
        addafter("Termination Date")
        {

            field("Nombre de contrat"; rec."Nombre de contrat")
            {
                ApplicationArea = all;
                //GL3900  DrillDownPageID = "Historique Transaction";
                Editable = false;
                //GL3900  LookupPageID = "Historique Transaction";
            }




            // field("Date Validité Permis"; rec."Date Validité Permis")
            // {
            //     ApplicationArea = all;
            // }
            // field("Passeport EVAX"; rec."Passeport EVAX")
            // {
            //     ApplicationArea = all;
            // }
        }

        modify("Emplymt. Contract Code")
        {
            Caption = 'Contrat de travail';
            Visible = false;
        }


        modify("Grounds for Term. Code")
        {
            Style = Strong;
            StyleExpr = true;
        }
        modify("Inactive Date")
        {
            Style = Strong;
            StyleExpr = true;
        }
        addafter("Salespers./Purch. Code")
        {

            group(Affectation1)
            {
                Caption = 'Affectation';

                field("Employee Posting Group2"; rec."Employee Posting Group")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Employee Posting Group DESC"; rec."Employee Posting Group DESC")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Statistics Group Code1"; rec."Statistics Group Code")
                {
                    ApplicationArea = all;
                    Caption = 'Departement Salarié';
                    Style = Attention;
                    StyleExpr = true;

                }
                field("Statistic Gpe Descrip"; rec."Statistic Gpe Descrip")
                {
                    ApplicationArea = all;
                }

                field(Service; Rec.Service)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                    trigger OnValidate()
                    var
                        RecLStatisticGroup: Record "Employee Statistics Group";
                    begin
                        if RecLStatisticGroup.get(rec.service) and (rec.Service <> '') then begin
                            rec.Validate("Global Dimension 1 Code", RecLStatisticGroup."Global Dimension 1 Code");
                            rec.Validate("Global Dimension 2 Code", RecLStatisticGroup."Global Dimension 2 Code");
                        end;
                    end;

                }
                field("Description Service1"; Rec."Description Service")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;

                }
                field("Description Section1"; Rec."Description Section")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                // field(Affectation; rec.Affectation)
                // {
                //     ApplicationArea = all;
                // }
                // field("Deccription Affectation"; rec."Deccription Affectation")
                // {
                //     ApplicationArea = all;
                // }
                // field("Type Affectation"; rec."Type Affectation")
                // {
                //     ApplicationArea = all;
                // }
                // field("Description Type Affectation"; rec."Description Type Affectation")
                // {
                //     ApplicationArea = all;
                // }




                // field(Qualification; rec.Qualification)
                // {
                //     Editable = QualificationEDITABLE;
                //     ApplicationArea = all;
                // }
                // field("Description Qualification"; rec."Description Qualification")
                // {
                //     ApplicationArea = all;
                // }
                // field("Groupe Qualification"; rec."Groupe Qualification")
                // {
                //     ApplicationArea = all;
                // }
                // field("Description Group Qualif"; rec."Description Group Qualif")
                // {
                //     ApplicationArea = all;
                // }
                // field(Chantier; rec.Chantier)
                // {
                //     ApplicationArea = all;
                // }
            }


        }

        addafter(Administration)
        {
            group(Payment)
            {
                Caption = 'Paiement';
                Editable = SetEditable;


                // field("Collège2"; rec.Collège)
                // {
                //     Caption = 'Catégorie';
                //     ApplicationArea = all;
                //     Style = Attention;
                //     StyleExpr = true;
                // }
                field("Catégorie"; Rec."Catégorie")
                {
                    Style = Attention;
                    ApplicationArea = all;
                    StyleExpr = true;
                }
                field(Echelons; rec.Echelons)
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = true;
                    trigger OnValidate()
                    begin
                        rec.CALCFIELDS("Indemnité imposable");
                        rec.CALCFIELDS("Somme Indemnités");
                        SalaireBrut := rec."Somme Indemnités" + rec."Basis salary";
                    end;
                }
                field("Basis salary2"; rec."Basis salary")
                {
                    ApplicationArea = all;
                    Caption = 'Salaire de base';
                    Style = Attention;
                    Editable = false;
                    StyleExpr = true;
                }
                // }
                // field("Salaire De Base Horaire2"; rec."Salaire De Base Horaire")
                // {
                //     ApplicationArea = all;
                // }


                // field("Total Indemnité Par Defaut2"; rec."Total Indemnité Par Defaut")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Total Indemnité';
                //     Style = Attention;
                //     StyleExpr = true;
                //     Editable = false;
                // }
                field("Somme Indemnités"; Rec."Somme Indemnités")
                {
                    Style = Attention;
                    Caption = 'Total Indemnités';
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = true;
                }
                field(SalaireBrut; SalaireBrut)
                {
                    ApplicationArea = all;
                    Caption = 'Salaire Brut';
                    Style = Attention;
                    DecimalPlaces = 3 : 3;
                    StyleExpr = true;
                    Editable = false;
                }
                field("Salaire Net Contrat"; Rec."Salaire Net Contrat")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Salaire Net Contrat field.', Comment = '%';
                }
                field("Nombre de Charge1"; rec."Nombre de Charge")
                {
                    ApplicationArea = all;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Nombre Salaire Preavis"; rec."Nombre Salaire Preavis")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Moyenne 6 Dernier Salaire Brut"; rec."Moyenne 6 Dernier Salaire Brut")
                {
                    ApplicationArea = all;
                    Style = Favorable;
                    StyleExpr = true;

                }
                field("Montant Congé Payé"; rec."Montant Congé Payé")
                {

                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Nombre Mois Congé Payé"; Rec."Nombre Mois Congé Payé")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Salaire Net Simulé2"; rec."Salaire Net Simulé")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = true;
                    Editable = false;
                }
                field("Appliquer Retenue SNP"; Rec."Appliquer Retenue SNP")
                {
                    ApplicationArea = all;
                }
                field("Hors Grille"; Rec."Hors Grille")
                {
                    ApplicationArea = all;
                }

                // field("Total Indemnités"; rec."Total Indemnités")
                // {
                //     ApplicationArea = all;
                // }
                field("Entry date Cat/Echelon"; rec."Entry date Cat/Echelon")
                {
                    ApplicationArea = all;
                }
                field("Date denier passage Cat/ech"; rec."Date denier passage Cat/ech")
                {
                    ApplicationArea = all;
                }
                field("Upgrading date Cat/Echelon"; rec."Upgrading date Cat/Echelon")
                {
                    ApplicationArea = all;
                    Caption = 'Date passage Echelon';
                }


                // field("Impot Simule2"; rec."Impot Simule")
                // {
                //     Caption = 'Paiement';
                //     ApplicationArea = all;
                //     Style = Attention;
                //     StyleExpr = true;
                // }
                // field("Annee Rappel 1"; rec."Annee Rappel 1")
                // {
                //     ApplicationArea = all;
                // }
                // field("Montant Rappel 1"; rec."Montant Rappel 1")
                // {
                //     ApplicationArea = all;
                // }
                // field("Annee Rappel 2"; rec."Annee Rappel 2")
                // {
                //     ApplicationArea = all;
                // }
                // field("Montant Rappel 2"; rec."Montant Rappel 2")
                // {
                //     ApplicationArea = all;
                // }

                // field("Annee Anciennete"; rec."Annee Anciennete")
                // {
                //     ApplicationArea = all;
                // }
                // field("Jours Acquis"; rec."Jours Acquis")
                // {
                //     ApplicationArea = all;
                // }

                // field("Droit Acquis Ancienneté"; rec."Droit Acquis Ancienneté")
                // {
                //     ApplicationArea = all;
                // }


                field("Mode de règlement"; rec."Mode de règlement")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Num Mobile Money"; Rec."Num Mobile Money")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Num Mobile Money field.', Comment = '%';
                }
                field("Domiciliation bancaire"; rec."Domiciliation bancaire")
                {
                    ApplicationArea = all;
                }
                field("Date de domiciliation"; rec."Date de domiciliation")
                {
                    ApplicationArea = all;
                }

                field("Default Bank Account Code"; rec."Default Bank Account Code")
                {
                    ApplicationArea = all;
                }


                field("Compte Bancaire Societe"; rec."Compte Bancaire Societe")
                {
                    ApplicationArea = all;
                }
                // field("PC Portable"; rec."PC Portable")
                // {
                //     ApplicationArea = all;
                // }
                // field("Date Sortie PC Portable"; rec."Date Sortie PC Portable")
                // {
                //     ApplicationArea = all;
                // }


            }
        }
        modify("Social Security No.")
        {
            Caption = 'N° CNSS';
            Style = Strong;
            StyleExpr = true;

        }
        modify("Birth Date")
        {
            Style = Strong;
            StyleExpr = true;
        }

        addbefore("Birth Date")
        {
            field("N° Passeport"; Rec."N° Passeport")
            {
                ApplicationArea = all;
            }
        }
        addafter("Marital Status")
        {

            // field("N° CIN2"; Rec."N° CIN")
            // {
            //     ApplicationArea = all;
            // }
            field("Carte Séjour"; Rec."Carte Séjour")
            {
                ApplicationArea = all;

            }
            field("Nationalité"; Rec."Nationalité")
            {
                ApplicationArea = all;
            }


            field("Birth place A2"; Rec."Birth place A")
            {
                ApplicationArea = all;
            }

            group("Situation familiale")
            {
                Editable = SetEditable;
                Caption = 'Situation familiale';
                field("Marital Status1"; rec."Marital Status")
                {
                    Caption = 'Situation de famille A';
                    StyleExpr = true;
                    Style = Strong;
                }
                field("Familly chief2"; rec."Familly chief")
                {
                    ApplicationArea = all;
                    Caption = 'Chef de famille';
                    StyleExpr = true;
                    Style = Strong;

                }


                field("Deduction Loaded child2"; rec."Deduction Loaded child")
                {
                    ApplicationArea = all;
                    Caption = 'Déduction Enfant à charge';
                    StyleExpr = true;
                    Style = Strong;

                }
                field("Loaded childs2"; rec."Loaded childs")
                {
                    ApplicationArea = all;
                    StyleExpr = true;
                    Style = Strong;

                }
                // field("Nombre Enfant2"; rec."Nombre Enfant")
                // {
                //     Editable = NombreEnfantEDITABLE;
                //     ApplicationArea = all;
                //     Caption = 'Nombre Enfant';
                // }

                field("Nom Conjoint"; Rec."Nom Conjoint")
                {
                    ApplicationArea = all;
                }
                field("Nombre de Charge"; Rec."Nombre de Charge")
                {
                    ApplicationArea = all;
                }


            }

        }

        addafter(Personal)
        {
            group(Statistics)
            {
                Editable = SetEditable;
                Caption = 'Statistiques';

                group("Absences && Congés")
                {
                    Caption = 'Absences && Congés';
                    group("  ")
                    {

                        ShowCaption = false;
                        field("DATE2DMY(WORKDATE,3)-1"; DATE2DMY(WORKDATE, 3) - 1)
                        {
                            ApplicationArea = all;
                            Editable = false;
                            ShowCaption = false;
                            Style = Unfavorable;
                            StyleExpr = true;
                        }
                        field("JT d'absence non payées"; NonPayed[1])
                        {
                            ApplicationArea = all;
                            Caption = 'JT d''absence non payée';
                            Editable = false;
                        }
                        field("Droit congé"; DroitCong[1])
                        {
                            ApplicationArea = all;
                            Caption = 'Droit congé';
                            Editable = false;
                        }
                        field("Consommation congé"; ConSCong[1])
                        {
                            ApplicationArea = all;
                            Caption = 'Consommation congé';
                            Editable = false;
                        }
                        field("Solde jours de congés"; SoldeCong[1])
                        {
                            ApplicationArea = all;
                            Caption = 'Solde jours de congés';
                            Editable = false;
                        }
                        label("    ")
                        {
                            ShowCaption = false;
                        }
                    }
                    group(" ")
                    {

                        ShowCaption = false;
                        field("DATE2DMY(WORKDATE,3)"; DATE2DMY(WORKDATE, 3))
                        {
                            ApplicationArea = all;
                            Editable = false;
                            ShowCaption = false;
                            StyleExpr = true;
                            Style = Unfavorable;

                        }
                        field("JT d'absence non payées2"; NonPayed[2])
                        {
                            ApplicationArea = all;
                            Caption = 'JT d''absence non payées';
                            Editable = false;
                        }
                        field("Droit congé2"; DroitCong[2])
                        {
                            ApplicationArea = all;
                            Caption = 'Droit congé';
                            Editable = false;
                        }
                        field("Consommation congé2"; ConSCong[2])
                        {
                            ApplicationArea = all;
                            Caption = 'Consommation congé';
                            Editable = false;
                        }
                        field("Solde jours de congés2"; SoldeCong[2])
                        {
                            ApplicationArea = all;
                            Caption = 'Solde jours de congés';
                            Editable = false;
                            StyleExpr = true;
                            Style = Unfavorable;
                        }
                    }
                }
                group(Recuperation)
                {
                    Caption = 'Recuperation';
                    Visible = false;
                    field("Days off + Recup"; rec."Days off + Recup")
                    {
                        ApplicationArea = all;
                        Caption = 'Droit de Jours Recup.';
                    }
                    field(Note; rec.Note)
                    {
                        ApplicationArea = all;
                        Caption = 'Note';
                    }
                    field("Days off  Recup-"; rec."Days off  Recup-")
                    {
                        ApplicationArea = all;
                        Caption = 'Jour Recup Consomation';
                    }
                    field("Days off = Recup"; rec."Days off = Recup")
                    {
                        ApplicationArea = all;
                        Caption = 'Solde de Jours Recup.';
                    }
                }
            }
            group("Prét Et Avance")
            {
                Editable = SetEditable;
                Caption = 'Prét Et Avance';
                group("Solde Salarié")
                {
                    Caption = 'Solde Salarié';

                    field("Advances balance"; Rec."Advances balance")
                    {
                        ApplicationArea = all;
                        Caption = 'Solde Avances';
                    }
                    field("Loans balance"; rec."Loans balance")
                    {
                        ApplicationArea = all;
                        Caption = 'Solde Préts';
                    }
                }
            }
            // group(Historique)
            // {
            //     Editable = SetEditable;
            //     Caption = 'Historique';
            //     field("Mois N"; rec."Mois N")
            //     {
            //         Caption = 'Mois';

            //         ApplicationArea = all;
            //         trigger OnValidate()
            //         begin
            //             CurrPage.UPDATE;
            //         end;
            //     }
            // }
            group(HISTORIQES)
            {
                Caption = 'Historique contrat de Travail';
                Editable = SetEditable;
                part("HISTORIQE"; "Liste Hist contrat de travail")
                {
                    Editable = "Indemnite-FrameEDITABLE";

                    ApplicationArea = all;
                    SubPageLink = "Code" = FIELD("Emplymt. Contract Code");
                }
            }
            group("Indemnité")
            {
                Editable = SetEditable;
                Caption = 'Indemnité';
                part("Indemnite-Frame"; "Employment Contracts List Ind")
                {
                    Editable = "Indemnite-FrameEDITABLE";
                    ApplicationArea = all;
                    SubPageLink = "Employment Contract Code" = FIELD("Emplymt. Contract Code");
                    UpdatePropagation = Both;
                }
            }
            group("Cotisation Social")
            {
                Editable = SetEditable;
                Caption = 'Cotisation Social';
                part("Contisation-Frame"; "Employment Contracts List Cot")
                {
                    Editable = "Contisation-FrameEDITABLE";
                    ApplicationArea = all;
                    SubPageLink = "Employment Contract Code" = FIELD("Emplymt. Contract Code");
                }
            }
            group("Décisions Salaire")
            {
                Editable = SetEditable;
                Visible = false;
                Caption = 'Décisions Salaire';
                part("Subform Décision augmentation"; "Subform Décision augmentation")
                {
                    ApplicationArea = all;
                    SubPageLink = Matricule = FIELD("No.");
                }
            }
        }

        // addafter(General)
        // {
        //     part("Employee Picture"; 5202)
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "No." = FIELD("No.");

        //     }
        // }
    }
    actions
    {
        addafter("&Relatives")
        {
            action("Categorie Employée")
            {
                Caption = 'Categorie Employée';
                ApplicationArea = all;
                RunObject = page "Employee Categorie";
                RunPageLink = "No." = FIELD("No.");
            }

        }
        addafter("Q&ualifications")
        {
            // action("Historiques Carière")
            // {
            //     Caption = 'Career history';
            //     ApplicationArea = all;
            //     RunObject = page 52048969;
            //     RunPageLink = employee = FIELD("No.");
            // }

            // action("Ecriture Pointages")
            // {
            //     Caption = 'Entry postings';
            //     ApplicationArea = all;
            //     RunObject = Page 50052;
            //     RunPageView = SORTING(Field4, "Type réglement");
            //     RunPageLink = Field4 = FIELD("No.");
            //     Visible = FALSE;
            // }
        }

        addbefore("Misc. Articles &Overview")
        {
            action("Validées")
            {
                Caption = 'Validées';
                ApplicationArea = all;
                RunObject = Page 5231;
                RunPageLink = "No." = FIELD("No.");

            }
            action("Détail de consommation congé")
            {
                Caption = 'Détail de consommation congé';
                ApplicationArea = all;
                RunObject = page "Detail consommation conge";
                RunPageLink = "Salarié" = FIELD("No.");
            }
        }


        addafter(Action61)
        {
            action("Comptes &bancaires")
            {
                ApplicationArea = all;
                Caption = 'Comptes &bancaires';
                RunObject = page "Employee Bank Account Card";
                RunPageLink = "Employee No." = FIELD("No.");
            }
            separator(separator100)
            {
            }
            action("Contrat de travail")
            {
                ApplicationArea = all;
                Caption = 'Contrat de travail';
                RunObject = page "Employment Contract NE";
                RunPageLink = Code = FIELD("Emplymt. Contract Code");
            }
            action("ontrat de travail archivé")
            {
                ApplicationArea = all;
                Caption = 'Contrat de travail archivé';

                trigger OnAction()
                begin
                    CurrPage.HISTORIQE.Page.afficherencour;
                end;
            }
            // action("Contrat de travail archivé")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Archived employment contract';
            // }
            // separator(separator200)
            // {
            // }
            action("Salaires enreg.")
            {
                ApplicationArea = all;
                Caption = 'Salaires enreg.';
                RunObject = page "Recorded Payment lines";
                RunPageLink = Employee = FIELD("No.");
            }
            separator(separator300)
            {
            }
            action(Calendrier)
            {
                ApplicationArea = all;
                Caption = 'Calendrier';
                trigger OnAction()
                begin

                    CLEAR(CalendForm);
                    CalendForm.SetSalN(rec."No.");
                    CalendForm.RUNMODAL;
                end;
            }
            group("Engagements Salariée encours")
            {

                Caption = 'Engagements Salariée encours';

                action("Prêts")
                {
                    ApplicationArea = all;
                    Caption = 'Prêts';
                    RunObject = page "Loan & Advance Hdr";
                    RunPageLink = Employee = FIELD("No.");
                    RunPageView = SORTING(Employee, Type, Status, "No.", "Avance Sur Prime")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER("In progress"),
                                        Type = FILTER(Loan));
                }
                action(Avances)
                {
                    ApplicationArea = all;
                    Caption = 'Avances';
                    RunObject = page "Loan & Advance Hdr";
                    RunPageLink = Employee = FIELD("No.");
                    RunPageView = SORTING(Employee, Type, Status, "No.", "Avance Sur Prime")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER("In progress"),
                                        Type = FILTER(Advance));
                }
            }
            Group("Engagements Clôturer")
            {

                Caption = 'Engagements Clôturer';

                action("Prêts2")
                {
                    ApplicationArea = all;
                    Caption = 'Prêts';
                    RunObject = page "Loan & Advance Hdr";
                    RunPageLink = Employee = FIELD("No.");
                    RunPageView = SORTING(Employee, Type, Status, "No.", "Avance Sur Prime")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER(Enclosed),
                                        Type = FILTER(Loan));
                }
                action(Avances2)
                {
                    ApplicationArea = all;
                    Caption = 'Avances';
                    RunObject = page "Loan & Advance Hdr";
                    RunPageLink = Employee = FIELD("No.");
                    RunPageView = SORTING(Employee, Type, Status, "No.", "Avance Sur Prime")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER(Enclosed),
                                        Type = FILTER(Advance));
                }
            }
            // action("Credit Habitation")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Credit Habitation';
            //     RunObject = page "Credit Employé";
            //     RunPageLink = Employé = FIELD("No."); 
            // }
            action("Assurance Vie")
            {
                ApplicationArea = all;
                Caption = 'Assurance Vie';
                Visible = false;
                RunObject = Page "Assurance Vie Employé";
                RunPageLink = Employé = FIELD("No.");
            }
            action("Parent en Charge")
            {
                ApplicationArea = all;
                Caption = 'Parent en Charge';
                Visible = false;
                RunObject = Page "Parent en Charge";
                RunPageLink = Employé = FIELD("No.");
            }
            action("Etudiant en charge / Bourse")
            {
                ApplicationArea = all;
                Caption = 'Etudiant en charge / Bourse';
                Visible = false;
                RunObject = Page "Bourse Etudiant";
                RunPageLink = Employé = FIELD("No.");
            }
            // action(Autorisation)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Autorisation';
            //     RunObject = page "Suivi Autorisation";
            //     RunPageLink = "N° Salariée" = FIELD("No.");
            // }
        }




        addafter("E&mployee")
        {

            group(Fonctions)
            {
                Caption = 'Fonctions';

                action("Calcul Paie Inverse")
                {
                    ApplicationArea = all;
                    Caption = 'Calcul Paie Inverse';
                    trigger OnAction()
                    begin

                        SalaryLine.SETRANGE("No.", 'SIMULATION');
                        SalaryLine.SETRANGE(Employee, rec."No.");
                        IF SalaryLine.FIND('-') THEN
                            MngtSalary.DeleteLine(SalaryLine);

                        MngtSalary.CréerSimulationPaie(Rec);
                        COMMIT;
                        IF contrat.GET(rec."No.") THEN;
                        IF regimeofwork.GET(contrat."Regimes of work") THEN;
                        SalaryLine.SETRANGE("No.", 'SIMULATION');
                        SalaryLine.SETRANGE(Employee, rec."No.");
                        IF SalaryLine.FIND('-') THEN BEGIN
                            IF SalaryLine."Employee's type" = 0 THEN BEGIN
                                SalaryLine."Worked hours" := regimeofwork."Work Hours per month";
                                // SalaryLine."Worked hours" := regimeofwork."Work Hours per month";
                                // SalaryLine."Basis salary" := rec."Basis salary" * regimeofwork."Work Hours per month";
                                // SalaryLine."Employee's type" := 1;
                                // SalaryLine."Worked hours" := regimeofwork."Work Hours per month";
                                // MngtSalary.CalculerLigneSalaire(SalaryLine, FALSE, 0, 0, FALSE);

                                // IF RecEmployee.GET(rec."No.") THEN BEGIN
                                //     RecEmployee."Salaire Net Simulé" := SalaryLine."Net salary";
                                //     RecEmployee.MODIFY;
                                // END;

                            END;
                            PAGE.RUN(PAGE::"Employee : Salary calculation", SalaryLine);
                        END;
                    end;
                }
                separator(separator400)
                {
                }
                // action("Att Travail/Salaire/NB Prêt")
                // {
                //     Caption = 'Att Travail/Salaire/NB Prê';
                //     ApplicationArea = all;
                //     Visible = false;
                //     trigger OnAction()
                //     begin

                //         RecEmployee3.SETRANGE("No.", rec."No.");
                //         REPORT.RUNMODAL(REPORT::"Attestation de Salaire", TRUE, TRUE, RecEmployee3);
                //     end;
                // }
                separator(separator500)
                {
                }
                group("Export vers Word")
                {

                    Caption = 'Export vers Word';
                    Visible = false;

                    group("Attestation de travail")
                    {

                        Caption = 'Attestation de travail';

                        action(Depuis)
                        {
                            ApplicationArea = all;
                            Caption = 'Depuis';
                            Visible = false;
                            trigger OnAction()
                            begin

                                CLEAR(Dot);
                                Dot.AttestationDepuis(Rec);
                            end;
                        }
                        action("Période")
                        {
                            ApplicationArea = all;
                            Caption = 'Période';
                            trigger OnAction()
                            begin

                                CLEAR(Dot);
                                Dot.AttestationPeriode(Rec)
                            end;
                        }
                    }
                    action("Cértificat de travail")
                    {
                        ApplicationArea = all;
                        Caption = 'Cértificat de travail';
                        trigger OnAction()
                        begin

                            CLEAR(Dot);
                            Dot.CertifDeTravail(Rec)
                        end;
                    }
                }
                action("Archiver contrat de travail")
                {
                    ApplicationArea = all;
                    Caption = 'Archiver contrat de travail';
                    trigger OnAction()
                    var
                        RecGEmployee: Record Employee;
                        RecGEmploymentContract: Record "Employment Contract";
                        RecGDefaultIndemnity: Record "Default Indemnities";
                        RecGDefaultSocialCont: Record "Default Soc. Contribution";
                        RecGHistoriqueContratTravail: Record "Historique contrat de travail";
                        RecLHisrtDefaultindemties: Record "Hist. Default Indemnities";
                        RecHistDefaultSocialCont: Record "Hist. Soc. Contribution";
                    begin

                        //>>DSFT AGA 25/03/2010
                        RecGEmploymentContract.GET(rec."Emplymt. Contract Code");
                        RecGHistoriqueContratTravail.SETFILTER(Code, rec."Emplymt. Contract Code");
                        IF RecGHistoriqueContratTravail.FIND('+') THEN
                            RecGHistoriqueContratTravail."Code contrat archivé" := RecGHistoriqueContratTravail."Code contrat archivé" + 10000
                        ELSE
                            RecGHistoriqueContratTravail."Code contrat archivé" := 10000;
                        RecGHistoriqueContratTravail.INIT;
                        RecGHistoriqueContratTravail.Code := RecGEmploymentContract.Code;
                        RecGHistoriqueContratTravail.Description := RecGEmploymentContract.Description;
                        RecGHistoriqueContratTravail."Job Title" := rec."Job Title";
                        RecGHistoriqueContratTravail.Address := rec.Address;
                        RecGHistoriqueContratTravail.City := rec.City;
                        RecGHistoriqueContratTravail."Phone No." := rec."Phone No.";
                        // RecGHistoriqueContratTravail."Social Security No." := rec."N° CNPS";
                        RecGHistoriqueContratTravail."Social Security No." := rec."Social Security No.";
                        RecGHistoriqueContratTravail.Sex := rec.Gender;
                        RecGHistoriqueContratTravail."Statistics Group Code" := rec."Statistics Group Code";
                        RecGHistoriqueContratTravail."Statistics Group Code" := rec."Statistics Group Code";
                        RecGHistoriqueContratTravail."Employment Date" := rec."Employment Date";
                        RecGHistoriqueContratTravail.Status := rec.Status;
                        RecGHistoriqueContratTravail."Inactive Date" := rec."Inactive Date";
                        RecGHistoriqueContratTravail."Cause of Inactivity Code" := rec."Cause of Inactivity Code";
                        RecGHistoriqueContratTravail."Termination Date" := rec."Termination Date";
                        RecGHistoriqueContratTravail."Grounds for Term. Code" := rec."Grounds for Term. Code";
                        //GL2024 RecGHistoriqueContratTravail."Family Situation A":="Family Situation A";
                        RecGHistoriqueContratTravail."Relation de travail" := rec."Relation de travail";
                        RecGHistoriqueContratTravail."Employee's type Contrat" := RecGEmploymentContract."Employee's type Contrat";
                        RecGHistoriqueContratTravail.Spécialité := rec.Fonction;
                        // RecGHistoriqueContratTravail.Spécialité := rec.Spécialité;
                        RecGHistoriqueContratTravail."date debut contrat" := rec."date debut contrat";
                        RecGHistoriqueContratTravail.Nationalité := rec.Nationalité;
                        RecGHistoriqueContratTravail."Hors Grille" := rec."Hors Grille";
                        RecGHistoriqueContratTravail."Regular payments" := RecGEmploymentContract."Regular payments";
                        RecGHistoriqueContratTravail."Temporary payments" := RecGEmploymentContract."Temporary payments";
                        RecGHistoriqueContratTravail."Adjust indemnity amount" := RecGEmploymentContract."Adjust indemnity amount";
                        RecGHistoriqueContratTravail."Regimes of work" := RecGEmploymentContract."Regimes of work";
                        RecGHistoriqueContratTravail."Salary grid" := RecGEmploymentContract."Salary grid";
                        RecGHistoriqueContratTravail.Taxable := RecGEmploymentContract.Taxable;
                        RecGHistoriqueContratTravail."Take in account deductions" := RecGEmploymentContract."Take in account deductions";
                        RecGHistoriqueContratTravail."Calculation mode of the taxes" := RecGEmploymentContract."Calculation mode of the taxes";
                        RecGHistoriqueContratTravail."Inclusive ratio" := RecGEmploymentContract."Inclusive ratio";
                        RecGHistoriqueContratTravail.Grade := rec.Grade;
                        //RecGHistoriqueContratTravail.Echelle:=Echelle;
                        RecGHistoriqueContratTravail.Classe := rec.Classe;
                        RecGHistoriqueContratTravail."Type Calendar" := RecGEmploymentContract."Type Calendar";
                        RecGHistoriqueContratTravail."Code Calendar" := RecGEmploymentContract."Code Calendar";
                        RecGHistoriqueContratTravail."Appliquer Heure Supp" := RecGEmploymentContract."Appliquer Heure Supp";
                        RecGHistoriqueContratTravail.Note := rec.Note;
                        RecGHistoriqueContratTravail."Gross Salary" := rec."Indemnité imposable";
                        RecGHistoriqueContratTravail."Basis salary" := rec."Basis salary";
                        RecGHistoriqueContratTravail."National Identity Card No." := rec."N° Pièce D'identité";
                        //    RecGHistoriqueContratTravail."National Identity Card No." := rec."National Identity Card No.";
                        RecGHistoriqueContratTravail."Employee Posting Group" := rec."Employee Posting Group";
                        RecGHistoriqueContratTravail.Collège := rec.Catégorie;
                        // RecGHistoriqueContratTravail.Collège := rec.Collège;
                        //RecGHistoriqueContratTravail.Echelon:=Echelons;
                        RecGHistoriqueContratTravail."Entry date Cat/Echelon" := rec."Entry date Cat/Echelon";
                        RecGHistoriqueContratTravail."Upgrading date Cat/Echelon" := rec."Upgrading date Cat/Echelon";
                        RecGHistoriqueContratTravail."Loaded childs" := rec."Loaded childs";
                        RecGHistoriqueContratTravail."Days off -" := rec."Days off -";
                        RecGHistoriqueContratTravail."Days off +" := rec."Days off +";
                        RecGHistoriqueContratTravail."Days off =" := rec."Days off =";
                        RecGHistoriqueContratTravail."Date denier passage Cat/ech" := rec."Date denier passage Cat/ech";
                        RecGHistoriqueContratTravail.INSERT;

                        //>> DSFT AGA 25/03/2010
                        // Achive indemnité
                        RecGDefaultIndemnity.SETFILTER("Employment Contract Code", rec."Emplymt. Contract Code");
                        IF RecGDefaultIndemnity.FIND('-') THEN
                            REPEAT
                                RecLHisrtDefaultindemties.TRANSFERFIELDS(RecGDefaultIndemnity);
                                RecLHisrtDefaultindemties."Code contrat archivé" := RecGHistoriqueContratTravail."Code contrat archivé";
                                RecLHisrtDefaultindemties.INSERT;
                            UNTIL RecGDefaultIndemnity.NEXT = 0;

                        RecGDefaultSocialCont.SETFILTER("Employment Contract Code", rec."Emplymt. Contract Code");
                        IF RecGDefaultSocialCont.FIND('-') THEN
                            REPEAT
                                RecHistDefaultSocialCont.TRANSFERFIELDS(RecGDefaultSocialCont);
                                RecHistDefaultSocialCont."Code contrat archivé" := RecGHistoriqueContratTravail."Code contrat archivé";
                                RecHistDefaultSocialCont.INSERT;
                            UNTIL RecGDefaultSocialCont.NEXT = 0;
                        MESSAGE('Contrat de travail ' + FORMAT(rec."Emplymt. Contract Code") + ' Archivé avec succée');
                    end;
                }
                action("Modifier Fiche")
                {
                    ApplicationArea = all;
                    Image = UpdateDescription;
                    Caption = 'Modifier Fiche';
                    trigger OnAction()
                    begin

                        //IF CduUserSetupManagement.GetAutorisationLancerDevis(UPPERCASE(USERID)) THEN
                        IF RecUser.GET(USERID) THEN
                            IF RecUser."Modif Salarie" THEN
                                SetEditable := true;
                        IF xRec."First Name" <> '' THEN EnabledElemCalcSal;
                        //CurrForm.EDITABLE:=TRUE;
                    end;
                }
                action("Imprimer Fiche Création")
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer Fiche Création';
                    Visible = false;
                    trigger OnAction()
                    begin

                        RecEmployee2.RESET;
                        RecEmployee2.SETRANGE("No.", rec."No.");
                        REPORT.RUNMODAL(REPORT::"Fiche Création Nouv Salarié", TRUE, TRUE, RecEmployee2);
                    end;
                }
                action("Valider Fiche salarié")
                {
                    ApplicationArea = all;
                    Caption = 'Valider Fiche salarié';
                    Visible = false;
                    trigger OnAction()
                    begin

                        //   IF rec.Approuvé = TRUE THEN ERROR(Text004);
                        IF UserSetup.GET(USERID) THEN BEGIN
                            //  IF UserSetup."Approbateur Nouveau salarié" = FALSE THEN ERROR(Text002);
                        END;

                        IF NOT CONFIRM('Voulez-vous Validé la Fiche salarié', FALSE) THEN EXIT;
                        // rec.Approuvé := TRUE;
                        // rec."Approuvé par" := USERID;
                        // rec."Date Approbation" := TODAY;
                        // rec.MODIFY;
                    end;
                }
                action("Calcul Paie Inverse En Lot")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'Calcul Paie Inverse En Lot';
                    trigger OnAction()
                    begin

                        IF RecEmployee.FINDFIRST THEN
                            REPEAT
                                SalaryLine.SETRANGE("No.", 'SIMULATION');
                                SalaryLine.SETRANGE(Employee, RecEmployee."No.");
                                IF SalaryLine.FIND('-') THEN
                                    MngtSalary.DeleteLine(SalaryLine);

                                MngtSalary.CréerSimulationPaie(RecEmployee);
                                COMMIT;
                                SalaryLine.SETRANGE("No.", 'SIMULATION');
                                SalaryLine.SETRANGE(Employee, RecEmployee."No.");
                                IF SalaryLine.FINDFIRST THEN;
                                RecEmployee."Salaire Net Simulé" := SalaryLine."Net salary";
                                RecEmployee.MODIFY;
                            UNTIL RecEmployee.NEXT = 0;
                        MESSAGE(Text001);
                        EXIT;
                    end;
                }
            }
        }


        addafter("F&unctions")
        {
            action("Net Simule")
            {
                caption = 'Net Simule';
                ApplicationArea = all;
                //GL2024
                Visible = false;
                //GL2024
                trigger OnAction()
                begin
                    CalculerNet;
                end;
            }
        }
        addafter("Ledger E&ntries_Promoted")
        {
            actionref("Categorie Employée1"; "Categorie Employée") { }
            actionref("Comptes &bancaires1"; "Comptes &bancaires") { }
            actionref("Salaires enreg.1"; "Salaires enreg.") { }
            actionref(Calendrier1; Calendrier) { }
            group("Engagements Salariée encours1")
            {
                Caption = 'Engagements Salariée encours';
                actionref("Prêts1"; "Prêts") { }
                actionref(Avances1; Avances) { }
            }
            group("Engagements Clôturer1")
            {
                Caption = 'Engagements Clôturer';
                actionref("Prêts21"; "Prêts2") { }
                actionref(Avances21; Avances2) { }
            }
            //   actionref("Credit Habitation1"; "Credit Habitation") { }
            //  actionref("Assurance Vie1"; "Assurance Vie") { }
            // actionref("Parent en Charge1"; "Parent en Charge") { }
            //  actionref("Etudiant en charge / Bourse1"; "Etudiant en charge / Bourse") { }
            // actionref(Autorisation1; Autorisation) { }
        }
        addafter(Category_Category4)
        {
            group(Fonctions1)
            {
                Caption = 'Fonctions';
                actionref("Calcul Paie Inverse1"; "Calcul Paie Inverse") { }

                //    actionref("Att Travail/Salaire/NB Prêt1"; "Att Travail/Salaire/NB Prêt") { }
                actionref("Archiver contrat de travail1"; "Archiver contrat de travail") { }

                //  actionref("Imprimer Fiche Création1"; "Imprimer Fiche Création") { }
                //    actionref("Valider Fiche salarié1"; "Valider Fiche salarié") { }

                //  actionref("Calcul Paie Inverse En Lot1"; "Calcul Paie Inverse En Lot") { }

                group("Export vers Word1")
                {

                    Caption = 'Export vers Word1';
                    group("Attestation de travail1")
                    {

                        Caption = 'Attestation de travail';
                        actionref(Depuis1; Depuis) { }
                        actionref("Période1"; "Période") { }
                    }
                    actionref("Cértificat de travail1"; "Cértificat de travail") { }

                }
            }

        }
        addafter(Category_Report)
        {
            actionref("Modifier Fiche1"; "Modifier Fiche") { }
            actionref("Net Simule1"; "Net Simule")
            {

            }
        }
    }






    trigger OnOpenPage()
    begin
        /* GL2024  SourceTableView = WHERE(Blocked = CONST(false),
                         BR = CONST(false));*/
        /* Rec.FilterGroup(0);
         rec.SetRange(Blocked, false);
         rec.SetRange(BR, false);
         Rec.FilterGroup(2);*/

        rec.CALCFIELDS("Somme Indemnités");
        rec.CALCFIELDS("Indemnité imposable");
        Rec.CalcFields("Total Absence (Base)");
        //  rec.CALCFIELDS("Total Indemnité Par Defaut");
        SalaireBrut := rec."Somme Indemnités" + rec."Basis salary";
        //  s
        // IF rec."Salaire De Base Horaire" = 0 THEN
        //     SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Basis salary"
        // ELSE
        //     SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Salaire De Base Horaire";

        SetEditable := FALSE;
        // Currpage.EDITABLE(SetEditable);
    end;

    trigger OnAfterGetRecord()
    begin

        rec.SETRANGE("No.");
        rec.CALCFIELDS("Indemnité imposable");

        QualificationEmploye.RESET;
        QualificationEmploye.SETCURRENTKEY("Employee No.", "Line No.");
        QualificationEmploye.SETRANGE("Employee No.", rec."No.");
        IF QualificationEmploye.FIND('+') THEN BEGIN
            rec."Qualification Code" := QualificationEmploye."Qualification Code";
            rec.VALIDATE("Qualification Code", QualificationEmploye."Qualification Code");
        END;
        rec.CALCFIELDS("Somme Indemnités");
        SalaireBrut := rec."Somme Indemnités" + rec."Basis salary";
        /* rec.CALCFIELDS("Total Indemnité Par Defaut");
         //SalaireBrut := "Gross Salary"+"Basis salary";
         IF rec."Salaire De Base Horaire" = 0 THEN
             SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Basis salary"
         ELSE
             SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Salaire De Base Horaire";*/


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin


        SetEditable := true;
        QualificationEDITABLE := TRUE;
        BasisSalaryEDITABLE := TRUE;
        NombreEnfantEDITABLE := TRUE;
        "Indemnite-FrameEDITABLE" := TRUE;
        "Contisation-FrameEDITABLE" := TRUE;
        CategorieEDITABLE := TRUE;

    end;

    trigger OnAfterGetCurrRecord()
    begin

        rec.SETFILTER("Filtre Année", '%1', DATE2DMY(WORKDATE, 3) - 2);
        rec.CALCFIELDS("Non paid days", "Days off -", "Days off +", "Days off =");
        FOR i := 1 TO 2 DO BEGIN
            NonPayed[i] := 0;
            DroitCong[i] := 0;
            ConSCong[i] := 0;
            SoldeCong[i] := 0;
        END;

        DroitCong[1] := rec."Days off =";
        rec.SETFILTER("Filtre Année", '%1', DATE2DMY(WORKDATE, 3) - 1);
        rec.CALCFIELDS("Non paid days", rec."Days off -", rec."Days off +", rec."Days off =");

        NonPayed[1] := rec."Non paid days";
        DroitCong[1] := rec."Days off +"; //DroitCong[1]+    MBY 26-06-07
        ConSCong[1] := rec."Days off -";
        SoldeCong[1] := rec."Days off =";

        DroitCong[2] := rec."Days off =";
        rec.SETFILTER("Filtre Année", '%1', DATE2DMY(WORKDATE, 3));
        rec.CALCFIELDS("Non paid days", rec."Days off -", "Days off +", "Days off =");

        NonPayed[2] := rec."Non paid days";
        DroitCong[2] := rec."Days off +";//DroitCong[2]+ MBY 26-06-07
        ConSCong[2] := rec."Days off -";
        SoldeCong[2] := rec."Days off =";
        rec.CALCFIELDS("Somme Indemnités");
        SalaireBrut := rec."Somme Indemnités" + rec."Basis salary";
        /* rec.CALCFIELDS("Total Indemnité Par Defaut");
         //SalaireBrut := "Gross Salary"+"Basis salary";
         IF rec."Salaire De Base Horaire" = 0 THEN
             SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Basis salary"
         ELSE
             SalaireBrut := rec."Total Indemnité Par Defaut" + rec."Salaire De Base Horaire";*/
    end;


    PROCEDURE CalculerNet();
    VAR
        MngtSalary: Codeunit "Management of salary";
        SalaryHeader: Record "Salary Headers";
        SalaryLine: Record "Salary Lines";
        RecEmployee: Record Employee;
        EmpCont: Record "Employment Contract";
        RegWork: record "Regimes of work";
        MngmtSalary: Codeunit "Management of salary";
    BEGIN


        SalaryHeader.SETRANGE("No.", 'SIMULATION');
        IF SalaryHeader.FINDFIRST THEN SalaryHeader.DELETE(TRUE);

        IF RecEmployee.GET(rec."No.") THEN BEGIN
            SalaryLine.SETRANGE("No.", 'SIMULATION');
            SalaryLine.SETRANGE(Employee, RecEmployee."No.");
            IF SalaryLine.FIND('-') THEN SalaryLine.DELETE;

            MngtSalary.CréerSimulationPaie(RecEmployee);

            IF EmpCont.GET(RecEmployee."Emplymt. Contract Code") THEN BEGIN
                RegWork.GET(EmpCont."Regimes of work");

                SalaryLine.SETRANGE("No.", 'SIMULATION');
                SalaryLine.SETRANGE(Employee, RecEmployee."No.");
                IF SalaryLine.FINDFIRST THEN BEGIN

                    IF SalaryLine."Employee's type" = 0 THEN BEGIN
                        SalaryLine."Basis salary" := RecEmployee."Basis salary" * RegWork."Work Hours per month";
                        SalaryLine."Employee's type" := 1;
                        SalaryLine."Worked hours" := RegWork."Work Hours per month";
                    END;
                    MngmtSalary.CalculerLigneSalaire(SalaryLine, FALSE, 0, 0, FALSE);
                    rec."Salaire Net Simulé" := SalaryLine."Net salary";
                    //   rec."Impot Simule" := SalaryLine."Taxe (Month)";
                    rec.MODIFY;

                END;
            END;
        END;
    END;


    PROCEDURE EnabledElemCalcSal();
    BEGIN

        IF UserSetup.GET(UPPERCASE(USERID)) THEN;
        IF NOT UserSetup."Modification Element Calc Sal" THEN BEGIN
            QualificationEDITABLE := FALSE;
            BasisSalaryEDITABLE := FALSE;
            NombreEnfantEDITABLE := FALSE;
            "Indemnite-FrameEDITABLE" := FALSE;
            "Contisation-FrameEDITABLE" := FALSE;
            CategorieEDITABLE := FALSE;
            LoadedchildsEDITABLE := FALSE;
        END
        ELSE BEGIN
            QualificationEDITABLE := TRUE;
            BasisSalaryEDITABLE := TRUE;
            NombreEnfantEDITABLE := TRUE;
            "Indemnite-FrameEDITABLE" := TRUE;
            "Contisation-FrameEDITABLE" := TRUE;
            CategorieEDITABLE := TRUE;

        END;
    END;




    Var
        MngtSalary: Codeunit "Management of salary";
        SalaryLine: Record "Salary Lines";
        PostCode: Record "Post Code";
        CalendForm: page "Monthly Personal Calendar";
        NonPayed: ARRAY[2] OF Decimal;
        DroitCong: ARRAY[2] OF Decimal;
        ConSCong: ARRAY[2] OF Decimal;
        i: Integer;
        SoldeCong: ARRAY[2] OF Decimal;
        Sal: Record Employee;
        Dot: Codeunit Dots;
        QualificationEmploye: Record "Employee Qualification";
        FormListehistoriqueContrat: page "Liste Hist contrat de travail";
        regimeofwork: record "Regimes of work";
        contrat: Record "Employment Contract";
        SetEditable: Boolean;
        CduUserSetupManagement: Codeunit "User Setup Management";
        RecUser: Record "User Setup";
        SalaireBrut: Decimal;
        Empl: Record Employee;
        NonPayed1: ARRAY[3] OF Decimal;
        DroitCong1: ARRAY[3] OF Decimal;
        ConSCong1: ARRAY[3] OF Decimal;
        SoldeCong1: ARRAY[3] OF Decimal;
        RecDetailConge: Record "Detail de congé consommé";
        DecResteCons: Decimal;
        RecEmployee: Record Employee;
        EmpCont: Record "Employment Contract";
        RegWork: record "Regimes of work";
        UserSetup: Record "User Setup";
        RecEmployee2: Record Employee;
        RecEmployee3: Record Employee;
        Text001: label 'Task completed';
        Text002: label 'You are no longer an approver!!';
        Text003: label 'Employee Card approved successfully!!';
        Text004: label 'Card already approved!!';
        //GL2024

        QualificationEDITABLE: Boolean;
        NombreEnfantEDITABLE: Boolean;
        LoadedchildsEDITABLE: Boolean;
        "Indemnite-FrameEDITABLE": Boolean;
        "Contisation-FrameEDITABLE": Boolean;
        BasisSalaryEDITABLE: Boolean;
        //
        CategorieEDITABLE: Boolean;




}