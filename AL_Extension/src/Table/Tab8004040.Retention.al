Table 8004040 Retention
{
    // //RETENTION GESWAY 08/06/06 Retention

    Caption = 'Retention Terms';
    // LookupPageID = 8004040;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Due Date Calculation"; DateFormula)
        {
            Caption = 'Due Date Calculation';
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

