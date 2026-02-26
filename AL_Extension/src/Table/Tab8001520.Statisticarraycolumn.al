Table 8001520 "Statistic array column"
{
    //GL2024  ID dans Nav 2009 : "8001313"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic columns by user

    Caption = 'Statistic array column';
    // LookupPageID = 8001306;

    fields
    {
        field(1; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(2; "Colonne No. pos."; Integer)
        {
            Caption = 'Colonne No. pos.';
            NotBlank = true;
        }
        field(3; "Column Layout Name"; Code[10])
        {
            Caption = 'Column Layout Name';
            NotBlank = true;
            TableRelation = "Column style name";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Column title"; Text[100])
        {
            Caption = 'Column title';
        }
        field(6; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(7; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(8; "Column description"; Text[50])
        {
            Caption = 'Column description';
        }
        field(9; "Column No."; Code[10])
        {
            Caption = 'Column No.';
        }
        field(10; "Column type"; Text[30])
        {
            Caption = 'Column type';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter(Value));
        }
        field(11; Formula; Text[80])
        {
            Caption = 'Formula';
        }
        field(14; "Rounding Factor"; Option)
        {
            Caption = 'Rounding Factor';
            OptionCaption = 'None,1,1000,1000000';
            OptionMembers = "None","1","1000","1000000";
        }
        field(20; "Additional filter"; Boolean)
        {
            Caption = 'Additional filter';
            Editable = false;
        }
        field(30; "New line"; Boolean)
        {
            Caption = 'New line';
        }
        field(31; "Line title"; Text[30])
        {
            Caption = 'Line title';
        }
        field(100; "Statistic code"; Code[10])
        {
            Caption = 'Statistic code';
        }
    }

    keys
    {
        key(Key1; "User ID", "Statistic code", "Colonne No. pos.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

