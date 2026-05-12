TableExtension 50211 "Production BOM LineEXT" extends "Production BOM Line"
{
    fields
    {

        modify("No.")
        {
            TableRelation = if (Type = const(Item)) Item
            else
            if (Type = const("Production BOM")) "Production BOM Header";
        }

        modify(Description)
        {
            Description = 'Navibat';
        }

        modify("Unit of Measure Code")
        {
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const("Production BOM")) "Unit of Measure";
        }
        /*GL2024 modify(Quantity)
         {
             DecimalPlaces = 0 : 7
         }
          modify(Quantity per)
         {
             DecimalPlaces = 0 : 7
         }
         */




        field(50000; Centrale; Code[20])
        {
        }
    }
    keys
    {

        key(STG_Key3; Description)
        {
        }
    }
}

