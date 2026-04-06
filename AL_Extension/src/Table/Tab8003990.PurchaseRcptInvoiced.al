Table 8003990 "Purchase Rcpt. Invoiced"
{
    // //CUT_OFF GESWAY 29/05/02 Nouvelle table des réceptions facturées

    Caption = 'Purchase Rcpt. Invoiced';

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
        }
        field(2; "Invoice Line No."; Integer)
        {
            Caption = 'Invoice Line No.';
        }
        field(3; "Purchase Rcpt. No."; Code[20])
        {
            Caption = 'Whse. Receipt Nos.';
        }
        field(4; "Purch. Rcpt. Line No."; Integer)
        {
            Caption = 'Purch. Rcpt. Line No.';
        }
        field(5; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(6; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(10; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
        }
        field(11; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
        }
        field(12; "Invoice Posting Date"; Date)
        {
            Caption = 'Invoice Posting Date';
        }
        field(13; "Purch. Rcpt. Posting Date"; Date)
        {
            Caption = 'Purch. Rcpt. Posting Date';
        }
        field(20; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
    }

    keys
    {
        key(STG_Key1; "Invoice No.", "Invoice Line No.", "Purchase Rcpt. No.", "Purch. Rcpt. Line No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Order No.", "Order Line No.")
        {
        }
        key(STG_Key3; "Purch. Rcpt. Posting Date", "Invoice Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

