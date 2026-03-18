table 52048893 CATEGORIES
{
    //GL2024  ID dans Nav 2009 : "39001419"
    Caption = 'Category';

    DrillDownPageID = "CATEGORIES";
    LookupPageID = "CATEGORIES";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Borne inférieure"; Integer)
        {
            Caption = 'Hierarchy indication';
        }
        field(4; "Borne Supérieure"; Integer)
        {
        }
        field(50000; "Mnt Ind Transp"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50001; "Mnt Ind Log"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(8099198; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

