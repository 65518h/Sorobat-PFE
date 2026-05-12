//GL3900 
// page 72162 "Fiche OTP Terminé"
// {//GL2024  ID dans Nav 2009 : "39002162"
//     Caption = 'Preventive Work Order';
//     Editable = false;
//     PageType = Card;
//     SourceTable = OTP;
//     SourceTableView = WHERE(status = FILTER(Terminé));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 label(text2)
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19060353;
//                 }
//                 part(Liste_bt; "Liste BTP-OTP")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                     SubPageLink = "cd_OTP" = FIELD("code OTP");
//                 }
//                 field("code OTP"; REC."code OTP")
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(dt_create; REC.dt_create)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(cd_box; REC.cd_box)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(cd_matricule; REC.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(cd_model; REC.cd_model)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_equip_stop; REC.bo_equip_stop)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         //GL2024
//                         IF rec.bo_equip_stop = TRUE THEN
//                             Temps_arrêtENABLED := TRUE
//                         ELSE
//                             Temps_arrêtENABLED := FALSE;

//                     end;
//                 }
//                 field(Temps_arrêt; REC.Temps_arrêt)
//                 {
//                     ApplicationArea = all;
//                     Enabled = Temps_arrêtENABLED;
//                 }
//                 field("Type Declencheur"; REC."Type Declencheur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; REC.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user_create; REC.user_create)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(priorité; REC.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(nature; REC.nature)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; REC.status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(temps_prévu; REC.temps_prévu)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_team; REC.cd_team)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Technologie; REC.Technologie)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Cost)
//             {
//                 Caption = 'Cost';
//                 label(text1)
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19078659;
//                 }
//                 field(pr_fcst_main; REC.pr_fcst_main)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Caption = 'Labour';
//                     Editable = false;
//                 }
//                 field(pr_fcst_stock; REC.pr_fcst_stock)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Caption = 'Inventory cost';
//                     Editable = false;
//                 }
//                 field(pr_fcst_divers; REC.pr_fcst_divers)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Various costs';
//                     Editable = false;
//                 }
//                 field(fcst_total; REC.fcst_total)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Caption = 'Total Cost';
//                     Editable = false;
//                 }
//             }
//             group(Security)
//             {
//                 Caption = 'Security';
//                 part(risque; "Liste risque OTP")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "cd_OTp" = FIELD("code OTP");
//                 }
//                 label(text)
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19006919;
//                 }
//                 part(prevention; "Liste prevention OTP")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "cd_OTP" = FIELD("code OTP");
//                 }
//                 field(cd_fiche_securite; REC.cd_fiche_securite)
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
//             group(btn_bt1)
//             {
//                 Caption = 'PWS';
//                 action("New WS1")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'New WS';

//                     trigger OnAction()
//                     begin
//                         Rec.CreateBTp();
//                     end;
//                 }
//             }
//             group(btn_bt)
//             {
//                 Caption = 'PWS';
//                 action("New WS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'New WS';

//                     trigger OnAction()
//                     begin
//                         Rec.CreateBTp();
//                     end;
//                 }
//                 action("WS card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WS card';
//                     ShortCutKey = 'Maj+F5';

//                     trigger OnAction()
//                     begin
//                         RecGBTP.RESET;
//                         RecGBTP.SETRANGE(cd_OTP, REC."code OTP");
//                         CurrPage.Liste_bt.PAGE.GETRECORD(RecGBTP);

//                         IF RecGBTP."code BTP" <> 0 THEN
//                             PAGE.RUN(39002138, RecGBTP)
//                         ELSE
//                             MESSAGE(Text001);
//                     end;
//                 }
//             }
//             group(PWO)
//             {
//                 Caption = 'PWO';

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
//                     RunPageLink = "No." = FIELD("cd_box");
//                 }
//                 action(Register)
//                 {
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
//                     RunPageLink = "code site" = FIELD("cd_site");
//                 }
//             }
//         }
//         area(processing)
//         {
//             group(Functions)
//             {
//                 Caption = 'Functions';
//                 action("Change status")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Change status';

//                     trigger OnAction()
//                     begin
//                         //ChangeStatus.RUN(Rec);


//                         ChangeStatusForm.Set(Rec);
//                         IF ChangeStatusForm.RUNMODAL() = ACTION::Yes THEN BEGIN
//                             COMMIT;
//                             MESSAGE(Text000, REC.status, REC.TABLECAPTION, REC."code OTP", ToWorkOrder.status, ToWorkOrder.TABLECAPTION, ToWorkOrder."code OTP");

