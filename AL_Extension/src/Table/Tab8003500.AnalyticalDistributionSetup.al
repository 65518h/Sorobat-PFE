Table 8003500 "Analytical Distribution Setup"
{
    // //+REP+ GESWAY 19/09/01 Nouvelle table de paramétrage

    Caption = 'Analytical Distribution Setup';
    //  LookupPageID = 8003500;
    PasteIsValid = false;

    fields
    {
        field(1; "Primary key"; Code[10])
        {
            Caption = 'Primary key';
        }
        field(2; "Gen Ledger Jnl Template Name"; Code[10])
        {
            Caption = 'General Ledger Journal Template Name';
            TableRelation = "Gen. Journal Template".Name where(Type = filter(General | 10));
        }
        field(3; "Gen Ledger Journal Batch Name"; Code[10])
        {
            Caption = 'General Ledger Journal Batch Name';

            trigger OnLookup()
            var
                NomFSCompta: Record "Gen. Journal Batch";
            begin
                NomFSCompta.SetRange("Journal Template Name", "Gen Ledger Jnl Template Name");
                if PAGE.RunModal(page::"General Journal Batches", NomFSCompta) = Action::LookupOK then
                    "Gen Ledger Journal Batch Name" := NomFSCompta.Name;
            end;
        }
        field(4; "Job Jnl Template Name"; Code[10])
        {
            Caption = 'Job Journal Template Name';
            TableRelation = "Job Journal Template".Name;
        }
        field(5; "Job Journal Batch Name"; Code[10])
        {
            Caption = 'Job Journal Batch Name';

            trigger OnLookup()
            var
                NomFSProjet: Record "Job Journal Batch";
            begin
                NomFSProjet.SetRange("Journal Template Name", "Job Jnl Template Name");
                if PAGE.RunModal(page::"Job Journal Batches", NomFSProjet) = Action::LookupOK then
                    "Job Journal Batch Name" := NomFSProjet.Name;
            end;
        }
    }

    keys
    {
        key(Key1; "Primary key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

