Codeunit 8001404 "Import Specification"
{
    // //+REF+IMPORT CW 21/07/03 Import
    // //NAVIBAT GESWAY 18/08/06 Ajout job indicator


    trigger OnRun()
    begin
    end;

    var
        tIncorrectRecordID: label 'Record ID %1 not define';
        tIncorrectFieldID: label 'Field ID %1 not define';
        CustomerPriceGroup: Record "Customer Price Group";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Item: Record Item;
        ItemTranslation: Record "Item Translation";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlLine: Record "Gen. Journal Line";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        BOMComponent: Record "BOM Component";
        ItemVendor: Record "Item Vendor";
        Resource: Record Resource;
        Job: Record Job;
        UnitOfMeasure: Record "Unit of Measure";
        JobJnlLine: Record "Job Journal Line";
        JobBudgetEntry: Record "Job Planning Line";
        ShipToAddress: Record "Ship-to Address";
        OrderAddress: Record "Order Address";
        PostCode: Record "Post Code";
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
        CustomerBankAccount: Record "Customer Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
        CustomerDiscountGroup: Record "Customer Discount Group";
        ItemDiscountGroup: Record "Item Discount Group";
        Contact: Record Contact;
        IndustryGroup: Record "Industry Group";
        Employee: Record Employee;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        FixedAsset: Record "Fixed Asset";
        DepreciationBook: Record "Depreciation Book";
        NonstockItem: Record "Nonstock Item";
        Manufacturer: Record Manufacturer;
        ItemCategory: Record "Item Category";
        //GL2024  ProductGroup: Record "Product Group";
        tFormUndefine: label 'No form defined for TableID %1';
        SalesPrice: Record "Sales Price";
        SalesLineDiscount: Record "Sales Line Discount";
        PurchasePrice: Record "Purchase Price";
        PurchaseLineDiscount: Record "Purchase Line Discount";
        ImportCorrespondence: Record "Import Correspondence";
        UserExit: Integer;
        wRec8003946: Record "Job Indicator";


    procedure "Record"(var pRecord: RecordRef; pCodeunitID: Integer): Text[250]
    begin
        case pRecord.Number of
            Database::"Customer Price Group":
                begin // 6
                    pRecord.SetTable(CustomerPriceGroup);
                    Codeunit.Run(pCodeunitID, CustomerPriceGroup);
                    pRecord.GetTable(CustomerPriceGroup);
                end;
            Database::"G/L Account":
                begin // 17
                    pRecord.SetTable(GLAccount);
                    Codeunit.Run(pCodeunitID, GLAccount);
                    pRecord.GetTable(GLAccount);
                end;
            Database::Customer:
                begin // 18
                    pRecord.SetTable(Customer);
                    Codeunit.Run(pCodeunitID, Customer);
                    pRecord.GetTable(Customer);
                end;
            Database::Vendor:
                begin // 23
                    pRecord.SetTable(Vendor);
                    Codeunit.Run(pCodeunitID, Vendor);
                    pRecord.GetTable(Vendor);
                end;
            Database::Item:
                begin // 27
                    pRecord.SetTable(Item);
                    Codeunit.Run(pCodeunitID, Item);
                    pRecord.GetTable(Item);
                end;
            Database::"Item Translation":
                begin // 30
                    pRecord.SetTable(ItemTranslation);
                    Codeunit.Run(pCodeunitID, ItemTranslation);
                    pRecord.GetTable(ItemTranslation);
                end;
            Database::"Gen. Journal Line":
                begin // 81
                    pRecord.SetTable(GenJnlLine);
                    Codeunit.Run(pCodeunitID, GenJnlLine);
                    pRecord.GetTable(GenJnlLine);
                end;
            Database::"Item Journal Line":
                begin // 83
                    pRecord.SetTable(ItemJnlLine);
                    Codeunit.Run(pCodeunitID, ItemJnlLine);
                    pRecord.GetTable(ItemJnlLine);
                end;
            Database::"BOM Component":
                begin // 90
                    pRecord.SetTable(BOMComponent);
                    Codeunit.Run(pCodeunitID, BOMComponent);
                    pRecord.GetTable(BOMComponent);
                end;
            Database::"Item Vendor":
                begin // 99
                    pRecord.SetTable(ItemVendor);
                    Codeunit.Run(pCodeunitID, ItemVendor);
                    pRecord.GetTable(ItemVendor);
                end;
            Database::Resource:
                begin // 156
                    pRecord.SetTable(Resource);
                    Codeunit.Run(pCodeunitID, Resource);
                    pRecord.GetTable(Resource);
                end;
            Database::Job:
                begin // 167
                    pRecord.SetTable(Job);
                    Codeunit.Run(pCodeunitID, Job);
                    pRecord.GetTable(Job);
                end;
            Database::"Unit of Measure":
                begin // 204
                    pRecord.SetTable(UnitOfMeasure);
                    Codeunit.Run(pCodeunitID, UnitOfMeasure);
                    pRecord.GetTable(UnitOfMeasure);
                end;
            Database::"Job Journal Line":
                begin // 210
                    pRecord.SetTable(JobJnlLine);
                    Codeunit.Run(pCodeunitID, JobJnlLine);
                    pRecord.GetTable(JobJnlLine);
                end;
            /*GL2024 Database::"Job Budget Entry":
                 begin // 211
                     pRecord.SetTable(JobBudgetEntry);
                     Codeunit.Run(pCodeunitID, JobBudgetEntry);
                     pRecord.GetTable(JobBudgetEntry);
                 end;*/
            Database::"Ship-to Address":
                begin // 222
                    pRecord.SetTable(ShipToAddress);
                    Codeunit.Run(pCodeunitID, ShipToAddress);
                    pRecord.GetTable(ShipToAddress);
                end;
            Database::"Order Address":
                begin // 224
                    pRecord.SetTable(OrderAddress);
                    Codeunit.Run(pCodeunitID, OrderAddress);
                    pRecord.GetTable(OrderAddress);
                end;
            Database::"Post Code":
                begin // 224
                    pRecord.SetTable(PostCode);
                    Codeunit.Run(pCodeunitID, PostCode);
                    pRecord.GetTable(PostCode);
                end;
            Database::"Gen. Product Posting Group":
                begin // 279
                    pRecord.SetTable(GenProductPostingGroup);
                    Codeunit.Run(pCodeunitID, GenProductPostingGroup);
                    pRecord.GetTable(GenProductPostingGroup);
                end;
            Database::"Extended Text Header":
                begin // 279
                    pRecord.SetTable(ExtendedTextHeader);
                    Codeunit.Run(pCodeunitID, ExtendedTextHeader);
                    pRecord.GetTable(ExtendedTextHeader);
                end;
            Database::"Extended Text Line":
                begin // 280
                    pRecord.SetTable(ExtendedTextLine);
                    Codeunit.Run(pCodeunitID, ExtendedTextLine);
                    pRecord.GetTable(ExtendedTextLine);
                end;
            Database::"Customer Bank Account":
                begin // 287
                    pRecord.SetTable(CustomerBankAccount);
                    Codeunit.Run(pCodeunitID, CustomerBankAccount);
                    pRecord.GetTable(CustomerBankAccount);
                end;
            Database::"Vendor Bank Account":
                begin // 288
                    pRecord.SetTable(VendorBankAccount);
                    Codeunit.Run(pCodeunitID, VendorBankAccount);
                    pRecord.GetTable(VendorBankAccount);
                end;
            Database::"Customer Discount Group":
                begin // 340
                    pRecord.SetTable(CustomerDiscountGroup);
                    Codeunit.Run(pCodeunitID, CustomerDiscountGroup);
                    pRecord.GetTable(CustomerDiscountGroup);
                end;
            Database::"Item Discount Group":
                begin // 341
                    pRecord.SetTable(ItemDiscountGroup);
                    Codeunit.Run(pCodeunitID, ItemDiscountGroup);
                    pRecord.GetTable(ItemDiscountGroup);
                end;
            Database::Contact:
                begin // 5050
                    pRecord.SetTable(Contact);
                    Codeunit.Run(pCodeunitID, Contact);
                    pRecord.GetTable(Contact);
                end;
            Database::Employee:
                begin // 5200
                    pRecord.SetTable(Employee);
                    Codeunit.Run(pCodeunitID, Employee);
                    pRecord.GetTable(Employee);
                end;
            Database::"Item Unit of Measure":
                begin // 5404
                    pRecord.SetTable(ItemUnitOfMeasure);
                    Codeunit.Run(pCodeunitID, ItemUnitOfMeasure);
                    pRecord.GetTable(ItemUnitOfMeasure);
                end;
            Database::"Fixed Asset":
                begin // 5600
                    pRecord.SetTable(FixedAsset);
                    Codeunit.Run(pCodeunitID, FixedAsset);
                    pRecord.GetTable(FixedAsset);
                end;
            Database::"Depreciation Book":
                begin // 5612
                    pRecord.SetTable(DepreciationBook);
                    Codeunit.Run(pCodeunitID, DepreciationBook);
                    pRecord.GetTable(DepreciationBook);
                end;
            Database::"Nonstock Item":
                begin // 5718
                    pRecord.SetTable(NonstockItem);
                    Codeunit.Run(pCodeunitID, NonstockItem);
                    pRecord.GetTable(NonstockItem);
                end;
            Database::Manufacturer:
                begin // 5720
                    pRecord.SetTable(Manufacturer);
                    Codeunit.Run(pCodeunitID, Manufacturer);
                    pRecord.GetTable(Manufacturer);
                end;
            Database::"Item Category":
                begin // 5722
                    pRecord.SetTable(ItemCategory);
                    Codeunit.Run(pCodeunitID, ItemCategory);
                    pRecord.GetTable(ItemCategory);
                end;
            /*GL2024   Database::"Product Group":
                   begin // 5723
                       pRecord.SetTable(ProductGroup);
                       Codeunit.Run(pCodeunitID, ProductGroup);
                       pRecord.GetTable(ProductGroup);
                   end;*/
            Database::"Sales Price":
                begin // 7002
                    pRecord.SetTable(SalesPrice);
                    Codeunit.Run(pCodeunitID, SalesPrice);
                    pRecord.GetTable(SalesPrice);
                end;
            Database::"Sales Line Discount":
                begin // 7004
                    pRecord.SetTable(SalesLineDiscount);
                    Codeunit.Run(pCodeunitID, SalesLineDiscount);
                    pRecord.GetTable(SalesLineDiscount);
                end;
            Database::"Purchase Price":
                begin // 7012
                    pRecord.SetTable(PurchasePrice);
                    Codeunit.Run(pCodeunitID, PurchasePrice);
                    pRecord.GetTable(PurchasePrice);
                end;
            Database::"Purchase Line Discount":
                begin // 7014
                    pRecord.SetTable(PurchaseLineDiscount);
                    Codeunit.Run(pCodeunitID, PurchaseLineDiscount);
                    pRecord.GetTable(PurchaseLineDiscount);
                end;
            Database::"Import Correspondence":
                begin // 8001423
                    pRecord.SetTable(ImportCorrespondence);
                    Codeunit.Run(pCodeunitID, ImportCorrespondence);
                    pRecord.GetTable(ImportCorrespondence);
                end;
            //NAVIBAT
            Database::"Job Indicator":
                begin // 8003946
                    pRecord.SetTable(wRec8003946);
                    Codeunit.Run(pCodeunitID, wRec8003946);
                    pRecord.GetTable(wRec8003946);
                end;
            //NAVIBAT//
            else
                Error(tFormUndefine, pRecord.Number);
        end;
    end;


    procedure "Field"(var pFieldRef: FieldRef; pID: Integer): Text[250]
    var
        lText: Text[250];
    begin
        case pID of
            0:
                ;
            1:
                begin
                    lText := pFieldRef.Value;
                    pFieldRef.Value := DelChr(lText);
                end;
            else
                Error(tIncorrectFieldID, pFieldRef.Number, pID);
        end;
    end;


    procedure ShowCard(pTableID: Integer; pCode: Code[20])
    begin
        case pTableID of
            Database::"Customer Price Group":
                begin
                    if CustomerPriceGroup.Get(pCode) then;
                    Page.RunModal(Page::"Customer Price Groups", CustomerPriceGroup);
                end;
            Database::"G/L Account":
                begin
                    if GLAccount.Get(pCode) then;
                    Page.RunModal(Page::"G/L Account Card", GLAccount);
                end;
            Database::Customer,
            Database::"Ship-to Address",
            Database::"Customer Bank Account":
                begin
                    if Customer.Get(pCode) then;
                    Page.RunModal(Page::"Customer Card", Customer);
                end;
            Database::Vendor,
            Database::"Order Address",
            Database::"Vendor Bank Account":
                begin
                    if Vendor.Get(pCode) then;
                    Page.RunModal(Page::"Vendor Card", Vendor);
                end;
            Database::Item,
            Database::"Item Translation",
            Database::"BOM Component",
            Database::"Item Vendor",
            Database::"Item Unit of Measure",
            Database::"Sales Price",
            Database::"Purchase Price":
                begin
                    if Item.Get(pCode) then;
                    Page.RunModal(Page::"Item Card", Item);
                end;
            Database::"Gen. Journal Line":
                if GenJnlTemplate.Get(pCode) then begin
                    GenJnlLine.SetRange("Journal Template Name", pCode);
                    PAGE.Run(GenJnlTemplate."Page ID", GenJnlLine);
                end;
            Database::"Item Journal Line":
                if ItemJnlTemplate.Get(pCode) then begin
                    ItemJnlLine.SetRange("Journal Template Name", pCode);
                    PAGE.Run(ItemJnlTemplate."Page ID", ItemJnlLine);
                end;
            Database::Resource:
                begin
                    if Resource.Get(pCode) then;
                    Page.RunModal(Page::"Resource Card", Resource);
                end;
            Database::Job:
                begin
                    if Job.Get(pCode) then;
                    Page.RunModal(Page::"Job Card", Job);
                end;
            Database::"Unit of Measure":
                begin
                    if UnitOfMeasure.Get(pCode) then;
                    Page.RunModal(Page::"Unit of Measure Translation", UnitOfMeasure);
                end;
            Database::"Post Code":
                begin
                    if PostCode.Get(pCode) then;
                    Page.RunModal(Page::"Post Codes", PostCode);
                end;
            Database::Contact:
                begin
                    if Contact.Get(pCode) then;
                    Page.RunModal(Page::"Contact Card", Contact);
                end;
            Database::Employee:
                begin
                    if Employee.Get(pCode) then;
                    Page.RunModal(Page::"Employee Card", Employee);
                end;
            Database::"Fixed Asset",
            Database::"Depreciation Book":
                begin
                    if FixedAsset.Get(pCode) then;
                    Page.RunModal(Page::"Fixed Asset Card", FixedAsset);
                end;
            /* //GL2024  Database::"Nonstock Item":
                  begin
                      if NonstockItem.Get(pCode) then;
                      Page.RunModal(Page::"Nonstock Item Card", NonstockItem);
                  end;*/
            Database::Manufacturer:
                begin
                    if Manufacturer.Get(pCode) then;
                    Page.RunModal(Page::Manufacturers, Manufacturer);
                end;

            Database::"Item Category":
                begin
                    if ItemCategory.Get(pCode) then;
                    Page.RunModal(Page::"Item Categories", ItemCategory);
                end;
            /*GL2024  Database::"Product Group":
                  begin
                      if ProductGroup.Get(pCode) then;
                      Page.RunModal(Page::"Product Groups", ProductGroup);
                  end;*/
            Database::"Sales Line Discount":
                begin
                    if SalesLineDiscount.Get(pCode) then;
                    Page.RunModal(Page::"Sales Line Discounts", SalesLineDiscount);
                end;
            Database::"Purchase Line Discount":
                begin
                    if PurchaseLineDiscount.Get(pCode) then;
                    Page.RunModal(Page::"Purchase Line Discounts", PurchaseLineDiscount);
                end;
            /*   //GL2024 NAVIBAT  Database::"Import Correspondence":
                   begin
                       if ImportCorrespondence.Get(pCode) then;
                       Page.RunModal(Page::"Import Correspondences", ImportCorrespondence);
                   end;*/
            else
                Error(tFormUndefine, pTableID);
        end;
    end;


    procedure ShowList(pTableID: Integer)
    begin
        case pTableID of
            Database::"Customer Price Group":
                Page.RunModal(0, CustomerPriceGroup);
            Database::"G/L Account":
                Page.RunModal(0, GLAccount);
            Database::Customer:
                Page.RunModal(0, Customer);
            Database::Vendor:
                Page.RunModal(0, Vendor);
            Database::Item:
                Page.RunModal(0, Item);
            Database::"Gen. Journal Line":
                Error(tFormUndefine, pTableID);
            Database::"Item Journal Line":
                Error(tFormUndefine, pTableID);
            Database::"BOM Component":
                Page.RunModal(0, BOMComponent);
            Database::"Item Vendor":
                Page.RunModal(0, ItemVendor);
            Database::Resource:
                Page.RunModal(0, Resource);
            Database::Job:
                Page.RunModal(0, Job);
            Database::"Gen. Product Posting Group":
                Page.RunModal(0, GenProductPostingGroup);
            Database::"Unit of Measure":
                Page.RunModal(0, UnitOfMeasure);
            Database::"Ship-to Address":
                Page.RunModal(0, ShipToAddress);
            Database::"Order Address":
                Page.RunModal(0, OrderAddress);
            Database::"Post Code":
                Page.RunModal(0, PostCode);
            Database::"Extended Text Header":
                Error(tFormUndefine, pTableID);
            Database::"Extended Text Line":
                Error(tFormUndefine, pTableID);
            Database::"Customer Bank Account":
                Page.RunModal(0, CustomerBankAccount);
            Database::"Vendor Bank Account":
                Page.RunModal(0, VendorBankAccount);
            Database::Contact:
                Page.RunModal(0, Contact);
            Database::"Industry Group":
                Page.RunModal(0, IndustryGroup);
            Database::Employee:
                Page.RunModal(0, Employee);
            Database::"Item Unit of Measure":
                Page.RunModal(0, ItemUnitOfMeasure);
            Database::"Fixed Asset":
                Page.RunModal(0, FixedAsset);
            Database::"Depreciation Book":
                Page.RunModal(0, DepreciationBook);
            Database::"Nonstock Item":
                Page.RunModal(0, NonstockItem);
            Database::Manufacturer:
                Page.RunModal(0, Manufacturer);
            Database::"Item Category":
                Page.RunModal(0, ItemCategory);
            /* GL2024  Database::"Product Group":
                   Page.RunModal(0, ProductGroup);*/
            Database::"Sales Price":
                Page.RunModal(0, SalesPrice);
            Database::"Sales Line Discount":
                Page.RunModal(0, SalesLineDiscount);
            Database::"Purchase Price":
                Page.RunModal(0, PurchasePrice);
            Database::"Purchase Line Discount":
                Page.RunModal(0, PurchaseLineDiscount);
            Database::"Import Correspondence":
                Page.RunModal(0, ImportCorrespondence);
            else
                Error(tFormUndefine, pTableID);
        end;
    end;
}

