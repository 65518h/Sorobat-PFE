Page 50214 "Update Ligne Rend Camion Enr"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Ligne Rendement Vehicule Enr";
    ApplicationArea = all;
    Caption = 'Update Ligne Rend Camion Enr';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Journee; REC.Journee)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Vehicule; REC.Vehicule)
                {
                    ApplicationArea = all;
                }
                field("Nom Vehicule"; REC."Nom Vehicule")
                {
                    ApplicationArea = all;
                }
                field("Designation Affaire"; REC."Designation Affaire")
                {
                    ApplicationArea = all;
                }
                field(Provenance; REC.Provenance)
                {
                    ApplicationArea = all;
                }
                field(Destination; REC.Destination)
                {
                    ApplicationArea = all;
                }
                field("Distance Parcourus"; REC."Distance Parcourus")
                {
                    ApplicationArea = all;
                }
                field(Produit; REC.Produit)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nom Produit"; REC."Nom Produit")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

