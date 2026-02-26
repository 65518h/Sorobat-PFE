PageExtension 50140 "Blanket Sales Order Sub_PagEXT" extends "Blanket Sales Order Subform"
{

    layout
    {
        addafter(Quantity)
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Shipment Date")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {


    }

    PROCEDURE wShowDescription();
    VAR
        lDescription: Record "Description Line";
    BEGIN
        rec.TESTFIELD("Line No.");
        lDescription.ShowDescription(37, rec."Document Type", rec."Document No.", rec."Line No.");
    END;
}