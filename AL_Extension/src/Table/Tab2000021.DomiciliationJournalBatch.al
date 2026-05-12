Table 2000021 "Domiciliation Journal Batch"
{
    Caption = 'Domiciliation Journal Batch';
    DataCaptionFields = Name, Description;
    // LookupPageID = 2000021;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "Domiciliation Journal Template";
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
        DomJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        DomJnlLine.SetRange("Journal Batch Name", Name);
        DomJnlLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        LockTable;
        DomJnlTemplate.Get("Journal Template Name");
        "Reason Code" := DomJnlTemplate."Reason Code";
    end;

    trigger OnRename()
    begin
        DomJnlLine.SetRange("Journal Template Name", xRec."Journal Template Name");
        DomJnlLine.SetRange("Journal Batch Name", xRec.Name);
        if DomJnlLine.Find('-') then
            repeat
                DomJnlLine.Rename("Journal Template Name", Name, DomJnlLine."Line No.");
            until not DomJnlLine.Find('-');
    end;

    var
        DomJnlTemplate: Record "Domiciliation Journal Template";
        DomJnlLine: Record "Domiciliation Journal Line";
}

