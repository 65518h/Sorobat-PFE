// page 50733 "Profil Magasin"
// {
//     ApplicationArea = All;
//     Caption = 'Tableau de bord Magasin';
//     PageType = RoleCenter;

//     layout
//     {
//         area(RoleCenter)
//         {
//             // Tu peux ajouter ici des tuiles ou part si nécessaire
//         }
//     }

//     actions
//     {
//         area(Embedding)
//         {
//             action("Liste Magasins")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Liste Magasins';
//                 RunObject = page "Location List";
//                 ToolTip = 'Consulter la liste des magasins';
//             }

//             // action("Fiche Article")
//             // {
//             //     ApplicationArea = Basic, Suite;
//             //     Caption = 'Fiche Article';
//             //     RunObject = page "Item Card";
//             //     ToolTip = 'Ouvrir la fiche article';
//             // }
//             action("Liste Articles")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Liste Articles';
//                 RunObject = page "Item List";
//                 ToolTip = 'Afficher la liste des articles';
//             }
//             // action("Commandes Achat")
//             // {
//             //     ApplicationArea = Basic, Suite;
//             //     Caption = 'Commandes Achat';
//             //     RunObject = page "Purchase Order";
//             //     ToolTip = 'Afficher les commandes d’achat';
//             // }
//             action("Liste Achats")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Liste Achats';
//                 RunObject = page "Purchase List";
//                 ToolTip = 'Afficher la liste des achats';
//             }
//             action("Réceptions Achat Validées")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Réceptions Achat Validées';
//                 RunObject = page "Posted Purchase Receipts";
//                 ToolTip = 'Afficher les réceptions d’achat validées';
//             }
//             action("Sous-Form. Retour achat")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Réceptions Achat Validées';
//                 RunObject = page "Purchase Return Order Subform";
//                 // ToolTip = 'Afficher les réceptions d’achat validées';
//             }
//             action("Agents d'expédition")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Agents d''expédition';
//                 RunObject = page "Shipping Agents";
//                 ToolTip = 'Gérer les agents d’expédition';
//             }
//             action("Fiche Emplacement")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Fiche Emplacement';
//                 RunObject = page "Location Card";
//                 ToolTip = 'Consulter la fiche d’un emplacement';
//             }
//             /*-    action("Ordre de Transfert")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Ordre de Transfert';
//                     RunObject = page "Transfer Order";
//                     ToolTip = 'Créer ou consulter des ordres de transfert';
//                 }*/
//             action("Liste Transferts")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Liste Transferts';
//                 RunObject = page 5742; //a voir
//                 ToolTip = 'Afficher la liste des transferts';
//             }
//             action("Sous-form Demande de Prix")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Demande de prix';
//                 RunObject = page "Sous-form. demande de prix"; //ListPart
//                 ToolTip = 'Consulter les demandes de prix';
//             }
//             action("Emplacement")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Emplacement';
//                 RunObject = page "Emplacement";
//                 ToolTip = 'Afficher la page Emplacement personnalisée';
//             }
//             action("Liste Utilisateurs")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Liste Utilisateurs';
//                 RunObject = page "Liste Utilisateurs";
//                 ToolTip = 'Afficher les utilisateurs';
//             }
//             action("Article par Magasin")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Article par Magasin';
//                 RunObject = page "Article Par Magasin"; //listPart
//                 ToolTip = 'Consulter les articles par magasin';
//             }
//             action("Retour Marchandise")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Retour Marchandise';
//                 RunObject = page "Liste Retour Marchandise"; //Card
//                 ToolTip = 'Créer ou gérer les retours de marchandise';
//             }
//             action("Emplacement Article")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Emplacement Article';
//                 RunObject = page "Emplacement Article";
//                 ToolTip = 'Voir l’emplacement des articles';
//             }
//             action("Commentaires Achat")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Commentaires Achat';
//                 RunObject = page "Commentaire Achat"; //ListPart
//                 ToolTip = 'Consulter les commentaires liés aux achats';
//             }
//             action("Rapport DG")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Rapport DG';
//                 RunObject = page "Regroupement Rapport DG"; //ListPart
//                 ToolTip = 'Voir les rapports regroupés DG';
//             }
//             action("Réceptions Non Stockables")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Réceptions Non Stockables';
//                 RunObject = page "Reception Non Stockable Liste"; //Card
//                 ToolTip = 'Afficher les réceptions non stockables';
//             }
//             action("Reordering Requisition")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Reordering Requisition';
//                 // RunObject = page "Reordering Requisition"; // Assurez-vous que cette page existe
//                 ToolTip = 'Gérer les réquisitions de réapprovisionnement';
//             }
//             action("Ventes NaviBat")
//             {
//                 ApplicationArea = Basic, Suite;
//                 Caption = 'Ventes NaviBat';
//                 RunObject = page "NaviBat Sales List";
//                 ToolTip = 'Afficher les ventes NaviBat';
//             }
//         }
//     }
// }
