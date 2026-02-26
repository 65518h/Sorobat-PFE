Table 70119 "Imp Vendor Bank Account"
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
        field(5; "Name 2"; Text[30])
        {
        }
        field(6; Address; Text[30])
        {
        }
        field(7; "Address 2"; Text[30])
        {
        }
        field(8; City; Text[30])
        {
        }
        field(9; "Post Code"; Code[20])
        {
        }
        field(10; Contact; Text[30])
        {
        }
        field(11; "Phone No."; Text[30])
        {
        }
        field(12; "Telex No."; Text[20])
        {
        }
        field(13; "Bank Branch No."; Text[20])
        {
        }
        field(14; "Bank Account No."; Text[30])
        {
        }
        field(15; "Transit No."; Text[20])
        {
        }
        field(16; "Currency Code"; Code[10])
        {
        }
        field(17; "Country Code"; Code[10])
        {
        }
        field(18; County; Text[30])
        {
        }
        field(19; "Fax No."; Text[30])
        {
        }
        field(20; "Telex Answer Back"; Text[20])
        {
        }
        field(21; "Language Code"; Code[10])
        {
        }
        field(22; "E-Mail"; Text[80])
        {
        }
        field(23; "Home Page"; Text[80])
        {
        }
        field(24; IBAN; Code[50])
        {
        }
        field(25; "SWIFT Code"; Code[20])
        {
        }
        field(90608; "Clearing No."; Code[10])
        {
        }
        field(90610; "Payment Form"; Option)
        {
            OptionMembers = ESR,"ESR+","Post Payment Domestic","Bank Payment Domestic","Cash Outpayment Order Domestic","Post Payment Abroad","Bank Payment Abroad","SWIFT Payment Abroad","Cash Outpayment Order Abroad";
        }
        field(90611; "ESR Type"; Option)
        {
            OptionMembers = ,"5/15","9/27","9/16";
        }
        field(90621; "Giro Account No."; Code[11])
        {
        }
        field(90622; "ESR Account No."; Code[11])
        {
        }
        field(90623; "Bank Identifier Code"; Code[21])
        {
        }
        field(90625; "Balance Account No."; Code[20])
        {
        }
        field(90630; "Invoice No. Startposition"; Integer)
        {
        }
        field(90631; "Invoice No. Length"; Integer)
        {
        }
        field(90640; "Debit Bank"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

