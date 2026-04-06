Table 8001536 "BAR : Reconciliation Mode"
{
    //GL2024  ID dans Nav 2009 : "8001604"
    // //+RAP+RAPPRO GESWAY 26/06/02 Table des modes de rapprochement (le N° interne ne doit jamais être modifié)
    //                          Données exportées avec le fob (multi-sociétés)

    Caption = 'B.A.R. : Reconciliation Mode';
    DataPerCompany = false;
    // LookupPageID = 8001604;

    fields
    {
        field(1; "Reconciliation Mode"; Text[30])
        {
            Caption = 'Reconciliation Mode';
        }
        field(2; "Internal No."; Integer)
        {
            Caption = 'Internal No.';
        }
    }

    keys
    {
        key(STG_Key1; "Reconciliation Mode")
        {
            Clustered = true;
        }
        key(STG_Key2; "Internal No.")
        {
        }
    }

    fieldgroups
    {
    }
}

