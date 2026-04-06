Table 70106 "Imp Sales Line"
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
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Line No."; Integer)
        {
        }
        field(5; Type; Option)
        {
            OptionMembers = ,"G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
        }
        field(7; "Location Code"; Code[10])
        {
        }
        field(8; "Posting Group"; Code[10])
        {
        }
        field(10; "Shipment Date"; Date)
        {
        }
        field(11; Description; Text[50])
        {
        }
        field(12; "Description 2"; Text[50])
        {
        }
        field(13; "Unit of Measure"; Text[10])
        {
        }
        field(15; Quantity; Decimal)
        {
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
        }
        field(18; "Qty. to Ship"; Decimal)
        {
        }
        field(22; "Unit Price"; Decimal)
        {
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
        }
        field(25; "VAT %"; Decimal)
        {
        }
        field(27; "Line Discount %"; Decimal)
        {
        }
        field(28; "Line Discount Amount"; Decimal)
        {
        }
        field(29; Amount; Decimal)
        {
        }
        field(30; "Amount Including VAT"; Decimal)
        {
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
        }
        field(34; "Gross Weight"; Decimal)
        {
        }
        field(35; "Net Weight"; Decimal)
        {
        }
        field(36; "Units per Parcel"; Decimal)
        {
        }
        field(37; "Unit Volume"; Decimal)
        {
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
        }
        field(42; "Customer Price Group"; Code[10])
        {
        }
        field(45; "Job No."; Code[20])
        {
        }
        field(46; "Appl.-to Job Entry"; Integer)
        {
        }
        field(47; "Phase Code"; Code[10])
        {
        }
        field(50; "Job Applies-to ID"; Code[20])
        {
        }
        field(51; "Apply and Close (Job)"; Boolean)
        {
        }
        field(52; "Work Type Code"; Code[10])
        {
        }
        field(57; "Outstanding Amount"; Decimal)
        {
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
        }
        field(60; "Quantity Shipped"; Decimal)
        {
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
        }
        field(63; "Shipment No."; Code[20])
        {
        }
        field(64; "Shipment Line No."; Integer)
        {
        }
        field(67; "Profit %"; Decimal)
        {
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
        }
        field(71; "Purchase Order No."; Code[20])
        {
        }
        field(72; "Purch. Order Line No."; Integer)
        {
        }
        field(73; "Drop Shipment"; Boolean)
        {
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
        }
        field(77; "VAT Calculation Type"; Option)
        {
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
        }
        field(79; "Transport Method"; Code[10])
        {
        }
        field(80; "Attached to Line No."; Integer)
        {
        }
        field(81; "Exit Point"; Code[10])
        {
        }
        field(82; "Area"; Code[10])
        {
        }
        field(83; "Transaction Specification"; Code[10])
        {
        }
        field(85; "Tax Area Code"; Code[20])
        {
        }
        field(86; "Tax Liable"; Boolean)
        {
        }
        field(87; "Tax Group Code"; Code[10])
        {
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
        }
        field(91; "Currency Code"; Code[10])
        {
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
        }
        field(95; "Reserved Quantity"; Decimal)
        {
        }
        field(96; Reserve; Option)
        {
            OptionMembers = Never,Optional,Always;
        }
        field(97; "Blanket Order No."; Code[20])
        {
        }
        field(98; "Blanket Order Line No."; Integer)
        {
        }
        field(99; "VAT Base Amount"; Decimal)
        {
        }
        field(100; "Unit Cost"; Decimal)
        {
        }
        field(101; "System-Created Entry"; Boolean)
        {
        }
        field(103; "Line Amount"; Decimal)
        {
        }
        field(104; "VAT Difference"; Decimal)
        {
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
        }
        field(106; "VAT Identifier"; Code[10])
        {
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            OptionMembers = ,"G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
        }
        field(5402; "Variant Code"; Code[10])
        {
        }
        field(5403; "Bin Code"; Code[20])
        {
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
        }
        field(5405; Planned; Boolean)
        {
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
        }
        field(5600; "FA Posting Date"; Date)
        {
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
        }
        field(5613; "Use Duplication List"; Boolean)
        {
        }
        field(5700; "Responsibility Center"; Code[10])
        {
        }
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
        }
        field(5702; "Substitution Available"; Boolean)
        {
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            OptionMembers = ,Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
        }
        field(5709; "Item Category Code"; Code[10])
        {
        }
        field(5710; Nonstock; Boolean)
        {
        }
        field(5711; "Purchasing Code"; Code[10])
        {
        }
        field(5712; "Product Group Code"; Code[10])
        {
        }
        field(5713; "Special Order"; Boolean)
        {
        }
        field(5714; "Special Order Purchase No."; Code[20])
        {
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
        }
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
        }
        field(5752; "Completely Shipped"; Boolean)
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
        field(5794; "Planned Delivery Date"; Date)
        {
        }
        field(5795; "Planned Shipment Date"; Date)
        {
        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
        }
        field(5801; "Qty. to Assign"; Decimal)
        {
        }
        field(5802; "Qty. Assigned"; Decimal)
        {
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
        }
        field(5807; "Return Rcd. Not Invd."; Decimal)
        {
        }
        field(5808; "Return Rcd. Not Invd. (LCY)"; Decimal)
        {
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
        }
        field(5900; "Service Contract No."; Code[20])
        {
        }
        field(5901; "Service Order No."; Code[20])
        {
        }
        field(5902; "Service Item No."; Code[20])
        {
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
        }
        field(5904; "Service Item Line No."; Integer)
        {
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
        }
        field(5909; "BOM Item No."; Code[20])
        {
        }
        field(6600; "Return Receipt No."; Code[20])
        {
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
        }
        field(6608; "Return Reason Code"; Code[10])
        {
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
        }
        field(8001400; Separator; Integer)
        {
        }
        field(8001401; "Lot No."; Code[20])
        {
        }
        field(8001402; "Serial No."; Code[20])
        {
        }
        field(8001403; "Expiration Date"; Date)
        {
        }
        field(8001500; "Rule Discount Line Amount"; Decimal)
        {
        }
        field(8001501; "Disc. Commission Type Filter"; Option)
        {
            OptionMembers = "Line Discount","Footer Discount","Back Discount",Commission;
        }
        field(8001502; "Disc. Commission Rule Filter"; Code[20])
        {
        }
        field(8001503; "Calculated Discount Amount"; Decimal)
        {
        }
        field(8001805; "Unit Amount Tax 1"; Decimal)
        {
        }
        field(8001806; "Unit Amount Tax 2"; Decimal)
        {
        }
        field(8001807; "Unit Amount Tax 3"; Decimal)
        {
        }
        field(8001808; "Unit Amount Tax 4"; Decimal)
        {
        }
        field(8001809; "Unit Amount Tax 5"; Decimal)
        {
        }
        field(8001810; "Amount Tax 1"; Decimal)
        {
        }
        field(8001811; "Amount Tax 2"; Decimal)
        {
        }
        field(8001812; "Amount Tax 3"; Decimal)
        {
        }
        field(8001813; "Amount Tax 4"; Decimal)
        {
        }
        field(8001814; "Amount Tax 5"; Decimal)
        {
        }
        field(8001815; "VAT Tax Amount"; Decimal)
        {
        }
        field(8001840; "Gen. Bus. Post. Group Tax 1"; Code[10])
        {
        }
        field(8001841; "Gen. Prod. Post. Group Tax 1"; Code[10])
        {
        }
        field(8001842; "Gen. Bus. Post. Group Tax 2"; Code[10])
        {
        }
        field(8001843; "Gen. Prod. Post. Group Tax 2"; Code[10])
        {
        }
        field(8001844; "Gen. Bus. Post. Group Tax 3"; Code[10])
        {
        }
        field(8001845; "Gen. Prod. Post. Group Tax 3"; Code[10])
        {
        }
        field(8001846; "Gen. Bus. Post. Group Tax 4"; Code[10])
        {
        }
        field(8001847; "Gen. Prod. Post. Group Tax 4"; Code[10])
        {
        }
        field(8001848; "Gen. Bus. Post. Group Tax 5"; Code[10])
        {
        }
        field(8001849; "Gen. Prod. Post. Group Tax 5"; Code[10])
        {
        }
        field(8003900; "Completion Amount"; Decimal)
        {
        }
        field(8003901; "Previous Completion %"; Decimal)
        {
        }
        field(8003902; "New Completion %"; Decimal)
        {
        }
        field(8003903; "Scheduler Line No."; Integer)
        {
        }
        field(8003904; "Previous Prod. Completion %"; Decimal)
        {
        }
        field(8003907; "Outstanding Amt Excl VAT(LCY)"; Decimal)
        {
        }
        field(8003908; "Order Type"; Option)
        {
            OptionMembers = ,"Internal Order",Transfer;
        }
        field(8003909; "Rider No."; Code[20])
        {
        }
        field(8003910; "Completely Invoiced"; Boolean)
        {
        }
        field(8003911; "Imported Line"; Boolean)
        {
        }
        field(8003912; "Internal Description"; Text[50])
        {
        }
        field(8003913; "Excel Line No."; Integer)
        {
        }
        field(8003915; "Cross-Ref. Line No."; Integer)
        {
        }
        field(8003916; Marker; Code[20])
        {
        }
        field(8003943; "Purchasing Document Type"; Option)
        {
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8003945; "Purchasing Order No."; Code[20])
        {
        }
        field(8003946; "Purchasing Order Line No."; Integer)
        {
        }
        field(8003947; "Purch. Order Qty (Base)"; Decimal)
        {
        }
        field(8003948; "Purch. Order Receipt Date"; Date)
        {
        }
        field(8003949; "Purch. Order Rcpt. Qty (Base)"; Decimal)
        {
        }
        field(8003950; Option; Boolean)
        {
        }
        field(8003951; "Assignment Basis"; Option)
        {
            OptionMembers = ,"Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific;
        }
        field(8003952; "Assignment Method"; Option)
        {
            OptionMembers = ,All,Totaling,Selection,"No Subcontracting",Subcontracting;
        }
        field(8003953; "Job Cost Assignment"; Code[10])
        {
        }
        field(8003980; Tantieme; Integer)
        {
        }
        field(8003981; "Order No."; Code[20])
        {
        }
        field(8003982; "Order Line No."; Integer)
        {
        }
        field(8003983; "Amount Excl. VAT (LCY)"; Decimal)
        {
        }
        field(8003984; "WIP Amount Posted"; Decimal)
        {
        }
        field(8003985; "Global Disc. Amount"; Decimal)
        {
        }
        field(8003986; "Vendor Order Address Code"; Code[10])
        {
        }
        field(8004048; "Number of Resources"; Decimal)
        {
        }
        field(8004049; "Rate Quantity"; Decimal)
        {
        }
        field(8004050; "Line Type"; Option)
        {
            OptionMembers = ,Totaling,Item,Person,Machine,Structure,"G/L Account","Charge (Item)";
        }
        field(8004052; "Structure Line No."; Integer)
        {
        }
        field(8004053; "Quantity per"; Decimal)
        {
        }
        field(8004054; "Found Price"; Decimal)
        {
        }
        field(8004055; "Quantity Fixed"; Decimal)
        {
        }
        field(8004056; "Presentation Code"; Text[24])
        {
        }
        field(8004057; Level; Integer)
        {
        }
        field(8004058; "Vendor No."; Code[20])
        {
        }
        field(8004059; "Total Cost (LCY)"; Decimal)
        {
        }
        field(8004060; "Internal Order No."; Code[20])
        {
        }
        field(8004061; "Internal Order Line No."; Integer)
        {
        }
        field(8004062; "Theoretical Profit Amount(LCY)"; Decimal)
        {
        }
        field(8004063; "Overhead Amount (LCY)"; Decimal)
        {
        }
        field(8004064; "Fixed Price"; Boolean)
        {
        }
        field(8004065; "Optionnal Quantity"; Decimal)
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
        field(8004076; Comment; Boolean)
        {
        }
        field(8004077; "Job Costs (LCY)"; Decimal)
        {
        }
        field(8004088; "Machine Quantity"; Decimal)
        {
        }
        field(8004089; "Person Quantity"; Decimal)
        {
        }
        field(8004090; "Print Option Line"; Option)
        {
            OptionMembers = ,"Page Skip";
        }
        field(8004091; "Total Cost LCY by Line Type"; Decimal)
        {
        }
        field(8004092; "Vendor Ledger Entry No."; Integer)
        {
        }
        field(8004093; "Print Structure Line"; Boolean)
        {
        }
        field(8004094; Rate; Decimal)
        {
        }
        field(8004095; Dummy; Text[30])
        {
        }
        field(8004096; "Need Qty"; Decimal)
        {
        }
        field(8004098; Duration; Decimal)
        {
        }
        field(8004100; "Bill of Quantities"; Boolean)
        {
        }
        field(8004101; "Field Filter"; Integer)
        {
        }
        field(8004102; Variables; Boolean)
        {
        }
        field(8004103; "Variables Not Defined"; Boolean)
        {
        }
        field(8004104; "Need Unit of Measure Code"; Code[10])
        {
        }
        field(8004106; "Item Type"; Option)
        {
            OptionMembers = ,Specific,Generic;
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
        }
        field(8004131; "Date Filter"; Date)
        {
        }
        field(8004132; "Gen. Prod Posting Group Filter"; Code[10])
        {
        }
        field(8004133; "Planning Quantity"; Decimal)
        {
        }
        field(8004134; Subcontracting; Option)
        {
            OptionMembers = ,"Furniture and Fixing",Fixing;
        }
        field(8004135; Disable; Boolean)
        {
        }
        field(8004136; "Disable Quantity"; Decimal)
        {
        }
        field(8004137; "Resource Group No."; Code[20])
        {
        }
        field(8004138; "Advanced Person Budget (Qty)"; Decimal)
        {
        }
        field(8004139; "Line Type Filter"; Option)
        {
            OptionMembers = ,Totaling,Item,Person,Machine,Structure,"G/L Account";
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

