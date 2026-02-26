TableExtension 50096 "Resource Price ChangeEXT" extends "Resource Price Change"
{
    fields
    {

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
            //  ReturnedCrossRef: Record "Item Cross Reference";
            //   lSalesOverHead: Record 8004061;
            begin
            end;
        }
    }
    keys
    {

        //GL2024 key(Key1;"Customer No.","Job No.",Type,"Code","Work Type Code","Currency Code")
        // {
        // Clustered = true;
        // }
    }
}

