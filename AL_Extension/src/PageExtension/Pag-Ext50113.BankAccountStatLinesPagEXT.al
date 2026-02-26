PageExtension 50113 "Bank Account Stat Lines_PagEXT" extends "Bank Account Statement Lines"
{
    layout
    {
        addafter("Transaction Date")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }

        }
    }
}