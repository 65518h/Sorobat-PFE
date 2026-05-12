PageExtension 50182 "Sales List Archive_PagEXT" extends "Sales List Archive"

{
    layout
    {
        addbefore("Version No.")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("Rider to Order No."; Rec."Rider to Order No.")
            {
                ApplicationArea = all;
            }

            field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
            {
                ApplicationArea = all;
            }
        }

        addafter("Sell-to Customer Name")
        {
            field(Subject; Rec.Subject)
            {
                ApplicationArea = all;
            }
        }

        addafter("Currency Code")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = all;
            }
            field("Amount Excl. VAT (LCY)"; Rec."Amount Excl. VAT (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
    trigger OnOpenPage()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    BEGIN
        //MASK
        lMaskMgt.SalesHeaderArchive(Rec);
        //MASK//

    end;
}