Table 8004131 "Planning Temp"
{
    // //PLANNING CW 08/11/99 Pour report planning

    Caption = 'Planning Temp';

    fields
    {
        field(1; Year; Integer)
        {
            Caption = 'Year';
        }
        field(2; Week; Integer)
        {
            Caption = 'Week';
        }
        field(3; "Group No."; Code[20])
        {
            Caption = 'Group No.';
            Description = 'N° ressource ou N° projet';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Day; Integer)
        {
            Caption = 'Day';
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; "Start Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(9; "Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(10; Private; Boolean)
        {
            Caption = 'Private';
        }
        field(11; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Confirm,Suggested,Deleted,Posted';
            OptionMembers = Confirm,Suggested,Deleted,Posted;
        }
    }

    keys
    {
        key(STG_Key1; Year, Week, "Group No.", "Line No.", Day)
        {
            Clustered = true;
        }
        key(STG_Key2; "Prod. Posting Group")
        {
        }
    }

    fieldgroups
    {
    }
}

