TableExtension 50077 "Extended Text LineEXT" extends "Extended Text Line"
{
    fields
    {

        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8001400; Separator; Integer)
        {
        }
    }

    trigger OnBeforeInsert()
    VAR
        lExtendedH: Record "Extended Text Header";
    begin

        //OUVRAGE
        IF NOT lExtendedH.GET("Table Name", "No.", "Language Code", "Text No.") THEN BEGIN
            lExtendedH."Table Name" := "Table Name";
            lExtendedH."No." := "No.";
            lExtendedH."Language Code" := "Language Code";
            lExtendedH."Text No." := "Text No.";
            lExtendedH.INSERT;
        END;
        //OUVRAGE//
    end;

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
    BEGIN
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//
    END;

    trigger OnDelete()
    BEGIN
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//
    END;

    trigger OnRename()

    VAR
        lReplicationRef: RecordRef;
    BEGIN
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnRename(lReplicationRef, wReplicationRef);
        //+REF+REPLIC//
    END;



    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

