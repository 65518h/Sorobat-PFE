// Page 50177 "Liste Paie Caisse"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     PageType = List;
//     SourceTable = "Payment Line";
//     SourceTableView = sorting("No.", "Line No.")
//                       where(Caisse = filter(true),
//                             "Code Opération" = filter('P1' | 'P4' | '23' | '26'),
//                             Chrono = filter(' '),
//                             "Validé Caisse" = const(true));
//     ApplicationArea = all;
//     Caption = 'Liste Paie Caisse';
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
//                 field("Inserer Au Brouillard"; REC."Inserer Au Brouillard")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Chrono; REC.Chrono)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Due Date"; REC."Due Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Amount; REC.Amount)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("N° Paie"; REC."N° Paie")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(MoisPaie; REC.MoisPaie)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(AnnePaie; REC.AnnePaie)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Code Opération"; REC."Code Opération")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Benificiaire; REC.Benificiaire)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Benificiaire"; REC."Nom Benificiaire")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Affect; REC.Affect)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Designation Affectation"; REC."Designation Affectation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Debit Amount"; REC."Debit Amount")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Credit Amount"; REC."Credit Amount")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("External Document No."; REC."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Posting Date"; REC."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Libellé"; REC.Libellé)
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
//                 ShowCaption = false;
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
//                     DateEchiance := 0D;
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

//                     //IF RecSalaryHeaders.GET(RecPaymentLineInsert."N° Paie") THEN;
//                     //Mois:=RecSalaryHeaders.Month;
//                     //Annee:=RecSalaryHeaders.Year;
//                     Mois := Date2dmy(RecPaymentLineInsert."Due Date", 2) - 1; //RecPaymentLineInsert.moisPaie;
//                     Annee := Date2dmy(RecPaymentLineInsert."Due Date", 3); //RecPaymentLineInsert.AnnePaie;
//                     DateEchiance := CalcDate('FM', Dmy2date(1, Mois, Annee));
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

//     trigger OnOpenPage()
//     begin
//         //GetParametres(CodeDoc);
//         if CodeAffect <> '' then REC.SetRange(Affect, CodeAffect);
//     end;

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


//     procedure GetParametres(ParmCodeDoc: Code[20]; ParmCodeAffect: Code[20])
//     begin
//         CodeDoc := ParmCodeDoc;
//         CodeAffect := ParmCodeAffect;
//     end;
// }

