PageExtension 50286 "Released Prod Ord Lines_PagEXT" extends "Released Prod. Order Lines"
{
    layout
    {
        addafter("Ending Date")
        {
            field("Largeur (M)"; rec."Largeur (M)")
            {
                ApplicationArea = all;
            }
            field("Longueur (M)"; rec."Longueur (M)")
            {
                ApplicationArea = all;
            }
        }
    }
    //GL2024
    procedure ItemAvailability2(AvailabilityType: Option)
    begin
        ItemAvailFormsMgt.ShowItemAvailFromProdOrderLine(Rec, AvailabilityType);
    end;

    var

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
}

