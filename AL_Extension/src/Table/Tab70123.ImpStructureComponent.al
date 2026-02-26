Table 70123 "Imp Structure Component"
{

    fields
    {
        field(1; "Parent Structure No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = ,Item,Person,Machine,Structure,"G/L Account";
        }
        field(4; "No."; Code[20])
        {
        }
        field(6; Description; Text[100])
        {
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
        }
        field(8; "Quantity per"; Decimal)
        {
        }
        field(9; Position; Code[10])
        {
        }
        field(10; "Position 2"; Code[10])
        {
        }
        field(11; "Position 3"; Code[10])
        {
        }
        field(12; "Machine No."; Code[10])
        {
        }
        field(13; "Production Lead Time"; Integer)
        {
        }
        field(14; "BOM Description"; Text[50])
        {
        }
        field(15; "Description 2"; Text[50])
        {
        }
        field(5402; "Variant Code"; Code[10])
        {
        }
        field(5900; "Installed in Line No."; Integer)
        {
        }
        field(5901; "Installed in Item No."; Code[20])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
        field(8004048; "Number of Resources"; Decimal)
        {
        }
        field(8004049; "Rate Quantity"; Decimal)
        {
        }
        field(8004055; "Fixed Quantity"; Decimal)
        {
        }
        field(8004066; "Value 1"; Decimal)
        {
        }
        field(8004067; "Value 2"; Decimal)
        {
        }
        field(8004068; "Value 3"; Decimal)
        {
        }
        field(8004069; "Value 4"; Decimal)
        {
        }
        field(8004070; "Value 5"; Decimal)
        {
        }
        field(8004071; "Value 6"; Decimal)
        {
        }
        field(8004072; "Value 7"; Decimal)
        {
        }
        field(8004073; "Value 8"; Decimal)
        {
        }
        field(8004074; "Value 9"; Decimal)
        {
        }
        field(8004075; "Value 10"; Decimal)
        {
        }
        field(8004076; "Print Line on Doc."; Boolean)
        {
        }
        field(8004100; "Bill of quantities"; Boolean)
        {
        }
        field(8004102; Variables; Boolean)
        {
        }
        field(8004150; Subcontracting; Option)
        {
            OptionMembers = ,"Furniture and Fixing",Fixing;
        }
        field(8004152; "Subcontracted quantity"; Decimal)
        {
        }
        field(8004153; "Subcontracted Unit Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Parent Structure No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

