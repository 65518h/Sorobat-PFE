Table 8001562 "Workflow Comment Line"
{//GL2024  ID dans Nav 2009 : "8004211"
    // //+WKF+DOC CW 24/08/02 Workflow Document
    // //+BGW+MEMOPAD CW 11/02/05 +Separator

    Caption = 'Workflow Comment Line';
    //  DrillDownPageID = 8004212;
    // LookupPageID = 8004212;

    fields
    {
        field(1; "Journal Line No."; Integer)
        {
            Caption = 'Journal Line No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(9; "Journal Entry No. Filter"; Integer)
        {
            Caption = 'Entry No. Filter';
            FieldClass = FlowFilter;
        }
        field(12; Type; Integer)
        {
            Caption = 'Type';
            TableRelation = "Workflow Type";
        }
        field(13; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Journal Line No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        lWKFJournalLine: Record "Workflow Journal Line";
    begin
        TestField("Journal Line No.");
        if lWKFJournalLine.Get("Journal Line No.") then begin
            Type := lWKFJournalLine.Type;
            "No." := lWKFJournalLine."No.";
        end;
        Code := UserId;
    end;

    var
        tNoLineSelected: label 'No line selected';


    procedure SetUpNewLine()
    var
        lCommentLine: Record "Workflow Comment Line";
    begin
        lCommentLine.SetRange("Journal Line No.", "Journal Line No.");
        lCommentLine.SetRange(Date, WorkDate);
        if lCommentLine.IsEmpty then
            Date := WorkDate;
    end;
}

