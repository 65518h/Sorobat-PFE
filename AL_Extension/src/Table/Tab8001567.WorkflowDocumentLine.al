Table 8001567 "Workflow Document Line"
{
    //GL2024  ID dans Nav 2009 : "8004226"
    // //+WKF+DOC CW 24/08/02 Workflow Document
    //                CW 07/08/03 Commentaire poussé de 80 à 120

    Caption = 'Workflow Document Line';
    // DrillDownPageID = 8004212;
    //LookupPageID = 8004212;

    fields
    {
        field(1; "Document Template"; Integer)
        {
            Caption = 'Document Template';
            TableRelation = "Workflow Document Template";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Workflow Document"."No." where("Document Template" = field("Document Template"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[120])
        {
            Caption = 'Comment';
        }
        field(7; "User ID"; Code[20])
        {
            Caption = 'Code utilisateur';
            //GL2024  TableRelation = Login;
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document Template", "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Document.Get("Document Template", "No.") then
            Document.TestField(Open);
    end;

    trigger OnInsert()
    begin
        if Date = 0D then
            Date := Today;
        if "User ID" = '' then
            "User ID" := UserId;
        if Document.Get("Document Template", "No.") then
            Document.TestField(Open);
    end;

    trigger OnModify()
    begin
        if Document.Get("Document Template", "No.") then
            Document.TestField(Open);
    end;

    var
        Document: Record "Workflow Document";


    procedure SetUpNewLine()
    var
        CommentLine: Record "Workflow Document Line";
    begin
        CommentLine.SetRange("Document Template", "Document Template");
        CommentLine.SetRange("No.", "No.");
        if CommentLine.IsEmpty then
            Date := WorkDate;
    end;
}

