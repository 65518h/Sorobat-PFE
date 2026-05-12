// Page 50233 "Integrer Payement STC à la cai"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "STC Salaries";
//     SourceTableView = where(Status = const(Cloturé),
//                             Payer = const(false));

//     ApplicationArea = all;
//     Caption = 'Integrer Payement STC à la cai';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code STC"; REC."Code STC")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Integrer à la caisse"; REC."Integrer à la caisse")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;

//                     trigger OnValidate()
//                     begin
//                         Integrer224lacaisseOnValidate;
//                         Integrer224lacaisseOnAfterVali;
//                     end;
//                 }
//                 field(Annee; REC.Annee)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Mois; REC.Mois)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Maticule; REC.Maticule)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Salarié"; REC.Salarié)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Description Qualification"; REC."Description Qualification")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Saisie"; REC."Date Saisie")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Date Comptabilisation"; REC."Date Comptabilisation")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Motif; REC.Motif)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Net A Payer"; REC."Net A Payer")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Payer; REC.Payer)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;

//                     trigger OnValidate()
//                     begin
//                         PayerOnAfterValidate;
//                     end;
//                 }
//             }
//             field(TotSTC; TotSTC)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Total';
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//                 Style = Unfavorable;
//                 StyleExpr = true;
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         GetSomme;
//     end;

//     var
//         STCSalaries: Record "STC Salaries";
//         TotSTC: Decimal;
//         NumCaisse: Code[20];
//         NumLigneCaisse: Integer;
//         RecPaymentLine: Record "Payment Line";
//         Text001: label 'Voulez Vous  Integrer l''avance à La Ligne Caisse ?';
//         FormLignePaiementCaisse: Page "Ligne Paiement Caisse";
//         Text002: label 'Integration Faite avec succée';


//     procedure GetSomme()
//     begin
//         TotSTC := 0;
//         STCSalaries.SetRange(Status, STCSalaries.Status::Cloturé);
//         STCSalaries.SetRange(Payer, false);
//         if STCSalaries.FindFirst then
//             repeat
//                 TotSTC += STCSalaries."Net A Payer";
//             until STCSalaries.Next = 0;
//     end;


//     procedure GetParametre(var codeCaisse: Code[20]; var NumLigne: Integer)
//     begin
//         NumCaisse := codeCaisse;
//         NumLigneCaisse := NumLigne;
//     end;

//     local procedure Integrer224lacaisseOnAfterVali()
//     begin
//         CurrPage.Close;
//     end;

//     local procedure Integrer224lacaisseOnValidate()
//     begin
//         if not Confirm(Text001, false) then begin
//             REC."Integrer à la caisse" := false;
//             REC.Modify;
//             exit;
//         end;
//         RecPaymentLine.Reset;
//         if RecPaymentLine.Get(NumCaisse, NumLigneCaisse) then begin
//             RecPaymentLine.Validate("Credit Amount", REC."Net A Payer");
//             RecPaymentLine.Validate("Type Origine", 1);
//             RecPaymentLine.Validate(Benificiaire, REC.Maticule);
//             RecPaymentLine.Libellé := RecPaymentLine.Libellé + ' ' + REC."Code STC";
//             RecPaymentLine.Modify;
//             REC.Payer := true;
//             REC.Modify;
//         end;
//     end;

//     local procedure PayerOnAfterValidate()
//     begin
//         GetSomme;
//         CurrPage.Update;
//     end;
// }

