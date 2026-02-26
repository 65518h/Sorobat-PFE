//GL3900 
// Page 72111 "Comment Sheet gmao"
// {
//     //GL2024  ID dans Nav 2009 : "39002111"
//     AutoSplitKey = true;
//     Caption = 'Maintenance Comment Sheet ';
//     DataCaptionFields = "No.";
//     DelayedInsert = true;
//     MultipleNewLines = true;
//     PageType = List;
//     SourceTable = "Comment Line Gmao";
//     ApplicationArea = all;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;

//                 field(Date; Rec.Date)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Comment; Rec.Comment)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Visible = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         Rec.SetUpNewLine;
//     end;
// }

