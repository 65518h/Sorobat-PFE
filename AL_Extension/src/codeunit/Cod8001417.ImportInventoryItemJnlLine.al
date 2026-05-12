Codeunit 8001417 "Import Inventory ItemJnlLine"
{
    TableNo = "Item Journal Line";
    /*GL2024
        trigger OnRun()
        var
            lQty: Decimal;
            tNoItemJnlLine: Label 'No item journal line for item %1 at location %2.';
        begin
            SingleInstance.Get(ImportLog);

            CASE SingleInstance.Trigger OF

                ImportLog.Trigger::PreImport:     ;

                ImportLog.Trigger::BeforeUpdate:
                    BEGIN
                    lQty := "Qty. (Phys. Inventory)";
                    REC.SETRANGE("Journal Template Name", "Journal Template Name");
                    REC.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    REC.SETRANGE("Item No.", "Item No.");
                    REC.SETRANGE("Location Code", "Location Code");
                    IF REC.FIND('-') THEN BEGIN
                        REC.VALIDATE("Qty. (Phys. Inventory)", lQty);
                        REC.MODIFY;
                    END ELSE
                        IF lQty <> 0 THEN BEGIN
                            REC."Entry Type" := rec."Entry Type"::"Positive Adjmt.";
                            REC."Posting Date" := WORKDATE;
                            REC.VALIDATE("Item No.");
                            REC."Phys. Inventory" := TRUE;
                            REC.VALIDATE("Qty. (Phys. Inventory)", lQty);
                        END ELSE
                            SingleInstance.Warning(ImportLog.Level::Error, STRSUBSTNO(tNoItemJnlLine, rec."Item No.", rec."Location Code"));
                END;

                ImportLog.Trigger::PostImport:
                    BEGIN
                END;
                ELSE
            END;
        end;
    */
    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
        tAlreadyExists: Label 'Item %1 %2 already exists in this journal';
        tModify: Label 'La ligne de l''article %1 %2 a été modifiée.';
}

