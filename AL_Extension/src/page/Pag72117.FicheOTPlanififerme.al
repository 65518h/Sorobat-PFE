//GL3900 
// page 72117 "Fiche OT Planifié ferme"
// { //GL2024  ID dans Nav 2009 : "39002117"
//     PageType = Card;
//     SourceTable = OT;
//     SourceTableView = WHERE(status = CONST("Planifié ferme"));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code OT"; REC."code OT")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         IF REC.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }

//                 field(cd_box; REC.cd_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_model; REC.cd_model)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(cd_famille; REC.cd_famille)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(cd_matricule; REC.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; REC.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_cause_defaillance; REC.cd_cause_defaillance)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_mode_defaillance; REC.cd_mode_defaillance)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Failure mode';
//                 }
//                 field(cd_symptom; REC.cd_symptom)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_equip_stop; REC.bo_equip_stop)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin

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
//                 field(Titre; REC.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 label(text1)
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19003993;
//                 }
//                 part(Liste_bt; "Liste BT-OT")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                     SubPageLink = cd_OT = FIELD("code OT");
//                 }
//                 group(Intervention)
//                 {
//                     Caption = 'Intervention';
//                     field(priorité; REC.priorité)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(nature; REC.nature)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(status; REC.status)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(dt_debut; REC.dt_debut)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(dt_fin_ot; REC.dt_fin_ot)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(temps_prévu; REC.temps_prévu)
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//                 field(time_debut; REC.time_debut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(time_fin; REC.time_fin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Technologie; REC.Technologie)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom responsable"; REC."Nom responsable")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_team; REC.cd_team)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Origin)
//             {
//                 Caption = 'Origin';
//                 field(dt_create; REC.dt_create)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(demandeur; REC.demandeur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 part(list; "Liste DI-OT")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_OT = FIELD("code OT");
//                 }
//                 field(user_create; REC.user_create)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(cd_POT; REC.cd_POT)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//             group(Cost)
//             {
//                 Caption = 'Cost';
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
//             group(Security)
//             {
//                 Caption = 'Security';
//                 field(cd_fiche_securite; REC.cd_fiche_securite)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         fiche.RESET;
//                         IF REC.cd_fiche_securite <> '' THEN BEGIN
//                             // Win.OPEN('Insertion Risque      ########1#### \\'+
//                             //          'Insertion Prevention  ########2####');

//                             risk_sec.RESET;
//                             risk_sec.SETFILTER(risk_sec.cd_fiche_securité, REC.cd_fiche_securite);
//                             IF risk_sec.FIND('-') THEN
//                                 REPEAT
//                                     risk_ot.RESET;
//                                     risk_ot.SETFILTER(risk_ot.cd_risque, risk_sec.cd_risque);
//                                     risk_ot.SETFILTER(risk_ot.cd_OT, REC."code OT");
//                                     IF NOT risk_ot.FIND('-') THEN BEGIN
//                                         risk_ot.RESET;
//                                         risk_ot.cd_OT := REC."code OT";
//                                         risk_ot.cd_risque := risk_sec.cd_risque;
//                                         risk_ot.Libellé := risk_sec.Libellé;
//                                         // Win.UPDATE(1,risk_sec.cd_risque);
//                                         risk_ot.INSERT;
//                                     END;
//                                 UNTIL risk_sec.NEXT = 0;

//                             pre_sec.RESET;
//                             pre_sec.SETFILTER(pre_sec.cd_fiche_securité, REC.cd_fiche_securite);
//                             IF pre_sec.FIND('-') THEN
//                                 REPEAT
//                                     pre_ot.RESET;
//                                     pre_ot.SETFILTER(pre_ot.cd_prevention, pre_sec.cd_prevention);
//                                     pre_ot.SETFILTER(pre_ot.cd_OT, REC."code OT");
//                                     IF NOT pre_ot.FIND('-') THEN BEGIN
//                                         pre_ot.RESET;
//                                         pre_ot.cd_OT := REC."code OT";
//                                         pre_ot.cd_prevention := pre_sec.cd_prevention;
//                                         pre_ot.Libellé := pre_sec.Libellé;
//                                         //Win.UPDATE(2,pre_sec.cd_prevention);
//                                         pre_ot.INSERT;
//                                     END;
//                                 UNTIL pre_sec.NEXT = 0;
//                         END;
//                         cdfichesecuriteOnAfterValidate;
//                     end;
//                 }
//                 part(risque; "Liste risque OT")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_OT = FIELD("code OT");
//                 }
//                 part(prevention; "Liste prevention OT")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_OT = FIELD("code OT");
//                 }
//                 field(bo_consigne_DI; REC.bo_consigne_DI)
//                 {
//                     ApplicationArea = all;
//                     Enabled = bo_consigne_DIEnable;

