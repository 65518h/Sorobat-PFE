//GL3900 
// Page 72089 "Liste opertion bt"
// { //GL2024  ID dans Nav 2009 : "39002089"
//     DelayedInsert = true;
//     PageType = ListPart;
//     SourceTable = "Operation bt";
//     Caption = 'Liste opertion bt';
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;

//                 field(operation; Rec.operation)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("durée prévue"; Rec."durée prévue")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "durée prévueEditable";
//                 }
//                 field("durée réalisée"; Rec."durée réalisée")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = "durée réaliséeEditable";
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnInit()
//     begin
//         "durée réaliséeEditable" := true;
//         "durée prévueEditable" := true;
//     end;

//     trigger OnOpenPage()
//     begin
//         Rec.SetCurrentkey(Ordre);
//     end;

//     var
//         [InDataSet]
//         "durée prévueEditable": Boolean;
//         [InDataSet]
//         "durée réaliséeEditable": Boolean;


//     procedure planned()
//     begin
//         "durée prévueEditable" := true;
//         "durée réaliséeEditable" := false;
//     end;


//     procedure lanced()
//     begin
//         "durée prévueEditable" := false;
//         "durée réaliséeEditable" := true;
//     end;
// }

