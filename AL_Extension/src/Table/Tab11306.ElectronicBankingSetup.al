Table 11306 "Electronic Banking Setup"
{
    Caption = 'Electronic Banking Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Summarize Gen. Jnl. Lines"; Boolean)
        {
            Caption = 'Summarize Gen. Jnl. Lines';
            InitValue = true;
        }
        field(3; "Cut off Payment Message Texts"; Boolean)
        {
            Caption = 'Cut off Payment Message Texts';
            InitValue = false;
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

