//GL3900 
// page 72105 "Fiche DI refusée"
// {//GL2024  ID dans Nav 2009 : "39002105"
//     Caption = 'Rejected IR ';
//     Editable = false;
//     PageType = Card;
//     SourceTable = DI;
//     SourceTableView = SORTING("code demande intervention")
//                       ORDER(Ascending)
//                       WHERE(status = CONST(Refusée));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';

//                 field("code demande intervention"; REC."code demande intervention")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(titre; REC.titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(emetteur; REC.emetteur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_creation; REC.dt_creation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_destinateur; REC.cd_destinateur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_fin_souhaité; REC.dt_fin_souhaité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_fiche_securité; REC.cd_fiche_securité)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         fiche.RESET;
//                         IF REC.cd_fiche_securité <> '' THEN BEGIN
//                             // Win.OPEN('Insertion Risque      ########1#### \\'+
//                             //          'Insertion Prevention  ########2####');

//                             risk_sec.RESET;
//                             risk_sec.SETFILTER(risk_sec.cd_fiche_securité, REC.cd_fiche_securité);
//                             IF risk_sec.FIND('-') THEN
//                                 REPEAT
//                                     risk_di.RESET;
//                                     risk_di.SETFILTER(risk_di.cd_risque, risk_sec.cd_risque);
//                                     risk_di.SETFILTER(risk_di.cd_DI, REC."code demande intervention");
//                                     IF NOT risk_di.FIND('-') THEN BEGIN
//                                         risk_di.RESET;
//                                         risk_di.cd_DI := REC."code demande intervention";
//                                         risk_di.cd_risque := risk_sec.cd_risque;
//                                         risk_di.Libellé := risk_sec.Libellé;
//                                         // Win.UPDATE(1,risk_sec.cd_risque);
//                                         risk_di.INSERT;
//                                     END;
//                                 UNTIL risk_sec.NEXT = 0;

//                             pre_sec.RESET;
//                             pre_sec.SETFILTER(pre_sec.cd_fiche_securité, REC.cd_fiche_securité);
//                             IF pre_sec.FIND('-') THEN
//                                 REPEAT
//                                     pre_di.RESET;
//                                     pre_di.SETFILTER(pre_di.cd_prévention, pre_sec.cd_prevention);
//                                     pre_di.SETFILTER(pre_di.cd_DI, REC."code demande intervention");
//                                     IF NOT pre_di.FIND('-') THEN BEGIN
//                                         pre_di.RESET;
//                                         pre_di.cd_DI := REC."code demande intervention";
//                                         pre_di.cd_prévention := pre_sec.cd_prevention;
//                                         pre_di.Libellé := pre_sec.Libellé;
//                                         //Win.UPDATE(2,pre_sec.cd_prevention);
//                                         pre_di.INSERT;
//                                     END;
//                                 UNTIL pre_sec.NEXT = 0;
//                         END;
//                         cdfichesecurit233OnAfterValida;
//                     end;
//                 }
//                 field(priorité; REC.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_equipement; REC.cd_equipement)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; REC.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; REC.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_symphôme; REC.cd_symphôme)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("origine de la panne"; REC."origine de la panne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_equipement_stop; REC.bo_equipement_stop)
//                 {
//                     ApplicationArea = all;
//                 }
//                 label(text1)
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19053330;
//                 }
//                 part(risque; "Risque DI")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_DI = FIELD("code demande intervention");
//                 }
//                 label(text2)
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19006919;
//                 }
//                 part(prevention; "Liste prévention DI")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_DI = FIELD("code demande intervention");
//                 }
//             }
//             group("WO's Follow up")
//             {
//                 Caption = 'WO''s Follow up';
//                 field(status; REC.status)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                 }
//                 field(dt_prise_en_compte; REC.dt_prise_en_compte)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reject date';
//                     Editable = false;
//                     Visible = true;
//                 }
//                 field(cd_OT; REC.cd_OT)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(btn_action)
//             {
//                 Caption = 'Fonction&s';
//                 Visible = btn_actionVisible;
//                 action(Reject)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reject';
//                     Image = Reject;

//                     trigger OnAction()
//                     begin
//                         REC.status := REC.status::Refusée;
//                         MESSAGE(text001, REC."code demande intervention");
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action(Validate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Validate';
//                     RunObject = Page "Affectation OT";
//                     RunPageLink = "code demande intervention" = FIELD("code demande intervention");
//                 }
//             }
//             group(btn_ot)
//             {
//                 Caption = 'WO';
//                 action("WO card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO card';
//                     RunObject = Page "Fiche OT";
//                     RunPageLink = "code OT" = FIELD(cd_OT);
//                 }
//             }
//             group(IR)
//             {
//                 Caption = 'IR';

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

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnInit()
//     begin
//         btn_actionVisible := TRUE;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         IF REC.status = REC.status::Requête THEN
//             btn_actionVisible := TRUE
//         ELSE
//             btn_actionVisible := FALSE;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     var
//         fiche: Record "Fiche securité";
//         pre_sec: Record "prevention securité";
//         risk_sec: Record "Risque securité";
//         pre_di: Record "prevention DI";
//         risk_di: Record "Risque DI";
//         Win: Dialog;
//         text001: Label 'The intervention request %1 was rejected';

//         btn_actionVisible: Boolean;
//         Text19053330: Label 'Risks';
//         Text19006919: Label 'Preventions';

//     local procedure cdfichesecurit233OnAfterValida()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         /*
//         IF status = status::"Prise en compte" THEN
//           BEGIN
//              Currpage.dt_prise_en_compte.VISIBLE := TRUE;
//              Currpage.cd_OT.VISIBLE := TRUE;
//              Currpage.btn_ot.ENABLED := TRUE;
//           END
//         ELSE
//           BEGIN
//              Currpage.dt_prise_en_compte.VISIBLE := FALSE;
//              Currpage.cd_OT.VISIBLE := FALSE;
//              Currpage.btn_ot.ENABLED := FALSE;
//           END;
//         */

//         IF REC.status = REC.status::Requête THEN
//             btn_actionVisible := TRUE
//         ELSE
//             btn_actionVisible := FALSE;

//     end;
// }

