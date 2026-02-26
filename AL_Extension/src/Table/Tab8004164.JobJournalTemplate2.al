Table 8004164 "Job Journal Template2"
{
    // //PROJET GESWAY 30/11/04 Ajout du champ "Default Location Code"

    Caption = 'Job Journal Template';
    // DrillDownPageID = 8004174;
    //LookupPageID = 8004174;

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
            //GL2024 License  TableRelation = Object.ID where(Type = const(Report));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(report));
            //GL2024 License
        }
        field(6; "Form ID"; Integer)
        {
            Caption = 'Form ID';
            //GL2024 License   TableRelation = Object.ID where(Type = const(page));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(page));
            //GL2024 License

            trigger OnValidate()
            begin
                if "Form ID" = 0 then
                    Validate(Recurring);
            end;
        }
        field(7; "Posting Report ID"; Integer)
        {
            Caption = 'Posting Report ID';
            //GL2024 License  TableRelation = Object.ID where(Type = const(Report));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(report));
            //GL2024 License
        }
        field(8; "Force Posting Report"; Boolean)
        {
            Caption = 'Force Posting Report';
        }
        field(10; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";

            trigger OnValidate()
            begin
                JobJnlLine.SetRange("Journal Template Name", Name);
                JobJnlLine.ModifyAll("Source Code", "Source Code");
                Modify;
            end;
        }
        field(11; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(12; Recurring; Boolean)
        {
            Caption = 'Recurring';

            trigger OnValidate()
            begin
                if Recurring then
                    "Form ID" := page::"Recurring Job Jnl."
                else
                    "Form ID" := page::"Job Journal";
                "Test Report ID" := Report::"Job Journal - Test";
                "Posting Report ID" := Report::"Job Register";
                SourceCodeSetup.Get;
                "Source Code" := SourceCodeSetup."Job Journal";
                if Recurring then
                    TestField("No. Series", '');
            end;
        }
        field(13; "Test Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report),
                                                                           "Object ID" = field("Test Report ID")));
            Caption = 'Test Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Form Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(page),
                                                                           "Object ID" = field("Form ID")));
            Caption = 'Form Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Posting Report Name"; Text[80])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report),
                                                                           "Object ID" = field("Posting Report ID")));
            Caption = 'Posting Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if "No. Series" <> '' then begin
                    if Recurring then
                        Error(
                          Text000,
                          FieldCaption("Posting No. Series"));
                    if "No. Series" = "Posting No. Series" then
                        "Posting No. Series" := '';
                end;
            end;
        }
        field(17; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
                    FieldError("Posting No. Series", StrSubstNo(Text001, "Posting No. Series"));
            end;
        }
        field(8003901; "Default Location Code"; Code[20])
        {
            Caption = 'Default Location Code';
            TableRelation = Location;
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
        JobJnlLine.SetRange("Journal Template Name", Name);
        JobJnlLine.DeleteAll(true);
        JobJnlBatch.SetRange("Journal Template Name", Name);
        JobJnlBatch.DeleteAll;
    end;

    trigger OnInsert()
    begin
        Validate("Form ID");
    end;

    trigger OnRename()
    begin
        ReservEngineMgt.RenamePointer(Database::"Job Journal Line2",
          0, xRec.Name, '', 0, 0,
          0, Name, '', 0, 0);
    end;

    var
        Text000: label 'Only the %1 field can be filled in on recurring journals.';
        Text001: label 'must not be %1';
        JobJnlBatch: Record "Job Journal Batch2";
        JobJnlLine: Record "Job Journal Line2";
        SourceCodeSetup: Record "Source Code Setup";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
}

