//GL3900 
// page 72039 "Liste types de mesures"
// { //GL2024  ID dans Nav 2009 : "39002039"
//     Caption = 'Measure types list';
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Type mesure";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(cd_mesure_type; rec.cd_mesure_type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Libellé; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_val; rec.typ_val)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cost_typ; rec.cost_typ)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(unit_pr; rec.unit_pr)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(measure_unit; rec.measure_unit)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(min_val; rec.min_val)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(max_val; rec.max_val)
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
//             group("Mesure type")
//             {
//                 Caption = 'Mesure type';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Fiche Type de mesure";
//                     RunPageLink = cd_mesure_type = FIELD(cd_mesure_type);
//                     ShortCutKey = 'Maj+F5';
//                 }

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(mtype),
//                                   "No." = FIELD(cd_mesure_type);
//                 }
//                 action("Measure point")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Measure point';
//                     RunObject = Page "Liste point mesure";
//                     RunPageLink = cd_measure_type = FIELD(cd_mesure_type);
//                 }
//             }
//         }
//     }
// }

