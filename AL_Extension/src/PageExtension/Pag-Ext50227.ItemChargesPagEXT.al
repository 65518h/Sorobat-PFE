PageExtension 50227 "Item Charges_PagEXT" extends "Item Charges"

{
    layout
    {
        addafter(Description)
        {
            field("Affect Frais Annexe"; Rec."Affect Frais Annexe")
            {
                ApplicationArea = all;
            }
            field("Type Frais"; Rec."Type Frais")
            {
                ApplicationArea = all;
            }
            field("Achat/Vente"; Rec."Achat/Vente")
            {
                ApplicationArea = all;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }
            field("Compte Associé"; Rec."Compte Associé")
            {
                ApplicationArea = all;
            }
            // field("Search Description"; Rec."Search Description")
            // {
            //     ApplicationArea = all;
            // }
        }
        // addafter("VAT Prod. Posting Group")
        // {
        //     field("Compte Achat Associé"; Rec."Compte Achat Associé")
        //     {
        //         ApplicationArea = all;
        //     }

        // }
    }
    actions
    {

    }

    trigger OnOpenPage()
    begin

        IF CurrPage.LOOKUPMODE THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;
    end;

}