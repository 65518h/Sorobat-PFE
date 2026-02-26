//GL3900 
// page 72096 "Liste DI reportées"
// {
//     //GL2024  ID dans Nav 2009 : "39002096"
//     Caption = 'Reported IR';
//     Editable = true;
//     PageType = List;
//     SourceTable = DI;
//     SourceTableView = SORTING("code demande intervention")
//                       ORDER(Descending)
//                       WHERE(status = CONST(Reportée));

//     ApplicationArea = all;
//     UsageCategory = Lists;


//     layout
//     {
//         area(content)
//         {
//             field(TODAY; TODAY)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Date';
//             }
//             field(TIME; TIME)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Time';
//             }
//             repeater(liste)
//             {
//                 Editable = false;
//                 field("code demande intervention"; rec."code demande intervention")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(titre; rec.titre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dt_creation; rec.dt_creation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_equipement; rec.cd_equipement)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_site; rec.cd_site)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_matricule; rec.cd_matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(priorité; rec.priorité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(status; rec.status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(emetteur; rec.emetteur)
//                 {
//                     ApplicationArea = all;
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
//                         rec.status := rec.status::Refusée;
//                         MESSAGE(text001, rec."code demande intervention");
//                         CurrPage.UPDATE;
//                     end;
//                 }
//                 action(Validate)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Validate';

//                     trigger OnAction()
//                     begin
//                         rec.status := rec.status::Requête;
//                         rec.MODIFY;
//                         MESSAGE(Text003, rec."code demande intervention");
//                     end;
//                 }

//                 group(Navigate)
//                 {
//                     Caption = 'Navigate';
//                     action("Rejected IR")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Rejected IR';
//                         RunObject = Page "Liste DI";
//                         RunPageView = SORTING("code demande intervention")
//                                       ORDER(Ascending)
//                                       WHERE(status = CONST(Refusée));
//                     }
//                     action("Emited IR")
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Emited IR';
//                         RunObject = Page "Liste DI PEC";
//                     }
//                 }
//             }
//             group(btn_di)
//             {
//                 Caption = 'IR';
//                 Visible = btn_diVisible;
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Fiche DI";
//                     RunPageLink = "code demande intervention" = FIELD("code demande intervention");
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

//     trigger OnInit()
//     begin
//         btn_actionVisible := TRUE;
//         btn_diVisible := TRUE;
//     end;

//     trigger OnOpenPage()
//     begin
//         DI.RESET;
//         DI.SETFILTER(DI.status, 'reportée');
//         IF NOT DI.FIND('-') THEN BEGIN
//             btn_diVisible := FALSE;
//             btn_actionVisible := FALSE;
//             MESSAGE(text002);
//         END;
//     end;

//     var
//         text001: Label 'The Intervention request %1 was rejected';
//         text002: Label 'There is no Intervention request';
//         DI: Record DI;
//         Text003: Label 'DI Pris En Compte N° %1';
//         [InDataSet]
//         btn_diVisible: Boolean;
//         [InDataSet]
//         btn_actionVisible: Boolean;
// }

