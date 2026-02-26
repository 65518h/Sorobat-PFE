Table 8001559 "Workflow Procedure Line"
{
    //GL2024  ID dans Nav 2009 : "8004206"
    // //+WKF+MAIL OFE 19/03/2010
    // //+WKF+ MB 10/01/07 Ajout "Pre Trigger ID"
    // //+WKF+ MB 11/09/06 Ajout "Default Next Operation No."
    //            12/09/06 Correction du OnDelete, manque filtre sur "operation No."
    // //+WKF+ CW 03/08/02 New

    Caption = 'Workflow Procedure Line';

    fields
    {
        field(1; "Workflow Type"; Integer)
        {
            //blankzero = true;
            Caption = 'Workflow Type';
            TableRelation = "Workflow Type";
        }
        field(2; "Workflow Code"; Code[10])
        {
            Caption = 'Workflow Code';
            TableRelation = "Workflow Procedure Header".Code where("Workflow Type" = field("Workflow Type"));
        }
        field(3; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
        }
        field(4; "Next Operation No."; Code[30])
        {
            Caption = 'Next Operation No.';
        }
        field(5; "Default Next Operation No."; Code[10])
        {
            Caption = 'Default Next Operation No.';

            trigger OnValidate()
            var
                lWkfProcLine: Record "Workflow Procedure Line";
                tError: label 'You have to select an existing Operation No. and distinct from %1';
            begin
                if "Default Next Operation No." <> '' then
                    if not lWkfProcLine.Get("Workflow Type", "Workflow Code", "Default Next Operation No.")
                      or ("Operation No." = "Default Next Operation No.") then
                        Error(tError, "Operation No.");
            end;
        }
        field(6; "Role ID"; Code[10])
        {
            Caption = 'Role ID';
            TableRelation = "Workflow Role";
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(8; Notify; Boolean)
        {
            Caption = 'Notify';
        }
        field(9; "Trigger ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Post Trigger ID';
            TableRelation = "Workflow Trigger"."Trigger ID" where("Workflow Type" = field("Workflow Type"));

            trigger OnValidate()
            var
                lTrigger: Record "Workflow Trigger";
            begin
                if ("Confirmation Message" = '') or (xRec."Trigger ID" <> "Trigger ID") then
                    if lTrigger.Get("Workflow Type", "Trigger ID") then
                        "Confirmation Message" := lTrigger.Description
                    else
                        "Confirmation Message" := '';
            end;
        }
        field(10; "Confirmation Message"; Text[30])
        {
            Caption = 'Message de confirmation';
        }
        field(11; "Pre Trigger ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Pre Trigger ID';
            TableRelation = "Workflow Trigger"."Trigger ID" where("Workflow Type" = field("Workflow Type"));

            trigger OnValidate()
            var
                lTrigger: Record "Workflow Trigger";
            begin
            end;
        }
        field(14; CommentBLOB; Blob)
        {
        }
        field(15; "Notify By Mail"; Boolean)
        {
            Caption = 'Notify by Mail';
        }
    }

    keys
    {
        key(Key1; "Workflow Type", "Workflow Code", "Operation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lWorkflowJnlLine: Record "Workflow Journal Line";
    begin
        lWorkflowJnlLine.SetCurrentkey(Type, "Workflow Code", Open);
        lWorkflowJnlLine.SetRange(Type, "Workflow Type");
        lWorkflowJnlLine.SetRange("Workflow Code", "Workflow Code");
        //+WKF+
        lWorkflowJnlLine.SetRange("Operation No.", "Operation No.");
        //+WKF+//
        lWorkflowJnlLine.SetRange(Open, true);
        if not lWorkflowJnlLine.IsEmpty then
            Error(tWorkflowJnlLineExists, lWorkflowJnlLine.Count)
        else begin
            lWorkflowJnlLine.SetRange(Open);
            lWorkflowJnlLine.DeleteAll;
        end;
    end;

    var
        tWorkflowJnlLineExists: label '%1 opened workflow journal line(s) for this line';
}

