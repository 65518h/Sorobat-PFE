TableExtension 50101 "Payment BufferEXT" extends "Payment Buffer"
{
    fields
    {
        modify("Vendor Ledg. Entry Doc. Type")
        {
            Caption = 'Vendor Ledg. Entry Doc. Type';
        }
        modify("Vendor Ledg. Entry Doc. No.")
        {
            Caption = 'Vendor Ledg. Entry Doc. No.';
        }
        field(8001401; "Due Date"; Date)
        {
        }
        field(8001402; "Payment Type"; Integer)
        {
        }
    }
    keys
    {

        //GL2024 key(STG_Key1;"Vendor No.","Currency Code","Vendor Ledg. Entry No.","Dimension Entry No.","Due Date")
        // {
        // Clustered = true;
        // }
    }
}

