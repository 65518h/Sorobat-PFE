TableExtension 50184 "Lot No. InformationEXT" extends "Lot No. Information"
{
    fields
    {
        field(8001400; "Purchaser Lot No."; Code[20])
        {
            Caption = 'Purchaser Lot No.';
        }
        field(8001401; "Expiration Date"; Date)
        {
            CalcFormula = max("Item Ledger Entry"."Expiration Date" where("Item No." = field("Item No."),
                                                                           "Variant Code" = field("Variant Code"),
                                                                           "Lot No." = field("Lot No."),
                                                                           "Location Code" = field("Location Filter")));
            Caption = 'Expiration Date';
            FieldClass = FlowField;
        }
    }
}

