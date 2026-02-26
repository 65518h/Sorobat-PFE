Table 8001541 "Stock Posting Group"
{
    //GL2024  ID dans Nav 2009 : "8001609"
    // //+RAP+VMP GESWAY 01/08/02 Table "Stock Posting Group"

    Caption = 'Stock Posting Group';
    //LookupPageID = 8001621;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Stock Account"; Code[20])
        {
            Caption = 'Stock Account';
            TableRelation = "G/L Account";
        }
        field(3; "Bank Charges Account"; Code[20])
        {
            Caption = 'Bank Charges Account';
            TableRelation = "G/L Account";
        }
        field(4; "VAT Account"; Code[20])
        {
            Caption = 'VAT Account';
            TableRelation = "G/L Account";
        }
        field(5; "Capital Gain Account"; Code[20])
        {
            Caption = 'Capital Gain Account';
            TableRelation = "G/L Account";
        }
        field(6; "Loss In Value Account"; Code[20])
        {
            Caption = 'Loss In Value Account';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

