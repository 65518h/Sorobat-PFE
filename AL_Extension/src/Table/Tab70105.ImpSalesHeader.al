Table 70105 "Imp Sales Header"
{

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
        }
        field(3; "No."; Code[20])
        {
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
        }
        field(5; "Bill-to Name"; Text[30])
        {
        }
        field(6; "Bill-to Name 2"; Text[30])
        {
        }
        field(7; "Bill-to Address"; Text[30])
        {
        }
        field(8; "Bill-to Address 2"; Text[30])
        {
        }
        field(9; "Bill-to City"; Text[30])
        {
        }
        field(10; "Bill-to Contact"; Text[30])
        {
        }
        field(11; "Your Reference"; Text[30])
        {
        }
        field(12; "Ship-to Code"; Code[10])
        {
        }
        field(13; "Ship-to Name"; Text[30])
        {
        }
        field(14; "Ship-to Name 2"; Text[30])
        {
        }
        field(15; "Ship-to Address"; Text[30])
        {
        }
        field(16; "Ship-to Address 2"; Text[30])
        {
        }
        field(17; "Ship-to City"; Text[30])
        {
        }
        field(18; "Ship-to Contact"; Text[30])
        {
        }
        field(19; "Order Date"; Date)
        {
        }
        field(20; "Posting Date"; Date)
        {
        }
        field(21; "Shipment Date"; Date)
        {
        }
        field(22; "Posting Description"; Text[50])
        {
        }
        field(23; "Payment Terms Code"; Code[10])
        {
        }
        field(24; "Due Date"; Date)
        {
        }
        field(25; "Payment Discount %"; Decimal)
        {
        }
        field(26; "Pmt. Discount Date"; Date)
        {
        }
        field(27; "Shipment Method Code"; Code[10])
        {
        }
        field(28; "Location Code"; Code[10])
        {
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
        }
        field(31; "Customer Posting Group"; Code[10])
        {
        }
        field(32; "Currency Code"; Code[10])
        {
        }
        field(33; "Currency Factor"; Decimal)
        {
        }
        field(34; "Customer Price Group"; Code[10])
        {
        }
        field(35; "Prices Including VAT"; Boolean)
        {
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
        }
        field(41; "Language Code"; Code[10])
        {
        }
        field(43; "Salesperson Code"; Code[10])
        {
        }
        field(45; "Order Class"; Code[10])
        {
        }
        field(47; "No. Printed"; Integer)
        {
        }
        field(51; "On Hold"; Code[3])
        {
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            OptionMembers = ,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
        }
        field(55; "Bal. Account No."; Code[20])
        {
        }
        field(56; "Job No."; Code[20])
        {
        }
        field(57; Ship; Boolean)
        {
        }
        field(58; Invoice; Boolean)
        {
        }
        field(60; Amount; Decimal)
        {
        }
        field(61; "Amount Including VAT"; Decimal)
        {
        }
        field(62; "Shipping No."; Code[20])
        {
        }
        field(63; "Posting No."; Code[20])
        {
        }
        field(64; "Last Shipping No."; Code[20])
        {
        }
        field(65; "Last Posting No."; Code[20])
        {
        }
        field(70; "VAT Registration No."; Text[20])
        {
        }
        field(71; "Combine Shipments"; Boolean)
        {
        }
        field(73; "Reason Code"; Code[10])
        {
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
        }
        field(76; "Transaction Type"; Code[10])
        {
        }
        field(77; "Transport Method"; Code[10])
        {
        }
        field(78; "VAT Country Code"; Code[10])
        {
        }
        field(79; "Sell-to Customer Name"; Text[30])
        {
        }
        field(80; "Sell-to Customer Name 2"; Text[30])
        {
        }
        field(81; "Sell-to Address"; Text[30])
        {
        }
        field(82; "Sell-to Address 2"; Text[30])
        {
        }
        field(83; "Sell-to City"; Text[30])
        {
        }
        field(84; "Sell-to Contact"; Text[30])
        {
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
        }
        field(86; "Bill-to County"; Text[30])
        {
        }
        field(87; "Bill-to Country Code"; Code[10])
        {
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
        }
        field(89; "Sell-to County"; Text[30])
        {
        }
        field(90; "Sell-to Country Code"; Code[10])
        {
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
        }
        field(92; "Ship-to County"; Text[30])
        {
        }
        field(93; "Ship-to Country Code"; Code[10])
        {
        }
        field(94; "Bal. Account Type"; Option)
        {
            OptionMembers = "G/L Account","Bank Account";
        }
        field(97; "Exit Point"; Code[10])
        {
        }
        field(98; Correction; Boolean)
        {
        }
        field(99; "Document Date"; Date)
        {
        }
        field(100; "External Document No."; Code[20])
        {
        }
        field(101; "Area"; Code[10])
        {
        }
        field(102; "Transaction Specification"; Code[10])
        {
        }
        field(104; "Payment Method Code"; Code[10])
        {
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
        }
        field(106; "Package Tracking No."; Text[30])
        {
        }
        field(107; "No. Series"; Code[10])
        {
        }
        field(108; "Posting No. Series"; Code[10])
        {
        }
        field(109; "Shipping No. Series"; Code[10])
        {
        }
        field(114; "Tax Area Code"; Code[20])
        {
        }
        field(115; "Tax Liable"; Boolean)
        {
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
        }
        field(117; Reserve; Option)
        {
            OptionMembers = Never,Optional,Always;
        }
        field(118; "Applies-to ID"; Code[20])
        {
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
        }
        field(120; Status; Option)
        {
            OptionMembers = Open,Released;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
        }
        field(123; "Send IC Document"; Boolean)
        {
        }
        field(124; "IC Status"; Option)
        {
            OptionMembers = New,Pending,Sent;
        }
        field(125; "Sell-to IC Partner Code"; Code[20])
        {
        }
        field(126; "Bill-to IC Partner Code"; Code[20])
        {
        }
        field(129; "IC Direction"; Option)
        {
            OptionMembers = Outgoing,Incoming;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
        }
        field(5050; "Campaign No."; Code[20])
        {
        }
        field(5051; "Sell-to Customer Template Code"; Code[10])
        {
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
        }
        field(5054; "Bill-to Customer Template Code"; Code[10])
        {
        }
        field(5055; "Opportunity No."; Code[20])
        {
        }
        field(5700; "Responsibility Center"; Code[10])
        {
        }
        field(5750; "Shipping Advice"; Option)
        {
            OptionMembers = Partial,Complete;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
        }
        field(5754; "Location Filter"; Code[10])
        {
        }
        field(5790; "Requested Delivery Date"; Date)
        {
        }
        field(5791; "Promised Delivery Date"; Date)
        {
        }
        field(5792; "Shipping Time"; DateFormula)
        {
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
        }
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
        }
        field(5795; "Late Order Shipping"; Boolean)
        {
        }
        field(5796; "Date Filter"; Date)
        {
        }
        field(5800; Receive; Boolean)
        {
        }
        field(5801; "Return Receipt No."; Code[20])
        {
        }
        field(5802; "Return Receipt No. Series"; Code[10])
        {
        }
        field(5803; "Last Return Receipt No."; Code[20])
        {
        }
        field(5900; "Service Mgt. Document"; Boolean)
        {
        }
        field(6201; "Expiration Date"; Date)
        {
        }
        field(6202; "CP Status"; Option)
        {
            OptionMembers = ,"Requested by Customer","Accepted by Customer",Rejected;
        }
        field(6203; "Auto Created"; Boolean)
        {
        }
        field(6210; "Login ID"; Code[30])
        {
        }
        field(6211; "Web Site Code"; Code[20])
        {
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
        }
        field(7200; "Get Shipment Used"; Boolean)
        {
        }
        field(82750; "Mask Code"; Code[10])
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
        field(8001400; "Financial Document"; Boolean)
        {
        }
        field(8001401; "User ID"; Code[20])
        {
        }
        field(8001402; "Doc. Creation Date"; Date)
        {
        }
        field(8001403; "Source Quote No."; Code[20])
        {
        }
        field(8001404; "Close Opportunity Code"; Code[10])
        {
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
        }
        field(8001901; "Subscription End Date"; Date)
        {
        }
        field(8001902; "Next Invoice Time"; DateFormula)
        {
        }
        field(8001903; "Next Invoice Date"; Date)
        {
        }
        field(8001904; "Source Invoice No."; Code[20])
        {
        }
        field(8003900; "Closing No."; Integer)
        {
        }
        field(8003901; "Scheduler Origin"; Boolean)
        {
        }
        field(8003902; "Order Type"; Option)
        {
            OptionMembers = ,"Internal Order",Transfer;
        }
        field(8003903; "Rider to Order No."; Code[20])
        {
        }
        field(8003905; Subject; Text[50])
        {
        }
        field(8003906; "Invoicing Method"; Option)
        {
            OptionMembers = Direct,Scheduler,Completion;
        }
        field(8003907; "Revision % Submitted"; Integer)
        {
        }
        field(8003908; "Price Index Code"; Code[10])
        {
        }
        field(8003909; "Index Basis Date"; Date)
        {
        }
        field(8003910; Application; Option)
        {
            OptionMembers = "Every Invoice","Final Invoice";
        }
        field(8003911; "Recognition Method"; Option)
        {
            OptionMembers = "Percentage of Completion","Completed Contract";
        }
        field(8003912; "Person Responsible"; Code[20])
        {
        }
        field(8003913; "Project Manager"; Code[20])
        {
        }
        field(8003914; "Completely Invoiced"; Boolean)
        {
        }
        field(8003915; "Amount Excl. VAT (LCY)"; Decimal)
        {
        }
        field(8003916; "Ship-to Phone No."; Text[30])
        {
        }
        field(8003917; "Ship-to Fax No."; Text[30])
        {
        }
        field(8003918; "Source Quote Occurence No."; Integer)
        {
        }
        field(8003919; "Source Quote Version No."; Integer)
        {
        }
        field(8003920; "Sell-to Contact Company No."; Code[20])
        {
        }
        field(8003921; "Ship-to Contact No."; Code[20])
        {
        }
        field(8003922; "Job Description"; Text[50])
        {
        }
        field(8003924; "Part Payment"; Decimal)
        {
        }
        field(8003925; "Contract Type"; Code[10])
        {
        }
        field(8003926; Finished; Boolean)
        {
        }
        field(8003947; "Person Responsible 2"; Code[20])
        {
        }
        field(8003948; "Person Responsible 3"; Code[20])
        {
        }
        field(8003949; "Person Responsible 4"; Code[20])
        {
        }
        field(8003950; "Person Responsible 5"; Code[20])
        {
        }
        field(8003956; "Free Field 1"; Code[20])
        {
        }
        field(8003957; "Free Field 2"; Code[20])
        {
        }
        field(8003958; "Free Field 3"; Code[20])
        {
        }
        field(8003959; "Free Field 4"; Code[20])
        {
        }
        field(8003960; "Free Field 5"; Code[20])
        {
        }
        field(8003961; "Free Field 6"; Code[20])
        {
        }
        field(8003962; "Free Field 7"; Code[20])
        {
        }
        field(8003963; "Free Field 8"; Code[20])
        {
        }
        field(8003964; "Free Field 9"; Code[20])
        {
        }
        field(8003965; "Free Field 10"; Code[20])
        {
        }
        field(8003966; "Free Date 1"; Date)
        {
        }
        field(8003967; "Free Date 2"; Date)
        {
        }
        field(8003968; "Free Date 3"; Date)
        {
        }
        field(8003969; "Free Date 4"; Date)
        {
        }
        field(8003970; "Free Date 5"; Date)
        {
        }
        field(8003971; "Free Date 6"; Date)
        {
        }
        field(8003972; "Free Date 7"; Date)
        {
        }
        field(8003973; "Free Date 8"; Date)
        {
        }
        field(8003974; "Free Date 9"; Date)
        {
        }
        field(8003975; "Free Date 10"; Date)
        {
        }
        field(8003976; "Free Value 1"; Decimal)
        {
        }
        field(8003977; "Free Value 2"; Decimal)
        {
        }
        field(8003978; "Free Value 3"; Decimal)
        {
        }
        field(8003979; "Free Value 4"; Decimal)
        {
        }
        field(8003980; "Free Value 5"; Decimal)
        {
        }
        field(8003981; "Free Boolean 1"; Boolean)
        {
        }
        field(8003982; "Free Boolean 2"; Boolean)
        {
        }
        field(8003983; "Free Boolean 3"; Boolean)
        {
        }
        field(8003984; "Free Boolean 4"; Boolean)
        {
        }
        field(8003985; "Free Boolean 5"; Boolean)
        {
        }
        field(8003986; "Progress Degree"; Code[10])
        {
        }
        field(8003988; "Job Starting Date"; Date)
        {
        }
        field(8003989; "Job Ending Date"; Date)
        {
        }
        field(8003990; "Transfer Job No."; Code[20])
        {
        }
        field(8004050; "Deadline Code"; Code[10])
        {
        }
        field(8004051; "Deadline Date"; Date)
        {
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
        }
        field(8004132; "Gen. Prod Posting Group Filter"; Code[10])
        {
        }
        field(8004133; "Planning Quantity"; Decimal)
        {
        }
        field(99008500; "Date Received"; Date)
        {
        }
        field(99008501; "Time Received"; Time)
        {
        }
        field(99008502; "BizTalk Request for Sales Qte."; Boolean)
        {
        }
        field(99008503; "BizTalk Sales Order"; Boolean)
        {
        }
        field(99008509; "Date Sent"; Date)
        {
        }
        field(99008510; "Time Sent"; Time)
        {
        }
        field(99008513; "BizTalk Sales Quote"; Boolean)
        {
        }
        field(99008514; "BizTalk Sales Order Cnfmn."; Boolean)
        {
        }
        field(99008518; "Customer Quote No."; Code[20])
        {
        }
        field(99008519; "Customer Order No."; Code[20])
        {
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

