TableExtension 50102 "Detailed Cust. Ledg. EntryEXT" extends "Detailed Cust. Ledg. Entry"
{
    Caption = 'Detailed Cust. Ledg. Entry';
    fields
    {
        field(50000; Avance; Boolean)
        {
            CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
            Description = 'RB SORO 27/03/2015';
            FieldClass = FlowField;
        }
        field(50001; "Folio N°"; Text[20])
        {
        }
        field(50002; Lettre; Text[4])
        {
            Description = 'HJ SORO 03-05-2015';
        }
        field(5006; "Transaction No. Soroubat"; Integer)
        {
            Caption = 'Transaction No. Soroubat';
        }
        field(8001600; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
        field(8004100; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
        }
    }
    keys
    {


        /*  GL204   key(Key18;"Customer No.","Posting Date","Entry Type","Currency Code","Sell-to Customer No.")
             {
             SumIndexFields = Amount,"Amount (LCY)","Debit Amount","Debit Amount (LCY)","Credit Amount","Credit Amount (LCY)";
             }

             key(Key19;"Customer No.","Value Date","Currency Code")
             {
             SumIndexFields = Amount,"Amount (LCY)","Debit Amount","Credit Amount","Debit Amount (LCY)","Credit Amount (LCY)";
             }*/
        key(Key20; "Initial Document Type", "Customer No.", "Posting Date", "Currency Code", "Entry Type", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key21; "Initial Document Type", "Customer No.", "Posting Date", "Currency Code", "Entry Type", "Initial Entry Due Date")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
        key(Key22; "Cust. Ledger Entry No.")
        {
        }
        key(Key23; Lettre)
        {
        }
    }
}

