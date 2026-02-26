Table 8001568 "Workflow Document Link"
{
    //GL2024  ID dans Nav 2009 : "8004227"
    // //+WKF+DOC CW 24/08/02 Workflow Document

    Caption = 'Workflow Document Link';
    //  DrillDownPageID = 8004212;
    // LookupPageID = 8004212;

    fields
    {
        field(1; "Document Template"; Integer)
        {
            Caption = 'Document Template';
            TableRelation = "Workflow Document Template";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;
            TableRelation = "Workflow Document"."No." where("Document Template" = field("Document Template"));
        }
        field(3; Type; Integer)
        {
            //blankzero = true;
            Caption = 'Type';
            NotBlank = true;
            TableRelation = "Workflow Type" where("Link Enable" = const(true));

            trigger OnValidate()
            begin
                if Type <> xRec.Type then begin
                    "No." := '';
                    Name := '';
                end;
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;

            trigger OnLookup()
            begin
                "No." := WorkflowNo.Lookup(Type, '', "No.");
                Name := WorkflowNo.GetName(Type, '', "No.");
            end;

            trigger OnValidate()
            begin
                Name := WorkflowNo.GetName(Type, '', "No.");
            end;
        }
        field(5; Name; Text[30])
        {
            Caption = 'Description';
        }
        field(6; Remark; Text[80])
        {
            Caption = 'Remark';
        }
    }

    keys
    {
        key(Key1; "Document Template", "Document No.", Type, "No.")
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
    begin
        if Name = '' then
            Name := WorkflowNo.GetName(Type, '', "No.");
    end;

    var
        WorkflowNo: Codeunit "Workflow No.";
}

