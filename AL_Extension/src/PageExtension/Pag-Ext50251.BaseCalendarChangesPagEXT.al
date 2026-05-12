PageExtension 50251 "Base Calendar Changes_PagEXT" extends "Base Calendar Changes"
{
    layout
    {
        addafter(Date)
        {
            field("To Date"; Rec."To Date")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {


    }

}
