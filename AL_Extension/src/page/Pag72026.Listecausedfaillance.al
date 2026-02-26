//GL3900 
// page 72026 "Liste cause défaillance"
// {//GL2024  ID dans Nav 2009 : "39002026"
//     Caption = 'Failure causes list';
//     PageType = List;
//     SourceTable = "Cause défaillance";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(cd_fail_cause; rec.cd_fail_cause)
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
//             group("Failure Cause")
//             {
//                 Caption = 'Failure Cause';
//                 separator(separator100)
//                 {
//                 }
//                 action("Finished WO ")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Finished WO ';
//                     RunObject = Page "Liste OT";
//                     RunPageLink = cd_cause_defaillance = FIELD(cd_fail_cause);
//                 }
//             }
//         }
//     }
// }

