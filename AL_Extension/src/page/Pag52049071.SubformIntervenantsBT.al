// Page 52049071 "Subform Intervenants BT"
// {//GL2024  ID dans Nav 2009 : "39004778"
//     PageType = ListPart;
//     SourceTable = "Intervenants BT";
//     ApplicationArea = All;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 field("Code Intervenant"; Rec."Code Intervenant")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Nom Intervenant"; Rec."Nom Intervenant")
//                 {
//                     ApplicationArea = Basic;
//                     Editable = false;
//                 }
//                 field("Date Intervention"; Rec."Date Intervention")
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Durée"; Rec.Durée)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field("Detaille Intervention"; Rec."Detaille Intervention")
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnNewRecord(BelowxRec: Boolean)
//     begin
//         RecIntervenantsBT.SetRange("Code BT", Rec."Code BT");
//         if RecIntervenantsBT.FindLast then begin
//             Rec."N° Ligne" := RecIntervenantsBT."N° Ligne" + 10000;
//         end
//         else
//             Rec."N° Ligne" := 10000;
//     end;

//     var
//         RecIntervenantsBT: Record "Intervenants BT";
// }

