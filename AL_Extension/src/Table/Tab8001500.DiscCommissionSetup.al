Table 8001500 "Disc. Commission Setup"
{
    // //+RFA+ GESWAY 11/07/02 Paramètres remises, RFA et commissions

    Caption = 'Disc. Commission Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(10; "Calculate Sales Line Discount"; Boolean)
        {
            Caption = 'Calculate Sales Line Discount';
        }
        field(11; "Calc. Sales Line Back Disc."; Boolean)
        {
            Caption = 'Calc. Sales Line Back Disc.';
        }
        field(12; "Calc. Sales Line Commission"; Boolean)
        {
            Caption = 'Calc. Sales Line Commission';
        }
        field(23; "Calc. Purch. Line Discount"; Boolean)
        {
            Caption = 'Calc. Purch. Line Discount';
        }
        field(24; "Calc. Purch. Line Back Disc."; Boolean)
        {
            Caption = 'Calc. Purch. Line Back Disc.';
        }
        field(25; "Calc. Purch. Line Commission"; Boolean)
        {
            Caption = 'Calc. Purch. Line Commission';
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

