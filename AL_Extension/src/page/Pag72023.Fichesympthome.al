//GL3900 
// page 72023 "Fiche sympthome"
// {
//     //GL2024  ID dans Nav 2009 : "39002023"
//     Caption = 'Symptom card';
//     PageType = Card;
//     SourceTable = "symptôme";
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';


//                 field(cd_sympt; rec.cd_sympt)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Symptôme';
//                 }
//                 field(Libellé; rec.Libellé)
//                 {
//                     ApplicationArea = all;
//                 }
//                 label("Concerned equipements")
//                 {
//                     ApplicationArea = all;
//                     CaptionClass = Text19027033;
//                 }
//                 part(Equip; "Equipement/Symthôme")
//                 {
//                     ApplicationArea = all;
//                     SubPageLink = cd_sympt = FIELD(cd_sympt);
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

//                 action(Equipment)
//                 {
//                     Caption = 'Equipment';
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     begin
//                         box.RESET;
//                         CurrPage.Equip.page.GETRECORD(box);
//                         IF box.cd_box <> '' THEN
//                             PAGE.RUN(39002010, box)
//                         ELSE
//                             MESSAGE(text001);
//                     end;
//                 }
//                 action("Finished WO ")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Finished WO ';
//                     RunObject = Page "Liste OT";
//                     RunPageLink = cd_symptom = FIELD(cd_sympt), status = CONST(Terminé);
//                 }
//             }
//         }
//     }

//     var
//         box: Record Equipement;
//         text001: Label 'No seleted equipment';
//         Text19027033: Label 'Concerned equipements';
// }

