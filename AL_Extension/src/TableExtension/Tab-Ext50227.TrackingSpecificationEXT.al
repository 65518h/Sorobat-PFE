TableExtension 50227 "Tracking SpecificationEXT" extends "Tracking Specification"
{
    fields
    {
        //  Ajout de 3 champs pour remplacer les 3 variables "gLotNo", "gSerial" et "gExpDate".
        field(50000; "LotNo"; Code[20])
        {
            Caption = 'LotNo';
        }
        field(50001; "Serial"; Code[20])
        {
            Caption = 'Serial';
        }
        field(50002; "ExpDate"; Date)
        {
            Caption = 'ExpDate';
        }

    }
    trigger OnAfterDelete()
    VAR
        lInfoLot: Record "Lot No. Information";
    BEGIN

        //+REF+LOT
        IF "Quantity (Base)" > 0 THEN
            IF lInfoLot.GET("Item No.", "Variant Code", "Lot No.") THEN BEGIN
                lInfoLot.CALCFIELDS(Inventory);
                IF lInfoLot.Inventory = 0 THEN
                    lInfoLot.DELETE;
            END;
        //+REF+LOT//

    end;

}

