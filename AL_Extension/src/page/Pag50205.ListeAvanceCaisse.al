// Page 50205 "Liste Avance Caisse"
// {
//     DeleteAllowed = false;
//     //GL2024 Description = 'InsertAllowed=No';
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "Loan & Advance Lines";
//     ApplicationArea = all;
//     Caption = 'Liste Avance Caisse';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("No."; REC."No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Entry No."; REC."Entry No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Employee; REC.Employee)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Line Amount"; REC."Line Amount")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Month; REC.Month)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Year; REC.Year)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Paie"; REC."Date Paie")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Remboursement Anticipé"; REC."Remboursement Anticipé")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//             }
//             field(MontantSelect; MontantSelect)
//             {
//                 ApplicationArea = all;
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//                 Style = Unfavorable;
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
//                     MontantSelect := 0;
//                     RecPaymentLineSelect.Reset;
//                     CurrPage.SetSelectionFilter(RecPaymentLineSelect);
//                     if RecPaymentLineSelect.FindFirst then
//                         repeat
//                             MontantSelect += Abs(RecPaymentLineSelect.Amount);
//                         until RecPaymentLineSelect.Next = 0;
//                 end;
//             }
//             action("Coucher la Sélection")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Coucher la Sélection';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     RecPaymentLineSelect.Reset;
//                     CurrPage.SetSelectionFilter(RecPaymentLineSelect);
//                     if RecPaymentLineSelect.FindFirst then
//                         repeat
//                             RecPaymentLineSelect."Inserer Au Brouillard" := true;
//                             RecPaymentLineSelect.Modify;
//                         until RecPaymentLineSelect.Next = 0;
//                 end;
//             }
//             action("Intégrere En Comptabilité")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Intégrere En Comptabilité';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin

//                     DecMontantInsert := 0;
//                     RecPaymentLineInsert.Reset;
//                     RecPaymentLineDest.Reset;
//                     RecPaymentHeader.Reset;
//                     if RecPaymentHeader.Get(CodeDoc) then;

//                     // Calcule de Montant Selectionner
//                     RecPaymentLineInsert.SetRange("Inserer Au Brouillard", true);
//                     if RecPaymentLineInsert.FindFirst then
//                         repeat
//                             DecMontantInsert += RecPaymentLineInsert.Amount;
//                             RecPaymentLineInsert.Chrono := CodeDoc;
//                             RecPaymentLineInsert."Inserer Au Brouillard" := false;
//                             RecPaymentLineInsert.Modify;
//                         until RecPaymentLineInsert.Next = 0;

//                     // INSERTION AU NIVEAU DE BORDEREAUX
//                     RecPaymentLineDest.Init;
//                     RecPaymentLineDest.Validate("No.", CodeDoc);
//                     RecPaymentLineDest."Line No." := 10000;
//                     RecPaymentLineDest.Validate("Payment Class", RecPaymentHeader."Payment Class");
//                     RecPaymentLineDest.Validate("Status No.", RecPaymentHeader."Status No.");
//                     RecPaymentLineDest.Validate(RecPaymentLineDest."Type de compte", RecPaymentLineDest."type de compte"::"G/L Account");

//                     if RecSalaryHeaders.Get(RecPaymentLineInsert."N° Paie") then;
//                     Mois := RecSalaryHeaders.Month;
//                     Annee := RecSalaryHeaders.Year;
//                     DateEchiance := CalcDate('FM', Dmy2date(1, Mois + 1, Annee));
//                     RecPaymentLineDest.Validate("Due Date", DateEchiance);
//                     RecPaymentLineDest.Validate("Debit Amount", Abs(DecMontantInsert));
//                     if not RecPaymentLineDest.Modify then RecPaymentLineDest.Insert;

//                     // MISE A JOUR DATE COMPTABILISATION BORDERAU DE PAIEMENT
//                     RecPaymentHeader."Posting Date" := RecPaymentLineInsert."Due Date";
//                     RecPaymentHeader."Document Date" := RecPaymentLineInsert."Due Date";
//                     RecPaymentHeader.Modify;
//                     CurrPage.Close;
//                 end;
//             }
//         }
//     }

//     var
//         MontantSelect: Decimal;
//         CodeDoc: Code[20];
//         CodeAffect: Code[20];
//         RecPaymentLineInsert: Record "Payment Line";
//         RecPaymentLineSelect: Record "Payment Line";
//         DecMontantInsert: Decimal;
//         RecPaymentLineDest: Record "Payment Line";
//         RecPaymentHeader: Record "Payment Header";
//         Mois: Integer;
//         Annee: Integer;
//         DateEchiance: Date;
//         RecSalaryHeaders: Record "Rec. Salary Headers";
//         "Loan&AdvanceLines": Record "Loan & Advance Lines";


//     procedure GetParametres(ParmCodeDoc: Code[20])
//     begin
//         CodeDoc := ParmCodeDoc;
//     end;
// }

