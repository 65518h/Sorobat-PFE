// page 52049067 "Entete BT Curative"
// {//GL2024  ID dans Nav 2009 : "39004772"
//     PageType = Card;
//     Caption = 'BT Curative';
//     SourceTable = "Entete BT";
//     SourceTableView = SORTING(Code)
//                       WHERE(Type = FILTER(Curative));


//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';

//                 field(Code; REC.Code)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Type; REC.Type)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Equipement; REC.Equipement)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Immatriculation; REC.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }
//                 field(Observation; REC.Observation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Atelier; REC.Atelier)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Date Objectif"; REC."Date Objectif")
//                 {
//                     ApplicationArea = all;
//                 }

//                 field("Date Lancement"; REC."Date Lancement")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Traitement"; REC."Date Traitement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designiation Equipement"; REC."Designiation Equipement")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Index Actuelle"; REC."Index Actuelle")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("DA Associé"; REC."DA Associé")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Utilisateur; REC.Utilisateur)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//             }
//             group(Articles)
//             {
//                 Caption = 'Articles';
//                 part(ligne; "Subform Ligne BT")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code BT" = FIELD(Code);
//                 }
//             }
//             group(Intervenants)
//             {
//                 Caption = 'Intervenants';
//                 part(subform; "Subform Intervenants BT")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code BT" = FIELD(Code);
//                 }
//             }
//             group("Diagnostic et réparation")
//             {
//                 Caption = 'Diagnostic et réparation';
//                 part(observ; "Observation BT")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = BT = FIELD(Code),
//                                   Type = FILTER(Diagnostique);
//                 }
//             }
//             group("Ordre de Travail")
//             {
//                 Caption = 'Ordre de Travail';
//                 part(ordre; "Ordre de Travail GMAO")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = BT = FIELD(Code),
//                                   Type = FILTER('Ordre de Travail');
//                 }
//             }
//             group("Réparation")
//             {
//                 Caption = 'Réparation';
//                 field("Date Acceptation"; REC."Date Acceptation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Acceptation"; REC."Heure Acceptation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nature Panne"; REC."Nature Panne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Sous Nature Panne"; REC."Sous Nature Panne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Degré d'Urgence"; REC."Degré d'Urgence")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Prevision Réparation"; REC."Date Prevision Réparation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Descriptif Panne"; REC."Descriptif Panne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Prevision Réparation"; REC."Heure Prevision Réparation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Début Réparation"; REC."Date Début Réparation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Debut Réparation"; REC."Heure Debut Réparation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 // label(text)
//                 // {
//                 //     ApplicationArea = all;
//                 //     //CaptionClass = Text19024074;
//                 //     Style = Unfavorable;
//                 //     StyleExpr = TRUE;
//                 // }
//                 field("Date Fin réparation"; REC."Date Fin réparation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Heure Fin Réparation"; REC."Heure Fin Réparation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Motif  Ecart"; REC."Motif  Ecart")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Opération Realisées"; REC."Opération Realisées")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Mission)
//             {
//                 Caption = 'Mission';
//                 field(Chauffeur; REC.Chauffeur)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     var
//                         ChauffeurLocation: Record "Chauffeur Location";
//                     begin
//                         REC.CALCFIELDS("Nom Chauffeur", "Designation Vehicule");
//                         if ChauffeurLocation.get(rec.Chauffeur) then
//                             REC."Nom Chauffeur" := ChauffeurLocation.Nom;
//                     end;
//                 }
//                 field("Nom Chauffeur"; REC."Nom Chauffeur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Vehicule Mission"; REC."Vehicule Mission")
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     var
//                         Véhicule: Record Véhicule;
//                     begin
//                         REC.CALCFIELDS("Nom Chauffeur", "Designation Vehicule");

//                         if Véhicule.get(REC."Vehicule Mission") then
//                             REC."Designation Vehicule" := Véhicule."Désignation";

//                     end;
//                 }
//                 field("Designation Vehicule"; REC."Designation Vehicule")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group("Coût")
//             {
//                 Caption = 'Coût';
//                 field("Cout Article"; REC."Cout Article")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Cout Main d'oeuvre"; REC."Cout Main d'oeuvre")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Cout BT"; REC."Cout BT")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Promoted)
//         {
//             group(Fonction1)
//             {
//                 Caption = 'Fonction';
//                 actionref(Valider1; Valider) { }
//                 actionref(Imprimer1; Imprimer) { }
//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action(valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'valider';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         REC.TESTFIELD("Index Actuelle");
//                         CuGMAOParc.ValiderBT(Rec);
//                     end;
//                 }

//                 action(Imprimer)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer';

//                     trigger OnAction()
//                     begin
//                         RecEnteteBT.SETRANGE(Code, REC.Code);
//                         REPORT.RUNMODAL(50187, TRUE, TRUE, RecEnteteBT);
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         IF RecParametreParc.GET() THEN;
//         REC.Code := NoSeriesMgt.GetNextNo(RecParametreParc."Code BT Curative", 0D, TRUE);
//         REC.Type := REC.Type::Curative;
//         REC."Date Lancement" := TODAY;
//     end;

//     var
//         RecParametreParc: Record "Paramétre Parc";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         CuGMAOParc: Codeunit "Soroubat cdu";
//         RecEnteteBT: Record "Entete BT";
//         Text19024074: Label 'Opérations Realisées';
// }

