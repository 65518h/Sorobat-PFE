//GL3900 
// Page 72140 "Liste opertion btp"
// {
//     //GL2024  ID dans Nav 2009 : "39002140"
//     PageType = ListPart;
//     SourceTable = "Operation btp";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field(operation; Rec.operation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("durée prévue"; Rec."durée prévue")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "durée prévueEditable";
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInit()
//     begin
//         "durée prévueEditable" := true;
//     end;

//     var
//         [InDataSet]
//         "durée prévueEditable": Boolean;


//     procedure planned()
//     begin
//         "durée prévueEditable" := true;
//     end;


//     procedure lanced()
//     begin
//         "durée prévueEditable" := false;
//     end;
// }

