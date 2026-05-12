Codeunit 8001545 "Upgrade Workflow CommentLline"
{
    //GL2024  ID dans Nav 2009 : "8004298"
    trigger OnRun()
    var
        WkfJnlLine: Record "Workflow Journal Line";
        WkfCmtLine: Record "Workflow Comment Line";
        lProgress: Codeunit "Progress Dialog2";
    begin
        lProgress.Open('', WkfJnlLine.Count);
        WkfJnlLine.FindSet;
        repeat
            lProgress.Update;
            WkfCmtLine.SetRange("Journal Line No.", WkfJnlLine."Entry No.");
            WkfCmtLine.ModifyAll(Type, WkfJnlLine.Type);
            WkfCmtLine.ModifyAll("No.", WkfJnlLine."No.");
        until WkfJnlLine.Next = 0;
        lProgress.Close;
    end;
}

