// Page 50101 "Detail Contrat Leasing"
// {
//     DelayedInsert = true;
//     PageType = ListPart;
//     SourceTable = "Detail Contrat";
//     ApplicationArea = All;
//     Caption = 'Detail Contrat Leasing';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(Description; REC.Description)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Fournisseurs; REC.Fournisseurs)
//                 {
//                     ApplicationArea = all;

//                     trigger OnValidate()
//                     begin
//                         FournisseursOnAfterValidate;
//                     end;
//                 }
//                 field("Nom Fournisseurs"; REC."Nom Fournisseurs")
//                 {
//                     ApplicationArea = all;
//                     Style = Strong;
//                     StyleExpr = true;
//                 }
//                 field(Nombre; REC.Nombre)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Prix TTC"; REC."Prix TTC")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//     }

//     local procedure FournisseursOnAfterValidate()
//     begin
//         REC.CalcFields("Nom Fournisseurs");
//     end;
// }

