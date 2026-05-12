//GL3900 
// page 72071 "Liste OT"
// {
//     //GL2024  ID dans Nav 2009 : "39002071"
//     Editable = false;
//     PageType = List;
//     SourceTable = OT;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste OT';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("code OT"; rec."code OT")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; rec.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_box; rec.cd_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; rec.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_symptom; rec.cd_symptom)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_create; rec.dt_create)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user_create; rec.user_create)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; rec.status)
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
//             group(WO)
//             {
//                 Caption = 'WO';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     ShortCutKey = 'Maj+F5';

//                     trigger OnAction()
//                     begin
//                         IF rec.status = rec.status::Planifié THEN
//                             PAGE.RUN(39002070, Rec);
//                         IF rec.status = rec.status::Lancé THEN
//                             PAGE.RUN(39002118, Rec);
//                         IF rec.status = rec.status::Terminé THEN
//                             PAGE.RUN(39002091, Rec);
//                         IF rec.status = rec.status::Simulé THEN
//                             PAGE.RUN(39002109, Rec);
//                         IF rec.status = rec.status::"Planifié ferme" THEN
//                             PAGE.RUN(39002117, Rec);
//                     end;
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(ot),
//                                   "No." = FIELD("code OT");
//                 }
//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD(cd_box);
//                 }
//                 action(Register)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Register';
//                     Image = Confirm;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD(cd_matricule);
//                 }
//                 action(Site)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD(cd_site);
//                 }
//             }
//         }
//     }
// }

