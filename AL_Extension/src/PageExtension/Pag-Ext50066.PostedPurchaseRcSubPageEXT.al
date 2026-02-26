PageExtension 50066 "Posted Purchase Rc.Sub_PageEXT" extends "Posted Purchase Rcpt. Subform"
{

    /* GL2024   InsertAllowed = false;
        DeleteAllowed = false;*/
    Editable = true;

    layout
    {
        modify(Type)
        {


            Editable = false;
        }
        modify("No.")
        {


            Editable = false;
        }
        modify("Item Reference No.")
        {
            Visible = false;
            Editable = false;
        }
        modify("Variant Code")
        {
            Visible = false;
            Editable = false;
        }
        modify(Description)
        {
            Visible = false;
        }
        modify("Description 2")
        {
            Visible = false;
            Editable = false;
        }

        modify("Return Reason Code")
        {
            Visible = false;
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        modify("Bin Code")
        {
            Visible = false;
            Editable = false;
        }

        addafter("Job No.")
        {
            field("DYSJob No."; Rec."DYSJob No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }






        modify(Quantity)
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Unit of Measure")
        {
            Visible = false;
            Editable = false;
        }


        modify("Quantity Invoiced")
        {
            Editable = false;
        }
        modify("Qty. Rcd. Not Invoiced")
        {
            Visible = false;
            Editable = false;
        }


        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
            Editable = false;
        }
        modify("Planned Receipt Date")
        {
            Editable = false;
        }
        modify("Expected Receipt Date")
        {
            Editable = false;
        }
        modify("Order Date")
        {
            Editable = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
            Editable = false;
        }
        modify("Job No.")
        {
            Visible = false;
            Editable = false;
        }
        modify("Prod. Order No.")
        {
            Visible = false;
            Editable = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
            Editable = false;
        }
        modify("Appl.-to Item Entry")
        {
            Visible = false;
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
            Editable = false;
        }
        modify(Correction)
        {
            Visible = false;
            Editable = false;

        }







        addafter("type")
        {
            field("Type article"; Rec."Type article")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = all;
            }
        }

        addafter("Bin Code")
        {
            field(Inventory; rec.Inventory)
            {
                Editable = false;
                ApplicationArea = all;
            }
        }
        addafter(Quantity)
        {
            field("Value 1"; rec."Value 1")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 2"; rec."Value 2")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 3"; rec."Value 3")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 4"; rec."Value 4")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 5"; rec."Value 5")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 6"; rec."Value 6")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 7"; rec."Value 7")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 8"; rec."Value 8")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 9"; rec."Value 9")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 10"; rec."Value 10")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Qty. Rcd. Not Invoiced")
        {
            field("Qty. Not In Conformity"; rec."Qty. Not In Conformity")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Not In Conformity Code"; rec."Not In Conformity Code")
            {
                Editable = false;
                ApplicationArea = all;
            }
            field("Not In Conformity"; rec."Not In Conformity")
            {
                Editable = false;
                ApplicationArea = all;

            }
            field("Remainder Quantity"; rec."Remainder Quantity")
            {
                Editable = false;
                ApplicationArea = all;

            }
            field("Posting Date"; rec."Posting Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Job No.2"; Rec."Job No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Job No.")
        {
            field("Work Type Code"; rec."Work Type Code")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Line No."; rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
        }
    }

    actions
    {
        addafter(DocumentLineTracking)
        {
            action("Effacer N° Projet")
            {
                Caption = 'Effacer N° Projet';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Rec.Validate("Job No.", ''); // ou "No. Projet" si ton champ a ce nom exact
                    Rec.Modify(true);
                    Message('Le champ N° Projet a été vidé pour %1.', Rec."No.");
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        rec.SETFILTER("Location Filter", rec."Location Code");
        rec.CALCFIELDS(Inventory);
    end;

    procedure ListePvReception()
    var
        RecLPvReception: Record "PV Reception";
        RecLPvReception2: Record "PV Reception";
        RecLPurchRcptHeader: Record "Purch. Rcpt. Header";
        CdupurchPost: Codeunit "Purch.-Post";
        cduPurchpostevent: Codeunit PurchPostEvent;
    begin
        // >> HJ DSFT 25-04-2012
        if RecLPurchRcptHeader.Get(rec."Document No.") then;
        cduPurchpostevent.ListePvReception(rec."Document No.", RecLPurchRcptHeader."Order No.", rec."No.", RecLPurchRcptHeader."Vendor Shipment No.");
        RecLPvReception2.SetRange("N° BL Fournisseur", RecLPurchRcptHeader."Vendor Shipment No.");
        RecLPvReception2.SetRange("Code Fournisseur", RecLPurchRcptHeader."Buy-from Vendor No.");
        Page.Run(Page::"Liste PV Reception", RecLPvReception2);
        // >> HJ DSFT 25-04-2012
    end;

    procedure ImprimerPvReception()
    var
        RecLPvReception: Record "PV Reception";
        RecLPurchRcptHeader: Record "Purch. Rcpt. Header";
    begin
        // >> HJ DSFT 25-04-2012
        if RecLPurchRcptHeader.Get(rec."Document No.") then;
        RecLPvReception.SetRange("N° BL Fournisseur", RecLPurchRcptHeader."Vendor Shipment No.");
        RecLPvReception.SetRange("N° Article", rec."No.");
        Report.RunModal(Report::"PV Reception", true, false, RecLPvReception);
        // >> HJ DSFT 25-04-2012
    end;
}

