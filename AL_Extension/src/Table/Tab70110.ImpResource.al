Table 70110 "Imp Resource"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Type; Option)
        {
            OptionMembers = Person,Machine,Structure;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; "Search Name"; Code[50])
        {
        }
        field(5; "Name 2"; Text[50])
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
        field(9; "Social Security No."; Text[30])
        {
        }
        field(10; "Job Title"; Text[30])
        {
        }
        field(11; Education; Text[30])
        {
        }
        field(12; "Contract Class"; Text[30])
        {
        }
        field(13; "Employment Date"; Date)
        {
        }
        field(14; "Resource Group No."; Code[20])
        {
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(18; "Base Unit of Measure"; Code[10])
        {
        }
        field(19; "Direct Unit Cost"; Decimal)
        {
        }
        field(20; "Indirect Cost %"; Decimal)
        {
        }
        field(21; "Unit Cost"; Decimal)
        {
        }
        field(22; "Profit %"; Decimal)
        {
        }
        field(23; "Price/Profit Calculation"; Option)
        {
            OptionMembers = "Profit=Price-Cost","Price=Cost+Profit","No Relationship";
        }
        field(24; "Unit Price"; Decimal)
        {
        }
        field(25; "Vendor No."; Code[20])
        {
        }
        field(26; "Last Date Modified"; Date)
        {
        }
        field(27; Comment; Boolean)
        {
        }
        field(38; Blocked; Boolean)
        {
        }
        field(39; "Date Filter"; Date)
        {
        }
        field(40; "Unit of Measure Filter"; Code[10])
        {
        }
        field(41; Capacity; Decimal)
        {
        }
        field(42; "Qty. on Order (Job)"; Decimal)
        {
        }
        field(43; "Qty. Quoted (Job)"; Decimal)
        {
        }
        field(44; "Usage (Qty.)"; Decimal)
        {
        }
        field(45; "Usage (Cost)"; Decimal)
        {
        }
        field(46; "Usage (Price)"; Decimal)
        {
        }
        field(47; "Sales (Qty.)"; Decimal)
        {
        }
        field(48; "Sales (Cost)"; Decimal)
        {
        }
        field(49; "Sales (Price)"; Decimal)
        {
        }
        field(50; "Chargeable Filter"; Boolean)
        {
        }
        field(51; "Gen. Prod. Posting Group"; Code[10])
        {
        }
        field(52; Picture; Blob)
        {
        }
        field(53; "Post Code"; Code[20])
        {
        }
        field(54; County; Text[30])
        {
        }
        field(55; "Automatic Ext. Texts"; Boolean)
        {
        }
        field(56; "No. Series"; Code[10])
        {
        }
        field(57; "Tax Group Code"; Code[10])
        {
        }
        field(58; "VAT Prod. Posting Group"; Code[10])
        {
        }
        field(59; "Country Code"; Code[10])
        {
        }
        field(60; "IC Partner Purch. G/L Acc. No."; Code[20])
        {
        }
        field(5900; "Qty. on Service Order"; Decimal)
        {
        }
        field(5901; "Service Zone Filter"; Code[10])
        {
        }
        field(5902; "In Customer Zone"; Boolean)
        {
        }
        field(73754; Replication; Boolean)
        {
        }
        field(82750; "Mask Code"; Code[10])
        {
        }
        field(8001428; Template; Code[10])
        {
        }
        field(8003900; "Bal. Job No."; Code[20])
        {
        }
        field(8003901; "Work Type Code"; Code[10])
        {
        }
        field(8003902; "Working Time"; Decimal)
        {
        }
        field(8003903; "Job No. Filter"; Code[20])
        {
        }
        field(8003907; "Work Type Filter"; Code[10])
        {
        }
        field(8003908; "Journal Template Name Filter"; Code[10])
        {
        }
        field(8003909; "Journal Batch Name Filter"; Code[10])
        {
        }
        field(8003910; "Able to Route"; Boolean)
        {
        }
        field(8003911; "User ID"; Code[20])
        {
        }
        field(8003912; "WT Allowed"; Boolean)
        {
        }
        field(8003929; "Tree Code"; Text[20])
        {
        }
        field(8003943; "Starting Date Filter"; Date)
        {
        }
        field(8003944; "Ending Date Filter"; Date)
        {
        }
        field(8003945; "In Mission"; Boolean)
        {
        }
        field(8003946; Skill; Boolean)
        {
        }
        field(8003947; "Skill Filter"; Code[20])
        {
        }
        field(8003948; Status; Option)
        {
            OptionMembers = Internal,External,Generic;
        }
        field(8003949; "Responsible Code"; Code[20])
        {
        }
        field(8003950; Rate; Decimal)
        {
        }
        field(8003951; "Unit price Calculated"; Decimal)
        {
        }
        field(8003952; "Default Rate Quantity"; Decimal)
        {
        }
        field(8003953; "Default Number Of Resources"; Integer)
        {
        }
        field(8004130; "Period Planning Quantity"; Decimal)
        {
        }
        field(8004132; "Prod. Posting Group Filter"; Code[10])
        {
        }
        field(8004150; Subcontracting; Option)
        {
            OptionMembers = ,"Furniture and Fixing",Fixing;
        }
        field(8004154; "Assignment Basis"; Option)
        {
            OptionMembers = ,"Person Quantity","Direct Cost","Cost Price","Estimated Price",Specific;
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

