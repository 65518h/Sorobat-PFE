PageExtension 50232 "Service Order_PagEXT" extends "Service Order"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

