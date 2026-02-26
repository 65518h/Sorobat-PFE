//GL3900 
// Page 72119 "Coûts divers BT"
// {
//     //GL2024  ID dans Nav 2009 : "39002119"
//     PageType = List;
//     SourceTable = "Coûts divers BT";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Coût"; Rec.Coût)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Libellé coût"; Rec."Libellé coût")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("coût réalisé"; Rec."coût réalisé")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "coût réaliséEditable";
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInit()
//     begin
//         "coût réaliséEditable" := true;
//     end;

//     var
//         [InDataSet]
//         "coût réaliséEditable": Boolean;


//     procedure Planned()
//     begin
//         //GL2024
//         //CurrPage.Coût.EDITABLE := TRUE;
//         "coût réaliséEditable" := false;
//     end;


//     procedure Lanced()
//     begin
//         //GL2024
//         //CurrPage.Coût.EDITABLE := FALSE;
//         "coût réaliséEditable" := true;
//     end;
// }

