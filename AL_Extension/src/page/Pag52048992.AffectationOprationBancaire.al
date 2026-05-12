// page 52048992 "Affectation Opération Bancaire"
// {
//     //GL2024  ID dans Nav 2009 : "39001520"
//     Caption = 'Affectation Opération Bancaire';
//     DelayedInsert = true;
//     PageType = List;
//     SourceTable = "Affectation Opération Bancaire";
//     ApplicationArea = all;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1000000000)
//             {
//                 ShowCaption = false;
//                 field("Code"; Rec.Code)
//                 {
//                     ApplicationArea = Basic;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     trigger OnOpenPage()
//     begin
//         CurrPage.Editable(not CurrPage.LookupMode);
//     end;

//     var
//         //GL2024  FrmPersonnelFormation: page 52048993;
//         RecGEmployee: Record Employee;
//         IntGAn: Integer;
//         Text001: label 'Voulez-vous lancer cette formation?';
// }

