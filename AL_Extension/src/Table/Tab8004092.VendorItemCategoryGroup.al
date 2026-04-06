Table 8004092 "Vendor Item Category Group"
{
    // //+OFF+REMISE GESWAY 17/10/02 Table "Vendor Item Category Group"

    Caption = 'Vendor Item Category Group';
    // LookupPageID = 8004095;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(2; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            NotBlank = true;
            TableRelation = "Item Category";

            trigger OnValidate()
            begin
                /*GL2024  if ("Item Category Code" <> xRec."Item Category Code") and
                     ("Product Group Code" <> '')
                  then
                      if not ProductGroup.Get("Item Category Code", "Product Group Code") then
                          "Product Group Code" := '';*/
            end;
        }
        field(3; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            //GL2024  TableRelation = "Product Group".Code where("Item Category Code" = field("Item Category Code"));
        }
        field(4; "Exclude From Price Offer"; Boolean)
        {
            Caption = 'Exclude From Price Offer';
        }
    }

    keys
    {
        key(STG_Key1; "Item Category Code", "Product Group Code", "Vendor No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Vendor No.", "Item Category Code", "Product Group Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
    //GL2024  ProductGroup: Record "Product Group";
}

