PageExtension 50205 "Fixed Asset List_PagEXT" extends "Fixed Asset List"

{


    layout
    {
        addbefore("No.")
        {
            field("Ancien Code"; Rec."Ancien Code")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = all;
            }
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = all;
            }
            field("Groupe Immo"; Rec."Groupe Immo")
            {
                ApplicationArea = all;
            }
            field("Date Acquisition"; Rec."Date Acquisition")
            {
                ApplicationArea = all;
            }
            field("Materiel Exploiatation"; Rec."Materiel Exploiatation")
            {
                ApplicationArea = all;
            }
        }

        addafter("Budgeted Asset")
        {
            field("N° Facture Fournisseur"; Rec."N° Facture Fournisseur")
            {
                Editable = FALSE;
                ApplicationArea = all;
            }
            field("Date Comptabilisation"; Rec."Date Comptabilisation")
            {
                Editable = FALSE;
                ApplicationArea = all;
            }
            field("N° Facture"; Rec."N° Facture")
            {
                Editable = FALSE;
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
}
