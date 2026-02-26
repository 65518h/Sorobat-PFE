Table 8003991 "Return Receipt Invoiced"
{
    // //CUT_OFF GESWAY 29/05/02 Nouvelle table des réceptions retour facturées

    Caption = 'Return Receipt Invoiced';

    fields
    {
        field(1; "Credit Memo No."; Code[20])
        {
            Caption = 'Credit Memo No.';
        }
        field(2; "Cr. Memo Line No."; Integer)
        {
            Caption = 'Cr. Memo Line No.';
        }
        field(3; "Return Receipt. No."; Code[20])
        {
            Caption = 'Return Receipt No.';
        }
        field(4; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.';
        }
        field(5; "Return  Order No."; Code[20])
        {
            Caption = 'Return  Order No.';
        }
        field(6; "Return Order Line No."; Integer)
        {
            Caption = 'Return Order Line No.';
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
        field(12; "Cr. Memo Posting Date"; Date)
        {
            Caption = 'Cr. Memo Posting Date';
        }
        field(13; "Return Rcpt. Posting Date"; Date)
        {
            Caption = 'Return Rcpt. Posting Date';
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
        key(Key1; "Credit Memo No.", "Cr. Memo Line No.", "Return Receipt. No.", "Return Receipt Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Return  Order No.", "Return Order Line No.")
        {
        }
        key(Key3; "Return Rcpt. Posting Date", "Cr. Memo Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

