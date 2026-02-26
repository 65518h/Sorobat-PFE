// Page 50051 "Décompte Monnaies"
// {
//     Editable = true;
//     PageType = Card;
//     SourceTable = "Decomptes Des Monnaies";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Décompte Monnaies';
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field("Journée"; rec.Journée)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("50 Dinars"; rec."50 Dinars")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("30 Dinards"; rec."30 Dinards")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("20 Dinards"; rec."20 Dinards")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("10 Dinards"; rec."10 Dinards")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("5 Dinards"; rec."5 Dinards")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("2 Dinards"; rec."2 Dinards")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("1 Dinards"; rec."1 Dinards")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("500 Millimes"; rec."500 Millimes")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("200 Millimes"; rec."200 Millimes")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("100 Millimes"; rec."100 Millimes")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("50 Millimes"; rec."50 Millimes")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("20 Millimes"; rec."20 Millimes")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("10 Millimes"; rec."10 Millimes")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("5 Millimes"; rec."5 Millimes")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Total Journée"; rec."Total Journée")
//                 {
//                     ApplicationArea = all;
//                     Style = Unfavorable;
//                     StyleExpr = true;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         "Amount_Débit": Decimal;
//         SFV_gr: Record "Suivie Facture Vente";
//         "Amount_Crédit": Decimal;
//         Amount_TVA: Decimal;
//         Amount_Ds: Decimal;
//         Amount_Int: Decimal;
//         "Amount_ResteaPayé": Decimal;
//         "Amount_Payé": Decimal;
// }

