//GL3900 
// page 72055 "Fiche de sécurité"
// {//GL2024  ID dans Nav 2009 : "39002055"
//     PageType = Card;
//     SourceTable = "Fiche securité";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Fiche de sécurité';
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code fiche securite"; rec."code fiche securite")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Libellé; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dttm_creation; rec.dttm_creation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user; rec.user)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_last_modif; rec.dt_last_modif)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user_modify; rec.user_modify)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             label(Risks)
//             {
//                 ApplicationArea = all;
//                 CaptionClass = Text19053330;
//             }
//             part("Liste risque sécurité"; "Liste risque sécurité")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = cd_fiche_securité = FIELD("code fiche securite");
//             }
//             label(Preventions)
//             {
//                 ApplicationArea = all;
//                 CaptionClass = Text19006919;
//             }
//             part("Liste prevention securité"; "Liste prevention securité")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = cd_fiche_securité = FIELD("code fiche securite");
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

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         rec.user := USERID;
//         rec.user_modify := USERID;
//         rec.dttm_creation := TODAY;
//         rec.dt_last_modif := TODAY;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         rec.user_modify := USERID;
//     end;

//     var
//         Text19053330: Label 'Risks';
//         Text19006919: Label 'Preventions';
// }

