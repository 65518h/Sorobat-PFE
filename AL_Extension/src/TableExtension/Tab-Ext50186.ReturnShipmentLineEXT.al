TableExtension 50186 "Return Shipment LineEXT" extends "Return Shipment Line"
{
    fields
    {
        /*GL2024   modify("Buy-from Vendor No.")
           {

                Editable=true;

           }
            modify("Pay-to Vendor No.")
           {
               Editable = true;
           }
             modify("Unit Cost")
           {
               Editable = true;
           }
           */
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8003900; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(8003902; "Charge To Order No."; Code[20])
        {
            Caption = 'Charge To Order No.';
            TableRelation = "Purchase Header Archive"."No." where("Document Type" = const(Order));
        }
        field(8004097; "Discount 1 %"; Decimal)
        {
            Caption = 'Discount 1 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(8004098; "Discount 2 %"; Decimal)
        {
            Caption = 'Discount 2 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(8004099; "Discount 3 %"; Decimal)
        {
            Caption = 'Discount 3 %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
    }
}

