Page 52049037 "Image Véhicule"
{//GL2024  ID dans Nav 2009 : "39004703"
    Caption = 'Item Picture';
    PageType = Card;
    SourceTable = "Véhicule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(Image; Rec.Image)
            {
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        area(navigation)
        {
            // GL2024 group("&Picture")
            // {
            //     Caption = '&Picture';
            //     action(Import)
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Import';
            //         Ellipsis = true;

            //         trigger OnAction()
            //         begin
            //             /*  GL2024   PictureExists := Image.Hasvalue;
            //                  if Image.Import('*.BMP', true) = '' then
            //                      exit;*/
            //             if PictureExists then
            //                 if not Confirm(Text001, false, Rec.TableCaption, rec."N° Vehicule") then
            //                     exit;
            //             CurrPage.SaveRecord;
            //         end;
            //     }
            //     action("E&xport")
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'E&xport';
            //         Ellipsis = true;

            //         trigger OnAction()
            //         begin
            //             /*  GL2024 if Image.Hasvalue then
            //                  Image.Export('*.BMP', true);*/
            //         end;
            //     }
            //     action(Delete)
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Delete';

            //         trigger OnAction()
            //         begin
            //             /* GL2024  if Image.Hasvalue then
            //                  if Confirm(Text002, false, Rec.TableCaption, REC."N° Vehicule") then begin
            //                      Clear(Rec.Image);
            //                      CurrPage.SaveRecord;
            //                  end;*/
            //         end;
            //     }
            // }
        }
    }

    var
        Text001: label 'Do you want to replace the existing picture of %1 %2?';
        Text002: label 'Do you want to delete the picture of %1 %2?';
        PictureExists: Boolean;
}

