// Page 50149 "Declaration Trimes salaires"
// {
//     PageType = List;
//     SourceTable = "Declaration Trimes salaires";
//     ApplicationArea = all;
//     Caption = 'Déclaration Trimes salaires';
//     UsageCategory = Lists;


//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("Année"; REC.Année)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Matricule; REC.Matricule)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom et Prénom"; REC."Nom et Prénom")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° CNSS"; REC."N° CNSS")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Exclu De Dec Trim CNSS"; REC."Exclu De Dec Trim CNSS")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Collège"; REC.Collège)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Trimestre; REC.Trimestre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Page"; REC."N° Page")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Ligne"; REC."N° Ligne")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Mois 1"; REC."N° Mois 1")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mois 1';
//                 }
//                 field("N° Mois 2"; REC."N° Mois 2")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mois 2';
//                 }
//                 field("N° Mois 3"; REC."N° Mois 3")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Mois 3';
//                 }
//                 field("Mantant Mois 1"; REC."Mantant Mois 1")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Mantant Mois 2"; REC."Mantant Mois 2")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Mantant Mois 3"; REC."Mantant Mois 3")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Total Mantant"; REC."Total Mantant")
//                 {
//                     ApplicationArea = all;
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
//                 actionref("Imprimer Extrait C.N.S.S.1"; "Imprimer Extrait C.N.S.S.") { }

//             }
//         }
//         area(navigation)
//         {
//             group(Fonction)
//             {
//                 Caption = 'Fonction';
//                 action("Imprimer Extrait C.N.S.S.")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Imprimer Extrait C.N.S.S.';

//                     trigger OnAction()
//                     begin
//                         //IF AnnéePrime = 0 THEN
//                         // ERROR(Text001);

//                         DeclarationTrimessalaires.SetRange(DeclarationTrimessalaires.Matricule, REC.Matricule);
//                         Report.RunModal(50188, true, false, DeclarationTrimessalaires);
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         //GL2024  FormPrepLotSal: page 52048995;
//         Text001: label 'Erreur, Vous devez saisir une Année !!!';
//         RecLigneLotPaie: Record "Ligne Lot Paie";
//         Text002: label 'il n a rien à validé';
//         RecSalaryLines: Record "Rec. Salary Lines";
//         Text003: label 'Insertion Terminée';
//         "AnnéePrime": Integer;
//         Notesprime: Record Notes;
//         Salarie: Record Employee;
//         NbreFiche: Integer;
//         RecSalaryLines2: Record "Rec. Salary Lines";
//         Text004: label 'Confirmer L''insertion ?';
//         Affectat: Record Section;
//         Qualifica: Record Qualification;
//         SubFormNotePrime: Page "SubForm Note Prime";
//         DeclarationTrimessalaires: Record "Declaration Trimes salaires";
// }

