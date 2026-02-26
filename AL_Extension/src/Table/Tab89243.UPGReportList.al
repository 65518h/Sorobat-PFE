Table 89243 "UPG Report List"
{

    fields
    {
        field(2; "Line No."; Integer)
        {
        }
        field(3; Text; Text[100])
        {
        }
        field(4; "Report ID"; Integer)
        {
        }
        field(6; "Menu ID"; Integer)
        {
        }
        field(100; "G/L Reports"; Integer)
        {
        }
        field(102; "Sales Reports"; Integer)
        {
        }
        field(103; "Sales Documents"; Integer)
        {
        }
        field(104; "Purchase Reports"; Integer)
        {
        }
        field(105; "Purchase Documents"; Integer)
        {
        }
        field(106; "Item Reports"; Integer)
        {
        }
        field(108; "BOM Reports"; Integer)
        {
        }
        field(110; "Resource Reports"; Integer)
        {
        }
        field(112; "Job Reports"; Integer)
        {
        }
        field(5000; "Relationship Mgt. Reports"; Integer)
        {
        }
        field(5001; "Relationship Mgt. Documents"; Integer)
        {
        }
        field(5200; "Employee Reports"; Integer)
        {
        }
        field(5600; "Fixed Asset Reports"; Integer)
        {
        }
        field(5750; "Warehouse Reports"; Integer)
        {
        }
        field(5751; "Warehouse Documents"; Integer)
        {
        }
        field(5900; "Service Mgt. Reports"; Integer)
        {
        }
        field(5901; "Service Mgt. Documents"; Integer)
        {
        }
        field(6201; "Commerce Portal Reports"; Integer)
        {
        }
        field(99000750; "Mfg. Reports"; Integer)
        {
        }
        field(99000751; "Mfg. Documents"; Integer)
        {
        }
        field(99001000; "CRP Reports"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Menu ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

