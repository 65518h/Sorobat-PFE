// Page 52049062 "Subform Organe"
// {//GL2024  ID dans Nav 2009 : "39004766"
//     PageType = ListPart;
//     SourceTable = "Véhicule";
//     SourceTableView = sorting("N° Vehicule")
//                       where(Organe = const(true));
//     ApplicationArea = All;
//     Caption = 'Subform Organe';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 Editable = false;
//                 field("No Vehicule"; REC."N° Vehicule")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Désignation"; Rec.Désignation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Num Moteur"; Rec."Num Moteur")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Kms Parcourus"; Rec."Kms Parcourus")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Organe; Rec.Organe)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }
// }

