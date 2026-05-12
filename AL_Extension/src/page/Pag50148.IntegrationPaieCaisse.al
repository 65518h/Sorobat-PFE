// Page 50148 "Integration Paie Caisse"
// {
//     PageType = Card;
//     SourceTable = "Rec. Salary Lines";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     Caption = 'Integration Paie Caisse';
//     layout
//     {
//         area(content)
//         {
//             field(NumBorderau; NumBorderau)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Num Bordereau';
//                 TableRelation = "Payment Header"."No.";

//                 trigger OnValidate()
//                 begin
//                     if RecPaymentHeader.Get(NumBorderau) then;
//                     if RecPaymentHeader.Affectation = '' then
//                         Error(Text001)
//                     else
//                         CodeAffectation := RecPaymentHeader.Affectation;
//                 end;
//             }
//             field(CodeAffectation; CodeAffectation)
//             {
//                 Caption = 'Affectation';
//                 ApplicationArea = all;
//                 Editable = false;
//             }
//             field(NumPaie; NumPaie)
//             {
//                 Caption = 'N° Paie';
//                 ApplicationArea = all;
//                 TableRelation = "Rec. Salary Headers"."No.";
//             }
//             field(TypePaie; TypePaie)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Rappel';
//             }
//             label(Control1000000005)
//             {
//                 ApplicationArea = all;
//                 //CaptionClass = Text19068917;
//             }
//             label(Control1000000003)
//             {
//                 ApplicationArea = all;
//                 //CaptionClass = Text19058393;
//             }
//             label(Control1000000002)
//             {
//                 ApplicationArea = all;
//                 //CaptionClass = Text19066581;
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Intégrer")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Intégrer';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if NumPaie = '' then
//                         Error(Text002);

//                     RecDetailPaieCaisse.Reset;
//                     RecSalaryLines.Reset;
//                     RecSalaryLines.SetRange("No.", NumPaie);
//                     RecSalaryLines.SetRange(Affectation, CodeAffectation);
//                     if not TypePaie then
//                         RecSalaryLines.SetRange("Code Mode Réglement", RecSalaryLines."code mode réglement"::Espèce);
//                     if RecSalaryLines.FindFirst then
//                         repeat
//                             RecDetailPaieCaisse.Code := 'P1';
//                             RecDetailPaieCaisse.Matricule := RecSalaryLines.Employee;
//                             RecDetailPaieCaisse.Journee := RecPaymentHeader."Posting Date";
//                             RecDetailPaieCaisse.Affectation := RecSalaryLines.Affectation;
//                             RecDetailPaieCaisse.Nom := RecSalaryLines.Name;
//                             RecDetailPaieCaisse.Montant := RecSalaryLines."Net salary cashed";
//                             if not RecDetailPaieCaisse.Insert then RecDetailPaieCaisse.Modify;
//                         until RecSalaryLines.Next = 0;
//                     Message('Integration reuissite, Vérifier le bordereau N° %1', NumBorderau);
//                 end;
//             }
//         }
//     }

//     var
//         NumBorderau: Code[20];
//         CodeAffectation: Code[10];
//         NumPaie: Code[20];
//         RecPaymentHeader: Record "Payment Header";
//         Text001: label 'Vous devez preciser l''affectation dans le bordereau bancaire';
//         Text002: label 'Vous devez sélectionner le numero de Paie';
//         RecSalaryLines: Record "Rec. Salary Lines";
//         RecDetailPaieCaisse: Record "Detail Paie Caisse";
//         TypePaie: Boolean;
//         Text19066581: label 'Num Bordereau';
//         Text19058393: label 'Affectation';
//         Text19068917: label 'N° Paie';
// }

