Table 8001501 "Disc. Commission Buffer"
{
    // //+RFA+ GESWAY 11/07/02 Nouvelle table temporaire pour le calcul des remises

    Caption = 'Disc. Commission Buffer';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Disc. Commission Type"; Option)
        {
            Caption = 'Disc. Commission Type';
            OptionCaption = 'Line Discount,Footer Discount,Back Discount,Commission';
            OptionMembers = "Line Discount","Footer Discount","Back Discount",Commission;
        }
        field(3; "Rule No."; Code[20])
        {
            Caption = 'Rule No.';
        }
        field(10; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(11; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(12; "Price Group Code"; Code[10])
        {
            Caption = 'Price Group Code';
        }
        field(13; "Source Gen. Bus. Posting Gr."; Code[10])
        {
            Caption = 'Source Gen. Bus. Posting Gr.';
        }
        field(14; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(15; "Cust./Item Discount Group"; Code[10])
        {
            Caption = 'Cust./Item Discount Group';
        }
        field(16; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
        }
        field(17; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(18; "Item/Cust. Discount Group"; Code[10])
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
            TableRelation = if (Type = const("Account G/L")) "G/L Account"
            else
            if (Type = const(Item)) Item
            else
            if (Type = const(Resource)) Resource;
        }
        field(30; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(31; Base; Decimal)
        {
            Caption = 'Base';
        }
        field(32; "Commission/Discount Amount"; Decimal)
        {
            Caption = 'Commission/Discount Amount';
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
        field(51; "Customer Criteria 1"; Code[20])
        {
            Caption = 'Cust. Criteria 1';
        }
        field(52; "Customer Criteria 2"; Code[20])
        {
            Caption = 'Cust. Criteria 2';
        }
        field(53; "Customer Criteria 3"; Code[20])
        {
            Caption = 'Cust. Criteria 3';
        }
        field(54; "Customer Criteria 4"; Code[20])
        {
            Caption = 'Cust. Criteria 4';
        }
        field(55; "Customer Criteria 5"; Code[20])
        {
            Caption = 'Cust. Criteria 5';
        }
        field(56; "Customer Criteria 6"; Code[20])
        {
            Caption = 'Cust. Criteria 6';
        }
        field(57; "Customer Criteria 7"; Code[20])
        {
            Caption = 'Cust. Criteria 7';
        }
        field(58; "Customer Criteria 8"; Code[20])
        {
            Caption = 'Cust. Criteria 8';
        }
        field(59; "Customer Criteria 9"; Code[20])
        {
            Caption = 'Cust. Criteria 9';
        }
        field(60; "Customer Criteria 10"; Code[20])
        {
            Caption = 'Cust. Criteria 10';
        }
        field(61; "Item Criteria 1"; Code[20])
        {
            Caption = 'Item Criteria 1';
        }
        field(62; "Item Criteria 2"; Code[20])
        {
            Caption = 'Item Criteria 2';
        }
        field(63; "Item Criteria 3"; Code[20])
        {
            Caption = 'Item Criteria 3';
        }
        field(64; "Item Criteria 4"; Code[20])
        {
            Caption = 'Item Criteria 4';
        }
        field(65; "Item Criteria 5"; Code[20])
        {
            Caption = 'Item Criteria 5';
        }
        field(66; "Item Criteria 6"; Code[20])
        {
            Caption = 'Item Criteria 6';
        }
        field(67; "Item Criteria 7"; Code[20])
        {
            Caption = 'Item Criteria 7';
        }
        field(68; "Item Criteria 8"; Code[20])
        {
            Caption = 'Item Criteria 8';
        }
        field(69; "Item Criteria 9"; Code[20])
        {
            Caption = 'Item Criteria 9';
        }
        field(70; "Item Criteria 10"; Code[20])
        {
            Caption = 'Item Criteria 10';
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
            //GL2024 TableRelation = "Product Group".Code where ("Item Category Code"=field("Item Category Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            //GL2024 ValidateTableRelation = false;
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
            Caption = 'Dimension 1 Code';
            TableRelation = Dimension;
        }
        field(30002; "Dimension 2 Code"; Code[20])
        {
            Caption = 'Dimension 2 Code';
            TableRelation = Dimension;
        }
        field(30003; "Dimension 3 Code"; Code[20])
        {
            Caption = 'Dimension 3 Code';
            TableRelation = Dimension;
        }
        field(30004; "Dimension 4 Code"; Code[20])
        {
            Caption = 'Dimension 4 Code';
            TableRelation = Dimension;
        }
        field(30005; "Dimension 5 Code"; Code[20])
        {
            Caption = 'Dimension 5 Code';
            TableRelation = Dimension;
        }
        field(30006; "Dimension 6 Code"; Code[20])
        {
            Caption = 'Dimension 6 Code';
            TableRelation = Dimension;
        }
        field(30007; "Dimension 7 Code"; Code[20])
        {
            Caption = 'Dimension 7 Code';
            TableRelation = Dimension;
        }
        field(30008; "Dimension 8 Code"; Code[20])
        {
            Caption = 'Dimension 8 Code';
            TableRelation = Dimension;
        }
        field(30009; "Dimension 9 Code"; Code[20])
        {
            Caption = 'Dimension 9 Code';
            TableRelation = Dimension;
        }
        field(30010; "Dimension 10 Code"; Code[20])
        {
            Caption = 'Dimension 10 Code';
            TableRelation = Dimension;
        }
        field(30011; "Dimension 11 Code"; Code[20])
        {
            Caption = 'Dimension 11 Code';
            TableRelation = Dimension;
        }
        field(30012; "Dimension 12 Code"; Code[20])
        {
            Caption = 'Dimension 12 Code';
            TableRelation = Dimension;
        }
        field(30013; "Dimension 13 Code"; Code[20])
        {
            Caption = 'Dimension 13 Code';
            TableRelation = Dimension;
        }
        field(30014; "Dimension 14 Code"; Code[20])
        {
            Caption = 'Dimension 14 Code';
            TableRelation = Dimension;
        }
        field(30015; "Dimension 15 Code"; Code[20])
        {
            Caption = 'Dimension 15 Code';
            TableRelation = Dimension;
        }
        field(30016; "Dimension 16 Code"; Code[20])
        {
            Caption = 'Dimension 16 Code';
            TableRelation = Dimension;
        }
        field(30017; "Dimension 17 Code"; Code[20])
        {
            Caption = 'Dimension 17 Code';
            TableRelation = Dimension;
        }
        field(30018; "Dimension 18 Code"; Code[20])
        {
            Caption = 'Dimension 18 Code';
            TableRelation = Dimension;
        }
        field(30019; "Dimension 19 Code"; Code[20])
        {
            Caption = 'Dimension 19 Code';
            TableRelation = Dimension;
        }
        field(30020; "Dimension 20 Code"; Code[20])
        {
            Caption = 'Dimension 20 Code';
            TableRelation = Dimension;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Rule No.", "Disc. Commission Type", "Salesperson Code", "Source No.", "Source Gen. Bus. Posting Gr.", "Gen. Bus. Posting Group", "Inventory Posting Group", "Gen. Prod. Posting Group", Type, "No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

