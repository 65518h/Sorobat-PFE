Table 70107 "Imp Company Information"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "Name 2"; Text[50])
        {
        }
        field(4; Address; Text[50])
        {
        }
        field(5; "Address 2"; Text[50])
        {
        }
        field(6; City; Text[30])
        {
        }
        field(7; "Phone No."; Text[20])
        {
        }
        field(8; "Phone No. 2"; Text[20])
        {
        }
        field(9; "Telex No."; Text[20])
        {
        }
        field(10; "Fax No."; Text[20])
        {
        }
        field(11; "Giro No."; Text[20])
        {
        }
        field(12; "Bank Name"; Text[30])
        {
        }
        field(13; "Bank Branch No."; Text[20])
        {
        }
        field(14; "Bank Account No."; Text[20])
        {
        }
        field(15; "Payment Routing No."; Text[20])
        {
        }
        field(17; "Customs Permit No."; Text[10])
        {
        }
        field(18; "Customs Permit Date"; Date)
        {
        }
        field(19; "VAT Registration No."; Text[20])
        {
        }
        field(20; "Registration No."; Text[20])
        {
        }
        field(21; "Telex Answer Back"; Text[20])
        {
        }
        field(22; "Ship-to Name"; Text[30])
        {
        }
        field(23; "Ship-to Name 2"; Text[30])
        {
        }
        field(24; "Ship-to Address"; Text[30])
        {
        }
        field(25; "Ship-to Address 2"; Text[30])
        {
        }
        field(26; "Ship-to City"; Text[30])
        {
        }
        field(27; "Ship-to Contact"; Text[30])
        {
        }
        field(28; "Location Code"; Code[10])
        {
        }
        field(29; Picture; Blob)
        {
        }
        field(30; "Post Code"; Code[20])
        {
        }
        field(31; County; Text[30])
        {
        }
        field(32; "Ship-to Post Code"; Code[20])
        {
        }
        field(33; "Ship-to County"; Text[30])
        {
        }
        field(34; "E-Mail"; Text[80])
        {
        }
        field(35; "Home Page"; Text[80])
        {
        }
        field(36; "Country Code"; Code[10])
        {
        }
        field(37; "Ship-to Country Code"; Code[10])
        {
        }
        field(38; IBAN; Code[50])
        {
        }
        field(39; "SWIFT Code"; Code[20])
        {
        }
        field(40; "Industrial Classification"; Text[30])
        {
        }
        field(41; "IC Partner Code"; Code[20])
        {
        }
        field(42; "IC Inbox Type"; Option)
        {
            OptionMembers = "File Location",Database;
        }
        field(43; "IC Inbox Details"; Text[250])
        {
        }
        field(5700; "Responsibility Center"; Code[10])
        {
        }
        field(5791; "Check-Avail. Period Calc."; DateFormula)
        {
        }
        field(5792; "Check-Avail. Time Bucket"; Option)
        {
            OptionMembers = Day,Week,Month,Quarter,Year;
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
        }
        field(7601; "Cal. Convergence Time Frame"; DateFormula)
        {
        }
        field(8001400; "Picture No."; Code[10])
        {
        }
        field(8001401; "Default Language Code"; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

