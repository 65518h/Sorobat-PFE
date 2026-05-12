// Page 50093 "Notification Fréquence Min-Max"
// {
//     DeleteAllowed = false;
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "Notification Reception";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Notification Fréquence Min-Max';

//     layout
//     {
//         area(content)
//         {
//             label("NOUVELLE NOTIFICATION MIN - MAX")
//             {
//                 ApplicationArea = all;

//                 Style = Strong;
//                 StyleExpr = true;
//                 Caption = 'NEW MIN - MAX NOTIFICATION';
//             }
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Article; rec.Article)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Item No.';
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Quantité Alerte Min Max"; rec."Quantité Alerte Min Max")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Min"; rec.Min)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Max"; rec.Max)
//                 {
//                     ApplicationArea = all;
//                 }
//             }

//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("ARCHIVER TOUT")
//             {
//                 ApplicationArea = all;
//                 Caption = 'ARCHIVE ALL';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     NotificationMinMax.SetRange(Archiver, false);
//                     NotificationMinMax.SetRange("Type Notification", NotificationMinMax."type notification"::"Min Max");
//                     NotificationMinMax.ModifyAll(Archiver, true);
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         rec.SetRange(Archiver, false);
//         rec.SetRange("Type Notification", rec."type notification"::"Min Max");
//     end;

//     var
//         NotificationMinMax: Record "Notification Reception";
//         Tout: Boolean;

// }

