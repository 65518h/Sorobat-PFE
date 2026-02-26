PageExtension 50290 "Finished Prod Ord Lines_PagEXT" extends "Finished Prod. Order Lines"
{
    layout
    {
        addafter("Description 2")
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
    var
        f: Page "Code Coverage";
}

