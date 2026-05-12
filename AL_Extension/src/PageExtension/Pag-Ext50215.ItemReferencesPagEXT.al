PageExtension 50215 "Item References_PagEXT" extends "Item References"
//GL2024 table dans Nav2009 "Cross References" id 5723
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

