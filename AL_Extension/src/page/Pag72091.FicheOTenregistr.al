//GL3900 
// page 72091 "Fiche OT enregistré"
// {
//     //GL2024  ID dans Nav 2009 : "39002091"
//     Editable = false;
//     PageType = Card;
//     SourceTable = OT;
//     SourceTableView = SORTING("code OT") ORDER(Ascending) WHERE(status = CONST(Terminé));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Fiche OT enregistré';
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

//                 group("Point d'intervention")
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

//                 label("WS List")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WS List';
//                 }
//                 part(Liste_bt; "Liste BT-OT")
//                 {
//                     ApplicationArea = all;
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
//                 field("Avis de panne"; rec."Avis de panne")
//                 {
//                     ApplicationArea = all;
//                     Visible = "Avis de panneVisible";
//                 }
//                 field(cd_POT; rec.cd_POT)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = cd_POTVisible;
//                 }
//                 part(lDi; "Liste DI-OT")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_OT = FIELD("code OT");
//                     Visible = lDiVisible;
//                 }
//             }
//             group(Costs)
//             {
//                 Caption = 'Costs';

//                 group("Main d'oeuvre")
//                 {
//                     Caption = 'Labour';
//                     field(pr_fcst_main; rec.pr_fcst_main)
//                     {

//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Editable = false;
//                         Caption = 'Expected Cost';

//                     }
//                     field(reel_main; rec.reel_main)
//                     {
//                         ApplicationArea = all;

//                         AutoFormatType = 1;
//                         Editable = false;
//                         Caption = 'Actual Cost';
//                     }
//                     field(ecart_main; rec.ecart_main)
//                     {
//                         ApplicationArea = all;

//                         AutoFormatType = 1;
//                         Editable = false;
//                         Caption = 'Variance';
//                     }
//                     field(per_main; rec.per_main)
//                     {

//                         DecimalPlaces = 3 : 3;
//                         Editable = false;
//                         Caption = 'Dev. %';
//                     }

//                 }


//                 group("Coût PDR")
//                 {
//                     Caption = 'Inventory cost';



//                     field(pr_fcst_stock; rec.pr_fcst_stock)
//                     {
//                         ApplicationArea = all;

//                         Caption = 'Expected Cost';
//                         AutoFormatType = 1;
//                         Editable = false;
//                     }
//                     field(reel_stock; rec.reel_stock)
//                     {

//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Editable = false;
//                         Caption = 'Actual Cost';
//                     }
//                     field(ecart_stock; rec.ecart_stock)
//                     {
//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Editable = false;
//                         Caption = 'Variance';
//                     }
//                     field(per_stock; rec.per_stock)
//                     {

//                         ApplicationArea = all;
//                         DecimalPlaces = 3 : 3;
//                         Editable = false;
//                         Caption = 'Dev. %';
//                     }

//                 }

//                 group("Coûts divers")
//                 {
//                     Caption = 'Various costs';




//                     field(pr_fcst_divers; rec.pr_fcst_divers)
//                     {
//                         ApplicationArea = all;

//                         Caption = 'Expected Cost';
//                         Editable = false;
//                     }
//                     field(reel_divers; rec.reel_divers)
//                     {
//                         ApplicationArea = all;

//                         Editable = false;
//                         Caption = 'Actual Cost';
//                     }






//                     field(ecart_divers; rec.ecart_divers)
//                     {
//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Editable = false;
//                         Caption = 'Variance';
//                     }
//                     field(per_divers; rec.per_divers)
//                     {
//                         ApplicationArea = all;
//                         DecimalPlaces = 3 : 3;
//                         Editable = false;
//                         Caption = 'Dev. %';
//                     }

//                 }



//                 group("Coût total")
//                 {
//                     Caption = 'Total Cost';




//                     field(fcst_total; rec.fcst_total)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Expected Cost';
//                         AutoFormatType = 1;
//                         Editable = false;
//                     }
//                     field(reel_total; rec.reel_total)
//                     {
//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Caption = 'Actual Cost';
//                         Editable = false;
//                     }


//                     field(ecart_total; rec.ecart_total)
//                     {
//                         ApplicationArea = all;
//                         AutoFormatType = 1;
//                         Editable = false;
//                         Caption = 'Variance';
//                     }
//                     field(per_total; rec.per_total)
//                     {
//                         ApplicationArea = all;
//                         DecimalPlaces = 3 : 3;
//                         Editable = false;
//                         Caption = 'Dev. %';
//                     }
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
//                     RunPageLink = "code site" = FIELD(cd_site);
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
//             // Currpage.btn_bt1.VISIBLE := TRUE;
//             btn_btVisible := FALSE;
//         END
//         ELSE BEGIN
//             //Currpage.btn_bt1.VISIBLE := FALSE;
//             btn_btVisible := TRUE;
//         END;

