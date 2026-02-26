PageExtension 50008 "Salespersons/Purchasers_PagEXT" extends "Salespersons/Purchasers"
{
    Editable = false;
    layout
    {
        addafter(Name)
        {
            field("Job Title"; rec."Job Title")
            {
                ApplicationArea = all;
                Caption = 'Job Title';

            }


        }


    }




}

