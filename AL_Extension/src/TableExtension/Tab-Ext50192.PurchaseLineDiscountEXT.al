TableExtension 50192 "Purchase Line DiscountEXT" extends "Purchase Line Discount"
{
    fields
    {
        modify("Item No.")
        {



            TableRelation = if (Type = const(Item)) Item
            else
            if (Type = const("Item Disc. Group")) "Item Discount Group";
        }
        modify("Vendor No.")
        {



            TableRelation = if ("Purchase Type" = const(Vendor)) Vendor
            else
            if ("Purchase Type" = const("Vendor Disc. Group")) "Vendor Discount Group";
            Caption = 'Purchase Code';
        }



        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
        field(8004090; "Discount 1 %"; Decimal)
        {
            Caption = 'Discount 1 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //+OFF+REMISE
                "Line Discount %" := wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %");
                //+OFF+REMISE//
            end;
        }
        field(8004091; "Discount 2 %"; Decimal)
        {
            Caption = 'Discount 2 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //+OFF+REMISE
                "Line Discount %" := wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %");
                //+OFF+REMISE//
            end;
        }
        field(8004092; "Discount 3 %"; Decimal)
        {
            Caption = 'Discount 3 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                //+OFF+REMISE
                "Line Discount %" := wTotalDiscount("Discount 1 %", "Discount 2 %", "Discount 3 %");
                //+OFF+REMISE//
            end;
        }
        field(8004093; "Cost Filter"; Decimal)
        {
            Caption = 'Cost Filter';
            FieldClass = FlowFilter;
        }
        field(8004096; "Purchase Type"; Option)
        {
            Caption = 'Purchase Type';
            OptionCaption = 'Vendor,Vendor Disc. Group,All Vendors';
            OptionMembers = Vendor,"Vendor Disc. Group","All Vendors";

            trigger OnValidate()
            begin
                //+OFF+REMISE
                if "Purchase Type" <> xRec."Purchase Type" then
                    //GL2024  Validate("Purchase Code", '');
                    Validate("Vendor No.", '');
                //+OFF+REMISE//
            end;
        }
        field(8004097; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Item,Item Disc. Group';
            OptionMembers = Item,"Item Disc. Group";

            trigger OnValidate()
            begin
                //+OFF+REMISE
                if xRec.Type <> Type then
                    //GL2024 Validate(Code, '');
                    Validate("Item No.", '');
                //+OFF+REMISE//
            end;
        }
    }
    keys
    {

        key(Key3; Synchronise)
        {
        }
    }

    trigger OnAfterInsert()
    begin
        //+OFF+REMISE
        //TESTFIELD("Vendor No.");
        //TESTFIELD("Item No.");
        //TESTFIELD("Purchase Code");
        IF "Purchase Type" = "Purchase Type"::"All Vendors" THEN
            //GL2024  "Purchase Code" := ''
            "Vendor No." := ''
        ELSE
            //GL2024 TESTFIELD("Purchase Code");
            TESTFIELD("Vendor No.");
        //+OFF+REMISE//
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//
    end;

    trigger OnAfterRename()
    VAR
        lReplicationRef: RecordRef;
    begin
        //+OFF+REMISE
        //TESTFIELD("Vendor No.");
        IF "Purchase Type" = "Purchase Type"::"All Vendors" THEN
            //GL2024   "Purchase Code" := ''
            "Vendor No." := ''
        ELSE
            //GL2024  TESTFIELD("Purchase Code");
            TESTFIELD("Vendor No.");
        //+OFF+REMISE//
        //  GL2024 TESTFIELD(Code);
        TESTFIELD("Item No.");
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


    //end;

    procedure wTotalDiscount(pDiscount1: Decimal; pDiscount2: Decimal; pDiscount3: Decimal): Decimal
    begin
        //+OFF+REMISE
        exit(100 - (100 - pDiscount1) * (100 - pDiscount2) * (100 - pDiscount3) / 10000);
        //+OFF+REMISE//
    end;



    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

