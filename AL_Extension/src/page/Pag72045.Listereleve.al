//GL3900 
// page 72045 "Liste releve"
// { //GL2024  ID dans Nav 2009 : "39002045"
//     Caption = 'Measure readings list';
//     Editable = false;
//     PageType = List;
//     SourceTable = "Relevé mesure";
//     SourceTableView = SORTING(cd_releve, cd_mesure_point)
//                       ORDER(Ascending);
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(cd_mesure_point; rec.cd_mesure_point)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dttm_releve; rec.dttm_releve)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(val_mesure; rec.val_mesure)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(unit; rec.unit)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(val_variation; rec.val_variation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Last; rec.Last)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Reading)
//             {
//                 Caption = 'Reading';
//                 /*GL2024  action(Card)
//                   {    ApplicationArea = all;
//                       Caption = 'Card';
//                       Image = EditLines;
//                       RunObject = Page 50662;
//                       RunPageLink = Field6 = FIELD(cd_releve);
//                       ShortCutKey = 'Maj+F5';
//                   }*/

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(relevé),
//                                   "No." = FIELD(cd_releve);
//                 }
//                 action("Measure point")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Measure point';
//                     RunObject = Page "Fiche point de mesure";
//                     RunPageLink = cd_measure_point = FIELD(cd_mesure_point);
//                 }
//             }
//         }
//     }
// }

