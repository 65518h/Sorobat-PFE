PageExtension 50152 "IC Partner Card_PagEXT" extends "IC Partner Card"
{

    layout
    {

        addafter("Cost Distribution in LCY")
        {
            field("Resource No."; Rec."Resource No.")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {

    }


}