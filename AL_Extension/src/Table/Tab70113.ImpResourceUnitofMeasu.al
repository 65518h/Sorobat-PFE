Table 70113 "Imp Resource Unit of Measu"
{

    fields
    {
        field(1; "Resource No."; Code[20])
        {
        }
        field(2; "Code"; Code[10])
        {
        }
        field(3; "Qty. per Unit of Measure"; Decimal)
        {
        }
        field(4; "Related to Base Unit of Meas."; Boolean)
        {
        }
        field(73754; Replication; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Resource No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

