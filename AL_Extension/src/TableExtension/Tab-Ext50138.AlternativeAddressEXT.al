TableExtension 50138 "Alternative AddressEXT" extends "Alternative Address"
{
    fields
    {
        modify(Address)
        {
            trigger OnBeforeValidate()
            begin
                "Nbr Adresse Secondaie" := "Nbr Adresse Secondaie" + 1;

            end;
        }


        field(50000; "Nbr Adresse Secondaie"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
    }

}

