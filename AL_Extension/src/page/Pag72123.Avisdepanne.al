//GL3900 
// page 72123 "Avis de panne"
// {//GL2024  ID dans Nav 2009 : "39002123"
//     Caption = 'Failure Notice';
//     SourceTable = "Failure Notice";
//     SourceTableView = WHERE(Validé = CONST(false));
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'General';
//                 field("<Avis de panne>"; REC.code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Titre>"; REC.Titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Déclaré par>"; REC."Déclaré par")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Equipement>"; REC."code equipement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Matricule>"; REC."code matricule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Site>"; REC."code site")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Famille>"; REC."code famille")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Modèle>"; REC."code modele")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Date de la panne>"; REC.date)
//                 {
//                     ApplicationArea = all;
//                     Caption = '<Date de la panne>';
//                 }
//                 field("<Equipement arrêté>"; REC.Stop)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         IF REC.Stop THEN BEGIN

//                             "durée d'arrêtEDITABLE" := FALSE;
//                             REC."durée d'arrêt" := 0;
//                         END
//                         ELSE
//                             "durée d'arrêtEDITABLE" := TRUE
//                     end;
//                 }
//                 field("<Durée d'arrêt>"; REC."durée d'arrêt")
//                 {
//                     ApplicationArea = all;
//                     Editable = "durée d'arrêtEDITABLE";
//                 }
//                 part("TEXT ETENDU"; "TEXT ETENDU")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Table Name" = CONST(avis), "No." = FIELD(code);
//                 }
//             }
//             group(Suivi)
//             {
//                 Caption = 'Follow-Up';
//                 field("<Date de comptabiliation>"; REC."Date de saisie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<OT de garde>"; REC.OT)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("Avis de panne")
//             {
//                 Caption = 'Failure Notice';
//                 action(Lister)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'List';
//                     RunObject = Page "Liste avis de panne";
//                     RunPageView = WHERE(Validé = CONST(false));
//                     ShortCutKey = 'F5';
//                 }

//                 action(Equipement)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD("code equipement");
//                 }
//                 action(Matricule)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Register';
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD("code matricule");
//                 }
//                 action(Site)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD("code site");
//                 }
//                 action(Famille)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Family';
//                     RunObject = page "Fiche famille";
//                     RunPageLink = "code famille" = FIELD("code famille");
//                 }
//                 action("Modèle")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Model';
//                     RunObject = page "Fiche Modèle";
//                     RunPageLink = cd_pattern = FIELD("code modele");
//                 }

//             }
//             group("Functions")
//             {
//                 Caption = 'Functions';
//             }
//             /*  action("OT de garde")
//               {ApplicationArea = all;
//                   Visible=btn_otVISIBLE;
//                   Caption = 'Duty W.O';
//                   RunObject = Page 72124;
//                                   RunPageLink = Field1=FIELD(OT);
//               }*/
//             group("Functions2")
//             {
//                 Caption = 'Functions2';
//                 action("Créer OT de garde")
//                 {
//                     ApplicationArea = all;
//                     Visible = btn_createVISIBLE;
//                     Caption = 'Créer OT de garde';
//                     trigger OnAction()
//                     begin

//                         order.INIT;
//                         order.status := order.status::Lancé;
//                         order.Garde := TRUE;
//                         order.INSERT(TRUE);
//                         IF rec."code equipement" <> '' THEN
//                             order.VALIDATE(order.cd_box, rec."code equipement")
//                         ELSE
//                             IF rec."code matricule" <> '' THEN
//                                 order.VALIDATE(order.cd_matricule, rec."code matricule")
//                             ELSE
//                                 IF rec."code site" <> '' THEN
//                                     order.VALIDATE(order.cd_site, rec."code site");
//                         //order.nature :=
//                         order.dt_debut := CALCDATE('<-1D>', WORKDATE);
//                         order.dt_fin_ot := WORKDATE;
//                         order.demandeur := rec."Déclaré par";
//                         order.Responsable := rec."Déclaré par";
//                         workmgt.GET;
//                         order.time_debut := workmgt."Heure début garde";
//                         order.time_fin := workmgt."Heure fin garde";
//                         order.Titre := rec.Titre;
//                         order."Avis de panne" := rec.code;

//                         order.bo_equip_stop := rec.Stop;
//                         order.Temps_arrêt := rec."durée d'arrêt";
//                         order."Finished Date" := rec.date;
//                         order.MODIFY(TRUE);
//                         rec.OT := order."code OT";
//                         rec."Date de saisie" := order.dt_fin_ot;
//                         Rec.MODIFY;
//                         page.RUN(90114, order);

//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         //GL2024
//         IF rec.OT = '' THEN BEGIN
//             btn_createVISIBLE := TRUE;
//             btn_otVISIBLE := FALSE;
//         END ELSE BEGIN
//             btn_createVISIBLE := FALSE;
//             btn_otVISIBLE := TRUE;
//         END;
//         IF NOT rec.Stop THEN BEGIN
//             "durée d'arrêtEDITABLE" := FALSE;
//             rec."durée d'arrêt" := 0;
//         END
//         ELSE
//             "durée d'arrêtEDITABLE" := TRUE

//     end;

//     trigger OnOpenPage()
//     begin
//         //GL2024
//         IF rec.OT = '' THEN BEGIN
//             btn_createVISIBLE := TRUE;
//             btn_otVISIBLE := FALSE;
//         END ELSE BEGIN
//             btn_createVISIBLE := FALSE;
//             btn_otVISIBLE := TRUE;
//         END;

//         IF NOT rec.Stop THEN BEGIN
//             "durée d'arrêtEDITABLE" := FALSE;
//             //"durée d'arrêt" := 0;
//         END
//         ELSE
//             "durée d'arrêtEDITABLE" := TRUE

//     end;

//     var
//         "order": Record OT;
//         workmgt: Record "Work Setup";
//         [InDataSet]
//         "durée d'arrêtEDITABLE": Boolean;
//         [InDataSet]
//         btn_createVISIBLE: Boolean;
//         [InDataSet]
//         btn_otVISIBLE: Boolean;
// }

