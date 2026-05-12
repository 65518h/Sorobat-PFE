//GL3900 
// Page 72131 INDICATEURS
// {//GL2024  ID dans Nav 2009 : "39002131"
//     Caption = 'Analyse';
//     Editable = false;
//     PageType = List;
//     SourceTable = "TPM equipement";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(Working)
//             {
//                 Caption = 'Working';
//                 field(A; Rec.A)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Temps d activité total"; Rec."Temps d activité total")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(B; Rec.B)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("temps de marche total"; Rec."temps de marche total")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(C; Rec.C)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(D; Rec.D)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(Failure)
//             {
//                 Caption = 'Failure';
//                 field("nombre d'arrêt"; Rec."nombre d'arrêt")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("temps d'arrêt total"; Rec."temps d'arrêt total")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(Rate)
//             {
//                 Caption = 'Rate';
//                 field(Tb; Rec.Tb)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Tp; Rec.Tp)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Tq; Rec.Tq)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(TRS; Rec.TRS)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group(Indicative)
//             {
//                 Caption = 'Indicative';
//                 field(MTTR; Rec.MTTR)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(MTBF; Rec.MTBF)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Disponibilité"; Rec.Disponibilité)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Lancer calcul Indicateur")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Lancer calcul Indicateur';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         if not Confirm(Text001, false) then exit;
//                         RecTpmEquip.Copy(Rec);
//                         Rec.ComputeValues(RecTpmEquip);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         Text001: label 'Lancer Le Calcul ?';
//         RecTpmEquip: Record "TPM equipement";
// }

