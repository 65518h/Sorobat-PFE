Table 8003941 "Resource Discount Group"
{
    Caption = 'Resource Discount Group';
    //DrillDownPageID = 8003941;
    //LookupPageID = 8003941;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        SalesLineDiscount: Record "Sales Line Discount";
    begin
        SalesLineDiscount.SetRange(Type, SalesLineDiscount.Type::"Item Disc. Group");
        SalesLineDiscount.SetRange(Code, Code);
        SalesLineDiscount.DeleteAll(true);
    end;
}

