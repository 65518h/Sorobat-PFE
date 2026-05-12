Table 8001558 "Workflow Procedure Header"
{
    //GL2024  ID dans Nav 2009 : "8004205"
    // //+WKF+MAIL OFE 19/03/2010
    // //+WKF+ CW 03/08/02 New

    Caption = 'Workflow Procedure Header';
    // DrillDownPageID = 8004204;
    //LookupPageID = 8004204;

    fields
    {
        field(1; "Workflow Type"; Integer)
        {
            //blankzero = true;
            Caption = 'Workflow Type';
            TableRelation = "Workflow Type";
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(4; "Role ID"; Code[10])
        {
            Caption = 'Role ID';
            TableRelation = "Workflow Role";
        }
    }

    keys
    {
        key(STG_Key1; "Workflow Type", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lWorkflowProcLine: Record "Workflow Procedure Line";
        lWorkflowJnlLine: Record "Workflow Journal Line";
    begin
        lWorkflowJnlLine.SetCurrentkey(Type, "Workflow Code", Open);
        lWorkflowJnlLine.SetRange(Type, "Workflow Type");
        lWorkflowJnlLine.SetRange("Workflow Code", Code);
        lWorkflowJnlLine.SetRange(Open, true);
        if not lWorkflowJnlLine.IsEmpty then
            Error(tWorkflowJnlLineExists, lWorkflowJnlLine.Count, Code)
        else begin
            lWorkflowJnlLine.SetRange(Open);
            lWorkflowJnlLine.DeleteAll;
        end;
        lWorkflowProcLine.SetRange("Workflow Type", "Workflow Type");
        lWorkflowProcLine.SetRange("Workflow Code", Code);
        lWorkflowProcLine.DeleteAll;
    end;

    var
        tWorkflowJnlLineExists: label '%1 opened workflow journal line(s) for %2';
}

