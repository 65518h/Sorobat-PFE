Table 8001491 "Phys. Inv. Journal Line"
{
    Caption = 'Phys. Inv. Journal Line';
    //DrillDownPageID = 8001492;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;
            TableRelation = Location;
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Name';
            NotBlank = true;
            TableRelation = "Phys. Inv. Journal Batch".Name where("Location Code" = field("Location Code"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnLookup()
            begin
                LookupItemNo;
            end;

            trigger OnValidate()
            var
                BinCode: Code[20];
            begin
                GetItem;
                Item.TestField(Blocked, false);
                Description := Item.Description;
                Validate("Unit of Measure Code", Item."Base Unit of Measure");
            end;
        }
        field(5; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));

            trigger OnValidate()
            begin
                if "Variant Code" = '' then
                    exit;

                ItemVariant.Get("Item No.", "Variant Code");
                Description := ItemVariant.Description;
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7; Quantity; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity (Base) ';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            var
                lRec: Record "Phys. Inv. Journal Line";
            begin
                "Quantity (Base)" := Quantity * "Qty. per Unit of Measure";
                if "Relegation Code" <> '' then begin
                    "Relegation Quantity" := Quantity;
                    "Relegation Qty. (base)" := "Quantity (Base)";
                    //  Quantity := 0;
                    //  "Quantity (Base)" := 0;
                end;
            end;
        }
        field(8; "Bar Code"; Code[20])
        {
            Caption = 'Bar Code';

            trigger OnValidate()
            var
                lItemCrossReference: Record "Item Reference";
                lCode: Record "Code";
                lRec: Record "Phys. Inv. Journal Line";
            begin
                TestField("Location Code");
                TestField("Journal Batch Name");
                lItemCrossReference.SetCurrentkey("Reference Type", lItemCrossReference."Reference No.");
                lItemCrossReference.SetRange("Reference Type", lItemCrossReference."reference type"::"Bar Code");
                lItemCrossReference.SetRange("Reference No.", "Bar Code");
                if lItemCrossReference.FindFirst then begin
                    Validate("Item No.", lItemCrossReference."Item No.");
                    Validate("Unit of Measure Code", lItemCrossReference."Unit of Measure");
                end else
                    if Item.Get("Bar Code") then begin
                        Validate("Item No.", "Bar Code");
                        "Bar Code" := '';
                    end else
                        if lCode.Get(Database::"Phys. Inv. Journal Line", FieldNo("Relegation Code"), "Bar Code") then begin
                            lRec := Rec;
                            lRec.SetRange("Location Code", "Location Code");
                            lRec.SetRange("Journal Batch Name", "Journal Batch Name");
                            if lRec.Next(-1) = 0 then
                                Error(tFirstLine)
                            else begin
                                "Relegation Code" := "Bar Code";
                                "Bar Code" := lRec."Bar Code";
                                Validate("Item No.", lRec."Item No.");
                            end;
                        end else begin
                            Item.Init;
                            Message(tNonStockReference);
                        end;
            end;
        }
        field(10; "Relegation Code"; Code[10])
        {
            Caption = 'Relegation Code';
            TableRelation = Code.Code where("Table No" = const(8001491),
                                             "Field No" = const(10));
        }
        field(13; "Relegation Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Relegation Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(63; "Phys. Inventory Area"; Code[10])
        {
            Caption = 'Area';
            Enabled = false;
            TableRelation = Area;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            //blankzero = true;
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));

            trigger OnValidate()
            begin
                GetItem;
                "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");

                Validate("Relegation Quantity");
            end;
        }
        field(5413; "Quantity (Base)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate("Relegation Quantity", "Quantity (Base)");
            end;
        }
        field(5414; "Relegation Qty. (base)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Relegation Qty. (base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "Location Code", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
        key(STG_Key2; "Location Code", "Item No.", "Variant Code", "Bar Code")
        {
            SumIndexFields = "Quantity (Base)";
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        Location: Record Location;
        UOMMgt: Codeunit "Unit of Measure Management";
        tNonStockReference: label 'Non Stock Reference';
        tFirstLine: label 'First line can''t be a relegation.';

    local procedure GetItem()
    begin
        if Item."No." <> "Item No." then
            Item.Get("Item No.");
    end;


    procedure LookupItemNo()
    var
        ItemList: page "Item List";
    begin
        ItemList.LookupMode := true;
        if ItemList.RunModal = Action::LookupOK then begin
            ItemList.GetRecord(Item);
            Validate("Item No.", Item."No.");
        end;
    end;
}

