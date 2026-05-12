//GL3900 
// page 72121 "Liste avis de panne"
// {//GL2024  ID dans Nav 2009 : "39002121"
//     PageType = Card;
//     SourceTable = "Failure Notice";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(code; REC.code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; REC.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code equipement"; REC."code equipement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code matricule"; REC."code matricule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code site"; REC."code site")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code famille"; REC."code famille")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("code modele"; REC."code modele")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(date; REC.date)
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
//             group("Failure Notice")
//             {
//                 Caption = 'Failure Notice';
//                 action(Card)
//                 {
//                     Caption = 'Card';
//                     Image = EditLines;
//                     ShortCutKey = 'Maj+F5';

//                     trigger OnAction()
//                     begin
//                         IF REC.Validé THEN
//                             PAGE.RUN(90110, Rec)
//                         ELSE
//                             PAGE.RUN(90113, Rec);
//                     end;
//                 }

//                 action(Equipment)
//                 {
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD("code equipement");
//                 }
//                 action(Register)
//                 {
//                     Caption = 'Register';
//                     Image = Confirm;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD("code matricule");
//                 }
//                 action(Site)
//                 {
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD("code site");
//                 }
//                 action(Family)
//                 {
//                     Caption = 'Family';
//                     RunObject = page "Fiche famille";
//                     RunPageLink = "code famille" = FIELD("code famille");
//                 }
//                 action(Model)
//                 {
//                     Caption = 'Model';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD("code modele");
//                 }
//             }
//         }
//     }
// }

