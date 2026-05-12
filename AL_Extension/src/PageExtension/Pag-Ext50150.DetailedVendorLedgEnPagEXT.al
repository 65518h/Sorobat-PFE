PageExtension 50150 "Detailed Vendor Ledg En_PagEXT" extends "Detailed Vendor Ledg. Entries"
{

    layout
    {
        addbefore("Initial Entry Due Date")
        {
            field("Debit Amount2"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount2"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
            field(Lettre; Rec.Lettre)
            {
                ApplicationArea = all;
            }
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
    }
    actions
    {

    }

}