PageExtension 50146 "Purchase Lines_PagEXT" extends "Purchase Lines"
{

    layout
    {
        addafter("Job Line Type")
        {
            field("Engaged Cost (LCY)"; Rec."Engaged Cost (LCY)")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(wAmtOrderedNotRcd; wAmtOrderedNotRcd)
            {
                Caption = 'Amt. Ordered Not Rcd. (LCY)';
                ApplicationArea = all;
            }
        }

        addafter("Amt. Rcd. Not Invoiced (LCY)")
        {
            field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
            {
                ApplicationArea = all;
            }
            field("Outst. Amount Excl. VAT (LCY)"; Rec."Outst. Amount Excl. VAT (LCY)")
            {
                ApplicationArea = all;
            }
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                ApplicationArea = all;
            }
            field("Amt.Rcd. Not Inv.Excl. VAT LCY"; Rec."Amt.Rcd. Not Inv.Excl. VAT LCY")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
    trigger OnAfterGetRecord()
    begin
        //#6283
        wAmtOrderedNotRcd := rec."Engaged Cost (LCY)" - rec."Amt.Rcd. Not Inv.Excl. VAT LCY";
        //#6283//
    end;

    var
        wAmtOrderedNotRcd: Decimal;
}