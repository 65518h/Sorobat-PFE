//GL3900 
// page 72070 "Fiche OT"
// {
//     //GL2024  ID dans Nav 2009 : "39002070"
//     PageType = Card;
//     SourceTable = OT;
//     SourceTableView = WHERE(status = CONST(Planifié));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Fiche OT';
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code OT"; rec."code OT")
//                 {
//                     ApplicationArea = all;

//                     trigger OnAssistEdit()
//                     begin
//                         IF rec.AssistEdit(xRec) THEN
//                             CurrPage.UPDATE;
//                     end;
//                 }
//                 field(Titre; rec.Titre)
//                 {
//                     ApplicationArea = all;
//                 }


//                 group("Intervention point")
//                 {
//                     Caption = 'Intervention point';

//                     field(cd_box; rec.cd_box)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(cd_model; rec.cd_model)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(cd_famille; rec.cd_famille)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(cd_matricule; rec.cd_matricule)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(cd_site; rec.cd_site)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(cd_cause_defaillance; rec.cd_cause_defaillance)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(cd_mode_defaillance; rec.cd_mode_defaillance)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Failure mode';
//                     }
//                     field(cd_symptom; rec.cd_symptom)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(bo_equip_stop; rec.bo_equip_stop)
//                     {
//                         ApplicationArea = all;

//                         trigger OnValidate()
//                         begin

//                             IF rec.bo_equip_stop = TRUE THEN
//                                 Temps_arrêtENABLED := TRUE
//                             ELSE
//                                 Temps_arrêtENABLED := FALSE;

//                         end;
//                     }
//                     field(Temps_arrêt; rec.Temps_arrêt)
//                     {
//                         ApplicationArea = all;
//                         Enabled = "Temps_arrêtENABLED";
//                     }
//                 }
//                 group(Intervention)
//                 {
//                     Caption = 'Intervention';
//                     field(priorité; rec.priorité)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(nature; rec.nature)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(status; rec.status)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(dt_debut; rec.dt_debut)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(dt_fin_ot; rec.dt_fin_ot)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(temps_prévu; rec.temps_prévu)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(time_debut; rec.time_debut)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(time_fin; rec.time_fin)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(Technologie; rec.Technologie)
//                     {
//                         ApplicationArea = all;
//                     }
//                     group(Administratif)
//                     {
//                         Caption = 'Administratif';
//                         field("Nom responsable"; rec."Nom responsable")
//                         {
//                             ApplicationArea = all;
//                         }
//                         field(cd_team; rec.cd_team)
//                         {
//                             ApplicationArea = all;
//                         }
//                     }
//                 }
//                 part(Liste_bt; "Liste BT-OT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WS List';
//                     Editable = false;
//                     Enabled = true;
//                     SubPageLink = cd_OT = FIELD("code OT");
//                 }


//             }
//             group(Origin)
//             {
//                 Caption = 'Origin';
//                 field(dt_create; rec.dt_create)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(demandeur; rec.demandeur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }

//                 field(user_create; rec.user_create)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 part("Liste DI-OT"; "Liste DI-OT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Intervention requests List';
//                     SubPageLink = cd_OT = FIELD("code OT");
//                 }
//             }
//             group(Cost)
//             {
//                 Caption = 'Cost';
//                 field(pr_fcst_main; rec.pr_fcst_main)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Editable = true;
//                 }
//                 field(pr_fcst_stock; rec.pr_fcst_stock)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Editable = true;
//                 }
//                 field(pr_fcst_divers; rec.pr_fcst_divers)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(fcst_total; rec.fcst_total)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatType = 1;
//                     Editable = false;
//                 }
//             }
//             group(Security)
//             {
//                 Caption = 'Security';
//                 field(cd_fiche_securite; rec.cd_fiche_securite)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         fiche.RESET;
//                         IF rec.cd_fiche_securite <> '' THEN BEGIN
//                             // Win.OPEN('Insertion Risque      ########1#### \\'+
//                             //          'Insertion Prevention  ########2####');

