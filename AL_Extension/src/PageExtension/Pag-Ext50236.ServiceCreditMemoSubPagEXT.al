PageExtension 50236 "Service Credit Memo Sub_PagEXT" extends "Service Credit Memo Subform"
{
    layout
    {
        addafter("Service Item No.")
        {
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Job Task No."; rec."Job Task No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }
}

