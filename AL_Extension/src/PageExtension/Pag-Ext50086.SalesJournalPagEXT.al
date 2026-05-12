PageExtension 50086 "Sales Journal_PagEXT" extends "Sales Journal"
{
    layout
    {
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Document No.")
        {
            Visible = true;
            Editable = false;
        }

        addafter("Currency Code")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

}

