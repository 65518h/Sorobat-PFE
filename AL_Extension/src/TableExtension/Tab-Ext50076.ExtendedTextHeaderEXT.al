TableExtension 50076 "Extended Text HeaderEXT" extends "Extended Text Header"
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
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//

    end;

    trigger OnModify()
    VAR
        lReplicationRef: RecordRef;
    begin
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



    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

