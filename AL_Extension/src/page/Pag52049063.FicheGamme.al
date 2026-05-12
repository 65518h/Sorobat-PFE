// page 52049063 "Fiche Gamme"
// {//GL2024  ID dans Nav 2009 : "39004767"
//     PageType = Card;
//     SourceTable = Gamme;

//     Caption = 'Fiche Gamme';


//     layout
//     {
//         area(content)
//         {
//             group(general)
//             {
//                 ShowCaption = false;
//                 field("Code Gamme"; REC."Code Gamme")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Desgniation; REC.Desgniation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code sous Famille Equipement"; REC."Code sous Famille Equipement")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Fréquence; REC.Fréquence)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Status; REC.Status)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Fréquence (Tolerance)"; REC."Fréquence (Tolerance)")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             group(Articles)
//             {
//                 Caption = 'Articles';
//                 part(ligne; "Subform Ligne Gamme Article")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code Gamme" = FIELD("Code Gamme");
//                 }
//             }
//             group(" Mode Opératoire")
//             {
//                 Caption = ' Mode Opératoire';
//                 part(subform; "Subform Ligne Gamme Mode Opera")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "Code Gamme" = FIELD("Code Gamme");
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
//                 actionref("Copier Gamme1"; "Copier Gamme") { }
//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Copier Gamme")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Copier Gamme';

//                     trigger OnAction()
//                     begin
//                         RecGamme.SETRANGE("Code Gamme", REC."Code Gamme");
//                         REPORT.RUNMODAL(REPORT::"Copier Gamme", TRUE, TRUE, RecGamme);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         RecGamme: Record Gamme;
//         RecParametreParc: Record "Paramétre Parc";
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//     // Text001: ;
// }

