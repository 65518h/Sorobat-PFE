Table 8001503 "Sales Disc. Commission Entry"
{
    // //+RFA+ GESWAY 11/07/02 Nouvelle table de stockage des commissions remises calculées a posteriori.
    // 
    // Clé : Discount and Comm. Type,Law No.,Salesperson Code,Customer No.,Location Code,Global Dimension 1 Code,
    //        Global Dimension 2 Code,Cust. Posting Group,Gen. Bus. Posting Group,Inventory Posting Group,
    //        Gen. Prod. Posting Group,Price Group Code,Cust./Item Disc. Group,Item/Cust. Disc. Group
    //        raccourcie de 2 critères.

    Caption = 'Discount and Commission Entry';
    // DrillDownPageID = 8001503;
    // LookupPageID = 8001503;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Disc. Commission Type"; Option)
        {
            Caption = 'Discount Commission Type';
            OptionCaption = 'Line Discount,Footer Discount,Back Discount,Commission';
            OptionMembers = "Line Discount","Footer Discount","Back Discount",Commission;
        }
        field(3; "Rule No."; Code[20])
        {
            Caption = 'Rule No.';
            TableRelation = "Discount Rule"."No." where("Discount and comm. type" = field("Disc. Commission Type"),
                                                         "No." = field("Rule No."));
        }
        field(10; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(12; "Price Group Code"; Code[10])
        {
            Caption = 'Price Group Code';
        }
        field(13; "Cust. Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group".Code;
        }
        field(14; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(15; "Cust./Item Disc. Group"; Code[10])
        {
            Caption = 'Cust./Item Discount Group';
        }
        field(16; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group".Code;
        }
        field(17; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(18; "Item/Cust. Disc. Group"; Code[10])
        {
            Caption = 'Item/Cust. Discount Group';
        }
        field(19; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Account G/L,Item,Resource';
            OptionMembers = "Account G/L",Item,Resource;
        }
        field(20; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const("Account G/L")) "G/L Account"."No."
            else
            if (Type = const(Item)) Item."No."
            else
            if (Type = const(Resource)) Resource."No.";
        }
        field(30; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(31; "Base (LCY)"; Decimal)
        {
            Caption = 'Base (LCY)';
        }
        field(32; "Discount Amount (LCY)"; Decimal)
        {
            Caption = 'Discount Amount (LCY)';
        }
        field(33; Base; Decimal)
        {
            Caption = 'Base';
        }
        field(34; "Discount Amount"; Decimal)
        {
            Caption = 'Discount Amount';
        }
        field(40; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(41; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(42; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(43; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
        }
        field(51; "Customer Criteria 1"; Code[10])
        {
            Caption = 'Cust. Criteria 1';
        }
        field(52; "Customer Criteria 2"; Code[10])
        {
            Caption = 'Cust. Criteria 2';
        }
        field(53; "Customer Criteria 3"; Code[10])
        {
            Caption = 'Cust. Criteria 3';
        }
        field(54; "Customer Criteria 4"; Code[10])
        {
            Caption = 'Cust. Criteria 4';
        }
        field(55; "Customer Criteria 5"; Code[10])
        {
            Caption = 'Cust. Criteria 5';
        }
        field(56; "Customer Criteria 6"; Code[10])
        {
            Caption = 'Cust. Criteria 6';
        }
        field(57; "Customer Criteria 7"; Code[10])
        {
            Caption = 'Cust. Criteria 7';
        }
        field(58; "Customer Criteria 8"; Code[10])
        {
            Caption = 'Cust. Criteria 8';
        }
        field(59; "Customer Criteria 9"; Code[10])
        {
            Caption = 'Cust. Criteria 9';
        }
        field(60; "Customer Criteria 10"; Code[10])
        {
            Caption = 'Cust. Criteria 10';
        }
        field(61; "Item Criteria 1"; Code[10])
        {
            Caption = 'Item Criteria 1';
        }
        field(62; "Item Criteria 2"; Code[10])
        {
            Caption = 'Item Criteria 2';
        }
        field(63; "Item Criteria 3"; Code[10])
        {
            Caption = 'Item Criteria 3';
        }
        field(64; "Item Criteria 4"; Code[10])
        {
            Caption = 'Item Criteria 4';
        }
        field(65; "Item Criteria 5"; Code[10])
        {
            Caption = 'Item Criteria 5';
        }
        field(66; "Item Criteria 6"; Code[10])
        {
            Caption = 'Item Criteria 6';
        }
        field(67; "Item Criteria 7"; Code[10])
        {
            Caption = 'Item Criteria 7';
        }
        field(68; "Item Criteria 8"; Code[10])
        {
            Caption = 'Item Criteria 8';
        }
        field(69; "Item Criteria 9"; Code[10])
        {
            Caption = 'Item Criteria 9';
        }
        field(70; "Item Criteria 10"; Code[10])
        {
            Caption = 'Item Criteria 10';
        }
        field(100; Basis; Option)
        {
            Caption = 'Basis';
            OptionCaption = 'Gross,Net line,Net Footer,Net End of Period Discount';
            OptionMembers = Gross,"Net line","Net Footer","Net End of Period Discount";
        }
        field(101; "Create Credit Memo"; Option)
        {
            Caption = 'Create Credit Memo';
            OptionCaption = 'No,Immediate,Forward';
            OptionMembers = No,Immediate,Forward;
        }
        field(102; Forced; Boolean)
        {
            Caption = 'Forced';
        }
        field(125; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
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
        field(30001; "Dimension 1 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(1);
            Caption = 'Dimension 1 Code';
            TableRelation = Dimension;
        }
        field(30002; "Dimension 2 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(2);
            Caption = 'Dimension 2 Code';
            TableRelation = Dimension;
        }
        field(30003; "Dimension 3 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(3);
            Caption = 'Dimension 3 Code';
            TableRelation = Dimension;
        }
        field(30004; "Dimension 4 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(4);
            Caption = 'Dimension 4 Code';
            TableRelation = Dimension;
        }
        field(30005; "Dimension 5 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(5);
            Caption = 'Dimension 5 Code';
            TableRelation = Dimension;
        }
        field(30006; "Dimension 6 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(6);
            Caption = 'Dimension 6 Code';
            TableRelation = Dimension;
        }
        field(30007; "Dimension 7 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(7);
            Caption = 'Dimension 7 Code';
            TableRelation = Dimension;
        }
        field(30008; "Dimension 8 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(8);
            Caption = 'Dimension 8 Code';
            TableRelation = Dimension;
        }
        field(30009; "Dimension 9 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(9);
            Caption = 'Dimension 9 Code';
            TableRelation = Dimension;
        }
        field(30010; "Dimension 10 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(10);
            Caption = 'Dimension 10 Code';
            TableRelation = Dimension;
        }
        field(30011; "Dimension 11 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(11);
            Caption = 'Dimension 11 Code';
            TableRelation = Dimension;
        }
        field(30012; "Dimension 12 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(12);
            Caption = 'Dimension 12 Code';
            TableRelation = Dimension;
        }
        field(30013; "Dimension 13 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(13);
            Caption = 'Dimension 13 Code';
            TableRelation = Dimension;
        }
        field(30014; "Dimension 14 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(14);
            Caption = 'Dimension 14 Code';
            TableRelation = Dimension;
        }
        field(30015; "Dimension 15 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(15);
            Caption = 'Dimension 15 Code';
            TableRelation = Dimension;
        }
        field(30016; "Dimension 16 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(16);
            Caption = 'Dimension 16 Code';
            TableRelation = Dimension;
        }
        field(30017; "Dimension 17 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(17);
            Caption = 'Dimension 17 Code';
            TableRelation = Dimension;
        }
        field(30018; "Dimension 18 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(18);
            Caption = 'Dimension 18 Code';
            TableRelation = Dimension;
        }
        field(30019; "Dimension 19 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(19);
            Caption = 'Dimension 19 Code';
            TableRelation = Dimension;
        }
        field(30020; "Dimension 20 Code"; Code[20])
        {
            //CaptionClass = GetCaptionClass(20);
            Caption = 'Dimension 20 Code';
            TableRelation = Dimension;
        }
    }

    keys
    {
        key(STG_Key1; "Disc. Commission Type", "Rule No.", "Salesperson Code", "Customer No.", "Location Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Cust. Posting Group", "Gen. Bus. Posting Group", "Inventory Posting Group", "Gen. Prod. Posting Group", "Price Group Code")
        {
            Clustered = true;
            SumIndexFields = "Discount Amount", "Discount Amount (LCY)";
        }
        key(STG_Key2; "Disc. Commission Type", "Salesperson Code", "Rule No.", "Inventory Posting Group", Type, "No.", "Ending Date")
        {
            SumIndexFields = "Discount Amount", "Discount Amount (LCY)";
        }
    }

    fieldgroups
    {
    }


    procedure GetCaptionClass(AnalysisViewDimType: Integer): Text[250]
    var
        lStatisticsSetup: Record "Statistics setup";
        lTextCaptionClass: label '1,6,,Code section axe %1';
        lText001: label '1,6,,Dimension 1 Value Code';
        lText002: label '1,6,,Dimension 2 Value Code';
        lText003: label '1,6,,Dimension 3 Value Code';
        lText004: label '1,6,,Dimension 4 Value Code';
        lText005: label '1,6,,Dimension 5 Value Code';
        lText006: label '1,6,,Dimension 6 Value Code';
        lText007: label '1,6,,Dimension 7 Value Code';
        lText008: label '1,6,,Dimension 8 Value Code';
        lText009: label '1,6,,Dimension 9 Value Code';
        lText010: label '1,6,,Dimension 10 Value Code';
        lText011: label '1,6,,Dimension 11 Value Code';
        lText012: label '1,6,,Dimension 12 Value Code';
        lText013: label '1,6,,Dimension 13 Value Code';
        lText014: label '1,6,,Dimension 14 Value Code';
        lText015: label '1,6,,Dimension 15 Value Code';
        lText016: label '1,6,,Dimension 16 Value Code';
        lText017: label '1,6,,Dimension 17 Value Code';
        lText018: label '1,6,,Dimension 18 Value Code';
        lText019: label '1,6,,Dimension 19 Value Code';
        lText020: label '1,6,,Dimension 20 Value Code';
    begin
        lStatisticsSetup.Get;
        case AnalysisViewDimType of
            1:
                if lStatisticsSetup."Dimension 1 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 1 Code");
            2:
                if lStatisticsSetup."Dimension 2 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 2 Code");
            3:
                if lStatisticsSetup."Dimension 3 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 3 Code");
            4:
                if lStatisticsSetup."Dimension 4 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 4 Code");
            5:
                if lStatisticsSetup."Dimension 5 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 5 Code");
            6:
                if lStatisticsSetup."Dimension 6 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 6 Code");
            7:
                if lStatisticsSetup."Dimension 7 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 7 Code");
            8:
                if lStatisticsSetup."Dimension 8 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 8 Code");
            9:
                if lStatisticsSetup."Dimension 9 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 9 Code");
            10:
                if lStatisticsSetup."Dimension 10 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 10 Code");
            11:
                if lStatisticsSetup."Dimension 11 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 11 Code");
            12:
                if lStatisticsSetup."Dimension 12 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 12 Code");
            13:
                if lStatisticsSetup."Dimension 13 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 13 Code");
            14:
                if lStatisticsSetup."Dimension 14 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 14 Code");
            15:
                if lStatisticsSetup."Dimension 15 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 15 Code");
            16:
                if lStatisticsSetup."Dimension 16 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 16 Code");
            17:
                if lStatisticsSetup."Dimension 17 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 17 Code");
            18:
                if lStatisticsSetup."Dimension 18 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 18 Code");
            19:
                if lStatisticsSetup."Dimension 19 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 19 Code");
            20:
                if lStatisticsSetup."Dimension 20 Code" <> '' then
                    exit('1,6,' + lStatisticsSetup."Dimension 20 Code");
        end;
        exit(StrSubstNo(lTextCaptionClass, AnalysisViewDimType));
    end;
}

