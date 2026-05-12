// page 52049045 "Traitement d'vancement auto."
// {//GL2024  ID dans Nav 2009 : "39001573"
//     PageType = List;
//     SourceTable = Employee;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Traitement d''vancement auto.';
//     layout
//     {
//         area(content)
//         {
//             label(Control1120028)
//             {
//                 ApplicationArea = Basic;
//                 //CaptionClass = Text19014219;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             repeater(Control1120000)
//             {
//                 ShowCaption = false;
//                 Editable = false;
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("First And Last Name"; Rec."First Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Last Name"; Rec."Last Name")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Job Title"; Rec."Job Title")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employment Date"; Rec."Employment Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Upgrading date Cat/Echelon"; Rec."Upgrading date Cat/Echelon")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Employee's type"; Rec."Employee's type")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Collège"; Rec.Collège)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Echellon; Rec.Echellon)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Basis salary"; Rec."Basis salary")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }

//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(Imprimer)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Imprimer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin

//                     salarie.SetRange("No.", Rec."No.");
//                     Report.RunModal(39001472, true, true, salarie);
//                 end;
//             }
//             action(Valider)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin

//                     salarie.SetRange("No.", Rec."No.");

//                     Report.RunModal(39001473, true, true, salarie);
//                 end;
//             }
//         }
//     }

//     trigger OnDeleteRecord(): Boolean
//     begin
//         Error(TEXT02)
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Error(TEXT01)
//     end;

//     trigger OnOpenPage()
//     begin
//         Rec.SetFilter("Upgrading date Cat/Echelon", '<%1', Today);
//         Rec.SetFilter("Hors Grille", '%1', false)
//     end;

//     var
//         echelon: Record "Collège";
//         TEXT01: label 'Vous avez atteint la limite des lignes';
//         TEXT02: label 'Impossible de supprimer cette ligne';
//         salarie: Record Employee;
//         Text19014219: label 'Traitement d'' avancement automatique des salaires ';
// }

