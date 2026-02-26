//GL3900
// page 72078 "Fiche BT"
// {
//     //GL2024  ID dans Nav 2009 : "39002078"
//     PageType = Card;
//     SourceTable = BT;
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Fiche BT';
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code BT"; rec."code BT")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(cd_OT; rec.cd_OT)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(priorité; rec.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_debut; rec.dt_debut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(time_debut; rec.time_debut)
//                 {
//                     ApplicationArea = all;
//                 }


//                 field(status; rec.status)
//                 {
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         IF rec.status = rec.status::Lancé THEN
//                             CurrPage.resource.page.lanced()
//                         ELSE
//                             CurrPage.resource.page.planned();
//                     end;
//                 }
//                 field(nature; rec.nature)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_fin; rec.dt_fin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(time_fin; rec.time_fin)
//                 {
//                     ApplicationArea = all;
//                 }
//                 group("Intervention")
//                 {
//                     Caption = 'Intervention';
//                     field(cd_equipe; rec.cd_equipe)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(cd_technologie; rec.cd_technologie)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(temps_prevu; rec.temps_prevu)
//                     {
//                         ApplicationArea = all;
//                     }
//                     field("Nbre intervenant"; rec."Nbre intervenant")
//                     {
//                         ApplicationArea = all;
//                     }
//                     field(temps_arret; rec.temps_arret)
//                     {
//                         ApplicationArea = all;
//                     }
//                 }

//                 group("Intervention point")
//                 {
//                     Caption = 'Intervention point';
//                     field(cd_box; rec.cd_box)
//                     {
//                         ApplicationArea = all;
//                         Editable = true;
//                     }
//                     field(cd_site; rec.cd_site)
//                     {
//                         ApplicationArea = all;
//                         Editable = true;
//                     }
//                     field(cd_famille; rec.cd_famille)
//                     {
//                         ApplicationArea = all;
//                         Editable = true;
//                     }
//                     field(cd_modèle; rec.cd_modèle)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                     field(cd_matricule; rec.cd_matricule)
//                     {
//                         ApplicationArea = all;
//                         Editable = false;
//                     }
//                 }
//                 field("Description Intervention"; rec."Description Intervention")
//                 {
//                     ApplicationArea = all;
//                     MultiLine = true;
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
//                         ApplicationArea = all;
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
//             group(Technicians)
//             {
//                 Caption = 'Technicians';
//                 part(resource; "Liste intervenant/bt")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_bt = FIELD("code BT"), cd_ot = FIELD(cd_OT);
//                 }
//             }
//             group(Consumption)
//             {
//                 Caption = 'Consumption';
//                 part(ARTICLE; "Consommation article")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "code ot" = FIELD(cd_OT), "code bt" = FIELD("code BT");
//                 }
//             }
//             group(Works)
//             {
//                 Caption = 'Works';
//                 part(process; "Liste opertion bt")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "code bt" = FIELD("code BT"), "code ot" = FIELD(cd_OT);
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
//                                     risk_bt.RESET;
//                                     risk_bt.SETFILTER(risk_bt.cd_risque, risk_sec.cd_risque);
//                                     risk_bt.SETFILTER(risk_bt.cd_OT, rec.cd_OT);
//                                     risk_bt.SETRANGE(risk_bt.cd_BT, rec."code BT");
//                                     IF NOT risk_bt.FIND('-') THEN BEGIN
//                                         risk_bt.RESET;
//                                         risk_bt.cd_BT := rec."code BT";
//                                         risk_bt.cd_OT := rec.cd_OT;
//                                         risk_bt.cd_risque := risk_sec.cd_risque;
//                                         risk_bt.Libellé := risk_sec.Libellé;
//                                         // Win.UPDATE(1,risk_sec.cd_risque);
//                                         risk_bt.INSERT;
//                                     END;
//                                 UNTIL risk_sec.NEXT = 0;

//                             pre_sec.RESET;
//                             pre_sec.SETFILTER(pre_sec.cd_fiche_securité, rec.cd_fiche_securite);
//                             IF pre_sec.FIND('-') THEN
//                                 REPEAT
//                                     pre_bt.RESET;
//                                     pre_bt.SETFILTER(pre_bt.cd_prevention, pre_sec.cd_prevention);
//                                     pre_bt.SETFILTER(pre_bt.cd_OT, rec.cd_OT);
//                                     pre_bt.SETRANGE(pre_bt.cd_BT, rec."code BT");
//                                     IF NOT pre_bt.FIND('-') THEN BEGIN
//                                         pre_bt.RESET;
//                                         pre_bt.cd_BT := rec."code BT";
//                                         pre_bt.cd_OT := rec.cd_OT;
//                                         pre_bt.cd_prevention := pre_sec.cd_prevention;
//                                         pre_bt.Libellé := pre_sec.Libellé;
//                                         //Win.UPDATE(2,pre_sec.cd_prevention);
//                                         pre_bt.INSERT;
//                                     END;
//                                 UNTIL pre_sec.NEXT = 0;
//                         END;
//                         cdfichesecuriteOnAfterValidate;
//                     end;
//                 }
//                 part(Risks; "Liste Risque BT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Risks';
//                     SubPageLink = cd_OT = FIELD(cd_OT), cd_BT = FIELD("code BT");
//                 }

//                 part(prevention; "Liste prévention BT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Preventions';
//                     SubPageLink = cd_OT = FIELD(cd_OT), cd_BT = FIELD("code BT");
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Operations)
//             {
//                 Caption = 'Operations';
//                 action(Outillages)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Outillages';

//                     trigger OnAction()
//                     begin
//                         OUTIL.SETRANGE(OUTIL.cd_ot, rec.cd_OT);
//                         OUTIL.SETRANGE(OUTIL.cd_bt, rec."code BT");
//                         PAGE.RUN(PAGE::Outillages, OUTIL);
//                     end;
//                 }
//                 action("Update Costs")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Update Costs';

//                     trigger OnAction()
//                     begin
//                         rec.COST();
//                     end;
//                 }
//             }
//             group(BT)
//             {
//                 Caption = 'WS';

//                 action("Joined WS")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Joined WS';
//                     RunObject = Page "Liste BT";
//                     RunPageLink = cd_OT = FIELD(cd_OT);
//                 }
//                 action(WO)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO';
//                     RunObject = Page "Fiche OT";
//                     RunPageLink = "code OT" = FIELD(cd_OT);
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
//                 action(Model)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Model';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD(cd_modèle);
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
//         IF rec.status = rec.status::Lancé THEN BEGIN
//             CurrPage.resource.Page.lanced();
//             CurrPage.ARTICLE.Page.lanced();
//             CurrPage.process.Page.lanced();

//         END
//         ELSE BEGIN
//             CurrPage.resource.Page.planned();
//             CurrPage.ARTICLE.Page.planned();
//             CurrPage.process.Page.planned();
//         END;
//     end;

//     var
//         fiche: Record "Fiche securité";
//         risk_sec: Record "Risque securité";
//         pre_sec: Record "prevention securité";
//         risk_bt: Record "Risque BT";
//         pre_bt: Record "Prevention BT";
//         OUTIL: Record Tools;
//         EXP: Codeunit "Consumption treatment";
//         Text19006919: Label 'Preventions';
//         Text19078659: Label 'Expected Cost';
//         Text19072842: Label 'Actual Cost';
//         Text19047697: Label 'Variance';
//         Text19028832: Label 'Dev. %';

//     local procedure cdfichesecuriteOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;
// }

