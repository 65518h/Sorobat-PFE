// page 52048996 "Lot Virement Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001524"
//     PageType = Card;
//     SourceTable = "Entete Lot Paie";
//     SourceTableView = WHERE(Status = FILTER("En Cours"), Type = FILTER(Bordereau));
//     RefreshOnActivate = true;


//     Caption = 'Lot Virement Salaire';

//     layout
//     {
//         area(content)
//         {
//             field(Code; rec.Code)
//             {
//                 ApplicationArea = all;
//                 Editable = false;

//             }
//             field("Code Affectation"; rec."Code Affectation")
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
//             field("Description Affectation"; rec."Description Affectation")
//             {
//                 ApplicationArea = all;
//                 Editable = false;

//             }
//             part("SubForm Lot Virement Salaire"; "SubForm Lot Virement Salaire")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = Code = FIELD(Code);
//                 UpdatePropagation = Both;
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
//                 actionref("Inserer Ligne Salaire1"; "Inserer Ligne Salaire")
//                 { }
//                 actionref("Inserer Ligne Salaire Enregistré1"; "Inserer Ligne Salaire Enregistré") { }

//                 actionref(Imprimer1; Imprimer) { }
//                 actionref(Valider1; Valider) { }
//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Inserer Ligne Salaire")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Inserer Ligne Salaire';

//                     trigger OnAction()
//                     begin
//                         rec.TESTFIELD("Code Affectation");
//                         FormPrepLotSal.GetParametres(rec.Code, rec."Code Affectation");
//                         FormPrepLotSal.RUN;
//                     end;
//                 }
//                 action("Inserer Ligne Salaire Enregistré")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Inserer Ligne Salaire Enregistré';

//                     trigger OnAction()
//                     begin
//                         rec.TESTFIELD("Code Affectation");
//                         FormPrepLotSalEnreg.GetParametres(rec.Code, rec."Code Affectation");
//                         FormPrepLotSalEnreg.RUN;
//                     end;
//                 }
//                 separator(separator1)
//                 {
//                 }
//                 action(Imprimer)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer';

//                     trigger OnAction()
//                     begin
//                         RecLignieLotPaieImpr.SETRANGE(Code, rec.Code);
//                         REPORT.RUNMODAL(50244, TRUE, FALSE, RecLignieLotPaieImpr);
//                     end;
//                 }
//                 separator(separator3)
//                 {
//                 }
//                 action(Valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';

//                     trigger OnAction()
//                     begin
//                         RecLigneLotPaie.SETRANGE(Code, rec.Code);
//                         RecLigneLotPaie.SETRANGE("Code Banque", rec."Code Banque");
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
//         rec.Code := NoSeriesMgt.GetNextNo(RecHumanResourcesSetup."Bordereau Paie", 0D, TRUE);
//         rec."Date Creation" := TODAY;
//         rec.User := UPPERCASE(USERID);
//         rec.Type := rec.Type::Bordereau;
//     end;

//     var
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         RecHumanResourcesSetup: Record "Human Resources Setup";
//         FormPrepLotSal: page "Preparation Lot Virement Salar";
//         Text001: Label 'Erreur, Vous devez selectionner une banque !!!';
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         Text002: Label 'il n a rien à validé';
//         RecSalaryLines: Record "Salary Lines";
//         Text003: Label 'Validation Effectuée';
//         RecSalaryLinesEnreg: Record "Rec. Salary Lines";
//         FormPrepLotSalEnreg: page "Prepa Lot Virement Salar Enreg";
//         Affectation: Code[20];
//         RecLignieLotPaieImpr: Record "Ligne Lot Paie";
// }

