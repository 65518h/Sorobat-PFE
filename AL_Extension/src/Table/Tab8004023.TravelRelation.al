Table 8004023 "Travel Relation"
{
    // //+ONE+TRAVEL CW 16/10/07

    Caption = 'Travel Relation';

    fields
    {
        field(1; "Resource Travel Code"; Code[20])
        {
            Caption = 'From';
            NotBlank = true;
            TableRelation = "Travel Code";
        }
        field(2; "Job Travel Code"; Code[20])
        {
            Caption = 'To';
            NotBlank = true;
            TableRelation = "Travel Code";
        }
        field(3; "Travel Work Type Code"; Code[10])
        {
            Caption = 'Travel Work Type Code';
            NotBlank = true;
            TableRelation = "Work Type" where("Work Time Type" = const(Transport));
        }
        field(4; "Travel Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Travel Quantity';
        }
        field(5; "Driver Work Type Code"; Code[10])
        {
            Caption = 'Driver Work Type Code';
            NotBlank = true;
            TableRelation = "Work Type" where("Work Time Type" = const(Transport));
        }
        field(6; "Driver Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Driver Quantity';
        }
    }

    keys
    {
        key(STG_Key1; "Resource Travel Code", "Job Travel Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

