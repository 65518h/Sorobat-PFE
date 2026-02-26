Table 8001532 "BAR : Setup"
{
    //GL2024  ID dans Nav 2009 : "8001600"
    // //+RAP+RAPPRO GESWAY 26/06/02 Table de paramètres de rapprochement

    Caption = 'Bank Account Reconciliation Setup';
    //DrillDownPageID = 8001600;
    //LookupPageID = 8001600;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Default Bank No."; Code[20])
        {
            Caption = 'Default Bank No.';
            TableRelation = "Bank Account";
        }
        field(3; "Number of Iterations"; Integer)
        {
            Caption = 'Number of Iterations';
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

