TableExtension 50163 "Item Cross ReferenceEXT" extends "Item Reference"
{
    fields
    {
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8003900; "Item Description"; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Item Description';
            Editable = false;
            FieldClass = FlowField;
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
    var
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
        DeleteItemVendor(Rec);
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

    //GL2024 Procedure standard dans nav2009 n'existe pas dans bc2024
    PROCEDURE DeleteItemVendor(ItemCrossReference: Record "Item Reference");
    VAR
        ItemCrossReference2: Record "Item Reference";
    BEGIN
        ItemCrossReference2.SETRANGE("Item No.", ItemCrossReference."Item No.");
        ItemCrossReference2.SETRANGE("Variant Code", ItemCrossReference."Variant Code");
        ItemCrossReference2.SETRANGE("Reference Type", ItemCrossReference."Reference Type");
        ItemCrossReference2.SETRANGE("Reference Type No.", ItemCrossReference."Reference Type No.");
        ItemCrossReference2.SETRANGE("Reference No.", ItemCrossReference."Reference No.");
        ItemCrossReference2.SETFILTER("Unit of Measure", '<>%1', ItemCrossReference."Unit of Measure");
        IF NOT ItemCrossReference2.FIND('-') THEN BEGIN
            ItemVend.RESET;
            ItemVend.SETRANGE("Item No.", ItemCrossReference."Item No.");
            ItemVend.SETRANGE("Vendor No.", ItemCrossReference."Reference Type No.");
            ItemVend.SETRANGE("Variant Code", ItemCrossReference."Variant Code");
            IF ItemVend.FIND('-') THEN
                REPEAT
                    IF UPPERCASE(DELCHR(ItemVend."Vendor Item No.", '<', ' ')) = ItemCrossReference."Reference No." THEN
                        ItemVend.DELETE;
                UNTIL ItemVend.NEXT = 0;
        ENd
    end;
    //GL2024 FIN


    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
        ItemVend: Record "Item Vendor";
}

