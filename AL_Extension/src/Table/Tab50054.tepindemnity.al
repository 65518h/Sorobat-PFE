Table 50054 "tep indemnity"
{

    fields
    {
        field(1; "code indemnity"; Code[20])
        {
        }
        field(2; "code salarie"; Code[10])
        {
        }
        field(3; "montant par de faut"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "code indemnity")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

