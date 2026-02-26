Table 8001900 "Subscription Setup"
{
    // #8025 CW 28/05/10
    // //+ABO+ GESWAY 15/07/02 Table de paramètres abonnements

    Caption = 'Subscription Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(8001901; "Sales Contract Nos."; Code[10])
        {
            Caption = 'Subscr. Contract Nos.';
            TableRelation = "No. Series";
        }
        field(8001902; "Invoice Line Description"; Text[50])
        {
            Caption = 'Invoice Line Description';
        }
        field(8001903; "Sales Contract Posting Desc."; Text[50])
        {
            Caption = 'Sales Contract Posting Desc.';
        }
        field(8001904; "Sales Comb. Inv. Posting Desc."; Text[50])
        {
            Caption = 'Sales Comb. Inv. Posting Desc.';
        }
        field(8001905; "Invoice Text Code"; Code[10])
        {
            Caption = 'Invoice Text Code';
            TableRelation = "Standard Text";
        }
        field(8001906; "Prorata Increase"; Text[50])
        {
            Caption = 'Prorata Increase';
        }
        field(8001907; "Prorata Decrease"; Text[50])
        {
            Caption = 'Prorata Decrease';
        }
        field(8001911; "Purch. Contract Nos."; Code[10])
        {
            Caption = 'Subscr. Contract Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

