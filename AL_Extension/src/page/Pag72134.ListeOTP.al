//GL3900 
// page 72134 "Liste OTP"
// {//GL2024  ID dans Nav 2009 : "39002134"
//     PageType = CardPart;
//     SourceTable = OTP;
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 Editable = false;
//                 field("code OTP"; REC."code OTP")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; REC.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_box; REC.cd_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; REC.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_create; REC.dt_create)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user_create; REC.user_create)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; REC.status)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             group(PWO)
//             {
//                 Caption = 'PWO';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Fiche OTP";
//                     RunPageLink = "code OTP" = FIELD("code OTP");
//                     ShortCutKey = 'Maj+F5';

//                     trigger OnAction()
//                     begin
//                         IF REC.status = REC.status::Planifié THEN
//                             PAGE.RUN(90060, Rec);
//                         IF REC.status = REC.status::Lancé THEN
//                             PAGE.RUN(90108, Rec);
//                         IF REC.status = REC.status::Terminé THEN
//                             PAGE.RUN(90081, Rec);
//                         IF REC.status = REC.status::Simulé THEN
//                             PAGE.RUN(90099, Rec);
//                         IF REC.status = REC.status::"Planifié ferme" THEN
//                             PAGE.RUN(90107, Rec);
//                     end;
//                 }

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(ot), "No." = FIELD("code OTP");
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

