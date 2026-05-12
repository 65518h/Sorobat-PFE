PageExtension 50222 "Posted Transfer Receipt_PagEXT" extends "Posted Transfer Receipt"

{
    layout
    {
        addafter("Shipping Agent Service Code")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {

    }

}