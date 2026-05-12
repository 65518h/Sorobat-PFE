//GL3900 
// Page 72092 "Form shelter"
// {
//     //GL2024  ID dans Nav 2009 : "39002092"
//     Caption = 'Allocation';
//     PageType = Card;
//     SourceTable = shelter;
//     ApplicationArea = all;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 Caption = 'General';
//                 field(cd_box; Rec.cd_box)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(cd_register_link; Rec.cd_register_link)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(dttm_link_begin; Rec.dttm_link_begin)
//                 {
//                     ApplicationArea = Basic;
//                 }
//                 field(dttm_link_end; Rec.dttm_link_end)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group(Allocation)
//             {
//                 Caption = 'Allocation';
//                 separator(Action1000000012)
//                 {
//                 }
//                 action(Equipment)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Equipment';
//                     RunObject = page "Caisse Chantier";
//                 }
//                 action(Register)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Register';
//                     Image = Confirm;
//                     Promoted = true;
//                     PromotedCategory = Process;
//                     RunObject = page "Fiche Matricule";
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         Rec.Reset;
//     end;
// }

