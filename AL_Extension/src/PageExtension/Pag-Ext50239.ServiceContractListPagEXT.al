PageExtension 50239 "Service Contract List_PagEXT" extends "Service Contract List"
{
    layout
    {
        addafter("Customer No.")
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
    }
}

