PageExtension 50241 "Lot No. Inform Card_PagEXT" extends "Lot No. Information Card"
{
    layout
    {
        addafter(Blocked)
        {
            field("Purchaser Lot No."; Rec."Purchaser Lot No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(Comment)
        {
            action(Folder)
            {
                ApplicationArea = all;
                Caption = 'Folder';
                trigger OnAction()
                VAR
                    lFolderManagement: Codeunit "Folder management";
                BEGIN
                    //+REF+FOLDER
                    lFolderManagement.Lot(Rec);
                    //+REF+FOLDER//

                end;
            }
        }
        addafter(Comment_Promoted)
        {
            actionref(Folder1; Folder)
            {

            }
        }
    }

}

