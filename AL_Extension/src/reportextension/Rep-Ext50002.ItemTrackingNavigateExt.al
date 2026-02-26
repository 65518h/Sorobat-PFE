reportextension 50002 "Item Tracking Navigate Ext" extends "Item Tracking Navigate"
{
    dataset
    {

    }

    requestpage
    {

    }

    rendering
    {

    }

    procedure TransferFilters(NewSerialNoFilter: Code[1000]; NewLotNoFilter: Code[1000]; NewItemNoFilter: Code[1000]; NewVariantFilter: Code[1000])
    begin

        SerialNoFilter := NewSerialNoFilter;
        LotNoFilter := NewLotNoFilter;
        ItemNoFilter := NewItemNoFilter;
        VariantFilter := NewVariantFilter;
    end;


    var

        SerialNoFilter: Code[1000];
        LotNoFilter: Code[1000];
        ItemNoFilter: Code[1000];
        VariantFilter: Code[1000];
}