PageExtension 50074 "Posted Purchase Rec_PagEXT" extends "Posted Purchase Receipts"
{

    layout
    {
        addbefore("No.")
        {

            field("Posting Date2"; Rec."Posting Date")
            {
                ApplicationArea = all;
            }

        }
        addafter("No.")
        {
            field("N° Dossier"; Rec."N° Dossier")
            {
                ApplicationArea = all;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Order Address Code")
        {
            field(Engin; Rec.Engin)
            {
                ApplicationArea = all;
            }
            field("Description Engin"; Rec."Description Engin")
            {
                ApplicationArea = all;
            }
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
            field("N° Demande d'achat"; Rec."N° Demande d'achat")
            {
                ApplicationArea = all;
            }
            field(Demandeur; Rec.Demandeur)
            {
                ApplicationArea = all;
            }
        }

        addafter("Buy-from Vendor Name")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
            }
            field("On Hold"; Rec."On Hold")
            {
                ApplicationArea = all;
            }
        }

        addafter("Pay-to Contact")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Control1)
        {
            part("PurchReceiptLines"; "Posted Purchase Rcpt. Subform")
            {
                Caption = 'Posted Purchase Rcpt. Subform';

                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }


    }


}



