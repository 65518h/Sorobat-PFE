PageExtension 50242 "Item Tracking Lines_PagEXT" extends "Item Tracking Lines"
{
    layout
    {

    }
    actions
    {

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin

        //+REF+LOT
        IF gFormSalesLine OR gValidate THEN BEGIN
            IF NOT gTempTrackingSpec.FIND('-') THEN BEGIN
                IF gFormSalesLine THEN
                    fLot;
                IF gValidateDateExp THEN
                    gTempTrackingSpec."Expiration Date" := rec.ExpDate
                ELSE
                    IF gValidate THEN BEGIN
                        gValidate := FALSE;
                        fLotValidate(TRUE);
                    END;
                gValidate := FALSE;
                IF SourceQuantityArray[2] = gTempTrackingSpec."Qty. to Handle (Base)" THEN
                    CurrPage.CLOSE
                ELSE BEGIN
                    MESSAGE(tUnitMissing, SourceQuantityArray[2] - gTempTrackingSpec."Qty. to Handle (Base)", rec."Lot No.");
                    rec."Quantity (Base)" := 0;
                    rec."Lot No." := '';
                    rec."Serial No." := '';
                    rec."Qty. to Handle (Base)" := 0;
                    rec."Qty. to Invoice (Base)" := 0;
                    rec."Quantity Handled (Base)" := 0;
                    rec."Quantity Invoiced (Base)" := 0;
                    rec."Qty. to Handle" := 0;
                    rec."Qty. to Invoice" := 0;
                    rec."Qty. per Unit of Measure" := 1;
                    rec.InitQtyToShip;
                    gTempTrackingSpec := Rec;
                END;
            END;
        END;


        //+REF+LOT//
    end;

    trigger OnAfterGetRecord()
    var

        TrackingSpecification: Record "Tracking Specification";
    begin

        //+REF+LOT
        IF gDelete THEN BEGIN
            IF gTempTrackingSpec.FIND('-') THEN
                REPEAT
                    Rec := gTempTrackingSpec;

                    //GL2024 procedure n'existe pas dans BC24   CheckEntryIsReservation(0, 0);
                    //GL2024

                    if ((rec."Source Type" = Database::"Transfer Line") and (CurrentRunMode <> CurrentRunMode::Transfer) and (rec."Source Subtype" = 1))
                    or (ItemTrackingMgt.ItemTrkgIsManagedByWhse(rec."Source Type", rec."Source Subtype", rec."Source ID", rec."Source Prod. Order Line", rec."Source Ref. No.", rec."Location Code", rec."Item No."))
                           then
                        DeleteIsBlocked := true
                    else
                        DeleteIsBlocked := false;
                    //GL2024
                    IF NOT DeleteIsBlocked THEN BEGIN
                        TempItemTrackLineDelete.TRANSFERFIELDS(gTempTrackingSpec);
                        TempItemTrackLineDelete.INSERT();
                        IF TempItemTrackLineInsert.GET(gTempTrackingSpec."Entry No.") THEN
                            TempItemTrackLineInsert.DELETE();
                        IF TempItemTrackLineModify.GET(gTempTrackingSpec."Entry No.") THEN
                            TempItemTrackLineModify.DELETE();
                        gTempTrackingSpec.DELETE(TRUE);
                    END;
                UNTIL gTempTrackingSpec.NEXT = 0;
            gTempTrackingSpec."Serial No." := '';
            gTempTrackingSpec."Lot No." := '';
            gTempTrackingSpec."Expiration Date" := 0D;
            CurrPage.CLOSE;
        END
        ELSE
            IF gValidateDateExp THEN BEGIN
                IF gTempTrackingSpec.FIND('-') THEN
                    REPEAT
                        Rec := gTempTrackingSpec;
                        IF TempItemTrackLineModify.GET(gTempTrackingSpec."Entry No.") THEN BEGIN
                            TempItemTrackLineModify."Expiration Date" := rec.ExpDate;
                            TempItemTrackLineModify.MODIFY;
                        END
                        ELSE BEGIN
                            TempItemTrackLineModify.TRANSFERFIELDS(gTempTrackingSpec);
                            TempItemTrackLineModify."Expiration Date" := rec.ExpDate;
                            TempItemTrackLineModify.INSERT;
                        END;
                    UNTIL gTempTrackingSpec.NEXT = 0;
                gTempTrackingSpec."Expiration Date" := rec.ExpDate;
                CurrPage.CLOSE;
            END
            ELSE
                IF NOT gOkLookup AND gFormSalesLine THEN
                    IF gTempTrackingSpec.FIND('-') THEN
                        IF (gTempTrackingSpec."Lot No." <> '') OR (gTempTrackingSpec."Serial No." <> '') THEN
                            IF CONFIRM(tLotExists, TRUE) THEN BEGIN
                                REPEAT
                                    Rec := gTempTrackingSpec;
                                    //GL2024 procedure n'existe pas dans BC24 
                                    //GL2024 procedure n'existe pas dans BC24    CheckEntryIsReservation(0, 0);
                                    //GL2024
                                    if ((TrackingSpecification."Source Type" = Database::"Transfer Line") and (CurrentRunMode <> CurrentRunMode::Transfer) and (TrackingSpecification."Source Subtype" = 1))
                                                      or (ItemTrackingMgt.ItemTrkgIsManagedByWhse(TrackingSpecification."Source Type", TrackingSpecification."Source Subtype", TrackingSpecification."Source ID", TrackingSpecification."Source Prod. Order Line", TrackingSpecification."Source Ref. No.", TrackingSpecification."Location Code", TrackingSpecification."Item No."))
                                                             then
                                        DeleteIsBlocked := true
                                    else
                                        DeleteIsBlocked := false;
                                    //GL2024
                                    IF NOT DeleteIsBlocked THEN BEGIN
                                        TempItemTrackLineDelete.TRANSFERFIELDS(gTempTrackingSpec);
                                        TempItemTrackLineDelete.INSERT();
                                        IF TempItemTrackLineInsert.GET(gTempTrackingSpec."Entry No.") THEN
                                            TempItemTrackLineInsert.DELETE();
                                        IF TempItemTrackLineModify.GET(gTempTrackingSpec."Entry No.") THEN
                                            TempItemTrackLineModify.DELETE();
                                        gTempTrackingSpec.DELETE(TRUE);
                                        CalculateSums;
                                        rec.INIT;
                                    END;
                                UNTIL gTempTrackingSpec.NEXT = 0;
                                gTempTrackingSpec."Quantity (Base)" := 0;
                                gTempTrackingSpec."Lot No." := '';
                                gTempTrackingSpec."Serial No." := '';
                                gTempTrackingSpec."Expiration Date" := 0D;
                                gTempTrackingSpec."Qty. to Handle (Base)" := 0;
                                gTempTrackingSpec."Qty. to Invoice (Base)" := 0;
                                gTempTrackingSpec."Quantity Handled (Base)" := 0;
                                gTempTrackingSpec."Quantity Invoiced (Base)" := 0;
                                gTempTrackingSpec."Qty. to Handle" := 0;
                                gTempTrackingSpec."Qty. to Invoice" := 0;
                                gTempTrackingSpec."Qty. per Unit of Measure" := 1;
                                gTempTrackingSpec.InitQtyToShip;
                                CurrPage.UPDATE(FALSE);
                            END
                            ELSE
                                gFormSalesLine := FALSE;

        IF gValidate AND (gTempTrackingSpec."Source Type" = 39) THEN BEGIN
            IF gTempTrackingSpec.FIND('-') THEN BEGIN
                IF gValidate THEN
                    fLotValidate(FALSE);
                IF SourceQuantityArray[2] = gTempTrackingSpec."Qty. to Handle (Base)" THEN
                    CurrPage.CLOSE
                ELSE BEGIN
                    MESSAGE(tUnitMissing, SourceQuantityArray[2] - gTempTrackingSpec."Qty. to Handle (Base)", rec."Lot No.");
                    rec."Quantity (Base)" := 0;
                    rec."Lot No." := '';
                    rec."Serial No." := '';
                    rec."Qty. to Handle (Base)" := 0;
                    rec."Qty. to Invoice (Base)" := 0;
                    rec."Quantity Handled (Base)" := 0;
                    rec."Quantity Invoiced (Base)" := 0;
                    rec."Qty. to Handle" := 0;
                    rec."Qty. to Invoice" := 0;
                    rec."Qty. per Unit of Measure" := 1;
                    rec.InitQtyToShip;
                    gTempTrackingSpec := Rec;
                END;
            END;
        END;
    end;


    PROCEDURE fLot();
    VAR
        lMaxQuantity: Decimal;
    BEGIN
        CurrentPageIsOpen := TRUE;

        IF ColorOfQuantityArray[1] = 0 THEN
            lMaxQuantity := UndefinedQtyArray[1] + (rec."Quantity (Base)" - rec."Quantity Handled (Base)");

        gTempTrackingSpec := Rec;
        gTempTrackingSpec."Entry No." := NextEntryNo;
        gTempTrackingSpec."Qty. per Unit of Measure" := QtyPerUOM;
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
            IF NOT TestTempSpecificationExists THEN BEGIN
                TempItemTrackLineInsert.TRANSFERFIELDS(gTempTrackingSpec);
                TempItemTrackLineInsert.INSERT();
                gTempTrackingSpec.INSERT;
            END;
        Rec := gTempTrackingSpec;

        rec."Bin Code" := ForBinCode;
        ItemTrackingDataCollection.AssistOutBoundBarcodeScannerTrackingNo('', Rec,
          CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, gLotSerial, lMaxQuantity);
        //DYS fonction remplacer
        // ItemTrackingDataCollection.AssistEditLotSerialNo(Rec,
        //  CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, gLotSerial, lMaxQuantity);
        rec."Bin Code" := '';

        gTempTrackingSpec := Rec;
        gTempTrackingSpec.MODIFY;
        TempItemTrackLineInsert := Rec;
        TempItemTrackLineInsert.MODIFY;
        gOkLookup := gFormSalesLine;
        CurrPage.UPDATE;
    END;

    PROCEDURE fSetLot(pType: Option Lookup,Delete,Validate,DateExp; pLotSerie: Option Serial,Lot; pExpDate: Date);
    BEGIN
        gFormSalesLine := pType = pType::Lookup;
        gDelete := pType = pType::Delete;
        gValidate := pType = pType::Validate;
        gValidateDateExp := pType = pType::DateExp;
        gLotSerial := pLotSerie;
        rec.ExpDate := pExpDate;
    END;


    PROCEDURE fLotValidate(pUpdate: Boolean);
    VAR
        lMaxQuantity: Decimal;
        CduFunction: Codeunit SoroubatFucntion;
    BEGIN

        CurrentPageIsOpen := TRUE;

        IF ColorOfQuantityArray[1] = 0 THEN
            lMaxQuantity := UndefinedQtyArray[1] + (rec."Quantity (Base)" - rec."Quantity Handled (Base)");

        gTempTrackingSpec := Rec;
        gTempTrackingSpec."Entry No." := NextEntryNo;
        gTempTrackingSpec."Qty. per Unit of Measure" := QtyPerUOM;
        gTempTrackingSpec."Lot No." := rec.LotNo;
        gTempTrackingSpec."Serial No." := rec.Serial;
        IF rec.ExpDate <> 0D THEN
            gTempTrackingSpec."Expiration Date" := rec.ExpDate;
        IF gTempTrackingSpec."Source Type" = DATABASE::"Purchase Line" THEN BEGIN
            gTempTrackingSpec."Qty. to Handle (Base)" := UndefinedQtyArray[2];
            gTempTrackingSpec."Quantity (Base)" := UndefinedQtyArray[2];
            gTempTrackingSpec."Qty. to Invoice (Base)" := UndefinedQtyArray[3];
        END;
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
            IF NOT TestTempSpecificationExists THEN BEGIN
                TempItemTrackLineInsert.TRANSFERFIELDS(gTempTrackingSpec);
                TempItemTrackLineInsert.INSERT();
                gTempTrackingSpec.INSERT;
            END;
        Rec := gTempTrackingSpec;
        rec."Bin Code" := ForBinCode;
        IF gTempTrackingSpec."Source Type" = DATABASE::"Sales Line" THEN
            CduFunction.fValidateLotSerialNo(Rec,
              CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, gLotSerial, lMaxQuantity);
        rec."Bin Code" := '';
        IF gTempTrackingSpec."Expiration Date" = 0D THEN
            gTempTrackingSpec."Expiration Date" := rec.ExpDate;
        gTempTrackingSpec := Rec;
        gTempTrackingSpec.MODIFY;
        TempItemTrackLineInsert := Rec;
        TempItemTrackLineInsert.MODIFY;
        IF pUpdate THEN
            CurrPage.UPDATE;
    END;




    trigger OnOpenPage()
    begin

        CurrentPageIsOpen := true;
    end;


    var
        gTempTrackingSpec: Record "Tracking Specification";
        gFormSalesLine: Boolean;
        gDelete: Boolean;
        gValidate: Boolean;
        /*   gLotNo: Code[20];
           gSerial: Code[20];
           gExpDate: Date;*/
        gLotSerial: Option Serial,Lot;
        gOkLookup: Boolean;

        gValidateDateExp: Boolean;
        tLotExists: Label 'There is already a batch for this line, do you want to replace it ?';
        tUnitMissing: Label 'It misses %1 units in the lot %2.\You must supplement with another lot.';
        ColorOfQuantityArray: ARRAY[3] OF Integer;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        CurrentPageIsOpen: Boolean;
        DeleteIsBlocked: Boolean;
}

