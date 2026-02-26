// Page 50204 "Ligne Caisse Brouillard"
// {
//     PageType = List;
//     SourceTable = "Payment Line";
//     SourceTableView = sorting("Due Date")
//                       where(Caisse = const(true),
//                             "Type Caisse" = const(C),
//                             Chrono = filter(' '));
//     ApplicationArea = all;
//     Caption = 'Ligne Caisse Brouillard';
//     layout
//     {
//         area(content)
//         {
//             field(NumBorderaux; NumBorderaux)
//             {
//                 ApplicationArea = all;
//                 Caption = 'N° Borderaux';
//                 Editable = false;
//                 Enabled = true;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             repeater(Control1)
//             {
//                 Editable = false;
//                 ShowCaption = false;
//                 field("No."; REC."No.")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Due Date"; REC."Due Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Chrono; REC.Chrono)
//                 {
//                     ApplicationArea = all;
//                     Visible = false;
//                 }
//                 field("Numero Seq"; REC."Numero Seq")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Origine"; REC."Type Origine")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Benificiaire; REC.Benificiaire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Benificiaire"; REC."Nom Benificiaire")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Code Opération"; REC."Code Opération")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Type Caisse"; REC."Type Caisse")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Libellé"; REC.Libellé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Debit Amount"; REC."Debit Amount")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Recettes';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Credit Amount"; REC."Credit Amount")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Depenses';
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Numero Seq Retour"; REC."Numero Seq Retour")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("External Document No."; REC."External Document No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affaire; REC.Affaire)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Chantier';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Validé Caisse"; REC."Validé Caisse")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Caisse Validé ';
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Commentaires; REC.Commentaires)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("N° Paie"; REC."N° Paie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Description Paie"; REC."Description Paie")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Affect; REC.Affect)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Qualification; REC.Qualification)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designation Affectation"; REC."Designation Affectation")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Designation Qualification"; REC."Designation Qualification")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Date Debut"; REC."Date Debut")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Affectation';
//                 }
//                 field(Tranche; REC.Tranche)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//             field(DecSommDebit; DecSommDebit)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Débit ';
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             field(DecSommCredit; DecSommCredit)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Crédit';
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//                 Style = Attention;
//                 StyleExpr = true;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Calculer la Sélection")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Calculer la Sélection';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     RecPaymentLineSelect.Reset;
//                     DecSommDebit := 0;
//                     DecSommCredit := 0;
//                     CurrPage.SetSelectionFilter(RecPaymentLineSelect);
//                     if RecPaymentLineSelect.FindFirst then
//                         repeat
//                             DecSommDebit += RecPaymentLineSelect."Debit Amount";
//                             DecSommCredit += RecPaymentLineSelect."Credit Amount";
//                         until RecPaymentLineSelect.Next = 0;
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         RegroupementPaieEntete.FindFirst();
//         NumBorderaux := RegroupementPaieEntete."N° Caisse";
//     end;

//     var
//         DecSommDebit: Decimal;
//         DecSommCredit: Decimal;
//         RecPaymentLineSelect: Record "Payment Line";
//         RegroupementPaieEntete: Record "Regroupement Paie Entete";
//         NumBorderaux: Code[20];
//         RecPaymentHeader: Record "Payment Header";
// }

