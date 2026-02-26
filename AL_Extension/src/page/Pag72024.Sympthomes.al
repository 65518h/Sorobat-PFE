//GL3900 
// page 72024 Sympthomes
// {
//     //GL2024  ID dans Nav 2009 : "39002024"
//     Caption = 'Symptoms list';
//     Editable = false;
//     PageType = List;
//     SourceTable = "symptôme";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(cd_sympt; rec.cd_sympt)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Libellé; rec.Libellé)
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
//             group(Symptom)
//             {
//                 Caption = 'Symptom';
//                 action(Card)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Card';
//                     Image = EditLines;
//                     RunObject = page "Fiche sympthome";
//                     RunPageLink = cd_sympt = FIELD(cd_sympt);
//                     ShortCutKey = 'Maj+F5';
//                 }
//                 separator(separator100)
//                 {
//                 }
//                 action("Finished WO ")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Finished WO ';
//                     RunObject = Page "Liste OT";
//                     RunPageLink = cd_symptom = FIELD(cd_sympt),
//                                   status = CONST(Terminé);
//                 }
//             }
//         }
//     }

//     var
//         box: Record Equipement;
// }

