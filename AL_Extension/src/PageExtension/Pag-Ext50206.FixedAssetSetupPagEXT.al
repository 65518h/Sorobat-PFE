PageExtension 50206 "Fixed Asset Setup_PagEXT" extends "Fixed Asset Setup"

{


    layout
    {
        addafter("Automatic Insurance Posting")
        {
            field("Activate Duplication List"; Rec."Activate Duplication List")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
}
