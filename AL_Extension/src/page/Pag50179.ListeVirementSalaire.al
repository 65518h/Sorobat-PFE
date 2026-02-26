// Page 50179 "Liste Virement Salaire"
// {
//     Editable = true;
//     InsertAllowed = false;
//     PageType = List;
//     UsageCategory = Lists;
//     SourceTable = "Entete Lot Paie";
//     SourceTableView = sorting(Code)
//                       where(Status = filter(Validée),
//                             "Code Bordereau" = filter(' '),
//                             Type = filter("Ordre Virement"));
//     ApplicationArea = all;
//     Caption = 'Liste Virement Salaire';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code"; REC.Code)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Inserer en Comptabilité"; REC."Inserer en Comptabilité")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Selectionner';
//                 }
//                 field("Code Banque"; REC."Code Banque")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Nom Banque"; REC."Nom Banque")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Mantant Net"; REC."Mantant Net")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Mois; REC.Mois)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Annee; REC.Annee)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Code Affectation"; REC."Code Affectation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Description Affectation"; REC."Description Affectation")
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

//                     RecPaymentHeader.Reset;
//                     if RecPaymentHeader.Get(CodeDoc) then;

//                     RecEnteteLotPaieSelect.SetRange("Inserer en Comptabilité", true);
//                     if RecEnteteLotPaieSelect.Count <> 1 then Error(TEXT01);
//                     if RecEnteteLotPaieSelect.FindFirst then begin
//                         RecEnteteLotPaieSelect.CalcFields("Mantant Net");
//                         if REC.Mois <> REC.Mois::Rappel then
//                             DateEcheance := CalcDate('+FM', Dmy2date(1, RecEnteteLotPaieSelect.Mois, RecEnteteLotPaieSelect.Annee));
//                         // DateEcheance:=CALCDATE('+FM',DMY2DATE(1,7,RecEnteteLotPaieSelect.Annee));
//                         // MISE A JOUR DATE COMPTABILISATION BORDERAU DE PAIEMENT
//                         RecPaymentHeader."Posting Date" := RecEnteteLotPaieSelect."Date Creation";
//                         RecPaymentHeader."Document Date" := RecEnteteLotPaieSelect."Date Creation";
//                         RecPaymentHeader.Validate("Account No.", RecEnteteLotPaieSelect."Code Banque");
//                         RecPaymentHeader.Modify;
//                         // INSERTION AU NIVEAU DE BORDEREAUX
//                         RecPaymentLineDest.Init;
//                         RecPaymentLineDest.Validate("No.", CodeDoc);
//                         RecPaymentLineDest."Line No." := 10000;
//                         RecPaymentLineDest.Validate("Payment Class", RecPaymentHeader."Payment Class");
//                         RecPaymentLineDest.Validate("Status No.", RecPaymentHeader."Status No.");
//                         RecPaymentLineDest.Validate(RecPaymentLineDest."Type de compte", RecPaymentLineDest."type de compte"::"G/L Account");
//                         if REC.Mois = REC.Mois::Rappel then RecPaymentLineDest.Validate("Code compte", '42500000');
//                         RecPaymentLineDest.Validate("Due Date", DateEcheance);
//                         RecPaymentLineDest.Validate("Credit Amount", Abs(RecEnteteLotPaieSelect."Mantant Net"));
//                         RecPaymentLineDest.Libellé := 'VIREMENT SALAIRE ' + Format(RecEnteteLotPaieSelect.Mois) + ' ' + Format(RecEnteteLotPaieSelect.Annee);
//                         if not RecPaymentLineDest.Modify then RecPaymentLineDest.Insert;

//                         RecEnteteLotPaieSelect."Code Bordereau" := CodeDoc;
//                         RecEnteteLotPaieSelect."Inserer en Comptabilité" := false;
//                         RecEnteteLotPaieSelect.Modify;
//                         CurrPage.Close;
//                     end;
//                 end;
//             }
//         }
//     }

//     var
//         CodeDoc: Code[20];
//         RecPaymentHeader: Record "Payment Header";
//         RecEnteteLotPaieSelect: Record "Entete Lot Paie";
//         TEXT01: label 'Erreur !!! Vous devez selectionner une seule lignie !!!';
//         RecPaymentLineDest: Record "Payment Line";
//         DateEcheance: Date;


//     procedure GetParametres(ParmCodeDoc: Code[20])
//     begin
//         CodeDoc := ParmCodeDoc;
//     end;
// }

