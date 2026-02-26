Table 50059 "Bilan Decompte"
{

    fields
    {
        field(1; "Code Marché"; Code[20])
        {
            TableRelation = Job."No.";
        }
        field(2; Date; Date)
        {
        }
        field(3; Designatiion; Text[150])
        {
        }
        field(5; "Mantant HTVA"; Decimal)
        {
        }
        field(9; Niveau; Integer)
        {
        }
        field(10; Taux; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code Marché", Date, Designatiion)
        {
            Clustered = true;
        }
        key(Key2; Niveau)
        {
        }
    }

    fieldgroups
    {
    }
}

