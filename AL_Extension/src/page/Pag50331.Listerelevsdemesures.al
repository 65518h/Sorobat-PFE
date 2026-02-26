// page 50331 "Liste relevés de mesures"
// {//GL2024 NEW PAGE
//     Caption = 'Liste relevés de mesures';
//     DeleteAllowed = true;
//     Editable = true;
//     ModifyAllowed = true;
//     PageType = list;
//     SourceTable = "Relevé mesures";
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     CardPageId = "Relevé mesures";

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 Caption = 'Général';
//                 field("N°"; REC."N°")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Date Mesure"; REC."Date Mesure")
//                 {
//                     ApplicationArea = All;

//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field("Code Releveur"; REC."Code Releveur")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field(Releveur; REC.Releveur)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Filter Affectation"; REC."Filter Affectation")
//                 {
//                     ApplicationArea = All;

//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Filter Sous Famille"; REC."Filter Sous Famille")
//                 {
//                     ApplicationArea = All;
//                     // DecimalPlaces = 0 : 0;

//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }

//         }
//     }


// }

