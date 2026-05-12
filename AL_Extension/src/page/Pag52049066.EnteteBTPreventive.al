// page 52049066 "Entete BT Preventive"
// {//GL2024  ID dans Nav 2009 : "39004771"
//     PageType = Card;
//     Caption = 'BT Preventive';
//     SourceTable = "Entete BT";
//     SourceTableView = SORTING(Code)
//                       WHERE(Type = FILTER(Preventive));
//     ApplicationArea = All;


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
//                 field(Gamme; REC.Gamme)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Observation; REC.Observation)
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
//                 field("Designiation Gamme"; REC."Designiation Gamme")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Frequence; REC.Frequence)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Immatriculation; REC.Immatriculation)
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = TRUE;
//                 }

//                 field("Index Actuelle"; REC."Index Actuelle")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Date Objectif"; REC."Date Objectif")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Atelier; REC.Atelier)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("DA Associé"; REC."DA Associé")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'DA Associé';
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
//             group("Mode Operatoire")
//             {
//                 Caption = 'Mode Operatoire';
//                 part(subfor; "Subform Ligne Gamme Mode Opera")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code Gamme" = FIELD(Gamme);
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
//                 action(Valider)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Valider';
//                     ShortCutKey = 'F9';

//                     trigger OnAction()
//                     begin
//                         REC.TESTFIELD("Index Actuelle");
//                         IF RecEquipement.GET(REC.Equipement) THEN;
//                         RecEquipement."BT Prev En cours" := FALSE;
//                         RecEquipement.MODIFY;
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

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     begin
//         //ERROR(Text001);
//         //MH SORO 14-06-2021

//         IF RecParametreParc.GET() THEN;
//         REC.Code := NoSeriesMgt.GetNextNo(RecParametreParc."Code BT Preventive", 0D, TRUE);
//         REC.Type := REC.Type::Preventive;
//         REC."Date Lancement" := TODAY;

//         //MH SORO 14-06-2021
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     var
//         Text001: Label 'Erreur !!! Vous ne pouvez pas créer un BT Preventive !!!';
//         RecEquipement: Record "Véhicule";
//         CuGMAOParc: Codeunit "Soroubat cdu";
//         RecEnteteBT: Record "Entete BT";
//         RecParametreParc: Record "Paramétre Parc";
//         NoSeriesMgt: Codeunit NoSeriesManagement;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         REC."Cout BT" := REC."Cout Article" + REC."Cout Main d'oeuvre";
//     end;
// }

