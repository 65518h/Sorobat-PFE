//GL3900 
// page 71568 "MIS-Demande FM archivée"
// {//GL2024  ID dans Nav 2009 : "39001568"
//     DeleteAllowed = false;
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Entete demande frais mission";
//     SourceTableView = where("Ordre mission cree" = filter(true));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'MIS-Demande FM archivée';
//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 Editable = false;
//                 field("N° Demande"; Rec."N° Demande")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 label(Control1120003)
//                 {
//                     ApplicationArea = Basic;
//                     Description = 'SourceExpr=Demandeur';
//                 }
//                 field("Nom Demandeur"; Rec."Nom Demandeur")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("N° CIN"; Rec."N° CIN")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field(Qualite; Rec.Qualite)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Objet mission"; Rec."Objet mission")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Commentaire; Rec.Commentaire)
//                 {
//                     ApplicationArea = Basic;
//                     MultiLine = true;
//                 }
//                 field("Type mission"; Rec."Type mission")
//                 {
//                     ApplicationArea = Basic;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Destination; Rec.Destination)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Moyen transport"; Rec."Moyen transport")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date debut"; Rec."Date debut")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Date fin"; Rec."Date fin")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Statut; Rec.Statut)
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//             }


//             part("STC Enregistré All"; "STC Enregistré All")
//             {

//                 //DYS erreur dans NAV
//                 // subpageLink="N° Demande"=FIELD("N° Demande");
//                 Editable = false;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Fonction&s")
//             {
//                 Caption = 'Fonction&s';
//                 action("Envoyer demande d'approbation")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Envoyer demande d''approbation';

//                     trigger OnAction()
//                     var
//                         RecLAction: Record "BR Heure Suplémentaire";
//                     begin
//                         Rec.TestField(Demandeur);
//                         Rec.TestField(Destination);
//                         Rec.TestField("Moyen transport");
//                         Rec.TestField("Date debut");
//                         Rec.TestField("Date fin");
//                         Rec.TestField("Objet mission");
//                         VerifierEquipe;
//                         //GL2024
//                         IF (REC.Statut = 0) THEN BEGIN
//                             //DYS erreur dans NVA
//                             //   IF RecLAction.DemadeApprobation(70074,14,REC."N° Demande") THEN
//                             //   BEGIN
//                             //     REC.Statut:=REC.Statut::"En cours approbation";
//                             //     REC.MODIFY;
//                             //     MESSAGE('%1',Text004);
//                             //   END
//                             //   ELSE
//                             //     ERROR(Text003);
//                         END
//                         ELSE BEGIN
//                             IF REC.Statut = 1 THEN
//                                 ERROR(Text005);
//                         END;

//                     end;
//                 }
//                 action(Refuser)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Refuser';

//                     trigger OnAction()
//                     begin
//                         Rec.Statut := Rec.Statut::Refuse;
//                         Rec.Modify;
//                     end;
//                 }
//                 separator(Action1120029)
//                 {
//                 }
//                 action("Créer ordre de mission")
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Créer ordre de mission';

//                     trigger OnAction()
//                     begin
//                         Rec.TestField(Statut, Rec.Statut::Valide);
//                         if not Rec."Ordre mission cree" then
//                             CreerOrgreMission
//                         else
//                             Error(Text002);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         CurrPage.Editable(Rec.Statut = Rec.Statut::"En attente");
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     var
//         Text003: label 'Il n''existe aucuns approbateurs pour ce compte.';
//         Text004: label 'La demande d''approbation a été lancée avec succès.';
//         Text005: label 'La demande d''approbation a déjà été lancée.';
//         Text001: label 'L''equipe doit contenir au minimum un salarié!';
//         Text002: label 'Ordre de mission déjà géneré!';


//     procedure CreerOrgreMission()
//     var
//         RecLOrdreMission: Record "Entete frais mission";
//         RecLEquipMission: Record "Equipe mission";
//         RecLEquipDemandMission: Record "Equipe demande  mission";
//         RecLLgneFraisMission: Record "Ligne frais de mission";
//     begin
//         RecLOrdreMission.Init;
//         RecLOrdreMission.TransferFields(Rec);
//         RecLOrdreMission.Insert;

//         RecLEquipDemandMission.SetRange(RecLEquipDemandMission."N° Demande", Rec."N° Demande");
//         if RecLEquipDemandMission.FindFirst then
//             repeat
//                 RecLEquipMission.Init;
//                 RecLEquipMission.TransferFields(RecLEquipDemandMission);
//                 RecLEquipMission.Insert;
//             /*RecLLgneFraisMission.INIT;
//             RecLLgneFraisMission."N°":=
//             RecLLgneFraisMission."N° Ligne":=
//             RecLLgneFraisMission."N° Salarier":=
//             RecLLgneFraisMission."Code Frais mission":=
//             RecLLgneFraisMission.Designation:=
//             RecLLgneFraisMission."Global Dimension 1":=
//             RecLLgneFraisMission."Global Dimension 2":=
//             RecLLgneFraisMission.INSERT;*/
//             until RecLEquipDemandMission.Next = 0;
//         Rec."Ordre mission cree" := true;
//         Rec.Modify;
//         Message('Ordre de mission créé avec succès.');

//     end;


//     procedure VerifierEquipe()
//     var
//         RecLEquipe: Record "Equipe demande  mission";
//     begin
//         RecLEquipe.SetRange(RecLEquipe."N° Demande", Rec."N° Demande");
//         //RecLEquipe.SETRANGE(RecLEquipe."Employee No.",'<>%1','');
//         if not RecLEquipe.FindFirst then
//             Error(Text001);
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         CurrPage.Editable(true);
//     end;
// }

