// Page 50020 Emplacement
// {
//     PageType = list;
//     SourceTable = Emplacement;
//     Caption = 'Emplacement';
//     ApplicationArea = all;
//     UsageCategory = Lists;
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
//                 field(Magasin; rec.Magasin)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Détail Empl.")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Détail Empl.';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     ItemLedgerEntry.SetRange(Emplacement, rec.Code);
//                     ItemLedgerEntry.SetRange("Location Code", rec.Magasin);
//                     Report.RunModal(Report::"Article Par Emplacement", true, true, ItemLedgerEntry);
//                 end;
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         CurrPage.Editable(not CurrPage.LookupMode);
//     end;

//     var
//         ItemLedgerEntry: Record "Item Ledger Entry";
// }

