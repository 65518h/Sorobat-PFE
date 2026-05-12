codeunit 50026 SoroubatFucntion
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;
        gRespCenter: Code[10];
        wNavibatSetup: Record NavibatSetup;
        wTempRes: Record Resource TEMPORARY;
        wOverheadAmount: Decimal;
        wMarginAmount: Decimal;
        wOverRule: Record "Overhead-Margin Rule";
        wMarginRule: Record "Overhead-Margin Rule";
        wOverCalc: Codeunit "Overhead Calculation";
        CduCalcCostStd: Codeunit "Calculate Standard Cost";
        gTools: Codeunit Tools;
        "** HJ DSFT **": Integer;
        FieldsArrayName: ARRAY[255] OF Text[255];
        FieldsArrayKey: ARRAY[255] OF Integer;
        gServContractLine: Record "Service Contract Line";
        gInvFrom: Date;
        gInvTo: Date;
        gServiceApplyEntry: Integer;
        gLineInvoiceAmount: Decimal;
        gSignningContract: Boolean;
        MakeUpdateRequired: Boolean;

    procedure fSetRespCenter(PRespCenter: code[10])
    begin
        gRespCenter := PRespCenter;

    end;

    //*************************************page 8************************************************//


    //*************************************table 99************************************************//
    procedure CheckItemCrossRefLicense(): Boolean
    var
        LicensePermission: Record "License Permission";
    begin

        LicensePermission.SETRANGE("Object Type", LicensePermission."Object Type"::Table);
        LicensePermission.SETRANGE("Object Number", DATABASE::"Item Reference");
        LicensePermission.SETFILTER("Insert Permission", '<>%1', LicensePermission."Insert Permission"::" ");
        IF LicensePermission.FIND('-') THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;
    //*************************************Codeunit 418************************************************//

    PROCEDURE fPopulateLogin(VAR pLogin: Record "Allocation Policy");
    VAR
    // Objet obsolete 
    //lDatabaseLogin : Record 2000000002;
    //lWindowsLogin : Record 2000000054;
    BEGIN
        //   pLogin.DELETEALL;
        //   IF lWindowsLogin.FIND('-') THEN
        //     REPEAT
        //       pLogin.INIT;
        //       lWindowsLogin.CALCFIELDS(ID,Name);
        //       pLogin."User ID" := ShortUserID(lWindowsLogin.ID);
        //       IF pLogin."User ID" <> '' THEN BEGIN
        //         pLogin."Windows Login" := TRUE;
        //         pLogin."Windows Login ID" := lWindowsLogin.ID;
        //         pLogin.Name := lWindowsLogin.Name;
        //         pLogin."Windows Login SID" := lWindowsLogin.SID;
        //         pLogin.INSERT;
        //       END;
        //     UNTIL lWindowsLogin.NEXT = 0;

        //   IF lDatabaseLogin.FIND('-') THEN
        //     REPEAT
        //       pLogin.INIT;
        //       pLogin."User ID" := lDatabaseLogin."User ID";
        //       pLogin."Windows Login" := FALSE;
        //       pLogin."Windows Login ID" := '';
        //       pLogin.Name := lDatabaseLogin.Name;
        //       pLogin.INSERT;
        //     UNTIL lDatabaseLogin.NEXT = 0;
    END;

    PROCEDURE wPopulateLogin();
    VAR
        // Objet obsolete 
        // lDatabaseLogin : Record 2000000002;
        // lWindowsLogin : Record 2000000054;
        lDialog: Dialog;
        tWait: Label 'ENU=Wait...;';
        lLogin: Record "Allocation Policy";
    BEGIN
        lDialog.OPEN(tWait);
        fPopulateLogin(lLogin);
        lDialog.CLOSE;
    END;

    PROCEDURE GetSID(UserID: Code[20]): Text[100];
    VAR
    // DatabaseLogin : Record 2000000002;
    //SIDConversion : Record 2000000055;
    BEGIN
        //   IF UserID <> '' THEN
        //     IF NOT DatabaseLogin.GET(UserID) THEN BEGIN
        //       SIDConversion.SETCURRENTKEY(ID);
        //       SIDConversion.ID := UserID;
        //       IF NOT SIDConversion.FIND THEN
        //         ERROR(
        //           Text000,
        //           DatabaseLogin.FIELDCAPTION("User ID"),
        //           UserID);
        //       EXIT(SIDConversion.SID);
        //     END;
    END;

    //*************************************Codeunit 447************************************************//

    PROCEDURE InsertRecordLink(pRecordRef: RecordRef; pDescription: Text[250]; pURL: Text[1024]);
    VAR
        lRecordLink: Record "Record Link";
        i: Integer;
    BEGIN
        WITH lRecordLink DO BEGIN
            "Link ID" := 0; // AutoIncrement
            "Record ID" := pRecordRef.RECORDID;
            URL1 := COPYSTR(pURL, i + 1, MAXSTRLEN(URL1));
            i += MAXSTRLEN(URL1);
            // URL2 := COPYSTR(pURL,i + 1,MAXSTRLEN(URL2)); i += MAXSTRLEN(URL2);
            // URL3 := COPYSTR(pURL,i + 1,MAXSTRLEN(URL3)); i += MAXSTRLEN(URL3);
            // URL4 := COPYSTR(pURL,i + 1,MAXSTRLEN(URL4)); i += MAXSTRLEN(URL4);
            IF pDescription <> '' THEN
                Description := pDescription
            ELSE
                Description := lGetFileName(pURL);
            Type := Type::Link;
            //  Note := '';
            Created := CURRENTDATETIME;
            "User ID" := USERID;
            Company := COMPANYNAME;
            INSERT;
        END;
    END;

    LOCAL PROCEDURE lGetFileName(pURL: Text[1024]) Return: Text[250];
    VAR
        i: Integer;
    BEGIN
        i := STRLEN(pURL);
        IF i = 0 THEN
            EXIT('');
        WHILE (i > 0) AND NOT (pURL[i] IN ['/', ':', '\']) DO
            i -= 1;
        IF i = 0 THEN
            EXIT('')
        ELSE
            EXIT(COPYSTR(pURL, i + 1, MAXSTRLEN(Return)));
    END;

    //*************************************Codeunit 6500 ************************************************//
    PROCEDURE fValidateLotSerialNo(VAR TrackingSpecification: Record "Tracking Specification" TEMPORARY; SearchForSupply: Boolean; CurrentSignFactor: Integer; LookupMode: Option "Serial No.","Lot No."; MaxQuantity: Decimal): Boolean;
    VAR
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservEntry: Record "Reservation Entry";
        TempReservEntry: Record "Reservation Entry" TEMPORARY;
        TempEntrySummary: Record "Entry Summary" TEMPORARY;
        WarehouseEntry: Record "Warehouse Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ItemTrackingSummaryForm: PAGE "Item Tracking Summary";
        LastEntryNo: Integer;
        Window: Dialog;
        InsertRec: Boolean;
        UseWarehouseEntries: Boolean;
        Text004: Label 'Counting records...';
    BEGIN
        Window.OPEN(Text004);
        TempReservEntry.RESET;
        TempReservEntry.DELETEALL;
        ReservEntry.RESET;
        ReservEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code", "Reservation Status");
        ReservEntry.SETRANGE("Item No.", TrackingSpecification."Item No.");
        ReservEntry.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
        ReservEntry.SETRANGE("Location Code", TrackingSpecification."Location Code");
        ReservEntry.SETRANGE("Reservation Status",
          ReservEntry."Reservation Status"::Reservation, ReservEntry."Reservation Status"::Surplus);

        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive, "Location Code");
        ItemLedgEntry.SETRANGE("Item No.", TrackingSpecification."Item No.");
        ItemLedgEntry.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
        ItemLedgEntry.SETRANGE(Open, TRUE);
        ItemLedgEntry.SETRANGE("Location Code", TrackingSpecification."Location Code");

        IF TrackingSpecification."Bin Code" <> '' THEN BEGIN
            UseWarehouseEntries := TRUE;
            Item.GET(TrackingSpecification."Item No.");
            ItemTrackingCode.GET(Item."Item Tracking Code");
        END;

        CASE LookupMode OF
            LookupMode::"Serial No.":
                BEGIN
                    IF MaxQuantity <> 0 THEN
                        MaxQuantity := MaxQuantity / ABS(MaxQuantity); // Set to a signed value of 1.
                    ItemLedgEntry.SETFILTER("Serial No.", '<>%1', '');
                    ReservEntry.SETFILTER("Serial No.", '<>%1', '');
                    IF UseWarehouseEntries THEN
                        UseWarehouseEntries := ItemTrackingCode."SN Warehouse Tracking";
                END;
            LookupMode::"Lot No.":
                BEGIN
                    ItemLedgEntry.SETFILTER("Lot No.", '<>%1', '');
                    ReservEntry.SETFILTER("Lot No.", '<>%1', '');
                    IF UseWarehouseEntries THEN
                        UseWarehouseEntries := ItemTrackingCode."Lot Warehouse Tracking";
                END;
        END;

        IF ItemLedgEntry.FIND('-') THEN
            REPEAT
                IF UseWarehouseEntries THEN BEGIN
                    InsertRec := FALSE;
                    WarehouseEntry.RESET;
                    WarehouseEntry.SETCURRENTKEY(
                      "Item No.", "Bin Code", "Location Code", "Variant Code",
                      "Unit of Measure Code", "Lot No.", "Serial No.");
                    WarehouseEntry.SETRANGE("Item No.", TrackingSpecification."Item No.");
                    WarehouseEntry.SETRANGE("Bin Code", TrackingSpecification."Bin Code");
                    WarehouseEntry.SETRANGE("Location Code", TrackingSpecification."Location Code");
                    WarehouseEntry.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
                    CASE LookupMode OF
                        LookupMode::"Serial No.":
                            WarehouseEntry.SETRANGE("Serial No.", ItemLedgEntry."Serial No.");
                        LookupMode::"Lot No.":
                            WarehouseEntry.SETRANGE("Lot No.", ItemLedgEntry."Lot No.");
                    END;
                    WarehouseEntry.CALCSUMS("Qty. (Base)");
                    IF WarehouseEntry."Qty. (Base)" > 0 THEN
                        InsertRec := TRUE;
                END ELSE
                    InsertRec := TRUE;
                TempReservEntry.INIT;
                TempReservEntry."Entry No." := -ItemLedgEntry."Entry No.";
                TempReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
                TempReservEntry.Positive := ItemLedgEntry.Positive;
                TempReservEntry."Item No." := ItemLedgEntry."Item No.";
                TempReservEntry."Location Code" := ItemLedgEntry."Location Code";
                TempReservEntry."Quantity (Base)" := ItemLedgEntry."Remaining Quantity";
                TempReservEntry."Source Type" := DATABASE::"Item Ledger Entry";
                TempReservEntry."Source Ref. No." := ItemLedgEntry."Entry No.";
                TempReservEntry."Serial No." := ItemLedgEntry."Serial No.";
                TempReservEntry."Lot No." := ItemLedgEntry."Lot No.";
                TempReservEntry."Variant Code" := ItemLedgEntry."Variant Code";
                IF TempReservEntry.Positive THEN BEGIN
                    TempReservEntry."Warranty Date" := ItemLedgEntry."Warranty Date";
                    TempReservEntry."Expiration Date" := ItemLedgEntry."Expiration Date";
                    TempReservEntry."Expected Receipt Date" := 0D
                END ELSE
                    TempReservEntry."Shipment Date" := 99991231D;
                IF InsertRec THEN
                    TempReservEntry.INSERT;
            UNTIL ItemLedgEntry.NEXT = 0;

        IF ReservEntry.FIND('-') THEN
            REPEAT
                TempReservEntry := ReservEntry;
                TempReservEntry.INSERT;
            UNTIL ReservEntry.NEXT = 0;

        IF TempReservEntry.FIND('-') THEN
            REPEAT
                CASE LookupMode OF
                    LookupMode::"Serial No.":
                        TempEntrySummary.SETRANGE("Serial No.", TempReservEntry."Serial No.");
                    LookupMode::"Lot No.":
                        TempEntrySummary.SETRANGE("Lot No.", TempReservEntry."Lot No.");
                END;
                IF NOT TempEntrySummary.FIND('-') THEN BEGIN
                    TempEntrySummary.INIT;
                    TempEntrySummary."Entry No." := LastEntryNo + 1;
                    LastEntryNo := TempEntrySummary."Entry No.";
                    TempEntrySummary."Table ID" := TempReservEntry."Source Type";
                    TempEntrySummary."Summary Type" := '';
                    TempEntrySummary."Lot No." := TempReservEntry."Lot No.";
                    IF LookupMode = LookupMode::"Serial No." THEN
                        TempEntrySummary."Serial No." := TempReservEntry."Serial No.";
                    TempEntrySummary.INSERT;
                END;

                IF TempReservEntry.Positive THEN BEGIN
                    TempEntrySummary."Warranty Date" := TempReservEntry."Warranty Date";
                    TempEntrySummary."Expiration Date" := TempReservEntry."Expiration Date";
                    IF TempReservEntry."Entry No." < 0 THEN
                        TempEntrySummary."Total Quantity" += TempReservEntry."Quantity (Base)";
                    IF TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation THEN
                        TempEntrySummary."Total Reserved Quantity" += TempReservEntry."Quantity (Base)";
                END ELSE BEGIN
                    TempEntrySummary."Total Requested Quantity" -= TempReservEntry."Quantity (Base)";
                    IF (TempReservEntry."Reservation Status" = TempReservEntry."Reservation Status"::Reservation) AND
                       (TempReservEntry."Source Type" = TrackingSpecification."Source Type") AND
                       (TempReservEntry."Source Subtype" = TrackingSpecification."Source Subtype") AND
                       (TempReservEntry."Source ID" = TrackingSpecification."Source ID") AND
                       (TempReservEntry."Source Batch Name" = TrackingSpecification."Source Batch Name") AND
                       (TempReservEntry."Source Prod. Order Line" = TrackingSpecification."Source Prod. Order Line") AND
                       (TempReservEntry."Source Ref. No." = TrackingSpecification."Source Ref. No.")
                     THEN
                        TempEntrySummary."Current Reserved Quantity" -= TempReservEntry."Quantity (Base)";
                END;

                TempEntrySummary."Total Available Quantity" :=
                  TempEntrySummary."Total Quantity" -
                  TempEntrySummary."Total Requested Quantity" +
                  TempEntrySummary."Current Reserved Quantity";
                TempEntrySummary.MODIFY;
            UNTIL TempReservEntry.NEXT = 0;

        TempEntrySummary.RESET;

        ItemTrackingSummaryForm.SetSources(TempReservEntry, TempEntrySummary);
        ItemTrackingSummaryForm.LOOKUPMODE(SearchForSupply);
        TempEntrySummary.SETRANGE("Serial No.", TrackingSpecification."Serial No.");
        TempEntrySummary.SETRANGE("Lot No.", TrackingSpecification."Lot No.");
        IF TempEntrySummary.FIND('-') THEN
            ItemTrackingSummaryForm.SETRECORD(TempEntrySummary);
        Window.CLOSE;
        IF TempEntrySummary.FIND('-') THEN BEGIN
            ItemTrackingSummaryForm.GETRECORD(TempEntrySummary);
            TrackingSpecification."Serial No." := TempEntrySummary."Serial No.";
            TrackingSpecification."Lot No." := TempEntrySummary."Lot No.";
            IF ((CurrentSignFactor < 0) AND SearchForSupply) THEN
                TrackingSpecification.VALIDATE("Quantity (Base)",
                  MinValueAbs(TempEntrySummary."Total Available Quantity", MaxQuantity))
            ELSE
                TrackingSpecification.VALIDATE("Quantity (Base)",
                  MinValueAbs(-TempEntrySummary."Total Available Quantity", MaxQuantity));
        END;
    END;

    LOCAL PROCEDURE MinValueAbs(Value1: Decimal; Value2: Decimal): Decimal;
    BEGIN
        IF ABS(Value1) < ABS(Value2) THEN
            EXIT(Value1)
        ELSE
            EXIT(Value2);
    END;
    //*************************************Codeunit 6812 ************************************************//

    PROCEDURE wCalcStructure(VAR pRes: Record Resource; pBatch: Boolean);
    VAR
        ItemCostMgt: Codeunit ItemCostManagement;
        lCalcMultiLevel: Boolean;
        Text001: Label '&Single level,&All levels';

    BEGIN
        //OUVRAGE
        IF pBatch THEN
            lCalcMultiLevel := FALSE
        ELSE
            CASE STRMENU(Text001) OF
                0:
                    EXIT;
                1:
                    lCalcMultiLevel := FALSE;
                2:
                    lCalcMultiLevel := TRUE;
            END;

        CduCalcCostStd.SetProperties(WORKDATE, lCalcMultiLevel, FALSE, FALSE, '', FALSE);

        wNavibatSetup.GET;
        wOverheadAmount := 0;
        wMarginAmount := 0;
        wCalcAssemblyStructure(pRes."No.", pRes, 0);
        wOverRule."Gen. Prod. Posting Group" := pRes."Gen. Prod. Posting Group";
        wOverCalc.FetchRule(wOverRule.Type::Margin, wOverRule);

        IF wNavibatSetup."Profit Calculation Method" = wNavibatSetup."Profit Calculation Method"::Structure THEN
            pRes."Unit price Calculated" := (pRes."Unit Cost" + wOverheadAmount) / (1 - wOverRule.Value / 100)
        //    ROUND(
        //      (pRes."Unit Cost" + wOverheadAmount) / (1 - wOverRule.Value / 100),
        //      wNavibatSetup."Unit-Price Rounding Precision")
        ELSE
            //  pRes."Unit price Calculated" := ROUND(wMarginAmount,wNavibatSetup."Unit-Price Rounding Precision");
            pRes."Unit price Calculated" := wMarginAmount;
        //OUVRAGE//
    END;

    PROCEDURE wCalcAssemblyStructure(pResNo: Code[20]; VAR pRes: Record Resource; pLevel: Integer);
    VAR
        lResCost: Record "Resource Cost";
        lBOMComp: Record "Structure Component";
        lCompItem: Record item;
        lCompRes: Record Resource;
        lResFindUnitCost: Codeunit "Resource-Find Cost";
        lUnitCost: Decimal;
        lCompUnitCost: Decimal;
        lCompOverhead: Decimal;
        lCompMargin: Decimal;
        GLSetup: Record "General Ledger Setup";
        UOMMgt: Codeunit "Unit of Measure Management";
        MaxLevel: Integer;
        Text000: Label 'Too many levels. Must be below %1.';
        CalcMultiLevel: Boolean;
    BEGIN
        //OUVRAGE
        IF pLevel > MaxLevel THEN
            ERROR(Text000, MaxLevel);
        IF wGetRes(pResNo, pRes) THEN
            EXIT;
        IF NOT CalcMultiLevel AND (pLevel <> 0) THEN
            EXIT;

        lBOMComp.SETRANGE("Parent Structure No.", pResNo);
        lBOMComp.SETFILTER(Type, '<>%1', lBOMComp.Type::" ");
        //SUBCONTRACTOR
        CASE pRes.Subcontracting OF
            pRes.Subcontracting::" ":
                lBOMComp.SETRANGE(Subcontracting, 0);
            pRes.Subcontracting::"Furniture and Fixing":
                lBOMComp.SETRANGE(Subcontracting, 1);
            pRes.Subcontracting::Fixing:
                BEGIN
                    lBOMComp.SETFILTER(Subcontracting, '%1|%2', pRes.Subcontracting::" ", pRes.Subcontracting::Fixing);
                    lBOMComp.SETFILTER(Type, '%1|%2', lBOMComp.Type::Item, lBOMComp.Type::Machine);
                END;
        END;
        //SUBCONTRACTOR//
        IF lBOMComp.FIND('-') THEN BEGIN
            REPEAT
                //#3911
                IF lBOMComp."No." <> '' THEN BEGIN
                    //#3911//
                    lCompUnitCost := 0;
                    CASE TRUE OF
                        lBOMComp.Type = lBOMComp.Type::Item:
                            BEGIN
                                // CduCalcCostStd.CalcAssemblyItem(lBOMComp."No.", lCompItem, pLevel + 1);
                                IF (lBOMComp.Subcontracting <> 0) AND (lBOMComp."Subcontracted Unit Cost" <> 0) THEN
                                    lCompItem."Standard Cost" := lBOMComp."Subcontracted Unit Cost";
                                IF lCompItem."Standard Cost" <> 0 THEN
                                    lCompItem."Unit Cost" := lCompItem."Standard Cost";
                                lCompUnitCost :=
                                  (lBOMComp."Fixed Quantity" + lBOMComp."Quantity per") *
                                  UOMMgt.GetQtyPerUnitOfMeasure(lCompItem, lBOMComp."Unit of Measure Code") *
                                  lCompItem."Unit Cost";
                                wOverRule."Gen. Prod. Posting Group" := lCompItem."Gen. Prod. Posting Group";
                                wMarginRule."Gen. Prod. Posting Group" := lCompItem."Gen. Prod. Posting Group";
                            END;
                        lBOMComp.Type IN [lBOMComp.Type::Person, lBOMComp.Type::Machine]:
                            IF lCompRes.GET(lBOMComp."No.") THEN BEGIN
                                lResCost.INIT;
                                lResCost.Code := lBOMComp."No.";
                                lResCost."Work Type Code" := '';
                                //lResFindUnitCost.RUN(lResCost);
                                lCompUnitCost := lBOMComp."Number of Resources" * (lBOMComp."Quantity per" + lBOMComp."Fixed Quantity")
                                                 * lResCost."Unit Cost";
                                wOverRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                                wMarginRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                            END;
                        lBOMComp.Type = lBOMComp.Type::Structure:
                            BEGIN
                                wCalcAssemblyStructure(lBOMComp."No.", lCompRes, pLevel + 1);
                                lCompUnitCost := (lBOMComp."Quantity per" + lBOMComp."Fixed Quantity") * lCompRes."Unit Cost";
                                wOverRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                                wMarginRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                            END;
                    END;

                    wOverCalc.FetchRule(wOverRule.Type::Overhead, wOverRule);
                    lCompOverhead := ROUND(
                      //        lCompUnitCost * wOverCalc.ApplyRule(wOverRule.Type::Overhead,wOverRule) / 100,
                      lCompUnitCost * wOverRule.Value / 100,
                      GLSetup."Unit-Amount Rounding Precision");
                    wOverCalc.FetchRule(wOverRule.Type::Margin, wMarginRule);
                    lCompMargin := ROUND(
                      (lCompUnitCost + lCompOverhead) /
                      //        (1 - (wOverCalc.ApplyRule(wOverRule.Type::Margin,wMarginRule)) / 100),
                      (1 - wMarginRule.Value / 100),
                      GLSetup."Unit-Amount Rounding Precision");

                    wOverheadAmount := wOverheadAmount + lCompOverhead;
                    wMarginAmount := wMarginAmount + lCompMargin;
                    lUnitCost := lUnitCost + lCompUnitCost;
                    //#3911
                END;
            //#3911//
            UNTIL lBOMComp.NEXT = 0;

            pRes."Unit Cost" := ROUND(lUnitCost, GLSetup."Unit-Amount Rounding Precision");
            //CostCalcMgt.CalcUnitCost(
            //  lUnitCost,pRes."Indirect Cost %",0,GLSetup."Unit-Amount Rounding Precision");
            pRes."Direct Unit Cost" := wOverheadAmount;
        END;
        //OUVRAGE//
    END;

    PROCEDURE wGetRes(pResNo: Code[20]; VAR pRes: Record Resource): Boolean;
    var
        TempItem: Record item temporary;
    BEGIN
        //OUVRAGE
        IF pResNo = '' THEN
            EXIT(TRUE);
        IF TempItem.GET(pResNo) THEN BEGIN
            pRes := wTempRes;
            EXIT(TRUE);
        END ELSE BEGIN
            pRes.GET(pResNo);
            EXIT(FALSE);
        END;
        //OUVRAGE//
    END;

    PROCEDURE wCalcDetailStructure(pBOMComp: Record "Structure Component"; VAR pCompUnitCost: Decimal; VAR pUnitCost: Decimal; VAR pCompOverhead: Decimal; VAR pCompPR: Decimal; VAR pCompMargin: Decimal; VAR pCompPrice: Decimal);
    VAR
        lResCost: Record "Resource Cost";
        lCompItem: Record item;
        lCompRes: Record Resource;
        lResFindUnitCost: Codeunit "Resource-Find Cost";
        lNumberOfResource: Decimal;
        UOMMgt: Codeunit "Unit of Measure Management";
        GLSetup: Record "General Ledger Setup";
    BEGIN
        //OUVRAGE
        WITH pBOMComp DO BEGIN
            IF ("No." = '') OR (Type = Type::" ") THEN
                EXIT;
            pCompUnitCost := 0;
            pCompOverhead := 0;
            pCompMargin := 0;
            pCompPrice := 0;
            CASE TRUE OF
                Type = Type::Item:
                    BEGIN
                        lCompItem.GET("No.");
                        IF (Subcontracting <> 0) AND ("Subcontracted Unit Cost" <> 0) THEN
                            lCompItem."Standard Cost" := "Subcontracted Unit Cost";
                        IF lCompItem."Standard Cost" <> 0 THEN
                            lCompItem."Unit Cost" := lCompItem."Standard Cost";
                        pCompUnitCost :=
                          ("Fixed Quantity" + "Quantity per") *
                          UOMMgt.GetQtyPerUnitOfMeasure(lCompItem, "Unit of Measure Code") *
                          lCompItem."Unit Cost";
                        pUnitCost := lCompItem."Unit Cost";
                        wOverRule."Gen. Prod. Posting Group" := lCompItem."Gen. Prod. Posting Group";
                        wMarginRule."Gen. Prod. Posting Group" := lCompItem."Gen. Prod. Posting Group";
                    END;
                Type IN [Type::Person, Type::Machine]:
                    BEGIN
                        lCompRes.GET("No.");
                        lResCost.INIT;
                        lResCost.Code := "No.";
                        lResCost."Work Type Code" := '';
                        //lResFindUnitCost.RUN(lResCost);
                        pCompUnitCost := "Number of Resources" * ("Quantity per" + "Fixed Quantity") * lResCost."Unit Cost";
                        pUnitCost := lCompRes."Unit Cost";
                        wOverRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                        wMarginRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                    END;
                Type = Type::Structure:
                    BEGIN
                        lCompRes.GET("No.");
                        pCompUnitCost := ("Quantity per" + "Fixed Quantity") * lCompRes."Unit Cost";
                        pUnitCost := lCompRes."Unit Cost";
                        wOverRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                        wMarginRule."Gen. Prod. Posting Group" := lCompRes."Gen. Prod. Posting Group";
                    END;
            END;

            wOverCalc.FetchRule(wOverRule.Type::Overhead, wOverRule);
            pCompOverhead := ROUND(
              pCompUnitCost * wOverRule.Value / 100,
              GLSetup."Unit-Amount Rounding Precision");
            wOverCalc.FetchRule(wOverRule.Type::Margin, wMarginRule);
            pCompPrice := ROUND(
              (pCompUnitCost + pCompOverhead) /
              (1 - wMarginRule.Value / 100),
              GLSetup."Unit-Amount Rounding Precision");
            pCompPR := pCompUnitCost + pCompOverhead;
            pCompMargin := pCompPrice - pCompPR;
        END;
        //OUVRAGE//
    END;

    //*************************************Codeunit 8612 ************************************************//

    PROCEDURE Select(VAR pRec: Record "Config. Template Header");
    VAR
        lRecordRef: RecordRef;
        lGLAccount: Record "G/L Account";
        lCustomer: Record Customer;
        lVendor: Record Vendor;
        lItem: Record item;
        lResource: Record Resource;
        lJob: Record Job;
        lContact: Record Contact;
        lEmployee: Record Employee;
        lFixedAsset: Record "Fixed Asset";
    BEGIN
        CASE pRec."Table ID" OF
            DATABASE::"G/L Account":
                BEGIN // 15
                    IF PAGE.RUNMODAL(0, lGLAccount) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lGLAccount);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::Customer:
                BEGIN // 18
                    IF PAGE.RUNMODAL(0, lCustomer) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lCustomer);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::Vendor:
                BEGIN // 23
                    IF PAGE.RUNMODAL(0, lVendor) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lVendor);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::Item:
                BEGIN // 27
                    IF PAGE.RUNMODAL(0, lItem) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lItem);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::Resource:
                BEGIN // 156
                    IF PAGE.RUNMODAL(0, lResource) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lResource);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::Job:
                BEGIN // 8004160
                    IF PAGE.RUNMODAL(0, lJob) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lJob);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::Contact:
                BEGIN // 5050
                    IF PAGE.RUNMODAL(0, lContact) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lContact);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::Employee:
                BEGIN // 5200
                    IF PAGE.RUNMODAL(0, lEmployee) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lEmployee);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
            DATABASE::"Fixed Asset":
                BEGIN // 5600
                    IF PAGE.RUNMODAL(0, lFixedAsset) = ACTION::LookupOK THEN BEGIN
                        lRecordRef.GETTABLE(lFixedAsset);
                        SetTemplate(lRecordRef, pRec);
                    END;
                END;
        END;
    END;

    PROCEDURE Suggest(VAR pTemplate: Record "Config. Template Header");
    VAR
        lRecordRef: RecordRef;
        i: Integer;
        lFieldRef: FieldRef;
        lKeyRef: KeyRef;
        lRec: Record "Config. Template Line";
        lLineNo: Integer;
    BEGIN
        lRec.SETRANGE("Table ID", pTemplate."Table ID");
        lRec.SETRANGE("Data Template Code", pTemplate.Code);
        IF lRec.FINDLAST THEN
            lLineNo := lRec."Line No.";

        lRec.INIT;
        lRec."Table ID" := pTemplate."Table ID";
        lRec."Data Template Code" := pTemplate.Code;


        lRecordRef.OPEN(pTemplate."Table ID");
        FOR i := 1 TO lRecordRef.FIELDCOUNT DO BEGIN
            lFieldRef := lRecordRef.FIELDINDEX(i);
            IF (FORMAT(lFieldRef.CLASS) = 'Normal') AND (FORMAT(lFieldRef.TYPE) <> 'BLOB') THEN BEGIN
                lRec."Field ID" := lFieldRef.NUMBER;
                lRec.VALIDATE("Field Name", lFieldRef.NAME);
                lRec."Line No." := lLineNo + i * 10000;
                IF lRec.INSERT THEN;
            END;
        END;
        lKeyRef := lRecordRef.KEYINDEX(1);
        FOR i := 1 TO lKeyRef.FIELDCOUNT DO BEGIN
            lFieldRef := lKeyRef.FIELDINDEX(i);
            IF lRec.GET(lRec."Data Template Code", lFieldRef.NUMBER) THEN
                lRec.DELETE;
        END;
    END;

    LOCAL PROCEDURE SetTemplate(pRecordRef: RecordRef; pTemplate: Record "Config. Template Header");
    VAR
        i: Integer;
        lFieldRef: FieldRef;
        lKeyRef: KeyRef;
        lRec: Record "Config. Template Line";
        lField: Record Field;
        lLineNo: Integer;
    BEGIN
        lRec.SETRANGE("Table ID", pTemplate."Table ID");
        lRec.SETRANGE("Data Template Code", pTemplate.Code);
        lRec.DELETEALL;

        lRec."Table ID" := pTemplate."Table ID";
        lRec."Data Template Code" := pTemplate.Code;
        FOR i := 1 TO pRecordRef.FIELDCOUNT DO BEGIN
            lFieldRef := pRecordRef.FIELDINDEX(i);
            EVALUATE(lField.Type, FORMAT(lFieldRef.TYPE));
            EVALUATE(lField.Class, FORMAT(lFieldRef.CLASS));
            IF (lField.Class = lField.Class::Normal) AND (lField.Type <> lField.Type::BLOB) THEN BEGIN
                lRec."Field ID" := lFieldRef.NUMBER;
                lRec.VALIDATE("Field Name", lFieldRef.NAME);
                lRec."Line No." := i * 10000;
                IF lField.Type = lField.Type::Boolean THEN
                    lRec."Default Value" := FORMAT(lFieldRef.VALUE, 0, 2) // 0:False, 1:True
                ELSE
                    IF STRLEN(FORMAT(lFieldRef.VALUE)) <= 30 THEN
                        lRec."Default Value" := FORMAT(lFieldRef.VALUE)
                    ELSE
                        lRec."Default Value" := '';
                IF (lRec."Default Value" <> '0') AND (lRec."Default Value" <> '') THEN
                    //       ((FORMAT(lFieldRef.TYPE) <> 'Boolean') OR (lRec."Default Value" <> lFalse)) THEN
                    IF lRec.INSERT THEN;
            END;
        END;
        lKeyRef := pRecordRef.KEYINDEX(1);
        FOR i := 1 TO lKeyRef.FIELDCOUNT DO BEGIN
            lFieldRef := lKeyRef.FIELDINDEX(i);
            lRec.SETRANGE("Table ID", pTemplate."Table ID");
            lRec.SETRANGE("Data Template Code", pTemplate.Code);
            lRec.SETRANGE(lRec."Field ID", lFieldRef.NUMBER);
            IF lRec.FINDFIRST THEN
                lRec.DELETE;
        END;
    END;

    PROCEDURE FieldRefEvaluate(VAR pFieldRef: FieldRef; VAR pValue: Text[250]): Text[250];
    VAR
        lField: Record Field;
        int: Integer;
        txt: Text[250];
        cd: Code[80];
        dec: Decimal;
        opt: Option;
        bln: Boolean;
        dt: Date;
        tm: Time;
        dttm: DateTime;
        df: DateFormula;
    BEGIN
        EVALUATE(lField.Type, FORMAT(pFieldRef.TYPE));
        CASE lField.Type OF
            lField.Type::Integer:
                IF EVALUATE(int, pValue) THEN BEGIN
                    pFieldRef.VALUE := int;
                    EXIT(FORMAT(int));
                END;
            lField.Type::Text:
                IF EVALUATE(txt, pValue) THEN BEGIN
                    pFieldRef.VALUE := txt;
                    EXIT(FORMAT(txt));
                END;
            lField.Type::Code:
                IF EVALUATE(cd, pValue) THEN BEGIN
                    pFieldRef.VALUE := cd;
                    EXIT(FORMAT(cd));
                END;
            lField.Type::Decimal:
                BEGIN
                    pFieldRef.VALUE := gTools.VarToDec(pValue);
                    EXIT(FORMAT(pFieldRef.VALUE));
                END;
            lField.Type::Option:
                IF EVALUATE(opt, pValue) THEN BEGIN
                    pFieldRef.VALUE := opt;
                    EXIT(FORMAT(opt));
                END;
            lField.Type::Boolean:
                IF EVALUATE(bln, pValue) THEN BEGIN
                    pFieldRef.VALUE := bln;
                    EXIT(FORMAT(bln));
                END;
            lField.Type::Date:
                IF EVALUATE(dt, pValue) THEN BEGIN
                    pFieldRef.VALUE := dt;
                    EXIT(FORMAT(dt));
                END;
            lField.Type::Time:
                IF EVALUATE(tm, pValue) THEN BEGIN
                    pFieldRef.VALUE := tm;
                    EXIT(FORMAT(tm));
                END;
            lField.Type::DateTime:
                IF EVALUATE(dttm, pValue) THEN BEGIN
                    pFieldRef.VALUE := dttm;
                    EXIT(FORMAT(dttm));
                END;
            //#7861
            lField.Type::DateFormula:
                IF EVALUATE(df, pValue) THEN BEGIN
                    pFieldRef.VALUE := df;
                    EXIT(FORMAT(df));
                END;
        //#7861//

        END;
    END;

    PROCEDURE GetTemplate(VAR pRecordRef: RecordRef): Boolean;
    VAR
        lTemplate: Record "Config. Template Header";
        lTemplate2: Record "Config. Template Header";
    BEGIN
        lTemplate.SETRANGE("Table ID", pRecordRef.NUMBER);
        IF NOT lTemplate.FIND('-') THEN
            EXIT(TRUE);

        // Disable theese 2 lines code to show a selection form whenever only one template is defined.
        lTemplate2.COPY(lTemplate);
        IF lTemplate2.NEXT <> 0 THEN
            IF PAGE.RUNMODAL(0, lTemplate) <> ACTION::LookupOK THEN
                EXIT(FALSE);

        SetValue(pRecordRef, lTemplate.Code);
        EXIT(TRUE);
    END;

    PROCEDURE SetValue(VAR pRecordRef: RecordRef; pTemplateCode: Code[20]);
    VAR
        Field: Record "Config. Template Line";
        TableField: Record Field;
        RelationRecord: RecordRef;
        RecordField: FieldRef;
        RelationField: FieldRef;
        int: Integer;
        txt: Text[30];
        cd: Code[20];
        dec: Decimal;
        opt: Option;
        bln: Boolean;
        dt: Date;
        tm: Time;
        dttm: DateTime;
        df: DateFormula;
    BEGIN
        Field.SETRANGE("Table ID", pRecordRef.NUMBER);
        Field.SETRANGE("Data Template Code", pTemplateCode);
        IF NOT Field.FIND('-') THEN
            EXIT;

        REPEAT
            RecordField := pRecordRef.FIELD(Field."Field ID");
            CASE FORMAT(RecordField.TYPE) OF
                'Integer':
                    IF EVALUATE(int, Field."Default Value") THEN
                        RecordField.VALUE := int;
                'Text':
                    IF EVALUATE(txt, Field."Default Value") THEN
                        RecordField.VALUE := txt;
                'Code':
                    IF EVALUATE(cd, Field."Default Value") THEN
                        RecordField.VALUE := cd;
                'Decimal':
                    IF EVALUATE(dec, Field."Default Value") THEN
                        RecordField.VALUE := dec;
                'Option':
                    IF EVALUATE(opt, Field."Default Value") THEN
                        RecordField.VALUE := opt;
                'Boolean':
                    IF EVALUATE(bln, Field."Default Value") THEN
                        RecordField.VALUE := bln;
                'Date':
                    IF EVALUATE(dt, Field."Default Value") THEN
                        RecordField.VALUE := dt;
                'Time':
                    IF EVALUATE(tm, Field."Default Value") THEN
                        RecordField.VALUE := tm;
                'DateTime':
                    IF EVALUATE(dttm, Field."Default Value") THEN
                        RecordField.VALUE := dttm;
                //#7861
                'DateFormula':
                    IF EVALUATE(df, Field."Default Value") THEN
                        RecordField.VALUE := df;
            //#7861//
            END;

        //  IF Field.Validate THEN
        //    RecordField.VALIDATE;

        UNTIL Field.NEXT = 0;
    END;

    PROCEDURE Check(pRecordRef: RecordRef; pTemplateCode: Code[10]): Boolean;
    VAR
        lDataTemplateLine: Record "Config. Template Line";
        lFieldRef: FieldRef;
        lValue: Text[250];
        tIsMandatory: Label 'is mandatory as défine by template %1';
    BEGIN
        WITH lDataTemplateLine DO BEGIN
            IF pTemplateCode = '' THEN
                pTemplateCode := FORMAT(pRecordRef.NUMBER);
            SETRANGE("Data Template Code", pTemplateCode);
            lDataTemplateLine.SETRANGE(Mandatory, TRUE);
            IF FINDFIRST THEN
                REPEAT
                    lFieldRef := pRecordRef.FIELD("Field ID");
                    lValue := FORMAT(lFieldRef.VALUE);
                    IF lValue = '' THEN
                        lFieldRef.FIELDERROR(STRSUBSTNO(tIsMandatory, pTemplateCode));
                UNTIL NEXT = 0;
        END;
        EXIT(TRUE);
    END;

    PROCEDURE "HJ DSFT"();
    BEGIN
    END;

    PROCEDURE GetMandatoryFields(TableID: Integer): Boolean;
    VAR
        KeyFieldCount: Integer;
        FindMandatory: Boolean;
        //  RecLFields: Record "Mandatory Fields" temporary;
        Error001: Label 'Veuillez renseigner les champ(s) obligatoire(s) ci dessous';
    BEGIN
        FOR KeyFieldCount := 1 TO ARRAYLEN(FieldsArrayKey)
        DO BEGIN
            IF FieldsArrayKey[KeyFieldCount] <> 0 THEN BEGIN
                FindMandatory := TRUE;
                /*  RecLFields.INIT;
                  RecLFields."Field ID" := FieldsArrayKey[KeyFieldCount];
                  RecLFields."Field Name" := FieldsArrayName[KeyFieldCount];
                  RecLFields."Table ID" := TableID;
                  RecLFields.INSERT;*/
            END
        END;
        IF FindMandatory THEN BEGIN
            //  PAGE.RUN(0, RecLFields);
            ERROR(Error001);
        END;
        EXIT(FindMandatory);
    END;

    PROCEDURE CheckMandatoriesFields(VAR RecRef: RecordRef): Boolean;
    VAR
        TemplateHeader: Record "Config. Template Header";
        Index: Integer;
        TemplateLine: Record "Config. Template Line";
        FieldRef: FieldRef;
        FieldRefItem: FieldRef;
        RecItem: Record item;
        Text001: Label 'Il n''existe pas de modŠle de validation pour cette table';
    BEGIN
        //hs
        FieldRefItem := RecRef.Field(10);
        //hs
        TemplateHeader.SETRANGE("Table ID", RecRef.NUMBER);
        TemplateHeader.SETRANGE("Validation Template", TRUE);
        IF TemplateHeader.FINDFIRST THEN BEGIN
            Index := 1;
            TemplateLine.SETRANGE("Data Template Code", TemplateHeader.Code);
            //hs
            if Format(FieldRefItem.Value) = Format(RecItem.Type::Service) then
                TemplateLine.SetRange("Article de service", false);
            //hs
            IF TemplateLine.FIND('-') THEN
                REPEAT
                    IF TemplateLine.Type = TemplateLine.Type::Field THEN BEGIN
                        IF TemplateLine."Field ID" <> 0 THEN BEGIN
                            FieldRef := RecRef.FIELD(TemplateLine."Field ID");
                            IF (TemplateLine.Mandatory) AND (FORMAT(FieldRef) = '') THEN BEGIN
                                FieldsArrayName[Index] := TemplateLine."Field Name";
                                FieldsArrayKey[Index] := TemplateLine."Field ID";
                                Index := Index + 1;

                            END
                        END
                    END
                UNTIL TemplateLine.NEXT = 0;
        END
        ELSE
            ;
        //MESSAGE(Text001);
        EXIT(GetMandatoryFields(TemplateHeader."Table ID"));
    END;

    //*************************************Codeunit 99000832 ************************************************//
    procedure InitTrackingSpecification(var SalesLine: Record "Sales Line"; TrackingSpecification: Record "Tracking Specification")
    begin


        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Sales Line";
        WITH SalesLine DO BEGIN
            TrackingSpecification."Item No." := "No.";
            TrackingSpecification."Location Code" := "Location Code";
            TrackingSpecification.Description := Description;
            TrackingSpecification."Variant Code" := "Variant Code";
            TrackingSpecification."Source Subtype" := "Document Type";
            TrackingSpecification."Source ID" := "Document No.";
            TrackingSpecification."Source Batch Name" := '';
            TrackingSpecification."Source Prod. Order Line" := 0;
            TrackingSpecification."Source Ref. No." := "Line No.";
            TrackingSpecification."Quantity (Base)" := "Quantity (Base)";
            TrackingSpecification."Qty. to Invoice (Base)" := "Qty. to Invoice (Base)";
            TrackingSpecification."Qty. to Invoice" := "Qty. to Invoice";
            TrackingSpecification."Quantity Invoiced (Base)" := "Qty. Invoiced (Base)";
            TrackingSpecification."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            TrackingSpecification."Bin Code" := "Bin Code";

            IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
                TrackingSpecification."Qty. to Handle (Base)" := "Return Qty. to Receive (Base)";
                TrackingSpecification."Quantity Handled (Base)" := "Return Qty. Received (Base)";
                TrackingSpecification."Qty. to Handle" := "Return Qty. to Receive";
            END ELSE BEGIN
                TrackingSpecification."Qty. to Handle (Base)" := "Qty. to Ship (Base)";
                TrackingSpecification."Quantity Handled (Base)" := "Qty. Shipped (Base)";
                TrackingSpecification."Qty. to Handle" := "Qty. to Ship";
            END;
            //+REF+LOT
            IF "Lot No."[1] <> '*' THEN
                TrackingSpecification."Lot No." := "Lot No.";
            IF "Serial No."[1] <> '*' THEN
                TrackingSpecification."Serial No." := "Serial No.";
            //+REF+LOT//
        END;
    end;

    procedure ComposeRowID(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer): text[250]
    var
        StrArray: array[2] of text[100];
        Pos, Len, T : Integer;
    begin

        StrArray[1] := ID;
        StrArray[2] := BatchName;
        FOR T := 1 TO 2 DO BEGIN
            IF STRPOS(StrArray[T], '"') > 0 THEN BEGIN
                Len := STRLEN(StrArray[T]);
                Pos := 1;
                REPEAT
                    IF COPYSTR(StrArray[T], Pos, 1) = '"' THEN BEGIN
                        StrArray[T] := INSSTR(StrArray[T], '"', Pos + 1);
                        Len += 1;
                        Pos += 1;
                    END;
                    Pos += 1;
                UNTIL Pos > Len;
            END;
        END;
        EXIT(STRSUBSTNO('"%1";"%2";"%3";"%4";"%5";"%6"', Type, Subtype, StrArray[1], StrArray[2], ProdOrderLine, RefNo));

    end;

    PROCEDURE fCallItemTracking(VAR pSalesLine: Record "Sales Line"; pType: Option Lookup,Delete,Validate; pSerialLot: Option Serial,Lot; pExpDate: Date);
    VAR
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingForm: PAGE "Item Tracking Lines";
        CduSalesLineReserv: Codeunit "Sales Line-Reserve";
        ItemTrackingMgt: Codeunit "Item Tracing Mgt.";
    BEGIN
        InitTrackingSpecification(pSalesLine, TrackingSpecification);
        IF ((pSalesLine."Document Type" = pSalesLine."Document Type"::Invoice) AND
            (pSalesLine."Shipment No." <> '')) OR
           ((pSalesLine."Document Type" = pSalesLine."Document Type"::"Credit Memo") AND
            (pSalesLine."Return Receipt No." <> ''))
        THEN
            ItemTrackingForm.SetRunMode(2); // Combined shipment/receipt
        IF pSalesLine."Drop Shipment" THEN BEGIN
            ItemTrackingForm.SetRunMode(3); // Drop Shipment
            IF pSalesLine."Purchase Order No." <> '' THEN
                ItemTrackingForm.SetSecondSourceRowID(ComposeRowID(DATABASE::"Purchase Line",
                  1, pSalesLine."Purchase Order No.", '', 0, pSalesLine."Purch. Order Line No."));
        END;
        ItemTrackingForm.SetSourceSpec(TrackingSpecification, pSalesLine."Shipment Date");
        ItemTrackingForm.fSetLot(pType, pSerialLot, pExpDate);
        ItemTrackingForm.RUNMODAL;
    END;
    //*************************************Codeunit 378 ************************************************//
    local procedure DeletePurchLines(var PurchLine: Record "Purchase Line"): Boolean
    var
        PurchLine2: Record "Purchase Line";
    begin
        PurchLine2.SetRange("Document Type", PurchLine."Document Type");
        PurchLine2.SetRange("Document No.", PurchLine."Document No.");
        PurchLine2.SetRange("Attached to Line No.", PurchLine."Line No.");

        PurchLine2 := PurchLine;
        if PurchLine2.Find('>') then begin
            repeat
                PurchLine2.Delete(true);
            until PurchLine2.Next() = 0;
            exit(true);
        end;
    end;

    PROCEDURE wPurchasingCheckIfAnyAttText(VAR PurchLine: Record "Purchase Line"; pAttachedToLineNo: Integer): Boolean;
    VAR
        lSalesLine: Record "Sales Line";
        lItem: Record item;
        lSubSingleInstance: Codeunit "NaviBat SingleInstance";
        lLineNo: Integer;
        lPurchText: Option Structure,Item,Both;
        CduTransfExttxt: Codeunit "Transfer Extended Text";
        TmpExtTextLine: Record "Extended Text Line" temporary;
    BEGIN
        MakeUpdateRequired := FALSE;
        IF PurchLine."Line No." <> 0 THEN
            MakeUpdateRequired := DeletePurchLines(PurchLine);

        TmpExtTextLine.DELETEALL;

        IF PurchLine.Type <> PurchLine.Type::" " THEN BEGIN
            lPurchText := lSubSingleInstance.Get;
            IF lPurchText IN [lPurchText::Item, lPurchText::Both] THEN BEGIN
                IF NOT lItem.GET(PurchLine."No.") THEN
                    lItem.INIT;
                IF lItem."Item Type" <> 0 THEN
                    CduTransfExttxt.PurchCheckIfAnyExtText(PurchLine, FALSE);
                IF lPurchText = lPurchText::Item THEN
                    EXIT(TmpExtTextLine.FIND('-'));
            END;
        END;

        CLEAR(lLineNo);
        lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SETRANGE("Document Type", PurchLine."Sales Document Type" - 1);
        lSalesLine.SETRANGE("Line Type", lSalesLine."Line Type"::" ");
        IF PurchLine."Sales Order No." <> '' THEN BEGIN
            lSalesLine.SETRANGE("Document No.", PurchLine."Sales Order No.");
            IF pAttachedToLineNo <> 0 THEN
                lSalesLine.SETRANGE("Attached to Line No.", pAttachedToLineNo)
            ELSE
                lSalesLine.SETRANGE("Attached to Line No.", PurchLine."Sales Order Line No.");
        END ELSE
            IF PurchLine."Special Order Sales No." <> '' THEN BEGIN
                lSalesLine.SETRANGE("Document No.", PurchLine."Special Order Sales No.");
                IF pAttachedToLineNo <> 0 THEN
                    lSalesLine.SETRANGE("Attached to Line No.", pAttachedToLineNo)
                ELSE
                    lSalesLine.SETRANGE("Attached to Line No.", PurchLine."Special Order Sales Line No.");
            END;
        IF lSalesLine.FIND('-') THEN BEGIN
            IF TmpExtTextLine.FIND('+') THEN
                lLineNo := TmpExtTextLine."Line No.";
            REPEAT
                TmpExtTextLine.INIT;
                TmpExtTextLine."Table Name" := TmpExtTextLine."Table Name"::"Standard Text";
                TmpExtTextLine."No." := PurchLine."No.";
                TmpExtTextLine."Line No." := lLineNo + 10000;
                lLineNo := TmpExtTextLine."Line No.";
                TmpExtTextLine.Text := lSalesLine.Description;
                //+REF+MEMOPAD
                TmpExtTextLine.Separator := lSalesLine.Separator;
                //+REF+MEMOPAD//
                TmpExtTextLine.INSERT;
            UNTIL lSalesLine.NEXT = 0;
            EXIT(TRUE);
        END;

        EXIT(TmpExtTextLine.FIND('-'));
    END;

    PROCEDURE wInsertSalesLineDescription(VAR pRec: Record "Sales Line"): Boolean;
    VAR
        lFromDescriptionLine: Record "Description Line";
    BEGIN
        CASE pRec.Type OF
            pRec.Type::Item:
                lFromDescriptionLine."Table ID" := DATABASE::Item;
            pRec.Type::Resource:
                lFromDescriptionLine."Table ID" := DATABASE::Resource;
            pRec.Type::"G/L Account":
                lFromDescriptionLine."Table ID" := DATABASE::"G/L Account";
            ELSE
        END;
        lFromDescriptionLine.CopyLines(
            lFromDescriptionLine."Table ID", 0, pRec."No.", 0,
            DATABASE::"Sales Line", pRec."Document Type", pRec."Document No.", pRec."Line No.");
    END;

    PROCEDURE wDeleteSalesLineDescription(VAR pRec: Record "Sales Line"): Boolean;
    VAR
        lFromDescriptionLine: Record "Description Line";
    BEGIN
        CASE pRec.Type OF
            pRec.Type::Item:
                lFromDescriptionLine."Table ID" := DATABASE::Item;
            pRec.Type::Resource:
                lFromDescriptionLine."Table ID" := DATABASE::Resource;
            pRec.Type::"G/L Account":
                lFromDescriptionLine."Table ID" := DATABASE::"G/L Account";
            ELSE
        END;
        lFromDescriptionLine.DeleteLines(
            DATABASE::"Sales Line", pRec."Document Type", pRec."Document No.", pRec."Line No.");
    END;
    //*************************************Codeunit 99000834 ************************************************//

    procedure InitTrackingSpecification3(var PurchLine: Record "Purchase Line"; var TrackingSpecification: Record "Tracking Specification")
    begin


        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Purchase Line";
        WITH PurchLine DO BEGIN
            TrackingSpecification."Item No." := "No.";
            TrackingSpecification."Location Code" := "Location Code";
            TrackingSpecification.Description := Description;
            TrackingSpecification."Variant Code" := "Variant Code";
            TrackingSpecification."Source Subtype" := "Document Type";
            TrackingSpecification."Source ID" := "Document No.";
            TrackingSpecification."Source Batch Name" := '';
            TrackingSpecification."Source Prod. Order Line" := 0;
            TrackingSpecification."Source Ref. No." := "Line No.";
            TrackingSpecification."Quantity (Base)" := "Quantity (Base)";
            TrackingSpecification."Qty. to Invoice (Base)" := "Qty. to Invoice (Base)";
            TrackingSpecification."Qty. to Invoice" := "Qty. to Invoice";
            TrackingSpecification."Quantity Invoiced (Base)" := "Qty. Invoiced (Base)";
            TrackingSpecification."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            TrackingSpecification."Bin Code" := "Bin Code";

            IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
                TrackingSpecification."Qty. to Handle (Base)" := "Return Qty. to Ship (Base)";
                TrackingSpecification."Quantity Handled (Base)" := "Return Qty. Shipped (Base)";
                TrackingSpecification."Qty. to Handle" := "Return Qty. to Ship";
            END ELSE BEGIN
                TrackingSpecification."Qty. to Handle (Base)" := "Qty. to Receive (Base)";
                TrackingSpecification."Quantity Handled (Base)" := "Qty. Received (Base)";
                TrackingSpecification."Qty. to Handle" := "Qty. to Receive";
            END;
            //+REF+LOT
            IF "Lot No."[1] <> '*' THEN
                TrackingSpecification."Lot No." := "Lot No.";
            IF "Serial No."[1] <> '*' THEN
                TrackingSpecification."Serial No." := "Serial No.";
            IF PurchLine."Expiration Date" <> 0D THEN
                TrackingSpecification."Expiration Date" := PurchLine."Expiration Date";
            //+REF+LOT//
        END;
    end;

    procedure HasSamePointer(var ReservEntry: Record "Reservation Entry"; var Reserventry2: Record "Reservation Entry"): Boolean
    begin

        EXIT
          ((ReservEntry."Source Type" = Reserventry2."Source Type") AND
          (ReservEntry."Source Subtype" = Reserventry2."Source Subtype") AND
          (ReservEntry."Source ID" = Reserventry2."Source ID") AND
          (ReservEntry."Source Batch Name" = Reserventry2."Source Batch Name") AND
          (ReservEntry."Source Prod. Order Line" = Reserventry2."Source Prod. Order Line") AND
          (ReservEntry."Source Ref. No." = Reserventry2."Source Ref. No."));

    end;

    PROCEDURE wTransferQuotePurchToOrdePurch(VAR OldPurchline: Record "Purchase Line"; VAR NewPurchLine: Record "Purchase Line"; TransferQty: Decimal; TransferAll: Boolean);
    VAR
        OldReservEntry: Record "Reservation Entry";
        OldReservEntry2: Record "Reservation Entry";
        NewReservEntry: Record "Reservation Entry";
        ActionMessageEntry: Record "Action Message Entry";
        ActionMessageEntry2: Record "Action Message Entry";
        CduPurchlinres: Codeunit "Purch. Line-Reserve";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
    BEGIN
        //+OFF+OFFRE
        IF NOT CduPurchlinres.FindReservEntry(OldPurchline, OldReservEntry) THEN
            EXIT;

        NewPurchLine.TESTFIELD("No.", OldPurchline."No.");
        NewPurchLine.TESTFIELD("Variant Code", OldPurchline."Variant Code");
        NewPurchLine.TESTFIELD("Location Code", OldPurchline."Location Code");
        NewPurchLine.TESTFIELD("Bin Code", OldPurchline."Bin Code");

        IF TransferAll THEN BEGIN
            OldReservEntry.FIND('-');
            OldReservEntry.TESTFIELD("Qty. per Unit of Measure", NewPurchLine."Qty. per Unit of Measure");

            REPEAT
                OldReservEntry.TESTFIELD("Item No.", OldPurchline."No.");
                OldReservEntry.TESTFIELD("Variant Code", OldPurchline."Variant Code");
                OldReservEntry.TESTFIELD("Location Code", OldPurchline."Location Code");
                //OldReservEntry.TESTFIELD("Bin Code",OldPurchline."Bin Code");

                NewReservEntry := OldReservEntry;
                NewReservEntry."Source Type" := DATABASE::"Purchase Line";
                NewReservEntry."Source Subtype" := NewPurchLine."Document Type";
                NewReservEntry."Source ID" := NewPurchLine."Document No.";
                NewReservEntry."Source Batch Name" := '';
                NewReservEntry."Source Prod. Order Line" := 0;
                NewReservEntry."Source Ref. No." := NewPurchLine."Line No.";

                IF OldReservEntry."Reservation Status" = OldReservEntry."Reservation Status"::Surplus THEN BEGIN
                    ActionMessageEntry.FilterFromReservEntry(OldReservEntry);
                    IF ActionMessageEntry.FIND('-') THEN
                        REPEAT
                            ActionMessageEntry2 := ActionMessageEntry;
                            ActionMessageEntry2.TransferFromReservEntry(NewReservEntry);
                            ActionMessageEntry2.MODIFY;
                        UNTIL ActionMessageEntry.NEXT = 0;
                    NewReservEntry.MODIFY;
                END ELSE
                    IF OldReservEntry2.GET(OldReservEntry."Entry No.", NOT OldReservEntry.Positive) THEN BEGIN
                        IF HasSamePointer(OldReservEntry2, NewReservEntry) THEN BEGIN
                            OldReservEntry2.DELETE;
                            NewReservEntry.DELETE;
                        END ELSE
                            NewReservEntry.MODIFY;
                    END ELSE
                        NewReservEntry.MODIFY;
            UNTIL OldReservEntry.NEXT = 0;
        END ELSE BEGIN
            IF TransferQty = 0 THEN
                EXIT;
            OldReservEntry.SETRANGE("Reservation Status", OldReservEntry."Reservation Status"::Tracking);

            IF OldReservEntry.FIND('-') THEN
                REPEAT
                    OldReservEntry.TESTFIELD("Item No.", OldPurchline."No.");
                    OldReservEntry.TESTFIELD("Variant Code", OldPurchline."Variant Code");
                    OldReservEntry.TESTFIELD("Location Code", OldPurchline."Location Code");
                    //OldReservEntry.TESTFIELD("Bin Code",OldPurchline."Bin Code");

                    TransferQty := CreateReservEntry.TransferReservEntry(DATABASE::"Purchase Line",
                      NewPurchLine."Document Type", NewPurchLine."Document No.", '', 0,
                      NewPurchLine."Line No.", NewPurchLine."Qty. per Unit of Measure", OldReservEntry, TransferQty);
                UNTIL (OldReservEntry.NEXT = 0) OR (TransferQty = 0);
        END;
        //+OFF+OFFRE//
    END;

    PROCEDURE fCallItemTracking(VAR PurchLine: Record "Purchase Line"; pType: Option Lookup,Delete,Validate,ValidateExpDate; pSerialLot: Option Serial,Lot; pExpDate: Date);
    VAR
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingForm: page "Item Tracking Lines";
    BEGIN
        //+REF+LOT
        COMMIT;
        InitTrackingSpecification3(PurchLine, TrackingSpecification);
        IF ((PurchLine."Document Type" = PurchLine."Document Type"::Invoice) AND
            (PurchLine."Receipt No." <> '')) OR
           ((PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo") AND
            (PurchLine."Return Shipment No." <> ''))
        THEN
            ItemTrackingForm.SetRunMode(2); // Combined shipment/receipt
        IF PurchLine."Drop Shipment" THEN BEGIN
            ItemTrackingForm.SetRunMode(3); // Drop Shipment
            IF PurchLine."Sales Order No." <> '' THEN
                ItemTrackingForm.SetSecondSourceRowID(ComposeRowID(DATABASE::"Sales Line",
                  1, PurchLine."Sales Order No.", '', 0, PurchLine."Sales Order Line No."));
        END;
        ItemTrackingForm.SetSourcespec(TrackingSpecification, PurchLine."Expected Receipt Date");
        ItemTrackingForm.fSetLot(pType, pSerialLot, pExpDate);
        ItemTrackingForm.RUNMODAL;
        //+REF+LOT//
    END;

    //*************************************Codeunit 99000835 ************************************************//
    procedure InitTrackingSpecification2(var ItemJnlLine: Record "Item Journal Line"; var TrackingSpecification: Record "Tracking Specification")
    begin

        TrackingSpecification.INIT;
        TrackingSpecification."Source Type" := DATABASE::"Item Journal Line";
        WITH ItemJnlLine DO BEGIN
            TrackingSpecification."Item No." := "Item No.";
            TrackingSpecification."Location Code" := "Location Code";
            TrackingSpecification.Description := Description;
            TrackingSpecification."Variant Code" := "Variant Code";
            TrackingSpecification."Source Subtype" := "Entry Type";
            TrackingSpecification."Source ID" := "Journal Template Name";
            TrackingSpecification."Source Batch Name" := "Journal Batch Name";
            TrackingSpecification."Source Prod. Order Line" := 0;
            TrackingSpecification."Source Ref. No." := "Line No.";
            TrackingSpecification."Quantity (Base)" := "Quantity (Base)";
            TrackingSpecification."Qty. to Handle" := Quantity;
            TrackingSpecification."Qty. to Handle (Base)" := "Quantity (Base)";
            TrackingSpecification."Qty. to Invoice" := Quantity;
            TrackingSpecification."Qty. to Invoice (Base)" := "Quantity (Base)";
            TrackingSpecification."Quantity Handled (Base)" := 0;
            TrackingSpecification."Quantity Invoiced (Base)" := 0;
            TrackingSpecification."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            TrackingSpecification."Bin Code" := "Bin Code";
        END;
    end;

    procedure FilterReservFor(var FilterReservEntry: Record "Reservation Entry"; ItemJnlLine: record "Item Journal Line")
    begin

        FilterReservEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        FilterReservEntry.SETRANGE("Source Subtype", ItemJnlLine."Entry Type");
        FilterReservEntry.SETRANGE("Source ID", ItemJnlLine."Journal Template Name");
        FilterReservEntry.SETRANGE("Source Batch Name", ItemJnlLine."Journal Batch Name");
        FilterReservEntry.SETRANGE("Source Prod. Order Line", 0);
        FilterReservEntry.SETRANGE("Source Ref. No.", ItemJnlLine."Line No.");

        FilterReservEntry.SETRANGE("Serial No.", ItemJnlLine."Serial No.");
        FilterReservEntry.SETRANGE("Lot No.", ItemJnlLine."Lot No.");
    end;

    PROCEDURE fCallItemTracking(VAR pItemJnlLine: Record "Item Journal Line"; IsReclass: Boolean; pType: Option Lookup,Delete,Validate; pSerialLot: Option Serial,Lot; pExpDate: Date);
    VAR
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingForm: page "Item Tracking Lines";
        ReservEntry: Record "Reservation Entry";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        Text006: Label 'You cannot define item tracking on %1 %2';
        CduItemJnlreser: Codeunit "Item Jnl. Line-Reserve";
    BEGIN
        //+REF+LOT
        IF NOT pItemJnlLine.ItemPosting THEN BEGIN
            ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, FALSE);
            FilterReservFor(ReservEntry, pItemJnlLine);
            ReservEntry.SETRANGE("Serial No.");
            ReservEntry.SETRANGE("Lot No.");
            IF NOT ReservEntry.FIND('-') THEN
                ERROR(Text006, pItemJnlLine.FIELDCAPTION("Operation No."), pItemJnlLine."Operation No.");
        END;
        InitTrackingSpecification2(pItemJnlLine, TrackingSpecification);
        IF IsReclass THEN
            ItemTrackingForm.SetRunMode(1);
        ItemTrackingForm.SetSourcespec(TrackingSpecification, pItemJnlLine."Posting Date");
        ItemTrackingForm.fSetLot(pType, pSerialLot, pExpDate);
        ItemTrackingForm.RUNMODAL;
        //+REF+LOT//
    END;

    //*************************************Codeunit 5940 ************************************************//
    PROCEDURE fSetServContractLine(pServContractLine: Record "Service Contract Line"; pDocNo: Code[20]; pInvFrom: Date; pInvTo: Date; pInvoiceAmount: Decimal; pInvoicePeriod: Option Month,"Two Months",Quarter,"Half Year",Year,None);
    VAR
        lServLedgEntry: Record "Service Ledger Entry";
        lFirstLine: Boolean;
        lLastLineNo: Integer;
        CduServContractManagement: Codeunit ServContractManagement;
    BEGIN
        gServContractLine := pServContractLine;
        gInvFrom := pInvFrom;
        gInvTo := pInvTo;
        gLineInvoiceAmount := CduServContractManagement.CalcContractLineAmount(pServContractLine."Line Amount", pInvFrom, pInvTo);
        lServLedgEntry.SETCURRENTKEY("Entry Type", "Document Type", "Document No.", "Document Line No.");
        lServLedgEntry.SETRANGE("Entry Type", lServLedgEntry."Entry Type"::Sale);
        lServLedgEntry.SETRANGE("Document Type", lServLedgEntry."Document Type"::" ");
        lServLedgEntry.SETRANGE("Document No.", pDocNo);
        lServLedgEntry.SETRANGE("Document Line No.", pServContractLine."Line No.");
        lServLedgEntry.SETRANGE("Service Contract No.", pServContractLine."Contract No.");
        IF pInvoicePeriod = pInvoicePeriod::Month THEN BEGIN
            lServLedgEntry.FINDFIRST;
            gServiceApplyEntry := lServLedgEntry."Entry No.";
            lServLedgEntry."Document Line No." := 0;
            lServLedgEntry."Apply Until Entry No." := 0;
            lServLedgEntry.MODIFY;
        END ELSE BEGIN
            lServLedgEntry.FINDLAST;
            lLastLineNo := lServLedgEntry."Entry No.";
            IF lServLedgEntry.FINDSET(TRUE, FALSE) THEN BEGIN
                gServiceApplyEntry := lServLedgEntry."Entry No.";
                lServLedgEntry."Apply Until Entry No." := lLastLineNo;
                lServLedgEntry.MODIFY;
                lServLedgEntry.MODIFYALL("Document Line No.", 0);
            END;
        END;
    END;

    PROCEDURE fClearNewGlobals();
    BEGIN
        gServContractLine.INIT;
        CLEAR(gInvFrom);
        CLEAR(gInvTo);
        CLEAR(gLineInvoiceAmount);
        CLEAR(gServiceApplyEntry);
    END;
}