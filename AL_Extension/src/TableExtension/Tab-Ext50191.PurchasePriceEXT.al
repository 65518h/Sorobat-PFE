TableExtension 50191 "Purchase PriceEXT" extends "Purchase Price"
{
    fields
    {
        modify("Item No.")
        {
            //GL2024  NotBlank =true;
            Description = 'Modification TableRelation ';
        }

        modify("Vendor No.")
        {
            //GL2024  NotBlank =true;
            Description = 'Modification TableRelation ';
        }

        field(50000; "N° Demande"; Code[20])
        {
        }
        field(50001; "Prix en Devise"; Decimal)
        {
            Description = 'HJ DSFT 01 03 2012';
        }
        field(50002; "Delai de Livraison"; DateFormula)
        {
            Description = 'HJ DSFT 01 03 2012';
        }
        field(50003; "Num Devis"; Code[20])
        {
            Description = 'HJ DSFT 01 03 2012';
        }
        field(50004; "Num Frs"; Code[20])
        {
            CalcFormula = lookup(Vendor."No." where("Ancien Numero" = field("Vendor No.")));
            Description = 'HJ DSFT 01 03 2012';
            FieldClass = FlowField;
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Description = 'HJ DSFT 01 03 2012';
            Editable = false;
        }
        field(8004150; "Resource No."; Code[20])
        {
            Caption = 'Structure no.';
            TableRelation = Resource."No." WHERE(Type = CONST(Structure));
        }
        field(8004151; Description; Text[80])
        {
            Caption = 'Co&mment';
        }
    }
    keys
    {



        /*  GL2024  key(Key3;"Vendor No.","Item No.","Job No.","Starting Date","Currency Code","Variant Code","Unit of Measure Code","Minimum Quantity")
            {
            }*/
    }

    trigger OnAfterInsert()
    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
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
}

