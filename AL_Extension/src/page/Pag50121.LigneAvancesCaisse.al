// Page 50121 "Ligne Avances Caisse"
// {
//     Editable = false;
//     PageType = List;
//     SourceTable = "Payment Line";
//     SourceTableView = sorting("Due Date")
//                       where(Caisse = const(true), "Code Opération" = const('P2'));
//     ApplicationArea = all;
//     Caption = 'Ligne Avances Caisse';
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             label(Control1000000028)
//             {
//                 ApplicationArea = all;
//                 Caption = '.............Avances Ligne Caisse................';
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//             repeater(Control1)
//             {
//                 Editable = true;
//                 ShowCaption = false;
//                 field("Numero Seq"; REC."Numero Seq")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//                 field("Line No."; REC."Line No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Due Date"; REC."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date';
//                 }
//                 field("Posting Date"; REC."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Benificiaire; REC.Benificiaire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Nom Benificiaire"; REC."Nom Benificiaire")
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
//                 field("No."; REC."No.")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("N° Affaire"; REC."N° Affaire")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field("Type Origine"; REC."Type Origine")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
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
//                 field("Date Debut"; REC."Date Debut")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date D''affectation';
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
//                 field(MoisPaie; REC.MoisPaie)
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
//                 field("Date Affectation"; REC."Date Debut")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Date Affectation';
//                 }
//                 field(Tranche; REC.Tranche)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Chrono; REC.Chrono)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//             field(DecSommDebit; DecSommDebit)
//             {
//                 ApplicationArea = all;
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//                 ShowCaption = false;
//             }
//             field(DecSommCredit; DecSommCredit)
//             {
//                 ApplicationArea = all;
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//                 Style = Attention;
//                 StyleExpr = true;
//                 ShowCaption = false;
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

//     var
//         DecSommDebit: Decimal;
//         DecSommCredit: Decimal;
//         RecPaymentLineSelect: Record "Payment Line";
//         Text19029061: label 'Avances Ligne Caisse';
// }

