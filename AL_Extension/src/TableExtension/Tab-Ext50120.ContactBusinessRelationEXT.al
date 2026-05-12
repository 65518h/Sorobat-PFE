TableExtension 50120 "Contact Business RelationEXT" extends "Contact Business Relation"
{
    fields
    {
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
    }

    trigger OnAfterInsert()
    begin

        //#7799
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //#7799//
    end;

    trigger OnModify()
    VAR
        lReplicationRef: RecordRef;
    begin
        //#7799
        wReplicationRef.GETTABLE(Rec);
        lReplicationRef.GETTABLE(xRec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //#7799//

    end;

    trigger OnDelete()
    begin

        //#7799
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //#7799//
    end;

    trigger OnRename()
    VAR
        lReplicationRef: RecordRef;
    begin
        //#7799
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //#7799//

    end;



    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

