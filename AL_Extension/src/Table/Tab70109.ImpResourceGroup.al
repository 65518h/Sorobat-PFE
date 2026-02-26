Table 70109 "Imp Resource Group"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Name; Text[30])
        {
        }
        field(22; "Date Filter"; Date)
        {
        }
        field(23; Capacity; Decimal)
        {
        }
        field(24; "Qty. on Order (Job)"; Decimal)
        {
        }
        field(25; "Qty. Quoted (Job)"; Decimal)
        {
        }
        field(26; "Unit of Measure Filter"; Code[10])
        {
        }
        field(27; "Usage (Qty.)"; Decimal)
        {
        }
        field(28; "Usage (Cost)"; Decimal)
        {
        }
        field(29; "Usage (Price)"; Decimal)
        {
        }
        field(30; "Sales (Qty.)"; Decimal)
        {
        }
        field(31; "Sales (Cost)"; Decimal)
        {
        }
        field(32; "Sales (Price)"; Decimal)
        {
        }
        field(33; "Chargeable Filter"; Boolean)
        {
        }
        field(34; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(35; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(5900; "Qty. on Service Order"; Decimal)
        {
        }
        field(8003900; "Gen. Prod. Posting Group"; Code[10])
        {
        }
        field(8003901; "Job Filter"; Code[20])
        {
        }
        field(8003902; "Phase Filter"; Code[10])
        {
        }
        field(8003903; "Audit Res. Gr. Qty."; Decimal)
        {
        }
        field(8003904; "Posted Res. Gr. Qty"; Decimal)
        {
        }
        field(8003907; "Audit Res. Gr. Cost"; Decimal)
        {
        }
        field(8003908; "Posted Res. Gr. Cost"; Decimal)
        {
        }
        field(8003909; Type; Option)
        {
            OptionMembers = Person,Machine;
        }
        field(8003910; Totaling; Text[250])
        {
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
        }
        field(8004132; "Planning Quantity"; Decimal)
        {
        }
        field(8004133; "Sales Quantity"; Decimal)
        {
        }
        field(8004134; "Document Type Filter"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004135; "Document No. Filter"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

