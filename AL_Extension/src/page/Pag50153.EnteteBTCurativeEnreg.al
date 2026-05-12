// page 50153 "Entete BT Curative Enreg"
// {
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Entete BT Enreg";
//     SourceTableView = SORTING(Code)
//                       WHERE(Type = FILTER(Curative));
//     Caption = 'BT Curative Enreg';

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';

//                 field(Code; rec.Code)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Type; rec.Type)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Equipement; rec.Equipement)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Immatriculation; rec.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field(Observation; rec.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Lancement"; rec."Date Lancement")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Date Traitement"; rec."Date Traitement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designiation Equipement"; rec."Designiation Equipement")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Index Actuelle"; rec."Index Actuelle")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Utilisateur; rec.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }

//             }

//             group(Mission)
//             {
//                 Caption = 'Mission';
//                 field(Chauffeur; rec.Chauffeur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vehicule Mission"; rec."Vehicule Mission")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Coût")
//             {
//                 Caption = 'Coût';
//                 field("Cout Article"; rec."Cout Article")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Cout Main d'oeuvre"; rec."Cout Main d'oeuvre")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Cout BT"; rec."Cout BT")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//             group(Articles)
//             {
//                 Caption = 'Articles';
//                 part("Subform Ligne BT Enre"; "Subform Ligne BT Enre")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code BT" = FIELD(Code);
//                 }
//             }
//             /* GL2024 group(Intervenants)
//               {
//                   Caption = 'Intervenants';
//                   part(; 39004778)
//                   { ApplicationArea = all;
//                       SubPageLink = Code BT=FIELD(Code);
//                   }
//               }
//               group("Diagnostic et réparation")
//               {
//                   Caption = 'Diagnostic et réparation';
//                   part(; 39004782)
//                   { ApplicationArea = all;
//                       SubPageLink = BT = FIELD(Code);
//                   }
//               }*/
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Imprimer)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Imprimer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin

//                     RecEnteteBTEnreg.SETRANGE(Code, rec.Code);
//                     REPORT.RUNMODAL(50218, TRUE, TRUE, RecEnteteBTEnreg);
//                 end;
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         IF RecParametreParc.GET() THEN;
//         rec.Code := NoSeriesMgt.GetNextNo(RecParametreParc."Code BT Curative", 0D, TRUE);
//         rec.Type := rec.Type::Curative;
//     end;

//     var
//         RecParametreParc: Record "Paramétre Parc";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         CuGMAOParc: Codeunit "Soroubat cdu";
//         RecEnteteBT: Record "Entete BT";
//         RecEnteteBTEnreg: Record "Entete BT Enreg";
// }

