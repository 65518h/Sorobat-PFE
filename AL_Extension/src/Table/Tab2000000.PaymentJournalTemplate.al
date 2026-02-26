Table 2000000 "Payment Journal Template"
{
    Caption = 'Payment Journal Template';
    DataCaptionFields = Name;
    //LookupPageID = 2000000;

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Name';
            NotBlank = true;
        }
        field(2; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(5; "Test Report ID"; Integer)
        {
            Caption = 'Test Report ID';
            //GL2024 License  TableRelation =Object.ID where(Type = const(Report));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Report));
            //GL2024 License


        }
        field(6; "Form ID"; Integer)
        {
            Caption = 'Form ID';
            //GL2024 License TableRelation = Object.ID where(Type = const(page));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(page));
            //GL2024 License
        }
        field(10; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";

            trigger OnValidate()
            begin
                PaymJnlLine.SetRange("Journal Template Name", Name);
                PaymJnlLine.ModifyAll("Source Code", "Source Code");
            end;
        }
        field(11; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(15; "Test Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report),
                                                                           "Object ID" = field("Test Report ID")));
            Caption = 'Test Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Form Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Page),
                                                                           "Object ID" = field("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            TableRelation = "Bank Account";
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        PaymJnlBatch.SetRange("Journal Template Name", Name);
        PaymJnlBatch.DeleteAll(true);
        PaymJnlLine.SetRange("Journal Template Name", Name);
        PaymJnlLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        Validate("Form ID");
        SourceCodeSetup.Get;
        "Source Code" := SourceCodeSetup."Payment Journal";
    end;

    var
        SourceCodeSetup: Record "Source Code Setup";
        PaymJnlBatch: Record "Paym. Journal Batch";
        PaymJnlLine: Record "Payment Journal Line";
}

