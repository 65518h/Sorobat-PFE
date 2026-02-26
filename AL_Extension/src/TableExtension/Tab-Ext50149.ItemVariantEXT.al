TableExtension 50149 "Item VariantEXT" extends "Item Variant"
{
    fields
    {

        modify(Description)
        {
            Description = 'Navibat';
        }
        modify("Description 2")
        {
            Description = 'Navibat';
        }

        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
    }



    trigger OnInsert()
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

    trigger OnAfterRename()
    VAR
        lReplicationRef: RecordRef;
    begin
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

