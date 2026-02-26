// Page 50106 "Regroupement Article"
// {
//     PageType = List;
//     SourceTable = "Regroupent Article";
//     ApplicationArea = all;
//     UsageCategory = Lists;
//     Caption = 'Regroupement Article';

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("N° Document"; REC."N° Document")
//                 {
//                     ApplicationArea = all;
//                     Enabled = false;
//                     Visible = false;
//                 }
//                 field(Article; REC.Article)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Designation; REC.Designation)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Nombre; REC.Nombre)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Quantité"; REC.Quantité)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(PU; REC.PU)
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("MAJ PU")
//             {
//                 ApplicationArea = all;
//                 Caption = 'MAJ PU';
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     if not Confirm(Text001) then exit;
//                     RegroupentArticle.Copy(Rec);
//                     if RegroupentArticle.FindFirst then
//                         repeat
//                             SalesLine.SetRange("Document No.", RegroupentArticle."N° Document");
//                             SalesLine.SetRange("No.", RegroupentArticle.Article);
//                             if SalesLine.FindFirst then
//                                 repeat
//                                     SalesLine.Validate("Unit Price", RegroupentArticle.PU);
//                                     SalesLine.Modify;
//                                 until SalesLine.Next = 0;
//                         until RegroupentArticle.Next = 0;
//                 end;
//             }
//         }
//     }

//     var
//         SalesLine: Record "Sales Line";
//         RegroupentArticle: Record "Regroupent Article";
//         Text001: label 'Confirmer Cette Action ?';
// }


