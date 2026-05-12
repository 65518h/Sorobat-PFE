
xmlport 50009 "RecupImageChantier"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = '#';
    RecordSeparator = '<NewLine>';
    UseRequestPage = false;
    Caption = 'Recup Image Chantier';
    TableSeparator = '<NewLine><NewLine>';

    TextEncoding = UTF8;









    schema
    {
        textelement(Root)
        {

            tableelement(PurchaseLine1; "Purchase Line")
            {
                AutoSave = false;
                AutoUpdate = false;

                textelement(DocumentType) { }
                textelement(DocumentNo3) { }
                textelement(LineNo3) { }
                textelement(OutstandingQuantity) { }





                textelement("QuantityReceived") { }

                textelement("OutstandingQtyBase") { }

                textelement("QtyReceivedBase") { }

                textelement("CompletelyReceived") { }

                textelement("OriginalQuantity") { }

                textelement("QtytoReceive") { }


                textelement("QtytoReceiveBase") { }





                trigger OnBeforeInsertRecord()
                var

                    "Quantity Received1": Decimal;
                    "LineNo1": Integer;
                    "Quantity1": Decimal;
                    DocumentType1: Enum "Purchase Document Type";
                begin
                    Evaluate(LineNo1, LineNo3);
                    Evaluate("Quantity Received1", QuantityReceived);
                    Evaluate("DocumentType1", DocumentType);



                    IF PurchaseLine1.GET(DocumentType1, DocumentNo3, LineNo1) THEN
                        IF (PurchaseLine1."Quantity Received" = "Quantity Received1") OR
                           (PurchaseLine1."Quantity Received" > "Quantity Received1") THEN
                            currXMLport.SKIP
                        ELSE BEGIN
                            PurchaseLine1."Qty. Rcd. Not Invoiced" := PurchaseLine1."Qty. Rcd. Not Invoiced" +
                                                                    "Quantity Received1" - PurchaseLine1."Quantity Received";

                            PurchaseLine1."Qty. Rcd. Not Invoiced (Base)" := PurchaseLine1."Qty. Rcd. Not Invoiced";
                            PurchaseLine1.MODIFY;
                        END;

                end;
            }


            // // // Table 120 - Purch. Rcpt. Header

            tableelement(PurchRcptHeader; "Purch. Rcpt. Header")
            {
                // AutoSave = false;
                // AutoUpdate = false;




                textelement(BuyFromVendorNo4) { }
                textelement(No4) { }
                textelement(PayToVendorNo4) { }
                textelement(PayToName) { }
                textelement(PayToName2) { }
                textelement(PayToAddress) { }
                textelement(PayToAddress2) { }
                textelement(PayToCity) { }
                textelement(PayToContact) { }
                textelement(YourReference) { }
                textelement(ShipToCode) { }
                textelement(ShipToName) { }
                textelement(ShipToName2) { }
                textelement(ShipToAddress) { }
                textelement(ShipToAddress2) { }
                textelement(ShipToCity) { }
                textelement(ShipToContact) { }
                textelement(OrderDate4) { }
                textelement(PostingDate4) { }
                textelement(ExpectedReceiptDate4) { }
                textelement(PostingDescription) { }
                textelement(PaymentTermsCode) { }
                textelement(DueDate) { }
                textelement(PaymentDiscountPercent) { }
                textelement(PmtDiscountDate) { }
                textelement(ShipmentMethodCode) { }
                textelement(LocationCode4) { }
                textelement(ShortcutDim14) { }
                textelement(ShortcutDim24) { }
                textelement(VendorPostingGroup) { }
                textelement(CurrencyCode4) { }
                textelement(CurrencyFactor) { }
                textelement(InvoiceDiscCode) { }
                textelement(LanguageCode) { }
                textelement(PurchaserCode) { }
                textelement(OrderNo4) { }
                textelement(Comment) { }
                textelement(NoPrinted) { }
                textelement(OnHold) { }
                textelement(AppliesToDocType) { }
                textelement(AppliesToDocNo) { }
                textelement(BalAccountNo) { }
                textelement(VendorOrderNo) { }
                textelement(VendorShipmentNo) { }
                textelement(VATRegistrationNo) { }
                textelement(SellToCustomerNo) { }
                textelement(ReasonCode) { }
                textelement(GenBusPostingGroup4) { }
                textelement(TransactionType4) { }
                textelement(TransportMethod4) { }
                textelement(VATCountryRegionCode) { }
                textelement(BuyFromVendorName) { }
                textelement(BuyFromVendorName2) { }
                textelement(BuyFromAddress) { }
                textelement(BuyFromAddress2) { }
                textelement(BuyFromCity) { }
                textelement(BuyFromContact) { }
                textelement(PayToPostCode) { }
                textelement(PayToCounty) { }
                textelement(PayToCountryRegionCode) { }
                textelement(BuyFromPostCode) { }
                textelement(BuyFromCounty) { }
                textelement(BuyFromCountryRegionCode) { }
                textelement(ShipToPostCode) { }
                textelement(ShipToCounty) { }





                textelement(ShipToCountryRegionCode) { }
                textelement("BalAccountType") { }
                textelement("OrderAddressCode") { }

                textelement("EntryPoint4") { }
                textelement(Correction4) { }
                textelement("DocumentDate4") { }
                textelement(Area4) { }
                textelement("TransactionSpecification4") { }


                textelement("PaymentMethodCode") { }
                textelement("NoSeries") { }
                textelement("OrderNoSeries") { }
                textelement("UserID") { }
                textelement("SourceCode") { }
                textelement("TaxAreaCode4") { }
                textelement("TaxLiable4") { }
                textelement("VATBusPostingGroup4") { }
                textelement("VATBaseDiscount4") { }
                textelement("QuoteNo") { }
                textelement("CampaignNo4") { }
                textelement("BuyfromContactNo") { }
                textelement("PaytoContactNo") { }
                textelement("ResponsibilityCenter4") { }
                textelement("RequestedReceiptDate4") { }
                textelement("PromisedReceiptDate4") { }
                textelement("LeadTimeCalculation4") { }
                textelement("InboundWhseHandlingTime4") { }
                textelement("NDossier") { }
                textelement("DateDossier") { }
                textelement("NDemandedachat") { }
                textelement("DateDA") { }
                textelement("NumSequenceSyncro4") { }
                textelement("Synchronise4") { }
                textelement("MaskCode4") { }
                textelement("JobNo4") { }
                textelement("DateReceived4") { }
                textelement("TimeReceived") { }
                textelement("BizTalkPurchaseReceipt") { }
                trigger OnBeforeInsertRecord()
                var
                    OrderDateTest: date;
                    PostingDateTest: date;
                    ExpectedReceiptDateTest: date;
                    DueDateTest: date;
                    PaymentDiscountPercenttest: Decimal;
                    PmtDiscountDatetest: date;
                    CurrencyFactortest: Decimal;
                    Commenttest: Boolean;
                    NoPrintedtest: Integer;
                    AppliesToDocTypetest: Enum "Gen. Journal Document Type";
                    BalAccountTypetest: Enum "Payment Balance Account Type";
                    BalAccountTypetest3: Option "Général","Banque";
                    Correction4test: Boolean;
                    DocumentDate4test: date;
                    TaxLiable4test: Boolean;
                    VATBaseDiscount4test: Decimal;
                    RequestedReceiptDate4test: date;
                    PromisedReceiptDate4test: date;
                    LeadTimeCalculation4test: DateFormula;
                    InboundWhseHandlingTime4test: DateFormula;
                    DateDossiertest: date;
                    DateDAtest: date;
                    NumSequenceSyncro4test: Integer;
                    Synchronise4test: Boolean;
                    DateReceived4test: date;
                    TimeReceivedtest: Time;
                    BizTalkPurchaseReceipttest: Boolean;
                begin
                    Evaluate(OrderDateTest, OrderDate4);
                    Evaluate(PostingDateTest, PostingDate4);
                    Evaluate(ExpectedReceiptDateTest, ExpectedReceiptDate4);
                    Evaluate(DueDateTest, DueDate);
                    Evaluate(PaymentDiscountPercenttest, PaymentDiscountPercent);
                    Evaluate(PmtDiscountDatetest, PmtDiscountDate);
                    Evaluate(CurrencyFactortest, CurrencyFactor);
                    Evaluate(Commenttest, Comment);
                    Evaluate(NoPrintedtest, NoPrinted);
                    Evaluate(AppliesToDocTypetest, AppliesToDocType);
                    //GL2026 Evaluate(BalAccountTypetest, BalAccountType);
                    Evaluate(BalAccountTypetest3, BalAccountType);
                    Evaluate(Correction4test, Correction4);
                    Evaluate(DocumentDate4test, DocumentDate4);
                    Evaluate(TaxLiable4test, TaxLiable4);
                    Evaluate(VATBaseDiscount4test, VATBaseDiscount4);
                    Evaluate(RequestedReceiptDate4test, RequestedReceiptDate4);
                    Evaluate(PromisedReceiptDate4test, PromisedReceiptDate4);
                    Evaluate(LeadTimeCalculation4test, LeadTimeCalculation4);
                    Evaluate(InboundWhseHandlingTime4test, InboundWhseHandlingTime4);
                    Evaluate(DateDossiertest, DateDossier);
                    Evaluate(DateDAtest, DateDA);
                    Evaluate(NumSequenceSyncro4test, NumSequenceSyncro4);
                    Evaluate(Synchronise4test, Synchronise4);
                    Evaluate(DateReceived4test, DateReceived4);
                    Evaluate(TimeReceivedtest, TimeReceived);
                    Evaluate(BizTalkPurchaseReceipttest, BizTalkPurchaseReceipt);


                    IF RecPurchaseHeader.GET(No4) THEN currXMLport.SKIP;
                    PurchRcptHeader.Init();
                    Clear(PurchRcptHeader);
                    PurchRcptHeader.VALIDATE("Buy-from Vendor No.", BuyFromVendorNo4);
                    PurchRcptHeader.VALIDATE("No.", No4);
                    PurchRcptHeader.VALIDATE("Pay-to Vendor No.", PayToVendorNo4);
                    PurchRcptHeader."Pay-to Name" := PayToName;
                    PurchRcptHeader."Pay-to Name 2" := PayToName2;
                    PurchRcptHeader."Pay-to Address" := PayToAddress;
                    PurchRcptHeader."Pay-to Address 2" := PayToAddress2;
                    PurchRcptHeader."Pay-to City" := PayToCity;
                    PurchRcptHeader."Pay-to Contact" := PayToContact;
                    PurchRcptHeader."Your Reference" := YourReference;
                    PurchRcptHeader."Ship-to Code" := ShipToCode;
                    PurchRcptHeader."Ship-to Name" := ShipToName;
                    PurchRcptHeader."Ship-to Name 2" := ShipToName2;
                    PurchRcptHeader."Ship-to Address" := ShipToAddress;
                    PurchRcptHeader."Ship-to Address 2" := ShipToAddress2;
                    PurchRcptHeader."Ship-to City" := ShipToCity;
                    PurchRcptHeader."Ship-to Contact" := ShipToContact;
                    PurchRcptHeader."Order Date" := OrderDateTest;
                    PurchRcptHeader."Posting Date" := PostingDateTest;
                    PurchRcptHeader."Expected Receipt Date" := ExpectedReceiptDateTest;
                    PurchRcptHeader."Posting Description" := PostingDescription;
                    PurchRcptHeader."Payment Terms Code" := PaymentTermsCode;
                    PurchRcptHeader."Due Date" := DueDateTest;
                    PurchRcptHeader."Payment Discount %" := PaymentDiscountPercenttest;
                    PurchRcptHeader."Pmt. Discount Date" := PmtDiscountDatetest;
                    PurchRcptHeader."Shipment Method Code" := ShipmentMethodCode;
                    PurchRcptHeader."Location Code" := LocationCode4;
                    PurchRcptHeader."Shortcut Dimension 1 Code" := ShortcutDim14;
                    PurchRcptHeader."Shortcut Dimension 2 Code" := ShortcutDim24;
                    PurchRcptHeader."Vendor Posting Group" := VendorPostingGroup;
                    PurchRcptHeader."Currency Code" := CurrencyCode4;
                    PurchRcptHeader."Currency Factor" := CurrencyFactortest;
                    PurchRcptHeader."Invoice Disc. Code" := InvoiceDiscCode;
                    PurchRcptHeader."Language Code" := LanguageCode;
                    PurchRcptHeader."Purchaser Code" := PurchaserCode;
                    PurchRcptHeader."Order No." := OrderNo4;
                    PurchRcptHeader.Comment := Commenttest;
                    PurchRcptHeader."No. Printed" := NoPrintedtest;
                    PurchRcptHeader."On Hold" := OnHold;
                    PurchRcptHeader."Applies-to Doc. Type" := AppliesToDocTypetest;
                    PurchRcptHeader."Applies-to Doc. No." := AppliesToDocNo;
                    PurchRcptHeader."Bal. Account No." := BalAccountNo;
                    PurchRcptHeader."Vendor Order No." := VendorOrderNo;
                    PurchRcptHeader."Vendor Shipment No." := VendorShipmentNo;
                    PurchRcptHeader."VAT Registration No." := VATRegistrationNo;
                    PurchRcptHeader."Sell-to Customer No." := SellToCustomerNo;
                    PurchRcptHeader."Reason Code" := ReasonCode;
                    PurchRcptHeader."Gen. Bus. Posting Group" := GenBusPostingGroup4;
                    PurchRcptHeader."Transaction Type" := TransactionType4;
                    PurchRcptHeader."Transport Method" := TransportMethod4;
                    PurchRcptHeader."VAT Country/Region Code" := VATCountryRegionCode;
                    PurchRcptHeader."Buy-from Vendor Name" := BuyFromVendorName;
                    PurchRcptHeader."Buy-from Vendor Name 2" := BuyFromVendorName2;
                    PurchRcptHeader."Buy-from Address" := BuyFromAddress;
                    PurchRcptHeader."Buy-from Address 2" := BuyFromAddress2;
                    PurchRcptHeader."Buy-from City" := BuyFromCity;
                    PurchRcptHeader."Buy-from Contact" := BuyFromContact;
                    PurchRcptHeader."Pay-to Post Code" := PayToPostCode;
                    PurchRcptHeader."Pay-to County" := PayToCounty;
                    PurchRcptHeader."Pay-to Country/Region Code" := PayToCountryRegionCode;
                    PurchRcptHeader."Buy-from Post Code" := BuyFromPostCode;
                    PurchRcptHeader."Buy-from County" := BuyFromCounty;
                    PurchRcptHeader."Buy-from Country/Region Code" := BuyFromCountryRegionCode;
                    PurchRcptHeader."Ship-to Post Code" := ShipToPostCode;
                    PurchRcptHeader."Ship-to County" := ShipToCounty;
                    PurchRcptHeader."Ship-to Country/Region Code" := ShipToCountryRegionCode;
                    //GL2026  PurchRcptHeader."Bal. Account Type" := BalAccountTypetest;

                    IF BalAccountTypetest3 = BalAccountTypetest3::Banque then
                        PurchRcptHeader."Bal. Account Type" := PurchRcptHeader."Bal. Account Type"::"Bank Account"
                    else IF BalAccountTypetest3 = BalAccountTypetest3::"Général" then
                        PurchRcptHeader."Bal. Account Type" := PurchRcptHeader."Bal. Account Type"::"G/L Account";

                    PurchRcptHeader."Order Address Code" := OrderAddressCode;
                    PurchRcptHeader."Entry Point" := EntryPoint4;
                    PurchRcptHeader.Correction := Correction4test;
                    PurchRcptHeader."Document Date" := DocumentDate4test;
                    PurchRcptHeader.Area := Area4;
                    PurchRcptHeader."Transaction Specification" := TransactionSpecification4;
                    PurchRcptHeader."Payment Method Code" := PaymentMethodCode;
                    PurchRcptHeader."No. Series" := NoSeries;
                    PurchRcptHeader."Order No. Series" := OrderNoSeries;
                    PurchRcptHeader."User ID" := UserID;
                    PurchRcptHeader."Source Code" := SourceCode;
                    PurchRcptHeader."Tax Area Code" := TaxAreaCode4;
                    PurchRcptHeader."Tax Liable" := TaxLiable4test;
                    PurchRcptHeader."VAT Bus. Posting Group" := VATBusPostingGroup4;
                    PurchRcptHeader."VAT Base Discount %" := VATBaseDiscount4test;
                    PurchRcptHeader."Quote No." := QuoteNo;
                    PurchRcptHeader."Campaign No." := CampaignNo4;
                    PurchRcptHeader."Buy-from Contact No." := BuyFromContactNo;
                    PurchRcptHeader."Pay-to Contact No." := PayToContactNo;
                    PurchRcptHeader."Responsibility Center" := ResponsibilityCenter4;
                    PurchRcptHeader."Requested Receipt Date" := RequestedReceiptDate4test;
                    PurchRcptHeader."Promised Receipt Date" := PromisedReceiptDate4test;
                    PurchRcptHeader."Lead Time Calculation" := LeadTimeCalculation4test;
                    PurchRcptHeader."Inbound Whse. Handling Time" := InboundWhseHandlingTime4test;
                    PurchRcptHeader."N° Dossier" := NDossier;
                    PurchRcptHeader."Date Dossier" := DateDossiertest;
                    PurchRcptHeader."N° Demande d'achat" := NDemandedachat;
                    PurchRcptHeader."Date DA" := DateDAtest;
                    PurchRcptHeader."Num Sequence Syncro" := NumSequenceSyncro4test;
                    PurchRcptHeader.Synchronise := Synchronise4test;
                    PurchRcptHeader."Mask Code" := MaskCode4;
                    PurchRcptHeader."Job No." := JobNo4;
                    PurchRcptHeader."Date Received" := DateReceived4test;
                    PurchRcptHeader."Time Received" := TimeReceivedtest;
                    PurchRcptHeader."BizTalk Purchase Receipt" := BizTalkPurchaseReceipttest;




                end;


                trigger OnAfterInsertRecord()
                begin
                    //  PurchRcptHeader.INSERT(false);
                end;

                trigger OnPreXmlItem()
                begin
                    //   COMMIT;
                end;

            }


            // Table 121 - Purch. Rcpt. Line

            tableelement(PurchRcptLine; "Purch. Rcpt. Line")
            {






                textelement(BuyFromVendorNo) { }
                textelement(DocumentNo) { }
                textelement(LineNo) { }
                textelement(Type) { }
                textelement(No) { }
                textelement(LocationCode) { }
                textelement(PostingGroup) { }
                textelement(ExpectedReceiptDate) { }
                textelement(Description) { }
                textelement(Description22) { }
                textelement(UnitOfMeasure) { }
                textelement(Quantity) { }
                textelement(DirectUnitCost) { }
                textelement(UnitCostLCY) { }
                textelement(VATPercent) { }
                textelement(LineDiscountPercent) { }
                textelement(UnitPriceLCY) { }
                textelement(AllowInvoiceDisc) { }
                textelement(GrossWeight) { }
                textelement(NetWeight) { }
                textelement(UnitsPerParcel) { }
                textelement(UnitVolume) { }
                textelement(ApplToItemEntry) { }
                textelement(ItemRcptEntryNo) { }
                textelement(ShortcutDim1) { }
                textelement(ShortcutDim2) { }
                textelement(JobNo) { }
                textelement(IndirectCostPercent) { }
                textelement(QtyRcdNotInvoiced) { }
                textelement(QuantityInvoiced) { }
                textelement(OrderNo) { }
                textelement(OrderLineNo) { }
                textelement(PayToVendorNo) { }
                textelement(VendorItemNo) { }
                textelement(SalesOrderNo) { }
                textelement(SalesOrderLineNo) { }
                textelement(GenBusPostingGroup) { }
                textelement(GenProdPostingGroup) { }
                textelement(VATCalculationType) { }
                textelement(TransactionType) { }
                textelement(TransportMethod) { }
                textelement(AttachedToLineNo) { }
                textelement(EntryPoint) { }
                textelement(Area2) { }
                textelement(TransactionSpecification) { }
                textelement(TaxAreaCode) { }
                textelement(TaxLiable) { }
                textelement(TaxGroupCode) { }
                textelement(UseTax) { }
                textelement(VATBusPostingGroup) { }
                textelement(VATProdPostingGroup) { }
                textelement(CurrencyCode) { }
                textelement(BlanketOrderNo) { }
                textelement(BlanketOrderLineNo) { }
                textelement(VATBaseAmount) { }
                textelement(UnitCost) { }
                textelement(PostingDate) { }
                textelement(JobTaskNo) { }
                textelement(JobLineType) { }
                textelement(JobUnitPrice) { }
                textelement(JobTotalPrice) { }
                textelement(JobLineAmount) { }
                textelement(JobLineDiscountAmount) { }
                textelement(JobLineDiscountPercent) { }
                textelement(JobUnitPriceLCY) { }
                textelement(JobTotalPriceLCY) { }
                textelement(JobLineAmountLCY) { }
                textelement(JobLineDiscAmountLCY) { }
                textelement(JobCurrencyFactor) { }
                textelement(JobCurrencyCode) { }
                textelement(ProdOrderNo) { }
                textelement(VariantCode) { }
                textelement(BinCode) { }
                textelement(QtyPerUnitOfMeasure) { }
                textelement(UnitOfMeasureCode) { }
                textelement(QuantityBase) { }
                textelement(QtyInvoicedBase) { }
                textelement(FAPostingDate) { }
                textelement(FAPostingType) { }
                textelement(DepreciationBookCode) { }
                textelement(SalvageValue) { }
                textelement(DeprUntilFAPostingDate) { }
                textelement(DeprAcquisitionCost) { }
                textelement(MaintenanceCode) { }
                textelement(InsuranceNo) { }
                textelement(BudgetedFANo) { }
                textelement(DuplicateInDepreciationBook) { }
                textelement(UseDuplicationList) { }
                textelement(ResponsibilityCenter) { }
                textelement(CrossReferenceNo) { }
                textelement(UnitOfMeasureCrossRef) { }
                textelement(CrossReferenceType) { }
                textelement(CrossReferenceTypeNo) { }
                textelement(ItemCategoryCode) { }
                textelement(Nonstock) { }
                textelement(PurchasingCode) { }
                textelement(ProductGroupCode) { }
                textelement(SpecialOrderSalesNo) { }
                textelement(SpecialOrderSalesLineNo) { }
                textelement(RequestedReceiptDate) { }
                textelement(PromisedReceiptDate) { }
                textelement(LeadTimeCalculation) { }
                textelement(InboundWhseHandlingTime) { }
                textelement(PlannedReceiptDate) { }
                textelement(OrderDate) { }
                textelement(ItemChargeBaseAmount) { }
                textelement(Correction) { }
                textelement(ReturnReasonCode) { }
                textelement(Nossier) { }
                textelement(Synchronise) { }
                textelement(NumBLFournisseur) { }
                textelement(Materiel) { }
                textelement(NumSequenceSyncro) { }
                textelement(QtyNotInConformity) { }
                textelement(NotInConformityCode) { }
                textelement(RemainderQuantity) { }
                textelement(OrderLineAmount) { }
                textelement(NotInConformity) { }
                textelement(WorkTypeCode) { }
                textelement(ChargeToOrderNo) { }
                textelement(Value1) { }
                textelement(Value2) { }
                textelement(Value3) { }
                textelement(Value4) { }
                textelement(Value5) { }
                textelement(Value6) { }
                textelement(Value7) { }
                textelement(Value8) { }
                textelement(Value9) { }
                textelement(Value10) { }
                textelement(RoutingNo) { }
                textelement(OperationNo) { }
                textelement(WorkCenterNo) { }
                textelement(ProdOrderLineNo) { }
                textelement(OverheadRate) { }
                textelement(RoutingReferenceNo) { }





                trigger OnBeforeInsertRecord()

                var

                    LineNotest2: Integer;

                    Typetest2: enum "Purchase Line Type";

                    OrderDateTest: date;
                    PostingDateTest: date;
                    ExpectedReceiptDateTest2: date;
                    Quantitytest2: Decimal;
                    DueDateTest: date;


                    DirectUnitCosttest2: Decimal;
                    UnitCostLCYtest2: Decimal;
                    VATPercenttest2: Decimal;
                    LineDiscountPercenttest2: Decimal;
                    UnitPriceLCYtest2: Decimal;
                    AllowInvoiceDisctest2: Boolean;


                    GrossWeighttest2: Decimal;
                    NetWeighttest2: Decimal;
                    UnitsPerParceltest2: Decimal;
                    UnitVolumetest2: Decimal;
                    ApplToItemEntrytest2: Integer;
                    ItemRcptEntryNotest2: Integer;



                    IndirectCostPercenttest2: Decimal;
                    QtyRcdNotInvoicedtest2: Decimal;
                    QuantityInvoicedtest2: Decimal;
                    OrderLineNotest2: Integer;

                    SalesOrderLineNotest2: Integer;
                    VATCalculationTypetest2: Enum "Tax Calculation Type";
                    VATCalculationTypetest23: Option Normal,"Intracomm.",Correctif,"Sales Tax";
                    AttachedToLineNotest2: Integer;
                    TaxLiabletest2: Boolean;
                    UseTaxtest2: Boolean;



                    BlanketOrderLineNotest2: Decimal;
                    VATBaseAmounttest2: Decimal;
                    UnitCosttest2: Decimal;
                    PostingDatetest2: date;
                    JobTaskNotest2: Decimal;
                    JobLineTypetest2: Enum "Job Line Type";
                    JobUnitPricetest2: Decimal;
                    JobTotalPricetest2: Decimal;
                    JobLineAmounttest2: Decimal;
                    JobLineDiscountAmounttest2: Decimal;
                    JobLineDiscountPercenttest2: Decimal;
                    JobUnitPriceLCYtest2: Decimal;
                    JobTotalPriceLCYtest2: Decimal;
                    JobLineAmountLCYtest2: Decimal;
                    JobLineDiscAmountLCYtest2: Decimal;
                    JobCurrencyFactortest2: Decimal;

                    CrossReferenceTypetest2: Enum "Item Reference Type";


                    //
                    QtyPerUnitOfMeasuretest2: Decimal;
                    QuantityBasetest2: Decimal;
                    QtyInvoicedBasetest2: Decimal;
                    FAPostingDatetest2: Date;
                    FAPostingTypetest2: ENUM "Purchase FA Posting Type";
                    SalvageValuetest2: Decimal;
                    DeprUntilFAPostingDatetest2: Boolean;
                    DeprAcquisitionCosttest2: Boolean;
                    UseDuplicationListtest2: Boolean;
                    Nonstocktest2: Boolean;
                    SpecialOrderSalesLineNotest2: Decimal;
                    RequestedReceiptDatetest2: DATE;
                    PromisedReceiptDatetest2: DATE;
                    LeadTimeCalculationtest2: DateFormula;
                    InboundWhseHandlingTimetest2: DateFormula;
                    PlannedReceiptDatetest2: date;
                    OrderDatetest2: date;
                    ItemChargeBaseAmounttest2: Decimal;
                    Correctiontest2: Boolean;
                    Synchronisetest2: Boolean;
                    NumSequenceSyncrotest2: Decimal;
                    QtyNotInConformitytest2: Decimal;

                    RemainderQuantitytest2: Decimal;
                    OrderLineAmounttest2: Decimal;
                    NotInConformitytest2: Boolean;
                    Value1test2: Decimal;
                    Value2test2: Decimal;
                    Value3test2: Decimal;
                    Value4test2: Decimal;
                    Value5test2: Decimal;
                    Value6test2: Decimal;
                    Value7test2: Decimal;
                    Value8test2: Decimal;
                    Value9test2: Decimal;
                    Value10test2: Decimal;

                    ProdOrderLineNotest2: Decimal;
                    OverheadRatetest2: Decimal;
                    RoutingReferenceNotest2: Decimal;
                //







                begin
                    Evaluate(LineNotest2, LineNo);
                    Evaluate(Typetest2, Type);



                    Evaluate(ExpectedReceiptDateTest2, ExpectedReceiptDate);

                    Evaluate(Quantitytest2, Quantity);


                    Evaluate(DirectUnitCosttest2, DirectUnitCost);
                    Evaluate(UnitCostLCYtest2, UnitCostLCY);
                    Evaluate(VATPercenttest2, VATPercent);
                    Evaluate(LineDiscountPercenttest2, LineDiscountPercent);
                    Evaluate(UnitPriceLCYtest2, UnitPriceLCY);
                    Evaluate(AllowInvoiceDisctest2, AllowInvoiceDisc);



                    Evaluate(GrossWeighttest2, GrossWeight);
                    Evaluate(NetWeighttest2, NetWeight);
                    Evaluate(UnitsPerParceltest2, UnitsPerParcel);
                    Evaluate(UnitVolumetest2, UnitVolume);
                    Evaluate(ApplToItemEntrytest2, ApplToItemEntry);
                    Evaluate(ItemRcptEntryNotest2, ItemRcptEntryNo);


                    Evaluate(IndirectCostPercenttest2, IndirectCostPercent);
                    Evaluate(QtyRcdNotInvoicedtest2, QtyRcdNotInvoiced);
                    Evaluate(QuantityInvoicedtest2, QuantityInvoiced);
                    Evaluate(OrderLineNotest2, OrderLineNo);


                    Evaluate(SalesOrderLineNotest2, SalesOrderLineNo);
                    Evaluate(VATCalculationTypetest23, VATCalculationType);
                    Evaluate(AttachedToLineNotest2, AttachedToLineNo);
                    Evaluate(TaxLiabletest2, TaxLiable);
                    Evaluate(UseTaxtest2, UseTax);


                    Evaluate(BlanketOrderLineNotest2, BlanketOrderLineNo);
                    Evaluate(VATBaseAmounttest2, VATBaseAmount);
                    Evaluate(UnitCosttest2, UnitCost);
                    Evaluate(PostingDatetest2, PostingDate);


                    Evaluate(JobLineTypetest2, JobLineType);
                    Evaluate(JobUnitPricetest2, JobUnitPrice);
                    Evaluate(JobTotalPricetest2, JobTotalPrice);
                    Evaluate(JobLineAmounttest2, JobLineAmount);
                    Evaluate(JobLineDiscountAmounttest2, JobLineDiscountAmount);
                    Evaluate(JobLineDiscountPercenttest2, JobLineDiscountPercent);

                    Evaluate(JobUnitPriceLCYtest2, JobUnitPriceLCY);
                    Evaluate(JobTotalPriceLCYtest2, JobTotalPriceLCY);
                    Evaluate(JobLineAmountLCYtest2, JobLineAmountLCY);
                    Evaluate(JobLineDiscAmountLCYtest2, JobLineDiscAmountLCY);
                    Evaluate(JobCurrencyFactortest2, JobCurrencyFactor);


                    //
                    Evaluate(QtyPerUnitOfMeasuretest2, QtyPerUnitOfMeasure);
                    Evaluate(QuantityBasetest2, QuantityBase);
                    Evaluate(QtyInvoicedBasetest2, QtyInvoicedBase);
                    Evaluate(FAPostingDatetest2, FAPostingDate);
                    Evaluate(FAPostingTypetest2, FAPostingType);
                    Evaluate(SalvageValuetest2, SalvageValue);
                    Evaluate(DeprUntilFAPostingDatetest2, DeprUntilFAPostingDate);
                    Evaluate(DeprAcquisitionCosttest2, DeprAcquisitionCost);
                    Evaluate(UseDuplicationListtest2, UseDuplicationList);
                    Evaluate(Nonstocktest2, Nonstock);
                    Evaluate(SpecialOrderSalesLineNotest2, SpecialOrderSalesLineNo);
                    Evaluate(RequestedReceiptDatetest2, RequestedReceiptDate);
                    Evaluate(PromisedReceiptDatetest2, PromisedReceiptDate);
                    Evaluate(LeadTimeCalculationtest2, LeadTimeCalculation);
                    Evaluate(InboundWhseHandlingTimetest2, InboundWhseHandlingTime);
                    Evaluate(PlannedReceiptDatetest2, PlannedReceiptDate);
                    Evaluate(OrderDatetest2, OrderDate);
                    Evaluate(ItemChargeBaseAmounttest2, ItemChargeBaseAmount);
                    Evaluate(Correctiontest2, Correction);
                    Evaluate(Synchronisetest2, Synchronise);
                    Evaluate(NumSequenceSyncrotest2, NumSequenceSyncro);
                    Evaluate(QtyNotInConformitytest2, QtyNotInConformity);

                    Evaluate(RemainderQuantitytest2, RemainderQuantity);
                    Evaluate(OrderLineAmounttest2, OrderLineAmount);
                    Evaluate(NotInConformitytest2, NotInConformity);
                    Evaluate(Value1test2, Value1);
                    Evaluate(Value2test2, Value2);
                    Evaluate(Value3test2, Value3);
                    Evaluate(Value4test2, Value4);
                    Evaluate(Value5test2, Value5);
                    Evaluate(Value6test2, Value6);
                    Evaluate(Value7test2, Value7);
                    Evaluate(Value8test2, Value8);
                    Evaluate(Value9test2, Value9);
                    Evaluate(Value10test2, Value10);

                    Evaluate(ProdOrderLineNotest2, ProdOrderLineNo);
                    Evaluate(OverheadRatetest2, OverheadRate);
                    Evaluate(RoutingReferenceNotest2, RoutingReferenceNo);
                    Evaluate(CrossReferenceTypetest2, CrossReferenceType);

                    //





                    IF RecPurchaseLine.GET(DocumentNo, LineNotest2) THEN currXMLport.SKIP;
                    PurchRcptLine.Init();
                    Clear(PurchRcptLine);


                    PurchRcptLine.VALIDATE("Buy-from Vendor No.", BuyFromVendorNo);
                    //    PurchRcptLine.VALIDATE("Document No.", DocumentNo);
                    PurchRcptLine."Document No." := DocumentNo;
                    PurchRcptLine.VALIDATE("Line No.", LineNotest2);
                    PurchRcptLine.VALIDATE(Type, Typetest2);
                    PurchRcptLine.VALIDATE("No.", No);
                    PurchRcptLine.VALIDATE("Location Code", LocationCode);
                    PurchRcptLine.VALIDATE("Posting Group", PostingGroup);
                    PurchRcptLine."Expected Receipt Date" := ExpectedReceiptDateTest2;
                    PurchRcptLine.Description := Description;
                    PurchRcptLine."Description 2" := Description22;
                    PurchRcptLine.VALIDATE("Unit of Measure", UnitOfMeasure);
                    PurchRcptLine.VALIDATE("Quantity", Quantitytest2);

                    PurchRcptLine."Direct Unit Cost" := DirectUnitCosttest2;
                    PurchRcptLine."Unit Cost (LCY)" := UnitCostLCYtest2;
                    PurchRcptLine."VAT %" := VATPercenttest2;
                    PurchRcptLine."Line Discount %" := LineDiscountPercenttest2;
                    PurchRcptLine."Unit Price (LCY)" := UnitPriceLCYtest2;
                    PurchRcptLine."Allow Invoice Disc." := AllowInvoiceDisctest2;
                    PurchRcptLine."Gross Weight" := GrossWeighttest2;
                    PurchRcptLine."Net Weight" := NetWeighttest2;
                    PurchRcptLine."Units per Parcel" := UnitsPerParceltest2;
                    PurchRcptLine."Unit Volume" := UnitVolumetest2;
                    PurchRcptLine."Appl.-to Item Entry" := ApplToItemEntrytest2;
                    PurchRcptLine."Item Rcpt. Entry No." := ItemRcptEntryNotest2;
                    PurchRcptLine."Shortcut Dimension 1 Code" := ShortcutDim1;
                    PurchRcptLine."Shortcut Dimension 2 Code" := ShortcutDim2;
                    PurchRcptLine."Job No." := JobNo;
                    PurchRcptLine."Indirect Cost %" := IndirectCostPercenttest2;
                    PurchRcptLine."Qty. Rcd. Not Invoiced" := QtyRcdNotInvoicedtest2;
                    PurchRcptLine."Quantity Invoiced" := QuantityInvoicedtest2;
                    PurchRcptLine."Order No." := OrderNo;
                    PurchRcptLine."Order Line No." := OrderLineNotest2;
                    PurchRcptLine."Pay-to Vendor No." := PayToVendorNo;
                    PurchRcptLine."Vendor Item No." := VendorItemNo;
                    PurchRcptLine."Sales Order No." := SalesOrderNo;
                    PurchRcptLine."Sales Order Line No." := SalesOrderLineNotest2;
                    PurchRcptLine."Gen. Bus. Posting Group" := GenBusPostingGroup;
                    PurchRcptLine."Gen. Prod. Posting Group" := GenProdPostingGroup;
                    //GL2026    PurchRcptLine."VAT Calculation Type" := VATCalculationTypetest2;
                    IF VATCalculationTypetest23 = VATCalculationTypetest23::Normal then
                        PurchRcptLine."VAT Calculation Type" := PurchRcptLine."VAT Calculation Type"::"Normal VAT"
                    else IF VATCalculationTypetest23 = VATCalculationTypetest23::"Intracomm." then
                        PurchRcptLine."VAT Calculation Type" := PurchRcptLine."VAT Calculation Type"::"Reverse Charge VAT"
                    else IF VATCalculationTypetest23 = VATCalculationTypetest23::Correctif then
                        PurchRcptLine."VAT Calculation Type" := PurchRcptLine."VAT Calculation Type"::"Full VAT"

                    else IF VATCalculationTypetest23 = VATCalculationTypetest23::"Sales Tax" then
                        PurchRcptLine."VAT Calculation Type" := PurchRcptLine."VAT Calculation Type"::"Sales Tax";

                    PurchRcptLine."Transaction Type" := TransactionType;
                    PurchRcptLine."Transport Method" := TransportMethod;
                    PurchRcptLine."Attached to Line No." := AttachedToLineNotest2;
                    PurchRcptLine."Entry Point" := EntryPoint;
                    PurchRcptLine.Area := Area2;
                    PurchRcptLine."Transaction Specification" := TransactionSpecification;
                    PurchRcptLine."Tax Area Code" := TaxAreaCode;
                    PurchRcptLine."Tax Liable" := TaxLiabletest2;
                    PurchRcptLine."Tax Group Code" := TaxGroupCode;
                    PurchRcptLine."Use Tax" := UseTaxtest2;
                    PurchRcptLine."VAT Bus. Posting Group" := VATBusPostingGroup;
                    PurchRcptLine."VAT Prod. Posting Group" := VATProdPostingGroup;
                    PurchRcptLine."Currency Code" := CurrencyCode;
                    PurchRcptLine."Blanket Order No." := BlanketOrderNo;
                    PurchRcptLine."Blanket Order Line No." := BlanketOrderLineNotest2;
                    PurchRcptLine."VAT Base Amount" := VATBaseAmounttest2;
                    PurchRcptLine."Unit Cost" := UnitCosttest2;
                    PurchRcptLine."Posting Date" := PostingDatetest2;
                    PurchRcptLine."Job Task No." := JobTaskNo;
                    PurchRcptLine."Job Line Type" := JobLineTypetest2;
                    PurchRcptLine."Job Unit Price" := JobUnitPricetest2;
                    PurchRcptLine."Job Total Price" := JobTotalPricetest2;
                    PurchRcptLine."Job Line Amount" := JobLineAmounttest2;
                    PurchRcptLine."Job Line Discount Amount" := JobLineDiscountAmounttest2;
                    PurchRcptLine."Job Line Discount %" := JobLineDiscountPercenttest2;
                    PurchRcptLine."Job Unit Price (LCY)" := JobUnitPriceLCYtest2;
                    PurchRcptLine."Job Total Price (LCY)" := JobTotalPriceLCYtest2;
                    PurchRcptLine."Job Line Amount (LCY)" := JobLineAmountLCYtest2;
                    PurchRcptLine."Job Line Disc. Amount (LCY)" := JobLineDiscAmountLCYtest2;
                    PurchRcptLine."Job Currency Factor" := JobCurrencyFactortest2;
                    PurchRcptLine."Job Currency Code" := JobCurrencyCode;
                    PurchRcptLine."Prod. Order No." := ProdOrderNo;
                    PurchRcptLine."Variant Code" := VariantCode;
                    PurchRcptLine."Bin Code" := BinCode;
                    PurchRcptLine."Qty. per Unit of Measure" := QtyPerUnitOfMeasuretest2;
                    PurchRcptLine."Unit of Measure Code" := UnitOfMeasureCode;
                    PurchRcptLine."Quantity (Base)" := QuantityBasetest2;
                    PurchRcptLine."Qty. Invoiced (Base)" := QtyInvoicedBasetest2;
                    PurchRcptLine."FA Posting Date" := FAPostingDatetest2;
                    PurchRcptLine."FA Posting Type" := FAPostingTypetest2;
                    PurchRcptLine."Depreciation Book Code" := DepreciationBookCode;
                    PurchRcptLine."Salvage Value" := SalvageValuetest2;
                    PurchRcptLine."Depr. until FA Posting Date" := DeprUntilFAPostingDatetest2;
                    PurchRcptLine."Depr. Acquisition Cost" := DeprAcquisitionCosttest2;
                    PurchRcptLine."Maintenance Code" := MaintenanceCode;
                    PurchRcptLine."Insurance No." := InsuranceNo;
                    PurchRcptLine."Budgeted FA No." := BudgetedFANo;
                    PurchRcptLine."Duplicate in Depreciation Book" := DuplicateInDepreciationBook;
                    PurchRcptLine."Use Duplication List" := UseDuplicationListtest2;
                    PurchRcptLine."Responsibility Center" := ResponsibilityCenter;
                    PurchRcptLine."item Reference No." := CrossReferenceNo;
                    PurchRcptLine."Item Reference Unit of Measure" := UnitOfMeasureCrossRef;
                    PurchRcptLine."item Reference Type" := CrossReferenceTypetest2;
                    PurchRcptLine."item Reference Type No." := CrossReferenceTypeNo;
                    PurchRcptLine."Item Category Code" := ItemCategoryCode;
                    PurchRcptLine.Nonstock := Nonstocktest2;
                    PurchRcptLine."Purchasing Code" := PurchasingCode;
                    PurchRcptLine."Product Group Code2" := ProductGroupCode;
                    PurchRcptLine."Special Order Sales No." := SpecialOrderSalesNo;
                    PurchRcptLine."Special Order Sales Line No." := SpecialOrderSalesLineNotest2;
                    PurchRcptLine."Requested Receipt Date" := RequestedReceiptDatetest2;
                    PurchRcptLine."Promised Receipt Date" := PromisedReceiptDatetest2;
                    PurchRcptLine."Lead Time Calculation" := LeadTimeCalculationtest2;
                    PurchRcptLine."Inbound Whse. Handling Time" := InboundWhseHandlingTimetest2;
                    PurchRcptLine."Planned Receipt Date" := PlannedReceiptDatetest2;
                    PurchRcptLine."Order Date" := OrderDatetest2;
                    PurchRcptLine."Item Charge Base Amount" := ItemChargeBaseAmounttest2;
                    PurchRcptLine.Correction := Correctiontest2;
                    PurchRcptLine."Return Reason Code" := ReturnReasonCode;
                    PurchRcptLine."N° dossier" := Nossier;
                    PurchRcptLine.Synchronise := Synchronisetest2;
                    PurchRcptLine."Num BL Fournisseur" := NumBLFournisseur;
                    PurchRcptLine.Materiel := Materiel;
                    PurchRcptLine."Num Sequence Syncro" := NumSequenceSyncrotest2;
                    PurchRcptLine."Qty. Not In Conformity" := QtyNotInConformitytest2;
                    PurchRcptLine."Not In Conformity Code" := NotInConformityCode;
                    PurchRcptLine."Remainder Quantity" := RemainderQuantitytest2;
                    PurchRcptLine."Order Line Amount" := OrderLineAmounttest2;
                    PurchRcptLine."Not In Conformity" := NotInConformitytest2;
                    PurchRcptLine."Work Type Code" := WorkTypeCode;
                    PurchRcptLine."Charge To Order No." := ChargeToOrderNo;
                    PurchRcptLine."Value 1" := Value1test2;
                    PurchRcptLine."Value 2" := Value2test2;
                    PurchRcptLine."Value 3" := Value3test2;
                    PurchRcptLine."Value 4" := Value4test2;
                    PurchRcptLine."Value 5" := Value5test2;
                    PurchRcptLine."Value 6" := Value6test2;
                    PurchRcptLine."Value 7" := Value7test2;
                    PurchRcptLine."Value 8" := Value8test2;
                    PurchRcptLine."Value 9" := Value9test2;
                    PurchRcptLine."Value 10" := Value10test2;
                    PurchRcptLine."Routing No." := RoutingNo;
                    PurchRcptLine."Operation No." := OperationNo;
                    PurchRcptLine."Work Center No." := WorkCenterNo;
                    PurchRcptLine."Prod. Order Line No." := ProdOrderLineNotest2;
                    PurchRcptLine."Overhead Rate" := OverheadRatetest2;
                    PurchRcptLine."Routing Reference No." := RoutingReferenceNotest2;


                    //




                end;




                trigger OnAfterInsertRecord()
                begin
                    //  PurchRcptLine.INSERT(true);
                end;

                trigger OnPreXmlItem()
                begin
                    //  COMMIT;
                end;

            }
        }
    }

    trigger OnPreXmlPort()
    begin
        // Converted from OnPreDataport


        //  IF RecGLSetup.GET THEN;
        //     currXMLport.FILENAME := RecGLSetup."Données Administration" + NomFichier + '.txt';
        // Image.DELETEALL;

    end;

    trigger OnPostXmlPort()
    begin

        COMMIT;
        MESSAGE(Text001);

    end;


    Procedure Documentation()
    begin


        ok := 1;
    end;

    Procedure InsertImage(ParaSequence: Integer; ParaTable: Integer; "ParaSeq-Doc-Code": Code[100];
    ParLigne: Integer; ParaFrs: Code[50]; ParaMagasin: code[30]; ParaQuantité: decimal; ParaArticle: code[50];
    ParaDescription: text[100]; ParaNomTable: integer)
    var

        Image: Record "Image Chantier";
    begin



        Image.Sequence := ParaSequence;
        Image.Table := ParaTable;
        Image."Sequence / Document / Code" := "ParaSeq-Doc-Code";
        Image."Ligne / Sequence" := ParLigne;
        Image.Fournisseur := ParaFrs;
        Image.Magasin := ParaMagasin;
        Image.Quantité := ParaQuantité;
        Image.Description := ParaDescription;
        Image.Article := ParaArticle;
        Image."Nom Table" := ParaNomTable;
        IF Image.INSERT THEN COMMIT;
    end;



    procedure GetNomFichier(ParaNomFichier: Text[100])
    begin


        NomFichier := ParaNomFichier;
    end;





    var

        Image: Record "Image Chantier";
        SequenceImage: Integer;
        RecPurchaseLine: Record "Purch. Rcpt. Line";
        RecPurchaseHeader: Record "Purch. Rcpt. Header";
        RecPurchaseLine2: Record "Purch. Rcpt. Line";
        RecPurchaseHeader2: Record "Purch. Rcpt. Header";
        PurchPost: Codeunit PurchPostEvent;
        RecPaymentHeader: Record "Payment Header";
        ItemJrlLine: Record "Item Journal Line";
        ItemJrlLine2: Record "Item Journal Line";
        RecGLSetup: Record "General Ledger Setup";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        ItemJournalLine: Record "Item Journal Line";
        Ligne: Integer;
        Article: Code[20];
        DateCpt: Date;
        DocNo: Code[20];
        Magasin: Code[20];
        Quantite: Decimal;
        ItemJnlPost: Codeunit "Item Jnl.-Post Line";
        NumSequence: Integer;
        Vehicule: Code[20];
        Affectation: Code[20];
        SousAffectation: Code[20];
        Ok: Integer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PurchaseLine: Record "Purchase Line";

        Image2: Record "Image Chantier";
        NomFichier: Text[100];
        PurchaseHeader: Record "Purchase Header";
        PuchaseLine: Record "Purchase Line";
        Variante: Code[30];
        va1: Code[20];
        va2: Code[20];
        TypeEntree: Option;
        RecItem: Record Item;
        ProductionOrder: Record "Production Order";
        RecPaymentLine: Record "Payment Line";
        Depasser: Boolean;
        Description2: Text[100];
        DocExterne: Code[100];
        SousAffectMarche: Code[100];
        Origine: Code[20];
        RecVehicule: Record Véhicule;
        Text001: label 'Importation Données Achevées Avec Succée';


}
