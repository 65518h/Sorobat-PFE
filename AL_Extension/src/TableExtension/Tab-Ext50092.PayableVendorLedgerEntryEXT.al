TableExtension 50092 "Payable Vendor Ledger EntryEXT" extends "Payable Vendor Ledger Entry"
{
    Caption = 'Payable Vendor Ledger Entry';
    fields
    {



        field(8001401; "Due Date2"; Date)
        {
            Caption = 'Due Date';
        }
        field(8001402; "Payment Type"; Option)
        {
            OptionCaption = ' ,Check,Bill,Transfer,,,VCOM';
            OptionMembers = " ",Check,Bill,Transfer,,,VCOM;
        }
    }
    keys
    {


        key(STG_Key2; "Due Date2")
        {
        }
    }
}

