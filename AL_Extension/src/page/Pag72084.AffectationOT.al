//GL3900
// page 72084 "Affectation OT"
// {
//     //GL2024  ID dans Nav 2009 : "39002084"
//     Caption = 'WO Allocation';
//     SourceTable = DI;
//     SourceTableView = WHERE(status = CONST(Requête));
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("<Demande d'intervention>"; rec."code demande intervention")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Titre>"; rec.titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Date de création>"; rec.dt_creation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Emetteur>"; rec.emetteur)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("<Fin souhaité>"; rec.dt_fin_souhaité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 label("WO List")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO List';
//                 }
//                 part("List_OT"; "Liste Ot requête")
//                 {
//                     Caption = 'Liste Ot requête';
//                     SubPageLink = status = CONST(Planifié),
//                                   cd_box = FIELD(cd_equipement),
//                                   cd_matricule = FIELD(cd_matricule),
//                                   cd_site = FIELD(cd_site);
//                     SubPageView = SORTING("code OT")
//                                   ORDER(Descending);
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             group("<OT>")
//             {
//                 Caption = 'WO';
//                 Visible = "btn_ot.VISIBLE";
//                 action("<Action1000000009>")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO card';

//                     trigger OnAction()
//                     begin
//                         ot1.RESET;

//                         CurrPAGE.List_OT.Page.GETRECORD(ot1);
//                         PAGE.RUN(Page::"Fiche OT", ot1);
//                     end;
//                 }
//             }
//             group(DI)
//             {
//                 Caption = 'IR';

//                 action("<Action1000000010>")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'IR card';
//                     RunObject = Page "Fiche DI";
//                     RunPageLink = "code demande intervention" = FIELD("code demande intervention");
//                 }
//                 action("<Action1000000011>")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment card';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD(cd_equipement);
//                 }
//                 action("<Action1000000012>")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Site card';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD(cd_site);
//                 }
//                 action("<Action1000000013>")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fiche Matricule';
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD(cd_matricule);
//                 }
//             }
//             group("Action1")
//             {
//                 Caption = 'Action';
//                 Visible = "btn_action1.VISIBLE";
//                 action("Nouveau OT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'New WO';
//                     trigger OnAction()
//                     begin

//                         ot.RESET;
//                         ot.status := ot.status::Planifié;
//                         ot."code OT" := '';
//                         ot.INSERT(TRUE);
//                         ot.Titre := rec.titre;
//                         ot.demandeur := rec.emetteur;
//                         ot.cd_box := rec.cd_equipement;
//                         ot.cd_model := rec.cd_model;
//                         ot.dt_fin_ot := DT2DATE(rec.dt_fin_souhaité);
//                         ot.dt_debut := WORKDATE;
//                         ot.cd_symptom := rec.cd_symphôme;
//                         ot.bo_consigne_DI := TRUE;
//                         ot.cd_matricule := rec.cd_matricule;
//                         ot.cd_site := rec.cd_site;
//                         ot.dt_create := CURRENTDATETIME;
//                         ot.bo_equip_stop := rec.bo_equipement_stop;
//                         ot.VALIDATE(ot.bo_consigne_DI, TRUE);
//                         ot.MODIFY;



//                         ot_di.RESET;
//                         ot_di.cd_OT := ot."code OT";
//                         ot_di.cd_DI := rec."code demande intervention";
//                         ot_di.date_prise_en_compte := CURRENTDATETIME;
//                         ot_di.Titre_DI := rec.titre;
//                         ot_di.INSERT(TRUE);
//                         RecDi.COPY(Rec);
//                         RecDi.dt_prise_en_compte := CURRENTDATETIME;
//                         RecDi.cd_OT := ot."code OT";
//                         RecDi.status := rec.status::"Prise en compte";
//                         //RecDi.MODIFY;

//                         //form.run(90060,ot);
//                         MESSAGE(text001, rec."code demande intervention", ot."code OT");
//                         Currpage.CLOSE;
//                     end;
//                 }

//             }
//             group("Action")
//             {
//                 Caption = 'Action';
//                 Visible = "btn_action.VISIBLE";
//                 action("Affecter OT")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO Allocate';

