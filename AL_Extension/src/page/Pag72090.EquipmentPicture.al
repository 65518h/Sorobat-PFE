//GL3900 
// Page 72090 "Equipment Picture"
// {
//     //GL2024  ID dans Nav 2009 : "39002090"
//     Caption = 'Equipment Picture';
//     PageType = Card;
//     SourceTable = Equipement;
//     ApplicationArea = all;
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             field(Picture; Rec.Picture)
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("&Picture")
//             {
//                 Caption = '&Picture';
//                 action(Import)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Import';
//                     Ellipsis = true;

//                     trigger OnAction()
//                     begin

//                         // GL2024   PictureExists := Picture.Hasvalue;
//                         /*   // GL2024  if Picture.Import('*.BMP', true) = '' then
//                                exit;*/

//                         if PictureExists then
//                             if not Confirm(Text001, false, Rec.TableCaption, Rec.cd_box) then
//                                 exit;
//                         CurrPage.SaveRecord;
//                     end;
//                 }
//                 action(Delete)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Delete';

//                     trigger OnAction()
//                     begin

//                         /* // GL2024 if Picture.Hasvalue then



//                             if Confirm(Text002, false, Rec.TableCaption, Rec.cd_box) then begin
//                                 Clear(Rec.Picture);
//                                 CurrPage.SaveRecord;
//                             end;*/
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         Text001: label 'Do you want to replace the existing picture of %1 %2?';
//         Text002: label 'Do you want to delete the picture of %1 %2?';
//         PictureExists: Boolean;
// }

