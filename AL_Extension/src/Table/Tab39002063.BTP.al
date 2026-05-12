// Table 39002063 BTP
// {
//     //GL2024  ID dans Nav 2009 : "39002063"
//     DrillDownPageID = "Liste BTP";
//     LookupPageID = "Liste BTP";

//     fields
//     {
//         field(1; "code BTP"; Integer)
//         {
//             Caption = 'Preventive Work sheet';
//         }
//         field(2; cd_OTP; Code[10])
//         {
//             Caption = 'Preventive Work order';
//             //GL3900    TableRelation = OTP."code OTP";
//         }
//         field(3; "priorité"; Option)
//         {
//             Caption = 'Priority';
//             OptionCaption = 'Secondary,Normal,72 Hours,48 Hours,24 Hours';
//             OptionMembers = Secondaire,Normale,"72 Heures","48 Heures","24 Heures";
//         }
//         field(4; status; Option)
//         {
//             Caption = 'Status';
//             OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
//             OptionMembers = "Simulé","Planifié","Planifié ferme","Lancé","Terminé";
//         }
//         field(5; nature; Code[10])
//         {
//             Caption = 'Nature';
//             //GL3900  TableRelation = "Nature travaux"."code nature";
//         }
//         field(6; cd_cost_center; Code[10])
//         {
//             Caption = 'Cost center';
//         }
//         field(7; dt_debut; Date)
//         {
//             Caption = 'Begin date';
//         }
//         field(8; dt_fin; Date)
//         {
//             Caption = 'End date';
//         }
//         field(9; cd_box; Code[10])
//         {
//             Caption = 'Equipment';
//             //GL3900   TableRelation = Equipement.cd_box;
//         }
//         field(10; cd_site; Code[10])
//         {
//             Caption = 'Site';
//             //GL3900   TableRelation = Site."code site";
//         }
//         field(11; cd_famille; Code[10])
//         {
//             Caption = 'Family';
//             //GL3900   TableRelation = Famille."code famille";
//         }
//         field(12; "cd_modèle"; Code[10])
//         {
//             Caption = 'Model';
//             //GL3900   TableRelation = model.cd_pattern;
//         }
//         field(13; cd_matricule; Code[10])
//         {
//             Caption = 'Register';
//             //GL3900   TableRelation = Matricule."code matricule";
//         }
//         field(14; cd_equipe; Code[10])
//         {
//             Caption = 'Team';
//             //GL3900    TableRelation = Equipes."code équipe";
//         }
//         field(15; cd_technologie; Code[10])
//         {
//             Caption = 'Technology';
//             //GL3900   TableRelation = Technologie."code technologie";
//         }
//         field(16; temps_prevu; Time)
//         {
//             Caption = 'Planned time';
//         }
//         field(17; "Nbre intervenant"; Integer)
//         {
//             Caption = 'Technicians Number';
//         }
//         field(18; temps_arret; Time)
//         {
//             Caption = 'Stop time';
//         }
//         field(19; cd_fiche_securite; Code[10])
//         {
//             Caption = 'Security card';
//             //GL3900   TableRelation = "Fiche securité"."code fiche securite";
//         }
//         field(20; souche; Code[10])
//         {
//             TableRelation = "No. Series";
//         }
//         field(21; Titre; Text[100])
//         {
//             Caption = 'Title';
//         }
//         field(22; "consigne sur DI"; Boolean)
//         {
//             Caption = 'IR Instructions';
//         }
//         field(33; pr_fcst_main; Decimal)
//         {
//             Caption = 'Expected labour cost';
//         }
//         field(34; pr_fcst_prest; Decimal)
//         {
//             Caption = 'Expected Service cost';
//         }
//         field(36; pr_fcst_stock; Decimal)
//         {
//             Caption = 'Expected inventory cost';
//         }
//         field(37; pr_fcst_divers; Decimal)
//         {
//             Caption = 'Expected various cost';
//         }
//         field(38; fcst_total; Decimal)
//         {
//             Caption = 'Expected total';
//         }
//         field(57; time_debut; Time)
//         {
//             Caption = 'Start time';
//         }
//         field(58; time_fin; Time)
//         {
//             Caption = 'End time';
//         }
//         field(59; "code intervention"; Code[10])
//         {
//         }
//     }

//     keys
//     {
//         key(STG_Key1; cd_OTP, cd_box, "code intervention", "code BTP")
//         {
//             Clustered = true;
//         }
//         key(STG_Key2; "code BTP")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         /*
//         //suppression des risques
//         risk_bt.RESET;
//         risk_bt.SETFILTER(risk_bt.cd_OT,cd_OT);
//         risk_bt.SETRANGE(risk_bt.cd_BT,"code BT");
//         IF risk_bt.FIND('-') THEN
//           REPEAT
//            risk_bt.DELETE(TRUE);
//          UNTIL risk_bt.NEXT = 0;

