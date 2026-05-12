TableExtension 50055 "Resource Unit of MeasureEXT" extends "Resource Unit of Measure"
{
    fields
    {
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
    }


    trigger OnInsert()
    BEGIN
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    END;

    trigger OnModify()
    VAR
        lReplicationRef: RecordRef;
    BEGIN
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//

    end;


    trigger OnAfterDelete()
    begin

        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnAfterRename()
    VAR
        lReplicationRef: RecordRef;
    BEGIN
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    end;


    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

