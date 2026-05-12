Table 8001547 "BAR : Setup Cash Flow"
{
    //GL2024  ID dans Nav 2009 : "8001615"
    // //+RAP+TRESO GESWAY 26/06/02 Table de paramètres de la trésorerie

    Caption = 'BAR : Setup Cash Flow';
    // DrillDownPageID = 8001630;
    //LookupPageID = 8001630;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Journal Templates"; Code[20])
        {
            Caption = 'Journal Templates';
            TableRelation = "Gen. Journal Template".Name;
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

