// page 52049018 "Ordre Virement Salaire Validé"
// {
//     //GL2024  ID dans Nav 2009 : "39001546"
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Entete Lot Paie";
//     SourceTableView = WHERE(Status = FILTER(Validée), Type = FILTER("Ordre Virement"));

//     Caption = 'Ordre Virement Salaire Validé';
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

//             field("Mantant Net"; rec."Mantant Net")
//             {
//                 ApplicationArea = all;
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//             }
//             field("Nom Banque"; rec."Nom Banque")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field("Code Affectation"; rec."Code Affectation")
//             {
//                 ApplicationArea = all;
//             }
//             field("Description Affectation"; rec."Description Affectation")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field(Mois; rec.Mois)
//             {
//                 ApplicationArea = all;
//             }
//             field(Annee; rec.Annee)
//             {
//                 ApplicationArea = all;
//             }
//             part("SubForm Ordre Virement Salaire"; "SubForm Ordre Virement Salaire")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = Code = FIELD(Code);
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

//                 actionref(Imprimer1; Imprimer) { }
//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';

//                 action(Imprimer)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer';

//                     trigger OnAction()
//                     begin
//                         RecLignieLotPaieImpr.SETRANGE(Code, rec.Code);
//                         REPORT.RUNMODAL(50245, TRUE, FALSE, RecLignieLotPaieImpr);
//                     end;
//                 }

//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         RecHumanResourcesSetup.GET;
//         rec.Code := NoSeriesMgt.GetNextNo(RecHumanResourcesSetup."Lot Paie", 0D, TRUE);
//         rec."Date Creation" := TODAY;
//         rec.User := UPPERCASE(USERID);
//         rec.Type := rec.Type::"Ordre Virement";
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecHumanResourcesSetup: Record "Human Resources Setup";
//         Text001: Label 'Erreur, Vous devez selectionner une banque !!!';
//         FormPrepOrdreViret: page "Preparation Bordereau Salaire";
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         Text002: Label 'il n a rien à validé';
//         RecSalaryLines: Record "Salary Lines";
//         Text003: Label 'Validation Effectuée';
//         RecSalaryLinesEnreg: Record "Rec. Salary Lines";
//         Affectation: Code[20];
//         RecLignieLotPaieImpr: Record "Ligne Lot Paie";
// }

