PageExtension 50119 "Payment Methods_PagEXT" extends "Payment Methods"
{
    layout
    {
        addafter("Pmt. Export Line Definition")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = all;
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = all;
            }
            field("Bill Type"; Rec."Bill Type")
            {
                ApplicationArea = all;
            }
        }

    }


    actions
    {

    }

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}


