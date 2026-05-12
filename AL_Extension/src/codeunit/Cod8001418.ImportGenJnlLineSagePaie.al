Codeunit 8001418 "Import GenJnlLine SagePaie"
{
    // #6569 CW 14/10/08
    // //+REF+IMPORT CW 21/07/03 Import customize

    TableNo = "Gen. Journal Line";
    /* GL2024
        trigger OnRun()
        var
            lRec: Record 81;
        begin

            SingleInstance.Get(ImportLog);

            CASE SingleInstance.Trigger OF

      ImportLog.Trigger::PreImport:;

                ImportLog.Trigger::BeforeUpdate:BEGIN
                    IF ImportLog."Import Line No." = 1 THEN BEGIN
                        lRec.SETRANGE("Journal Template Name", "Journal Template Name");
                        lRec.SETRANGE("Journal Batch Name", "Journal Batch Name");
                        IF lRec.FIND('-') THEN
                            SingleInstance.Warning(ImportLog.Level::Severe, STRSUBSTNO(tBatchNotEmpty, "Journal Template Name", "Journal Batch Name"));
                    END;
                    "Line No." := ImportLog."Import Line No." * 10000;

                    IF "External Document No." <> '' THEN BEGIN
                        IF "External Document No." = 'C' THEN
                            VALIDATE(Amount, -Amount)
                        ELSE
                            VALIDATE(Amount);
                        "External Document No." := '';
                        "Document No." := 'PAI' + "Document No.";
                    END;

                    //#6569
                    IF Amount = 0 THEN BEGIN
                        IF "Debit Amount" <> 0 THEN
                            VALIDATE(Amount, "Debit Amount")
                        ELSE
                            VALIDATE(Amount, -"Credit Amount");
                    END;
                    //#6569//

                END;

                ImportLog.Trigger::PostImport:;

                ELSE
            END;
        end;
    */
    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
        tBatchNotEmpty: label 'Batch journal %1 %2 is not empty';
}

