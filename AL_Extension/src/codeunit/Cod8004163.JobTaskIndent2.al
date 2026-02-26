Codeunit 8004163 "Job Task-Indent2"
{
    TableNo = "Job Task";

    trigger OnRun()
    begin
        rec.TestField("Job No.");
        if not
           Confirm(
             Text000 +
             Text001 +
             Text002 +
             Text003, true)
        then
            exit;
        JT := Rec;
        Indent(rec."Job No.");
    end;

    var
        Text000: label 'This function updates the indentation of all the Job Tasks.';
        Text001: label 'All Job Tasks between a Begin-Total and the matching End-Total are indented one level. ';
        Text002: label 'The Totaling for each End-total is also updated.';
        Text003: label '\\Do you want to indent the Job Tasks?';
        Text004: label 'Indenting the Job Tasks #1##########.';
        Text005: label 'End-Total %1 is missing a matching Begin-Total.';
        JT: Record "Job Task";
        Window: Dialog;
        JTNo: array[10] of Code[20];
        i: Integer;


    procedure Indent(JobNo: Code[20])
    begin
        Window.Open(Text004);
        JT.SetRange("Job No.", JobNo);
        with JT do
            if Find('-') then
                repeat
                    Window.Update(1, "Job Task No.");

                    if "Job Task Type" = "job task type"::"End-Total" then begin
                        if i < 1 then
                            Error(
                              Text005,
                              "Job Task No.");
                        Totaling := JTNo[i] + '..' + "Job Task No.";
                        i := i - 1;
                    end;

                    Indentation := i;
                    Modify;

                    if "Job Task Type" = "job task type"::"Begin-Total" then begin
                        i := i + 1;
                        JTNo[i] := "Job Task No.";
                    end;
                until Next = 0;

        Window.Close;
    end;
}