//         //suppression des préventions
//         prev_bt.RESET;
//         prev_bt.SETFILTER(prev_bt.cd_OT,cd_OT);
//         prev_bt.SETRANGE(prev_bt.cd_BT,"code BT");
//         IF prev_bt.FIND('-') THEN
//           REPEAT
//            prev_bt.DELETE(TRUE);
//          UNTIL prev_bt.NEXT = 0;

//         //suppression des consommations articles
//         artBt.RESET;
//         artBt.SETFILTER(artBt."code ot",cd_OT);
//         artBt.SETRANGE(artBt."code bt","code BT");
//         IF artBt.FIND('-') THEN
//           REPEAT
//             artBt.DELETE(TRUE);
//           UNTIL artBt.NEXT = 0;

//         //suppression des Consommations ressources
//         ResBT.RESET;
//         ResBT.SETFILTER(ResBT.cd_ot,cd_OT);
//         ResBT.SETRANGE(ResBT.cd_bt,"code BT");
//         IF ResBT.FIND('-') THEN
//           REPEAT
//             ResBT.DELETE(TRUE);
//           UNTIL ResBT.NEXT = 0;

//         //suppression des coûts divers
//         Dcost.RESET;
//         Dcost.SETFILTER(Dcost."code ot",cd_OT);
//         Dcost.SETRANGE(Dcost."code bt","code BT");
//         IF Dcost.FIND('-') THEN
//           REPEAT
//             Dcost.DELETE(TRUE);
//           UNTIL Dcost.NEXT = 0;*/

//     end;

//     var
//     //GL3900 
//     /*  risk_bt: Record "Risque BT";
//       prev_bt: Record "Prevention BT";
//       artBt: Record "ARTICLE/BT";
//       ResBT: Record "Intervenant/bt";
//       Dcost: Record "Coûts divers BT";*/ //GL3900 
//                                          //GL3900 
//                                          /*
//                                              procedure "BT EXPECTED COSTS"()
//                                              var
//                                                  ART: Record "ARTICLE/BT";
//                                                  INTERV: Record "Intervenant/bt";
//                                                  "COST ARTICLE": Decimal;
//                                                  "COST INTERV": Decimal;
//                                                  "COST LINE INTERV": Decimal;
//                                                  "COST LINE ARTICLE": Decimal;
//                                                  "Cost Divers": Decimal;
//                                                  "Cost line divers": Decimal;
//                                                  divers: Record "Coûts divers BT";
//                                                  total: Decimal;
//                                              begin
//                                                  //calcul du coût prévu pour la main d'oeuvre
//                                                  "COST INTERV" := 0;
//                                                  INTERV.Reset;
//                                                  INTERV.SetFilter(INTERV.cd_ot, cd_OTP);
//                                                  INTERV.SetRange(INTERV.cd_bt, "code BTP");
//                                                  if INTERV.Find('-') then
//                                                      repeat
//                                                          "COST LINE INTERV" := 0;
//                                                          "COST LINE INTERV" := INTERV.Quantité_prévue * INTERV."Unit cost";
//                                                          "COST INTERV" := "COST INTERV" + "COST LINE INTERV";
//                                                      until INTERV.Next = 0;

//                                                  //affectation de la valeur calculée au bt
//                                                  Rec.pr_fcst_main := "COST INTERV";
//                                                  Rec.Modify(true);

//                                                  //calcul du coût prévu pour la consommation art
//                                                  "COST ARTICLE" := 0;
//                                                  ART.Reset;
//                                                  ART.SetFilter(ART."code ot", cd_OTP);
//                                                  ART.SetRange(ART."code bt", "code BTP");
//                                                  if ART.Find('-') then
//                                                      repeat
//                                                          "COST LINE ARTICLE" := 0;
//                                                          "COST LINE ARTICLE" := ART."Quantité prévue" * ART."coût unitaire";
//                                                          "COST ARTICLE" := "COST ARTICLE" + "COST LINE ARTICLE";
//                                                      until ART.Next = 0;

//                                                  //affectation de la valeur calculée au bt
//                                                  Rec.pr_fcst_stock := "COST ARTICLE";
//                                                  Rec.Modify(true);

//                                                  //calcul du coût prévu pour Les frais divers
//                                                  "Cost Divers" := 0;
//                                                  divers.Reset;
//                                                  divers.SetFilter(divers."code ot", cd_OTP);
//                                                  divers.SetRange(divers."code bt", "code BTP");
//                                                  if divers.Find('-') then
//                                                      repeat
//                                                          "Cost Divers" := "Cost Divers" + divers.Coût;
//                                                      until divers.Next = 0;

//                                                  //affectation de la valeur calculée au bt
//                                                  Rec.pr_fcst_divers := "Cost Divers";
//                                                  Rec.Modify(true);

//                                                  //calcul du total prévu
//                                                  total := 0;
//                                                  total := "COST ARTICLE" + "COST INTERV" + "Cost Divers";
//                                                  //affectation de la valeur calculée au bt
//                                                  Rec.fcst_total := total;
//                                                  Rec.Modify(true);
//                                              end;
//                                              */ //GL3900 
// }

