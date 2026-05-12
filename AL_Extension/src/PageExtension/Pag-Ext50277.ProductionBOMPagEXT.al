PageExtension 50277 "Production BOM_PagEXT" extends "Production BOM"
{

    layout
    {
        addafter("Last Date Modified")
        {
            field(Centrale; Rec.Centrale)
            {
                ApplicationArea = all;
            }
            field("Article Lié"; Rec."Article Lié")
            {
                ApplicationArea = all;
            }
            field("Type Production"; Rec."Type Production")
            {
                ApplicationArea = all;
            }
            field(Stockable; Rec.Stockable)
            {
                ApplicationArea = all;
            }
        }
    }
}

