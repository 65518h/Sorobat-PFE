// Page 50213 "Liste Vir Salaire Valider"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "Ligne Lot Paie";
//     SourceTableView = where(Status = const(Validée));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste Vir Salaire Valider';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code"; REC.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Banque"; REC."Code Banque")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Matricule Salarié"; REC."Matricule Salarié")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Salarie"; REC."Nom Salarie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(RIB; REC.RIB)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant Net"; REC."Montant Net")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Num Paie"; REC."Num Paie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Banque Salarié"; REC."Banque Salarié")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Affectation"; REC."Code Affectation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Type; REC.Type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Ordre Virement Salaire"; REC."Ordre Virement Salaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Selection; REC.Selection)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Rejet Salaire"; REC."Rejet Salaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Mois; REC.Mois)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Annee; REC.Annee)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

