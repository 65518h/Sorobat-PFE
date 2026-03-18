Table 80039 "UPG Purchase Line"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Line No."; Integer)
        {
        }
        field(60135; "Prepayment VAT Difference"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

