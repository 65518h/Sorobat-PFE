// Page 50188 "Ligne Virement de Salaire"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "Ligne Lot Paie";
//     SourceTableView = sorting(Code, "Matricule Salarié")
//                       where(Type = filter(Bordereau));
//     ApplicationArea = all;
//     Caption = 'Ligne Virement de Salaire';
//     UsageCategory = Lists;
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
//                 field("Ordre Virement Salaire"; REC."Ordre Virement Salaire")
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

