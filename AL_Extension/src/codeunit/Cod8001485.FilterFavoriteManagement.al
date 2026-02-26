Codeunit 8001485 "Filter Favorite Management"
{
    // //+BGW+FILTER CW 12/05/11


    trigger OnRun()
    begin
    end;

    var
        gTableRelation: Record "Filter Table Relation";
        tDone: label '%1 new %2';
        tConfirmAdd: label 'Do-you want to add %1 "%2" to favorites?';
        tConfirmRemove: label 'Do-you want to remove %1 "%2" from favorites?';
        tOutlookBreak: label 'If you remove this item from favorites, you can''t refresh this card to Outlook.';
        tConfirm: label 'Do you want to continue?';


    procedure Add(var pRecordref: RecordRef; pEntryID: Text[250])
    var
        lFavorite: Record "Filter Favorite";
    begin
        lFavorite.Init;
        lFavorite."User ID" := UserId;
        lFavorite."Table ID" := pRecordref.Number;
        lFavorite."Source Type" := gTableRelation.SourceType(pRecordref);
        lFavorite."No." := gTableRelation.SourceNo(pRecordref);
        lFavorite.Validate(Description, gTableRelation.SourceDescription(pRecordref));
        if lFavorite.Insert then;
    end;


    procedure AddSelection(var pRecordRef: RecordRef)
    var
        lCount: Integer;
    begin
        lCount := pRecordRef.Count;
        if lCount <> 1 then
            if not Confirm(tConfirmAdd, true, lCount, pRecordRef.Caption) then
                exit;

        if pRecordRef.FindSet then
            repeat
                Add(pRecordRef, '');
            until pRecordRef.Next = 0;
    end;


    procedure Remove(var pRecordRef: RecordRef)
    var
        lFavorite: Record "Filter Favorite";
    begin
        if not lFavorite.Get(UserId, pRecordRef.Number, gTableRelation.SourceType(pRecordRef), gTableRelation.SourceNo(pRecordRef)) then
            exit;
        lFavorite.Delete;
    end;


    procedure RemoveSelection(var pRecordRef: RecordRef)
    var
        lFavorite: Record "Filter Favorite";
    begin
        if not Confirm(tConfirmRemove, true, pRecordRef.Count, pRecordRef.Caption) then
            exit;
        if gTableRelation.Get(pRecordRef.Number) and (gTableRelation."Source Type FieldNo" <> 0) then begin
            if pRecordRef.FindSet then
                repeat
                    if lFavorite.Get(UserId, pRecordRef.Number, gTableRelation.SourceType(pRecordRef), gTableRelation.SourceNo(pRecordRef)) then
                        lFavorite.Delete;
                until pRecordRef.Next = 0;
        end else
            if pRecordRef.FindSet then
                repeat
                    if lFavorite.Get(UserId, pRecordRef.Number, gTableRelation.SourceType(pRecordRef), gTableRelation.SourceNo(pRecordRef)) then
                        lFavorite.Delete;
                until pRecordRef.Next = 0;
    end;


    procedure OnDeleteSource(var pRecordRef: RecordRef)
    var
        lFavorite: Record "Filter Favorite";
    begin
        with lFavorite do begin
            SetCurrentkey("Table ID", "Source Type", "No.");
            SetRange("Table ID", pRecordRef.Number);
            SetRange("Source Type", gTableRelation.SourceType(pRecordRef));
            SetRange("No.", gTableRelation.SourceNo(pRecordRef));
            DeleteAll;
        end;
    end;


    procedure OnRenameSource(var xRecordRef: RecordRef; pRecordRef: RecordRef)
    var
        lFavorite: Record "Filter Favorite";
    begin
        with lFavorite do begin
            SetCurrentkey("Table ID", "Source Type", "No.");
            SetRange("Table ID", pRecordRef.Number);
            SetRange("Source Type", gTableRelation.SourceType(xRecordRef));
            SetRange("No.", gTableRelation.SourceNo(xRecordRef));
            ModifyAll("No.", gTableRelation.SourceNo(pRecordRef));
        end;
    end;


    procedure Toggle(var pRecordRef: RecordRef)
    var
        lFavorite: Record "Filter Favorite";
    begin
        if lFavorite.Get(UserId, pRecordRef.Number, gTableRelation.SourceType(pRecordRef), gTableRelation.SourceNo(pRecordRef)) then
            Remove(pRecordRef)
        else
            Add(pRecordRef, '');
    end;
}

