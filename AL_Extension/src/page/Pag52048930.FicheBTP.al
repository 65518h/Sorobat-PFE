// page 52048930 "Fiche BTP"
// {//GL2024  ID dans Nav 2009 : "39002138"
//     PageType = Card;
//     SourceTable = BTP;
//     ApplicationArea = All;
//     Caption = 'Fiche BTP';

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 group(Intervention)
//                 {
//                     Caption = 'Intervention';
//                     label(text1)
//                     {
//                         ApplicationArea = all;
//                         //CaptionClass = Text19058412;
//                     }
//                 }
//                 field("code BTP"; REC."code BTP")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(cd_OTP1; REC.cd_OTP)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(priorité; REC.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_debut; REC.dt_debut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(time_debut; REC.time_debut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_equipe; REC.cd_equipe)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_technologie; REC.cd_technologie)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(temps_prevu; REC.temps_prevu)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nbre intervenant"; REC."Nbre intervenant")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(temps_arret; REC.temps_arret)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; REC.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; REC.status)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(nature; REC.nature)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_fin; REC.dt_fin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(time_fin; REC.time_fin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 group("Intervention point")
//                 {
//                     Caption = 'Intervention point';
//                     field(cd_box; REC.cd_box)
//                     {
//                         ApplicationArea = all;
//                         Editable = true;
//                     }
//                     field(cd_site; REC.cd_site)
//                     {
//                         ApplicationArea = all;
//                         Editable = true;
//                     }
//                     field(cd_famille; REC.cd_famille)
//                     {
//                         ApplicationArea = all;
//                         Editable = true;
//                     }
//                     field(cd_modèle; REC.cd_modèle)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(cd_matricule; REC.cd_matricule)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                 }
//             }
//             group(Costs)
//             {
//                 Caption = 'Costs';
//                 label(text2)
//                 {
//                     ApplicationArea = all;
//                     //CaptionClass = Text19078659;
//                 }
//                 field(pr_fcst_main; REC.pr_fcst_main)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Editable = false;
//                 }
//                 field(pr_fcst_stock; REC.pr_fcst_stock)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Editable = false;
//                 }
//                 field(pr_fcst_divers; REC.pr_fcst_divers)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(fcst_total; REC.fcst_total)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Editable = false;
//                 }
//             }
//             //GL3900 
//             /*   group(Consumption)
//         {
//             Caption = 'Consumption';
//              part(ARTICLE; "Consommation article Prev")
//                {
//                    ApplicationArea = all;
//                    SubPageLink = "code otp" = FIELD(cd_OTP), "code bt" = FIELD("code BTP");
//                }

//         }  */ //GL3900 
//             //GL3900 
//             /*   group(Works)
//         {
//             Caption = 'Works';
//              part(process; "Liste opertion btp")
//               {
//                   ApplicationArea = all;
//                   SubPageLink = "code btp" = FIELD("code BTP"), "code otp" = FIELD("cd_OTP");
//               } 
//         }*///GL3900
//             group(Security)
//             {
//                 Caption = 'Security';
//                 /*
//                 //GL3900 
//                  part(risque; "Liste Risque BTP")
//                  {
//                      ApplicationArea = all;
//                      SubPageLink = "cd_OTP" = FIELD(cd_OTP), "cd_BT" = FIELD("code BTP");
//                  }
//                  label(text3)
//                  {
//                      ApplicationArea = all;
//                      //CaptionClass = Text19006919;
//                  }
//                  part(prevention; "Liste Prevention BTP")
//                  {
//                      ApplicationArea = all;
//                      SubPageLink = cd_OTP = FIELD(cd_OTP), cd_BTP = FIELD("code BTP");
//                  }*/
//                 //GL3900 
//                 field(cd_fiche_securite; REC.cd_fiche_securite)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         cdfichesecuriteOnAfterValidate;
//                     end;
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
//                 actionref("Joined WS1"; "Joined WS") { }

//                 actionref(Equipment1; Equipment) { }
//             }
//         }
//         area(navigation)
//         {
//             /*GL3900  group(Operations)
//              {
//                  Caption = 'Operations';
//                  action(Outillages)
//                  {
//                      ApplicationArea = all;
//                      Caption = 'Outillages';
//                      //GL3900 
//                      /*   trigger OnAction()
//                         begin

//                             OUTIL.SETRANGE(OUTIL.cd_otp, REC.cd_OTP);
//                             OUTIL.SETRANGE(OUTIL.cd_btp, REC."code BTP");
//                             PAGE.RUN(PAGE::Outillages, OUTIL);
//                         end;*/
//             //GL3900 
//             // }
//             //  }
//             group(PWS)
//             {
//                 Caption = 'PWS';

//                 action("Joined WS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Joined WS';
//                     RunObject = Page "Liste BTP";
//                     RunPageLink = cd_OTP = FIELD(cd_OTP);
//                 }
//                 /*GL3900    action(WO)
//                    {
//                        ApplicationArea = all;
//                        Caption = 'WO';
//                        //GL3900   RunObject = Page "Fiche OTP";
//                        //GL3900   RunPageLink = "code OTP" = FIELD("cd_OTP");
//                    }*/

//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD("cd_box");
//                 }
//                 /* GL3900 action(Register)
//                   {
//                       ApplicationArea = all;
//                       Caption = 'Register';
//                       Image = Confirm;
//                       Promoted = true;
//                       PromotedCategory = Process;
//                       //GL3900    RunObject = page "Fiche Matricule";
//                       //GL3900    RunPageLink = "code matricule" = FIELD(cd_matricule);
//                   }
//                   action(Model)
//                   {
//                       ApplicationArea = all;
//                       Caption = 'Model';
//                       //GL3900   RunObject = page "Fiche Modèle";
//                       //GL3900   RunPageLink = "cd_pattern" = FIELD(cd_modèle);
//                   }
//                   action(Site)
//                   {
//                       ApplicationArea = all;
//                       Caption = 'Site';
//                       //GL3900    RunObject = page "Fiche Site";
//                       //GL3900    RunPageLink = "code site" = FIELD(cd_site);
//                   }*/
//             }
//         }
//     }

//     var
//         //GL3900 
//         /*    fiche: Record "Fiche securité";
//             risk_sec: Record "Risque securité";
//             pre_sec: Record "prevention securité";
//             risk_btp: Record "Risque BTP";
//             pre_btp: Record "Prevention BTP";
//             OUTIL: Record Tools;*/
//         //GL3900 
//         //GL3900   EXP: Codeunit "Consumption treatment";

//         Text19058412: Label 'Heure';
//         Text19006919: Label 'Preventions';
//         Text19078659: Label 'Expected Cost';

//     local procedure cdfichesecuriteOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;
// }

