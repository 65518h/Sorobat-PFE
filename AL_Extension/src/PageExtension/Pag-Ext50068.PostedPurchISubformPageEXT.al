PageExtension 50068 "Posted Purch.I Subform_PageEXT" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        modify("Item Reference No.")
        {
            Visible = false;
        }
        addafter("Job No.")
        {
            field("DYSJob No."; Rec."DYSJob No.")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'N° Projet';
            }

        }
        modify("Job No.")
        {
            Visible = false;
        }

        modify("Unit Price (LCY)")
        {
            Visible = false;
        }
        addafter("Item Reference No.")
        {
            field("Vendor Item No."; rec."Vendor Item No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter(Description)
        {
            field("Order No.2"; Rec."Order No.2")
            {
                ApplicationArea = all;
            }
            field("N° Bon Reception"; rec."N° Bon Reception")
            {
                ApplicationArea = all;
            }
            field("Location Code"; rec."Location Code")
            {
                ApplicationArea = all;
            }

            field("Expected Receipt Date"; rec."Expected Receipt Date")
            {
                ApplicationArea = all;
            }

        }
        addafter(Quantity)
        {
            field("Value 1"; rec."Value 1")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 2"; rec."Value 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 3"; rec."Value 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 4"; rec."Value 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 5"; rec."Value 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 6"; rec."Value 6")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 7"; rec."Value 7")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 8"; rec."Value 8")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 9"; rec."Value 9")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 10"; rec."Value 10")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field(InvoicedQty; InvoicedQty)
            {
                ApplicationArea = all;
                Caption = 'Invoicing Quantity';
            }
            field("Invoicing Unit"; rec."Invoicing Unit")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("N° BL Fournisseur"; rec."N° BL Fournisseur")
            {
                ApplicationArea = all;
            }
        }
        addafter("Appl.-to Item Entry")
        {
            field("Work Type Code"; rec."Work Type Code")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

    var
        InvoicedQty: Decimal;


    trigger OnAfterGetRecord()
    begin
        if Rec."DYSJob No." = '' then begin
            Rec."DYSJob No." := Rec."Job No.";
            Rec.Modify();
        end;
        //ACHATS
        wUpdateQtyPerInvoicing;
        //ACHATS//
    end;
    //end;

    procedure wUpdateQtyPerInvoicing()
    begin
        if rec."Qty. Per Invoicing Unit" <> 0 then
            InvoicedQty := rec.Quantity * rec."Qty. Per Invoicing Unit"
        else
            InvoicedQty := rec.Quantity;
    end;
}

