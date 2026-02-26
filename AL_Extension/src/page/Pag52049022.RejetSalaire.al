// page 52049022 "Rejet Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001550"
//     PageType = Card;
//     SourceTable = "Entete Lot Paie";
//     SourceTableView = WHERE(Status = FILTER("En Cours"), Type = FILTER("Rejet Salaire"));
//     ApplicationArea = all;
//     Caption = 'Rejet Salaire';
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
//                 actionref("Inserer Ordre de Virement1"; "Inserer Ordre de Virement") { }
//                 actionref(Imprimer1; Imprimer) { }
//                 actionref(Valider11; Valider) { }
//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Inserer Ordre de Virement")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Inserer Ordre de Virement';

//                     trigger OnAction()
//                     begin
//                         rec.TESTFIELD("Code Banque");
//                         FormPrepRejetSal.GetParametres(rec.Code, rec."Code Banque");
//                         FormPrepRejetSal.RUN;
//                     end;
//                 }
//                 separator(separator200)
//                 {
//                 }
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
//                 separator(separator100)
//                 {
//                 }
//                 action(Valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';

//                     trigger OnAction()
//                     begin
//                         RecLigneLotPaie.SETRANGE(Code, rec.Code);
//                         //RecLigneLotPaie.SETRANGE("Code Banque","Code Banque");
//                         IF RecLigneLotPaie.FINDFIRST THEN BEGIN
//                             REPEAT
//                                 RecLigneLotPaie.Status := RecLigneLotPaie.Status::Validée;
//                                 RecLigneLotPaie.MODIFY;
//                             UNTIL RecLigneLotPaie.NEXT = 0;
//                             rec.Status := rec.Status::Validée;
//                             rec.MODIFY;
//                             MESSAGE(Text003);
//                         END
//                         ELSE
//                             ERROR(Text002);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         RecHumanResourcesSetup.GET;
//         rec.Code := NoSeriesMgt.GetNextNo(RecHumanResourcesSetup."Rejet Salaire", 0D, TRUE);
//         rec."Date Creation" := TODAY;
//         rec.User := UPPERCASE(USERID);
//         rec.Type := rec.Type::"Rejet Salaire";
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecHumanResourcesSetup: Record "Human Resources Setup";
//         Text001: Label 'Erreur, Vous devez selectionner une banque !!!';
//         FormPrepRejetSal: page "Preparation Rejet Salaire";
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         Text002: Label 'il n a rien à validé';
//         RecSalaryLines: Record "Salary Lines";
//         Text003: Label 'Validation Effectuée';
//         RecSalaryLinesEnreg: Record "Rec. Salary Lines";
//         Affectation: Code[20];
//         RecLignieLotPaieImpr: Record "Ligne Lot Paie";
// }

