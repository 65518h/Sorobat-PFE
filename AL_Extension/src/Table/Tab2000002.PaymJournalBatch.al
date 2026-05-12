Table 2000002 "Paym. Journal Batch"
{
    Caption = 'Paym. Journal Batch';
    DataCaptionFields = Name, Description;
    // LookupPageID = 2000003;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "Payment Journal Template";
        }
        field(2; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(5; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = " ";
            OptionCaption = ' ,,Processed,Posted';
            OptionMembers = " ",,Processed,Posted;
        }
    }

    keys
    {
        key(STG_Key1; "Journal Template Name", Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PaymJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        PaymJnlLine.SetRange("Journal Batch Name", Name);
        PaymJnlLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        LockTable;
        PaymJnlTemplate.Get("Journal Template Name");
        "Reason Code" := PaymJnlTemplate."Reason Code";
    end;

    trigger OnRename()
    begin
        PaymJnlLine.SetRange("Journal Template Name", xRec."Journal Template Name");
        PaymJnlLine.SetRange("Journal Batch Name", xRec.Name);
        if PaymJnlLine.Find('-') then
            repeat
                PaymJnlLine.Rename("Journal Template Name", Name, PaymJnlLine."Line No.");
            until (PaymJnlLine.Next = 0);
    end;

    var
        PaymJnlTemplate: Record "Payment Journal Template";
        PaymJnlLine: Record "Payment Journal Line";
}

