Codeunit 8004131 "Post Planning"
{

    trigger OnRun()
    begin
    end;


    procedure PostPlanningEntry(var pPlanningEntry: Record "Planning Entry")
    var
        lJobJnlLine: Record "Job Journal Line";
        lPlanningSetup: Record "Planning Setup";
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
    begin
        lPlanningSetup.Get;
        with pPlanningEntry do begin
            lJobJnlLine.Init;
            lJobJnlLine."Document No." := '';
            lJobJnlLine."Entry Type" := lJobJnlLine."entry type"::Usage;
            lJobJnlLine.Validate("Posting Date", Date);
            lJobJnlLine."Line No." := "Entry No.";
            lJobJnlLine."External Document No." := Format("Entry No.");
            lJobJnlLine.Validate("Job No.", "Job No.");
            lJobJnlLine.Type := lJobJnlLine.Type::Resource;
            lJobJnlLine.Validate("No.", "No.");
            lJobJnlLine.Validate("Gen. Prod. Posting Group", "Prod. Posting Group");
            lJobJnlLine.Validate("Work Type Code", "Work Type Code");
            lJobJnlLine.Validate("Job Task No.", "Job Task No.");
            lJobJnlLine.Description := Description;
            lJobJnlLine.Validate(Quantity, Quantity);
            //POINTAGE
            lJobJnlLine."Source Record ID" := "Source Record ID";
            lJobJnlLine."Source Line No." := "Source Line No.";
            //POINTAGE//
            Status := Status::Deleted;
            Modify;
            lJobJnlLine."Planning Entry No." := pPlanningEntry."Entry No.";
        end;

        lJobJnlPostLine.Run(lJobJnlLine);
    end;
}

