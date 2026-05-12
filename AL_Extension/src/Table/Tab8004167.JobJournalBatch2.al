Table 8004167 "Job Journal Batch2"
{
    // //POINTAGE GESWAY 06/06/02 Ajout du champ "Name Journal Transfer"
    // //PROJET GESWAY 30/11/04 Ajout du champ "Default Location Code"
    //                          Alimentation de "Default Location Code" dans fonction SetupNewBatch

    Caption = 'Job Journal Batch';
    DataCaptionFields = Name, Description;
    // LookupPageID = 8004175;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            NotBlank = true;
            TableRelation = "Job Journal Template2";
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

            trigger OnValidate()
            begin
                if "Reason Code" <> xRec."Reason Code" then begin
                    JobJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                    JobJnlLine.SetRange("Journal Batch Name", Name);
                    JobJnlLine.ModifyAll("Reason Code", "Reason Code");
                    Modify;
                end;
            end;
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if "No. Series" <> '' then begin
                    JobJnlTemplate.Get("Journal Template Name");
                    if JobJnlTemplate.Recurring then
                        Error(
                          Text000,
                          FieldCaption("Posting No. Series"));
                    if "No. Series" = "Posting No. Series" then
                        Validate("Posting No. Series", '');
                end;
            end;
        }
        field(6; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            begin
                if ("Posting No. Series" = "No. Series") and ("Posting No. Series" <> '') then
                    FieldError("Posting No. Series", StrSubstNo(Text001, "Posting No. Series"));
                JobJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                JobJnlLine.SetRange("Journal Batch Name", Name);
                JobJnlLine.ModifyAll("Posting No. Series", "Posting No. Series");
                Modify;
            end;
        }
        field(22; Recurring; Boolean)
        {
            CalcFormula = lookup("Job Journal Template2".Recurring where(Name = field("Journal Template Name")));
            Caption = 'Recurring';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003900; "Transfer Journal Name"; Code[10])
        {
            Caption = 'Transfer Journal Name';
            TableRelation = "Job Journal Batch2".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(8003901; "Default Location Code"; Code[20])
        {
            Caption = 'Default Location Code';
            TableRelation = Location;
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
        JobJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        JobJnlLine.SetRange("Journal Batch Name", Name);
        JobJnlLine.DeleteAll(true);
    end;

    trigger OnInsert()
    begin
        LockTable;
        JobJnlTemplate.Get("Journal Template Name");
    end;

    trigger OnRename()
    begin
        JobJnlLine.SetRange("Journal Template Name", xRec."Journal Template Name");
        JobJnlLine.SetRange("Journal Batch Name", xRec.Name);
        while JobJnlLine.Find('-') do
            JobJnlLine.Rename("Journal Template Name", Name, JobJnlLine."Line No.");
    end;

    var
        Text000: label 'Only the %1 field can be filled in on recurring journals.';
        Text001: label 'must not be %1';
        JobJnlTemplate: Record "Job Journal Template2";
        JobJnlLine: Record "Job Journal Line2";


    procedure SetupNewBatch()
    begin
        JobJnlTemplate.Get("Journal Template Name");
        "No. Series" := JobJnlTemplate."No. Series";
        "Posting No. Series" := JobJnlTemplate."Posting No. Series";
        "Reason Code" := JobJnlTemplate."Reason Code";
        //PROJET
        "Default Location Code" := JobJnlTemplate."Default Location Code";
        //PROJET//
    end;
}

