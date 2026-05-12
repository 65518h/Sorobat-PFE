//GL3900 
// page 72120 "Avis de panne enregistrés"
// { //GL2024  ID dans Nav 2009 : "39002120"
//     Caption = 'Failure Notice';
//     SourceTable = "Failure Notice";
//     SourceTableView = WHERE(Validé = CONST(true));
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
//                     Caption = 'List';
//                     ShortCutKey = 'F5';
//                 }

//                 action(Equipement)
//                 {
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD("code equipement");
//                 }
//                 action(Matricule)
//                 {
//                     Caption = 'Register';
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD("code matricule");
//                 }
//                 action(Site)
//                 {
//                     Caption = 'Site';
//                     RunObject = page "Fiche Site";
//                     RunPageLink = "code site" = FIELD("code site");
//                 }
//                 action("OT de garde")
//                 {
//                     Caption = 'OT de garde';
//                     RunObject = Page "Fiche OT enregistré";
//                     RunPageLink = "code OT" = FIELD(OT);
//                 }
//             }
//             group("<Aide>1")
//             {
//                 Caption = 'Failure Notice';
//                 action("<Aide>")
//                 {
//                     Caption = '<Aide>';
//                 }
//             }
//         }
//     }

//     var
//         "order": Record OT;
//         workmgt: Record "Work Setup";
//         [InDataSet]
//         "durée d'arrêtEDITABLE": Boolean;
// }

