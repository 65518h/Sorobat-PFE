PageExtension 50110 "Bank Ac. Reconcil Lines_PagEXT" extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        addafter("Transaction Date")
        {
            field("External Document No."; Rec."External Document No.")
            {
                Editable = FALSE;
                ApplicationArea = all;
            }
            field("Lettré"; Rec."Lettré")
            {
                ApplicationArea = all;
            }
        }
    }
}