//                             risk_sec.RESET;
//                             risk_sec.SETFILTER(risk_sec.cd_fiche_securité, rec.cd_fiche_securite);
//                             IF risk_sec.FIND('-') THEN
//                                 REPEAT
//                                     risk_ot.RESET;
//                                     risk_ot.SETFILTER(risk_ot.cd_risque, risk_sec.cd_risque);
//                                     risk_ot.SETFILTER(risk_ot.cd_OT, rec."code OT");
//                                     IF NOT risk_ot.FIND('-') THEN BEGIN
//                                         risk_ot.RESET;
//                                         risk_ot.cd_OT := rec."code OT";
//                                         risk_ot.cd_risque := risk_sec.cd_risque;
//                                         risk_ot.Libellé := risk_sec.Libellé;
//                                         // Win.UPDATE(1,risk_sec.cd_risque);
//                                         risk_ot.INSERT;
//                                     END;
//                                 UNTIL risk_sec.NEXT = 0;

//                             pre_sec.RESET;
//                             pre_sec.SETFILTER(pre_sec.cd_fiche_securité, rec.cd_fiche_securite);
//                             IF pre_sec.FIND('-') THEN
//                                 REPEAT
//                                     pre_ot.RESET;
//                                     pre_ot.SETFILTER(pre_ot.cd_prevention, pre_sec.cd_prevention);
//                                     pre_ot.SETFILTER(pre_ot.cd_OT, rec."code OT");
//                                     IF NOT pre_ot.FIND('-') THEN BEGIN
//                                         pre_ot.RESET;
//                                         pre_ot.cd_OT := rec."code OT";
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

//                 field(bo_consigne_DI; rec.bo_consigne_DI)
//                 {
//                     ApplicationArea = all;
//                     Enabled = bo_consigne_DIEnable;

//                     trigger OnValidate()
//                     begin
//                         IF rec.bo_consigne_DI = TRUE THEN BEGIN
//                             di.RESET;
//                             di_ot.RESET;
//                             di_ot.SETFILTER(di_ot.cd_OT, rec."code OT");
//                             IF di_ot.FIND('-') THEN
//                                 REPEAT
//                                     pre_di.RESET;
//                                     pre_di.SETFILTER(pre_di.cd_DI, di_ot.cd_DI);
//                                     IF pre_di.FIND('-') THEN
//                                         REPEAT
//                                             pre_ot.RESET;
//                                             pre_ot.SETFILTER(pre_ot.cd_OT, rec."code OT");
//                                             pre_ot.SETFILTER(pre_ot.cd_prevention, pre_di.cd_prévention);
//                                             IF NOT pre_ot.FIND('-') THEN BEGIN
//                                                 pre_ot.RESET;
//                                                 pre_ot.cd_OT := rec."code OT";
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
//                                             risk_ot.SETFILTER(risk_ot.cd_OT, rec."code OT");
//                                             risk_ot.SETFILTER(risk_ot.cd_risque, risk_di.cd_risque);
//                                             IF NOT risk_ot.FIND('-') THEN BEGIN
//                                                 risk_ot.RESET;
//                                                 risk_ot.cd_OT := rec."code OT";
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
//                             di_ot.SETFILTER(di_ot.cd_OT, rec."code OT");
//                             IF di_ot.FIND('-') THEN
//                                 REPEAT
//                                     pre_di.RESET;
//                                     pre_di.SETFILTER(pre_di.cd_DI, di_ot.cd_DI);
//                                     IF pre_di.FIND('-') THEN
//                                         REPEAT
//                                             pre_ot.RESET;
//                                             pre_ot.SETFILTER(pre_ot.cd_OT, rec."code OT");
//                                             pre_ot.SETFILTER(pre_ot.cd_prevention, pre_di.cd_prévention);
//                                             IF pre_ot.FIND('-') THEN
//                                                 pre_ot.DELETE;

