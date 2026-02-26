Table 8001515 "Statistic column filter"
{
    //GL2024  ID dans Nav 2009 : "8001308"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic column, filters for each column

    Caption = 'Statistic column filter';
    // LookupPageID = 8001307;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Column style name";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
            TableRelation = "Statistic column"."Line No." where(Code = field(Code));
        }
        field(3; "Period Length"; Option)
        {
            Caption = 'Period Length';
            InitValue = Statistic;
            OptionCaption = 'Day,Week,Month,Quarter,Year,Period,Statistic';
            OptionMembers = Day,Week,Month,Quarter,Year,Period,Statistic;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Account (G/L),Item,Resource,Employee,Resource Group';
            OptionMembers = " ","Account (G/L)",Item,Resource,Employee,"Resource Group";
        }
        field(6; "No."; Text[30])
        {
            Caption = 'No.';
            TableRelation = if (Type = filter("Account (G/L)")) "G/L Account"
            else
            if (Type = filter(Item)) Item
            else
            if (Type = filter(Resource)) Resource
            else
            if (Type = filter(Employee)) Employee
            else
            if (Type = filter("Resource Group")) "Resource Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = ' ,Customer,Vendor,Item,Bank Account,Fixed Asset,Budget';
            OptionMembers = " ",Customer,Vendor,Item,"Bank Account","Fixed Asset",Budget;
        }
        field(9; "Source No."; Text[30])
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
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(11; "Location Code"; Text[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; "Inventory Posting Group"; Text[30])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(13; "Source Posting Group"; Text[30])
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
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(14; "Gen. Bus. Posting Group"; Text[30])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(15; "Gen. Prod. Posting Group"; Text[30])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(16; "Salespers./Purch. Code"; Text[30])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(17; "Global Dimension 1 Code"; Text[30])
        {
            //CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(18; "Global Dimension 2 Code"; Text[30])
        {
            //CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(19; "Country Code"; Text[20])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(30; Year; Text[10])
        {
            Caption = 'Year';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(31; "Half Year"; Text[10])
        {
            Caption = 'Half Year';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(32; Quarter; Text[10])
        {
            Caption = 'Quarter';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(33; Month; Text[10])
        {
            Caption = 'Month';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(34; Week; Text[10])
        {
            Caption = 'Week';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(35; "Fiscal year closing date"; Text[22])
        {
            Caption = 'Fiscal year closing date';

            trigger OnValidate()
            begin
                "Fiscal year closing date" := FaireFiltreDate.FaireDate("Fiscal year closing date");
            end;
        }
        field(36; "Week Day"; Text[10])
        {
            Caption = 'Week Day';
        }
        field(37; "Business Unit Code"; Text[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(38; "Consol. Debit Acc."; Text[30])
        {
            Caption = 'Consol. Debit Acc.';
        }
        field(39; "Consol. Credit Acc."; Text[30])
        {
            Caption = 'Consol. Credit Acc.';
        }
        field(40; "Job No."; Text[30])
        {
            Caption = 'N° Affaire.';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(41; "Job Task Code"; Text[30])
        {
            Caption = 'Job Task Code';
            TableRelation = "Job Task"."Job Task No.";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(44; "Work Type Code"; Text[15])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(45; "Reason Code"; Text[20])
        {
            Caption = 'Reason Code';
            TableRelation = if (Type = filter(<> Employee)) "Reason Code"
            else
            if (Type = filter(Employee)) "Cause of Absence";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(46; "Job Posting Group"; Text[20])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job Posting Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(47; "Resource Group No."; Text[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(48; "Person Responsible"; Text[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(57; "Campaign No."; Text[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;

            trigger OnValidate()
            var
                TempDocDim: Record "Gen. Jnl. Dim. Filter" temporary;
            begin
            end;
        }
        field(60; "Item criteria 1"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99030';
            Caption = 'Item criteria 1';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(61; "Item criteria 2"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99031';
            Caption = 'Item criteria 2';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(62; "Item criteria 3"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99032';
            Caption = 'Item criteria 3';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(63; "Item criteria 4"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99033';
            Caption = 'Item criteria 4';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(64; "Item criteria 5"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99035';
            Caption = 'Item criteria 5';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(65; "Item criteria 6"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99036';
            Caption = 'Item criteria 6';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(66; "Item criteria 7"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99036';
            Caption = 'Item criteria 7';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(67; "Item criteria 8"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99037';
            Caption = 'Item criteria 8';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(68; "Item criteria 9"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99038';
            Caption = 'Item criteria 9';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69; "Item criteria 10"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99039';
            Caption = 'Item criteria 10';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(70; "Customer criteria 1"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99003';
            Caption = 'Customer criteria 1';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(71; "Customer criteria 2"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99004';
            Caption = 'Customer criteria 2';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(72; "Customer criteria 3"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99005';
            Caption = 'Customer criteria 3';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(73; "Customer criteria 4"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99006';
            Caption = 'Customer criteria 4';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(74; "Customer criteria 5"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99007';
            Caption = 'Customer criteria 5';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(75; "Customer criteria 6"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99008';
            Caption = 'Customer criteria 6';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(76; "Customer criteria 7"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99009';
            Caption = 'Customer criteria 7';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(77; "Customer criteria 8"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99010';
            Caption = 'Customer criteria 8';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(78; "Customer criteria 9"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99011';
            Caption = 'Customer criteria 9';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(79; "Customer criteria 10"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99012';
            Caption = 'Customer criteria 10';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(89; "Job criteria 1"; Text[20])
        {
            //CaptionClass = '8001400,1,8001302,99090';
            Caption = 'Job criteria 1';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001301));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(90; "Back disc./commission rule No."; Text[20])
        {
            Caption = 'Back discount/commission rule No.';
            TableRelation = "Discount Rule"."No." where("Discount and comm. type" = filter("Back discount" | Commission));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(91; "Job criteria 2"; Text[20])
        {
            //CaptionClass = '8001400,1,8001302,99091';
            Caption = 'Job criteria 2';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001302));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(92; "Job criteria 3"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99092';
            Caption = 'Job criteria 3';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001303));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(93; "Job criteria 4"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99093';
            Caption = 'Job criteria 4';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001304));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(94; "Job criteria 5"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99094';
            Caption = 'Job criteria 5';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001305));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(95; "Job criteria 6"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99095';
            Caption = 'Job criteria 6';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001306));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(96; "Job criteria 7"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99096';
            Caption = 'Job criteria 7';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001307));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(97; "Job criteria 8"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99097';
            Caption = 'Job criteria 8';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001308));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(98; "Job criteria 9"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99098';
            Caption = 'Job criteria 9';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001309));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(99; "Job criteria 10"; Text[30])
        {
            //CaptionClass = '8001400,1,8001302,99099';
            Caption = 'Job criteria 10';
            TableRelation = Code.Code where("Table No" = const(167),
                                             "Field No" = const(8001310));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(300; "Item Charge No."; Text[30])
        {
            Caption = 'Item Charge No.';
            TableRelation = "Item Charge";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(301; "Variant Code"; Text[30])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = filter(Item)) "Item Variant".Code where("Item No." = field("No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(303; "Return Reason Code"; Text[30])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(310; "Manufacturer Code"; Text[30])
        {
            Caption = 'Manufacturer Code';
            TableRelation = Manufacturer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(311; "Item Category Code"; Text[30])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(312; "Product Group Code"; Text[30])
        {
            Caption = 'Product Group Code';
            //GL2024   TableRelation = "Product Group".Code where("Item Category Code" = field("Item Category Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            //GL2024  ValidateTableRelation = false;
        }
        field(313; "Service Item Group"; Text[30])
        {
            Caption = 'Service Item Group';
            TableRelation = "Service Item Group".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(1001; "Free field 1"; Text[30])
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
        field(1002; "Free field 2"; Text[30])
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
        field(1003; "Free field 3"; Text[30])
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
        field(1004; "Free field 4"; Text[30])
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
        field(1005; "Free field 5"; Text[30])
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
        field(1006; "Free field 6"; Text[30])
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
        field(1007; "Free field 7"; Text[30])
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
        field(1008; "Free field 8"; Text[30])
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
        field(1009; "Free field 9"; Text[30])
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
        field(1010; "Free field 10"; Text[30])
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
        field(1011; "Free date 1"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99061';
            Caption = 'Free date 1';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 1" := FaireFiltreDate.FaireDate("Free date 1");
            end;
        }
        field(1012; "Free date 2"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99062';
            Caption = 'Free date 2';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 2" := FaireFiltreDate.FaireDate("Free date 2");
            end;
        }
        field(1013; "Free date 3"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99063';
            Caption = 'Free date 3';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 3" := FaireFiltreDate.FaireDate("Free date 3");
            end;
        }
        field(1014; "Free date 4"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99064';
            Caption = 'Free date 4';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 4" := FaireFiltreDate.FaireDate("Free date 4");
            end;
        }
        field(1015; "Free date 5"; Text[22])
        {
            //CaptionClass = '8001400,3,8001302,99065';
            Caption = 'Free date 5';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnValidate()
            begin
                "Free date 5" := FaireFiltreDate.FaireDate("Free date 5");
            end;
        }
        field(1021; "Free boolean 1"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99071';
            Caption = 'Free boolean 1';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(1022; "Free boolean 2"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99072';
            Caption = 'Free boolean 2';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(1023; "Free boolean 3"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99073';
            Caption = 'Free boolean 3';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(1024; "Free boolean 4"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99074';
            Caption = 'Free boolean 4';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(1025; "Free boolean 5"; Option)
        {
            //CaptionClass = '8001400,3,8001302,99075';
            Caption = 'Free boolean 5';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(2000; Company; Text[30])
        {
            Caption = 'Company';
            TableRelation = Company;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(30001; "Dimension 1 Value Code"; Text[30])
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
        field(30002; "Dimension 2 Value Code"; Text[30])
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
        field(30003; "Dimension 3 Value Code"; Text[30])
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
        field(30004; "Dimension 4 Value Code"; Text[30])
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
        field(30005; "Dimension 5 Value Code"; Text[30])
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
        field(30006; "Dimension 6 Value Code"; Text[30])
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
        field(30007; "Dimension 7 Value Code"; Text[30])
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
        field(30008; "Dimension 8 Value Code"; Text[30])
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
        field(30009; "Dimension 9 Value Code"; Text[30])
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
        field(30010; "Dimension 10 Value Code"; Text[30])
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
        field(30011; "Dimension 11 Value Code"; Text[30])
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
        field(30012; "Dimension 12 Value Code"; Text[30])
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
        field(30013; "Dimension 13 Value Code"; Text[30])
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
        field(30014; "Dimension 14 Value Code"; Text[30])
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
        field(30015; "Dimension 15 Value Code"; Text[30])
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
        field(30016; "Dimension 16 Value Code"; Text[30])
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
        field(30017; "Dimension 17 Value Code"; Text[30])
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
        field(30018; "Dimension 18 Value Code"; Text[30])
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
        field(30019; "Dimension 19 Value Code"; Text[30])
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
        field(30020; "Dimension 20 Value Code"; Text[30])
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
        key(Key1; "Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Critere: Record "Statistic criteria";
        Colonne: Record "Statistic column";
        StatisticsSetup: Record "Statistics setup";
        DimValue: Record "Dimension Value";
        FaireFiltreDate: Codeunit MakeDateFilter;
        i: Integer;
        Text001: label '1,6,,Dimension 1 Value Code';
        Text002: label '1,6,,Dimension 2 Value Code';
        Text003: label '1,6,,Dimension 3 Value Code';
        Text004: label '1,6,,Dimension 4 Value Code';
        Text005: label '1,6,,Dimension 5 Value Code';
        Text006: label '1,6,,Dimension 6 Value Code';
        Text007: label '1,6,,Dimension 7 Value Code';
        Text008: label '1,6,,Dimension 8 Value Code';
        Text009: label '1,6,,Dimension 9 Value Code';
        Text010: label '1,6,,Dimension 10 Value Code';
        Text011: label '1,6,,Dimension 11 Value Code';
        Text012: label '1,6,,Dimension 12 Value Code';
        Text013: label '1,6,,Dimension 13 Value Code';
        Text014: label '1,6,,Dimension 14 Value Code';
        Text015: label '1,6,,Dimension 15 Value Code';
        Text016: label '1,6,,Dimension 16 Value Code';
        Text017: label '1,6,,Dimension 17 Value Code';
        Text018: label '1,6,,Dimension 18 Value Code';
        Text019: label '1,6,,Dimension 19 Value Code';
        Text020: label '1,6,,Dimension 20 Value Code';
        wTableRelation: Codeunit TableRelation;


    procedure GetCaptionClass(AnalysisViewDimType: Integer): Text[250]
    begin
        StatisticsSetup.Get;
        case AnalysisViewDimType of
            1:
                begin
                    if StatisticsSetup."Dimension 1 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 1 Code")
                    else
                        exit(Text001);
                end;
            2:
                begin
                    if StatisticsSetup."Dimension 2 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 2 Code")
                    else
                        exit(Text002);
                end;
            3:
                begin
                    if StatisticsSetup."Dimension 3 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 3 Code")
                    else
                        exit(Text003);
                end;
            4:
                begin
                    if StatisticsSetup."Dimension 4 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 4 Code")
                    else
                        exit(Text004);
                end;
            5:
                begin
                    if StatisticsSetup."Dimension 5 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 5 Code")
                    else
                        exit(Text005);
                end;
            6:
                begin
                    if StatisticsSetup."Dimension 6 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 6 Code")
                    else
                        exit(Text006);
                end;
            7:
                begin
                    if StatisticsSetup."Dimension 7 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 7 Code")
                    else
                        exit(Text007);
                end;
            8:
                begin
                    if StatisticsSetup."Dimension 8 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 8 Code")
                    else
                        exit(Text008);
                end;
            9:
                begin
                    if StatisticsSetup."Dimension 9 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 9 Code")
                    else
                        exit(Text009);
                end;
            10:
                begin
                    if StatisticsSetup."Dimension 10 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 10 Code")
                    else
                        exit(Text010);
                end;
            11:
                begin
                    if StatisticsSetup."Dimension 11 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 11 Code")
                    else
                        exit(Text011);
                end;
            12:
                begin
                    if StatisticsSetup."Dimension 12 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 12 Code")
                    else
                        exit(Text012);
                end;
            13:
                begin
                    if StatisticsSetup."Dimension 13 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 13 Code")
                    else
                        exit(Text013);
                end;
            14:
                begin
                    if StatisticsSetup."Dimension 14 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 14 Code")
                    else
                        exit(Text014);
                end;
            15:
                begin
                    if StatisticsSetup."Dimension 15 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 15 Code")
                    else
                        exit(Text015);
                end;
            16:
                begin
                    if StatisticsSetup."Dimension 16 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 16 Code")
                    else
                        exit(Text016);
                end;
            17:
                begin
                    if StatisticsSetup."Dimension 17 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 17 Code")
                    else
                        exit(Text017);
                end;
            18:
                begin
                    if StatisticsSetup."Dimension 18 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 18 Code")
                    else
                        exit(Text018);
                end;
            19:
                begin
                    if StatisticsSetup."Dimension 19 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 19 Code")
                    else
                        exit(Text019);
                end;
            20:
                begin
                    if StatisticsSetup."Dimension 20 Code" <> '' then
                        exit('1,6,' + StatisticsSetup."Dimension 20 Code")
                    else
                        exit(Text020);
                end;
        end;
    end;


    procedure LookUpFreeField(pFieldRef: Text[50]; var pFieldValue: Text[50])
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

