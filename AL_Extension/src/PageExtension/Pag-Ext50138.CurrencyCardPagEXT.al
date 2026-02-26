PageExtension 50138 "Currency Card_PagEXT" extends "Currency Card"
{

    layout
    {
        addafter("VAT Rounding Type")
        {
            field("Sales Unit-Amt Round. Prec."; Rec."Sales Unit-Amt Round. Prec.")
            {
                ApplicationArea = all;
            }
        }
    }
}