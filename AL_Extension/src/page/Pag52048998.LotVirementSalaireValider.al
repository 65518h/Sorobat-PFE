// page 52048998 "Lot Virement Salaire Valider"
// {
//     //GL2024  ID dans Nav 2009 : "39001526"
//     Editable = false;
//     PageType = card;
//     SourceTable = "Entete Lot Paie";
//     SourceTableView = WHERE(Status = FILTER(Validée),
//                             Type = FILTER(Bordereau));
//     ApplicationArea = all;
//     InsertAllowed = false;
//     DeleteAllowed = false;
//     ModifyAllowed = false;


//     Caption = 'Lot Virement Salaire Valider';
//     layout
//     {
//         area(content)
//         {
//             field(Code; rec.Code)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Code Banque"; rec."Code Banque")
//             {
//                 ApplicationArea = all;
//             }
//             field("Date Creation"; rec."Date Creation")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field(Status; rec.Status)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }

//             field("Nom Banque"; rec."Nom Banque")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field(Mois; rec.Mois)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Mantant Net"; rec."Mantant Net")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Total Mantant Net';
//                 DecimalPlaces = 3 : 3;
//                 Style = Strong;
//                 StyleExpr = TRUE;
//             }
//             field(Annee; rec.Annee)
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Code Affectation"; rec."Code Affectation")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Description Affectation"; rec."Description Affectation")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             part("SubForm Lot Virement Salaire V"; "SubForm Lot Virement Salaire V")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = Code = FIELD(Code),
//                               "Code Banque" = FIELD("Code Banque");
//             }
//         }
//     }

//     actions
//     {

//         area(Promoted)
//         {
//             group(Fonction1)
//             {
//                 Caption = 'Fonction';
//                 actionref("Imprimer Paie En Cours1"; "Imprimer Paie En Cours") { }
//                 actionref("Imprimer Paie Valider1"; "Imprimer Paie Valider") { }
//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Imprimer Paie En Cours")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer Paie En Cours';

//                     trigger OnAction()
//                     begin
//                         RecSalaryLines.SETRANGE("Lot Virement Salaire", rec.Code);
//                         //RecSalaryLines.SETRANGE("Code Banque Virement","Code Banque");
//                         REPORT.RUNMODAL(39001410, TRUE, FALSE, RecSalaryLines);
//                     end;
//                 }
//                 action("Imprimer Paie Valider")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer Paie Valider';

//                     trigger OnAction()
//                     begin
//                         RecSalaryLinesEnreg.SETRANGE("Lot Virement Salaire", rec.Code);
//                         REPORT.RUNMODAL(50172, TRUE, FALSE, RecSalaryLinesEnreg);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         RecSalaryLines: Record "Salary Lines";
//         RecSalaryLinesEnreg: Record "Rec. Salary Lines";
// }

