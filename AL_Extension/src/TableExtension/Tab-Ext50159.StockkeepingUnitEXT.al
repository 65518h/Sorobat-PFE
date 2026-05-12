TableExtension 50159 "Stockkeeping UnitEXT" extends "Stockkeeping Unit"
{
    fields
    {
        modify(Description)
        {
            Description = 'Navibat';
        }

        modify("Assembly BOM")
        {
            Caption = 'Bill of Materials';
        }

        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8003900; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
    }

    trigger OnAfterInsert()
    begin

        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnAfterModify()
    VAR
        lReplicationRef: RecordRef;
    begin

        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnAfterRename()
    var

        lReplicationRef: RecordRef;
    begin

        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
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

