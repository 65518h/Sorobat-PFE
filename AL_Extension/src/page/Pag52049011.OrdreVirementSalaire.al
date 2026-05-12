// page 52049011 "Ordre Virement Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001539"
//     PageType = Card;
//     SourceTable = "Entete Lot Paie";
//     SourceTableView = WHERE(Status = FILTER("En Cours"), Type = FILTER("Ordre Virement"));
//     ApplicationArea = all;

//     Caption = 'Ordre Virement Salaire';

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
//             field("Nom Banque"; rec."Nom Banque")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
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
//                 Style = Strong;
//                 StyleExpr = TRUE;
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
//                 actionref("Inserer Bordereau de Salaire1"; "Inserer Bordereau de Salaire") { }
//                 actionref(Imprimer1; Imprimer) { }
//                 actionref(Valider1; Valider) { }
//             }
//         }

//         area(navigation)
//         {
//             Group("Disquette Virement")
//             {
//                 action("Disquette Virement STB")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement STB';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement STB';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement STB";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BTE")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BTE';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BTE';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BTE";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BNA")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BNA';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BNA';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BNA";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BNA Enreg")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BNA Enreg';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BNA Enreg';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BNA Enreg";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement BTE Enreg")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement BTE Enreg';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement BTE Enreg';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement BTE 02";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;
//                 }

//                 action("Disquette Virement QNB")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement QNB';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement QNB';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement QNB";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();
//                     end;

//                 }

//                 action("Disquette Virement TSB")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Disquette Virement TSB';
//                     Image = FileContract;
//                     ToolTip = 'Disquette Virement TSB';
//                     trigger OnAction()
//                     var
//                         RecEnteteLotPaie: Record "Entete Lot Paie";
//                         DisquetteVirement: xmlport "Disquette Virement TSB";
//                     begin
//                         DisquetteVirement.GetFILTER(rec.Code, rec."Code Banque");
//                         DisquetteVirement.Run();

//                     end;
//                 }
//             }
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Inserer Bordereau de Salaire")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Inserer Bordereau de Salaire';

//                     trigger OnAction()
//                     begin
//                         rec.TESTFIELD("Code Banque");
//                         FormPrepOrdreViret.GetParametres(rec.Code, rec."Code Banque");
//                         FormPrepOrdreViret.RUN;
//                     end;
//                 }
//                 separator(separator100)
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
//                 separator(separator200)
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

