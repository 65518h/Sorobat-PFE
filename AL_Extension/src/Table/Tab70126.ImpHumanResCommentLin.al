Table 70126 "Imp Human Res. Comment Lin"
{

    fields
    {
        field(1; "Table Name"; Option)
        {
            OptionMembers = Employee,"Alternative Address","Employee Qualification","Employee Relative","Employee Absence","Misc. Article Information","Confidential Information","Prepay ledger";
        }
        field(2; "No."; Code[20])
        {
        }
        field(3; "Table Line No."; Integer)
        {
        }
        field(4; "Alternative Address Code"; Code[10])
        {
        }
        field(6; "Line No."; Integer)
        {
        }
        field(7; Date; Date)
        {
        }
        field(8; "Code"; Code[10])
        {
        }
        field(9; Comment; Text[80])
        {
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Table Name", "No.", "Table Line No.", "Alternative Address Code", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

