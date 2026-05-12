page 52048884 "Sub Overcharge Hour cost"
{
    //GL2024  ID dans Nav 2009 : "39001405"
    PageType = CardPart;
    SourceTable = "Bon Reglement";
    Caption = 'Sub Overcharge Hour cost';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Details';
                field(Annee; Rec.Annee)
                {
                    ApplicationArea = all;
                }
                field(Mois; Rec.Mois)
                {
                    ApplicationArea = all;
                }
                field(Matricule; Rec.Matricule)
                {
                    ApplicationArea = all;
                }
                field(Categorie; Rec.Categorie)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Annee := xRec.Annee + 1
    end;
}

