PageExtension 50117 "Customer Bank Acc Card_PagEXT" extends "Customer Bank Account Card"
{

    layout
    {
        addafter("Bank Account No.")
        {
            field("Giro Account No."; Rec."Giro Account No.")
            {
                ApplicationArea = all;
            }
            field("Default Account"; Rec."Default Account")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {

    }

}
