Table 70103 "Imp Vendor"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Name; Text[30])
        {
        }
        field(3; "Search Name"; Code[30])
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
        field(10; "Telex No."; Text[20])
        {
        }
        field(14; "Our Account No."; Text[20])
        {
        }
        field(15; "Territory Code"; Code[10])
        {
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(19; "Budgeted Amount"; Decimal)
        {
        }
        field(21; "Vendor Posting Group"; Code[10])
        {
        }
        field(22; "Currency Code"; Code[10])
        {
        }
        field(24; "Language Code"; Code[10])
        {
        }
        field(26; "Statistics Group"; Integer)
        {
        }
        field(27; "Payment Terms Code"; Code[10])
        {
        }
        field(28; "Fin. Charge Terms Code"; Code[10])
        {
        }
        field(29; "Purchaser Code"; Code[10])
        {
        }
        field(30; "Shipment Method Code"; Code[10])
        {
        }
        field(31; "Shipping Agent Code"; Code[10])
        {
        }
        field(33; "Invoice Disc. Code"; Code[20])
        {
        }
        field(35; "Country Code"; Code[10])
        {
        }
        field(38; Comment; Boolean)
        {
        }
        field(39; Blocked; Option)
        {
            OptionMembers = ,Payment,All;
        }
        field(45; "Pay-to Vendor No."; Code[20])
        {
        }
        field(46; Priority; Integer)
        {
        }
        field(47; "Payment Method Code"; Code[10])
        {
        }
        field(54; "Last Date Modified"; Date)
        {
        }
        field(55; "Date Filter"; Date)
        {
        }
        field(56; "Global Dimension 1 Filter"; Code[20])
        {
        }
        field(57; "Global Dimension 2 Filter"; Code[20])
        {
        }
        field(58; Balance; Decimal)
        {
        }
        field(59; "Balance (LCY)"; Decimal)
        {
        }
        field(60; "Net Change"; Decimal)
        {
        }
        field(61; "Net Change (LCY)"; Decimal)
        {
        }
        field(62; "Purchases (LCY)"; Decimal)
        {
        }
        field(64; "Inv. Discounts (LCY)"; Decimal)
        {
        }
        field(65; "Pmt. Discounts (LCY)"; Decimal)
        {
        }
        field(66; "Balance Due"; Decimal)
        {
        }
        field(67; "Balance Due (LCY)"; Decimal)
        {
        }
        field(69; Payments; Decimal)
        {
        }
        field(70; "Invoice Amounts"; Decimal)
        {
        }
        field(71; "Cr. Memo Amounts"; Decimal)
        {
        }
        field(72; "Finance Charge Memo Amounts"; Decimal)
        {
        }
        field(74; "Payments (LCY)"; Decimal)
        {
        }
        field(75; "Inv. Amounts (LCY)"; Decimal)
        {
        }
        field(76; "Cr. Memo Amounts (LCY)"; Decimal)
        {
        }
        field(77; "Fin. Charge Memo Amounts (LCY)"; Decimal)
        {
        }
        field(78; "Outstanding Orders"; Decimal)
        {
        }
        field(79; "Amt. Rcd. Not Invoiced"; Decimal)
        {
        }
        field(80; "Application Method"; Option)
        {
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82; "Prices Including VAT"; Boolean)
        {
        }
        field(84; "Fax No."; Text[30])
        {
        }
        field(85; "Telex Answer Back"; Text[20])
        {
        }
        field(86; "VAT Registration No."; Text[20])
        {
        }
        field(88; "Gen. Bus. Posting Group"; Code[10])
        {
        }
        field(89; Picture; Blob)
        {
        }
        field(91; "Post Code"; Code[20])
        {
        }
        field(92; County; Text[30])
        {
        }
        field(97; "Debit Amount"; Decimal)
        {
        }
        field(98; "Credit Amount"; Decimal)
        {
        }
        field(99; "Debit Amount (LCY)"; Decimal)
        {
        }
        field(100; "Credit Amount (LCY)"; Decimal)
        {
        }
        field(102; "E-Mail"; Text[80])
        {
        }
        field(103; "Home Page"; Text[80])
        {
        }
        field(104; "Reminder Amounts"; Decimal)
        {
        }
        field(105; "Reminder Amounts (LCY)"; Decimal)
        {
        }
        field(107; "No. Series"; Code[10])
        {
        }
        field(108; "Tax Area Code"; Code[20])
        {
        }
        field(109; "Tax Liable"; Boolean)
        {
        }
        field(110; "VAT Bus. Posting Group"; Code[10])
        {
        }
        field(111; "Currency Filter"; Code[10])
        {
        }
        field(113; "Outstanding Orders (LCY)"; Decimal)
        {
        }
        field(114; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
        }
        field(116; "Block Payment Tolerance"; Boolean)
        {
        }
        field(117; "Pmt. Disc. Tolerance (LCY)"; Decimal)
        {
        }
        field(118; "Pmt. Tolerance (LCY)"; Decimal)
        {
        }
        field(119; "IC Partner Code"; Code[20])
        {
        }
        field(120; Refunds; Decimal)
        {
        }
        field(121; "Refunds (LCY)"; Decimal)
        {
        }
        field(122; "Other Amounts"; Decimal)
        {
        }
        field(123; "Other Amounts (LCY)"; Decimal)
        {
        }
        field(5049; "Primary Contact No."; Code[20])
        {
        }
        field(5700; "Responsibility Center"; Code[10])
        {
        }
        field(5701; "Location Code"; Code[10])
        {
        }
        field(5790; "Lead Time Calculation"; DateFormula)
        {
        }
        field(6200; "Reverse Auction Participant"; Boolean)
        {
        }
        field(6207; "Notification Process Code"; Code[10])
        {
        }
        field(6209; "Queue Priority"; Option)
        {
            OptionMembers = "Very Low",,Low,Medium,High,,,"Very High";
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
        }
        field(50100; "Mobile Phone No."; Text[30])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
        field(2000005; "Suggest Payments"; Boolean)
        {
        }
        field(2000006; "Preferred Bank Account"; Code[10])
        {
        }
        field(8001400; Cotation; Code[10])
        {
        }
        field(8001428; Template; Code[10])
        {
        }
        field(8001801; "Gen. Bus. Post. Group Tax 1"; Code[10])
        {
        }
        field(8001802; "Gen. Bus. Post. Group Tax 2"; Code[10])
        {
        }
        field(8001803; "Gen. Bus. Post. Group Tax 3"; Code[10])
        {
        }
        field(8001804; "Gen. Bus. Post. Group Tax 4"; Code[10])
        {
        }
        field(8001805; "Gen. Bus. Post. Group Tax 5"; Code[10])
        {
        }
        field(8003901; "External Work Force"; Boolean)
        {
        }
        field(8003902; "Shipment Method to"; Text[30])
        {
        }
        field(8004090; "Vendor Disc. Group"; Code[10])
        {
        }
        field(8004091; "Item Category"; Boolean)
        {
        }
        field(8004092; "Item Category Filter"; Code[20])
        {
        }
        field(8004100; "Default Payment Bank Account"; Code[10])
        {
        }
        field(8004150; Subcontractor; Boolean)
        {
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

