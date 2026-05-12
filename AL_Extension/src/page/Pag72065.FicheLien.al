//GL3900 
// Page 72065 "Fiche Lien"
// {
//     //GL2024  ID dans Nav 2009 : "39002065"
//     PageType = Card;
//     SourceTable = shelter;

//     Caption = 'Fiche Lien';

//     ApplicationArea = all;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field(cd_box; Rec.cd_box)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(cd_register_link; Rec.cd_register_link)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(dttm_link_begin; Rec.dttm_link_begin)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(dttm_link_end; Rec.dttm_link_end)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         Rec.type := 1;
//         Rec.dttm_link_begin := Today;
//     end;
// }

