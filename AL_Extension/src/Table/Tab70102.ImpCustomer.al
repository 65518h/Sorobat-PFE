Table 70102 "Imp Customer"
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
        field(18; "Chain Name"; Code[10])
        {
        }
        field(19; "Budgeted Amount"; Decimal)
        {
        }
        field(20; "Credit Limit (LCY)"; Decimal)
        {
        }
        field(21; "Customer Posting Group"; Code[10])
        {
        }
        field(22; "Currency Code"; Code[10])
        {
        }
        field(23; "Customer Price Group"; Code[10])
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
        field(29; "Salesperson Code"; Code[10])
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
        field(33; "Invoice Disc. Code"; Code[20])
        {
        }
        field(34; "Customer Disc. Group"; Code[10])
        {
        }
        field(35; "Country Code"; Code[10])
        {
        }
        field(36; "Collection Method"; Code[20])
        {
        }
        field(37; Amount; Decimal)
        {
        }
        field(38; Comment; Boolean)
        {
        }
        field(39; Blocked; Option)
        {
            OptionMembers = ,Ship,Invoice,All;
        }
        field(40; "Invoice Copies"; Integer)
        {
        }
        field(41; "Last Statement No."; Integer)
        {
        }
        field(42; "Print Statements"; Boolean)
        {
        }
        field(45; "Bill-to Customer No."; Code[20])
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
        field(62; "Sales (LCY)"; Decimal)
        {
        }
        field(63; "Profit (LCY)"; Decimal)
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
        field(79; "Shipped Not Invoiced"; Decimal)
        {
        }
        field(80; "Application Method"; Option)
        {
            OptionMembers = Manual,"Apply to Oldest";
        }
        field(82; "Prices Including VAT"; Boolean)
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
        field(86; "VAT Registration No."; Text[20])
        {
        }
        field(87; "Combine Shipments"; Boolean)
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
        field(104; "Reminder Terms Code"; Code[10])
        {
        }
        field(105; "Reminder Amounts"; Decimal)
        {
        }
        field(106; "Reminder Amounts (LCY)"; Decimal)
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
        field(114; "Shipped Not Invoiced (LCY)"; Decimal)
        {
        }
        field(115; Reserve; Option)
        {
            OptionMembers = Never,Optional,Always;
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
        field(5750; "Shipping Advice"; Option)
        {
            OptionMembers = Partial,Complete;
        }
        field(5790; "Shipping Time"; DateFormula)
        {
        }
        field(5792; "Shipping Agent Service Code"; Code[10])
        {
        }
        field(5900; "Service Zone Code"; Code[10])
        {
        }
        field(5902; "Contract Gain/Loss Amount"; Decimal)
        {
        }
        field(5903; "Ship-to Filter"; Code[10])
        {
        }
        field(6207; "Notification Process Code"; Code[10])
        {
        }
        field(6209; "Queue Priority"; Option)
        {
            OptionMembers = "Very Low",,Low,Medium,High,,,"Very High";
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
        }
        field(7171; "No. of Quotes"; Integer)
        {
        }
        field(7172; "No. of Blanket Orders"; Integer)
        {
        }
        field(7173; "No. of Orders"; Integer)
        {
        }
        field(7174; "No. of Invoices"; Integer)
        {
        }
        field(7175; "No. of Return Orders"; Integer)
        {
        }
        field(7176; "No. of Credit Memos"; Integer)
        {
        }
        field(7177; "No. of Pstd. Shipments"; Integer)
        {
        }
        field(7178; "No. of Pstd. Invoices"; Integer)
        {
        }
        field(7179; "No. of Pstd. Return Receipts"; Integer)
        {
        }
        field(7180; "No. of Pstd. Credit Memos"; Integer)
        {
        }
        field(7181; "No. of Ship-to Addresses"; Integer)
        {
        }
        field(7182; "Bill-To No. of Quotes"; Integer)
        {
        }
        field(7183; "Bill-To No. of Blanket Orders"; Integer)
        {
        }
        field(7184; "Bill-To No. of Orders"; Integer)
        {
        }
        field(7185; "Bill-To No. of Invoices"; Integer)
        {
        }
        field(7186; "Bill-To No. of Return Orders"; Integer)
        {
        }
        field(7187; "Bill-To No. of Credit Memos"; Integer)
        {
        }
        field(7188; "Bill-To No. of Pstd. Shipments"; Integer)
        {
        }
        field(7189; "Bill-To No. of Pstd. Invoices"; Integer)
        {
        }
        field(7190; "Bill-To No. of Pstd. Return R."; Integer)
        {
        }
        field(7191; "Bill-To No. of Pstd. Cr. Memos"; Integer)
        {
        }
        field(7600; "Base Calendar Code"; Code[10])
        {
        }
        field(7601; "Copy Sell-to Addr. to Qte From"; Option)
        {
            OptionMembers = Company,Person;
        }
        field(50100; "Mobile Phone No."; Text[30])
        {
        }
        field(73754; Replication; Boolean)
        {
        }
        field(2000006; "Preferred Bank Account"; Code[10])
        {
        }
        field(2000020; "Domiciliation No."; Text[12])
        {
        }
        field(8001301; "Criteria 1"; Code[20])
        {
        }
        field(8001302; "Criteria 2"; Code[20])
        {
        }
        field(8001303; "Criteria 3"; Code[20])
        {
        }
        field(8001304; "Criteria 4"; Code[20])
        {
        }
        field(8001305; "Criteria 5"; Code[20])
        {
        }
        field(8001306; "Criteria 6"; Code[20])
        {
        }
        field(8001307; "Criteria 7"; Code[20])
        {
        }
        field(8001308; "Criteria 8"; Code[20])
        {
        }
        field(8001309; "Criteria 9"; Code[20])
        {
        }
        field(8001310; "Criteria 10"; Code[20])
        {
        }
        field(8001411; "Payments not Due (LCY)"; Decimal)
        {
        }
        field(8001412; "Due Date Filter"; Date)
        {
        }
        field(8001413; "Balance (LCY) Sell-to Cust."; Decimal)
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
        field(8004100; "Default Payment Bank Account"; Code[10])
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

