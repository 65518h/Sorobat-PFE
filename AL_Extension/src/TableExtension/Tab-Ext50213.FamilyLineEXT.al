TableExtension 50213 "Family LineEXT" extends "Family Line"
{
    fields
    {

        modify(Description)
        {
            Description = 'Navibat';
        }

        modify("Description 2")
        {
            Description = 'Navibat';
        }
        field(50000; Dosage; Decimal)
        {

            trigger OnValidate()
            begin
                Quantity := Dosage * Largeur;
            end;
        }
        field(50001; Largeur; Decimal)
        {
            trigger OnValidate()
            begin
                Quantity := Dosage * Largeur;
            end;

        }
        field(50002; Activé; boolean)
        {


        }
    }
    keys
    {

        key(Key3; "Item No.")
        {
        }
    }
}

