PageExtension 50125 "Sales Receivables Setup_PagEXT" extends "Sales & Receivables Setup"
{

    layout
    {

        addafter("Update Document Date When Posting Date Is Modified")
        {
            // field("Coût Transport BETON HT"; Rec."Coût Transport BETON HT")
            // {
            //     ApplicationArea = all;
            // }
            // field("Coût Transport Sous-Tremie HT"; Rec."Coût Transport Sous-Tremie HT")
            // {
            //     ApplicationArea = all;
            // }
            field("Frais BIC"; Rec."Frais BIC")
            {
                ApplicationArea = all;
            }
            field("Taux BIC"; Rec."Taux BIC")
            {
                ApplicationArea = all;
            }

            // addafter("Posted Prepmt. Cr. Memo Nos.")
            // {
            //     // field("Souche Facture Beton"; Rec."Souche Facture Beton")
            //     // {
            //     //     ApplicationArea = all;
            //     // }
            // }

        }
    }

    actions
    {

    }




}

