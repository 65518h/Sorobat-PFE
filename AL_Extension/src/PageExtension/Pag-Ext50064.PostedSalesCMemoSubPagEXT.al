PageExtension 50064 "Posted Sales C.Memo Sub_PagEXT" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addafter("Item Reference No.")
        {
            field(Marker; rec.Marker)
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Appl.-to Item Entry")
        {
            field("Work Type Code"; rec."Work Type Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }
}

