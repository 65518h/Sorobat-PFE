//GL3900 
// page 72041 "Liste point mesure"
// { //GL2024  ID dans Nav 2009 : "39002041"
//     Caption = 'Measure points list';
//     Editable = false;
//     PageType = Card;
//     SourceTable = "Point mesure";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(cd_measure_point; rec.cd_measure_point)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_measure_type; rec.cd_measure_type)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Libellé type de mesure"; rec."Libellé type de mesure")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_box; rec.cd_box)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(cd_register; rec.cd_register)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(measure_unit; rec.measure_unit)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(bo_real_cmpt; rec.bo_real_cmpt)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(val_last_read; rec.val_last_read)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("val_period-read"; rec."val_period-read")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(dttm_last_read; rec.dttm_last_read)
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
//             group("Measure point")
//             {
//                 Caption = 'Measure point';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = Page "Fiche point de mesure";
//                     RunPageLink = cd_measure_point = FIELD(cd_measure_point);
//                     ShortCutKey = 'Maj+F5';
//                 }

//                 action(Comment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Comment';
//                     RunObject = Page "Comment Sheet gmao";
//                     RunPageLink = "Table Name" = CONST(pt_mesure),
//                                   "No." = FIELD(cd_measure_point);
//                 }
//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                     RunPageLink = "No." = FIELD(cd_box);
//                 }
//                 action(Register)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Register';
//                     Image = Confirm;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = page "Fiche Matricule";
//                     RunPageLink = "code matricule" = FIELD(cd_register);
//                 }
//                 action("Measure type")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Measure type';
//                     RunObject = Page "Fiche Type de mesure";
//                     RunPageLink = cd_mesure_type = FIELD(cd_measure_type);
//                 }
//             }
//         }
//     }
// }

