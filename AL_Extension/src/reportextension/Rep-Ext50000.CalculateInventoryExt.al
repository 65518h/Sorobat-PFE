reportextension 50000 "Calculate Inventory Ext" extends "Calculate Inventory"
{

    dataset
    {
        // Add changes to dataitems and columns here

    }

    requestpage
    {
        // Add changes to the requestpage here
    }

    rendering
    {
        // layout(LayoutName)
        // {
        //     Type = RDLC;
        //     LayoutFile = 'mylayout.rdl';
        // }
    }
    procedure SetPhysInv()
    begin

        //+REF+PHYS_INV
        gPhysInv := TRUE;
        //+REF+PHYS_INV//
    end;

    var
        gPhysInv: Boolean;
}