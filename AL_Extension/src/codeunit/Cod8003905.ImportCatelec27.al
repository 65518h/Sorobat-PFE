Codeunit 8003905 "Import Catelec 27"
{
    // //IMPORT_CUSTOM CW 21/07/03 Import customize
    //                 CW 07/05/04 Update PurchasePrice via PurchaseLineDiscount /ItemDiscGroup /VendorDiscGroup
    //                               "Standard cost" = Best UnitCost for higher Vendor."Import Priority"
    // //+REF+REPLIC AC 29/06/05 Modification apporté pour répondre à la problématique de la réplication

    TableNo = Item;
    /*GL2024
        trigger OnRun()
        var
            lTree: Record 8003929;
            lItemCategory: Record 5722;
            //GL2024   lProductGroup: Record "Product Group";
            lItemUnit: Record 5404;
            lUOM: Record 204;
            lJaugeMax: BigInteger;
            lJauge: BigInteger;
            lWindow: Dialog;
            lDeleted: Integer;
            lBlocked: Integer;
            TextUOM: label 'Unit of measure added.';
        begin
            SingleInstance.Get(ImportLog);
            StartDate := Dt2Date(ImportLog."Start DateTime");

            //GL2024  case SingleInstance.ImportLog.PreImport;

            //  ImportLog.BeforeUpdatebegin
            REC."Last Date Modified" := StartDate; // En vue suppression
            REC."Shelf No." := 'CATELEC';
            REC."Tree Code" := CopyStr(REC."No.", 1, 3) + ' ' + DelChr(REC."Item Category Code");
            REC."Item Category Code" := CopyStr(REC."No.", 1, 3) + REC."Item Category Code";

            REC."Item Disc. Group" := CopyStr(REC."No.", 1, 3) + REC."Item Disc. Group";

            if not lUOM.Get(REC."Base Unit of Measure") then begin
                lUOM.Init;
                lUOM.Code := REC."Base Unit of Measure";
                lUOM.Description := REC."Base Unit of Measure";
                lUOM.Insert;
                ImportLog.Add(ImportLog."Import Line No.", REC."Base Unit of Measure", TextUOM);
            end;

            lItemUnit."Item No." := REC."No.";
            lItemUnit.Code := REC."Base Unit of Measure";
            lItemUnit."Qty. per Unit of Measure" := 1;
            if lItemUnit.Insert then;

            REC.Validate("Base Unit of Measure");
            if REC.Insert then;
            REC.Validate("Standard Cost", FindStandardCost(Rec));


            //  ImportLog.PostImportbegin // Suppression des articles ne figurant plus au fichier
            REC.Reset;
            REC.SetRange("Last Date Modified", 0D, StartDate - 1);
            REC.SetRange("Shelf No.", 'CATELEC');
            REC.SetRange(Blocked, false);
            //+REF+REPLIC
            REC.SetRange(Replication, false);
            //+REF+REPLIC//
            lJaugeMax := COUNTAPPROX;
            lWindow.Open(tDeleteExpired + '\@1@@@@@@@@@@@@@@@@@@');
            if REC.Find('-') then
                repeat
                    lJauge += 1;
                    lWindow.Update(1, (lJauge * 10000) DIV lJaugeMax);
                    if NoEntry(Rec) then begin
                        REC.Delete(true);
                        lDeleted += 1
                    end else begin
                        lBlocked += 1;
                        REC.Blocked := true;
                        REC.Modify;
                    end;
                until REC.Next = 0;

            lWindow.Close;
            Message(tDeleted, lDeleted, lBlocked);
        end;

             else
              end;
          end;
    */
    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
        tDeleteExpired: label 'Delete Expired Data';
        tDeleted: label '%1 item deleted, %2 blocked';
        StartDate: Date;


    procedure NoEntry(var pItem: Record Item): Boolean
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemJnlLine: Record "Item Journal Line";
        PurchOrderLine: Record "Purchase Line";
        SalesOrderLine: Record "Sales Line";
        lStructure: Record "Structure Component";
    begin
        ItemLedgerEntry.SetCurrentkey("Item No.");
        ItemLedgerEntry.SetRange("Item No.", pItem."No.");
        if not ItemLedgerEntry.IsEmpty then
            exit(false);

        ItemJnlLine.SetRange("Item No.", pItem."No.");
        if not ItemJnlLine.IsEmpty then
            exit(false);

        PurchOrderLine.SetCurrentkey(Type, "No.");
        PurchOrderLine.SetRange(Type, PurchOrderLine.Type::Item);
        PurchOrderLine.SetRange("No.", pItem."No.");
        if not PurchOrderLine.IsEmpty then
            exit(false);

        SalesOrderLine.SetCurrentkey(Type, "No.");
        SalesOrderLine.SetRange(Type, SalesOrderLine.Type::Item);
        SalesOrderLine.SetRange("No.", pItem."No.");
        if not SalesOrderLine.IsEmpty then
            exit(false);

        lStructure.SetCurrentkey(Type, "No.");
        lStructure.SetRange(Type, lStructure.Type::Item);
        lStructure.SetRange("No.", pItem."No.");
        if not lStructure.IsEmpty then
            exit(false);

        exit(true);
    end;


    procedure FindStandardCost(pItem: Record Item): Decimal
    var
        lPurchasePrice: Record "Purchase Price";
        lPurchaseLineDiscount: Record "Purchase Line Discount";
        lVendor: Record Vendor;
        lHigherPriority: Integer;
        lUnitCost: Decimal;
        lBestUnitCost: Decimal;
    begin
        lHigherPriority := 0;
        lVendor.SetCurrentkey("Import Priority");
        lVendor.SetFilter("Import Priority", '<>0');
        if lVendor.Find('-') then
            repeat
                lPurchaseLineDiscount.SetRange(Type, lPurchaseLineDiscount.Type::"Item Disc. Group");
                //GL2024   lPurchaseLineDiscount.SetRange(Code, pItem."Item Disc. Group");
                lPurchaseLineDiscount.SetRange("Item No.", pItem."Item Disc. Group");
                lPurchaseLineDiscount.SetRange("Purchase Type", lPurchaseLineDiscount."purchase type"::"Vendor Disc. Group");
                //GL2024  lPurchaseLineDiscount.SetRange("Purchase Code", lVendor."Vendor Disc. Group");
                lPurchaseLineDiscount.SetRange("Vendor No.", lVendor."Vendor Disc. Group");
                lPurchaseLineDiscount.SetRange("Starting Date", 0D, WorkDate);
                lPurchaseLineDiscount.SetFilter("Ending Date", '%1|>=%2', 0D, WorkDate);
                if lPurchaseLineDiscount.Find('-') then begin
                    lUnitCost := PurchasePriceUpdate(pItem."No.", lVendor."No.", pItem."Public Price", lPurchaseLineDiscount);
                    if lVendor."Import Priority" > lHigherPriority then begin
                        lHigherPriority := lVendor."Import Priority";
                        lBestUnitCost := lUnitCost;
                    end else
                        if lVendor."Import Priority" = lHigherPriority then
                            if (lUnitCost < lBestUnitCost) or (lBestUnitCost = 0) then
                                lBestUnitCost := lUnitCost;
                end;
            until lVendor.Next = 0;
        exit(lBestUnitCost);
    end;


    procedure PurchasePriceUpdate(pItemNo: Code[20]; pVendorNo: Code[20]; pPublicPrice: Decimal; pPurchaseLineDiscount: Record "Purchase Line Discount"): Decimal
    begin
        exit(ROUND(pPublicPrice * (100 - pPurchaseLineDiscount."Line Discount %") / 100, 0.01));
    end;
}

