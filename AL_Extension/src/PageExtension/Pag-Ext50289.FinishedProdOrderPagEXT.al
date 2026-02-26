PageExtension 50289 "Finished Prod Order_PagEXT" extends "Finished Production Order"
{
    //GL2024     DeleteAllowed=false;
    layout
    {
        modify(General)
        {
            Editable = false;
        }
        modify(Schedule)
        {
            Editable = false;
        }
        modify(Posting)
        {
            Editable = false;
        }

        addafter("Source No.")
        {
            field(Centrale; Rec.Centrale)
            {
                ApplicationArea = all;
            }
            field("N° BL"; Rec."N° BL")
            {
                ApplicationArea = all;
            }
            field(Destination; Rec.Destination)
            {
                ApplicationArea = all;
            }
        }
        addafter("Last Date Modified")
        {
            field(Camion; Rec.Camion)
            {
                ApplicationArea = all;
            }
            field(Chauffeur; Rec.Chauffeur)
            {
                ApplicationArea = all;
            }
            field(Service; Rec.Service)
            {
                ApplicationArea = all;
            }
            field("Nombre Heure Travail"; Rec."Nombre Heure Travail")
            {
                ApplicationArea = all;
            }
            field("Nombre Voyage"; Rec."Nombre Voyage")
            {
                ApplicationArea = all;
            }

            field(Observation; Rec.Observation)
            {
                ApplicationArea = all;
            }
        }
    }
}
