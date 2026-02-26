Codeunit 8001406 "Replication Trigger"
{
    // //+REF+REPLIC CW 28/04/05 Trigger Management
    //    SingleInstance = Yes, to be stopped during Replication itself

    Permissions = TableData Vendor = rimd,
                  TableData Item = rimd,
                  TableData "Item Translation" = rimd,
                  TableData "BOM Component" = rimd,
                  TableData "Comment Line" = rimd,
                  TableData "Item Vendor" = rimd,
                  TableData Resource = rimd,
                  TableData "Standard Vendor Purchase Code" = rimd,
                  TableData "Resource Price" = rimd,
                  TableData "Resource Cost" = rimd,
                  TableData "Unit of Measure" = rimd,
                  TableData "Resource Unit of Measure" = rimd,
                  TableData "Order Address" = rimd,
                  TableData "Extended Text Header" = rimd,
                  TableData "Extended Text Line" = rimd,
                  TableData "Vendor Bank Account" = rimd,
                  TableData "Default Dimension" = rimd,
                  TableData Contact = rimd,
                  TableData "Item Variant" = rimd,
                  TableData "Item Unit of Measure" = rimd,
                  TableData "Stockkeeping Unit" = rimd,
                  TableData "Item Substitution" = rimd,
                  TableData "Item Cross Reference" = rimd,
                  TableData "Nonstock Item" = rimd,
                  TableData "Sales Price" = rimd,
                  TableData "Sales Line Discount" = rimd,
                  TableData "Purchase Price" = rimd,
                  TableData "Purchase Line Discount" = rimd,
                  TableData Translation2 = rimd,
                  TableData Bitmap = rimd,
                  //TableData 8003916 = rimd,
                  TableData Tree = rimd,
                  TableData "Interim Mission" = rimd,
                  TableData "Resource / Resource Group" = rimd,
                  TableData "Structure Component" = rimd,
                  TableData "Description Line" = rimd,
                  TableData "Vendor Item Category Group" = rimd,
                  TableData "Workflow Document" = rimd;
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        ReplicationLog: Record "Replication Log";
        KeyField: array[4] of FieldRef;
        tPrimaryKeyError: label 'Primary Key can''t contain more than %1 fields for "%2" replication.';
        ReplicationTable: Record "Replication Table";
        tRenameError: label 'Replication not enabled for rename trigger.';
        tNotEditable: label 'Table "%1" can only be update by replication from "%2" company.';
        Suspend: Boolean;
        tReplicateRecord: label 'Cet élément de la table "%1" ne peut être modifié car il provient d''une réplication de la société "%2" \\ et ne figure pas dans la liste des exceptions';
        Enabled: Boolean;
        tReplicateFieldRecord: label 'Le champ "%1" de la table "%2" ne peut être modifié car il provient d''une réplication de la société "%3" \\ et ne figure pas dans la liste des exceptions';

    //GL2024 
    procedure OnInsert(var pRecordRef: RecordRef)
    begin
        if Suspend or not Enabled then
            exit
        else
            if not ReplicationTable.Get(pRecordRef.Number) then
                lUpdate(pRecordRef, ReplicationLog."Trigger"::Insert)
            else
                lCheckEditable(pRecordRef);
    end;


    procedure OnModify(var pRecordRef: RecordRef; var pRecordxRef: RecordRef)
    begin
        if Suspend or not Enabled then
            exit
        else
            if not ReplicationTable.Get(pRecordRef.Number) then
                lUpdate(pRecordRef, ReplicationLog."Trigger"::Modify)
            else
                lCheckModify(pRecordRef, pRecordxRef)
        //  lCheckEditable(pRecordRef);
    end;


    procedure OnDelete(var pRecordRef: RecordRef)
    begin
        if Suspend or not Enabled then
            exit
        else
            if not ReplicationTable.Get(pRecordRef.Number) then
                lUpdate(pRecordRef, ReplicationLog."Trigger"::Delete)
            else
                lCheckEditable(pRecordRef);
    end;


    procedure OnRename(var pxRecordRef: RecordRef; var pRecordRef: RecordRef)
    begin
        if Suspend or not Enabled then
            exit
        else
            if not ReplicationTable.Get(pRecordRef.Number) then begin
                lSetKey(pRecordRef, 0);
                with ReplicationLog do begin
                    "To Key 1" := "Key 1";
                    "To Key 2" := "Key 2";
                    "To Key 3" := "Key 3";
                    "To Key 4" := "Key 4";
                    "To Key 5" := "Key 5";
                    "To Key 6" := "Key 6";
                    "To Key 7" := "Key 7";
                    "To Key 8" := "Key 8";
                    "To Key 9" := "Key 9";
                end;
                lUpdate(pxRecordRef, ReplicationLog."Trigger"::Rename);
            end else
                lCheckEditable(pRecordRef);
    end;

    local procedure lUpdate(var pRecordRef: RecordRef; pTrigger: Integer)
    var
        lExists: Boolean;
    begin
        with ReplicationLog do begin
            lSetKey(pRecordRef, pTrigger);
            //GL2024    lExists := Get(TableID, "Key 1", "Key 2", "Key 3", "Key 4", "Key 5", "Key 6", "Key 7", "Key 8", "Key 9",Trigger);
            //GL2024
            lExists := Get(TableID, "Key 1", "Key 2", "Key 3", "Key 4", "Key 5", "Key 6", "Key 7", "Key 8", "Key 9", '');
            //L2024
            "User ID" := UserId;
            DateTime := CurrentDatetime;
            if lExists then
                Modify
            else
                Insert;
        end;
    end;

    local procedure lSetKey(var pRecordRef: RecordRef; pTrigger: Integer)
    var
        lKeyRef: KeyRef;
        lFieldRef: FieldRef;
        i: Integer;
    begin
        with ReplicationLog do begin
            TableID := pRecordRef.Number;
            lKeyRef := pRecordRef.KeyIndex(1);
            for i := 1 to lKeyRef.FieldCount do begin
                lFieldRef := lKeyRef.FieldIndex(i);
                case i of
                    1:
                        "Key 1" := Format(lFieldRef.Value);
                    2:
                        "Key 2" := Format(lFieldRef.Value);
                    3:
                        "Key 3" := Format(lFieldRef.Value);
                    4:
                        "Key 4" := Format(lFieldRef.Value);
                    5:
                        "Key 5" := Format(lFieldRef.Value);
                    6:
                        "Key 6" := Format(lFieldRef.Value);
                    7:
                        "Key 7" := Format(lFieldRef.Value);
                    8:
                        "Key 8" := Format(lFieldRef.Value);
                    9:
                        "Key 9" := Format(lFieldRef.Value);
                    else
                        Error(tPrimaryKeyError, i - 1, pRecordRef.Caption);
                end;
            end;
            //GL2024   trigger pTrigger;
        END;
    end;

    local procedure lCheckEditable(var pRecordRef: RecordRef)
    var
        lFieldRef: FieldRef;
        lBoolean: Boolean;
    begin
        if ReplicationTable.Get(pRecordRef.Number) then begin
            if not ReplicationTable.Editable then
                lError(tNotEditable)
            else begin
                lFieldRef := pRecordRef.Field(73754);
                lBoolean := lFieldRef.Value;
                if lBoolean then
                    lError(tReplicateRecord);
            end;
        end;
    end;

    local procedure lCheckModify(var pRecordRef: RecordRef; var pRecordxRef: RecordRef)
    var
        lFieldRef: FieldRef;
        lFieldxRef: FieldRef;
        lBoolean: Boolean;
        lField: Record "Field";
        lRepliException: Record "Replication Exception";
    begin
        if ReplicationTable.Get(pRecordRef.Number) then begin
            if not ReplicationTable.Editable then
                lError(tNotEditable)
            else begin
                lFieldRef := pRecordRef.Field(73754);
                lBoolean := lFieldRef.Value;
                if lBoolean then begin
                    lField.SetRange(TableNo, pRecordRef.Number);
                    lField.SetRange(lField.Class, lField.Class::Normal);
                    lField.Find('-');
                    repeat
                        lFieldRef := pRecordRef.Field(lField."No.");
                        lFieldxRef := pRecordxRef.Field(lField."No.");
                        if lFieldxRef.Value <> lFieldRef.Value then
                            if not lRepliException.Get(pRecordRef.Number, lField."No.") then
                                lError(StrSubstNo(tReplicateFieldRecord, lFieldRef.Caption, '%1', '%2'));
                    until lField.Next = 0;
                end;
            end;
        end;
    end;

    local procedure lError(pMessage: Text[250])
    var
        lReplicationSetup: Record "Replication Setup";
    begin
        if lReplicationSetup.Get then;
        ReplicationTable.CalcFields(Caption);
        Error(pMessage, ReplicationTable.Caption, lReplicationSetup."Company Name");
    end;


    procedure Stop()
    begin
        Suspend := true;
    end;


    procedure Start()
    begin
        Suspend := false;
    end;


    procedure EnableReplication(pEnabled: Boolean)
    begin
        Enabled := pEnabled;
    end;
}

