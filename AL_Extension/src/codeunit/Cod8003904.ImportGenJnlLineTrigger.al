Codeunit 8003904 "Import GenJnlLine Trigger"
{
    // #7899 CW 19/03/10
    // //+ONE+IMPORT CW 19/03/10 Import Gen.JnlLine with Job Dimensions

    TableNo = "Gen. Journal Line";
    /*
    GL2024
        trigger OnRun()
        var
            lRec: Record 81;
            lJob: Record 8004160;
        begin
            SingleInstance.Get(ImportLog);
            case SingleInstance.
              ImportLog.PreImport            SingleInstance.SetInit(false);

                ImportLog.BeforeUpdatebegin
                if ImportLog."Import Line No." = 1 then begin
                        lRec.SetRange("Journal Template Name", "Journal Template Name");
                        lRec.SetRange("Journal Batch Name", "Journal Batch Name");
                        if lRec.Find('-') then
                            SingleInstance.Warning(ImportLog.Level::Severe, StrSubstNo(tBatchNotEmpty, "Journal Template Name", "Journal Batch Name"));
                    end;
                "Line No." := ImportLog."Import Line No." * 10000;
                if "Debit Amount" <> 0 then
                  Validate("Debit Amount")
                else
                    Validate("Credit Amount");
            end;

            ImportLog.PostImportbegin

                Reset;
            SetRange("Journal Template Name", "Journal Template Name");
            SetRange("Journal Batch Name", "Journal Batch Name");
            SetFilter("Job No.", '<>%1', '');
            if FindSet then
                repeat
                    lJob.Get("Job No.");
                    "Job No." := '';
                    Validate("Job No.", lJob."No.");
                until Next = 0;
        end;

    */

    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
        tBatchNotEmpty: label 'Batch journal %1 %2 is not empty';
}

