//GL3900 
// Page 72066 "Site parent"
// {
//     //GL2024  ID dans Nav 2009 : "39002066"
//     PageType = Card;
//     SourceTable = Liens;

//     Caption = 'Site parent';

//     ApplicationArea = all;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             field(cd_site; Rec.cd_site)
//             {
//                 ApplicationArea = Basic;
//             }
//             field(cd_box_link; Rec.cd_box_link)
//             {
//                 ApplicationArea = Basic;
//                 Visible = false;
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Rec.typ_subtype := '3';
//     end;
// }

