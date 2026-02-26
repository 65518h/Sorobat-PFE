//GL3900 
// page 74702 "Visite technique"
// {//GL2024  ID dans Nav 2009 : "39004702"
//     PageType = Card;
//     SourceTable = "Visite Technique";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';
//                 field("N° Visite"; REC."N° Visite")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Véhicule"; REC."N° Véhicule")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Cert. Visite"; REC."N° Cert. Visite")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Visite"; REC."Date Visite")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Fin Validité"; REC."Date Fin Validité")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° d'Ordre"; REC."N° d'Ordre")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Châssis"; REC."N° Châssis")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Im."; REC."N° Im.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; REC.Affectation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant T.F."; REC."Montant T.F.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Montant FPCSR"; REC."Montant FPCSR")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date document"; REC."Date document")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Valider; REC.Valider)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Visite Technique")
//             {
//                 Caption = 'Visite Technique';

//                 action("Fiche Véhicule")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Fiche Véhicule';
//                     RunObject = Page "Fiche Véhicule";
//                     RunPageLink = "N° Vehicule" = FIELD("N° Véhicule");
//                 }
//             }
//         }
//         area(processing)
//         {
//             action(Valider)
//             {
//                 Caption = 'Valider';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     IF NOT REC.Valider THEN BEGIN
//                         IF CONFIRM('Souhaitez vous valider la visite techinique', TRUE) THEN BEGIN
//                             REC.Valider := TRUE;
//                             REC.MODIFY;
//                         END;
//                     END ELSE
//                         ERROR('Visite Déjà Valider');
//                 end;
//             }
//         }
//     }
// }

