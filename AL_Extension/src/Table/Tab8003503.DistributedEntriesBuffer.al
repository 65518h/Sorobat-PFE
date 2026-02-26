Table 8003503 "Distributed Entries Buffer"
{
    // //+REP+ GESWAY 19/09/01 Nouvelle table pour stockage des N° de séquence des écritures traitées

    Caption = 'Distributed Entries Buffer';

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'General Ledger,Job,G/L Journal,Job Journal';
            OptionMembers = "General Ledger",Job,"G/L Journal","Job Journal";
        }
        field(2; "Entry no."; Integer)
        {
            Caption = 'Entry no.';
        }
        field(3; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
        }
        field(4; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
    }

    keys
    {
        key(Key1; Type, "Entry no.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        EcrARepartir.SetCurrentkey("Entry Type", "Origin Entry No.");
        EcrARepartir.SetRange("Entry Type", Type);
        EcrARepartir.SetRange("Origin Entry No.", "Entry no.");
        EcrARepartir.DeleteAll;
    end;

    var
        EcrARepartir: Record "Entries to Distribue Buffer";
}

