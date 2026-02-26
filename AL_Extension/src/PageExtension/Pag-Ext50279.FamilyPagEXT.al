PageExtension 50279 "Family_PagEXT" extends "Family"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Sans Consommation"; Rec."Sans Consommation")
            {
                ApplicationArea = all;
            }
            field("Heure Travail Par Jour"; Rec."Heure Travail Par Jour")
            {
                ApplicationArea = all;
            }
            field(Carriere; Rec.Carriere)
            {
                ApplicationArea = all;
            }
            field(Centrale; Rec.Centrale)
            {
                ApplicationArea = all;
            }
        }
    }
}

