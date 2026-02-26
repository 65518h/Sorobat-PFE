PageExtension 50234 "Service Invoice Subform_PagEXT" extends "Service Invoice Subform"
{
    layout
    {
        addafter("Appl.-to Service Entry")
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

