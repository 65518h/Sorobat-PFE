// Table 39004798 "Copie Table Entet Achat"
// {
//     //GL2024  ID dans Nav 2009 : "39004798"
//     fields
//     {
//         field(1; "Type Document"; Option)
//         {
//             OptionCaption = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour,,,,,Note de frais,Abonnement';
//             OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",,,,,"Note of Expenses",Subscription;
//         }
//         field(2; "N° Document"; Code[20])
//         {
//         }
//         field(3; "N° Demande d'achat"; Code[20])
//         {
//         }
//         field(4; "N° DA Chantier"; Code[20])
//         {
//         }
//         field(5; "Date DA"; Date)
//         {
//         }
//         field(6; "N° Devis Fournisseur"; Code[20])
//         {
//         }
//         field(7; "Code acheteur"; Code[10])
//         {
//         }
//         field(8; "Pays provenance"; Code[10])
//         {
//         }
//         field(9; "Code condition paiement"; Code[10])
//         {
//         }
//         field(10; "Observation 1"; Text[160])
//         {
//         }
//         field(11; "Observation 2"; Text[100])
//         {
//         }
//         field(12; "Observation 3"; Text[50])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; "Type Document", "N° Document")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//     }
// }

