Table 50026 "Parametre declaration emp"
{

    fields
    {
        field(1; Annexe; Option)
        {
            OptionMembers = " ","Annexe II","Annexe III","Annexe IV","Annexe V","Annexe VI","Annexe VII";
        }
        field(2; Compte; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(3; Taux; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(4; Position; Code[4])
        {
        }
        field(5; "Compte CGC"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
    }

    keys
    {
        key(Key1; Annexe, Compte)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

