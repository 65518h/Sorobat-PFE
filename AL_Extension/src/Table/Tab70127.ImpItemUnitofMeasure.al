Table 70127 "Imp Item Unit of Measure"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; "Code"; Code[10])
        {
        }
        field(3; "Qty. per Unit of Measure"; Decimal)
        {
        }
        field(7300; Length; Decimal)
        {
        }
        field(7301; Width; Decimal)
        {
        }
        field(7302; Height; Decimal)
        {
        }
        field(7303; Cubage; Decimal)
        {
        }
        field(7304; Weight; Decimal)
        {
        }
        field(73754; Replication; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

