// Page 50181 "Liste Avance/Pret Caisse"
// {
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Payment Line";
//     SourceTableView = sorting("No.", "Line No.")
//                       where(Caisse = filter(TRUE),
//                             "Type Caisse" = filter(C),
//                             Chrono = filter(' '),
//                             "Validé Caisse" = const(true));
//     ApplicationArea = all;
//     Caption = 'Liste Avance/Pret Caisse';
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
//                 field("Montant Avance/Pret"; REC."Montant Avance/Pret")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Style = Strong;
//                     StyleExpr = true;
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
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Intégrer en Comptabilité")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Intégrer en Comptabilité';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     NumLignie := 10000;
//                     RecPaymentHeader.Reset;
//                     if RecPaymentHeader.Get(CodeBordPaiemt) then;
//                     // VERIFICATION LIGNIE CAISSE SELECTIONNER
//                     RecPaymentLineSelect.Reset;
//                     RecPaymentLineSelect.SetRange("Inserer Au Brouillard", true);
//                     //IF RecPaymentLineSelect.COUNT <>1 THEN ERROR(TEXT01);
//                     if RecPaymentLineSelect.FindFirst then
//                         repeat
//                             // INSERTION AU NIVEAU DE BORDEREAUX
//                             RecPaymentLineDest.Init;
//                             RecPaymentLineDest.Validate("No.", CodeBordPaiemt);
//                             RecPaymentLineDest."Line No." := NumLignie;
//                             RecPaymentLineDest.Validate("Payment Class", RecPaymentHeader."Payment Class");
//                             RecPaymentLineDest.Validate("Status No.", RecPaymentHeader."Status No.");
//                             RecPaymentLineDest.Validate(RecPaymentLineDest."Type de compte", RecPaymentLineDest."type de compte"::"G/L Account");
//                             RecPaymentLineDest.Validate("Due Date", RecPaymentLineSelect."Due Date");
//                             if (SensType = '2') or (SensType = '3') then
//                                 RecPaymentLineDest.Validate("Credit Amount", Abs(RecPaymentLineSelect.Amount))
//                             else
//                                 RecPaymentLineDest.Validate("Debit Amount", Abs(RecPaymentLineSelect.Amount));
//                             RecPaymentLineDest.Salarié := RecPaymentLineSelect.Benificiaire;
//                             if not RecPaymentLineDest.Modify then RecPaymentLineDest.Insert;
//                             NumLignie += 100;
//                             // MISE A JOUR LIGNIE CAISSE SELECTIONNER
//                             RecPaymentLineSelect.Chrono := CodeBordPaiemt;
//                             RecPaymentLineSelect."Inserer Au Brouillard" := false;
//                             RecPaymentLineSelect.Modify;
//                         until RecPaymentLineSelect.Next = 0;
//                     // MISE A JOUR DATE COMPTABILISATION BORDERAU DE PAIEMENT
//                     RecPaymentHeader."Posting Date" := RecPaymentLineDest."Due Date";
//                     RecPaymentHeader."Document Date" := RecPaymentLineDest."Due Date";
//                     RecPaymentHeader.Modify;

//                     CurrPage.Close;
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         GetParametres(CodeBordPaiemt, SensType);
//         REC.FilterGroup(2);
//         REC.SetRange("Code Opération", SensType);
//         REC.FilterGroup(0);
//     end;

//     var
//         CodeBordPaiemt: Code[20];
//         SensType: Text[30];
//         TEXT01: label 'Erreur !!! Vous devez selectionner une seule lignie !!!';
//         RecPaymentHeader: Record "Payment Header";
//         RecPaymentLineDest: Record "Payment Line";
//         RecPaymentLineSelect: Record "Payment Line";
//         NumLignie: Integer;


//     procedure GetParametres(ParmCodeDoc: Code[20]; ParmType: Text[30])
//     begin
//         CodeBordPaiemt := ParmCodeDoc;
//         SensType := ParmType;
//     end;
// }