//         //test sur les travaux de garde
//         IF rec.Garde THEN BEGIN
//             "Avis de panneVisible" := TRUE;
//             cd_POTVisible := FALSE;
//             pr_fcst_stockVisible := FALSE;
//             pr_fcst_mainVisible := FALSE;
//             pr_fcst_diversVisible := FALSE;
//             fcst_totalVisible := FALSE;
//             prevuVisible := FALSE;
//             listDiVisible := FALSE;
//             lDiVisible := FALSE;
//             per_totalVisible := FALSE;
//             per_stockVisible := FALSE;
//             per_mainVisible := FALSE;
//             per_diversVisible := FALSE;
//             ecart_diversVisible := FALSE;
//             ecart_stockVisible := FALSE;
//             ecart_mainVisible := FALSE;
//             ecart_totalVisible := FALSE;
//             ecartVisible := FALSE;
//             percentVisible := FALSE;
//         END ELSE BEGIN
//             "Avis de panneVisible" := FALSE;
//             cd_POTVisible := TRUE;
//             pr_fcst_stockVisible := TRUE;
//             pr_fcst_mainVisible := TRUE;
//             pr_fcst_diversVisible := TRUE;
//             fcst_totalVisible := TRUE;
//             prevuVisible := TRUE;
//             listDiVisible := TRUE;
//             lDiVisible := TRUE;
//             per_totalVisible := TRUE;
//             per_stockVisible := TRUE;
//             per_mainVisible := TRUE;
//             per_diversVisible := TRUE;
//             ecart_diversVisible := TRUE;
//             ecart_stockVisible := TRUE;
//             ecart_mainVisible := TRUE;
//             ecart_totalVisible := TRUE;
//             ecartVisible := TRUE;
//             percentVisible := TRUE;

//         END;

//     end;

//     trigger OnInit()
//     begin
//         bo_consigne_DIEnable := TRUE;
//         percentVisible := TRUE;
//         ecartVisible := TRUE;
//         ecart_totalVisible := TRUE;
//         ecart_mainVisible := TRUE;
//         ecart_stockVisible := TRUE;
//         ecart_diversVisible := TRUE;
//         per_diversVisible := TRUE;
//         per_mainVisible := TRUE;
//         per_stockVisible := TRUE;
//         per_totalVisible := TRUE;
//         lDiVisible := TRUE;
//         listDiVisible := TRUE;
//         prevuVisible := TRUE;
//         fcst_totalVisible := TRUE;
//         pr_fcst_diversVisible := TRUE;
//         pr_fcst_mainVisible := TRUE;
//         pr_fcst_stockVisible := TRUE;
//         cd_POTVisible := TRUE;
//         "Avis de panneVisible" := TRUE;
//         btn_btVisible := TRUE;
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
//         [InDataSet]
//         btn_btVisible: Boolean;
//         [InDataSet]
//         "Avis de panneVisible": Boolean;
//         [InDataSet]
//         cd_POTVisible: Boolean;
//         [InDataSet]
//         pr_fcst_stockVisible: Boolean;
//         [InDataSet]
//         pr_fcst_mainVisible: Boolean;
//         [InDataSet]
//         pr_fcst_diversVisible: Boolean;
//         [InDataSet]
//         fcst_totalVisible: Boolean;
//         [InDataSet]
//         prevuVisible: Boolean;
//         [InDataSet]
//         listDiVisible: Boolean;
//         [InDataSet]
//         lDiVisible: Boolean;
//         [InDataSet]
//         per_totalVisible: Boolean;
//         [InDataSet]
//         per_stockVisible: Boolean;
//         [InDataSet]
//         per_mainVisible: Boolean;
//         [InDataSet]
//         per_diversVisible: Boolean;
//         [InDataSet]
//         ecart_diversVisible: Boolean;
//         [InDataSet]
//         ecart_stockVisible: Boolean;
//         [InDataSet]
//         ecart_mainVisible: Boolean;
//         [InDataSet]
//         ecart_totalVisible: Boolean;
//         [InDataSet]
//         ecartVisible: Boolean;
//         [InDataSet]
//         percentVisible: Boolean;
//         [InDataSet]
//         bo_consigne_DIEnable: Boolean;
//         Text19003993: Label 'WS List';
//         Text19072842: Label 'Actual Cost';
//         Text19028832: Label 'Dev. %';
//         Text19047697: Label 'Variance';
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

