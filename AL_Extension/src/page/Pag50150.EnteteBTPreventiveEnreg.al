// page 50150 "Entete BT Preventive Enreg"
// {
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Entete BT Enreg";
//     SourceTableView = SORTING(Code)
//                       WHERE(Type = FILTER(Preventive));
//     Caption = 'BT Preventive Enreg';

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
//                     Editable = false;
//                 }
//                 field(Gamme; rec.Gamme)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Status; rec.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; rec.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Lancement"; rec."Date Lancement")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
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
//                 field("Designiation Gamme"; rec."Designiation Gamme")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Frequence; rec.Frequence)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Immatriculation; rec.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field(Utilisateur; rec.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }

//                 field("Index Actuelle"; rec."Index Actuelle")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Atelier; rec.Atelier)
//                 {
//                     ApplicationArea = all;
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
//             /* GL2024 group("Mode Operatoire")
//               {
//                   Caption = 'Mode Operatoire';
//                   part(; 39004775)
//                   {    ApplicationArea = all;
//                       SubPageLink = Code Gamme=FIELD(Gamme);
//                   }
//               }
//               group(Intervenants)
//               {
//                   Caption = 'Intervenants';
//                   part(; 39004778)
//                   {    ApplicationArea = all;
//                       SubPageLink = Code BT=FIELD(Code);
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

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         ERROR(Text001);
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     var
//         Text001: Label 'Erreur !!! Vous ne pouvez pas crier un BT Preventive !!!';
//         RecEquipement: Record "Véhicule";
//         CuGMAOParc: Codeunit "Soroubat cdu";
//         RecEnteteBT: Record "Entete BT";
//         RecEnteteBTEnreg: Record "Entete BT Enreg";

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         rec."Cout BT" := rec."Cout Article" + rec."Cout Main d'oeuvre";
//     end;
// }

