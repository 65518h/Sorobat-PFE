TableExtension 50195 "Posted Whse. Receipt LineEXT" extends "Posted Whse. Receipt Line"
{
    Caption = 'Posted Whse. Receipt Line';
    fields
    {
        modify("Whse. Receipt No.")
        {
            Caption = 'Whse. Receipt No.';
        }
        modify("Whse Receipt Line No.")
        {
            Caption = 'Whse Receipt Line No.';
        }
        field(50000; "Tare Fournisseur"; Integer)
        {
            Description = 'HJ DSFT 25-04-2012';
        }
        field(50001; "Brut Fournisseur"; Integer)
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

