// GL3900 
// page 71560 "MIS-Ord. Mission Enreg"
// {
//     //GL2024  ID dans Nav 2009 : "39001560"
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = Card;
//     SourceTable = "Entete frais mission";
//     SourceTableView = WHERE("Statut ordre mission" = FILTER(Cloture));
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'MIS-Ord. Mission Enreg';
//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N° Demande"; rec."N° Demande")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Type mission"; rec."Type mission")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Demandeur; rec.Demandeur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Demandeur"; rec."Nom Demandeur")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° CIN"; rec."N° CIN")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Qualite; rec.Qualite)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Objet mission"; rec."Objet mission")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Commentaire; rec.Commentaire)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     MultiLine = true;
//                 }
//                 field(AffichDetail; AffichDetail)
//                 {
//                     ApplicationArea = all;
//                     OptionCaption = 'Equipe de la mission,Frais de la mission';

//                     trigger OnValidate()
//                     begin
//                         IF AffichDetail = AffichDetail::"Frais mission" THEN
//                             FraismissionAffichDetailOnVali;
//                         IF AffichDetail = AffichDetail::"Equipe mission" THEN
//                             EquipemissionAffichDetailOnVal;
//                     end;
//                 }
//                 field("Item Budget Name"; rec."Item Budget Name")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Budget';
//                     Editable = false;
//                 }
//                 field("Enveloppe Bank"; rec."Enveloppe Bank")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Destination; rec.Destination)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Moyen transport"; rec."Moyen transport")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date debut"; rec."Date debut")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date fin"; rec."Date fin")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Statut ordre mission"; rec."Statut ordre mission")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//             part(Equipe; "MIS-Equipe Ord. Mission")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 SubPageLink = "N° Demande" = FIELD("N° Demande");
//                 Visible = EquipeVisible;
//             }
//             part(Frais; "MIS-Ligne Fr. Mis.")
//             {
//                 ApplicationArea = all;
//                 Editable = false;
//                 SubPageLink = "N°" = FIELD("N° Demande");
//                 Visible = FraisVisible;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Imprimer...")
//             {
//                 Caption = '&Imprimer...';
//                 action("Imprimer Ordre de mission")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer Ordre de mission';

//                     trigger OnAction()
//                     begin
//                         CurrPage.SETSELECTIONFILTER(Rec);
//                         IF rec."Type mission" = rec."Type mission"::Etranger THEN
//                             REPORT.RUNMODAL(70080, TRUE, FALSE, Rec)
//                         ELSE
//                             REPORT.RUNMODAL(70082, TRUE, FALSE, Rec);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         EquipeVisible := AffichDetail = 0;
//         FraisVisible := AffichDetail = 1;
//     end;

//     trigger OnInit()
//     begin
//         FraisVisible := TRUE;
//         EquipeVisible := TRUE;
//     end;

//     var
//         AffichDetail: Option "Equipe mission","Frais mission";
//         RecGUserSetUp: Record "User Setup";
//         Text001: Label 'Veuiller paramétrer le modéle feuille frais de mission.';
//         RecGGenJournalLine: Record "Gen. Journal Line";
//         RecLTemplateJournal: Record "Gen. Journal Template";
//         RecGHumResSetup: Record "Human Resources Setup";
//         IntGLine: Integer;
//         RecGGenJournalBatch: Record "Gen. Journal Batch";
//         RecGLigneFrais: Record "Ligne frais de mission";
//         [InDataSet]
//         EquipeVisible: Boolean;
//         [InDataSet]
//         FraisVisible: Boolean;

//     local procedure EquipemissionAffichDetailOnAft()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure FraismissionAffichDetailOnAfte()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure EquipemissionAffichDetailOnVal()
//     begin
//         EquipeVisible := AffichDetail = 0;
//         FraisVisible := AffichDetail = 1;
//         EquipemissionAffichDetailOnAft;
//     end;

//     local procedure FraismissionAffichDetailOnVali()
//     begin
//         EquipeVisible := AffichDetail = 0;
//         FraisVisible := AffichDetail = 1;
//         FraismissionAffichDetailOnAfte;
//     end;
// }

