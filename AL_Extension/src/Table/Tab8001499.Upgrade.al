Table 8001499 Upgrade
{
    // //+REF+VERSION GESWAY 01/12/01 Gestion de la Version List

    DataPerCompany = false;

    fields
    {
        field(1; "Version List"; Text[80])
        {
        }
        field(2; "Step1 UserID"; Code[20])
        {
        }
        field(3; "Step1 DateTime"; DateTime)
        {
        }
        field(4; "Step1 Ellapsed Time (ms)"; Integer)
        {
        }
        field(5; "Step2 UserID"; Code[20])
        {
        }
        field(6; "Step2 DateTime"; DateTime)
        {
        }
        field(7; "Step2 Ellapsed Time (ms)"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Version List")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ModeleFeuille: Record "Gen. Journal Template";
        NomFeuille: Record "Gen. Journal Batch";
}

