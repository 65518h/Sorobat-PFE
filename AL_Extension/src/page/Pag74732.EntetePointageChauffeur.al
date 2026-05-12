// page 74732 "Entete Pointage Chauffeur"
// {//GL2024  ID dans Nav 2009 : "39004732"
//     Editable = true;
//     PageType = Card;
//     SourceTable = "Entete Pointage Chauffeur";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("N° Document"; REC."N° Document")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Journee1; REC.Journee)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         AffectationOnValidate;
//                         AffectationOnAfterValidate;
//                     end;
//                 }
//                 field("Designation Affectation"; REC."Designation Affectation")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             part(ligne; "Ligne Pointage Chauffeur")
//             {
//                 ApplicationArea = all;
//                 SubPageLink = "N° Document" = FIELD("N° Document"),
//                               Journee = FIELD(Journee),
//                               "Code Affaire" = FIELD(Affectation);
//             }
//         }
//     }

//     actions
//     {
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
//                         IF NOT CONFIRM(Text001) THEN EXIT;
//                         IF REC.Journee = 0D THEN ERROR(Text002);
//                         EntetePointageChauffeurEnre.TRANSFERFIELDS(Rec);
//                         EntetePointageChauffeurEnre.INSERT;
//                         PointageChauffeur.RESET;
//                         PointageChauffeur.SETRANGE("N° Document", REC."N° Document");
//                         IF PointageChauffeur.FINDFIRST THEN
//                             REPEAT
//                                 PointageChauffeur.TESTFIELD("Nombre Heure");
//                                 PointageChauffeurEnregistre.TRANSFERFIELDS(PointageChauffeur);
//                                 PointageChauffeurEnregistre.INSERT;
//                             UNTIL PointageChauffeur.NEXT = 0;

//                         // SUPPRESSION
//                         //message("N° Document");


//                         REC.DELETE;

//                         PointageChauffeur.RESET;
//                         PointageChauffeur.SETRANGE("N° Document", REC."N° Document");
//                         PointageChauffeur.DELETEALL;
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         EntetePointageChauffeur: Record "Entete Pointage Chauffeur";
//         EntetePointageChauffeurEnr2: Record "Entete Pointage Chauffeur Enre";
//         EntetePointageChauffeurEnr3: Record "Entete Pointage Chauffeur Enre";
//         EntetePointageChauffeurEnr4: Record "Entete Pointage Chauffeur Enre";
//         PointageChauffeur: Record "Ligne Pointage Chauffeur";
//         PointageChauffeurEnregistre: Record "Ligne Pointage Chauffeur Enr";
//         DteJournee: Date;
//         Affectation: Code[20];
//         RecVehicule: Record "Véhicule";
//         PointageChauffeur2: Record "Ligne Pointage Chauffeur";
//         Text001: Label 'Confirmer Cette Action ?';
//         Text002: Label 'Vous Devez Preciser La Journee';
//         Text003: Label 'Vous Devez D''abords Valider La Journee %1';
//         Text004: Label 'Journee Deja Saisie';
//         LignePointageChauffeurEnr: Record "Ligne Pointage Chauffeur Enr";
//         EntetePointageChauffeurEnre: Record "Entete Pointage Chauffeur Enre";
//         EnteteRendementVehicule: Record "Entete rendement Vehicule";
//         LigneRendementVehicule: Record "Ligne Rendement Vehicule";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         ParametreParc: Record "Paramétre Parc";

//     local procedure AffectationOnAfterValidate()
//     begin
//         CurrPage.UPDATE;
//     end;

//     local procedure AffectationOnValidate()
//     begin
//         IF Affectation = '' THEN EXIT;
//         REC.CALCFIELDS("Designation Affectation");
//         IF REC.Journee = 0D THEN ERROR(Text002);

//         EntetePointageChauffeurEnr2.SETRANGE(Journee, REC.Journee);
//         EntetePointageChauffeurEnr2.SETRANGE(Affectation, Affectation);
//         //IF EntetePointageChauffeurEnr2.FINDFIRST THEN ERROR(Text004);

//         EntetePointageChauffeurEnr3.SETCURRENTKEY(Journee);
//         EntetePointageChauffeurEnr3.SETFILTER(Journee, '<%1', REC.Journee);
//         EntetePointageChauffeurEnr3.SETRANGE(Affectation, Affectation);
//         IF EntetePointageChauffeurEnr3.FINDLAST THEN BEGIN
//             LignePointageChauffeurEnr.SETRANGE("N° Document", EntetePointageChauffeurEnr3."N° Document");
//             IF LignePointageChauffeurEnr.FINDFIRST THEN
//                 REPEAT
//                     PointageChauffeur2.TRANSFERFIELDS(LignePointageChauffeurEnr);
//                     PointageChauffeur2."N° Document" := REC."N° Document";
//                     PointageChauffeur2.Journee := REC.Journee;
//                     IF PointageChauffeur2.INSERT THEN;
//                 UNTIL LignePointageChauffeurEnr.NEXT = 0;
//         END
//         ELSE BEGIN
//             RecVehicule.SETRANGE(Marche, Affectation);
//             IF RecVehicule.FINDFIRST THEN
//                 REPEAT
//                     RecVehicule.CALCFIELDS("Designation Affaire", "Designation Sous Affaire");
//                     PointageChauffeur2."N° Document" := REC."N° Document";
//                     PointageChauffeur2.Vehicule := RecVehicule."N° Vehicule";
//                     PointageChauffeur2.Journee := REC.Journee;
//                     PointageChauffeur2."Code Affaire" := RecVehicule.Marche;
//                     PointageChauffeur2."Code Sous Affaire" := RecVehicule."Sous Affaire";
//                     PointageChauffeur2.Chauffeur := RecVehicule.Chauffeur;
//                     IF NOT PointageChauffeur2.INSERT THEN PointageChauffeur2.MODIFY;
//                 UNTIL RecVehicule.NEXT = 0;
//         END;
//     end;
// }

