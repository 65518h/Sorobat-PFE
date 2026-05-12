//GL3900 
// page 72017 "Liste model"
// {
//     //GL2024  ID dans Nav 2009 : "39002017"
//     Caption = 'Models list';
//     DelayedInsert = true;
//     Editable = true;
//     PageType = List;
//     SourceTable = model;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(cd_pattern; rec.cd_pattern)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Désignation; rec.Désignation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code famille"; rec."code famille")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_criticality_level; rec.typ_criticality_level)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_cancopy; rec.bo_cancopy)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_calender_constr; rec.cd_calender_constr)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Model)
//             {
//                 Caption = 'Model';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_pattern);
//                     ShortCutKey = 'Maj+F5';
//                 }

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(modèle),
//                                   "No." = FIELD(cd_pattern);
//                 }
//                 action("Parent model")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Parent model';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD("code famille");
//                 }

//             }
//         }
//     }
// }