//                                         UNTIL pre_di.NEXT = 0;


//                                     risk_di.RESET;
//                                     risk_di.SETFILTER(risk_di.cd_DI, di_ot.cd_DI);
//                                     IF risk_di.FIND('-') THEN
//                                         REPEAT
//                                             risk_ot.RESET;
//                                             risk_ot.SETFILTER(risk_ot.cd_OT, rec."code OT");
//                                             risk_ot.SETFILTER(risk_ot.cd_risque, risk_di.cd_risque);
//                                             IF risk_ot.FIND('-') THEN
//                                                 risk_ot.DELETE;

//                                         UNTIL risk_di.NEXT = 0;
//                                 UNTIL di_ot.NEXT = 0;
//                         END;
//                         boconsigneDIOnAfterValidate;
//                     end;
//                 }
//                 part(risque; "Liste risque OT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Risks';
//                     SubPageLink = cd_OT = FIELD("code OT");
//                 }
//                 part(prevention; "Liste prevention OT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Preventions';
//                     SubPageLink = cd_OT = FIELD("code OT");
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
//                         bt.RESET;
//                         bt.cd_OT := rec."code OT";
//                         bt."code BT" := 1;
//                         bt.nature := rec.nature;
//                         bt.cd_box := rec.cd_box;
//                         bt.cd_site := rec.cd_site;
//                         bt.dt_debut := rec.dt_debut;
//                         bt.dt_fin := rec.dt_fin_ot;
//                         bt.time_debut := rec.time_debut;
//                         bt.time_fin := rec.time_fin;
//                         bt.status := rec.status;
//                         bt.cd_famille := rec.cd_famille;
//                         bt.cd_modèle := rec.cd_model;
//                         bt.cd_matricule := rec.cd_matricule;
//                         bt.Titre := rec.Titre + '-1';
//                         bt.INSERT(TRUE);
//                         IF rec.bo_consigne_DI = TRUE THEN BEGIN
//                             bt."consigne sur DI" := TRUE;
//                             bt.MODIFY;
//                         END;
//                         //Passage des préventions et des risques de la fiche OT à la fiche BT
//                         //Preventions
//                         pre_ot.RESET;
//                         pre_ot.SETFILTER(pre_ot.cd_OT, rec."code OT");
//                         IF pre_ot.FIND('-') THEN
//                             REPEAT
//                                 pre_bt.INIT;
//                                 pre_bt.cd_OT := rec."code OT";
//                                 pre_bt.cd_BT := bt."code BT";
//                                 pre_bt.cd_prevention := pre_ot.cd_prevention;
//                                 pre_bt.Libellé := pre_ot.Libellé;
//                                 pre_bt.INSERT(TRUE);
//                             UNTIL pre_ot.NEXT = 0;
//                         //Risques
//                         risk_ot.RESET;
//                         risk_ot.SETFILTER(risk_ot.cd_OT, rec."code OT");
//                         IF risk_ot.FIND('-') THEN
//                             REPEAT
//                                 risk_bt.INIT;
//                                 risk_bt.cd_OT := rec."code OT";
//                                 risk_bt.cd_BT := bt."code BT";
//                                 risk_bt.cd_risque := risk_ot.cd_risque;
//                                 risk_bt.Libellé := risk_ot.Libellé;
//                                 risk_bt.INSERT(TRUE);
//                             UNTIL risk_ot.NEXT = 0;

//                         PAGE.RUN(39002078, bt);
//                     end;
//                 }
//             }
//             group(btn_bt)
//             {
//                 Caption = 'WS';
//                 Visible = btn_btVisible;
//                 action("WS card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WS card';

