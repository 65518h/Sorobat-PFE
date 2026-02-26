PageExtension 50057 "User Setup_PagEXT" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field(Fonction; rec.Fonction)
            {
                ApplicationArea = all;
            }
        }
        addafter("Allow Posting From")
        {
            /*  field("Modifier Etat facture AchEnreg"; rec."Modifier Etat facture AchEnreg")
              {
                  ApplicationArea = all;
              }
              field("Approbateur Nouveau salarié"; rec."Approbateur Nouveau salarié")
              {
                  ApplicationArea = all;
              }
              field("Notifier Rotation"; rec."Notifier Rotation")
              {
                  ApplicationArea = all;
              }*/
            /*    field("Notifier Reception PR"; rec."Notifier Reception PR")
                {
                    ApplicationArea = all;
                }
                field("Appliquer Blocage Date Compatb"; rec."Appliquer Blocage Date Compatb")
                {
                    ApplicationArea = all;
                }
                field("Approbateur Devis vente"; rec."Approbateur Devis vente")
                {
                    ApplicationArea = all;
                }*/
            /*  field("Approbateur Autoriser Avance F"; rec."Approbateur Autoriser Avance F")
              {
                  ApplicationArea = all;
              }*/
            field(Agence; rec.Agence)
            {
                ApplicationArea = all;
            }
            /*  field("Prix CMDV TTC"; rec."Prix CMDV TTC")
              {
                  ApplicationArea = all;
              }
              field("Integrer Caisse Comptable"; rec."Integrer Caisse Comptable")
              {
                  ApplicationArea = all;
              }
              field("Integrer Virement Salaire Comp"; rec."Integrer Virement Salaire Comp")
              {
                  ApplicationArea = all;
              }*/
            field(Niveau; rec.Niveau)
            {
                ApplicationArea = all;
            }
            /* field("N° Contrat BL Best Beton"; rec."N° Contrat BL Best Beton")
             {
                 ApplicationArea = all;
             }
             field("BL Carriere Stockable"; rec."BL Carriere Stockable")
             {
                 ApplicationArea = all;
             }*/
            field("Compte EX"; rec."Compte EX")
            {
                ApplicationArea = all;
            }
        }
        addafter("Allow Posting To")
        {
            field("Approver ID DA"; Rec."Approver ID DA") { ApplicationArea = all; }
            field("Filtre DA"; Rec."Filtre DA") { ApplicationArea = all; }
            field("Affaire Par Defaut"; Rec."Affaire Par Defaut") { ApplicationArea = all; }
            field("approver"; Rec."approver") { ApplicationArea = all; }
            field("PR Reopen permission"; Rec."PR Reopen permission") { ApplicationArea = all; }
            field("Permission Print PR"; Rec."Permission Print PR") { ApplicationArea = all; }
            field("Créer Commande a partir DA"; Rec."Créer Commande a partir DA") { ApplicationArea = all; }
            /*  field("Suppression Reception Achat"; rec."Suppression Reception Achat")
              {
                  ApplicationArea = all;
              }
              field("Chang Descrip Interdit"; rec."Chang Descrip Interdit")
              {
                  ApplicationArea = all;
              }
              field("Modif Materiel"; rec."Modif Materiel")
              {
                  ApplicationArea = all;
              }*/
            field("Modif Commande achat"; Rec."Modif Commande achat")
            {
                ApplicationArea = all;
            }
            field("Autoriser modif caisse extra"; Rec."Autoriser modif caisse extra")
            {
                ApplicationArea = All;
            }
            field("Autoriser Config Packages"; Rec."Autoriser Config Packages")
            {
                ApplicationArea = All;
            }
            /*   field("User GMAO"; rec."User GMAO")
               {
                   ApplicationArea = all;
               }
               field("Notifier GMAO"; rec."Notifier GMAO")
               {
                   ApplicationArea = all;
               }
               field("Modifier Magasin Reception"; rec."Modifier Magasin Reception")
               {
                   ApplicationArea = all;
               }
               field("Validation Commande Achat"; rec."Validation Commande Achat")
               {
                   ApplicationArea = all;
               }
               field("Annuler Impression CMDA"; rec."Annuler Impression CMDA")
               {
                   ApplicationArea = all;
               }
               field("Supp Doc Achat"; rec."Supp Doc Achat")
               {
                   ApplicationArea = all;
               }*/
            /*    field("Suppression DA"; rec."Suppression DA")
                {
                    ApplicationArea = all;
                }
                field("Reouvrir DA"; rec."Reouvrir DA")
                {
                    ApplicationArea = all;
                }
                field("Reouvrir DOC Achat"; rec."Reouvrir DOC Achat")
                {
                    ApplicationArea = all;
                }*/
            field("Modif Client"; rec."Modif Client")
            {
                ApplicationArea = all;
            }
            field("Modif Fournisseur"; rec."Modif Fournisseur")
            {
                ApplicationArea = all;
            }
            field("Modif Article"; rec."Modif Article")
            {
                ApplicationArea = all;
            }
            field("Approuver Brouillard"; rec."Approuver Brouillard")
            {
                ApplicationArea = all;
            }
            field("Car Pool Resp. Ctr. Filter"; Rec."Car Pool Resp. Ctr. Filter")
            {
                ApplicationArea = all;
            }

            field("Mask Code"; Rec."Mask Code")
            {
                ApplicationArea = all;
            }
            /*  field("Alerte Fin Contrat"; rec."Alerte Fin Contrat")
              {
                  ApplicationArea = all;
              }*/
            field("Alerte Generale"; rec."Alerte Generale")
            {
                ApplicationArea = all;
            }
            field("Alerte Min-Max"; rec."Alerte Min-Max")
            {
                ApplicationArea = all;
            }
            field("Alerte Papier Vehicule"; rec."Alerte Papier Vehicule")
            {
                ApplicationArea = all;
            }
            field("Alerte Vidange Vehicule"; rec."Alerte Vidange Vehicule")
            {
                ApplicationArea = all;
            }
            field("Mask Filter"; rec."Mask Filter")
            {
                ApplicationArea = all;
            }

            field("Modif Salarie"; rec."Modif Salarie")
            {
                ApplicationArea = all;
            }
            /*   field("Mise a Jour Etat Mensuel paie"; rec."Mise a Jour Etat Mensuel paie")
               {
                   ApplicationArea = all;
               }*/
            field("Modification Element Calc Sal"; rec."Modification Element Calc Sal")
            {
                ApplicationArea = all;
            }
            /*   field("Affaire Par Defaut"; rec."Affaire Par Defaut")
               {
                   ApplicationArea = all;
               }
               field("Filtre Magasin"; rec."Filtre Magasin")
               {
                   ApplicationArea = all;
               }
               field("Filtre Magasin 2"; rec."Filtre Magasin 2")
               {
                   ApplicationArea = all;
               }
               field("Filtre Magasin 3"; rec."Filtre Magasin 3")
               {
                   ApplicationArea = all;
               }
               field("Filtre DA"; rec."Filtre DA")
               {
                   ApplicationArea = all;
               }
               field(SM; rec.SM)
               {
                   ApplicationArea = all;
               }*/
            /*  field("Allerte Réclamation Facture"; rec."Allerte Réclamation Facture")
              {
                  ApplicationArea = all;
              }
              field("Validation Paiement"; rec."Validation Paiement")
              {
                  ApplicationArea = all;
              }*/
            field(Service; rec.Service)
            {
                ApplicationArea = all;
            }
            /*   field("Service Achat 01"; rec."Service Achat 01")
               {
                   ApplicationArea = all;
               }
               field("Service Achat 02"; rec."Service Achat 02")
               {
                   ApplicationArea = all;
               }
               field("Service Achat 03"; rec."Service Achat 03")
               {
                   ApplicationArea = all;
               }
               field("<Notifier Rotation2>"; rec."Notifier Rotation")
               {
                   ApplicationArea = all;
               }
               field("Approbateur DA"; rec."Approbateur DA")
               {
                   ApplicationArea = all;
               }*/
        }
        addafter("Register Time")
        {
            /*    field("Notification Min-Max"; rec."Notification Min-Max")
                {
                    ApplicationArea = all;
                }
                field("Filtre Service Vente"; rec."Filtre Service Vente")
                {
                    ApplicationArea = all;
                }
                field("Filtre Famille Article"; rec."Filtre Famille Article")
                {
                    ApplicationArea = all;
                }
                field("Filtre Magasin Min Max"; rec."Filtre Magasin Min Max")
                {
                    ApplicationArea = all;
                }
                field("Autoriser Réception Magasin Z4"; rec."Autoriser Réception Magasin Z4")
                {
                    ApplicationArea = all;
                }
                field("Validation Doc Achat Simuler"; rec."Validation Doc Achat Simuler")
                {
                    ApplicationArea = all;
                }
                field("Notifier DA Par Mail"; rec."Notifier DA Par Mail")
                {
                    ApplicationArea = all;
                }
                field(Mail; rec.Mail)
                {
                    ApplicationArea = all;
                }
                field("Notification Service Appro"; rec."Notification Service Appro")
                {
                    ApplicationArea = all;
                }
                field("Simulation Doc Achat"; rec."Simulation Doc Achat")
                {
                    ApplicationArea = all;
                }
                field("Souche Facture Vente"; rec."Souche Facture Vente")
                {
                    ApplicationArea = all;
                }*/
            field("Inventory Resp. Ctr. Filter"; Rec."Inventory Resp. Ctr. Filter")
            {
                ApplicationArea = all;
            }
        }


        addafter(PhoneNo)
        {
            /*   field("DA Approver"; Rec."DA Approver") { ApplicationArea = all; }

               field("Approver ID DA"; Rec."Approver ID DA") { ApplicationArea = all; }
               field(approver; Rec.approver) { ApplicationArea = all; }
               field("Treating PR"; Rec."Treating PR") { ApplicationArea = all; Visible = false; }

               field("PR Reopen permission"; Rec."PR Reopen permission") { ApplicationArea = all; }*/
            field("Réinitialiser statut à Approuver"; Rec."Réinitialiser statut à Approuver") { ApplicationArea = all; }

            //    field("Permission Print PR"; Rec."Permission Print PR") { ApplicationArea = all; }
            field("Default Location"; Rec."Default Location") { ApplicationArea = all; }
            /* field("Mgasin Origine Transf"; Rec."Mgasin Origine Transf")
             {
                 ApplicationArea = all;
             }*/
            field("Permission Data Editor"; Rec."Permission Data Editor") { ApplicationArea = all; }
            field("N° matériel Obligatoire"; Rec."N° matériel Obligatoire")
            {
                ApplicationArea = all;
            }
            field("Autoriser Modification Détail Marché"; Rec."Autoriser Modification Détail Marché")
            {
                ApplicationArea = all;
            }
            field("Autoriser Suppression Fichiers"; Rec."Autoriser Suppression Fichiers")
            {
                ApplicationArea = all;
            }
            field("Autoriser Filtre Gasoil"; rec."Autoriser Filtre Gasoil")
            {
                ApplicationArea = all;
            }
            field("Autoriser Filtre Pointage Véhicule"; rec."Autoriser Filtre Pointage Véhicule")
            {
                ApplicationArea = all;


            }
            field(Affaire; Rec.Affaire)
            {
                ApplicationArea = all;
            }
            field(Cuve; Rec.Cuve)
            {
                ApplicationArea = all;
            }
            field(Affectation; Rec.Affectation)
            {
                ApplicationArea = all;
            }
        }
    }






    actions
    {

        addfirst(creation)
        {
            action("Autorisation Magasin")
            {
                Caption = 'Store authorization';
                ApplicationArea = all;
                Visible = false;
                trigger OnAction()
                begin

                    //    RecAutorisationMagasin.SETFILTER("Code Utilisateur", rec."User ID");
                    //    page.RUNMODAL(Page::"Autorisation Magasin", RecAutorisationMagasin);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin

        // Vérifier si l'utilisateur connecté est ADMIN
        if UserId <> 'ADMIN' then
            Error('Accès refusé : vous n''êtes pas autorisé à ouvrir cette page.');
    end;

    var
        "// RB SORO": Integer;
    //   RecAutorisationMagasin: Record "Autorisation Magasin";
}

