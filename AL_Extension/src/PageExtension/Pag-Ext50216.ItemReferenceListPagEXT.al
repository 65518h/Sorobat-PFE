PageExtension 50216 "Item Reference List_PagEXT" extends "Item Reference List"
//GL2024 table dans Nav2009 "Cross Reference List" id 5724
{
    layout
    {
        addafter("Item No.")
        {
            field("Item Description"; rec."Item Description")
            {
                ApplicationArea = all;
            }
        }
    }


}

