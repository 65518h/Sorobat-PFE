// page 52049013 "Preparation Bordereau Salaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001541"
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Entete Lot Paie";
//     SourceTableView = sorting(Code)
//                       where(Type = filter(Bordereau),
//                             "Ordre Virement Salaire" = filter(''),
//                             Status = filter(Validée));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Preparation Bordereau Salaire';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Mantant Net"; Rec."Mantant Net")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Inserer en Ordre Virement Sala"; Rec."Inserer en Ordre Virement Sala")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Sélectionner';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Date Creation"; Rec."Date Creation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Mois; Rec.Mois)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Annee; Rec.Annee)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Code Affectation"; Rec."Code Affectation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Description Affectation"; Rec."Description Affectation")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Valider)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text001) then exit;
//                     RecLignieOrdreVrmtSalaire.Reset;
//                     RecLignieOrdreVrmtSalaire.SetRange(Code, CodeOrdreViremtSalaire);
//                     Rec.SetRange("Inserer en Ordre Virement Sala", true);
//                     if Rec.FindFirst then
//                         repeat
//                             RecLignieBordereauSalaire.Reset;
//                             RecLignieBordereauSalaire.SetRange(Code, Rec.Code);
//                             if RecLignieBordereauSalaire.FindFirst then
//                                 repeat
//                                     RecLignieOrdreVrmtSalaire.Code := CodeOrdreViremtSalaire;
//                                     RecLignieOrdreVrmtSalaire."Code Banque" := CodeBqVirmSalaire;
//                                     RecLignieOrdreVrmtSalaire.Validate("Matricule Salarié", RecLignieBordereauSalaire."Matricule Salarié");
//                                     RecLignieOrdreVrmtSalaire."Montant Net" := RecLignieBordereauSalaire."Montant Net";
//                                     RecLignieOrdreVrmtSalaire.Status := RecLignieOrdreVrmtSalaire.Status::"En Cours";
//                                     RecLignieOrdreVrmtSalaire."Num Paie" := RecLignieBordereauSalaire."Num Paie";
//                                     RecLignieOrdreVrmtSalaire."Code Affectation" := RecLignieBordereauSalaire."Code Affectation";
//                                     RecLignieOrdreVrmtSalaire.Type := RecLignieOrdreVrmtSalaire.Type::"Ordre Virement";
//                                     if not RecLignieOrdreVrmtSalaire.Modify then RecLignieOrdreVrmtSalaire.Insert;
//                                 until RecLignieBordereauSalaire.Next = 0;
//                             // Insertion Code Order Virement Salaire dans Lignie Bordereau Virement Salaire
//                             RecMAJBordVirtSar.Reset;
//                             RecMAJBordVirtSar.SetRange(Code, Rec.Code);
//                             if RecMAJBordVirtSar.FindFirst then
//                                 repeat
//                                     RecMAJBordVirtSar."Ordre Virement Salaire" := CodeOrdreViremtSalaire;
//                                     RecMAJBordVirtSar.Modify;
//                                 until RecMAJBordVirtSar.Next = 0;
//                             // Insertion de Code Order Virement Salaire et Code de la banque dans la Lignie de Salaire ou Lignie de Salaire Enregestrie
//                             RecMAJSalaryLines.Reset;
//                             RecMAJSalaryLines.SetRange("Lot Virement Salaire", Rec.Code);
//                             if RecMAJSalaryLines.FindFirst then
//                                 repeat
//                                     RecMAJSalaryLines."Ordre Virement Salaire" := CodeOrdreViremtSalaire;
//                                     RecMAJSalaryLines."Code Banque Virement" := CodeBqVirmSalaire;
//                                     RecMAJSalaryLines.Modify;
//                                 until RecMAJSalaryLines.Next = 0;
//                             RecMAJSalaryLinesEnreg.Reset;
//                             RecMAJSalaryLinesEnreg.SetRange("Lot Virement Salaire", Rec.Code);
//                             if RecMAJSalaryLinesEnreg.FindFirst then
//                                 repeat
//                                     RecMAJSalaryLinesEnreg."Ordre Virement Salaire" := CodeOrdreViremtSalaire;
//                                     RecMAJSalaryLinesEnreg."Code Banque Virement" := CodeBqVirmSalaire;
//                                     RecMAJSalaryLinesEnreg.Modify;
//                                 until RecMAJSalaryLinesEnreg.Next = 0;
//                             //
//                             Rec."Inserer en Ordre Virement Sala" := false;
//                             Rec."Ordre Virement Salaire" := CodeOrdreViremtSalaire;
//                             Rec.Modify;
//                         until Rec.Next = 0;
//                     CurrPage.Close;
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         GetParametres(CodeOrdreViremtSalaire, CodeBqVirmSalaire);
//         Rec.FilterGroup(2);
//         Rec.SetFilter("Ordre Virement Salaire", '%1', ' ');
//         Rec.FilterGroup(0);
//     end;

//     var
//         CodeOrdreViremtSalaire: Code[20];
//         CodeBqVirmSalaire: Code[20];
//         RecLignieOrdreVrmtSalaire: Record "Ligne Lot Paie";
//         Text001: label 'Confirmer l''ordre de Virement ?';
//         RecLignieBordereauSalaire: Record "Ligne Lot Paie";
//         RecMAJBordVirtSar: Record "Ligne Lot Paie";
//         RecMAJSalaryLinesEnreg: Record "Rec. Salary Lines";
//         RecMAJSalaryLines: Record "Salary Lines";


//     procedure GetParametres(ParmCodeOrdre: Code[20]; ParmCodeBq: Code[20])
//     begin
//         CodeOrdreViremtSalaire := ParmCodeOrdre;
//         CodeBqVirmSalaire := ParmCodeBq;
//     end;
// }

