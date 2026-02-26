// Page 50216 "Validation Payement STC"
// {
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "STC Salaries";
//     SourceTableView = where(Status = const(Cloturé),
//                             Payer = const(false));
//     ApplicationArea = all;
//     Caption = 'Validation Payement STC';
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
//                 }
//                 field("Net A Payer"; REC."Net A Payer")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Payer; REC.Payer)
//                 {
//                     ApplicationArea = all;

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

//     local procedure PayerOnAfterValidate()
//     begin
//         GetSomme;
//         CurrPage.Update;
//     end;
// }

