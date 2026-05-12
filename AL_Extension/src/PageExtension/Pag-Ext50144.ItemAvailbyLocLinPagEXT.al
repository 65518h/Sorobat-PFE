PageExtension 50144 "Item Avail. by Loc Lin_PagEXT" extends "Item Avail. by Location Lines"
{

    layout
    {

    }

    actions
    {

    }
    trigger OnOpenPage()
    begin

        // >> HJ SORO 11-07-2014
        // FiltreMagasin;
        // >> HJ SORO 11-07-201
    end;

    trigger OnAfterGetRecord()
    begin
        // >> HJ SORO 11-07-2014
        //FiltreMagasin;
        // >> HJ SORO 11-07-201
        /* IF Item."No." <> '' THEN BEGIN
             AmountType2 := AmountType;
             AmountType := AmountType::"Balance at Date";
             //   CalculateNeed;

             ProjAvailBalance :=
               Item.Inventory +
               PlannedOrderReceipt +
               ScheduledReceipt -
               GrossRequirement;

             IF AmountType2 <> AmountType THEN BEGIN
                 AmountType := AmountType2;
                 //  CalculateNeed;
             END;

             ExpectedInventory := AvailabilityMgt.ExpectedQtyOnHand(Item, TRUE, 0, QtyAvailable, 99993112D);
         END;*/
    end;

    PROCEDURE FiltreMagasin();
    VAR
        LUserSetup: Record "User Setup";
    BEGIN
        // >> HJ SORO 11-07-2014
        IF LUserSetup.GET(UPPERCASE(USERID)) THEN BEGIN
            // IF LUserSetup."Filtre Magasin" <> '' THEN rec.SETRANGE(Code, LUserSetup."Filtre Magasin");
        END;
        // >> HJ SORO 11-07-2014
    END;

    var
        AmountType2: Enum "Analysis Amount Type";
        ProjAvailBalance: Decimal;
        PlannedOrderReceipt: Decimal;
        ScheduledReceipt: Decimal;
        AvailabilityMgt: Codeunit 5400;
}