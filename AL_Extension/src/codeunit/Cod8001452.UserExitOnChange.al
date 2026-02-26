Codeunit 8001452 "UserExit OnChange"
{
    // //+REF+USEREXIT CW 21/05/06 UserExit


    trigger OnRun()
    begin
    end;

    var
        Item: Record Item;
        xItem: Record Item;
        DimMgt: Codeunit DimensionManagement;


    procedure OnInsert(var pRecordRef: RecordRef)
    var
        lItem: Record Item;
    begin
        case pRecordRef.Number of
            Database::Customer:
                ;
            Database::Vendor:
                ;
            Database::Item:
                ;
        end;
    end;


    procedure OnModify(var pRecordRef: RecordRef; xRecordRef: RecordRef)
    begin
        case pRecordRef.Number of
            Database::Customer:
                ;
            Database::Vendor:
                ;
            Database::Item:
                ;
        end;
    end;


    procedure OnDelete(var pRecordRef: RecordRef)
    var
        lItem: Record Item;
    begin
        case pRecordRef.Number of
            Database::Customer:
                ;
            Database::Vendor:
                ;
            Database::Item:
                ;
        end;
    end;


    procedure OnRename(var pRecordRef: RecordRef; xRecordRef: RecordRef)
    begin
        case pRecordRef.Number of
            Database::Customer:
                ;
            Database::Vendor:
                ;
            Database::Item:
                ;
        end;
    end;
}

