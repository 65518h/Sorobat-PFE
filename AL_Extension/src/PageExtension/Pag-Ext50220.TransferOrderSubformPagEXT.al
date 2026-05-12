PageExtension 50220 "Transfer Order Subform_PagEXT" extends "Transfer Order Subform"

{
    layout
    {
        modify(Description)
        {
            Editable = false;
        }
        addfirst(Control1)
        {
            field("Filtre Article"; rec."Filtre Article")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Item No.")
        {
            field(Stock; rec.Stock)
            {
                ApplicationArea = all;
            }
            field("N° vehicule"; rec."N° vehicule")
            {
                ApplicationArea = all;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            // field("N° Materiel"; rec."N° Materiel")
            // {
            //     ApplicationArea = all;
            // }
            /*  field("Qty. to Ship2"; rec."Qty. to Ship")
              {
                  ApplicationArea = all;
              }
              field("Quantity Shipped2"; rec."Quantity Shipped")
              {
                  ApplicationArea = all;
              }*/
        }
    }

    actions
    {

    }
}