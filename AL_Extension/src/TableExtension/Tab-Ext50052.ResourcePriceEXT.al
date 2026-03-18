TableExtension 50052 "Resource PriceEXT" extends "Resource Price"
{
    fields
    {

        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8003900; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(8003901; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';

            trigger OnValidate()
            var
            //ReturnedCrossRef: Record "Item Cross Reference";
            //  lSalesOverHead: Record 8004061;
            begin
            end;
        }
    }
    keys
    {

        key(STG_Key2; "Customer No.", "Cross-Reference No.")
        {
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

