//GL3900 
// page 72063 "Fiche DI"
// {
//     //GL2024  ID dans Nav 2009 : "39002063"
//     Caption = 'IR Card';
//     Editable = true;
//     PageType = Card;
//     SourceTable = DI;
//     SourceTableView = SORTING("code demande intervention")
//                       ORDER(Ascending)
//                       WHERE(status = CONST(Requête));
//     ApplicationArea = all;
//     UsageCategory = Administration;


//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("code demande intervention"; rec."code demande intervention")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(titre; rec.titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(emetteur; rec.emetteur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_creation; rec.dt_creation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_destinateur; rec.cd_destinateur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_fin_souhaité; rec.dt_fin_souhaité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_fiche_securité; rec.cd_fiche_securité)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         fiche.RESET;
//                         IF rec.cd_fiche_securité <> '' THEN BEGIN
//                             // Win.OPEN('Insertion Risque      ########1#### \\'+
//                             //          'Insertion Prevention  ########2####');

//                             risk_sec.RESET;
//                             risk_sec.SETFILTER(risk_sec.cd_fiche_securité, rec.cd_fiche_securité);
//                             IF risk_sec.FIND('-') THEN
//                                 REPEAT
//                                     risk_di.RESET;
//                                     risk_di.SETFILTER(risk_di.cd_risque, risk_sec.cd_risque);
//                                     risk_di.SETFILTER(risk_di.cd_DI, rec."code demande intervention");
//                                     IF NOT risk_di.FIND('-') THEN BEGIN
//                                         risk_di.RESET;
//                                         risk_di.cd_DI := rec."code demande intervention";
//                                         risk_di.cd_risque := risk_sec.cd_risque;
//                                         risk_di.Libellé := risk_sec.Libellé;
//                                         // Win.UPDATE(1,risk_sec.cd_risque);
//                                         risk_di.INSERT;
//                                     END;
//                                 UNTIL risk_sec.NEXT = 0;

//                             pre_sec.RESET;
//                             pre_sec.SETFILTER(pre_sec.cd_fiche_securité, rec.cd_fiche_securité);
//                             IF pre_sec.FIND('-') THEN
//                                 REPEAT
//                                     pre_di.RESET;
//                                     pre_di.SETFILTER(pre_di.cd_prévention, pre_sec.cd_prevention);
//                                     pre_di.SETFILTER(pre_di.cd_DI, rec."code demande intervention");
//                                     IF NOT pre_di.FIND('-') THEN BEGIN
//                                         pre_di.RESET;
//                                         pre_di.cd_DI := rec."code demande intervention";
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
//                 field(priorité; rec.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_equipement; rec.cd_equipement)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; rec.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; rec.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_symphôme; rec.cd_symphôme)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("origine de la panne"; rec."origine de la panne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_equipement_stop; rec.bo_equipement_stop)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part(risque; "Risque DI")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Risks';
//                 SubPageLink = cd_DI = FIELD("code demande intervention");
//             }
//             part(prevention; "Liste prévention DI")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Preventions';
//                 SubPageLink = cd_DI = FIELD("code demande intervention");
//             }
//             group("WO's Follow up")
//             {
//                 Caption = 'WO''s Follow up';
//                 field(status; rec.status)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Enabled = true;
//                 }
//                 field(dt_prise_en_compte; rec.dt_prise_en_compte)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = dt_prise_en_compteVisible;
//                 }
//                 field(cd_OT; rec.cd_OT)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = cd_OTVisible;
//                 }
//             }

//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(btn_ot)
//             {
//                 Caption = 'WO';
//                 Visible = false;
//                 action("WO card")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO card';
//                     RunObject = Page "Fiche OT";
//                     RunPageLink = "code OT" = FIELD(cd_OT);
//                 }
//             }
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
//                         rec.status := rec.status::Refusée;
//                         MESSAGE(text001, rec."code demande intervention");
//                         MESSAGE(text001, rec."code demande intervention");
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action(Validate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Validate';
//                     RunObject = Page "Affectation OT";
//                     RunPageLink = "code demande intervention" = FIELD("code demande intervention");

//                     trigger OnAction()
//                     begin
//                         rec.status := rec.status::"Prise en compte";
//                         rec.MODIFY;
//                     end;
//                 }
//                 action("Reportée")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Reportée';

//                     trigger OnAction()
//                     begin
//                         rec.status := rec.status::Reportée;
//                         rec.MODIFY;
//                     end;
//                 }
//             }
//             group(IR)
//             {
//                 Caption = 'IR';
//                 separator(separator100)
//                 {
//                 }
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
//                 separator(separator200)
//                 {
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
//         btn_otEnable := TRUE;
//         btn_actionVisible := TRUE;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         IF rec.status = rec.status::Requête THEN
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
//         [InDataSet]
//         dt_prise_en_compteVisible: Boolean;
//         [InDataSet]
//         cd_OTVisible: Boolean;
//         [InDataSet]
//         btn_actionVisible: Boolean;
//         [InDataSet]
//         btn_otEnable: Boolean;
//         Text19053330: Label 'Risks';
//         Text19006919: Label 'Preventions';

//     local procedure cdfichesecurit233OnAfterValida()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         IF rec.status = rec.status::"Prise en compte" THEN BEGIN
//             dt_prise_en_compteVisible := TRUE;
//             cd_OTVisible := TRUE;
//             btn_otEnable := TRUE;
//         END
//         ELSE BEGIN
//             dt_prise_en_compteVisible := FALSE;
//             cd_OTVisible := FALSE;
//             btn_otEnable := FALSE;
//         END;


//         IF rec.status = rec.status::Requête THEN
//             btn_actionVisible := TRUE
//         ELSE
//             btn_actionVisible := FALSE;
//     end;
// }

