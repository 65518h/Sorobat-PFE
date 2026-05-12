TableExtension 50190 "Sales Line DiscountEXT" extends "Sales Line Discount"
{
    fields
    {
        modify("Code")
        {
            TableRelation = if (Type = const(Item)) Item
            else
            if (Type = const("Item Disc. Group")) "Item Discount Group"
            else
            if (Type = const(Resource)) Resource
            else
            if (Type = const("Resource Discount Group")) "Resource Discount Group";
        }

        modify("Unit of Measure Code")
        {
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field(Code))
            else
            if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field(Code));

            trigger OnBeforeValidate()
            begin
                //DISC
                //TESTFIELD(Type,Type::Item);
                IF NOT (Type IN [Type::Item, Type::Resource]) THEN
                    ERROR(tErrorType);
                //DISC//
            end;

        }

        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                //DISC
                //TESTFIELD(Type,Type::Item);
                IF NOT (Type IN [Type::Item, Type::Resource]) THEN
                    ERROR(tErrorType);
                //DISC//
            end;
        }


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

    trigger OnDelete()
    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
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



    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        tErrorType: label 'Type must be Item or Resource';
}

