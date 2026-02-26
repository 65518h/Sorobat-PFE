PageExtension 50003 "Currencies_PagEXT" extends Currencies
{
    layout
    {
        addafter("Unit-Amount Rounding Precision")
        {
            field("Sales Unit-Amt Round. Prec."; rec."Sales Unit-Amt Round. Prec.")
            {
                ApplicationArea = all;
                Caption = 'Sales Unit-Amt Round. Prec.';
            }
        }


    }

}



