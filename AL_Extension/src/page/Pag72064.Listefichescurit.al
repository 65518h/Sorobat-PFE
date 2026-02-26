//GL3900 
// page 72064 "Liste fiche sécurité"
// {
//     //GL2024  ID dans Nav 2009 : "39002064"
//     Caption = 'Security cards list';
//     Editable = false;
//     PageType = List;
//     SourceTable = "Fiche securité";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("code fiche securite"; rec."code fiche securite")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Libellé; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user; rec.user)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dttm_creation; rec.dttm_creation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user_modify; rec.user_modify)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_last_modif; rec.dt_last_modif)
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
//             group("Security card")
//             {
//                 Caption = 'Security card';
//                 action(Fiche)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fiche';
//                     RunObject = Page "Fiche de sécurité";
//                     RunPageLink = "code fiche securite" = FIELD("code fiche securite");
//                     ShortCutKey = 'Maj+F5';
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(securité),
//                                   "No." = FIELD("code fiche securite");
//                 }
//             }
//         }
//     }
// }

