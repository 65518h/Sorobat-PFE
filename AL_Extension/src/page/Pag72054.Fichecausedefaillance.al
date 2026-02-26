//GL3900 
// page 72054 "Fiche cause defaillance"
// {//GL2024  ID dans Nav 2009 : "39002054"
//     Caption = 'Failure cause card';
//     PageType = Card;
//     SourceTable = "Cause défaillance";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group("Général")
//             {
//                 Caption = 'Général';

//                 field(cd_fail_cause; rec.cd_fail_cause)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Libellé; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 part(EQUIP; "Equipement/cause defaillance")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = "code cause defaillance" = FIELD(cd_fail_cause);
//                 }
//                 label("Possible symptoms list")
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19047945;
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

//                 action(Equipment)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Equipment';

//                     trigger OnAction()
//                     begin
//                         BOX.RESET;
//                         CurrPage.EQUIP.page.GETRECORD(BOX);
//                         IF BOX.cd_box <> '' THEN
//                             PAGE.RUN(39002010, BOX)
//                         ELSE
//                             MESSAGE(text001);
//                     end;
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

//     var
//         BOX: Record Equipement;
//         text001: Label 'No seleted equipment';
//         Text19047945: Label 'Possible symptoms list';
// }