//                     trigger OnAction()
//                     begin
//                         bt1.RESET;
//                         CurrPage.Liste_bt.Page.GETRECORD(bt1);
//                         IF bt1."code BT" <> 0 THEN
//                             PAGE.RUN(39002078, bt1)
//                         ELSE
//                             MESSAGE(text001);
//                     end;
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action("New WS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'New WS';

//                     trigger OnAction()
//                     begin
//                         bt1.RESET;
//                         bt1.SETFILTER(bt1.cd_OT, rec."code OT");
//                         bt1.SETCURRENTKEY(bt1."code BT");
//                         bt1.ASCENDING(TRUE);
//                         IF bt1.FIND('+') THEN
//                             int := bt1."code BT" + 1
//                         ELSE
//                             int := 1;

//                         bt.RESET;
//                         bt.cd_OT := rec."code OT";
//                         bt."code BT" := int;
//                         bt.nature := rec.nature;
//                         bt.cd_box := rec.cd_box;
//                         bt.dt_debut := rec.dt_debut;
//                         bt.dt_fin := rec.dt_fin_ot;
//                         bt.time_debut := rec.time_debut;
//                         bt.time_fin := rec.time_fin;
//                         bt.cd_site := rec.cd_site;
//                         bt.cd_famille := rec.cd_famille;
//                         bt.cd_modèle := rec.cd_model;
//                         bt.status := rec.status;
//                         bt.cd_matricule := rec.cd_matricule;
//                         bt.Titre := rec.Titre + '-' + FORMAT(int);
//                         bt.INSERT(TRUE);
//                         IF rec.bo_consigne_DI = TRUE THEN BEGIN
//                             bt."consigne sur DI" := TRUE;
//                             bt.MODIFY;
//                         END;
//                         //Passage des préventions et des risques de la fiche OT à la fiche BT
//                         //Preventions
//                         pre_ot.RESET;
//                         pre_ot.SETFILTER(pre_ot.cd_OT, rec."code OT");
//                         IF pre_ot.FIND('-') THEN
//                             REPEAT
//                                 pre_bt.INIT;
//                                 pre_bt.cd_OT := rec."code OT";
//                                 pre_bt.cd_BT := bt."code BT";
//                                 pre_bt.cd_prevention := pre_ot.cd_prevention;
//                                 pre_bt.Libellé := pre_ot.Libellé;
//                                 pre_bt.INSERT(TRUE);
//                             UNTIL pre_ot.NEXT = 0;
//                         //Risques
//                         risk_ot.RESET;
//                         risk_ot.SETFILTER(risk_ot.cd_OT, rec."code OT");
//                         IF risk_ot.FIND('-') THEN
//                             REPEAT
//                                 risk_bt.INIT;
//                                 risk_bt.cd_OT := rec."code OT";
//                                 risk_bt.cd_BT := bt."code BT";
//                                 risk_bt.cd_risque := risk_ot.cd_risque;
//                                 risk_bt.Libellé := risk_ot.Libellé;
//                                 risk_bt.INSERT(TRUE);
//                             UNTIL risk_ot.NEXT = 0;

//                         PAGE.RUN(39002078, bt);
//                     end;
//                 }
//             }
//             group(WO)
//             {
//                 Caption = 'WO';
//                 separator(separator200)
//                 {
//                 }
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
//                         changestatus.RUN(Rec);
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

//         IF rec.cd_fiche_securite = '' THEN
//             bo_consigne_DIEnable := FALSE
//         ELSE
//             bo_consigne_DIEnable := TRUE;

//         di_ot.RESET;
//         di_ot.SETFILTER(di_ot.cd_OT, rec."code OT");
//         IF di_ot.FIND('-') THEN
//             bo_consigne_DIEnable := TRUE
//         ELSE
//             bo_consigne_DIEnable := FALSE;


//         bt.RESET;
//         CurrPage.Liste_bt.Page.GETRECORD(bt);
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
//         rec.status := rec.status::Planifié;
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
//         [InDataSet]
//         btn_bt1Visible: Boolean;
//         [InDataSet]
//         btn_btVisible: Boolean;
//         [InDataSet]
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

