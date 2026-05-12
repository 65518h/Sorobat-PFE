//GL3900 
// page 72087 "Fiche OTP"
// {
//     //GL2024  ID dans Nav 2009 : "39002087"
//     Caption = 'Preventive Work Order';
//     PageType = Card;
//     SourceTable = OTP;
//     SourceTableView = WHERE(status = FILTER(Planifié));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';


//                 field("code OTP"; rec."code OTP")
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(dt_create; rec.dt_create)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(cd_box; rec.cd_box)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(cd_matricule; rec.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(cd_model; rec.cd_model)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_equip_stop; rec.bo_equip_stop)
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
//                 field(Temps_arrêt; rec.Temps_arrêt)
//                 {
//                     ApplicationArea = all;
//                     Enabled = Temps_arrêtENABLED;
//                 }
//                 field("Type Declencheur"; rec."Type Declencheur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Titre; rec.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(user_create; rec.user_create)
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                 }
//                 field(priorité; rec.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(nature; rec.nature)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; rec.status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(temps_prévu; rec.temps_prévu)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_team; rec.cd_team)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Technologie; rec.Technologie)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status1; rec.status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 part(Liste_bt; "Liste BTP-OTP")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                     SubPageLink = cd_OTP = FIELD("code OTP");
//                 }
//             }
//             group(Cost)
//             {
//                 Caption = 'Cost';
//                 group("Expected Cost")
//                 {
//                     Caption = 'Expected Cost';

//                     field(pr_fcst_main; rec.pr_fcst_main)
//                     {
//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Caption = 'Labour';
//                         Editable = true;
//                     }
//                     field(pr_fcst_stock; rec.pr_fcst_stock)
//                     {
//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Caption = 'Inventory cost';
//                         Editable = true;
//                     }
//                     field(pr_fcst_divers; rec.pr_fcst_divers)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Various costs';
//                         Editable = false;
//                     }
//                     field(fcst_total; rec.fcst_total)
//                     {
//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Caption = 'Total Cost';
//                         Editable = false;
//                     }
//                 }
//             }
//             group(Security)
//             {
//                 Caption = 'Security';

//                 field(cd_fiche_securite; rec.cd_fiche_securite)
//                 {
//                     ApplicationArea = all;
//                 }
//                 part(risque; "Liste risque OTP")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Risks';
//                     SubPageLink = cd_OTp = FIELD("code OTP");
//                 }

//                 part(prevention; "Liste prevention OTP")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Preventions';
//                     SubPageLink = cd_OTP = FIELD("code OTP");
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
//                         RecGBTP.SETRANGE(cd_OTP, rec."code OTP");
//                         CurrPage.Liste_bt.Page.GETRECORD(RecGBTP);

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

//                         ChangeStatusForm.GetRec(Rec);
//                         ChangeStatusForm.Set(Rec);
//                         IF ChangeStatusForm.RUNMODAL() = ACTION::Yes THEN;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin

//         //GL2024
//         IF rec.bo_equip_stop = TRUE THEN
//             Temps_arrêtENABLED := TRUE
//         ELSE
//             Temps_arrêtENABLED := FALSE;
//         //GL2024FIN

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
//         Currpage.Liste_bt.Page.GETRECORD(bt);
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

//         [InDataSet]
//         Temps_arrêtENABLED: Boolean;

//     local procedure OnActivateForm()
//     begin

//         GDeclanch.SETRANGE(OTP, rec."code OTP");
//         IF GDeclanch.FINDFIRST THEN;
//         CASE GDeclanch.Type OF
//             GDeclanch.Type::"Sur Déclenchement Calendaire":
//                 BEGIN
//                     MESSAGE('1');
//                     CASE GDeclanch.Période OF
//                         GDeclanch.Période::Jours:
//                             BEGIN
//                                 MESSAGE(FORMAT(CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'J', GDeclanch.Prévue)));
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'J', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     rec.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     rec.dt_create := WORKDATE;
//                                     GDeclanch.Prévue := WORKDATE;
//                                     //GOTP.status :: "Lancé" ;
//                                     IF rec.MODIFY THEN;
//                                 END;
//                             END;
//                         GDeclanch.Période::Semaines:
//                             BEGIN
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'S', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     rec.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     rec.dt_create := WORKDATE;
//                                     rec.MODIFY;
//                                 END;
//                             END;
//                         GDeclanch.Période::Mois:
//                             BEGIN
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'M', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     rec.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     rec.dt_create := WORKDATE;
//                                     rec.MODIFY;
//                                 END;
//                             END;
//                         GDeclanch.Période::Années:
//                             BEGIN
//                                 IF CALCDATE('+' + FORMAT(GDeclanch.Durée) + 'M', GDeclanch.Prévue) = WORKDATE THEN BEGIN
//                                     rec.INIT;
//                                     MESSAGE('Le nouveau OTP doit être exécutée à partir du' + ' ' + FORMAT(WORKDATE));
//                                     rec.dt_create := WORKDATE;
//                                     rec.MODIFY;
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

