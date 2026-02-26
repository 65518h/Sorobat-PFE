PageExtension 50247 "Posted Return Shipments_PagEXT" extends "Posted Return Shipments"
{

    layout
    {
        addafter("No.")
        {
            field("Return Order No."; Rec."Return Order No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}