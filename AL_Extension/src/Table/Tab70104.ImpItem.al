Table 70104 "Imp Item"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "No. 2"; Code[20])
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Search Description"; Code[50])
        {
        }
        field(5; "Description 2"; Text[50])
        {
        }
        field(6; "Bill of Materials"; Boolean)
        {
        }
        field(7; Class; Code[10])
        {
        }
        field(8; "Base Unit of Measure"; Code[10])
        {
        }
        field(9; "Price Unit Conversion"; Integer)
        {
        }
        field(11; "Inventory Posting Group"; Code[10])
        {
        }
        field(12; "Shelf No."; Code[10])
        {
        }
        field(14; "Item Disc. Group"; Code[10])
        {
        }
        field(15; "Allow Invoice Disc."; Boolean)
        {
        }
        field(16; "Statistics Group"; Integer)
        {
        }
        field(17; "Commission Group"; Integer)
        {
        }
        field(18; "Unit Price"; Decimal)
        {
        }
        field(19; "Price/Profit Calculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(20; "Profit %"; Decimal)
        {
        }
        field(21; "Costing Method"; Option)
        {
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(22; "Unit Cost"; Decimal)
        {
        }
        field(24; "Standard Cost"; Decimal)
        {
        }
        field(25; "Last Direct Cost"; Decimal)
        {
        }
        field(28; "Indirect Cost %"; Decimal)
        {
        }
        field(29; "Cost is Adjusted"; Boolean)
        {
        }
        field(30; "Allow Online Adjustment"; Boolean)
        {
        }
        field(31; "Vendor No."; Code[20])
        {
        }
        field(32; "Vendor Item No."; Text[20])
        {
        }
        field(33; "Lead Time Calculation"; DateFormula)
        {
        }
        field(34; "Reorder Point"; Decimal)
        {
        }
        field(35; "Maximum Inventory"; Decimal)
        {
        }
        field(36; "Reorder Quantity"; Decimal)
        {
        }
        field(37; "Alternative Item No."; Code[20])
        {
        }
        field(38; "Unit List Price"; Decimal)
        {
        }
        field(39; "Duty Due %"; Decimal)
        {
        }
        field(40; "Duty Code"; Code[10])
        {
        }
        field(41; "Gross Weight"; Decimal)
        {
        }
        field(42; "Net Weight"; Decimal)
        {
        }
        field(43; "Units per Parcel"; Decimal)
        {
        }
        field(44; "Unit Volume"; Decimal)
        {
        }
        field(45; Durability; Code[10])
        {
        }
        field(46; "Freight Type"; Code[10])
        {
        }
        field(47; "Tariff No."; Code[10])
        {
        }
        field(48; "Duty Unit Conversion"; Decimal)
        {
        }
        field(49; "Country Purchased Code"; Code[10])
        {
        }
        field(50; "Budget Quantity"; Decimal)
        {
        }
        field(51; "Budgeted Amount"; Decimal)
        {
        }
        field(52; "Budget Profit"; Decimal)
        {
        }
        field(53; Comment; Boolean)
        {
        }
        field(54; Blocked; Boolean)
        {
        }
        field(62; "Last Date Modified"; Date)
        {
        }
        field(64; "Date Filter"; Date)
        {
        }
        field(65; "Global Dimension 1 Filter"; Code[20])
        {
        }
        field(66; "Global Dimension 2 Filter"; Code[20])
        {
        }
        field(67; "Location Filter"; Code[10])
        {
        }
        field(68; Inventory; Decimal)
        {
        }
        field(69; "Net Invoiced Qty."; Decimal)
        {
        }
        field(70; "Net Change"; Decimal)
        {
        }
        field(71; "Purchases (Qty.)"; Decimal)
        {
        }
        field(72; "Sales (Qty.)"; Decimal)
        {
        }
        field(73; "Positive Adjmt. (Qty.)"; Decimal)
        {
        }
        field(74; "Negative Adjmt. (Qty.)"; Decimal)
        {
        }
        field(77; "Purchases (LCY)"; Decimal)
        {
        }
        field(78; "Sales (LCY)"; Decimal)
        {
        }
        field(79; "Positive Adjmt. (LCY)"; Decimal)
        {
        }
        field(80; "Negative Adjmt. (LCY)"; Decimal)
        {
        }
        field(83; "COGS (LCY)"; Decimal)
        {
        }
        field(84; "Qty. on Purch. Order"; Decimal)
        {
        }
        field(85; "Qty. on Sales Order"; Decimal)
        {
        }
        field(87; "Price Includes VAT"; Boolean)
        {
        }
        field(89; "Drop Shipment Filter"; Boolean)
        {
        }
        field(90; "VAT Bus. Posting Gr. (Price)"; Code[10])
        {
        }
        field(91; "Gen. Prod. Posting Group"; Code[10])
        {
        }
        field(92; Picture; Blob)
        {
        }
        field(93; "Transferred (Qty.)"; Decimal)
        {
        }
        field(94; "Transferred (LCY)"; Decimal)
        {
        }
        field(95; "Country of Origin Code"; Code[10])
        {
        }
        field(96; "Automatic Ext. Texts"; Boolean)
        {
        }
        field(97; "No. Series"; Code[10])
        {
        }
        field(98; "Tax Group Code"; Code[10])
        {
        }
        field(99; "VAT Prod. Posting Group"; Code[10])
        {
        }
        field(100; Reserve; Option)
        {
            OptionMembers = Never,Optional,Always;
        }
        field(101; "Reserved Qty. on Inventory"; Decimal)
        {
        }
        field(102; "Reserved Qty. on Purch. Orders"; Decimal)
        {
        }
        field(103; "Reserved Qty. on Sales Orders"; Decimal)
        {
        }
        field(105; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(106; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(107; "Res. Qty. on Outbound Transfer"; Decimal)
        {
        }
        field(108; "Res. Qty. on Inbound Transfer"; Decimal)
        {
        }
        field(5400; "Low-Level Code"; Integer)
        {
        }
        field(5401; "Lot Size"; Decimal)
        {
        }
        field(5402; "Serial Nos."; Code[10])
        {
        }
        field(5403; "Last Unit Cost Calc. Date"; Date)
        {
        }
        field(5404; "Rolled-up Material Cost"; Decimal)
        {
        }
        field(5405; "Rolled-up Capacity Cost"; Decimal)
        {
        }
        field(5407; "Scrap %"; Decimal)
        {
        }
        field(5409; "Inventory Value Zero"; Boolean)
        {
        }
        field(5410; "Discrete Order Quantity"; Integer)
        {
        }
        field(5411; "Minimum Order Quantity"; Decimal)
        {
        }
        field(5412; "Maximum Order Quantity"; Decimal)
        {
        }
        field(5413; "Safety Stock Quantity"; Decimal)
        {
        }
        field(5414; "Order Multiple"; Decimal)
        {
        }
        field(5415; "Safety Lead Time"; DateFormula)
        {
        }
        field(5417; "Flushing Method"; Option)
        {
            OptionMembers = Manual,Forward,Backward,"Pick + Forward","Pick + Backward";
        }
        field(5419; "Replenishment System"; Option)
        {
            OptionMembers = Purchase,"Prod. Order";
        }
        field(5420; "Scheduled Receipt (Qty.)"; Decimal)
        {
        }
        field(5421; "Scheduled Need (Qty.)"; Decimal)
        {
        }
        field(5422; "Rounding Precision"; Decimal)
        {
        }
        field(5423; "Bin Filter"; Code[20])
        {
        }
        field(5424; "Variant Filter"; Code[10])
        {
        }
        field(5425; "Sales Unit of Measure"; Code[10])
        {
        }
        field(5426; "Purch. Unit of Measure"; Code[10])
        {
        }
        field(5428; "Reorder Cycle"; DateFormula)
        {
        }
        field(5429; "Reserved Qty. on Prod. Order"; Decimal)
        {
        }
        field(5430; "Res. Qty. on Prod. Order Comp."; Decimal)
        {
        }
        field(5431; "Res. Qty. on Req. Line"; Decimal)
        {
        }
        field(5440; "Reordering Policy"; Option)
        {
            OptionMembers = ,"Fixed Reorder Qty.","Maximum Qty.","Order","Lot-for-Lot";
        }
        field(5441; "Include Inventory"; Boolean)
        {
        }
        field(5442; "Manufacturing Policy"; Option)
        {
            OptionMembers = "Make-to-Stock","Make-to-Order";
        }
        field(5700; "Stockkeeping Unit Exists"; Boolean)
        {
        }
        field(5701; "Manufacturer Code"; Code[10])
        {
        }
        field(5702; "Item Category Code"; Code[10])
        {
        }
        field(5703; "Created From Nonstock Item"; Boolean)
        {
        }
        field(5704; "Product Group Code"; Code[10])
        {
        }
        field(5706; "Substitutes Exist"; Boolean)
        {
        }
        field(5707; "Qty. in Transit"; Decimal)
        {
        }
        field(5708; "Trans. Ord. Receipt (Qty.)"; Decimal)
        {
        }
        field(5709; "Trans. Ord. Shipment (Qty.)"; Decimal)
        {
        }
        field(5776; "Qty. Assigned to ship"; Decimal)
        {
        }
        field(5777; "Qty. Picked"; Decimal)
        {
        }
        field(5900; "Service Item Group"; Code[10])
        {
        }
        field(5901; "Qty. on Service Order"; Decimal)
        {
        }
        field(5902; "Res. Qty. on Service Orders"; Decimal)
        {
        }
        field(6202; "Picture No."; Code[20])
        {
        }
        field(6500; "Item Tracking Code"; Code[10])
        {
        }
        field(6501; "Lot Nos."; Code[10])
        {
        }
        field(6502; "Expiration Calculation"; DateFormula)
        {
        }
        field(6503; "Lot No. Filter"; Code[20])
        {
        }
        field(6504; "Serial No. Filter"; Code[20])
        {
        }
        field(7171; "No. of Substitutes"; Integer)
        {
        }
        field(7301; "Special Equipment Code"; Code[10])
        {
        }
        field(7302; "Put-away Template Code"; Code[10])
        {
        }
        field(7307; "Put-away Unit of Measure Code"; Code[10])
        {
        }
        field(7380; "Phys Invt Counting Period Code"; Code[10])
        {
        }
        field(7381; "Last Counting Period Update"; Date)
        {
        }
        field(7382; "Next Counting Period"; Text[250])
        {
        }
        field(7383; "Last Phys. Invt. Date"; Date)
        {
        }
        field(7384; "Use Cross-Docking"; Boolean)
        {
        }
        field(7700; "Identifier Code"; Code[20])
        {
        }
        field(73754; Replication; Boolean)
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
        field(8001428; Template; Code[10])
        {
        }
        field(8001801; "Gen. Prod. Post. Group Tax 1"; Code[10])
        {
        }
        field(8001802; "Gen. Prod. Post. Group Tax 2"; Code[10])
        {
        }
        field(8001803; "Gen. Prod. Post. Group Tax 3"; Code[10])
        {
        }
        field(8001804; "Gen. Prod. Post. Group Tax 4"; Code[10])
        {
        }
        field(8001805; "Gen. Prod. Post. Group Tax 5"; Code[10])
        {
        }
        field(8003900; "Purchasing Code"; Code[10])
        {
        }
        field(8003901; "Job No. Filter"; Code[20])
        {
        }
        field(8003902; "Best Discount"; Decimal)
        {
        }
        field(8003904; "Best Register Cost"; Decimal)
        {
        }
        field(8003905; "Charasteristic 1"; Text[20])
        {
        }
        field(8003906; "Charasteristic 2"; Text[20])
        {
        }
        field(8003907; "Charasteristic 3"; Text[20])
        {
        }
        field(8003908; "Charasteristic 4"; Text[20])
        {
        }
        field(8003909; "Charasteristic 5"; Text[20])
        {
        }
        field(8003910; "Charasteristic 6"; Text[20])
        {
        }
        field(8003911; "Charasteristic 7"; Text[20])
        {
        }
        field(8003912; "Charasteristic 8"; Text[20])
        {
        }
        field(8003913; "Charasteristic 9"; Text[20])
        {
        }
        field(8003915; "Item Type"; Option)
        {
            OptionMembers = ,Specific,Generic;
        }
        field(8003916; "Public Price"; Decimal)
        {
        }
        field(8003929; "Tree Code"; Text[20])
        {
        }
        field(8003930; "Qty. on Purchase Quote"; Decimal)
        {
        }
        field(8003931; "Default Qty Value 1"; Decimal)
        {
        }
        field(8003932; "Default Qty Value 2"; Decimal)
        {
        }
        field(8003933; "Default Qty Value 3"; Decimal)
        {
        }
        field(8003934; "Default Qty Value 4"; Decimal)
        {
        }
        field(8003935; "Default Qty Value 5"; Decimal)
        {
        }
        field(8003936; "Default Qty Value 6"; Decimal)
        {
        }
        field(8003937; "Default Qty Value 7"; Decimal)
        {
        }
        field(8003938; "Default Qty Value 8"; Decimal)
        {
        }
        field(8003939; "Default Qty Value 9"; Decimal)
        {
        }
        field(8003940; "Default Qty Value 10"; Decimal)
        {
        }
        field(8003950; "Invoicing Unit"; Code[10])
        {
        }
        field(8003951; "Qty. Per Invoicing Unit"; Decimal)
        {
        }
        field(8003952; "Tariff Article"; Code[20])
        {
        }
        field(8004150; Subcontracting; Option)
        {
            OptionMembers = ,"Furniture and Fixing",Fixing;
        }
        field(99000750; "Routing No."; Code[20])
        {
        }
        field(99000751; "Production BOM No."; Code[20])
        {
        }
        field(99000752; "Single-Level Material Cost"; Decimal)
        {
        }
        field(99000753; "Single-Level Capacity Cost"; Decimal)
        {
        }
        field(99000754; "Single-Level Subcontrd. Cost"; Decimal)
        {
        }
        field(99000755; "Single-Level Cap. Ovhd Cost"; Decimal)
        {
        }
        field(99000756; "Single-Level Mfg. Ovhd Cost"; Decimal)
        {
        }
        field(99000757; "Overhead Rate"; Decimal)
        {
        }
        field(99000758; "Rolled-up Subcontracted Cost"; Decimal)
        {
        }
        field(99000759; "Rolled-up Mfg. Ovhd Cost"; Decimal)
        {
        }
        field(99000760; "Rolled-up Cap. Overhead Cost"; Decimal)
        {
        }
        field(99000761; "Planning Issues (Qty.)"; Decimal)
        {
        }
        field(99000762; "Planning Receipt (Qty.)"; Decimal)
        {
        }
        field(99000765; "Planned Order Receipt (Qty.)"; Decimal)
        {
        }
        field(99000766; "FP Order Receipt (Qty.)"; Decimal)
        {
        }
        field(99000767; "Rel. Order Receipt (Qty.)"; Decimal)
        {
        }
        field(99000768; "Planning Release (Qty.)"; Decimal)
        {
        }
        field(99000769; "Planned Order Release (Qty.)"; Decimal)
        {
        }
        field(99000770; "Purch. Req. Receipt (Qty.)"; Decimal)
        {
        }
        field(99000771; "Purch. Req. Release (Qty.)"; Decimal)
        {
        }
        field(99000773; "Order Tracking Policy"; Option)
        {
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(99000774; "Prod. Forecast Quantity (Base)"; Decimal)
        {
        }
        field(99000775; "Production Forecast Name"; Code[10])
        {
        }
        field(99000776; "Component Forecast"; Boolean)
        {
        }
        field(99000777; "Qty. on Prod. Order"; Decimal)
        {
        }
        field(99000778; "Qty. on Component Lines"; Decimal)
        {
        }
        field(99000875; Critical; Boolean)
        {
        }
        field(99008500; "Common Item No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

