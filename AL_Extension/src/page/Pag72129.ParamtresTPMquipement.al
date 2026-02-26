//GL3900 
// Page 72129 "Paramètres TPM équipement"
// {//GL2024  ID dans Nav 2009 : "39002129"
//     PageType = Card;
//     SourceTable = "TPM equipement";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(Genearl)
//             {
//                 Caption = 'Genearl';
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("code équipement"; Rec."code équipement")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Arrêt planifiés consommable"; Rec."Arrêt planifiés consommable")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Perte performance"; Rec."Perte performance")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("temps non qualité"; Rec."temps non qualité")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             group("Time Table")
//             {
//                 Caption = 'Time Table';
//                 field("Charge Lundi"; Rec."Charge Lundi")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("charge Mardi"; Rec."charge Mardi")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("charge Mercredi"; Rec."charge Mercredi")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Charge Jeudi"; Rec."Charge Jeudi")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("charge Vendredi"; Rec."charge Vendredi")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Charge Samedi"; Rec."Charge Samedi")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Charge Dimanche"; Rec."Charge Dimanche")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnQueryClosePage(CloseAction: action): Boolean
//     begin
//         ///testfield("Posting Date");


//         if ((Rec."Posting Date" > WorkDate) or (Rec."Posting Date" = 0D)) then begin
//             Message(txt);
//             exit(false);
//         end;

//         if ((Rec."Charge Lundi" = 0) and
//             (Rec."charge Mardi" = 0) and
//             (Rec."charge Mercredi" = 0) and
//             (Rec."Charge Jeudi" = 0) and
//             (Rec."charge Vendredi" = 0) and
//             (Rec."Charge Samedi" = 0) and
//             (Rec."Charge Dimanche" = 0)) then begin
//             Message(TXT1);
//             exit(false);
//         end;
//     end;

//     var
//         txt: label 'You can''t put date upper current date';
//         TXT1: label 'You must complete the equipment timetable';
// }

