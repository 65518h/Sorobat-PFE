// page 50424 " Liste Entete Suivi Mat Inf"
// {
//     PageType = List;
//     SourceTable = "Entete Suivi Materiel Inf";
//     Caption = 'Liste Suivi Matériel Informatique';
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     CardPageId = "Entete Suivi Mat Inf";
//     layout
//     {
//         area(content)
//         {

//             repeater("Control1")
//             {
//                 Caption = 'General';
//                 field("N° Document"; rec."N° Document")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Employee; rec.Employee)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Matricule';
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Nom Et Prenom"; rec."Nom Et Prenom")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affectation; rec.Affectation)
//                 {
//                     ApplicationArea = all;

//                     // trigger OnValidate()
//                     // begin
//                     //     AffectationOnAfterValidate;
//                     // end;
//                 }
//                 field("Description Affectation"; rec."Description Affectation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Qualification; rec.Qualification)
//                 {
//                     ApplicationArea = all;

//                     // trigger OnValidate()
//                     // begin
//                     //     QualificationOnAfterValidate;
//                     // end;
//                 }
//                 field("Description Qualification"; rec."Description Qualification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Statut; rec.Statut)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affaire; rec.Affaire)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Observation; rec.Observation)
//                 {
//                     ApplicationArea = all;
//                     // MultiLine = true;
//                     Visible = true;
//                 }
//                 field("Statut Bon De Sortie"; rec."Statut Bon De Sortie")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Type Document"; rec."Type Document")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field(Date; rec.Date)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Preleveur; rec.Preleveur)
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = TRUE;
//                 }
//                 field("Nom Preleveur"; rec."Nom Preleveur")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° BL"; rec."N° BL")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° BC"; rec."N° BC")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Doc Externe"; rec."N° Doc Externe")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             // part("Ligne Suivi Mat Inf"; "Ligne Suivi Mat Inf")
//             // {
//             //     ApplicationArea = all;
//             //     SubPageLink = "N° Document" = FIELD("N° Document");
//             // }
//         }
//     }

//     actions
//     {
//         // area(processing)
//         // {
//         //     action("Imprimer Bon")
//         //     {
//         //         Caption = 'Imprimer Bon';
//         //         Promoted = true;
//         //         PromotedCategory = Process;
//         //         ApplicationArea = all;

//         //         trigger OnAction()
//         //         begin
//         //             IF rec."Type Document" = 0 THEN ERROR(Text001);
//         //             EnteteSuiviMaterielInf.SETRANGE("N° Document", rec."N° Document");
//         //             REPORT.RUNMODAL(50238, TRUE, TRUE, EnteteSuiviMaterielInf);
//         //         end;
//         //     }
//         // }
//     }

//     // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     // begin
//     //     rec."N° Document" := NoSeriesMgt.GetNextNo('MATINFO', 0D, TRUE);
//     //     rec.Date := TODAY;
//     // end;

//     // var
//     //     NoSeriesMgt: Codeunit NoSeriesManagement;
//     //     EnteteSuiviMaterielInf: Record "Entete Suivi Materiel Inf";
//     //     Text001: Label 'Il Faut Séléctionner Type de document !!';

//     // local procedure AffectationOnAfterValidate()
//     // begin
//     //     rec.CALCFIELDS("Description Affectation");
//     // end;

//     // local procedure QualificationOnAfterValidate()
//     // begin
//     //     rec.CALCFIELDS("Description Qualification");
//     // end;
// }

