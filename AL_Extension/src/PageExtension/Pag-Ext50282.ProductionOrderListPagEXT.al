PageExtension 50282 "Production Order List_PagEXT" extends "Production Order List"
{

    layout
    {
        addafter(Description)
        {
            field("N° BL"; Rec."N° BL")
            {
                ApplicationArea = all;
            }
            field(Centrale; Rec.Centrale)
            {
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field(Automate; Rec.Automate)
            {

                ApplicationArea = all;
            }
        }

    }
}

