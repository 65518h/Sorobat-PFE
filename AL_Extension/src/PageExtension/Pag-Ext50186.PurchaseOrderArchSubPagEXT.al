PageExtension 50186 "Purchase Order Arch Sub_PagEXT" extends "Purchase Order Archive Subform"

{
    layout
    {
        addafter("Variant Code")
        {
            field("Vendor Item No."; Rec."Vendor Item No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Location Code")
        {
            field("Value 1"; Rec."Value 1")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 2"; Rec."Value 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 3"; Rec."Value 3")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 4"; Rec."Value 4")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 5"; Rec."Value 5")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 6"; Rec."Value 6")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 7"; Rec."Value 7")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 8"; Rec."Value 8")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 9"; Rec."Value 9")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Value 10"; Rec."Value 10")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }

        addafter("Unit of Measure")
        {
            field("Invoicing Quantity"; InvoicedQty)
            {
                Caption = 'Invoicing Quantity';
                ApplicationArea = all;
                DecimalPlaces = 0 : 5;
            }
            field("Invoicing Unit"; Rec."Invoicing Unit")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line Amount")
        {
            field("Discount 1 %"; Rec."Discount 1 %")
            {
                ApplicationArea = all;
            }
            field("Discount 2 %"; Rec."Discount 2 %")
            {
                ApplicationArea = all;
            }
            field("Discount 3 %"; Rec."Discount 3 %")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
    VAR
        InvoicedQty: Decimal;

    PROCEDURE wUpdateQtyPerInvoicing();
    BEGIN
        IF rec."Qty. Per Invoicing Unit" <> 0 THEN
            InvoicedQty := rec.Quantity * rec."Qty. Per Invoicing Unit"
        ELSE
            InvoicedQty := rec.Quantity;
    END;

    trigger OnOpenPage()
    begin
        //ACHATS
        wUpdateQtyPerInvoicing;
        //ACHATS//
    end;
}