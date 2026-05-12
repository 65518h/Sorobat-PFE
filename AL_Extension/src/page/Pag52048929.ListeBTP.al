// page 52048929 "Liste BTP"
// {//GL2024  ID dans Nav 2009 : "39002137"
//     Editable = false;
//     PageType = List;
//     SourceTable = BTP;
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("code BTP"; REC."code BTP")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_OTP; REC.cd_OTP)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; REC.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_debut; REC.dt_debut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(priorité; REC.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; REC.status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_box; REC.cd_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; REC.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_famille; REC.cd_famille)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_modèle; REC.cd_modèle)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; REC.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_equipe; REC.cd_equipe)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group(PWS1)
//             {
//                 Caption = 'PWS';
//                 actionref(Card1; Card) { }

//                 actionref(Equipment1; Equipment) { }
//             }
//         }
//         area(navigation)
//         {
//             group(PWS)
//             {
//                 Caption = 'PWS';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Fiche BTP";
//                     ShortCutKey = 'Maj+F5';
//                 }

//                 /* GL3900  action(WO)
//                   {
//                       ApplicationArea = all;
//                       Caption = 'WO';
//                       //GL3900   RunObject = Page "Fiche OTP";
//                       //GL3900       RunPageLink = "code OTP" = FIELD(cd_OTP);
//                   }*/

//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD(cd_box);
//                 }
//                 /* GL3900    action(Register)
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Register';
//                        Image = Confirm;
//                        Promoted = true;
//                        PromotedCategory = Process;
//                        //GL3900    RunObject = page "Fiche Matricule";
//                        //GL3900     RunPageLink = "code matricule" = FIELD(cd_matricule);
//                    }
//                    action(Model)
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Model';
//                        //GL3900    RunObject = page "Fiche Modèle";
//                        //GL3900   RunPageLink = cd_pattern = FIELD(cd_modèle);
//                    }
//                    action(Site)
//                    {
//                        ApplicationArea = all;
//                        Caption = 'Site';
//                        //GL3900    RunObject = page "Fiche Site";
//                        //GL3900   RunPageLink = "code site" = FIELD(cd_site);
//                    }*/
//             }
//         }
//     }
// }

