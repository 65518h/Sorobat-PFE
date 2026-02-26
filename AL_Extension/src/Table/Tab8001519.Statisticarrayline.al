Table 8001519 "Statistic array line"
{
    //GL2024  ID dans Nav 2009 : "8001312"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic lines by user

    Caption = 'Statistic array line';

    fields
    {
        field(1; "User ID"; Code[16])
        {
            Caption = 'User ID';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Statistic code"; Code[10])
        {
            Caption = 'Statistic code';
        }
        field(5; "Code"; Text[30])
        {
            Caption = 'Code';
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(10; "Break 1"; Text[22])
        {
            Caption = 'Break 1';
        }
        field(11; "Break 2"; Text[22])
        {
            Caption = 'Break 2';
        }
        field(12; "Break 3"; Text[22])
        {
            Caption = 'Break 3';
        }
        field(13; "Break 4"; Text[22])
        {
            Caption = 'Break 4';
        }
        field(14; "Break 5"; Text[22])
        {
            Caption = 'Break 5';
        }
        field(15; "Break 6"; Text[22])
        {
            Caption = 'Break 6';
        }
        field(16; "Break 7"; Text[22])
        {
            Caption = 'Break 7';
        }
        field(17; "Break 8"; Text[22])
        {
            Caption = 'Break 8';
        }
        field(18; "Break 9"; Text[22])
        {
            Caption = 'Break 9';
        }
        field(19; "Break 10"; Text[22])
        {
            Caption = 'Break 10';
        }
        field(20; "Section level"; Integer)
        {
            Caption = 'Section level';
        }
        field(21; "Section name"; Text[50])
        {
            Caption = 'Section name';
        }
        field(30; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(50; Result; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Statistic cell"."Computed result" where("User ID" = field("User ID"),
                                                                        "Statistic code" = field("Statistic code"),
                                                                        "Line No." = field("Line No."),
                                                                        "Column No." = field("Column no. filter")));
            Caption = 'Result';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Column no. filter"; Integer)
        {
            Caption = 'Column no. filter';
            FieldClass = FlowFilter;
        }
        field(60; "Sort value"; Decimal)
        {
            Caption = 'Sort value';
        }
        field(61; "Sort key by value"; Integer)
        {
            Caption = 'Sort key by value';
        }
        field(62; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
        }
        field(63; "Lower lines count"; Integer)
        {
            Caption = 'Lower lines count';
        }
    }

    keys
    {
        key(Key1; "User ID", "Statistic code", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "User ID", "Statistic code", "Break 1", "Break 2", "Break 3", "Break 4", "Break 5", "Break 6", "Break 7", "Break 8", "Break 9", "Line No.")
        {
        }
        key(Key3; "User ID", "Statistic code", "Section level", "Attached to Line No.", "Sort value", "Line No.")
        {
        }
        key(Key4; "User ID", "Statistic code", "Sort key by value")
        {
        }
        key(Key5; "User ID", "Statistic code", "Code")
        {
        }
        key(Key6; "User ID", "Section level", Open)
        {
        }
    }

    fieldgroups
    {
    }
}