//                     trigger OnAction()
//                     begin
//                         ot.RESET;
//                         ot.status := ot.status::Planifié;
//                         ot."code OT" := '';
//                         ot.INSERT(TRUE);
//                         ot.Titre := rec.titre;
//                         ot.demandeur := rec.emetteur;
//                         ot.cd_box := rec.cd_equipement;
//                         ot.cd_model := rec.cd_model;
//                         ot.dt_fin_ot := DT2DATE(rec.dt_fin_souhaité);
//                         ot.dt_debut := WORKDATE;
//                         ot.cd_symptom := rec.cd_symphôme;
//                         ot.bo_consigne_DI := TRUE;
//                         ot.cd_matricule := rec.cd_matricule;
//                         ot.cd_site := rec.cd_site;
//                         ot.dt_create := CURRENTDATETIME;
//                         ot.bo_equip_stop := rec.bo_equipement_stop;
//                         ot.VALIDATE(ot.bo_consigne_DI, TRUE);
//                         ot.MODIFY;
//                         ot_di.RESET;
//                         ot_di.cd_OT := ot."code OT";
//                         ot_di.cd_DI := rec."code demande intervention";
//                         ot_di.date_prise_en_compte := CURRENTDATETIME;
//                         ot_di.Titre_DI := rec.titre;
//                         ot_di.INSERT(TRUE);

//                         //dt_prise_en_compte := CURRENTDATETIME;
//                         //cd_OT := ot."code OT";
//                         /////status := status::"Prise en compte";
//                         //// MODIFY;

//                         //form.run(90060,ot);
//                         MESSAGE(text001, rec."code demande intervention", ot."code OT");
//                         CurrPage.CLOSE;
//                     end;
//                 }
//                 action("Affecter OT1")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'WO Allocate';

//                     trigger OnAction()
//                     begin
//                         ot.RESET;

//                         Currpage.List_OT.Page.GETRECORD(ot);
//                         IF ot."code OT" <> '' THEN BEGIN
//                             ot_di.RESET;
//                             ot.RESET;

//                             Currpage.List_OT.Page.GETRECORD(ot);
//                             ot_di.cd_OT := ot."code OT";
//                             ot_di.cd_DI := rec."code demande intervention";
//                             ot_di.date_prise_en_compte := CURRENTDATETIME;
//                             ot_di.Titre_DI := rec.titre;
//                             ot_di.INSERT(TRUE);
//                             rec.status := rec.status::"Prise en compte";
//                             rec.dt_prise_en_compte := CURRENTDATETIME;
//                             rec.cd_OT := ot."code OT";
//                             Rec.MODIFY;
//                             MESSAGE(text001, rec."code demande intervention", ot."code OT");

//                             PAGE.RUN(90060, ot);
//                             CurrPage.CLOSE;

//                         END
//                         ELSE
//                             MESSAGE(text002);
//                     end;
//                 }

//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin

//         ot.RESET;
//         Currpage.List_OT.page.GETRECORD(ot);
//         IF ot."code OT" <> '' THEN BEGIN
//             "btn_ot.VISIBLE" := TRUE;
//             "btn_action.VISIBLE" := TRUE;
//             "btn_action1.VISIBLE" := FALSE;

//         END
//         ELSE BEGIN
//             "btn_ot.VISIBLE" := FALSE;
//             "btn_action.VISIBLE" := FALSE;
//             "btn_action1.VISIBLE" := TRUE;
//         END;

//         //GL2024  Currpage.UPDATECONTROLS;

//     end;

//     var
//         ot: Record OT;
//         ot1: Record OT;
//         ot_di: Record "OT-DI";
//         RecDi: Record DI;
//         text001: Label 'The intervention request %1 was affected to the work order %2';
//         text002: Label 'Compatiblle WO list is empty,you must create a new one';
//         [InDataSet]
//         "btn_ot.VISIBLE": Boolean;
//         [InDataSet]
//         "btn_action.VISIBLE": Boolean;
//         [InDataSet]
//         "btn_action1.VISIBLE": Boolean;
// }

