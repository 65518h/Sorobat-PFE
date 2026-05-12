PageExtension 50101 "General Posting Setup_PagEXT" extends "General Posting Setup"
{
    layout
    {
        addafter("Purch. FA Disc. Account")
        {
            field("Prepaid Income Account"; rec."Prepaid Income Account")
            {
                ApplicationArea = all;
            }
            field("Prepaid Expenses Account"; rec."Prepaid Expenses Account")
            {
                ApplicationArea = all;
            }
            field("Transfer From Account"; rec."Transfer From Account")
            {
                ApplicationArea = all;
            }
            field("Transfer To Account"; rec."Transfer To Account")
            {
                ApplicationArea = all;
            }
            field("Comptes De Charges Affectées"; rec."Comptes De Charges Affectées")
            {
                ApplicationArea = all;
            }
        }
    }
}

