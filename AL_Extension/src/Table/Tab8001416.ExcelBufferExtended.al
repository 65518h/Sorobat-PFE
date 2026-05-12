Table 8001416 "Excel Buffer Extended"
{
    // //+BGW+OFFICE GESWAY 10/10/02 Echange avec Microsoft Excel


    fields
    {
        field(1; xlRowID; Text[10])
        {
            Caption = 'xlRowID';
        }
        field(2; xlColID; Text[10])
        {
            Caption = 'xlColID';
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Cell Value"; Text[250])
        {
            Caption = 'Cell Value as Text';
        }
    }

    keys
    {
        key(STG_Key1; xlRowID, xlColID, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

