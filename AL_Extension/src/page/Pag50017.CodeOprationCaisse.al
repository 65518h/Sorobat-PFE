// Page 50017 "Code Opération Caisse"
// {
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Code Opération Caisse";
//     Caption = 'Code Opération Caisse';
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     // CardPageId=50016;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Code"; rec.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Alimentation Caisse"; rec."Alimentation Caisse")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Avance; rec.Avance)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prêt"; rec.Prêt)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Paie; rec.Paie)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Provisoire; rec.Provisoire)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Journal; rec.Journal)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Brouillard; rec.Brouillard)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Sens; rec.Sens)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         CurrPage.Editable(not CurrPage.LookupMode);
//     end;
// }

