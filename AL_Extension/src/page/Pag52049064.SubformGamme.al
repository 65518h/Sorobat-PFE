// Page 52049064 "Subform Gamme"
// {//GL2024  ID dans Nav 2009 : "39004768"
//     DelayedInsert = true;
//     PageType = ListPart;
//     SourceTable = Gamme;
//     SourceTableView = sorting("Code sous Famille Equipement", Fréquence);
//     ApplicationArea = All;


//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 Editable = false;
//                 field("Code Gamme"; Rec."Code Gamme")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Desgniation; Rec.Desgniation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Fréquence"; Rec.Fréquence)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     var
//         RecGamme: Record Gamme;
// }

