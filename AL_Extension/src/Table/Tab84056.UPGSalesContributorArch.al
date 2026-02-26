Table 84056 "UPG Sales Contributor Arch"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(12; "Contact Company Name"; Text[50])
        {
        }
        field(17; "Line No."; Integer)
        {
        }
        field(5047; "Version No."; Integer)
        {
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.", "Version No.", "Doc. No. Occurrence")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

