Table 70115 "Imp Order Address"
{

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
        }
        field(2; "Code"; Code[10])
        {
        }
        field(3; Name; Text[30])
        {
        }
        field(4; "Name 2"; Text[30])
        {
        }
        field(5; Address; Text[30])
        {
        }
        field(6; "Address 2"; Text[30])
        {
        }
        field(7; City; Text[30])
        {
        }
        field(8; Contact; Text[30])
        {
        }
        field(9; "Phone No."; Text[30])
        {
        }
        field(10; "Telex No."; Text[30])
        {
        }
        field(35; "Country Code"; Code[10])
        {
        }
        field(54; "Last Date Modified"; Date)
        {
        }
        field(84; "Fax No."; Text[30])
        {
        }
        field(85; "Telex Answer Back"; Text[20])
        {
        }
        field(91; "Post Code"; Code[20])
        {
        }
        field(92; County; Text[30])
        {
        }
        field(102; "E-Mail"; Text[80])
        {
        }
        field(103; "Home Page"; Text[80])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Vendor No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

