PageExtension 50124 "No. Series Lines_PagEXT" extends "No. Series Lines"
{

    layout
    {
        addbefore("Series Code")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Visible = FALSE;
                Editable = FALSE;
            }
        }

        addafter("Series Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;

            }
        }


    }


    actions
    {

    }




}

