Table 8004102 "Bank Amount Buffer"
{
    // //+PMT+PAYMENT GESWAY 01/08/02 Table paiement transaction

    Caption = 'PMT Bank Amount Buffer';

    fields
    {
        field(1; "Bank Account No."; Code[20])
        {
            Caption = 'Bank Account No.';
            TableRelation = "Bank Account";
        }
        field(2; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Document No."; Text[30])
        {
            Caption = 'Document No.';
        }
        field(6; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
    }

    keys
    {
        key(Key1; "Bank Account No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

