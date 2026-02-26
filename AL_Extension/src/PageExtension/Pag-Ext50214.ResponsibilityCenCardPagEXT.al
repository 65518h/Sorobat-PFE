PageExtension 50214 "Responsibility Cen Card_PagEXT" extends "Responsibility Center Card"

{


    layout
    {
        addafter("Location Code")
        {
            field("Picture No."; Rec."Picture No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
}