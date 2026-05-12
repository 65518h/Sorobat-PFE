//GL3900 
// Page 72112 "Comment List gmao"
// {
//     //GL2024  ID dans Nav 2009 : "39002112"
//     Caption = 'Comment List';
//     DataCaptionFields = "No.";
//     Editable = false;
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

//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
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
// }

