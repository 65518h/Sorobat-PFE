Table 8001553 "Expenses Notes Setup"
{
    //GL2024  ID dans Nav 2009 : "8002000"
    // //+NDF+ GESWAY 15/07/02 Table Paramètres note de frais

    Caption = 'Expenses Notes Setup';
    // DrillDownPageID = 8002000;
    //LookupPageID = 8002000;

    fields
    {
        field(1; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            NotBlank = true;
            TableRelation = "Work Type";
        }
        field(2; "Flow Account Type"; Option)
        {
            Caption = 'Flow Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor';
            OptionMembers = "G/L Account",Customer,Vendor;
        }
        field(4; "Flow Account No."; Code[20])
        {
            Caption = 'Flow Account No.';
            TableRelation = if ("Flow Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Flow Account Type" = const(Customer)) Customer
            else
            if ("Flow Account Type" = const(Vendor)) Vendor;
        }
        field(10; "Credit Account Type"; Option)
        {
            Caption = 'Credit Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor';
            OptionMembers = "G/L Account",Customer,Vendor;
        }
        field(15; "Credit Account No."; Code[20])
        {
            Caption = 'Credit Account No.';
            TableRelation = if ("Credit Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Credit Account Type" = const(Customer)) Customer
            else
            if ("Credit Account Type" = const(Vendor)) Vendor;
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(22; Centralize; Boolean)
        {
            Caption = 'Centralize';
        }
        field(30; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
        }
        field(31; "Ceiling Amount"; Decimal)
        {
            Caption = 'Ceiling Amount';
        }
    }

    keys
    {
        key(STG_Key1; "Work Type Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

