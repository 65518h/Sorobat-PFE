// page 52049017 "Detail Paie Caisse"
// {
//     //GL2024  ID dans Nav 2009 : "39001545"
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Detail Paie Caisse";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Detail Paie Caisse';
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1120000)
//             {
//                 ShowCaption = false;
//                 Editable = true;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                     Visible = true;
//                 }
//                 field(Matricule; Rec.Matricule)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Nom; Rec.Nom)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("New Date"; Rec."New Date")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = true;
//                 }
//                 field(Journee; Rec.Journee)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Affectation; Rec.Affectation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Montant; Rec.Montant)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//             field(TotMontant; TotMontant)
//             {
//                 ApplicationArea = Basic;
//                 Caption = 'Total Montant';
//                 DecimalPlaces = 3 : 3;
//                 Editable = false;
//                 Style = Strong;
//                 StyleExpr = true;
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnAfterGetRecord()
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         OnAfterGetCurrRecord;
//     end;

//     trigger OnOpenPage()
//     begin
//         TotMontant := 0;
//     end;

//     var
//         TotMontant: Decimal;


//     procedure CalcAmout()
//     var
//         LDetailPaieCaisse: Record "Detail Paie Caisse";
//     begin
//         TotMontant := 0;
//         LDetailPaieCaisse.SetRange(Code, Rec.Code);
//         LDetailPaieCaisse.SetRange(Affectation, Rec.Affectation);
//         LDetailPaieCaisse.SetRange(Journee, Rec.Journee);
//         if LDetailPaieCaisse.FindFirst then
//             repeat
//                 TotMontant += LDetailPaieCaisse.Montant;
//             until LDetailPaieCaisse.Next = 0;
//     end;

//     local procedure OnAfterGetCurrRecord()
//     begin
//         xRec := Rec;
//         CalcAmout;
//     end;
// }

