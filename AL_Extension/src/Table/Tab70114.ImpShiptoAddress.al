Table 70114 "Imp Ship-to Address"
{

    fields
    {
        field(1; "Customer No."; Code[20])
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
        field(30; "Shipment Method Code"; Code[10])
        {
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
        }
        field(32; "Place of Export"; Code[20])
        {
        }
        field(35; "Country Code"; Code[10])
        {
        }
        field(54; "Last Date Modified"; Date)
        {
        }
        field(83; "Location Code"; Code[10])
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
        field(108; "Tax Area Code"; Code[20])
        {
        }
        field(109; "Tax Liable"; Boolean)
        {
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
        }
        field(5900; "Service Zone Code"; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Customer No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

