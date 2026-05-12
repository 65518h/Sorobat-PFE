PageExtension 50172 "Marketing Setup_PagEXT" extends "Marketing Setup"

{

    layout
    {
        addafter("Attachment Storage Location")
        {
            field("Allow Attachment Modification"; Rec."Allow Attachment Modification")
            {
                ApplicationArea = all;
            }
        }
    }

}