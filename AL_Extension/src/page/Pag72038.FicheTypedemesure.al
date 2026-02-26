//GL3900 
// page 72038 "Fiche Type de mesure"
// {
//     //GL2024  ID dans Nav 2009 : "39002038"
//     Caption = 'Measure type card';
//     PageType = Card;
//     SourceTable = "Type mesure";
//     ApplicationArea = all;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(cd_mesure_type; rec.cd_mesure_type)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Code';
//                 }
//                 field(Libellé; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(typ_val; rec.typ_val)
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
//                 field(cost_typ; rec.cost_typ)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(comment; rec.comment)
//                 {
//                     Visible = false;
//                 }
//                 field(max_val; rec.max_val)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(unit_pr; rec.unit_pr)
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
//                 separator(separator100)
//                 {
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

