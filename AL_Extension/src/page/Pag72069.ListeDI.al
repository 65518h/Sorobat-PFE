//GL3900 
// page 72069 "Liste DI"
// {
//     //GL2024  ID dans Nav 2009 : "39002069"
//     Editable = false;
//     PageType = List;
//     SourceTable = DI;
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Liste DI';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("code demande intervention"; rec."code demande intervention")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(titre; rec.titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Proposition; rec.Proposition)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_equipement; rec.cd_equipement)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; rec.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; rec.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_creation; rec.dt_creation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_equipement_stop; rec.bo_equipement_stop)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_symphôme; rec.cd_symphôme)
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
//             group(btn_di)
//             {
//                 Caption = 'IR';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Fiche DI";
//                     RunPageLink = "code demande intervention" = FIELD("code demande intervention");
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(di),
//                                   "No." = FIELD("code demande intervention");
//                 }
//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD(cd_equipement);
//                 }
//                 action("Site card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site card';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD(cd_site);
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
//                 action(Model)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Model';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_model);
//                 }
//                 separator(separator200)
//                 {
//                 }
//                 action(Symptom)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Symptom';
//                     RunObject = page "Fiche sympthome";
//                     RunPageLink = cd_sympt = FIELD(cd_symphôme);
//                 }
//                 action(Security)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Security';
//                     RunObject = Page "Fiche de sécurité";
//                     RunPageLink = "code fiche securite" = FIELD(cd_fiche_securité);
//                 }
//             }
//         }
//     }
// }

