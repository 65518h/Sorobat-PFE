Table 8001569 "Workflow Document Comment"
{
    //GL2024  ID dans Nav 2009 : "8004228"
    // //+WKF+DOC DL 18/10/05 Workflow Comment Document

    Caption = 'Workflow Document Comment';

    fields
    {
        field(1; "Document Template"; Integer)
        {
            //blankzero = true;
            Caption = 'Document Template';
            NotBlank = true;
            TableRelation = "Workflow Document Template";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
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
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(7; Comment2; Text[80])
        {
            Caption = 'Comment 2';
        }
        field(8; Separator; Integer)
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
}

