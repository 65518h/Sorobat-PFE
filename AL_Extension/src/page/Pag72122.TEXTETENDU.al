//GL3900 
// Page 72122 "TEXT ETENDU"
// {//GL2024  ID dans Nav 2009 : "39002122"
//     AutoSplitKey = true;
//     Caption = 'Maintenance Comment Sheet ';
//     DataCaptionFields = "No.";
//     DelayedInsert = true;
//     MultipleNewLines = true;
//     PageType = ListPart;
//     SourceTable = "Comment Line Gmao";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Comment; Rec.Comment)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Description';
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

