Table 70128 "Imp Purchase Price"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; "Vendor No."; Code[20])
        {
        }
        field(3; "Currency Code"; Code[10])
        {
        }
        field(4; "Starting Date"; Date)
        {
        }
        field(5; "Direct Unit Cost"; Decimal)
        {
        }
        field(14; "Minimum Quantity"; Decimal)
        {
        }
        field(15; "Ending Date"; Date)
        {
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
        }
        field(5700; "Variant Code"; Code[10])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
        field(8004150; "Resource No."; Code[20])
        {
        }
        field(8004151; Description; Text[80])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity", "Resource No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

