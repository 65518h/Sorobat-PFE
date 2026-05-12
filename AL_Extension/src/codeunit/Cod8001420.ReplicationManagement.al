Codeunit 8001420 "Replication Management"
{
    // //+REF+REPLIC CW 28/04/05 Replication Management
    // //BAT_REPLIC CW 22/09/05 Rename BAT rec.

    Permissions = TableData Vendor = rimd,
                  TableData Item = rimd,
                  TableData "Item Translation" = rimd,
                  TableData "BOM Component" = rimd,
                  TableData "Comment Line" = rimd,
                  TableData "Item Vendor" = rimd,
                  TableData Resource = rimd,
                  TableData "Standard Vendor Purchase Code" = rimd,
                  TableData "Resource Price" = rimd,
                  TableData "Resource Cost" = rimd,
                  TableData "Unit of Measure" = rimd,
                  TableData "Resource Unit of Measure" = rimd,
                  TableData "Order Address" = rimd,
                  TableData "Extended Text Header" = rimd,
                  TableData "Extended Text Line" = rimd,
                  TableData "Vendor Bank Account" = rimd,
                  TableData "Default Dimension" = rimd,
                  TableData Contact = rimd,
                  TableData "Item Variant" = rimd,
                  TableData "Item Unit of Measure" = rimd,
                  TableData "Stockkeeping Unit" = rimd,
                  TableData "Item Substitution" = rimd,
                  TableData "Item Cross Reference" = rimd,
                  TableData "Nonstock Item" = rimd,
                  TableData "Sales Price" = rimd,
                  TableData "Sales Line Discount" = rimd,
                  TableData "Purchase Price" = rimd,
                  TableData "Purchase Line Discount" = rimd,
                  TableData Translation2 = rimd,
                  TableData Bitmap = rimd,
                  //GL2024  TableData "Resource Cost" = rimd,
                  //GL2024       TableData 8003916 = rimd,
                  TableData Tree = rimd,
                  TableData "Interim Mission" = rimd,
                  TableData "Resource / Resource Group" = rimd,
                  TableData "Structure Component" = rimd,
                  TableData "Description Line" = rimd,
                  TableData "Vendor Item Category Group" = rimd;

    trigger OnRun()
    var
        lReplicationSetup: Record "Replication Setup";
        lTableTrigger: Record "Replication Log";
        lReplicationTable: Record "Replication Table";
        lFromRecordRef: RecordRef;
        lFromKeyRef: KeyRef;
        lFromFieldRef: FieldRef;
        lToRecordRef: RecordRef;
        lToKeyRef: KeyRef;
        lToFieldRef: FieldRef;
        i: Integer;
        lExists: Boolean;
        lVariant: Variant;
        lCode20: Code[20];
        lReplicationMgt: Codeunit "Replication Management";
        lProgress: Codeunit "Progress Dialog2";
        lReplicationTrigger: Codeunit "Replication Trigger";
    begin

        lReplicationSetup.GET;
        lReplicationSetup.TESTFIELD("Company Name");

        lReplicationTrigger.Stop;

        WITH lTableTrigger DO BEGIN
            CHANGECOMPANY(lReplicationSetup."Company Name");
            SETCURRENTKEY(DateTime);
            SETFILTER(DateTime, '>%1', lReplicationSetup."Last Replication");
            IF NOT FIND('-') THEN
                MESSAGE(tNoReplication)
            ELSE BEGIN
                IF NOT CONFIRM(tConfirm, FALSE, COUNT) THEN
                    EXIT;
                lProgress.Open('', COUNTAPPROX);
                REPEAT
                    lProgress.Update();
                    IF lReplicationTable.GET(TableID) THEN BEGIN
                        lFromRecordRef.OPEN(TableID, FALSE, lReplicationSetup."Company Name");
                        lToRecordRef.OPEN(TableID);
                        lFromKeyRef := lFromRecordRef.KEYINDEX(1);
                        lToKeyRef := lToRecordRef.KEYINDEX(1);
                        FOR i := 1 TO lFromKeyRef.FIELDCOUNT DO BEGIN
                            lFromFieldRef := lFromKeyRef.FIELDINDEX(i);
                            lToFieldRef := lToKeyRef.FIELDINDEX(i);
                            CASE i OF
                                1:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 1");
                                2:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 2");
                                3:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 3");
                                4:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 4");
                                5:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 5");
                                6:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 6");
                                7:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 7");
                                8:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 8");
                                9:
                                    lSetRange(lFromFieldRef, lToFieldRef, "Key 9");
                            END;
                        END;
                        /* GL2024   CASE Trigger OF
              Trigger::Insert,Trigger::Modify:
                                           BEGIN
                                               IF lFromRecordRef.FINDFIRST THEN BEGIN
                                                   lExists := lToRecordRef.FINDFIRST;
                                                   lUpdate(lFromRecordRef, lToRecordRef);
                                                   IF NOT lExists THEN
                                                       lToRecordRef.INSERT(TRUE)
                                                   ELSE
                                                       lToRecordRef.MODIFY(TRUE);
                                               END;
                                           END;
              Trigger::Delete:
                           BEGIN
                               IF lToRecordRef.FINDFIRST THEN
                                   lToRecordRef.DELETE(TRUE);
                           END;
              Trigger::Rename:
                           BEGIN
                               IF lToRecordRef.FIND('-') THEN
                                   RenameTable(lToRecordRef, lTableTrigger);
                           END;
                            END;*/
                        //#7760
                        lFromRecordRef.CLOSE;
                        lToRecordRef.CLOSE;
                        //#7760//
                    END;
                UNTIL NEXT = 0;
                lProgress.Close();

                lReplicationSetup."Last Replication" := CURRENTDATETIME;
                lReplicationSetup.MODIFY;
                MESSAGE(tDone);
                //#7760
                lFromRecordRef.CLOSE;
                lToRecordRef.CLOSE;
                //#7760//
            END;
        END;

        lReplicationTrigger.Start;
    end;

    var
        tNotImplemented: label 'Replication only allow simple primary key (Only one column).';
        tDone: label 'Replication done.';
        tConfirm: label 'Do you want to replicate %1 updates?';
        tConfirmReplace: label 'Do you want to replace %4 line(s) of table %2 \by  line(s) from %1 ?';
        WithoutConfirmation: Boolean;
        tNoReplication: label 'No update done since last replication.';


    procedure lUpdate(var pFromRecordRef: RecordRef; var pToRecordRef: RecordRef)
    var
        lException: Record "Replication Exception";
        lField: Record "Field";
        lFromFieldRef: FieldRef;
        lToFieldRef: FieldRef;
        i: Integer;
    begin
        lException.SetRange(lException."Table No.", pFromRecordRef.Number);
        if lException.Find('-') then;

        for i := 1 to pFromRecordRef.FieldCount do begin
            lFromFieldRef := pFromRecordRef.FieldIndex(i);
            while (lException."Field No." <> 0) and (lException."Field No." < lFromFieldRef.Number) do
                if lException.Next = 0 then
                    lException."Field No." := 0;
            if (lFromFieldRef.Number <> lException."Field No.") or WithoutConfirmation then begin
                lToFieldRef := pToRecordRef.FieldIndex(i);
                Evaluate(lField.Type, Format(lFromFieldRef.Type));
                if lField.Type <> lField.Type::Blob then
                    lToFieldRef.Value := lFromFieldRef.Value;
            end;
        end;
        lToFieldRef := pToRecordRef.Field(73754); // R E P L I
        lToFieldRef.Value := true;
    end;


    procedure lSetRange(var pFromFieldRef: FieldRef; var pToFieldRef: FieldRef; var pValue: Code[20])
    var
        lField: Record "Field";
        lCode: Code[20];
        lInteger: Integer;
        lDecimal: Decimal;
        lDate: Date;
        lVariant: Variant;
        lText: Text[20];
    begin
        Evaluate(lField.Type, Format(pFromFieldRef.Type));
        case lField.Type of
            lField.Type::Code:
                begin
                    Evaluate(lCode, pValue);
                    lVariant := lCode;
                end;
            lField.Type::Date:
                begin
                    Evaluate(lDate, pValue);
                    lVariant := lDate;
                end;
            lField.Type::Integer, lField.Type::Option:
                begin
                    if pValue = '' then
                        pValue := '0';
                    Evaluate(lInteger, pValue);
                    lVariant := lInteger;
                end;
            lField.Type::Decimal:
                begin
                    if pValue = '' then
                        pValue := '0';
                    Evaluate(lDecimal, pValue);
                    lVariant := lDecimal;
                end;
            //#8613
            lField.Type::Text:
                begin
                    Evaluate(lText, pValue);
                    lVariant := lText;
                end;
        //#8613//
        end;
        pFromFieldRef.SetRange(lVariant);
        pToFieldRef.SetRange(lVariant);
    end;


    procedure CopyTable(var pFromCompany: Text[30]; pTableNo: Integer)
    var
        lFromRecordRef: RecordRef;
        lToRecordRef: RecordRef;
        lToFieldRef: FieldRef;
        lProgressDlg: Codeunit "Progress Dialog2";
        tProgress: label 'Copy of %1 Table';
        lCount: Integer;
    begin
        lFromRecordRef.Open(pTableNo, false, pFromCompany);
        lToRecordRef.Open(pTableNo);

        if not WithoutConfirmation then
            if not Confirm(tConfirmReplace, false, pFromCompany, lFromRecordRef.Caption, lFromRecordRef.Count, lToRecordRef.Count) then
                exit;
        HideConfirmation();

        lToRecordRef.CurrentKeyIndex(1);
        lToFieldRef := lToRecordRef.Field(73754); // R E P L I
        lToFieldRef.SetRange(true);
        lCount := lFromRecordRef.COUNTAPPROX;
        if lCount > 100 then
            lProgressDlg.Open(StrSubstNo(tProgress, lFromRecordRef.Caption), lCount);

        lToRecordRef.DeleteAll; // Without RunTrigger
        lToRecordRef.CurrentKeyIndex(1);
        if lFromRecordRef.Find('-') then
            repeat
                lUpdate(lFromRecordRef, lToRecordRef);
                if not lToRecordRef.Insert then
                    if lToRecordRef.Modify then;//(TRUE)
                if lCount > 100 then
                    lProgressDlg.Update;
            until lFromRecordRef.Next = 0;
        if lCount > 100 then
            lProgressDlg.Close;
    end;


    procedure HideConfirmation()
    begin
        WithoutConfirmation := true;
    end;


    procedure RenameTable(var pFromRecRef: RecordRef; var pTableTrigger: Record "Replication Log")
    var
        lCustomer: Record Customer;
        lVendor: Record Vendor;
        lItem: Record Item;
        lItemTRanslation: Record "Item Translation";
        lBOMComponent: Record "BOM Component";
        lCommentLine: Record "Comment Line";
        lItemVendor: Record "Item Vendor";
        lResourceGrp: Record "Resource Group";
        lResource: Record Resource;
        lStdVendPurchCode: Record "Standard Vendor Purchase Code";
        lResCost: Record "Resource Cost";
        lResPrice: Record "Resource Price";
        lUnitofMeasure: Record "Unit of Measure";
        lResUnitMeasure: Record "Resource Unit of Measure";
        lOrderAddress: Record "Order Address";
        lExtTextHeader: Record "Extended Text Header";
        lExtTextLine: Record "Extended Text Line";
        lDefaultDim: Record "Default Dimension";
        lContact: Record Contact;
        lEmployee: Record Employee;
        lItemVariant: Record "Item Variant";
        lItemUnitMeasure: Record "Item Unit of Measure";
        lStockKeepingUnit: Record "Stockkeeping Unit";
        lItemSubstitution: Record "Item Substitution";
        lItemCrossRef: Record "Item Reference";
        lNonStockItem: Record "Nonstock Item";
        lSalesPrice: Record "Sales Price";
        lSalesPriceDisc: Record "Sales Line Discount";
        lPurchasePrice: Record "Purchase Price";
        lPurchasePriceDisc: Record "Purchase Line Discount";
        lCodeTranslation: Record Translation2;
        lTree: Record Tree;
        lInterim: Record "Interim Mission";
        "lRes/ResourceGrp": Record "Resource / Resource Group";
        lStructComponent: Record "Structure Component";
        lDescLine: Record "Description Line";
        lVendorItemCatGrp: Record "Vendor Item Category Group";
        lDate: Date;
        ldec: Decimal;
        lOption1: Option;
        lOption2: Option;
        lContactBusinessRel: Record "Contact Business Relation";
    begin
        with pTableTrigger do begin
            case pFromRecRef.Number of
                //#6467
                18:
                    if not lCustomer.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lCustomer);
                        lCustomer.Rename("To Key 1");
                    end;
                //#6467//
                23:
                    if not lVendor.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lVendor);
                        lVendor.Rename("To Key 1");
                    end;
                27:
                    if not lItem.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lItem);
                        lItem.Rename("To Key 1");
                    end;
                30:
                    if not lItemTRanslation.Get("To Key 1", "To Key 2", "To Key 3") then begin
                        pFromRecRef.SetTable(lItemTRanslation);
                        lItemTRanslation.Rename("To Key 1", "To Key 2", "To Key 3");
                    end;
                90:
                    if not lBOMComponent.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lBOMComponent);
                        lBOMComponent.Rename("To Key 1", "To Key 2");
                    end;
                97:
                    if not lCommentLine.Get("To Key 1", "To Key 2", "To Key 3") then begin
                        pFromRecRef.SetTable(lCommentLine);
                        lCommentLine.Rename("To Key 1", "To Key 2", "To Key 3");
                    end;
                99:
                    if not lItemVendor.Get("To Key 1", "To Key 2", "To Key 3") then begin
                        pFromRecRef.SetTable(lItemVendor);
                        lItemVendor.Rename("To Key 1", "To Key 2", "To Key 3");
                    end;
                152:
                    if not lResourceGrp.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lResourceGrp);
                        lResourceGrp.Rename("To Key 1");
                    end;
                156:
                    if not lResource.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lResource);
                        lResource.Rename("To Key 1");
                    end;
                175:
                    if not lStdVendPurchCode.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lStdVendPurchCode);
                        lStdVendPurchCode.Rename("To Key 1", "To Key 2");
                    end;
                201:
                    if not lResPrice.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5") then begin
                        pFromRecRef.SetTable(lResPrice);
                        lResPrice.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5");
                    end;
                202:
                    if not lResCost.Get("To Key 1", "To Key 2", "To Key 3") then begin
                        pFromRecRef.SetTable(lResCost);
                        lResCost.Rename("To Key 1", "To Key 2", "To Key 3");
                    end;
                204:
                    if not lUnitofMeasure.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lUnitofMeasure);
                        lUnitofMeasure.Rename("To Key 1");
                    end;
                205:
                    if not lResUnitMeasure.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lResUnitMeasure);
                        lResUnitMeasure.Rename("To Key 1", "To Key 2");
                    end;
                224:
                    if not lOrderAddress.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lOrderAddress);
                        lOrderAddress.Rename("To Key 1", "To Key 2");
                    end;
                279:
                    if not lExtTextHeader.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4") then begin
                        pFromRecRef.SetTable(lExtTextHeader);
                        lExtTextHeader.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4");
                    end;
                280:
                    if not lExtTextLine.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5") then begin
                        pFromRecRef.SetTable(lExtTextLine);
                        lExtTextLine.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5");
                    end;
                352:
                    if not lDefaultDim.Get("To Key 1", "To Key 2", "To Key 3") then begin
                        pFromRecRef.SetTable(lDefaultDim);
                        lDefaultDim.Rename("To Key 1", "To Key 2", "To Key 3");
                    end;
                5050:
                    if not lContact.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lContact);
                        lContact.Rename("To Key 1");
                    end;
                //#7798
                5054:
                    if not lContactBusinessRel.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lContactBusinessRel);
                        lContactBusinessRel.Rename("To Key 1", "To Key 2");
                    end;
                //#7798//
                5200:
                    if not lEmployee.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lEmployee);
                        lEmployee.Rename("To Key 1");
                    end;
                5401:
                    if not lItemVariant.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lItemVariant);
                        lItemVariant.Rename("To Key 1", "To Key 2");
                    end;
                5404:
                    if not lItemUnitMeasure.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lItemUnitMeasure);
                        lItemUnitMeasure.Rename("To Key 1", "To Key 2");
                    end;
                5700:
                    if not lStockKeepingUnit.Get("To Key 1", "To Key 2", "To Key 3") then begin
                        pFromRecRef.SetTable(lStockKeepingUnit);
                        lStockKeepingUnit.Rename("To Key 1", "To Key 2", "To Key 3");
                    end;
                5715:
                    if not lItemSubstitution.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5", "To Key 6") then begin
                        pFromRecRef.SetTable(lItemSubstitution);
                        lItemSubstitution.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5", "To Key 6");
                    end;
                5717:
                    if not lItemCrossRef.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5", "To Key 6") then begin
                        pFromRecRef.SetTable(lItemCrossRef);
                        lItemCrossRef.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5", "To Key 6");
                    end;
                5718:
                    if not lNonStockItem.Get("To Key 1") then begin
                        pFromRecRef.SetTable(lNonStockItem);
                        lNonStockItem.Rename("To Key 1");
                    end;
                7002:
                    if not lSalesPrice.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5",
                                             "To Key 6", "To Key 7", "To Key 8") then begin
                        pFromRecRef.SetTable(lSalesPrice);
                        lSalesPrice.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5", "To Key 6", "To Key 7", "To Key 8");
                    end;
                7004:
                    begin
                        Evaluate(lDate, "To Key 5");
                        Evaluate(ldec, "To Key 9");
                        if not lSalesPriceDisc.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4", lDate,
                                                      "To Key 6", "To Key 7", "To Key 8", ldec) then begin
                            pFromRecRef.SetTable(lSalesPriceDisc);
                            lSalesPriceDisc.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4", lDate,
                                                     "To Key 6", "To Key 7", "To Key 8", ldec);
                        end;
                    end;
                7012:
                    begin
                        Evaluate(lDate, "To Key 3");
                        Evaluate(ldec, "To Key 7");
                        if not lPurchasePrice.Get("To Key 1", "To Key 2", lDate, "To Key 4", "To Key 5", "To Key 6", ldec, "To Key 8") then begin
                            pFromRecRef.SetTable(lPurchasePrice);
                            lPurchasePrice.Rename("To Key 1", "To Key 2", lDate, "To Key 4", "To Key 5", "To Key 6", ldec, "To Key 8");
                        end;
                    end;
                7014:
                    begin
                        Evaluate(lDate, "To Key 5");
                        Evaluate(ldec, "To Key 9");
                        Evaluate(lOption1, "To Key 1");
                        Evaluate(lOption2, "To Key 3");
                        if not lPurchasePriceDisc.Get(lOption1, "To Key 2", lOption2, "To Key 4", lDate,
                                                  "To Key 6", "To Key 7", "To Key 8", ldec) then begin
                            pFromRecRef.SetTable(lPurchasePriceDisc);
                            lPurchasePriceDisc.Rename(lOption1, "To Key 2", lOption2, "To Key 4", lDate, "To Key 6", "To Key 7", "To Key 8", ldec);
                        end;
                    end;
                8001411:
                    if not lCodeTranslation.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4") then begin
                        pFromRecRef.SetTable(lCodeTranslation);
                        lCodeTranslation.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4");
                    end;
                //BAT_REPLIC
                8003929:
                    if not lTree.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lTree);
                        lTree.Rename("To Key 1", "To Key 2");
                    end;
                8004020:
                    if not lInterim.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lInterim);
                        lInterim.Rename("To Key 1", "To Key 2");
                    end;
                8004031:
                    if not "lRes/ResourceGrp".Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable("lRes/ResourceGrp");
                        "lRes/ResourceGrp".Rename("To Key 1", "To Key 2");
                    end;
                8004070:
                    if not lStructComponent.Get("To Key 1", "To Key 2") then begin
                        pFromRecRef.SetTable(lStructComponent);
                        lStructComponent.Rename("To Key 1", "To Key 2");
                    end;
                8004075:
                    if lDescLine.Get("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5", "To Key 6") then begin
                        pFromRecRef.SetTable(lDescLine);
                        lDescLine.Rename("To Key 1", "To Key 2", "To Key 3", "To Key 4", "To Key 5", "To Key 6");
                    end;
                //BAT_REPLIC//
                8004092:
                    if not lVendorItemCatGrp.Get("To Key 1", "To Key 2", "To Key 3") then begin
                        pFromRecRef.SetTable(lVendorItemCatGrp);
                        lVendorItemCatGrp.Rename("To Key 1", "To Key 2", "To Key 3");
                    end;
                else
                    Error('Not implemented');
            end;
        end;
    end;
}