//                     trigger OnValidate()
//                     begin
//                         IF REC.bo_consigne_DI = TRUE THEN BEGIN
//                             di.RESET;
//                             di_ot.RESET;
//                             di_ot.SETFILTER(di_ot.cd_OT, REC."code OT");
//                             IF di_ot.FIND('-') THEN
//                                 REPEAT
//                                     pre_di.RESET;
//                                     pre_di.SETFILTER(pre_di.cd_DI, di_ot.cd_DI);
//                                     IF pre_di.FIND('-') THEN
//                                         REPEAT
//                                             pre_ot.RESET;
//                                             pre_ot.SETFILTER(pre_ot.cd_OT, REC."code OT");
//                                             pre_ot.SETFILTER(pre_ot.cd_prevention, pre_di.cd_prévention);
//                                             IF NOT pre_ot.FIND('-') THEN BEGIN
//                                                 pre_ot.RESET;
//                                                 pre_ot.cd_OT := REC."code OT";
//                                                 pre_ot.cd_prevention := pre_di.cd_prévention;
//                                                 pre_ot.Libellé := pre_di.Libellé;
//                                                 pre_ot.cd_di := di_ot.cd_DI;
//                                                 pre_ot.INSERT;
//                                             END;
//                                         UNTIL pre_di.NEXT = 0;

//                                     risk_di.RESET;
//                                     risk_di.SETFILTER(risk_di.cd_DI, di_ot.cd_DI);
//                                     IF risk_di.FIND('-') THEN
//                                         REPEAT
//                                             risk_ot.RESET;
//                                             risk_ot.SETFILTER(risk_ot.cd_OT, REC."code OT");
//                                             risk_ot.SETFILTER(risk_ot.cd_risque, risk_di.cd_risque);
//                                             IF NOT risk_ot.FIND('-') THEN BEGIN
//                                                 risk_ot.RESET;
//                                                 risk_ot.cd_OT := REC."code OT";
//                                                 risk_ot.cd_risque := risk_di.cd_risque;
//                                                 risk_ot.Libellé := risk_di.Libellé;
//                                                 risk_ot.cd_DI := di_ot.cd_DI;
//                                                 risk_ot.INSERT;
//                                             END;
//                                         UNTIL risk_di.NEXT = 0;


//                                 UNTIL di_ot.NEXT = 0;
//                         END
//                         ELSE BEGIN
//                             di.RESET;
//                             di_ot.RESET;
//                             di_ot.SETFILTER(di_ot.cd_OT, REC."code OT");
//                             IF di_ot.FIND('-') THEN
//                                 REPEAT
//                                     pre_di.RESET;
//                                     pre_di.SETFILTER(pre_di.cd_DI, di_ot.cd_DI);
//                                     IF pre_di.FIND('-') THEN
//                                         REPEAT
//                                             pre_ot.RESET;
//                                             pre_ot.SETFILTER(pre_ot.cd_OT, REC."code OT");
//                                             pre_ot.SETFILTER(pre_ot.cd_prevention, pre_di.cd_prévention);
//                                             IF pre_ot.FIND('-') THEN
//                                                 pre_ot.DELETE;

//                                         UNTIL pre_di.NEXT = 0;


//                                     risk_di.RESET;
//                                     risk_di.SETFILTER(risk_di.cd_DI, di_ot.cd_DI);
//                                     IF risk_di.FIND('-') THEN
//                                         REPEAT
//                                             risk_ot.RESET;
//                                             risk_ot.SETFILTER(risk_ot.cd_OT, REC."code OT");
//                                             risk_ot.SETFILTER(risk_ot.cd_risque, risk_di.cd_risque);
//                                             IF risk_ot.FIND('-') THEN
//                                                 risk_ot.DELETE;

//                                         UNTIL risk_di.NEXT = 0;
//                                 UNTIL di_ot.NEXT = 0;
//                         END;
//                         boconsigneDIOnAfterValidate;
//                     end;
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
//                 Caption = 'WS';
//                 Visible = btn_bt1Visible;
//                 action("New WS1")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'New WS';

