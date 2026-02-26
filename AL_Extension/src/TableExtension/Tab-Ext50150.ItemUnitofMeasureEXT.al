TableExtension 50150 "Item Unit of MeasureEXT" extends "Item Unit of Measure"
{
    fields
    {
        field(50000; "unite base"; Code[10])
        {
            CalcFormula = lookup(Item."Base Unit of Measure" where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50001; Synchronise; Boolean)
        {
        }
        field(50002; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(50003; Bloqué; boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Blocked WHERE("No." = FIELD("Item No.")));
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
    }
    keys
    {
        key(Key4; Synchronise)
        {
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

