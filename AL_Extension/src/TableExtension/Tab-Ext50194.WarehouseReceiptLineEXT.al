TableExtension 50194 "Warehouse Receipt LineEXT" extends "Warehouse Receipt Line"
{
    fields
    {
        field(50000; "Tare Chez Fournisseur"; Integer)
        {
            Description = 'HJ DSFT 25-04-2012';
        }
        field(50001; "Poids Brut Fournisseur"; Integer)
        {
            Description = 'HJ DSFT 25-04-2012';
        }
        field(50002; "Tare Chantier"; Integer)
        {
            Description = 'HJ DSFT 25-04-2012';
        }
        field(50003; "N° Camion"; Code[20])
        {
            Description = 'HJ DSFT 25-04-2012';
            Editable = true;
            TableRelation = Resource;
        }
    }
}