//                     trigger OnAction()
//                     begin
//                         Rec.CreateBT();
//                     end;
//                 }
//             }
//             group(btn_bt)
//             {
//                 Caption = 'WS';
//                 Visible = btn_btVisible;
//                 action("New WS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'New WS';

//                     trigger OnAction()
//                     begin
//                         Rec.CreateBT();
//                     end;
//                 }
//                 action("WS card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WS card';

//                     trigger OnAction()
//                     begin
//                         bt1.RESET;
//                         //  CurrPage.Liste_bt.PAGE.GETRECORD(bt1);
//                         IF bt1."code BT" <> 0 THEN
//                             PAGE.RUN(39002078, bt1)
//                         ELSE
//                             MESSAGE(text001);
//                     end;
//                 }
//             }
//             group(WO)
//             {
//                 Caption = 'WO';

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(ot), "No." = FIELD("code OT");
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
//                     RunPageLink = "Code site" = FIELD(cd_site);
//                 }
//             }
//         }
//         area(processing)
//         {
//             group("&Print")
//             {
//                 Caption = '&Print';
//                 action("Print Order")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Print Order';

//                     trigger OnAction()
//                     begin
//                         order.RESET;
//                         order.SETFILTER(order."code OT", REC."code OT");
//                         IF order.FIND('-') THEN
//                             REPORT.RUNMODAL(39002020, TRUE, FALSE, order);
//                     end;
//                 }
//                 action("Print Sheets")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Print Sheets';

//                     trigger OnAction()
//                     begin
//                         sheet.RESET;
//                         sheet.SETFILTER(sheet.cd_OT, REC."code OT");
//                         IF sheet.FIND('-') THEN
//                             REPORT.RUNMODAL(39002021, TRUE, FALSE, sheet);
//                     end;
//                 }
//             }
//             group(Functions)
//             {
//                 Caption = 'Functions';
//                 action("Change status")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Change status';

//                     trigger OnAction()
//                     begin
//                         changestatus.RUN(Rec);
//                     end;
//                 }
//                 action("Update costs")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Update costs';

//                     trigger OnAction()
//                     begin
//                         Rec."OT costs"();
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin

//         IF REC.bo_equip_stop = TRUE THEN
//             Temps_arrêtENABLED := TRUE
//         ELSE
//             Temps_arrêtENABLED := FALSE;

//         IF rec.cd_fiche_securite = '' THEN
//             bo_consigne_DIEnable := FALSE
//         ELSE
//             bo_consigne_DIEnable := TRUE;

//         di_ot.RESET;
//         di_ot.SETFILTER(di_ot.cd_OT, REC."code OT");
//         IF di_ot.FIND('-') THEN
//             bo_consigne_DIEnable := TRUE
//         ELSE
//             bo_consigne_DIEnable := FALSE;


//         bt.RESET;
//         CurrPage.Liste_bt.page.GETRECORD(bt);
//         IF bt."code BT" = 0 THEN BEGIN
//             btn_bt1Visible := TRUE;
//             btn_btVisible := FALSE;
//         END
//         ELSE BEGIN
//             btn_bt1Visible := FALSE;
//             btn_btVisible := TRUE;
//         END;

//     end;

//     trigger OnInit()
//     begin
//         bo_consigne_DIEnable := TRUE;
//         btn_btVisible := TRUE;
//         btn_bt1Visible := TRUE;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         REC.status := REC.status::"Planifié ferme";
//     end;

//     var

//         fiche: Record "Fiche securité";
//         risk_sec: Record "Risque securité";
//         risk_ot: Record "Risque OT";
//         pre_sec: Record "prevention securité";
//         pre_ot: Record "Prevention OT";
//         di_ot: Record "OT-DI";
//         pre_di: Record "prevention DI";
//         risk_di: Record "Risque DI";
//         di: Record DI;
//         bt: Record BT;
//         bt1: Record BT;
//         int: Integer;
//         text001: Label 'No seleted WS';
//         risk_bt: Record "Risque BT";
//         pre_bt: Record "Prevention BT";
//         changestatus: Codeunit "Work  Order Status Management";
//         order: Record OT;
//         sheet: Record BT;
//         btn_bt1Visible: Boolean;

//         btn_btVisible: Boolean;

//         bo_consigne_DIEnable: Boolean;
//         Text19003993: Label 'WS List';
//         [InDataSet]
//         Temps_arrêtENABLED: Boolean;

//     local procedure boconsigneDIOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure cdfichesecuriteOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;
// }

