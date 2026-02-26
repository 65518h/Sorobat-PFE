PageExtension 50187 "Interaction Temp. Setup_PagEXT" extends "Interaction Template Setup"

{
    layout
    {
        addafter("Sales Finance Charge Memo")
        {
            field("Request Guarantee"; Rec."Request Guarantee")
            {
                ApplicationArea = all;
            }
            field("Due Guarantee"; Rec."Due Guarantee")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }

}