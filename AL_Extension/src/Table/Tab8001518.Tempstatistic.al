Table 8001518 "Temp. statistic"
{
    //GL2024  ID dans Nav 2009 : "8001311"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Temp. statistic

    Caption = 'Temp. statistic';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Period Length"; Option)
        {
            Caption = 'Period Length';
            InitValue = Month;
            OptionCaption = 'Day,Week,Month,Quarter,Year,Period';
            OptionMembers = Day,Week,Month,Quarter,Year,Period;
        }
        field(3; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(4; "Entry Type"; Text[30])
        {
            Caption = 'Entry Type';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter(Flow));
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Account (G/L),Item,Resource,Employee,Resource Group';
            OptionMembers = "Account (G/L)",Item,Resource,Employee,"Resource Group";
        }
        field(6; "No."; Text[20])
        {
            Caption = 'No.';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(8; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item,Bank Account,Fixed Asset,Budget';
            OptionMembers = " ",Customer,Vendor,Item,"Bank Account","Fixed Asset",Budget;
        }
        field(9; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const(Item)) Item
            else
            if ("Source Type" = filter("Bank Account")) "Bank Account"
            else
            if ("Source Type" = filter("Fixed Asset")) "Fixed Asset"
            else
            if ("Source Type" = filter(Budget)) "G/L Budget Name";
        }
        field(11; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(12; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(13; "Source Posting Group"; Code[20])
        {
            Caption = 'Source Posting Group';
            TableRelation = if ("Source Type" = filter(Customer)) "Customer Posting Group"
            else
            if ("Source Type" = filter(Vendor)) "Vendor Posting Group"
            else
            if ("Source Type" = filter(Item)) "Inventory Posting Group"
            else
            if ("Source Type" = filter("Bank Account")) "Bank Account Posting Group"
            else
            if ("Source Type" = filter("Fixed Asset")) "FA Posting Group"
            else
            if ("Source Type" = filter(Budget)) "G/L Budget Name";
        }
        field(14; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(15; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(16; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';

            trigger OnLookup()
            begin
                DimManagement.LookupDimValueCode(1, "Global Dimension 1 Code");
            end;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';

            trigger OnLookup()
            begin
                DimManagement.LookupDimValueCode(2, "Global Dimension 2 Code");
            end;
        }
        field(19; "Country Code"; Code[20])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(21; Volume; Decimal)
        {
            Caption = 'Volume';
        }
        field(23; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(24; "Adjusted Cost (Invoiced Qty.)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Adjusted Cost (Invoiced Qty.)';
        }
        field(30; Year; Integer)
        {
            Caption = 'Year';
        }
        field(31; "Half Year"; Integer)
        {
            Caption = 'Half Year';
        }
        field(32; Quarter; Integer)
        {
            Caption = 'Quarter';
        }
        field(33; Month; Integer)
        {
            Caption = 'Month';
        }
        field(34; Week; Integer)
        {
            Caption = 'Week';
        }
        field(35; "Fiscal year closing date"; Date)
        {
            Caption = 'Fiscal year closing date';
        }
        field(36; "Week Day"; Integer)
        {
            Caption = 'Week Day';
        }
        field(37; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(38; "Consol. Debit Acc."; Code[20])
        {
            Caption = 'Consol. Debit Acc.';
        }
        field(39; "Consol. Credit Acc."; Code[20])
        {
            Caption = 'Consol. Credit Acc.';
        }
        field(40; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(41; "Job Task Code"; Code[20])
        {
            Caption = 'Job Task Code';
            TableRelation = "Job Task"."Job Task No.";
        }
        field(44; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(45; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
        }
        field(46; "Job Posting Group"; Code[10])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job Posting Group";
        }
        field(47; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";
        }
        field(48; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
        }
        field(57; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;

            trigger OnValidate()
            var
                TempDocDim: Record "Gen. Jnl. Dim. Filter" temporary;
            begin
            end;
        }
        field(60; "Item criteria 1"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99030';
            Caption = 'Item criteria 1';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(61; "Item criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99031';
            Caption = 'Item criteria 2';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(62; "Item criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99032';
            Caption = 'Item criteria 3';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(63; "Item criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99033';
            Caption = 'Item criteria 4';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(64; "Item criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99035';
            Caption = 'Item criteria 5';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(65; "Item criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99036';
            Caption = 'Item criteria 6';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(66; "Item criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99036';
            Caption = 'Item criteria 7';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(67; "Item criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99037';
            Caption = 'Item criteria 8';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(68; "Item criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99038';
            Caption = 'Item criteria 9';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69; "Item criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99039';
            Caption = 'Item criteria 10';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(70; "Customer criteria 1"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99003';
            Caption = 'Customer criteria 1';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(71; "Customer criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99004';
            Caption = 'Customer criteria 2';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(72; "Customer criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99005';
            Caption = 'Customer criteria 3';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(73; "Customer criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99006';
            Caption = 'Customer criteria 4';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(74; "Customer criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99007';
            Caption = 'Customer criteria 5';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(75; "Customer criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99008';
            Caption = 'Customer criteria 6';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(76; "Customer criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99009';
            Caption = 'Customer criteria 7';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(77; "Customer criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99010';
            Caption = 'Customer criteria 8';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(78; "Customer criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99011';
            Caption = 'Customer criteria 9';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(79; "Customer criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99012';
            Caption = 'Customer criteria 10';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(80; "Free value 1"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99041';
            Caption = 'Free value 1';
        }
        field(81; "Free value 2"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99042';
            Caption = 'Free value 2';
        }
        field(82; "Free value 3"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99043';
            Caption = 'Free value 3';
        }
        field(83; "Free value 4"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99044';
            Caption = 'Free value 4';
        }
        field(84; "Free value 5"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99045';
            Caption = 'Free value 5';
        }
        field(85; "Free value 6"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99046';
            Caption = 'Free value 6';
        }
        field(86; "Free value 7"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99047';
            Caption = 'Free value 7';
        }
        field(87; "Free value 8"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99048';
            Caption = 'Free value 8';
        }
        field(88; "Free value 9"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99049';
            Caption = 'Free value 9';
        }
        field(89; "Free value 10"; Decimal)
        {
            AutoFormatType = 1;
            //CaptionClass = '8001400,1,8001302,99050';
            Caption = 'Free value 10';
        }
        field(90; "Job criteria 1"; Code[20])
        {
            Caption = 'Job criteria 1';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001301));
        }
        field(91; "Job criteria 2"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99091';
            Caption = 'Job criteria 2';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Job criteria 3"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99092';
            Caption = 'Job criteria 3';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(93; "Job criteria 4"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99093';
            Caption = 'Job criteria 4';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(94; "Job criteria 5"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99094';
            Caption = 'Job criteria 5';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(95; "Job criteria 6"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99095';
            Caption = 'Job criteria 6';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(96; "Job criteria 7"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99096';
            Caption = 'Job criteria 7';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(97; "Job criteria 8"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99097';
            Caption = 'Job criteria 8';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(98; "Job criteria 9"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99098';
            Caption = 'Job criteria 9';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(99; "Job criteria 10"; Code[20])
        {
            //CaptionClass = '8001400,1,8001302,99099';
            Caption = 'Job criteria 10';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(100; "Lines discount total"; Decimal)
        {
            Caption = 'Lines discount total';
        }
        field(101; "Document discount total"; Decimal)
        {
            Caption = 'Document discount total';
        }
        field(102; "Back discount total"; Decimal)
        {
            Caption = 'Back discount total';
        }
        field(103; "Commissions total"; Decimal)
        {
            Caption = 'Commissions total';
        }
        field(110; "Back disc./commission rule No."; Code[20])
        {
            Caption = 'Back discount/commission rule No.';
            TableRelation = "Discount Rule"."No." where("Discount and comm. type" = filter("Back discount" | Commission));
        }
        field(200; "Item Charge No."; Code[20])
        {
            Caption = 'Item Charge No.';
            TableRelation = "Item Charge";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(301; "Variant Code"; Code[20])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = filter(Item)) "Item Variant".Code where("Item No." = field("No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(303; "Return Reason Code"; Code[20])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(310; "Manufacturer Code"; Code[20])
        {
            Caption = 'Manufacturer Code';
            TableRelation = Manufacturer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(311; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(312; "Product Group Code"; Code[20])
        {
            Caption = 'Product Group Code';
            //GL2024   TableRelation = "Product Group".Code where("Item Category Code" = field("Item Category Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            //GL2024  ValidateTableRelation = false;
        }
        field(313; "Service Item Group"; Code[20])
        {
            Caption = 'Service Item Group';
            TableRelation = "Service Item Group".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(500; "Key 1"; Text[22])
        {
            Caption = 'Key 1';
        }
        field(501; "Key 2"; Text[22])
        {
            Caption = 'Key 2';
        }
        field(502; "Key 3"; Text[22])
        {
            Caption = 'Key 3';
        }
        field(503; "Key 4"; Text[22])
        {
            Caption = 'Key 4';
        }
        field(504; "Key 5"; Text[22])
        {
            Caption = 'Key 5';
        }
        field(505; "Key 6"; Text[22])
        {
            Caption = 'Key 6';
        }
        field(506; "Key 7"; Text[22])
        {
            Caption = 'Key 7';
        }
        field(507; "Key 8"; Text[22])
        {
            Caption = 'Key 8';
        }
        field(508; "Key 9"; Text[22])
        {
            Caption = 'Key 9';
        }
        field(509; "Key 10"; Text[22])
        {
            Caption = 'Key 10';
        }
        field(990; "Statistic code"; Code[10])
        {
            Caption = 'Statistic code';
        }
        field(995; Company; Text[30])
        {
            Caption = 'Company';
            NotBlank = true;
            TableRelation = Company;
        }
        field(1000; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(1001; "Free field 1"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99041';
            Caption = 'Free field 1';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(8004170));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 1", "Free field 1");
            end;
        }
        field(1002; "Free field 2"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99042';
            Caption = 'Free field 2';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(8004171));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 2", "Free field 2");
            end;
        }
        field(1003; "Free field 3"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99043';
            Caption = 'Free field 3';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(8004172));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 3", "Free field 3");
            end;
        }
        field(1004; "Free field 4"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99044';
            Caption = 'Free field 4';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(8004173));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 4", "Free field 4");
            end;
        }
        field(1005; "Free field 5"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99045';
            Caption = 'Free field 5';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(8004174));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 5", "Free field 5");
            end;
        }
        field(1006; "Free field 6"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99046';
            Caption = 'Free field 6';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1006));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 6", "Free field 6");
            end;
        }
        field(1007; "Free field 7"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99047';
            Caption = 'Free field 7';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1007));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 7", "Free field 7");
            end;
        }
        field(1008; "Free field 8"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99048';
            Caption = 'Free field 8';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1008));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 8", "Free field 8");
            end;
        }
        field(1009; "Free field 9"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99049';
            Caption = 'Free field 9';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1009));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 9", "Free field 9");
            end;
        }
        field(1010; "Free field 10"; Code[20])
        {
            //CaptionClass = '8001400,3,8001302,99050';
            Caption = 'Free field 10';
            TableRelation = Code.Code where("Table No" = const(8001300),
                                             "Field No" = const(1010));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                LookUpFreeField(StatisticsSetup."Free field no 10", "Free field 10");
            end;
        }
        field(1011; "Free date 1"; Date)
        {
            //CaptionClass = '8001400,3,8001302,99061';
            Caption = 'Free date 1';
        }
        field(1012; "Free date 2"; Date)
        {
            //CaptionClass = '8001400,3,8001302,99062';
            Caption = 'Free date 2';
        }
        field(1013; "Free date 3"; Date)
        {
            //CaptionClass = '8001400,3,8001302,99063';
            Caption = 'Free date 3';
        }
        field(1014; "Free date 4"; Date)
        {
            //CaptionClass = '8001400,3,8001302,99064';
            Caption = 'Free date 4';
        }
        field(1015; "Free date 5"; Date)
        {
            //CaptionClass = '8001400,3,8001302,99065';
            Caption = 'Free date 5';
        }
        field(1021; "Free boolean 1"; Boolean)
        {
            //CaptionClass = '8001400,3,8001302,99071';
            Caption = 'Free boolean 1';
        }
        field(1022; "Free boolean 2"; Boolean)
        {
            //CaptionClass = '8001400,3,8001302,99072';
            Caption = 'Free boolean 2';
        }
        field(1023; "Free boolean 3"; Boolean)
        {
            //CaptionClass = '8001400,3,8001302,99073';
            Caption = 'Free boolean 3';
        }
        field(1024; "Free boolean 4"; Boolean)
        {
            //CaptionClass = '8001400,3,8001302,99074';
            Caption = 'Free boolean 4';
        }
        field(1025; "Free boolean 5"; Boolean)
        {
            //CaptionClass = '8001400,3,8001302,99075';
            Caption = 'Free boolean 5';
        }
        field(30001; "Dimension 1 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(1);
            Caption = 'Dimension 1 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 1 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 1 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30002; "Dimension 2 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(2);
            Caption = 'Dimension 2 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 2 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 2 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30003; "Dimension 3 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(3);
            Caption = 'Dimension 3 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 3 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 3 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30004; "Dimension 4 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(4);
            Caption = 'Dimension 4 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 4 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 4 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30005; "Dimension 5 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(5);
            Caption = 'Dimension 5 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 5 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 5 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30006; "Dimension 6 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(6);
            Caption = 'Dimension 6 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 6 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 6 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30007; "Dimension 7 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(7);
            Caption = 'Dimension 7 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 7 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 7 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30008; "Dimension 8 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(8);
            Caption = 'Dimension 8 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 8 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 8 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30009; "Dimension 9 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(9);
            Caption = 'Dimension 9 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 9 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 9 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30010; "Dimension 10 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(10);
            Caption = 'Dimension 10 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 10 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 10 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30011; "Dimension 11 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(11);
            Caption = 'Dimension 11 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 11 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 11 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30012; "Dimension 12 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(12);
            Caption = 'Dimension 12 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 12 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 12 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30013; "Dimension 13 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(13);
            Caption = 'Dimension 13 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 13 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 13 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30014; "Dimension 14 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(14);
            Caption = 'Dimension 14 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 14 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 14 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30015; "Dimension 15 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(15);
            Caption = 'Dimension 15 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 15 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 15 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30016; "Dimension 16 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(16);
            Caption = 'Dimension 16 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 16 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 16 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30017; "Dimension 17 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(17);
            Caption = 'Dimension 17 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 17 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 17 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30018; "Dimension 18 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(18);
            Caption = 'Dimension 18 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 18 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 18 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30019; "Dimension 19 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(19);
            Caption = 'Dimension 19 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 19 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 19 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30020; "Dimension 20 Value Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(20);
            Caption = 'Dimension 20 Value Code';

            trigger OnLookup()
            begin
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 20 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 20 Value Code" := DimValue.Code;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "User ID", "Statistic code", "Key 1", "Key 2", "Key 3", "Key 4", "Key 5", "Key 6", "Key 7", "Key 8", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "User ID", "Statistic code", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DimManagement: Codeunit DimensionManagement;
        StatisticsSetup: Record "Statistics setup";
        DimValue: Record "Dimension Value";
        wTableRelation: Codeunit TableRelation;
        Text001: label '1,5,,Dimension 1 Value Code';
        Text002: label '1,5,,Dimension 2 Value Code';
        Text003: label '1,5,,Dimension 3 Value Code';
        Text004: label '1,5,,Dimension 4 Value Code';
        Text005: label '1,5,,Dimension 5 Value Code';
        Text006: label '1,5,,Dimension 6 Value Code';
        Text007: label '1,5,,Dimension 7 Value Code';
        Text008: label '1,5,,Dimension 8 Value Code';
        Text009: label '1,5,,Dimension 9 Value Code';
        Text010: label '1,5,,Dimension 10 Value Code';
        Text011: label '1,5,,Dimension 11 Value Code';
        Text012: label '1,5,,Dimension 12 Value Code';
        Text013: label '1,5,,Dimension 13 Value Code';
        Text014: label '1,5,,Dimension 14 Value Code';
        Text015: label '1,5,,Dimension 15 Value Code';
        Text016: label '1,5,,Dimension 16 Value Code';
        Text017: label '1,5,,Dimension 17 Value Code';
        Text018: label '1,5,,Dimension 18 Value Code';
        Text019: label '1,5,,Dimension 19 Value Code';
        Text020: label '1,5,,Dimension 20 Value Code';


    procedure AjouterNouvArticle(AncStats: Record "Statistic aggregate"; SousAncStats: Boolean)
    var
        AncStats2: Record "Statistic aggregate";
    begin
        if not SousAncStats then begin
            AncStats2 := AncStats;
            AncStats.Copy(Rec);
            AncStats := AncStats2;
            if not AncStats.Find('<') then
                AncStats.Init;
        end;
    end;


    procedure GetCaptionClass(AnalysisViewDimType: Integer): Text[250]
    begin
        StatisticsSetup.Get;
        case AnalysisViewDimType of
            1:
                begin
                    if StatisticsSetup."Dimension 1 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 1 Code")
                    else
                        exit(Text001);
                end;
            2:
                begin
                    if StatisticsSetup."Dimension 2 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 2 Code")
                    else
                        exit(Text002);
                end;
            3:
                begin
                    if StatisticsSetup."Dimension 3 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 3 Code")
                    else
                        exit(Text003);
                end;
            4:
                begin
                    if StatisticsSetup."Dimension 4 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 4 Code")
                    else
                        exit(Text004);
                end;
            5:
                begin
                    if StatisticsSetup."Dimension 5 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 5 Code")
                    else
                        exit(Text005);
                end;
            6:
                begin
                    if StatisticsSetup."Dimension 6 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 6 Code")
                    else
                        exit(Text006);
                end;
            7:
                begin
                    if StatisticsSetup."Dimension 7 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 7 Code")
                    else
                        exit(Text007);
                end;
            8:
                begin
                    if StatisticsSetup."Dimension 8 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 8 Code")
                    else
                        exit(Text008);
                end;
            9:
                begin
                    if StatisticsSetup."Dimension 9 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 9 Code")
                    else
                        exit(Text009);
                end;
            10:
                begin
                    if StatisticsSetup."Dimension 10 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 10 Code")
                    else
                        exit(Text010);
                end;
            11:
                begin
                    if StatisticsSetup."Dimension 11 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 11 Code")
                    else
                        exit(Text011);
                end;
            12:
                begin
                    if StatisticsSetup."Dimension 12 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 12 Code")
                    else
                        exit(Text012);
                end;
            13:
                begin
                    if StatisticsSetup."Dimension 13 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 13 Code")
                    else
                        exit(Text013);
                end;
            14:
                begin
                    if StatisticsSetup."Dimension 14 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 14 Code")
                    else
                        exit(Text014);
                end;
            15:
                begin
                    if StatisticsSetup."Dimension 15 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 15 Code")
                    else
                        exit(Text015);
                end;
            16:
                begin
                    if StatisticsSetup."Dimension 16 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 16 Code")
                    else
                        exit(Text016);
                end;
            17:
                begin
                    if StatisticsSetup."Dimension 17 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 17 Code")
                    else
                        exit(Text017);
                end;
            18:
                begin
                    if StatisticsSetup."Dimension 18 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 18 Code")
                    else
                        exit(Text018);
                end;
            19:
                begin
                    if StatisticsSetup."Dimension 19 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 19 Code")
                    else
                        exit(Text019);
                end;
            20:
                begin
                    if StatisticsSetup."Dimension 20 Code" <> '' then
                        exit('1,5,' + StatisticsSetup."Dimension 20 Code")
                    else
                        exit(Text020);
                end;
        end;
    end;

    //GL2024 procedure LookUpFreeField(pFieldRef: Text[50]; var pFieldValue: Variant)
    procedure LookUpFreeField(pFieldRef: Text[50]; var pFieldValue: code[20])
    var
        lTable: Integer;
        lField: Integer;
        lCode: Code[20];
        lTableTxt: Text[30];
        lFieldTxt: Text[30];
    begin
        if StrPos(pFieldRef, '.') > 1 then begin
            lTableTxt := CopyStr(pFieldRef, 1, StrPos(pFieldRef, '.') - 1);
            lFieldTxt := CopyStr(pFieldRef, StrPos(pFieldRef, '.') + 1);
        end;
        Evaluate(lTable, lTableTxt);
        Evaluate(lField, lFieldTxt);
        wTableRelation.LookUp(lTable, lField, lCode);
        pFieldValue := Format(lCode);
    end;
}