//                             /*ChangeStatusForm.ReturnPostingInfo(NewStatus,NewPostingDate,NewUpdateUnitCost);
//                              ChangeStatusForm.ReturnValidationInfo(valItem,valress,PItem,PRes);
//                              ChangeStatusOnProdOrder(Rec,NewStatus,NewPostingDate,NewUpdateUnitCost,valItem,valress,PItem,PRes);
//                              COMMIT;
//                              MESSAGE(Text000,ToWorkOrder.status,TABLECAPTION,"code OT",status,ToWorkOrder.TABLECAPTION,ToWorkOrder."code OT")
//                            END;

//                            */
//                             IF (Rec.status = Rec.status::Terminé) THEN
//                                 RecOTPHIS.INIT;
//                             RecOTPHIS.TRANSFERFIELDS(Rec);
//                             //RecOTPHIS.status:=status+1:


//                         END;

//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin

//         IF rec.bo_equip_stop = TRUE THEN
//             Temps_arrêtENABLED := TRUE
//         ELSE
//             Temps_arrêtENABLED := FALSE;


//         /*IF cd_fiche_securite='' THEN
//            Currpage.bo_consigne_DI.ENABLED := FALSE
//         ELSE
//          Currpage.bo_consigne_DI.ENABLED := TRUE;

//         di_ot.RESET;
//         di_ot.SETFILTER(di_ot.cd_OT,"code OT");
//         IF di_ot.FIND('-') THEN
//           Currpage.bo_consigne_DI.ENABLED := TRUE
//         ELSE
//          Currpage.bo_consigne_DI.ENABLED := FALSE;
//         */

//         /*bt.RESET;
//         Currpage.Liste_bt.FORM.GETRECORD(bt);
//         IF bt."code BTP" = 0 THEN
//            BEGIN
//              Currpage.btn_bt1.VISIBLE := TRUE;
//              Currpage.btn_bt.VISIBLE := FALSE;
//            END
//         ELSE
//            BEGIN
//              Currpage.btn_bt1.VISIBLE := FALSE;
//              Currpage.btn_bt.VISIBLE := TRUE;
//            END;*/

//     end;

//     trigger OnOpenPage()
//     begin
//         OnActivateForm;
//     end;

//     var
//         fiche: Record "Fiche securité";
//         risk_sec: Record "Risque securité";
//         risk_ot: Record "Risque OT";
//         pre_sec: Record "prevention securité";
//         pre_ot: Record "Prevention OT";
//         pre_di: Record "prevention DI";
//         risk_di: Record "Risque DI";
//         di: Record DI;
//         bt: Record BTP;
//         RecGBTP: Record BTP;
//         int: Integer;
//         Text001: Label 'No seleted WS';
//         ChangeStatus: Codeunit "Work  Order Status Management";
//         GDeclanch: Record "Déclencheur";
//         GOTP: Record OTP;
//         GRelMesure: Record "Relevé mesure";
//         G: Integer;
//         RecOTPHIS: Record "OTP HIS";
//         RecBTPHIS: Record "BTP HIS";
//         ChangeStatusForm: Page "Change Status on Work.Order11";
//         Text000: Label 'L''enregistrement %2 %1 %3 a été transformé en %5 %4 %6.';
//         ToWorkOrder: Record OTP;
//         Text19060353: Label 'PWS List';
//         Text19006919: Label 'Preventions';
//         Text19078659: Label 'Expected Cost';

//         Temps_arrêtENABLED: Boolean;

//     local procedure OnActivateForm()
//     begin

//         GDeclanch.SETRANGE(OTP, REC."code OTP");
//         IF GDeclanch.FINDFIRST THEN;
//         CASE GDeclanch.Type OF
//             GDeclanch.Type::"Sur Déclenchement Calendaire":
//                 BEGIN
//                     CASE GDeclanch.Période OF
//                         GDeclanch.Période::Jours:
//                             BEGIN
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'J', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     REC.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     REC.dt_create := WORKDATE;
//                                     GDeclanch.Prévue := WORKDATE;
//                                     //GOTP.status :: "Lancé" ;
//                                     REC.MODIFY;
//                                 END;
//                             END;
//                         GDeclanch.Période::Semaines:
//                             BEGIN
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'S', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     REC.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     REC.dt_create := WORKDATE;
//                                     REC.MODIFY;
//                                 END;
//                             END;
//                         GDeclanch.Période::Mois:
//                             BEGIN
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'M', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     REC.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     REC.dt_create := WORKDATE;
//                                     REC.MODIFY;
//                                 END;
//                             END;
//                         GDeclanch.Période::Années:
//                             BEGIN
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'M', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     REC.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     REC.dt_create := WORKDATE;
//                                     REC.MODIFY;
//                                 END;
//                             END;
//                         GDeclanch.Type::"Sur Prise de Mesure":
//                             BEGIN


//                             END;
//                         GDeclanch.Type::"Sur Symptôme":
//                             BEGIN


//                             END;

//                     END;
//                 END;
//         END
//     end;
// }

