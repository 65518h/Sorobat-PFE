pageextension 50301 "Purchase InvoicesExt" extends "Purchase Invoices"
{
    layout
    {

        modify("Buy-from Vendor No.")
        {
            Caption = 'N° preneur d''ordre';
        }

        addafter(Amount)
        {
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
                ToolTip = 'Total amount including VAT for the invoice.';
            }
        }
        addafter("Buy-from Vendor Name")
        {
            field("N° Demande d'achat"; Rec."N° Demande d'achat")
            {
                ApplicationArea = all;
                Style = Strong;
                StyleExpr = true;
            }
            field("Date Saisie"; Rec."Date Saisie")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
                ToolTip = 'Date when the invoice was entered.';
            }
            field("Utilisateur"; Rec."Utilisateur")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'User who entered the invoice.';
            }
            field("Facture En Instance"; Rec."Facture En Instance")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }


        }
        addafter("Document Date")
        {
            field("Vendor Shipment No."; rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
            }
            field("Statut Commande"; Rec."Statut Commande")
            {
                ApplicationArea = all;
                Style = AttentionAccent;
                StyleExpr = true;
                Visible = false;
            }
            field(Amount1; Rec.Amount)
            {

                ApplicationArea = all;
                Style = AttentionAccent;
                StyleExpr = true;
            }
            // field(wDescr; wDescr)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Libellé écriture';
            // }
            field("Requested Receipt Date1"; rec."Requested Receipt Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Promised Receipt Date"; rec."Promised Receipt Date")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Vendor Order No."; rec."Vendor Order No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Vendor Authorization No.1"; rec."Vendor Authorization No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Date Next Follow-Up"; rec."Date Next Follow-Up")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Location Code1"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("Job No."; rec."Job No.")
            {
                ApplicationArea = all;
            }


        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        movebefore("Vendor Invoice No."; "Posting Date", "Document Date")
        modify("Vendor Invoice No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            visible = true;
        }
        modify("Posting Date")
        {
            visible = true;
        }

        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

        wDescr: Text[100];

    trigger OnAfterGetRecord()
    begin

        //POSTING_DESC
        //    wDescr := rec.wShowPostingDescription(rec."Posting Description");
        //POSTING_DESC//
    end;
}