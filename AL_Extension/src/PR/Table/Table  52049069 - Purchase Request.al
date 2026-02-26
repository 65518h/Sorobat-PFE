Table 52049069 "Purchase Request"
{

    Caption = 'Purchase Request';
    DataCaptionFields = "No.", "Buy-from Vendor Name";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //OnBeforeValidateBuyFromVendorNo(Rec, xRec, CurrFieldNo, SkipBuyFromContact, IsHandled);
                if IsHandled then
                    exit;

                if "No." = '' then
                    InitRecord();
                TestStatusOpen();

                if ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") and
                   (xRec."Buy-from Vendor No." <> '')
                then begin
                    CheckDropShipmentLineExists();
                    if ConfirmUpdateField(FieldNo("Buy-from Vendor No.")) then begin
                        if InitFromVendor("Buy-from Vendor No.", FieldCaption("Buy-from Vendor No.")) then
                            exit;

                        CheckReceiptInfo(PurchRqLine, false);
                        CheckPrepmtInfo(PurchRqLine);
                        CheckReturnInfo(PurchRqLine, false);

                        PurchRqLine.Reset();
                    end else begin
                        Rec := xRec;
                        exit;
                    end;
                end;

                GetVend("Buy-from Vendor No.");
                CheckBlockedVendOnDocs(Vend);
                if not ApplicationAreaMgmt.IsSalesTaxEnabled() then
                    Vend.TestField("Gen. Bus. Posting Group");
                //  OnAfterCheckBuyFromVendor(Rec, xRec, Vend);

                "Buy-from Vendor Name" := Vend.Name;
                "Buy-from Vendor Name 2" := Vend."Name 2";
                CopyBuyFromVendorAddressFieldsFromVendor(Vend, false);
                if not SkipBuyFromContact then
                    "Buy-from Contact" := Vend.Contact;
                "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
                "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
                "Tax Area Code" := Vend."Tax Area Code";
                "Tax Liable" := Vend."Tax Liable";
                "VAT Country/Region Code" := Vend."Country/Region Code";
                "VAT Registration No." := Vend."VAT Registration No.";
                Validate("Lead Time Calculation", Vend."Lead Time Calculation");
                "Shipment Method Code" := Vend."Shipment Method Code";

                IsHandled := false;
                // OnValidateBuyFromVendorNoOnBeforeAssignResponsibilityCenter(Rec, xRec, CurrFieldNo, IsHandled);
                if not IsHandled then
                    "Responsibility Center" := UserSetupMgt.GetRespCenter(1, Vend."Responsibility Center");
                ValidateEmptySellToCustomerAndLocation();
                //    OnAfterCopyBuyFromVendorFieldsFromVendor(Rec, Vend, xRec);

                if "Buy-from Vendor No." = xRec."Pay-to Vendor No." then
                    if ReceivedPurchLinesExist() or ReturnShipmentExist() then begin
                        TestField("VAT Bus. Posting Group", xRec."VAT Bus. Posting Group");
                        TestField("Gen. Bus. Posting Group", xRec."Gen. Bus. Posting Group");
                    end;

                "Buy-from IC Partner Code" := Vend."IC Partner Code";
                "Send IC Document" := ("Buy-from IC Partner Code" <> '') and ("IC Direction" = "IC Direction"::Outgoing);

                //  OnValidateBuyFromVendorNoOnValidateBuyFromVendorNoOnBeforeValidatePayToVendor(Rec);
                if Vend."Pay-to Vendor No." <> '' then
                    Validate("Pay-to Vendor No.", Vend."Pay-to Vendor No.")
                else begin
                    if "Buy-from Vendor No." = "Pay-to Vendor No." then
                        SkipPayToContact := true;
                    Validate("Pay-to Vendor No.", "Buy-from Vendor No.");
                    SkipPayToContact := false;
                end;
                "Order Address Code" := '';

                // OnValidateBuyFromVendorNoOnAfterValidatePayToVendor(Rec);

                CopyPayToVendorAddressFieldsFromVendor(Vend, false);
                if IsCreditDocType() then begin
                    "Ship-to Name" := Vend.Name;
                    "Ship-to Name 2" := Vend."Name 2";
                    CopyShipToVendorAddressFieldsFromVendor(Vend, true);
                    "Ship-to Contact" := Vend.Contact;
                    "Shipment Method Code" := Vend."Shipment Method Code";
                    if Vend."Location Code" <> '' then
                        Validate("Location Code", Vend."Location Code");
                end;

                //  OnValidateBuyFromVendorNoBeforeRecreateLines(Rec, CurrFieldNo, Vend);

                if (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") or
                   (xRec."Currency Code" <> "Currency Code") or
                   (xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group") or
                   (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
                then
                    RecreatePurchLines(BuyFromVendorTxt);

                //  OnValidateBuyFromVendorNoOnAfterRecreateLines(Rec, xRec, CurrFieldNo);

                if not SkipBuyFromContact then
                    UpdateBuyFromCont("Buy-from Vendor No.");

                //   OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(Rec, xRec, CurrFieldNo, SkipBuyFromContact);

                if (xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> "Buy-from Vendor No.") then
                    Rec.RecallModifyAddressNotification(GetModifyVendorAddressNotificationId());
            end;
        }
        field(50211; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    GetPurchSetup();
                    NoSeries.TestManual(GetNoSeriesCode());
                    "No. Series" := '';
                end;
            end;
        }
        field(50212; "No Series"; Code[10])
        {
            Caption = 'N° Série';
            TableRelation = "No. Series";
            Editable = false;
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //    OnBeforeValidatePayToVendorNo(Rec, xRec, Confirmed, IsHandled);
                if IsHandled then
                    exit;

                TestStatusOpen();
                if (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") and
                   (xRec."Pay-to Vendor No." <> '')
                then
                    if ConfirmUpdateField(FieldNo("Pay-to Vendor No.")) then begin
                        PurchRqLine.SetRange("Document Type", "Document Type");
                        PurchRqLine.SetRange("Document No.", "No.");

                        CheckReceiptInfo(PurchrqLine, true);
                        CheckPrepmtInfo(PurchrqLine);
                        CheckReturnInfo(PurchrqLine, true);

                        PurchRqLine.Reset();
                    end else
                        "Pay-to Vendor No." := xRec."Pay-to Vendor No.";

                //  OnValidatePayToVendorNoOnBeforeGetPayToVend(Rec);
                GetVend("Pay-to Vendor No.");
                CheckBlockedVendOnDocs(Vend);
                Vend.TestField("Vendor Posting Group");
                PostingSetupMgt.CheckVendPostingGroupPayablesAccount("Vendor Posting Group");
                //   OnAfterCheckPayToVendor(Rec, xRec, Vend);

                "Pay-to Name" := Vend.Name;
                "Pay-to Name 2" := Vend."Name 2";
                CopyPayToVendorAddressFieldsFromVendor(Vend, false);
                if not SkipPayToContact then
                    "Pay-to Contact" := Vend.Contact;
                "Payment Terms Code" := Vend."Payment Terms Code";
                "Prepmt. Payment Terms Code" := Vend."Payment Terms Code";
                "Payment Method Code" := Vend."Payment Method Code";
                "Price Calculation Method" := Vend.GetPriceCalculationMethod();
                if "Buy-from Vendor No." = Vend."No." then
                    "Shipment Method Code" := Vend."Shipment Method Code";
                "Vendor Posting Group" := Vend."Vendor Posting Group";
                //   OnAfterCopyPayToVendorFieldsFromVendor(Rec, Vend, xRec);

                GLSetup.Get();
                if GLSetup."Bill-to/Sell-to VAT Calc." = GLSetup."Bill-to/Sell-to VAT Calc."::"Bill-to/Pay-to No." then begin
                    "VAT Bus. Posting Group" := Vend."VAT Bus. Posting Group";
                    "VAT Country/Region Code" := Vend."Country/Region Code";
                    "VAT Registration No." := Vend."VAT Registration No.";
                    "Gen. Bus. Posting Group" := Vend."Gen. Bus. Posting Group";
                end;
                "Prices Including VAT" := Vend."Prices Including VAT";
                "Currency Code" := Vend."Currency Code";
                "Invoice Disc. Code" := Vend."Invoice Disc. Code";
                "Language Code" := Vend."Language Code";
                "Format Region" := Vend."Format Region";
                SetPurchaserCode(Vend."Purchaser Code", "Purchaser Code");
                Validate("Payment Terms Code");
                Validate("Prepmt. Payment Terms Code");
                Validate("Payment Method Code");
                Validate("Currency Code");
                Validate("Creditor No.", Vend."Creditor No.");
#if not CLEAN22
                //    OnValidatePurchaseHeaderPayToVendorNo(Vend, Rec);
#endif
                //   OnValidatePurchaseHeaderPayToVendorNoOnBeforeCheckDocType(Vend, Rec, xRec, SkipPayToContact);

                if "Document Type" = "Document Type"::Order then
                    Validate("Prepayment %", Vend."Prepayment %");

                if "Pay-to Vendor No." = xRec."Pay-to Vendor No." then begin
                    if ReceivedPurchLinesExist() then
                        TestField("Currency Code", xRec."Currency Code");
                end;

                CreateDimensionsFromValidatePayToVendorNo();

                //      OnValidatePaytoVendorNoBeforeRecreateLines(Rec, CurrFieldNo);

                if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
                   (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.")
                then
                    RecreatePurchLines(PayToVendorTxt);

                if not SkipPayToContact then
                    UpdatePayToCont("Pay-to Vendor No.");

                "Pay-to IC Partner Code" := Vend."IC Partner Code";

                //  OnValidatePayToVendorNoOnBeforeRecallModifyAddressNotification(Rec, xRec, Vend);
                if (xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> "Pay-to Vendor No.") then
                    Rec.RecallModifyAddressNotification(GetModifyPayToVendorAddressNotificationId());
            end;
        }
        field(5; "Pay-to Name"; Text[100])
        {
            Caption = 'Pay-to Name';
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                Vendor: Record Vendor;
            begin
                if "Pay-to Vendor No." <> '' then
                    Vendor.Get("Pay-to Vendor No.");

                if Vendor.SelectVendor(Vendor) then begin
                    xRec := Rec;
                    "Pay-to Name" := Vendor.Name;
                    Validate("Pay-to Vendor No.", Vendor."No.");
                end;
            end;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                if ShouldSearchForVendorByName("Pay-to Vendor No.") then
                    Validate("Pay-to Vendor No.", Vendor.GetVendorNo("Pay-to Name"));
            end;
        }
        field(6; "Pay-to Name 2"; Text[50])
        {
            Caption = 'Pay-to Name 2';
        }
        field(7; "Pay-to Address"; Text[100])
        {
            Caption = 'Pay-to Address';

            trigger OnValidate()
            begin
                ModifyPayToVendorAddress();
            end;
        }
        field(8; "Pay-to Address 2"; Text[50])
        {
            Caption = 'Pay-to Address 2';

            trigger OnValidate()
            begin
                ModifyPayToVendorAddress();
            end;
        }
        field(9; "Pay-to City"; Text[30])
        {
            Caption = 'Pay-to City';
            TableRelation = if ("Pay-to Country/Region Code" = const('')) "Post Code".City
            else
            if ("Pay-to Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Pay-to Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                LookupPostCode("Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", CurrFieldNo);
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;

                if not IsHandled then
                    PostCode.ValidateCity(
                        "Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                ModifyPayToVendorAddress();
            end;
        }
        field(10; "Pay-to Contact"; Text[100])
        {
            Caption = 'Pay-to Contact';

            trigger OnLookup()
            var
                Contact: Record Contact;
            begin
                Contact.FilterGroup(2);
                LookupContact("Pay-to Vendor No.", "Pay-to Contact No.", Contact);
                if PAGE.RunModal(0, Contact) = ACTION::LookupOK then
                    Validate("Pay-to Contact No.", Contact."No.");
                Contact.FilterGroup(0);
            end;

            trigger OnValidate()
            begin
                ModifyPayToVendorAddress();
            end;
        }
        field(11; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code where("Customer No." = field("Sell-to Customer No."));

            trigger OnValidate()
            var
                ShipToAddr: Record "Ship-to Address";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //  OnBeforeValidateShipToCode(Rec, xRec, ShipToAddr, IsHandled);
                if IsHandled then
                    exit;

                CheckShipToCodeChange(Rec, xRec);

                if "Ship-to Code" <> '' then begin
                    ShipToAddr.Get("Sell-to Customer No.", "Ship-to Code");
                    SetShipToAddress(
                      ShipToAddr.Name, ShipToAddr."Name 2", ShipToAddr.Address, ShipToAddr."Address 2",
                      ShipToAddr.City, ShipToAddr."Post Code", ShipToAddr.County, ShipToAddr."Country/Region Code");
                    "Ship-to Contact" := ShipToAddr.Contact;
                    if ShipToAddr."Shipment Method Code" <> '' then
                        "Shipment Method Code" := ShipToAddr."Shipment Method Code"
                    else
                        if "Sell-to Customer No." <> '' then
                            if Cust.Get("Sell-to Customer No.") then
                                "Shipment Method Code" := Cust."Shipment Method Code";
                    if ShipToAddr."Location Code" <> '' then
                        Validate("Location Code", ShipToAddr."Location Code");
                    //    OnValidateShipToCodeOnAfterCopyFromShipToAddr(Rec, ShipToAddr);
                end else begin
                    TestField("Sell-to Customer No.");
                    Cust.Get("Sell-to Customer No.");
                    SetShipToAddress(
                      Cust.Name, Cust."Name 2", Cust.Address, Cust."Address 2",
                      Cust.City, Cust."Post Code", Cust.County, Cust."Country/Region Code");
                    "Ship-to Contact" := Cust.Contact;
                    "Shipment Method Code" := Cust."Shipment Method Code";
                    if Cust."Location Code" <> '' then
                        Validate("Location Code", Cust."Location Code");
                    //    OnValidateShipToCodeOnAfterCopyFromSellToCust(Rec, Cust);
                end;

                // OnAfterValidateShipToCode(Rec, Cust, ShipToAddr);
            end;
        }
        field(13; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = if ("Ship-to Country/Region Code" = const('')) "Post Code".City
            else
            if ("Ship-to Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Ship-to Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                LookupPostCode("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", CurrFieldNo);
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //   OnBeforeValidateShipToCity(Rec, PostCode, CurrFieldNo, IsHandled);
                if not IsHandled then
                    PostCode.ValidateCity(
                        "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(18; "Ship-to Contact"; Text[100])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Order Date';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //  OnBeforeValidateOrderDate(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if ("Document Type" in ["Document Type"::Quote, "Document Type"::Order]) and
                   not ("Order Date" = xRec."Order Date")
                then
                    PriceMessageIfPurchLinesExist(FieldCaption("Order Date"));
            end;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            var
                PurchasesPayablesSetup: Record "Purchases & Payables Setup";
                SkipJobCurrFactorUpdate: Boolean;
                IsHandled: Boolean;
                NeedUpdateCurrencyFactor: Boolean;
            begin
                IsHandled := false;
                //  OnBeforeValidatePostingDate(Rec, xRec, CurrFieldNo, IsHandled);
                if IsHandled then
                    exit;

                TestField("Posting Date");
                TestNoSeriesDate(
                  "Posting No.", "Posting No. Series",
                  FieldCaption("Posting No."), FieldCaption("Posting No. Series"));
                TestNoSeriesDate(
                  "Prepayment No.", "Prepayment No. Series",
                  FieldCaption("Prepayment No."), FieldCaption("Prepayment No. Series"));
                TestNoSeriesDate(
                  "Prepmt. Cr. Memo No.", "Prepmt. Cr. Memo No. Series",
                  FieldCaption("Prepmt. Cr. Memo No."), FieldCaption("Prepmt. Cr. Memo No. Series"));

                GLSetup.Get();
                GLSetup.UpdateVATDate("Posting Date", Enum::"VAT Reporting Date"::"Posting Date", "VAT Reporting Date");
                Validate("VAT Reporting Date");

                PurchasesPayablesSetup.SetLoadFields("Link Doc. Date To Posting Date");
                PurchasesPayablesSetup.GetRecordOnce();

                if ("Incoming Document Entry No." = 0) and PurchasesPayablesSetup."Link Doc. Date To Posting Date" then
                    ValidateDocumentDateWithPostingDate();

                if ("Document Type" in ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) and
                   not ("Posting Date" = xRec."Posting Date")
                then
                    PriceMessageIfPurchLinesExist(FieldCaption("Posting Date"));

                // OnValidatePostingDateOnBeforeResetInvoiceDiscountValue(Rec, xRec, CurrFieldNo);
                ResetInvoiceDiscountValue();

                NeedUpdateCurrencyFactor := "Currency Code" <> '';
                //  OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor(Rec, xRec, Confirmed, NeedUpdateCurrencyFactor);
                if NeedUpdateCurrencyFactor then begin
                    UpdateCurrencyFactor();
                    if ("Currency Factor" <> xRec."Currency Factor") and not GetCalledFromWhseDoc() then
                        SkipJobCurrFactorUpdate := not ConfirmCurrencyFactorUpdate();
                end;
                //  OnValidatePostingDateOnAfterCheckNeedUpdateCurrencyFactor(Rec, xRec, SkipJobCurrFactorUpdate);

                if "Posting Date" <> xRec."Posting Date" then
                    if DeferralHeadersExist() then
                        ConfirmUpdateDeferralDate();

                if PurchLinesExist() then
                    JobUpdatePurchLines(SkipJobCurrFactorUpdate);
            end;
        }
        field(21; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                if IsHandled then
                    exit;

                if "Expected Receipt Date" <> 0D then
                    UpdatePurchLinesByFieldNo(FieldNo("Expected Receipt Date"), CurrFieldNo <> 0);
            end;
        }
        field(22; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";


        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                if IsHandled then
                    exit;

                if not (CurrFieldNo in [0, FieldNo("Posting Date"), FieldNo("Document Date")]) then
                    TestStatusOpen();
                GLSetup.Get();
                if "Payment Discount %" < GLSetup."VAT Tolerance %" then
                    "VAT Base Discount %" := "Payment Discount %"
                else
                    "VAT Base Discount %" := GLSetup."VAT Tolerance %";
                Validate("VAT Base Discount %");
            end;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                if IsHandled then
                    exit;

                TestStatusOpen();
            end;
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                if IsHandled then
                    exit;

                TestStatusOpen();
                // if ("Location Code" <> xRec."Location Code") and
                //    (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
                // then
                //     MessageIfPurchLinesExist(FieldCaption("Location Code"));

                UpdateShipToAddress();
                UpdateInboundWhseHandlingTime();
                if "Location Code" <> xRec."Location Code" then
                    CreateDimFromDefaultDim(Rec.FieldNo("Location Code"));
            end;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(31; "Vendor Posting Group"; Code[20])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";

            trigger OnValidate()
            begin
                CheckVendorPostingGroupChange();
            end;
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;


        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                ResetInvoiceDiscountValue();

                if "Currency Factor" <> xRec."Currency Factor" then
                    UpdatePurchLinesByFieldNo(FieldNo("Currency Factor"), CurrFieldNo <> 0);
            end;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';


        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';

            trigger OnValidate()
            begin
                TestStatusOpen();
                MessageIfPurchLinesExist(FieldCaption("Invoice Disc. Code"));
            end;
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;

            trigger OnValidate()
            begin
                MessageIfPurchLinesExist(FieldCaption("Language Code"));
            end;
        }
        field(42; "Format Region"; Text[80])
        {
            Caption = 'Format Region';
            TableRelation = "Language Selection"."Language Tag";
        }
        field(43; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));


        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = exist("Purch. Comment Line" where("Document Type" = field("Document Type"),
                                                             "No." = field("No."),
                                                             "Document Line No." = const(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
        }
        field(52; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                // OnBeforeValidateAppliesToDocNo(Rec, IsHandled);
                if IsHandled then
                    exit;

                if "Applies-to Doc. No." <> '' then
                    TestField("Bal. Account No.", '');

                if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." <> '') and
                   ("Applies-to Doc. No." <> '')
                then begin
                    SetAmountToApply("Applies-to Doc. No.", "Buy-from Vendor No.");
                    SetAmountToApply(xRec."Applies-to Doc. No.", "Buy-from Vendor No.");
                end else
                    if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and (xRec."Applies-to Doc. No." = '') then
                        SetAmountToApply("Applies-to Doc. No.", "Buy-from Vendor No.")
                    else
                        if ("Applies-to Doc. No." <> xRec."Applies-to Doc. No.") and ("Applies-to Doc. No." = '') then
                            SetAmountToApply(xRec."Applies-to Doc. No.", "Buy-from Vendor No.");
            end;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account";

            trigger OnValidate()
            begin
                if "Bal. Account No." <> '' then
                    case "Bal. Account Type" of
                        "Bal. Account Type"::"G/L Account":
                            begin
                                GLAcc.Get("Bal. Account No.");
                                GLAcc.CheckGLAcc();
                                GLAcc.TestField("Direct Posting", true);
                            end;
                        "Bal. Account Type"::"Bank Account":
                            begin
                                BankAcc.Get("Bal. Account No.");
                                BankAcc.TestField(Blocked, false);
                                BankAcc.TestField("Currency Code", "Currency Code");
                            end;
                    end;
            end;
        }
        field(56; "Recalculate Invoice Disc."; Boolean)
        {
            CalcFormula = exist("Purchase request Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No."),
                                                       "Recalculate Invoice Disc." = const(true)));
            Caption = 'Recalculate Invoice Disc.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; Receive; Boolean)
        {
            Caption = 'Receive';
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
        }
        field(59; "Print Posted Documents"; Boolean)
        {
            Caption = 'Print Posted Documents';
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase request Line".Amount where("Document Type" = field("Document Type"),
                                                            "Document No." = field("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase request Line"."Amount Including VAT" where("Document Type" = field("Document Type"),
                                                                            "Document No." = field("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            Editable = false;
            TableRelation = "Purch. Rcpt. Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Purch. Inv. Header";
        }
        field(66; "Vendor Order No."; Code[35])
        {
            Caption = 'Vendor Order No.';
        }
        field(67; "Vendor Shipment No."; Code[35])
        {
            Caption = 'Vendor Shipment No.';


        }
        field(68; "Vendor Invoice No."; Code[35])
        {
            Caption = 'Vendor Invoice No.';

            trigger OnValidate()
            var
                VendorLedgerEntry: Record "Vendor Ledger Entry";
            begin
                if "Vendor Invoice No." <> '' then
                    if FindPostedDocumentWithSameExternalDocNo(VendorLedgerEntry, "Vendor Invoice No.") then
                        ShowExternalDocAlreadyExistNotification(VendorLedgerEntry)
                    else
                        RecallExternalDocAlreadyExistsNotification();
            end;
        }
        field(69; "Vendor Cr. Memo No."; Code[35])
        {
            Caption = 'Vendor Cr. Memo No.';

            trigger OnValidate()
            var
                VendorLedgerEntry: Record "Vendor Ledger Entry";
            begin
                if "Vendor Cr. Memo No." <> '' then
                    if FindPostedDocumentWithSameExternalDocNo(VendorLedgerEntry, "Vendor Cr. Memo No.") then
                        ShowExternalDocAlreadyExistNotification(VendorLedgerEntry)
                    else
                        RecallExternalDocAlreadyExistsNotification();
            end;
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(72; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;


        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";


        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";

            trigger OnValidate()
            begin
                UpdatePurchLinesByFieldNo(FieldNo("Transaction Type"), CurrFieldNo <> 0);
            end;
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";

            trigger OnValidate()
            begin
                UpdatePurchLinesByFieldNo(FieldNo("Transport Method"), CurrFieldNo <> 0);
            end;
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(79; "Buy-from Vendor Name"; Text[100])
        {
            Caption = 'Buy-from Vendor Name';
            TableRelation = Vendor.Name;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                VendorName: Text;
            begin
                VendorName := "Buy-from Vendor Name";
                LookupBuyFromVendorName(VendorName);
                "Buy-from Vendor Name" := CopyStr(VendorName, 1, MaxStrLen("Buy-from Vendor Name"));
            end;


        }
        field(80; "Buy-from Vendor Name 2"; Text[50])
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        field(81; "Buy-from Address"; Text[100])
        {
            Caption = 'Buy-from Address';

            trigger OnValidate()
            begin
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Address"));
                ModifyVendorAddress();
            end;
        }
        field(82; "Buy-from Address 2"; Text[50])
        {
            Caption = 'Buy-from Address 2';

            trigger OnValidate()
            begin
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Address 2"));
                ModifyVendorAddress();
            end;
        }
        field(83; "Buy-from City"; Text[30])
        {
            Caption = 'Buy-from City';
            TableRelation = if ("Buy-from Country/Region Code" = const('')) "Post Code".City
            else
            if ("Buy-from Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Buy-from Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                IsHandled: boolean;
            begin
                IsHandled := false;
                //   OnBuyFromCityOnBeforeOnLookup(Rec, PostCode, IsHandled);
                if IsHandled then
                    exit;
                LookupPostCode("Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", CurrFieldNo);
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                // OnBeforeValidateBuyFromCity(Rec, PostCode, CurrFieldNo, IsHandled);
                if not IsHandled then
                    PostCode.ValidateCity(
                        "Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to City"));
                ModifyVendorAddress();
            end;
        }
        field(84; "Buy-from Contact"; Text[100])
        {
            Caption = 'Buy-from Contact';

            trigger OnLookup()
            begin
                LookupBuyFromContact();
            end;

            trigger OnValidate()
            begin
                ModifyVendorAddress();
            end;
        }
        field(85; "Pay-to Post Code"; Code[20])
        {
            Caption = 'Pay-to Post Code';
            TableRelation = if ("Pay-to Country/Region Code" = const('')) "Post Code"
            else
            if ("Pay-to Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Pay-to Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                LookupPostCode("Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", CurrFieldNo);
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //OnBeforeValidatePayToPostCode(Rec, PostCode, CurrFieldNo, IsHandled);
                if not IsHandled then
                    PostCode.ValidatePostCode(
                        "Pay-to City", "Pay-to Post Code", "Pay-to County", "Pay-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                ModifyPayToVendorAddress();
            end;
        }
        field(86; "Pay-to County"; Text[30])
        {
            CaptionClass = '5,6,' + "Pay-to Country/Region Code";
            Caption = 'Pay-to County';

            trigger OnValidate()
            begin
                ModifyPayToVendorAddress();
            end;
        }
        field(87; "Pay-to Country/Region Code"; Code[10])
        {
            Caption = 'Pay-to Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                FormatAddress: Codeunit "Format Address";
            begin
                if not FormatAddress.UseCounty(Rec."Pay-to Country/Region Code") then
                    "Pay-to County" := '';
                ModifyPayToVendorAddress();
            end;
        }
        field(88; "Buy-from Post Code"; Code[20])
        {
            Caption = 'Buy-from Post Code';
            TableRelation = if ("Buy-from Country/Region Code" = const('')) "Post Code"
            else
            if ("Buy-from Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Buy-from Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                if BuyFromPostCodeOnBeforeLookupHandled() then
                    exit;

                LookupPostCode("Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", CurrFieldNo);
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //  OnBeforeValidateBuyFromPostCode(Rec, PostCode, CurrFieldNo, IsHandled);
                if not IsHandled then
                    PostCode.ValidatePostCode(
                        "Buy-from City", "Buy-from Post Code", "Buy-from County", "Buy-from Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Post Code"));
                ModifyVendorAddress();
            end;
        }
        field(89; "Buy-from County"; Text[30])
        {
            CaptionClass = '5,5,' + "Buy-from Country/Region Code";
            Caption = 'Buy-from County';

            trigger OnValidate()
            begin
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to County"));
                ModifyVendorAddress();
            end;
        }
        field(90; "Buy-from Country/Region Code"; Code[10])
        {
            Caption = 'Buy-from Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                FormatAddress: Codeunit "Format Address";
            begin
                if not FormatAddress.UseCounty(Rec."Buy-from Country/Region Code") then
                    "Buy-from County" := '';
                UpdatePayToAddressFromBuyFromAddress(FieldNo("Pay-to Country/Region Code"));
                ModifyVendorAddress();
            end;
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = if ("Ship-to Country/Region Code" = const('')) "Post Code"
            else
            if ("Ship-to Country/Region Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Ship-to Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //  OnShipToPostCodeOnBeforeOnLookup(Rec, IsHandled, PostCode);
                if IsHandled then
                    exit;

                LookupPostCode("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", CurrFieldNo);
            end;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //   OnBeforeValidateShipToPostCode(Rec, PostCode, CurrFieldNo, IsHandled);
                if not IsHandled then
                    PostCode.ValidatePostCode(
                        "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(92; "Ship-to County"; Text[30])
        {
            CaptionClass = '5,4,' + "Ship-to Country/Region Code";
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; enum "Payment Balance Account Type")
        {
            Caption = 'Bal. Account Type';
        }
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code where("Vendor No." = field("Buy-from Vendor No."));

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                if "Order Address Code" <> '' then
                    CopyAddressInfoFromOrderAddress()
                else begin
                    GetVend("Buy-from Vendor No.");
                    IsHandled := false;
                    // OnValidateOrderAddressCodeOnBeforeCopyBuyFromVendorAddressFieldsFromVendor(Rec, Vend, IsHandled);
                    if not IsHandled then begin
                        "Buy-from Vendor Name" := Vend.Name;
                        "Buy-from Vendor Name 2" := Vend."Name 2";
                        CopyBuyFromVendorAddressFieldsFromVendor(Vend, true);
                    end;

                    // OnValidateOrderAddressCodeOnAfterCopyBuyFromVendorAddressFieldsFromVendor(Rec, Vend);

                    if IsCreditDocType() then begin
                        "Ship-to Name" := Vend.Name;
                        "Ship-to Name 2" := Vend."Name 2";
                        CopyShipToVendorAddressFieldsFromVendor(Vend, true);
                        "Ship-to Contact" := Vend.Contact;
                        "Shipment Method Code" := Vend."Shipment Method Code";
                        IsHandled := false;
                        // OnValidateOrderAddressCodeOnBeforeUpdateLocationCode(Rec, xRec, CurrFieldNo, IsHandled);
                        if not IsHandled then
                            if Vend."Location Code" <> '' then
                                Validate("Location Code", Vend."Location Code");
                    end
                end;
            end;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
            TableRelation = "Entry/Exit Point";

            trigger OnValidate()
            begin
                UpdatePurchLinesByFieldNo(FieldNo("Entry Point"), CurrFieldNo <> 0);
            end;
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';

            trigger OnValidate()
            begin
                GLSetup.Get();
                GLSetup.UpdateVATDate("Document Date", Enum::"VAT Reporting Date"::"Document Date", "VAT Reporting Date");
                Validate("VAT Reporting Date");

                if (xRec."Document Date" <> "Document Date") or ReplaceDocumentDate then
                    UpdateDocumentDate := true;
                Validate("Payment Terms Code");
                Validate("Prepmt. Payment Terms Code");
            end;
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;

            trigger OnValidate()
            begin
                UpdatePurchLinesByFieldNo(FieldNo(Area), CurrFieldNo <> 0);
            end;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";

            trigger OnValidate()
            begin
                UpdatePurchLinesByFieldNo(FieldNo("Transaction Specification"), CurrFieldNo <> 0);
            end;
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            begin
                PaymentMethod.Init();
                if "Payment Method Code" <> '' then
                    PaymentMethod.Get("Payment Method Code");
                "Bal. Account Type" := PaymentMethod."Bal. Account Type";
                "Bal. Account No." := PaymentMethod."Bal. Account No.";
                if "Bal. Account No." <> '' then begin
                    TestField("Applies-to Doc. No.", '');
                    TestField("Applies-to ID", '');
                end;
            end;
        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";



            trigger OnValidate()
            begin
                if "Posting No. Series" <> '' then begin
                    GetPurchSetup();
                    TestNoSeries();
                    NoSeries.TestAreRelated(GetPostingNoSeriesCode(), "Posting No. Series");
                end;
                TestField("Posting No.", '');
            end;
        }
        field(109; "Receiving No. Series"; Code[20])
        {
            Caption = 'Receiving No. Series';
            TableRelation = "No. Series";




        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";

            trigger OnValidate()
            begin
                TestStatusOpen();
                MessageIfPurchLinesExist(FieldCaption("Tax Area Code"));
            end;
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';

            trigger OnValidate()
            begin
                TestStatusOpen();
                MessageIfPurchLinesExist(FieldCaption("Tax Liable"));
            end;
        }
        field(116; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";

            trigger OnValidate()
            begin
                TestStatusOpen();
                if (xRec."Buy-from Vendor No." = "Buy-from Vendor No.") and
                   (xRec."VAT Bus. Posting Group" <> "VAT Bus. Posting Group")
                then
                    RecreatePurchLines(FieldCaption("VAT Bus. Posting Group"));
            end;
        }
        field(118; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';

            trigger OnValidate()
            var
                TempVendLedgEntry: Record "Vendor Ledger Entry" temporary;
                VendEntrySetApplID: Codeunit "Vend. Entry-SetAppl.ID";
            begin
                if "Applies-to ID" <> '' then
                    TestField("Bal. Account No.", '');
                if ("Applies-to ID" <> xRec."Applies-to ID") and (xRec."Applies-to ID" <> '') then begin
                    VendLedgEntry.SetCurrentKey("Vendor No.", Open);
                    VendLedgEntry.SetRange("Vendor No.", "Pay-to Vendor No.");
                    VendLedgEntry.SetRange(Open, true);
                    VendLedgEntry.SetRange("Applies-to ID", xRec."Applies-to ID");
                    if VendLedgEntry.FindFirst() then
                        VendEntrySetApplID.SetApplId(VendLedgEntry, TempVendLedgEntry, '');
                    VendLedgEntry.Reset();
                end;
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                GLSetup.Get();
                if "VAT Base Discount %" > GLSetup."VAT Tolerance %" then begin
                    if GetHideValidationDialog() or not GuiAllowed then
                        Confirmed := true
                    else
                        Confirmed :=
                          Confirm(
                            Text007 +
                            Text008, false,
                            FieldCaption("VAT Base Discount %"),
                            GLSetup.FieldCaption("VAT Tolerance %"),
                            GLSetup.TableCaption());
                    if not Confirmed then
                        "VAT Base Discount %" := xRec."VAT Base Discount %";
                end;

                if ("VAT Base Discount %" = xRec."VAT Base Discount %") and (CurrFieldNo <> 0) then
                    exit;

                IsHandled := false;
                //   OnValidateVATBaseAmountPercOnBeforeUpdatePurchAmountLines(Rec, xRec, CurrFieldNo, IsHandled);
                if not IsHandled then
                    UpdatePurchAmountLines();
            end;
        }
        field(120; Status; Enum "Purchase Document Status")
        {
            Caption = 'Status';
            Editable = true;
        }
        field(121; "Invoice Discount Calculation"; Enum "Dys Invoice Disc Calculation")
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            // OptionCaption = 'None,%,Amount';
            // OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                // OnBeforeValidateSendICDocument(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "Send IC Document" then begin
                    TestField("Buy-from IC Partner Code");
                    TestField("IC Direction", "IC Direction"::Outgoing);
                end;
            end;
        }
        field(124; "IC Status"; Enum "Purchase Document IC Status")
        {
            Caption = 'IC Status';
        }
        field(125; "Buy-from IC Partner Code"; Code[20])
        {
            Caption = 'Buy-from IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(126; "Pay-to IC Partner Code"; Code[20])
        {
            Caption = 'Pay-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(127; "IC Reference Document No."; Code[20])
        {
            Caption = 'IC Reference Document No.';
            Editable = false;
        }
        field(129; "IC Direction"; Enum "IC Direction Type")
        {
            Caption = 'IC Direction';

            trigger OnValidate()
            begin
                if "IC Direction" = "IC Direction"::Incoming then
                    "Send IC Document" := false;
            end;
        }
        field(130; "Prepayment No."; Code[20])
        {
            Caption = 'Prepayment No.';
        }
        field(131; "Last Prepayment No."; Code[20])
        {
            Caption = 'Last Prepayment No.';
            TableRelation = "Purch. Inv. Header";
        }
        field(132; "Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No.';
        }
        field(133; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Purch. Cr. Memo Hdr.";
        }
        field(134; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Prepayment %" > 100 then
                    error(MaxAllowedValueIs100Err);
                if xRec."Prepayment %" <> "Prepayment %" then
                    UpdatePurchLinesByFieldNo(FieldNo("Prepayment %"), CurrFieldNo <> 0);
            end;
        }
        field(135; "Prepayment No. Series"; Code[20])
        {
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";


            trigger OnValidate()
            begin
                if "Prepayment No. Series" <> '' then begin
                    GetPurchSetup();
                    PurchSetup.TestField("Posted Prepmt. Inv. Nos.");
                    NoSeries.TestAreRelated(GetPostingPrepaymentNoSeriesCode(), "Prepayment No. Series");
                end;
                TestField("Prepayment No.", '');
            end;
        }
        field(136; "Compress Prepayment"; Boolean)
        {
            Caption = 'Compress Prepayment';
            InitValue = true;
        }
        field(137; "Prepayment Due Date"; Date)
        {
            Caption = 'Prepayment Due Date';
        }
        field(138; "Prepmt. Cr. Memo No. Series"; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";



            trigger OnValidate()
            begin
                if "Prepmt. Cr. Memo No. Series" <> '' then begin
                    GetPurchSetup();
                    PurchSetup.TestField("Posted Prepmt. Cr. Memo Nos.");
                    NoSeries.TestAreRelated(GetPostingPrepaymentNoSeriesCode(), "Prepmt. Cr. Memo No. Series");
                end;
                TestField("Prepmt. Cr. Memo No.", '');
            end;
        }
        field(139; "Prepmt. Posting Description"; Text[100])
        {
            Caption = 'Prepmt. Posting Description';
        }
        field(142; "Prepmt. Pmt. Discount Date"; Date)
        {
            Caption = 'Prepmt. Pmt. Discount Date';
        }
        field(143; "Prepmt. Payment Terms Code"; Code[10])
        {
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate()
            var
                PaymentTerms: Record "Payment Terms";
                IsHandled: Boolean;
            begin
                if ("Prepmt. Payment Terms Code" <> '') and ("Document Date" <> 0D) then begin
                    PaymentTerms.Get("Prepmt. Payment Terms Code");
                    if IsCreditDocType() and not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" then begin
                        IsHandled := false;
                        // OnValidatePrepmtPaymentTermsCodeOnCaseIfOnBeforeValidatePrepaymentDueDate(Rec, xRec, CurrFieldNo, IsHandled);
                        if not IsHandled then
                            Validate("Prepayment Due Date", "Document Date");
                        Validate("Prepmt. Pmt. Discount Date", 0D);
                        Validate("Prepmt. Payment Discount %", 0);
                    end else begin
                        IsHandled := false;
                        // OnValidatePaymentTermsCodeOnBeforeCalcDueDate(Rec, xRec, FieldNo("Prepmt. Payment Terms Code"), CurrFieldNo, IsHandled);
                        if not IsHandled then
                            "Prepayment Due Date" := CalcDate(PaymentTerms."Due Date Calculation", "Document Date");
                        IsHandled := false;
                        //  OnValidatePaymentTermsCodeOnBeforeCalcPmtDiscDate(Rec, xRec, FieldNo("Prepmt. Payment Terms Code"), CurrFieldNo, IsHandled, UpdateDocumentDate);
                        if not IsHandled then
                            "Prepmt. Pmt. Discount Date" := CalcDate(PaymentTerms."Discount Date Calculation", "Document Date");
                        if not UpdateDocumentDate then
                            Validate("Prepmt. Payment Discount %", PaymentTerms."Discount %")
                    end;
                end else begin
                    IsHandled := false;
                    // OnValidatePrepmtPaymentTermsCodeOnCaseElseOnBeforeValidatePrepaymentDueDate(Rec, xRec, CurrFieldNo, IsHandled);
                    if not IsHandled then
                        Validate("Prepayment Due Date", "Document Date");
                    if not UpdateDocumentDate then begin
                        Validate("Prepmt. Pmt. Discount Date", 0D);
                        Validate("Prepmt. Payment Discount %", 0);
                    end;
                end;
            end;
        }
        field(144; "Prepmt. Payment Discount %"; Decimal)
        {
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                // OnBeforeValidatePrepmtPaymentDiscountPercent(Rec, xRec, CurrFieldNo, IsHandled);
                if IsHandled then
                    exit;

                if not (CurrFieldNo in [0, FieldNo("Posting Date"), FieldNo("Document Date")]) then
                    TestStatusOpen();
                GLSetup.Get();
                if "Payment Discount %" < GLSetup."VAT Tolerance %" then
                    "VAT Base Discount %" := "Payment Discount %"
                else
                    "VAT Base Discount %" := GLSetup."VAT Tolerance %";
                Validate("VAT Base Discount %");
            end;
        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
        }
        field(160; "Job Queue Status"; Enum "Document Job Queue Status")
        {
            Caption = 'Job Queue Status';
            Editable = false;

            trigger OnLookup()
            var
                JobQueueEntry: Record "Job Queue Entry";
            begin
                if Rec."Job Queue Status" = Rec."Job Queue Status"::" " then
                    exit;
                JobQueueEntry.ShowStatusMsg(Rec."Job Queue Entry ID");
            end;
        }
        field(161; "Job Queue Entry ID"; Guid)
        {
            Caption = 'Job Queue Entry ID';
            Editable = false;
        }
        field(165; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            TableRelation = "Incoming Document";


        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.';
        }
        field(171; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
        }
        field(175; "Invoice Received Date"; Date)
        {
            Caption = 'Invoice Received Date';

        }
        field(178; "Journal Templ. Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template" where(Type = filter(Purchases));

            trigger OnValidate()
            begin
                PurchSetup.Get();
                TestNoSeries();
                Validate("Posting No. Series", GenJournalTemplate."Posting No. Series");
            end;
        }
        field(179; "VAT Reporting Date"; Date)
        {
            Caption = 'VAT Date';
            Editable = false;

            trigger OnValidate()
            begin
                if "VAT Reporting Date" = 0D then
                    InitVATDate();
            end;
        }
        field(300; "A. Rcd. Not Inv. Ex. VAT (LCY)"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."A. Rcd. Not Inv. Ex. VAT (LCY)" where("Document Type" = field("Document Type"),
                                                                                      "Document No." = field("No.")));
            Caption = 'Amount Received Not Invoiced (LCY)';
            FieldClass = FlowField;
        }
        field(301; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" where("Document Type" = field("Document Type"),
                                                                                    "Document No." = field("No.")));
            Caption = 'Amount Received Not Invoiced (LCY) Incl. VAT';
            FieldClass = FlowField;
        }
        field(302; "External Document No."; Code[50])
        {

            Caption = 'N° doc. externe';

        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                Rec.ShowDocDim();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(1000; "Remit-to Code"; Code[20])
        {
            Caption = 'Remit-to Code';
            TableRelation = "Remit Address".Code where("Vendor No." = field("Buy-from Vendor No."));
        }
        field(1305; "Invoice Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Inv. Discount Amount" where("Document No." = field("No."),
                                                                            "Document Type" = field("Document Type")));
            Caption = 'Invoice Discount Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = max("Purchase Header Archive"."Version No." where("Document Type" = field("Document Type"),
                                                                             "No." = field("No."),
                                                                             "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;

            trigger OnValidate()
            begin
                UpdatePurchLinesByFieldNo(FieldNo("Campaign No."), CurrFieldNo <> 0);
                CreateDimFromDefaultDim(Rec.FieldNo("Campaign No."));
            end;
        }
        field(5052; "Buy-from Contact No."; Code[20])
        {
            Caption = 'Buy-from Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            begin
                BuyfromContactLookup();
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                TestStatusOpen();

                if "Buy-from Contact No." <> '' then
                    if Cont.Get("Buy-from Contact No.") then
                        Cont.CheckIfPrivacyBlockedGeneric();

                if ("Buy-from Contact No." <> xRec."Buy-from Contact No.") and
                   (xRec."Buy-from Contact No." <> '')
                then
                    if ConfirmUpdateField(FieldNo("Buy-from Contact No.")) then begin
                        if InitFromContact("Buy-from Contact No.", "Buy-from Vendor No.", FieldCaption("Buy-from Contact No.")) then
                            exit
                    end else begin
                        Rec := xRec;
                        exit;
                    end;

                if ("Buy-from Vendor No." <> '') and ("Buy-from Contact No." <> '') then
                    CheckContactRelatedToVendorCompany("Buy-from Contact No.", "Buy-from Vendor No.", FieldNo("Buy-from Contact No."));

                if ("Buy-from Contact No." <> xRec."Buy-from Contact No.") then
                    UpdateBuyFromVend("Buy-from Contact No.");
            end;
        }
        field(5053; "Pay-to Contact No."; Code[20])
        {
            Caption = 'Pay-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //   OnBeforeLookupPayToContactNo(Rec, xRec, IsHandled);
                if IsHandled then
                    exit;

                if "Pay-to Vendor No." <> '' then
                    if Cont.Get("Pay-to Contact No.") then
                        Cont.SetRange("Company No.", Cont."Company No.")
                    else
                        if ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Vendor, "Pay-to Vendor No.") then
                            Cont.SetRange("Company No.", ContBusinessRelation."Contact No.")
                        else
                            Cont.SetRange("No.", '');

                if "Pay-to Contact No." <> '' then
                    if Cont.Get("Pay-to Contact No.") then;
                if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
                    xRec := Rec;
                    Validate("Pay-to Contact No.", Cont."No.");
                end;
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                TestStatusOpen();

                if "Pay-to Contact No." <> '' then
                    if Cont.Get("Pay-to Contact No.") then
                        Cont.CheckIfPrivacyBlockedGeneric();

                if ("Pay-to Contact No." <> xRec."Pay-to Contact No.") and
                   (xRec."Pay-to Contact No." <> '')
                then
                    if ConfirmUpdateField(FieldNo("Pay-to Contact No.")) then begin
                        if InitFromContact("Pay-to Contact No.", "Pay-to Vendor No.", FieldCaption("Pay-to Contact No.")) then
                            exit
                    end else begin
                        "Pay-to Contact No." := xRec."Pay-to Contact No.";
                        exit;
                    end;

                if ("Pay-to Vendor No." <> '') and ("Pay-to Contact No." <> '') then
                    Cont.Get("Pay-to Contact No.");

                CheckContactRelatedToVendorCompany("Pay-to Contact No.", "Pay-to Vendor No.", FieldNo("Pay-to Contact No."));

                UpdatePayToVend("Pay-to Contact No.");
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            begin
                TestStatusOpen();
                if not UserSetupMgt.CheckRespCenter(1, "Responsibility Center") then
                    Error(
                      Text028,
                      RespCenter.TableCaption(), UserSetupMgt.GetPurchasesFilter());

                UpdateLocationCode('');
                UpdateInboundWhseHandlingTime();

                UpdateShipToAddress();

                CreateDimFromDefaultDim(Rec.FieldNo("Responsibility Center"));

                if xRec."Responsibility Center" <> "Responsibility Center" then begin
                    RecreatePurchLines(FieldCaption("Responsibility Center"));
                    "Assigned User ID" := '';
                end;
            end;
        }
        field(5751; "Partially Invoiced"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No."),
                                                       Type = filter(<> " "),
                                                       "Location Code" = field("Location Filter"),
                                                       "Quantity Invoiced" = filter(<> 0)));
            Caption = 'Partially Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Received"; Boolean)
        {
            CalcFormula = min("Purchase Line"."Completely Received" where("Document Type" = field("Document Type"),
                                                                           "Document No." = field("No."),
                                                                           Type = filter(<> " "),
                                                                           "Location Code" = field("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Posting from Whse. Ref.';
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(5755; "Received Not Invoiced"; Boolean)
        {
            CalcFormula = min("Purchase Line"."Completely Received" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No."),
                                                       Type = filter(<> " "),
                                                       "Location Code" = field("Location Filter"),
                                                       "Quantity Invoiced" = filter(= 0)));
            Caption = 'Received Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //  OnBeforeValidateRequestedReceiptDate(Rec, xRec, CurrFieldNo, IsHandled);
                if IsHandled then
                    exit;

                if "Promised Receipt Date" <> 0D then
                    Error(
                      Text034,
                      FieldCaption("Requested Receipt Date"),
                      FieldCaption("Promised Receipt Date"));

                if "Requested Receipt Date" <> xRec."Requested Receipt Date" then
                    UpdatePurchLinesByFieldNo(FieldNo("Requested Receipt Date"), CurrFieldNo <> 0);
            end;
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';

            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //   OnBeforeValidatePromisedReceiptDate(Rec, xRec, IsHandled, CurrFieldNo);
                if IsHandled then
                    exit;

                TestStatusOpen();
                if "Promised Receipt Date" <> xRec."Promised Receipt Date" then
                    UpdatePurchLinesByFieldNo(FieldNo("Promised Receipt Date"), CurrFieldNo <> 0);
            end;
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Lead Time Calculation';

            trigger OnValidate()
            begin
                LeadTimeMgt.CheckLeadTimeIsNotNegative("Lead Time Calculation");

                if "Lead Time Calculation" <> xRec."Lead Time Calculation" then
                    UpdatePurchLinesByFieldNo(FieldNo("Lead Time Calculation"), CurrFieldNo <> 0);
            end;
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Inbound Whse. Handling Time';

            trigger OnValidate()
            begin
                if "Inbound Whse. Handling Time" <> xRec."Inbound Whse. Handling Time" then
                    UpdatePurchLinesByFieldNo(FieldNo("Inbound Whse. Handling Time"), CurrFieldNo <> 0);
            end;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; "Vendor Authorization No."; Code[35])
        {
            Caption = 'Vendor Authorization No.';
        }
        field(5801; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
        }
        field(5802; "Return Shipment No. Series"; Code[20])
        {
            Caption = 'Return Shipment No. Series';
            TableRelation = "No. Series";



            trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                //  OnBeforeValidateReturnShipmentNoSeries(Rec, IsHandled);
                if IsHandled then
                    exit;

                if "Return Shipment No. Series" <> '' then begin
                    GetPurchSetup();
                    PurchSetup.TestField("Posted Return Shpt. Nos.");
                    NoSeries.TestAreRelated(PurchSetup."Posted Return Shpt. Nos.", "Return Shipment No. Series");
                end;
                TestField("Return Shipment No.", '');
            end;
        }
        field(5803; Ship; Boolean)
        {
            Caption = 'Ship';
        }
        field(5804; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            Editable = false;
            TableRelation = "Return Shipment Header";
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
            ObsoleteState = Removed;
            ObsoleteReason = 'This functionality will be replaced by the systemID field';
            ObsoleteTag = '22.0';
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                if not UserSetupMgt.CheckRespCenter(1, "Responsibility Center", "Assigned User ID") then
                    Error(
                      Text049, "Assigned User ID",
                      RespCenter.TableCaption(), UserSetupMgt.GetPurchasesFilter("Assigned User ID"));
            end;
        }
        field(9001; "Pending Approvals"; Integer)
        {
            CalcFormula = count("Approval Entry" where("Table ID" = const(38),
                                                        "Document Type" = field("Document Type"),
                                                        "Document No." = field("No."),
                                                        Status = filter(Open | Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(50200; "Supplier Eval Criteria"; Enum "Dys Supplier Eval Criteria")
        {
            Caption = 'Supplier Eval Criteria';

            // OptionCaption = 'Price,Delai,Note';
            // OptionMembers = Price,Delai,Note;
        }
        field(50201; "Requester ID"; Text[30])
        {
            Caption = 'Requester ID';
            Description = '// DDE D''APPRO';
            Editable = true;
            TableRelation = Demandeur."Nom Et Prenom";

            trigger OnLookup()
            begin
                if Page.RunModal(page::"Liste Utilisateurs", Demandeur) = Action::LookupOK then "Requester ID" := Demandeur."Nom Et Prenom";
            end;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;


        }
        field(50202; Service; Enum "Dys Service")
        {
            Caption = 'Service';
            //OptionMembers = " ","Parc Z4","Direction Gen","Dir Audit","Dir Cpt Et Admin","Dir Financiere","Controle Et Gestion",Appro,Secreteriat,BaseVie;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(50203; "Request Type"; Enum "Dys Request Type")
        {
            Caption = 'Request Type';
            Description = '// DDE D''APPRO';
            // OptionCaption = 'Spare part,Materials,Supply and Miscellaneous,Service Delivery';
            // OptionMembers = "Spare part",Materials,"Supply and Miscellaneous","Service Delivery";
        }
        field(50204; Synchronize; Boolean)
        {
            Caption = 'Synchronize';
        }
        field(50205; Observation; Text[250])
        {
            Caption = 'Observation';
        }
        field(50206; "Apply Stamp fiscal"; Boolean)
        {
            Caption = 'Apply Stamp fiscal';

            InitValue = false;
        }
        field(50215; approver; Code[10])
        {
            Caption = 'approver';
        }
        field(50216; "Approval date"; Date)
        {
            Caption = 'Approval date';
        }
        field(50217; "Statut"; Enum "Dys Purchase Request status")
        {
            Caption = 'Status';
            // OptionCaption = 'Pending,accepted,refused';
            // OptionMembers = Ouvert,"Lancé","Partiellement Pris En Charge","Totallement Pris En Charge",Archiver;

        }
        field(50218; Approve; Boolean)
        {
            Caption = 'Approve';



        }
        field(50219; Engin; Code[20])
        {
            Caption = 'Engin';
            TableRelation = "Véhicule";

            trigger OnValidate()
            begin
                if Véhicule.Get(Engin) then begin
                    "Description Engin" := CopyStr(Véhicule."Désignation", 1, 50);
                    "Serial No." := Véhicule."No. Series";
                    Type := Véhicule.Marque;
                    "Sous Famille Engin" := Véhicule."Sous Famille";
                end;
            end;

        }
        field(50514; "Sous Famille Engin"; Code[100])
        {
            //Caption = 'Type';
        }
        field(50220; Type; Code[20])
        {
            Caption = 'Type';
        }
        field(50221; "Serial No."; Code[30])
        {
            Caption = 'Serial No.';
            Description = 'HJ DSFT 15-02-2013';
        }
        field(50222; "Description Engin"; Text[100])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(50223; "received"; Boolean)
        {
            Caption = 'received';
            FieldClass = FlowField;
            CalcFormula = exist("Purch. Rcpt. Line" where("Purchase Request No." = field("No.")));
            Editable = false;

        }
        field(50224; "Associated Purchase Order"; Code[20])
        {
            // CalcFormula = lookup("Purchase Header"."No." where("Purchase Request No." = field("No."),
            //                                                     "Document Type" = const(Order)));
            CalcFormula = lookup("Purchase Header"."No." where("N° Demande d'achat" = field("No."),
                                                                "Document Type" = const(Order)));

            Editable = false;
            FieldClass = FlowField;
        }
        field(50225; "PR Approved"; Boolean)
        {
            Caption = 'PR Approved';
        }
        field(50226; "PR approver"; Code[50])
        {
            Caption = 'PR approver';
        }
        field(50227; "Internal Order"; Boolean)
        {
            Caption = 'Internal Order';

        }
        field(50228; Marche; Boolean)
        {

        }
        field(50229; "Delay Days"; Integer)
        {
            Caption = 'Delay Days';
        }
        field(50230; "Business Order"; Boolean)
        {
            Caption = 'Business Order';
        }
        field(50231; "Type Commande"; Enum "Dys document type")
        {
            Caption = 'Document type';

            // OptionMembers = " ",Concrete,Carriere;
        }
        field(50232; "Coefficient Regulation"; Decimal)
        {
            Caption = 'Coefficient Regulation';
            DecimalPlaces = 2 : 5;
        }
        field(50233; "Construction site"; Boolean)
        {
            Caption = 'Construction site';

        }
        field(50234; "Order Date Service"; Date)
        {
            Caption = 'Order Date Service';
        }
        field(50235; "Nbre Mois Marché"; Integer)
        {
            Description = 'MH SORO 05-01-2018';
        }
        field(50236; "End of Work Date"; Date)
        {
            Caption = 'End of Work Date';
        }
        field(50237; Production; Boolean)
        {
        }
        field(50238; "Delai Suspension"; Decimal)
        {
            Caption = 'Delai Suspension';
        }
        field(50239; "Notification mode"; Enum "Dys Notification mode")
        {
            Caption = 'Notification mode';
            // OptionMembers = Normal,Mail;
        }
        field(50240; "Refusal Reason"; Enum "Dys Refusal Reason")
        {
            Caption = 'Refusal Reason';
            //  OptionMembers = " ","Overrun Forecast","Exaggerated quantity","Blocked advance";
        }
        field(50241; Time; Time)
        {
            Caption = 'Time';

        }
        field(50244; Destination; Text[30])
        {
            Caption = 'Destination';
        }
        field(50045; "Pompage Béton"; Boolean)
        {
            Caption = 'Concrete pumping';
        }
        field(50246; "Pump number"; Code[10])
        {
            Caption = 'Pump number';
        }
        field(50247; "DG Approval"; Boolean)
        {
            Caption = 'DG Approval';
        }
        field(50248; "Date DG Approval"; Date)
        {
            Caption = 'Date DG Approval';
        }
        field(50249; "Concrete formula"; Code[20])
        {
            Caption = 'Concrete formula';
        }
        field(50250; Close; Boolean)
        {
            Caption = 'Close';

        }
        field(50999; "Num Sequence Syncro"; Integer)
        {
            Caption = 'Num Sequence Syncro';
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(70001; "Alert Imminent"; Boolean)
        {
            Caption = 'Alert Imminent';
        }
        field(70002; "disabled Alert Imminent"; Boolean)
        {
            Caption = 'Disabled Alert Imminent';
        }
        field(70003; "Imminent Alert Triggered"; Boolean)
        {
            Caption = 'Imminent Alert Triggered';
        }
        field(70004; "Date Debut Decompte"; Date)
        {
            Description = 'HJ SORO 22-06-2017';
        }
        field(70005; "Date Fin Decompte"; Date)
        {
            Description = 'HJ SORO 22-06-2017';
        }
        field(70006; "sales department"; Enum "Dys sales department")
        {
            Caption = 'sales department';
            // OptionCaption = ' ,Concrete Service,Enrobe Service';
            // OptionMembers = " ","Concrete Service","Enrobe Service";
        }
        field(70007; "Force % VAT"; Integer)
        {
            Caption = 'Force % VAT';

        }
        field(82750; "Mask Code"; Code[1])
        {
            Caption = 'Mask Code';

        }
        field(50051; "Criteria 1"; Code[1])
        {

            Caption = 'Criteria 1';

        }
        field(50052; "Criteria 2"; Code[1])
        {
            Caption = 'Criteria 2';
        }
        field(50053; "Criteria 3"; Code[1])
        {
            Caption = 'Criteria 3';
        }
        field(50054; "Criteria 4"; Code[1])
        {
            Caption = 'Criteria 4';
        }
        field(50055; "Criteria 5"; Code[1])
        {
            CaptionClass = '8001400,1,8001302,99094';
            Caption = 'Criteria 5';

        }
        field(50056; "Criteria 6"; Code[1])
        {
            CaptionClass = '8001400,1,8001302,99095';
            Caption = 'Criteria 6';

        }
        field(50057; "Criteria 7"; Code[1])
        {
            CaptionClass = '8001400,1,8001302,99096';
            Caption = 'Criteria 7';

        }
        field(50058; "Criteria 8"; Code[1])
        {
            CaptionClass = '8001400,1,8001302,99097';
            Caption = 'Criteria 8';

        }
        field(50049; "Criteria 9"; Code[1])
        {
            CaptionClass = '8001400,1,8001302,99098';
            Caption = 'Criteria 9';

        }
        field(50060; "Criteria 10"; Code[1])
        {
            CaptionClass = '8001400,1,8001302,99099';
            Caption = 'Criteria 10';

        }
        /* field(50061; "Financial Document"; Boolean)
         {
             Caption = 'Financial Document';
         }*/
        field(50062; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = true;
            NotBlank = true;
            TableRelation = User."Full Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;


        }
        field(50063; "Doc. Creation Date"; Date)
        {
            Caption = 'Doc. Creation Date';
            Editable = false;
        }
        field(50064; "Source Quote No."; Code[20])
        {
            Caption = 'Source Quote No.';
        }
        field(50865; "Close Opportunity Code"; Code[1])
        {
            Caption = 'Close Opportunity Code';
            TableRelation = "Close Opportunity Code".Code;

        }
        field(50066; "Header comments"; Boolean)
        {
            Caption = 'Header comments';
        }
        field(50067; "Footer comments"; Boolean)
        {
            Caption = 'Footer comments';
        }
        field(50068; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';


        }
        field(50069; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';

        }
        field(50070; "Next Invoice Calculation"; DateFormula)
        {
            Caption = 'Next Invoice Calculation';

        }
        field(50071; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
            Editable = false;
        }
        field(50072; "Invoicing Periodicity Code"; Code[1])
        {
            Caption = 'Invoicing Periodicity Code';

        }
        field(50073; "Review Formula Code"; Code[1])
        {
            Caption = 'Price Index Code';

        }
        field(50074; "Review Base Date"; Date)
        {
            Caption = 'Index Basis Date';


        }
        field(50075; "No. Prepayment Invoiced"; Integer)
        {
            Caption = 'No. Prepayment Invoiced';


        }
        field(50076; "Scheduler Origin"; Boolean)
        {
            Caption = 'Scheduler Origin';
            Editable = false;
        }
        field(50077; "Order Type"; Enum "Dys order type")
        {
            Caption = 'Order Type';
            // OptionCaption = ' ,Supply Order,Transfer';
            // OptionMembers = " ","Supply Order",Transfer;


        }
        field(50078; "Rider to Order No."; Code[20])
        {
            Caption = 'Rider No.';

            //This property is currently not supported
            //TestTableRelation = false;

        }
        field(50079; Subject; Text[2])
        {
            Caption = 'Object';


        }
        field(50080; "Invoicing Method"; Enum "Dys invoicing method")
        {
            Caption = 'Invoicing Method';
            // OptionCaption = 'Direct,Scheduler,Completion';
            // OptionMembers = Direct,Scheduler,Completion;


        }
        field(50081; "Recognition Method"; Enum "Dys Recognition Method")
        {
            Caption = 'Recognition Method';
            // OptionCaption = 'Percentage of Completion,Completed Contract';
            // OptionMembers = "Percentage of Completion","Completed Contract";
        }
        field(50082; "Person Responsible"; Code[1])
        {

            Caption = 'Person Responsible';



        }
        field(50083; "Project Manager"; Code[1])
        {
            Caption = 'Project Manager';
            TableRelation = Contact;

        }
        field(50084; "Amount Excl. VAT (LCY)"; Decimal)
        {
            Caption = 'Amount Excl. VAT (LCY)';
        }
        field(50085; "Ship-to Phone No."; Text[1])
        {
            Caption = 'Ship-to Phone No.';
        }
        field(50086; "Ship-to Fax No."; Text[1])
        {
            Caption = 'Ship-to Fax No.';
        }
        field(50087; "Source Quote Occurence No."; Integer)
        {
            Caption = 'Source Quote Occurence No.';
        }
        field(50088; "Source Quote Version No."; Integer)
        {
            Caption = 'Source Quote Version No.';
        }
        field(50089; "Sell-to Contact Company No."; Code[20])
        {
            Caption = 'Sell-to Contact Company No.';
            TableRelation = Contact where(Type = const(Company));


        }
        field(50090; "Ship-to Contact No."; Code[20])
        {
            Caption = 'Ship-to Contact No.';
            TableRelation = Contact;



        }
        field(50091; "Job Description"; Text[50])
        {
            Caption = 'Job Description';
            Editable = false;

        }
        field(50092; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'Modification TableRelation';
            TableRelation = Job;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                RecJob: Record Job;
                RecPrLine: Record "Purchase request Line";
                RecLocation: Record Location;
                txt01: label 'Affaire non associé à aucune magasin, Contacter votre Administrateur Pour affecter l''affaire %1 à une magasin';

            begin
                if Rec."Job No." <> xRec."Job No." then begin
                    //GL2024   modfication selon logique soroubat
                    /*  if RecLocation.Get(Rec."Job No.") then
                          Rec.Validate("Location Code", RecLocation.Code);
                      RecPrLine.Reset();
                      RecPrLine.SetRange("Document No.", Rec."No.");
                      if RecPrLine.FindSet() then begin
                          RecPrLine.ModifyAll("Job No.", Rec."Job No.");
                          RecPrLine.ModifyAll("Job Task No.", '');
                          RecPrLine.ModifyAll("Job Planning Line No.", 0);
                          //    RecPrLine.ModifyAll("Location Code", Rec."Location Code");
                      end;*/
                    // RB SORO 14/05/2015 LOCATION CODE WITH JOB N°
                    RecJob.Reset;
                    if RecJob.Get("Job No.") then;
                    if RecJob."Affectation Magasin" <> '' then
                        Validate("Location Code", RecJob."Affectation Magasin")
                    else
                        Message(txt01, "Job No.");
                    // RB SORO 14/05/2015 LOCATION CODE WITH JOB N°
                    RecPrLine.Reset();
                    RecPrLine.SetRange("Document No.", Rec."No.");
                    if RecPrLine.FindSet() then begin
                        RecPrLine.ModifyAll("Job No.", Rec."Job No.");
                        RecPrLine.ModifyAll("Job Task No.", '');
                        RecPrLine.ModifyAll("Job Planning Line No.", 0);
                        //    RecPrLine.ModifyAll("Location Code", Rec."Location Code");
                    end;

                end;

                if RecJob.Get(Rec."Job No.") then
                    rec."Job Description" := RecJob.Description
                else
                    RecJob.Description := '';

            end;

        }
        field(50093; "Part Payment"; Decimal)
        {
            Caption = 'Part Payment';
        }
        field(50094; "Contract Type"; Code[10])
        {
            Caption = 'Contract Type';


        }
        field(50095; Finished; Boolean)
        {
            Caption = 'Finished';
        }
        field(50096; "Person Responsible 2"; Code[1])
        {
            Caption = 'Person Responsible 2';

        }
        field(50097; "Person Responsible 3"; Code[1])
        {

            Caption = 'Person Responsible 3,';




        }
        field(50098; "Person Responsible 4"; Code[1])
        {
            Caption = 'Person Responsible 4';

        }
        field(50100; "Person Responsible 5"; Code[1])
        {
            Caption = 'Person Responsible 5';
        }
        field(50101; "Free Date 1"; Date)
        {
            Caption = 'Free Date 1';
        }
        field(50102; "Free Date 2"; Date)
        {
            Caption = 'Free Date 2';
        }
        field(50103; "Free Date 3"; Date)
        {
            Caption = 'Free Date 3';
        }
        field(50104; "Free Date 4"; Date)
        {
            Caption = 'Free Date 4';
        }
        field(50105; "Free Date 5"; Date)
        {
            Caption = 'Free Date 5';
        }
        field(50106; "Free Date 6"; Date)
        {
            Caption = 'Free Date 6';
        }
        field(50107; "Free Date 7"; Date)
        {
            Caption = 'Free Date 7';
        }
        field(50108; "Free Date 8"; Date)
        {
            Caption = 'Free Date 8';
        }
        field(50109; "Free Value 1"; Decimal)
        {
            Caption = 'Free Value 1';
        }
        field(50110; "Free Value 2"; Decimal)
        {
            Caption = 'Free Value 2';
        }
        field(50111; "Free Value 3"; Decimal)
        {
            Caption = 'Free Value 3';
        }
        field(50112; "Free Value 4"; Decimal)
        {
            Caption = 'Free Value 4';
        }
        field(50113; "Free Value 5"; Decimal)
        {
            Caption = 'Free Value 5';
        }
        field(50114; "Free Boolean 1"; Boolean)
        {
            Caption = 'Free Boolean 1';
        }
        field(50115; "Free Boolean 2"; Boolean)
        {
            Caption = 'Free Boolean 2';
        }
        field(50116; "Free Boolean 3"; Boolean)
        {
            Caption = 'Free Boolean 3';
        }
        field(50117; "Free Boolean 4"; Boolean)
        {
            Caption = 'Free Boolean 4';
        }
        field(50118; "Free Boolean 5"; Boolean)
        {
            Caption = 'Free Boolean 5';
        }
        field(50119; "Progress Degree"; Code[10])
        {
            Caption = 'Progress Degree';
        }
        field(50120; "Job Starting Date"; Date)
        {
            Caption = 'Job Starting Date';
        }
        field(50121; "Job Ending Date"; Date)
        {
            Caption = 'Job Ending Date';
        }
        field(50122; "Transfer Job No."; Code[20])
        {
            Caption = 'Transfer Job No.';
            TableRelation = Job;
        }
        field(50123; "No. Prepayment Request Printed"; Integer)
        {
            Caption = 'No. Prepayment Request Printed';
            Editable = false;
        }
        field(50124; "Deadline Code"; Code[10])
        {
            Caption = 'Deadline code';

        }
        field(50125; "Deadline Date"; Date)
        {
            Caption = 'Deadline';
        }
        field(50126; "Gen. Prod Posting Group Filter"; Code[10])
        {
            Caption = 'Gen. Prod Posting Group Filter';
        }
        field(50127; "Person Quantity (Base)"; Decimal)
        {

            Caption = 'Person Quantity (Base)';
        }
        field(50128; "Date Received"; Date)
        {
            Caption = 'Date Received';
        }
        field(50129; "Time Received"; Time)
        {
            Caption = 'Time Received';
        }
        field(50130; "BizTalk Request for Sales Qte."; Boolean)
        {
            Caption = 'BizTalk Request for Sales Qte.';
        }
        field(50131; "BizTalk Sales Order"; Boolean)
        {
            Caption = 'BizTalk Sales Order';
        }
        field(50132; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
        }
        field(50133; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
        }
        field(50134; "BizTalk Sales Quote"; Boolean)
        {
            Caption = 'BizTalk Sales Quote';
        }
        field(50135; "BizTalk Sales Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Sales Order Cnfmn.';
        }
        field(50136; "Customer Quote No."; Code[20])
        {
            Caption = 'Customer Quote No.';
        }
        field(50137; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
        }
        field(50138; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
        }
        field(50139; "Reason Refusal"; Text[250])
        {
            Caption = 'Reason Refusal';
        }
        field(50140; "Management controller decision"; Enum "Dys Managcontrollerdecision")
        {
            Caption = 'Management controller decision';
            DataClassification = ToBeClassified;
        }

        field(50141; "Date saisie"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50142; "ID d'approbateur"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50143; "Date d'approbation"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50144; "Demarcheur"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent";
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }

        key(Key3; "Document Type", "Buy-from Vendor No.")
        {
        }
        key(Key4; "Document Type", "Pay-to Vendor No.")
        {
        }
        key(Key5; "Buy-from Vendor No.")
        {
        }
        key(Key6; "Incoming Document Entry No.")
        {
        }
        key(Key7; "Document Date")
        {
        }
        key(Key8; Status, "Expected Receipt Date", "Location Code", "Responsibility Center")
        {
        }
        key(Key9; "Assigned User ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Buy-from Vendor Name", "Amount Including VAT")
        {
        }
    }

    trigger OnDelete()
    var
        PurchCommentLine: Record "Purch. Comment Line";
        PostPurchDelete: Codeunit "PostPurch-Delete";
        ArchiveManagement: Codeunit ArchiveManagement;
        ShowPostedDocsToPrint: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeOnDelete(Rec, IsHandled);
        if IsHandled then
            exit;

        if not UserSetupMgt.CheckRespCenter(1, "Responsibility Center") then
            Error(
              Text023,
              RespCenter.TableCaption(), UserSetupMgt.GetPurchasesFilter());

        // ArchiveManagement.AutoArchivePurchDocument(Rec);

        Validate("Applies-to ID", '');
        Rec.Validate("Incoming Document Entry No.", 0);

        DeleteRecordInApprovalRequest();
        PurchRqLine.LockTable();

        WhseRequest.SetRange("Source Type", Database::"Purchase Line");
        WhseRequest.SetRange("Source Subtype", "Document Type");
        WhseRequest.SetRange("Source No.", "No.");
        WhseRequest.DeleteAll(true);

        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        PurchRqLine.SetRange(Type, PurchRqLine.Type::"Charge (Item)");
        DeletePurchaseLines();
        PurchRqLine.SetRange(Type);
        DeletePurchaseLines();

        PurchCommentLine.SetRange("Document Type", "Document Type");
        PurchCommentLine.SetRange("No.", "No.");
        PurchCommentLine.DeleteAll();

        ShowPostedDocsToPrint :=
            (PurchRcptHeader."No." <> '') or (PurchInvHeader."No." <> '') or (PurchCrMemoHeader."No." <> '') or
           (ReturnShptHeader."No." <> '') or (PurchInvHeaderPrepmt."No." <> '') or (PurchCrMemoHeaderPrepmt."No." <> '');
        if ShowPostedDocsToPrint then
            Message(PostedDocsToPrintCreatedMsg);
    end;

    trigger OnInsert()
    var
        IsHandled: Boolean;
    begin
        //OnBeforeOnInsert(Rec, IsHandled);

        Rec."User ID" := UserId;
        rec."Date saisie" := Today;
        if IsHandled then
            exit;

        InitInsert();

        SetBuyFromVendorFromFilter();

        if "Purchaser Code" = '' then
            SetDefaultPurchaser();
        Rec.Validate("Job No.");


    end;

    trigger OnRename()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeOnRename(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        Error(Text003, TableCaption);
    end;

    trigger OnModify()
    begin
        rec.TestStatusOpen();
    end;

    var
        Text003: Label 'You cannot rename a %1.';
        ConfirmChangeQst: Label 'Do you want to change %1?', Comment = '%1 = a Field Caption like Currency Code';
        Text005: Label 'You cannot reset %1 because the document still has one or more lines.';
        YouCannotChangeFieldErr: Label 'You cannot change %1 because the order is associated with one or more sales orders.', Comment = '%1 - fieldcaption';
        Text007: Label '%1 is greater than %2 in the %3 table.\';
        Text008: Label 'Confirm change?';
        Text009: Label 'Deleting this document will cause a gap in the number series for receipts. An empty receipt %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text012: Label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        Text014: Label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        RecreatePurchLinesMsg: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\Do you want to continue?', Comment = '%1: FieldCaption';
        ResetItemChargeAssignMsg: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\The amount of the item charge assignment will be reset to 0.\\Do you want to continue?', Comment = '%1: FieldCaption';
        LinesNotUpdatedMsg: Label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.', Comment = 'You have changed Posting Date on the purchase header, but it has not been changed on the existing purchase lines.';
        LinesNotUpdatedDateMsg: Label 'You have changed the %1 on the purchase order, which might affect the prices and discounts on the purchase order lines.', Comment = '%1: OrderDate';
        Text020: Label 'You must update the existing purchase lines manually.';
        AffectExchangeRateMsg: Label 'The change may affect the exchange rate that is used for price calculation on the purchase lines.';
        Text022: Label 'Do you want to update the exchange rate?';
        Text023: Label 'You cannot delete this document. Your identification is set up to process from %1 %2 only.';
        Text025: Label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. ';
        Text027: Label 'Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text028: Label 'Your identification is set up to process from %1 %2 only.';
        MaxAllowedValueIs100Err: Label 'The values must be less than or equal 100.';
        Text029: Label 'Deleting this document will cause a gap in the number series for return shipments. An empty return shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?', Comment = '%1 = Document No.';
        DoYouWantToKeepExistingDimensionsQst: Label 'This will change the dimension specified on the document. Do you want to recalculate/update dimensions?';
        Text032: Label 'You have modified %1.\\Do you want to update the lines?', Comment = 'You have modified Currency Factor.\\Do you want to update the lines?';
        ReviewLinesManuallyMsg: Label 'You should review the lines and manually update prices and discounts if needed.';
        UpdateLinesOrderDateAutomaticallyQst: Label 'Do you want to update the order date for existing lines?';
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        xPurchLine: Record "Purchase request Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        CompanyInfo: Record "Company Information";
        PostCode: Record "Post Code";
        BankAcc: Record "Bank Account";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchInvHeaderPrepmt: Record "Purch. Inv. Header";
        PurchCrMemoHeaderPrepmt: Record "Purch. Cr. Memo Hdr.";
        GenBusPostingGrp: Record "Gen. Business Posting Group";
        RespCenter: Record "Responsibility Center";
        Location: Record Location;
        WhseRequest: Record "Warehouse Request";
        InvtSetup: Record "Inventory Setup";
        GenJournalTemplate: Record "Gen. Journal Template";
        GlobalNoSeries: Record "No. Series";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeries: Codeunit "No. Series";
        DimMgt: Codeunit DimensionManagement;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        UserSetupMgt: Codeunit "User Setup Management";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        PostingSetupMgt: Codeunit PostingSetupManagement;
        StandardCodesMgtGlobal: Codeunit "Standard Codes Mgt.";
        ApplicationAreaMgmt: Codeunit "Application Area Mgmt.";
        CurrencyDate: Date;
        Confirmed: Boolean;
        Text034: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text037: Label 'Contact %1 %2 is not related to vendor %3.';
        Text038: Label 'Contact %1 %2 is related to a different company than vendor %3.';
        Text039: Label 'Contact %1 %2 is not related to a vendor.';
        Text040: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.';
        Text042: Label 'You must cancel the approval process if you wish to change the %1.';
        Text045: Label 'Deleting this document will cause a gap in the number series for prepayment invoices. An empty prepayment invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text046: Label 'Deleting this document will cause a gap in the number series for prepayment credit memos. An empty prepayment credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text049: Label '%1 is set up to process from %2 %3 only.';
        Text050: Label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\Do you want to continue?';
        Text051: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text052: Label 'The %1 field on the purchase order %2 must be the same as on sales order %3.';
        ReplaceDocumentDate: Boolean;
        UpdateDocumentDate: Boolean;
        PrepaymentInvoicesNotPaidErr: Label 'You cannot post the document of type %1 with the number %2 before all related prepayment invoices are posted.', Comment = 'You cannot post the document of type Order with the number 1001 before all related prepayment invoices are posted.';
        StatisticsInsuffucientPermissionsErr: Label 'You don''t have permission to view statistics.';
        Text054: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
        DeferralLineQst: Label 'You have changed the %1 on the purchase header, do you want to update the deferral schedules for the lines with this date?', Comment = '%1=The posting date on the document.';
        PostedDocsToPrintCreatedMsg: Label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        BuyFromVendorTxt: Label 'Buy-from Vendor';
        PayToVendorTxt: Label 'Pay-to Vendor';
        DocumentNotPostedClosePageQst: Label 'The document has been saved but is not yet posted.\\Are you sure you want to exit?';
        SelectNoSeriesAllowed: Boolean;
        MixedDropshipmentErr: Label 'You cannot print the purchase order because it contains one or more lines for drop shipment in addition to regular purchase lines.';
        ModifyVendorAddressNotificationLbl: Label 'Update the address';
        DontShowAgainActionLbl: Label 'Don''t show again';
        ModifyVendorAddressNotificationMsg: Label 'The address you entered for %1 is different from the Vendor''s existing address.', Comment = '%1=Vendor name';
        ModifyBuyFromVendorAddressNotificationNameTxt: Label 'Update Buy-from Vendor Address';
        ModifyBuyFromVendorAddressNotificationDescriptionTxt: Label 'Warn if the Buy-from address on purchase documents is different from the Vendor''s existing address.';
        ModifyPayToVendorAddressNotificationNameTxt: Label 'Update Pay-to Vendor Address';
        ModifyPayToVendorAddressNotificationDescriptionTxt: Label 'Warn if the Pay-to address on purchase documents is different from the Vendor''s existing address.';
        PurchaseAlreadyExistsTxt: Label 'Purchase %1 %2 already exists for this vendor.', Comment = '%1 = Document Type; %2 = Document No.';
        ShowVendLedgEntryTxt: Label 'Show the vendor ledger entry.';
        ShowDocAlreadyExistNotificationNameTxt: Label 'Purchase document with same external document number already exists.';
        ShowDocAlreadyExistNotificationDescriptionTxt: Label 'Warn if purchase document with same external document number already exists.';
        DuplicatedCaptionsNotAllowedErr: Label 'Field captions must not be duplicated when using this method. Use UpdatePurchLinesByFieldNo instead.';
        SplitMessageTxt: Label '%1\%2', Comment = 'Some message text 1.\Some message text 2.';
        FullPurchaseTypesTxt: Label 'Purchase Quote,Purchase Order,Purchase Invoice,Purchase Credit Memo,Purchase Blanket Order,Purchase Return Order';
        RecreatePurchaseLinesCancelErr: Label 'Change in the existing purchase lines for the field %1 is cancelled by user.', Comment = '%1 - Field Name, Sample:You must delete the existing purchase lines before you can change Currency Code.';
        WarnZeroQuantityPostingTxt: Label 'Warn before posting Purchase lines with 0 quantity';
        WarnZeroQuantityPostingDescriptionTxt: Label 'Warn before posting lines on Purchase documents where quantity is 0.';
        CalledFromWhseDoc: Boolean;
        Demandeur: Record Demandeur;
        "Véhicule": Record "Véhicule";

    protected var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchHeader: Record "Purchase Header";
        PurchRqLine: Record "Purchase request Line";
        HideValidationDialog: Boolean;
        StatusCheckSuspended: Boolean;
        SkipBuyFromContact: Boolean;
        SkipPayToContact: Boolean;
        SkipTaxCalculation: Boolean;

    procedure InitInsert()
    var
        PurchaseHeader2: Record "Purchase Header";
#if not CLEAN24
        NoSeriesMgt: Codeunit NoSeriesManagement;
#endif
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
        RecPurchSetup: Record "Purchases & Payables Setup";
        NoSeries: Codeunit "No. Series";
        NoSeriesBatch: Codeunit "No. Series - Batch";
        RecLUserSetup: Record "User Setup";
    begin
        if "No." = '' then begin
            RecPurchSetup.Get();
            RecPurchSetup.TestField("Purchase Request Nos.");
            if NoSeries.AreRelated(RecPurchSetup."Purchase Request Nos.", xRec."No Series") then
                "No Series" := xRec."No Series"
            else
                "No Series" := RecPurchSetup."Purchase Request Nos.";
            "No." := NoSeries.GetNextNo("No Series", WorkDate());

        end;
        RecLUserSetup.get(UserId);
        if RecLUserSetup.Affaire <> '' then
            rec.validate("Job No.", RecLUserSetup.Affaire);
        /*  IsHandled := false;
          //OnBeforeInitInsert(Rec, xRec, IsHandled);
          if not IsHandled then
              if "No." = '' then begin
                  TestNoSeries();
                  NoSeriesCode := GetNoSeriesCode();
  #if not CLEAN24
                  NoSeriesMgt.RaiseObsoleteOnBeforeInitSeries(NoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series", IsHandled);
                  if not IsHandled then begin
  #endif
                      "No. Series" := NoSeriesCode;
                      if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                          "No. Series" := xRec."No. Series";
                      "No." := NoSeries.GetNextNo("No. Series", "Posting Date");
                      PurchaseHeader2.ReadIsolation(IsolationLevel::ReadUncommitted);
                      PurchaseHeader2.SetLoadFields("No.");
                      while PurchaseHeader2.Get("Document Type", "No.") do
                          "No." := NoSeries.GetNextNo("No. Series", "Posting Date");
  #if not CLEAN24
                      NoSeriesMgt.RaiseObsoleteOnAfterInitSeries("No. Series", NoSeriesCode, "Posting Date", "No.");
                  end;
  #endif
              end;*/

        //  OnInitInsertOnBeforeInitRecord(Rec, xRec);
        InitRecord();
    end;

    procedure InitRecord()
    var
        IsHandled, SkipInitialization : Boolean;
    begin
        GetPurchSetup();
        IsHandled := false;
        //OnBeforeInitRecord(Rec, IsHandled, xRec, PurchSetup, GLSetup, SkipInitialization);
        if SkipInitialization then
            exit;
        if not IsHandled then
            InitPostingNoSeries();

        if "Document Type" = "Document Type"::Invoice then
            "Expected Receipt Date" := WorkDate();

        if not ("Document Type" in ["Document Type"::"Blanket Order", "Document Type"::Quote]) and
           ("Posting Date" = 0D)
        then
            "Posting Date" := WorkDate();

        if PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" then
            "Posting Date" := 0D;

        "Order Date" := WorkDate();
        "Document Date" := WorkDate();

        InitVATDate();

        //  OnInitRecordOnAfterAssignDates(Rec);

        ValidateEmptySellToCustomerAndLocation();

        if IsCreditDocType() then begin
            GLSetup.Get();
            Correction := GLSetup."Mark Cr. Memos as Corrections";
        end;

        InitPostingDescription();

        UpdateInboundWhseHandlingTime();

        IsHandled := false;
        //  OnInitRecordOnBeforeAssignResponsibilityCenter(Rec, IsHandled);
        if not IsHandled then
            "Responsibility Center" := UserSetupMgt.GetRespCenter(1, "Responsibility Center");
        GetNextArchiveDocOccurrenceNo();

        // OnAfterInitRecord(Rec);
    end;

    local procedure InitNoSeries()
    begin
        if xRec."Receiving No." <> '' then begin
            "Receiving No. Series" := xRec."Receiving No. Series";
            "Receiving No." := xRec."Receiving No.";
        end;
        if xRec."Posting No." <> '' then begin
            "Posting No. Series" := xRec."Posting No. Series";
            "Posting No." := xRec."Posting No.";
        end;
        if xRec."Return Shipment No." <> '' then begin
            "Return Shipment No. Series" := xRec."Return Shipment No. Series";
            "Return Shipment No." := xRec."Return Shipment No.";
        end;
        if xRec."Prepayment No." <> '' then begin
            "Prepayment No. Series" := xRec."Prepayment No. Series";
            "Prepayment No." := xRec."Prepayment No.";
        end;
        if xRec."Prepmt. Cr. Memo No." <> '' then begin
            "Prepmt. Cr. Memo No. Series" := xRec."Prepmt. Cr. Memo No. Series";
            "Prepmt. Cr. Memo No." := xRec."Prepmt. Cr. Memo No.";
        end;

        //  OnAfterInitNoSeries(Rec, xRec);
    end;

    procedure InitPostingDescription()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeInitPostingDescription(Rec, IsHandled);
        if IsHandled then
            exit;

        Rec."Posting Description" := Format(Rec."Document Type") + ' ' + Rec."No.";
    end;

    local procedure InitVATDate()
    begin
        "VAT Reporting Date" := GLSetup.GetVATDate("Posting Date", "Document Date");
    end;

    procedure SetStandardCodesMgt(var StandardCodesMgtNew: Codeunit "Standard Codes Mgt.")
    begin
        StandardCodesMgtGlobal := StandardCodesMgtNew;
    end;

    procedure AssistEdit(OldPurchHeader: Record "Purchase Header"): Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeAssistEdit(Rec, OldPurchHeader, IsHandled);
        if IsHandled then
            exit;

        GetPurchSetup();
        TestNoSeries();
        if NoSeries.LookupRelatedNoSeries(GetNoSeriesCode(), OldPurchHeader."No. Series", "No. Series") then begin
            "No." := NoSeries.GetNextNo("No. Series");
            exit(true);
        end;
    end;

    procedure TestNoSeries()
    var
        IsHandled: Boolean;
    begin
        GetPurchSetup();
        IsHandled := false;
        //  OnBeforeTestNoSeries(Rec, IsHandled);
        if not IsHandled then begin
            case "Document Type" of
                "Document Type"::Quote:
                    PurchSetup.TestField("Quote Nos.");
                "Document Type"::Order:
                    PurchSetup.TestField("Order Nos.");
                "Document Type"::Invoice:
                    PurchSetup.TestField("Invoice Nos.");
                "Document Type"::"Return Order":
                    PurchSetup.TestField("Return Order Nos.");
                "Document Type"::"Credit Memo":
                    PurchSetup.TestField("Credit Memo Nos.");
                "Document Type"::"Blanket Order":
                    PurchSetup.TestField("Blanket Order Nos.");
            end;
            GLSetup.GetRecordOnce();
            if not GLSetup."Journal Templ. Name Mandatory" then
                case "Document Type" of
                    "Document Type"::Invoice:
                        PurchSetup.TestField("Posted Invoice Nos.");
                    "Document Type"::"Credit Memo":
                        PurchSetup.TestField("Posted Credit Memo Nos.");
                end
            else begin
                PurchSetup.GetRecordOnce();
                if not IsCreditDocType() then begin
                    PurchSetup.TestField("P. Invoice Template Name");
                    if "Journal Templ. Name" = '' then
                        GenJournalTemplate.Get(PurchSetup."P. Invoice Template Name")
                    else
                        GenJournalTemplate.Get("Journal Templ. Name");
                end else begin
                    PurchSetup.TestField("P. Cr. Memo Template Name");
                    if "Journal Templ. Name" = '' then
                        GenJournalTemplate.Get(PurchSetup."P. Cr. Memo Template Name")
                    else
                        GenJournalTemplate.Get("Journal Templ. Name");
                end;
                GenJournalTemplate.TestField("Posting No. Series");
                GlobalNoSeries.Get(GenJournalTemplate."Posting No. Series");
                GlobalNoSeries.TestField("Default Nos.", true);
            end;
        end;

        //  OnAfterTestNoSeries(Rec, PurchSetup);
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
        IsHandled: Boolean;
    begin
        GetPurchSetup();
        IsHandled := false;
        //   OnBeforeGetNoSeriesCode(PurchSetup, NoSeriesCode, IsHandled, Rec);
        if IsHandled then
            exit(NoSeriesCode);

        case "Document Type" of
            "Document Type"::Quote:
                NoSeriesCode := PurchSetup."Quote Nos.";
            "Document Type"::Order:
                NoSeriesCode := PurchSetup."Order Nos.";
            "Document Type"::Invoice:
                NoSeriesCode := PurchSetup."Invoice Nos.";
            "Document Type"::"Return Order":
                NoSeriesCode := PurchSetup."Return Order Nos.";
            "Document Type"::"Credit Memo":
                NoSeriesCode := PurchSetup."Credit Memo Nos.";
            "Document Type"::"Blanket Order":
                NoSeriesCode := PurchSetup."Blanket Order Nos.";
        end;
        // OnAfterGetNoSeriesCode(Rec, PurchSetup, NoSeriesCode);

        if not SelectNoSeriesAllowed then
            exit(NoSeriesCode);

        if NoSeries.IsAutomatic(NoSeriesCode) then
            exit(NoSeriesCode);

        if NoSeries.HasRelatedSeries(NoSeriesCode) then
            if NoSeries.LookupRelatedNoSeries(NoSeriesCode, "No. Series") then
                exit("No. Series");

        exit(NoSeriesCode);
    end;

    local procedure GetNextArchiveDocOccurrenceNo()
    var
        ArchiveManagement: Codeunit ArchiveManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeGetNextArchiveDocOccurrenceNo(Rec, IsHandled);
        if IsHandled then
            exit;

        "Doc. No. Occurrence" :=
            ArchiveManagement.GetNextOccurrenceNo(Database::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");
    end;

    local procedure GetPostingNoSeriesCode() PostingNos: Code[20]
    var
        IsHandled: Boolean;
    begin
        GetPurchSetup();
        IsHandled := false;
        // OnBeforeGetPostingNoSeriesCode(Rec, PurchSetup, PostingNos, IsHandled);
        if IsHandled then
            exit(PostingNos);

        GLSetup.GetRecordOnce();
        if not GLSetup."Journal Templ. Name mandatory" then
            if IsCreditDocType() then
                PostingNos := PurchSetup."Posted Credit Memo Nos."
            else
                PostingNos := PurchSetup."Posted Invoice Nos."
        else begin
            GenJournalTemplate.Get("Journal Templ. Name");
            PostingNos := GenJournalTemplate."Posting No. Series";
        end;

        //    OnAfterGetPostingNoSeriesCode(Rec, PostingNos);
    end;

    local procedure GetPostingPrepaymentNoSeriesCode() PostingNos: Code[20]
    begin
        if IsCreditDocType() then
            PostingNos := PurchSetup."Posted Prepmt. Cr. Memo Nos."
        else
            PostingNos := PurchSetup."Posted Prepmt. Inv. Nos.";

        //  OnAfterGetPrepaymentPostingNoSeriesCode(Rec, PostingNos);
    end;

    procedure TestNoSeriesDate(No: Code[20]; NoSeriesCode: Code[20]; NoCapt: Text[1024]; NoSeriesCapt: Text[1024])
    begin
        if (No <> '') and (NoSeriesCode <> '') then begin
            GlobalNoSeries.Get(NoSeriesCode);
            if GlobalNoSeries."Date Order" then
                Error(
                  Text040,
                  FieldCaption("Posting Date"), NoSeriesCapt, NoSeriesCode,
                  GlobalNoSeries.FieldCaption("Date Order"), GlobalNoSeries."Date Order", "Document Type",
                  NoCapt, No);
        end;
    end;

    procedure ConfirmDeletion() Result: Boolean
    var
        SourceCode: Record "Source Code";
        SourceCodeSetup: Record "Source Code Setup";
        PostPurchDelete: Codeunit "PostPurch-Delete";
        ConfirmManagement: Codeunit "Confirm Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeConfirmDeletion(Rec, Result, IsHandled);
        if IsHandled then
            exit(Result);

        SourceCodeSetup.Get();
        SourceCodeSetup.TestField("Deleted Document");
        SourceCode.Get(SourceCodeSetup."Deleted Document");


        if PurchRcptHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text009, PurchRcptHeader."No."), true) then
                exit;
        if PurchInvHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text012, PurchInvHeader."No."), true) then
                exit;
        if PurchCrMemoHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text014, PurchCrMemoHeader."No."), true) then
                exit;
        if ReturnShptHeader."No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text029, ReturnShptHeader."No."), true) then
                exit;
        if "Prepayment No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text045, PurchInvHeaderPrepmt."No."), true) then
                exit;
        if "Prepmt. Cr. Memo No." <> '' then
            if not ConfirmManagement.GetResponseOrDefault(StrSubstNo(Text046, PurchCrMemoHeaderPrepmt."No."), true) then
                exit;
        exit(true);
    end;

    local procedure GetPurchSetup()
    begin
        PurchSetup.Get();
        //OnAfterGetPurchSetup(Rec, PurchSetup, CurrFieldNo);
    end;

    procedure GetVend(VendNo: Code[20])
    begin
        if VendNo <> Vend."No." then
            Vend.Get(VendNo);
    end;

    procedure GetStatusStyleText() StatusStyleText: Text
    begin
        if Status = Status::Open then
            StatusStyleText := 'Favorable'
        else
            StatusStyleText := 'Strong';

        //   OnAfterGetStatusStyleText(Rec, StatusStyleText);
    end;

    procedure PurchLinesExist(): Boolean
    var
        IsHandled, Result : Boolean;
    begin
        IsHandled := false;
        Result := false;
        //   OnBeforePurchLinesExist(Rec, Result, IsHandled);
        if IsHandled then
            exit(Result);

        PurchRqLine.Reset();
        PurchRqLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        exit(not PurchRqLine.IsEmpty);
    end;

    local procedure ResetInvoiceDiscountValue()
    begin
        if "Invoice Discount Value" <> 0 then begin
            CalcFields("Invoice Discount Amount");
            if "Invoice Discount Amount" = 0 then
                "Invoice Discount Value" := 0;
        end;
    end;

    internal procedure LookupBuyFromContact()
    var
        Contact: Record Contact;
    begin
        if "Buy-from Vendor No." = '' then
            exit;

        Contact.FilterGroup(2);
        LookupContact("Buy-from Vendor No.", "Buy-from Contact No.", Contact);
        if PAGE.RunModal(0, Contact) = ACTION::LookupOK then
            Validate("Buy-from Contact No.", Contact."No.");
        Contact.FilterGroup(0);
    end;

    procedure PerformManualRelease(var PurchaseHeader: Record "Purchase Header")
    var
        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
        NoOfSelected: Integer;
        NoOfSkipped: Integer;
        PrevFilterGroup: Integer;
    begin
        NoOfSelected := PurchaseHeader.Count();
        PrevFilterGroup := PurchaseHeader.FilterGroup();
        PurchaseHeader.FilterGroup(10);
        PurchaseHeader.SetFilter(Status, '<>%1', PurchaseHeader.Status::Released);
        NoOfSkipped := NoOfSelected - PurchaseHeader.Count;
        BatchProcessingMgt.BatchProcess(PurchaseHeader, Codeunit::"Purchase Manual Release", Enum::"Error Handling Options"::"Show Error", NoOfSelected, NoOfSkipped);
        PurchaseHeader.SetRange(Status);
        PurchaseHeader.FilterGroup(PrevFilterGroup);
    end;

    procedure PerformManualRelease()
    var
        ReleasePurchDoc: Codeunit "Release Purchase Document";
    begin
        if Rec.Status <> Rec.Status::Released then begin
            // ReleasePurchDoc.PerformManualRelease(Rec);
            Commit();
        end;
    end;

    procedure PerformManualReopen(var PurchaseHeader: Record "Purchase Header")
    var
        BatchProcessingMgt: Codeunit "Batch Processing Mgt.";
        NoOfSelected: Integer;
        NoOfSkipped: Integer;
    begin
        NoOfSelected := PurchaseHeader.Count();
        PurchaseHeader.SetFilter(Status, '<>%1', PurchaseHeader.Status::Open);
        NoOfSkipped := NoOfSelected - PurchaseHeader.Count;
        BatchProcessingMgt.BatchProcess(PurchaseHeader, Codeunit::"Purchase Manual Reopen", Enum::"Error Handling Options"::"Show Error", NoOfSelected, NoOfSkipped);
    end;

    procedure RecreatePurchLines(ChangedFieldName: Text[100])
    var
        TempPurchLine: Record "Purchase request Line" temporary;
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary;
        TempInteger: Record "Integer" temporary;
        TempPurchCommentLine: Record "Purch. Comment Line" temporary;
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ConfirmManagement: Codeunit "Confirm Management";
        ExtendedTextAdded: Boolean;
        ConfirmText: Text;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnRecreatePurchLinesOnBeforePurchLinesExists(Rec, xRec, ChangedFieldName, IsHandled);
        if IsHandled then
            exit;

        if not PurchLinesExist() then
            exit;

        IsHandled := false;
        // OnBeforeRecreatePurchLinesHandler(Rec, xRec, ChangedFieldName, IsHandled);
        if IsHandled then
            exit;

        IsHandled := false;
        //     OnRecreatePurchLinesOnBeforeConfirm(Rec, xRec, ChangedFieldName, HideValidationDialog, Confirmed, IsHandled);
        if not IsHandled then
            if GetHideValidationDialog() then
                Confirmed := true
            else begin
                if HasItemChargeAssignment() then
                    ConfirmText := ResetItemChargeAssignMsg
                else
                    ConfirmText := RecreatePurchLinesMsg;
                Confirmed := ConfirmManagement.GetResponseOrDefault(StrSubstNo(ConfirmText, ChangedFieldName), true);
            end;

        if Confirmed then begin
            PurchRqLine.LockTable();
            ItemChargeAssgntPurch.LockTable();
            Modify();
            // OnBeforeRecreatePurchLines(Rec);

            PurchRqLine.Reset();
            PurchRqLine.SetRange("Document Type", "Document Type");
            PurchRqLine.SetRange("Document No.", "No.");
            //  OnRecreatePurchLinesOnAfterPurchLineSetFilters(PurchRqLine);
            if PurchRqLine.FindSet() then begin
                RecreateTempPurchLines(TempPurchLine);
                StorePurchCommentLineToTemp(TempPurchCommentLine);
                DeletePurchCommentLines();

                TransferItemChargeAssgntPurchToTemp(ItemChargeAssgntPurch, TempItemChargeAssgntPurch);

                DeletePurchLines(PurchRqLine);

                PurchRqLine.Init();
                PurchRqLine."Line No." := 0;
                // OnRecreatePurchLinesOnBeforeTempPurchLineFindSet(TempPurchLine);
                TempPurchLine.FindSet();
                ExtendedTextAdded := false;
                repeat
                    if not TempPurchLine.IsExtendedText() then begin
                        PurchRqLine.Init();
                        PurchRqLine."Line No." := PurchRqLine."Line No." + 10000;
                        PurchRqLine."Price Calculation Method" := "Price Calculation Method";
                        PurchRqLine.Validate(Type, TempPurchLine.Type);
                        //    OnRecreatePurchLinesOnAfterValidateType(PurchLine, TempPurchLine);
                        if TempPurchLine."No." = '' then begin
                            PurchRqLine.Description := TempPurchLine.Description;
                            PurchRqLine."Description 2" := TempPurchLine."Description 2";
                        end else begin
                            PurchRqLine.Validate("No.", TempPurchLine."No.");
                            IsHandled := false;
                            // OnRecreatePurchLinesOnBeforeTransferSavedFields(Rec, TempPurchLine, IsHandled, PurchLine);
                            if not IsHandled then
                                if PurchRqLine.Type <> PurchRqLine.Type::" " then
                                    case true of
                                        TempPurchLine."Drop Shipment":
                                            TransferSavedFieldsDropShipment(PurchRQLine, TempPurchLine);
                                        TempPurchLine."Special Order":
                                            TransferSavedFieldsSpecialOrder(PurchRQLine, TempPurchLine);
                                        else
                                            TransferSavedFields(PurchRQLine, TempPurchLine);
                                    end;
                        end;

                        //    OnRecreatePurchLinesOnBeforeInsertPurchLine(PurchLine, TempPurchLine, ChangedFieldName);
                        PurchRqLine.Insert();
                        ExtendedTextAdded := false;

                        //   OnAfterRecreatePurchLine(PurchLine, TempPurchLine, Rec);

                        if PurchRqLine.Type = PurchRqLine.Type::Item then
                            RecreatePurchLinesFillItemChargeAssignment(PurchRqLine, TempPurchLine, TempItemChargeAssgntPurch);

                        if PurchRqLine.Type = PurchRqLine.Type::"Charge (Item)" then begin
                            TempInteger.Init();
                            TempInteger.Number := PurchRqLine."Line No.";
                            TempInteger.Insert();
                        end;
                    end else
                        if not ExtendedTextAdded then begin
                            //  TransferExtendedText.PurchCheckIfAnyExtText(PurchLine, true);
                            //TransferExtendedText.InsertPurchExtText(PurchLine);
                            //OnAfterTransferExtendedTextForPurchaseLineRecreation(PurchLine, TempPurchLine);
                            PurchRqLine.FindLast();
                            ExtendedTextAdded := true;
                        end;
                    RestorePurchCommentLine(TempPurchCommentLine, TempPurchLine."Line No.", PurchRqLine."Line No.");
                //  OnRecreatePurchLineOnAfterProcessAttachedToLineNo(TempPurchLine, PurchLine);
                until TempPurchLine.Next() = 0;

                //   OnRecreatePurchLinesOnAfterProcessTempPurchLines(TempPurchLine, Rec, xRec, ChangedFieldName);

                RestorePurchCommentLine(TempPurchCommentLine, 0, 0);

                RecreateItemChargeAssgntPurch(TempItemChargeAssgntPurch, TempPurchLine, TempInteger);

                TempPurchLine.SetRange(Type);
                TempPurchLine.DeleteAll();
                //   OnAfterDeleteAllTempPurchLines(Rec);
            end;
        end else
            Error(RecreatePurchaseLinesCancelErr, ChangedFieldName);

        // OnAfterRecreatePurchLines(Rec, ChangedFieldName);
    end;

    procedure StorePurchCommentLineToTemp(var TempPurchCommentLine: Record "Purch. Comment Line" temporary)
    var
        PurchCommentLine: Record "Purch. Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //    OnBeforeStorePurchCommentLineToTemp(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        PurchCommentLine.SetRange("Document Type", "Document Type");
        PurchCommentLine.SetRange("No.", "No.");
        if PurchCommentLine.FindSet() then
            repeat
                TempPurchCommentLine := PurchCommentLine;
                TempPurchCommentLine.Insert();
            until PurchCommentLine.Next() = 0;
    end;

    procedure RestorePurchCommentLine(var TempPurchCommentLine: Record "Purch. Comment Line" temporary; OldDocumentLineNo: Integer; NewDocumentLineNo: Integer)
    var
        PurchCommentLine: Record "Purch. Comment Line";
    begin
        TempPurchCommentLine.SetRange("Document Type", "Document Type");
        TempPurchCommentLine.SetRange("No.", "No.");
        TempPurchCommentLine.SetRange("Document Line No.", OldDocumentLineNo);
        if TempPurchCommentLine.FindSet() then
            repeat
                PurchCommentLine := TempPurchCommentLine;
                PurchCommentLine."Document Line No." := NewDocumentLineNo;
                PurchCommentLine.Insert();
            until TempPurchCommentLine.Next() = 0;
    end;

    local procedure RecreatePurchLinesFillItemChargeAssignment(PurchLine: Record "Purchase request Line"; var TempPurchLine: Record "Purchase request Line" temporary; var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary)
    begin
        ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Type", TempPurchLine."Document Type");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. No.", TempPurchLine."Document No.");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Line No.", TempPurchLine."Line No.");
        if TempItemChargeAssgntPurch.FindSet() then
            repeat
                if not TempItemChargeAssgntPurch.Mark() then begin
                    TempItemChargeAssgntPurch."Applies-to Doc. Line No." := PurchRqLine."Line No.";
                    TempItemChargeAssgntPurch.Description := PurchRqLine.Description;
                    TempItemChargeAssgntPurch.Modify();
                    TempItemChargeAssgntPurch.Mark(true);
                end;
            until TempItemChargeAssgntPurch.Next() = 0;
    end;

    local procedure RecreateItemChargeAssgntPurch(var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary; var TempPurchLine: Record "Purchase request Line" temporary; var TempInteger: Record "Integer" temporary)
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
        ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
        TempPurchLine.SetRange(Type, TempPurchLine.Type::"Charge (Item)");
        if TempPurchLine.FindSet() then
            repeat
                TempItemChargeAssgntPurch.SetRange("Document Line No.", TempPurchLine."Line No.");
                if TempItemChargeAssgntPurch.FindSet() then begin
                    repeat
                        TempInteger.FindFirst();
                        ItemChargeAssgntPurch.Init();
                        ItemChargeAssgntPurch := TempItemChargeAssgntPurch;
                        ItemChargeAssgntPurch."Document Line No." := TempInteger.Number;
                        ItemChargeAssgntPurch.Validate("Qty. to Assign", 0);
                        ItemChargeAssgntPurch.Insert();
                    until TempItemChargeAssgntPurch.Next() = 0;
                    TempInteger.Delete();
                end;
            until TempPurchLine.Next() = 0;

        ClearItemAssgntPurchFilter(TempItemChargeAssgntPurch);
        TempItemChargeAssgntPurch.DeleteAll();
    end;

    local procedure TransferSavedFields(var DestinationPurchaseLine: Record "Purchase request Line"; var SourcePurchaseLine: Record "Purchase request Line")
    begin
        // OnBeforeTransferSavedFields(DestinationPurchaseLine, SourcePurchaseLine);

        DestinationPurchaseLine.Validate("Unit of Measure Code", SourcePurchaseLine."Unit of Measure Code");
        DestinationPurchaseLine.Validate("Variant Code", SourcePurchaseLine."Variant Code");
        DestinationPurchaseLine."Prod. Order No." := SourcePurchaseLine."Prod. Order No.";
        if DestinationPurchaseLine."Prod. Order No." <> '' then begin
            DestinationPurchaseLine.Description := SourcePurchaseLine.Description;
            DestinationPurchaseLine.Validate("VAT Prod. Posting Group", SourcePurchaseLine."VAT Prod. Posting Group");
            DestinationPurchaseLine.Validate("Gen. Prod. Posting Group", SourcePurchaseLine."Gen. Prod. Posting Group");
            DestinationPurchaseLine.Validate("Expected Receipt Date", SourcePurchaseLine."Expected Receipt Date");
            DestinationPurchaseLine.Validate("Requested Receipt Date", SourcePurchaseLine."Requested Receipt Date");
            DestinationPurchaseLine.Validate("Qty. per Unit of Measure", SourcePurchaseLine."Qty. per Unit of Measure");
        end;
        TransferSavedJobFields(DestinationPurchaseLine, SourcePurchaseLine);
        if SourcePurchaseLine.Quantity <> 0 then
            DestinationPurchaseLine.Validate(Quantity, SourcePurchaseLine.Quantity);
        if ("Currency Code" = xRec."Currency Code") and (PurchRqLine."Direct Unit Cost" = 0) then
            DestinationPurchaseLine.Validate("Direct Unit Cost", SourcePurchaseLine."Direct Unit Cost");
        DestinationPurchaseLine."Routing No." := SourcePurchaseLine."Routing No.";
        DestinationPurchaseLine."Routing Reference No." := SourcePurchaseLine."Routing Reference No.";
        DestinationPurchaseLine."Operation No." := SourcePurchaseLine."Operation No.";
        DestinationPurchaseLine."Work Center No." := SourcePurchaseLine."Work Center No.";
        DestinationPurchaseLine."Prod. Order Line No." := SourcePurchaseLine."Prod. Order Line No.";
        DestinationPurchaseLine."Overhead Rate" := SourcePurchaseLine."Overhead Rate";

        // OnAfterTransferSavedFields(DestinationPurchaseLine, SourcePurchaseLine);
    end;

    local procedure TransferSavedJobFields(var DestinationPurchaseLine: Record "Purchase request Line"; SourcePurchaseLine: Record "Purchase request Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeTransferSavedJobFields(DestinationPurchaseLine, SourcePurchaseLine, IsHandled);
        if IsHandled then
            exit;

        if (SourcePurchaseLine."Job No." <> '') and (SourcePurchaseLine."Job Task No." <> '') then begin
            DestinationPurchaseLine.Validate("Job No.", SourcePurchaseLine."Job No.");
            DestinationPurchaseLine.Validate("Job Task No.", SourcePurchaseLine."Job Task No.");
            DestinationPurchaseLine."Job Line Type" := SourcePurchaseLine."Job Line Type";
        end;
    end;

    procedure TransferSavedFieldsDropShipment(var DestinationPurchaseLine: Record "Purchase request Line"; var SourcePurchaseLine: Record "Purchase request Line")
    var
        SalesLine: Record "Sales Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeTransferSavedFieldsDropShipment(DestinationPurchaseLine, SourcePurchaseLine, IsHandled);
        if IsHandled then
            exit;

        SalesLine.Get(
            SalesLine."Document Type"::Order,
            SourcePurchaseLine."Sales Order No.",
            SourcePurchaseLine."Sales Order Line No.");
        //CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine, DestinationPurchaseLine);
        DestinationPurchaseLine."Drop Shipment" := SourcePurchaseLine."Drop Shipment";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Sales Order No." := SourcePurchaseLine."Sales Order No.";
        DestinationPurchaseLine."Sales Order Line No." := SourcePurchaseLine."Sales Order Line No.";
        Evaluate(DestinationPurchaseLine."Inbound Whse. Handling Time", '<0D>');
        DestinationPurchaseLine.Validate("Inbound Whse. Handling Time");
        SalesLine.Validate("Unit Cost (LCY)", DestinationPurchaseLine."Unit Cost (LCY)");
        SalesLine."Purchase Order No." := DestinationPurchaseLine."Document No.";
        SalesLine."Purch. Order Line No." := DestinationPurchaseLine."Line No.";
        SalesLine.Modify();
    end;

    local procedure TransferSavedFieldsSpecialOrder(var DestinationPurchaseLine: Record "Purchase request Line"; var SourcePurchaseLine: Record "Purchase request Line")
    var
        SalesLine: Record "Sales Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeTransferSavedFieldsSpecialOrder(DestinationPurchaseLine, SourcePurchaseLine, IsHandled);
        if IsHandled then
            exit;

        SalesLine.Get(
            SalesLine."Document Type"::Order,
            SourcePurchaseLine."Special Order Sales No.",
            SourcePurchaseLine."Special Order Sales Line No.");
        // CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine, DestinationPurchaseLine);
        DestinationPurchaseLine."Special Order" := SourcePurchaseLine."Special Order";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Special Order Sales No." := SourcePurchaseLine."Special Order Sales No.";
        DestinationPurchaseLine."Special Order Sales Line No." := SourcePurchaseLine."Special Order Sales Line No.";
        DestinationPurchaseLine.Validate("Unit of Measure Code", SourcePurchaseLine."Unit of Measure Code");
        if SourcePurchaseLine.Quantity <> 0 then
            DestinationPurchaseLine.Validate(Quantity, SourcePurchaseLine.Quantity);

        SalesLine.Validate("Unit Cost (LCY)", DestinationPurchaseLine."Unit Cost (LCY)");
        SalesLine."Special Order Purchase No." := DestinationPurchaseLine."Document No.";
        SalesLine."Special Order Purch. Line No." := DestinationPurchaseLine."Line No.";
        //    OnTransferSavedFieldsSpecialOrderOnBeforeSalesLineModify(DestinationPurchaseLine, SourcePurchaseLine, SalesLine);
        SalesLine.Modify();
    end;

    procedure MessageIfPurchLinesExist(ChangedFieldName: Text[100])
    var
        MessageText: Text;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeMessageIfPurchLinesExist(Rec, ChangedFieldName, IsHandled);
        if IsHandled then
            exit;

        if PurchLinesExist() and not GetHideValidationDialog() then begin
            MessageText := StrSubstNo(LinesNotUpdatedMsg, ChangedFieldName);
            MessageText := StrSubstNo(SplitMessageTxt, MessageText, Text020);
            Message(MessageText);
        end;
    end;

    procedure PriceMessageIfPurchLinesExist(ChangedFieldName: Text[100])
    var
        ConfirmManagement: Codeunit "Confirm Management";
        MessageText: Text;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforePriceMessageIfPurchLinesExist(Rec, ChangedFieldName, IsHandled);
        if IsHandled then
            exit;

        if PurchLinesExist() and not GetHideValidationDialog() then begin
            MessageText := StrSubstNo(LinesNotUpdatedDateMsg, ChangedFieldName);
            if "Currency Code" <> '' then
                MessageText := StrSubstNo(SplitMessageTxt, MessageText, AffectExchangeRateMsg);

            if (ChangedFieldName.Contains(FieldCaption("Order Date"))) then begin
                Confirmed := ConfirmManagement.GetResponseOrDefault(StrSubstNo(SplitMessageTxt, MessageText, UpdateLinesOrderDateAutomaticallyQst), false);
                if Confirmed then
                    UpdatePurchLinesByFieldNo(FieldNo("Order Date"), false);
            end else
                Message(StrSubstNo(SplitMessageTxt, MessageText, ReviewLinesManuallyMsg));
        end;
    end;

    procedure UpdateCurrencyFactor()
    var
        UpdateCurrencyExchangeRates: Codeunit "Update Currency Exchange Rates";
        Updated: Boolean;
    begin
        //   OnBeforeUpdateCurrencyFactor(Rec, Updated, CurrExchRate, CurrFieldNo);
        if Updated then
            exit;

        if "Currency Code" <> '' then begin
            if Rec."Posting Date" <> 0D then
                CurrencyDate := "Posting Date"
            else
                CurrencyDate := WorkDate();
            //   OnUpdateCurrencyFactorOnAfterCurrencyDateSet(Rec, CurrencyDate, CurrFieldNo);

            if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate, "Currency Code") then begin
                "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
                if "Currency Code" <> xRec."Currency Code" then
                    RecreatePurchLines(FieldCaption("Currency Code"));
            end else
                UpdateCurrencyExchangeRates.ShowMissingExchangeRatesNotification("Currency Code");
        end else begin
            "Currency Factor" := 0;
            if "Currency Code" <> xRec."Currency Code" then
                RecreatePurchLines(FieldCaption("Currency Code"));
        end;

        // OnAfterUpdateCurrencyFactor(Rec, GetHideValidationDialog());
    end;

    procedure ConfirmCurrencyFactorUpdate(): Boolean
    var
        ForceConfirm: Boolean;
    begin
        //  OnBeforeConfirmUpdateCurrencyFactor(Rec, HideValidationDialog, ForceConfirm);
        if GetHideValidationDialog() or not GuiAllowed or ForceConfirm then
            Confirmed := true
        else
            Confirmed := Confirm(Text022, false);
        if Confirmed then
            Validate("Currency Factor")
        else
            "Currency Factor" := xRec."Currency Factor";
        //  OnAfterConfirmUpdateCurrencyFactor(Rec, HideValidationDialog);
        exit(Confirmed);
    end;

    procedure GetHideValidationDialog(): Boolean
    begin
        exit(HideValidationDialog);
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    procedure UpdateLocationCode(LocationCode: Code[10])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeUpdateLocationCode(Rec, LocationCode, IsHandled);
        if not IsHandled then
            Validate("Location Code", UserSetupMgt.GetLocation(1, LocationCode, "Responsibility Center"));
    end;

    procedure UpdatePurchLines(ChangedFieldName: Text[100]; AskQuestion: Boolean)
    var
        "Field": Record "Field";
    begin
        Field.SetRange(TableNo, Database::"Purchase Header");
        Field.SetRange("Field Caption", ChangedFieldName);
        Field.SetFilter(ObsoleteState, '<>%1', Field.ObsoleteState::Removed);
        Field.Find('-');
        if Field.Next() <> 0 then
            Error(DuplicatedCaptionsNotAllowedErr);
        UpdatePurchLinesByFieldNo(Field."No.", AskQuestion);

        //  OnAfterUpdatePurchLines(Rec);
    end;

    local procedure UpdatePurchAmountLines()
    var
        PurchLine: Record "Purchase Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeUpdatePurchLineAmounts(Rec, xRec, CurrFieldNo, IsHandled);
        if IsHandled then
            exit;

        PurchRqLine.Reset();
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        PurchRqLine.SetFilter(Type, '<>%1', PurchRqLine.Type::" ");
        PurchRqLine.SetFilter(Quantity, '<>0');
        PurchRqLine.LockTable();
        if PurchRqLine.FindSet() then begin
            Modify();
            repeat
                PurchRqLine.UpdateAmounts();
                PurchRqLine.Modify();
            until PurchRqLine.Next() = 0;
        end;
    end;

    procedure UpdatePurchLinesByFieldNo(ChangedFieldNo: Integer; AskQuestion: Boolean)
    var
        "Field": Record "Field";
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        Question: Text[250];
        IsHandled: Boolean;
        ShouldConfirmReservationDateConflict: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeUpdatePurchLinesByFieldNo(Rec, ChangedFieldNo, AskQuestion, IsHandled);
        if IsHandled then
            exit;

        if not PurchLinesExist() then
            exit;

        if not Field.Get(Database::"Purchase Header", ChangedFieldNo) then
            Field.Get(Database::"Purchase Line", ChangedFieldNo);

        if AskQuestion then begin
            Question := StrSubstNo(Text032, Field."Field Caption");
            if GuiAllowed and not HideValidationDialog then
                if DIALOG.Confirm(Question, true) then begin
                    ShouldConfirmReservationDateConflict := ChangedFieldNo in [FieldNo("Expected Receipt Date"),
                        FieldNo("Requested Receipt Date"),
                        FieldNo("Promised Receipt Date"),
                        FieldNo("Lead Time Calculation"),
                        FieldNo("Inbound Whse. Handling Time")];
                    //  OnUpdatePurchLinesByFieldNoOnAfterCalcShouldConfirmReservationDateConflict(Rec, ChangedFieldNo, ShouldConfirmReservationDateConflict);
                    if ShouldConfirmReservationDateConflict then
                        ConfirmReservationDateConflict(ChangedFieldNo);
                end
                else
                    exit;
        end;

        PurchRqLine.LockTable();
        //   OnUpdatePurchLinesByFieldNoOnBeforeModifyRec(Rec, PurchLine);
        Modify();

        PurchRqLine.Reset();
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        // OnUpdatePurchLinesByFieldNoOnAfterPurchLineSetFilters(Rec, xRec, PurchLine, ChangedFieldNo);
        if PurchRqLine.FindSet() then
            repeat
                xPurchLine := PurchRqLine;
                IsHandled := false;

                //   OnUpdatePurchLinesByFieldNoOnBeforeValidateFields(PurchLine, xPurchLine, ChangedFieldNo, Rec, IsHandled);
                if not IsHandled then
                    case ChangedFieldNo of
                        FieldNo("Expected Receipt Date"):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.Validate("Expected Receipt Date", "Expected Receipt Date");
                        FieldNo("Currency Factor"):
                            if PurchRqLine.Type <> PurchRqLine.Type::" " then
                                PurchRqLine.Validate("Direct Unit Cost");
                        FieldNo("Transaction Type"):
                            PurchRqLine.Validate("Transaction Type", "Transaction Type");
                        FieldNo("Transport Method"):
                            PurchRqLine.Validate("Transport Method", "Transport Method");
                        FieldNo("Entry Point"):
                            PurchRqLine.Validate("Entry Point", "Entry Point");
                        FieldNo(Area):
                            PurchRqLine.Validate(Area, Area);
                        FieldNo("Transaction Specification"):
                            PurchRqLine.Validate("Transaction Specification", "Transaction Specification");
                        FieldNo("Requested Receipt Date"):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.Validate("Requested Receipt Date", "Requested Receipt Date");
                        FieldNo("Prepayment %"):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.Validate("Prepayment %", "Prepayment %");
                        FieldNo("Promised Receipt Date"):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.Validate("Promised Receipt Date", "Promised Receipt Date");
                        FieldNo("Lead Time Calculation"):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.Validate("Lead Time Calculation", "Lead Time Calculation");
                        FieldNo("Inbound Whse. Handling Time"):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.Validate("Inbound Whse. Handling Time", "Inbound Whse. Handling Time");
                        PurchRqLine.FieldNo("Deferral Code"):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.Validate("Deferral Code");
                        FieldNo("Order Date"):
                            if PurchRqLine."No." <> '' then begin
                                PurchRqLine.Validate("Order Date", "Order Date");
                                PurchRqLine.UpdateDirectUnitCost(0);
                            end;
                        FieldNo("Campaign No."):
                            if PurchRqLine."No." <> '' then
                                PurchRqLine.UpdateDirectUnitCost(0);
                        else
                    //     OnUpdatePurchLinesByChangedFieldName(Rec, PurchLine, Field.FieldName, ChangedFieldNo, xRec);
                    end;
                //  OnUpdatePurchLinesByFieldNoOnBeforeLineModify(Rec, xRec, PurchLine);
                PurchRqLine.Modify(true);
            //  PurchLineReserve.VerifyChange(PurchLine, xPurchLine);
            until PurchRqLine.Next() = 0;

        //OnAfterUpdatePurchLinesByFieldNo(Rec, xRec, ChangedFieldNo);
    end;

    procedure ConfirmReservationDateConflict()
    begin
        ConfirmReservationDateConflict(0);
    end;

    procedure ConfirmReservationDateConflict(ChangedFieldNo: Integer)
    var
        ReservationEngineMgt: Codeunit "Reservation Engine Mgt.";
        ConfirmManagement: Codeunit "Confirm Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeConfirmResvDateConflict(Rec, IsHandled, ChangedFieldNo);
        if IsHandled then
            exit;

    end;

    procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        SourceCodeSetup: Record "Source Code Setup";
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeCreateDim(Rec, IsHandled, DefaultDimSource, CurrFieldNo);
        if IsHandled then
            exit;

        SourceCodeSetup.Get();

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Purchases, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        // OnCreateDimOnBeforeUpdateLines(Rec, xRec, CurrFieldNo, OldDimSetID, DefaultDimSource);

        if (OldDimSetID <> "Dimension Set ID") and (OldDimSetID <> 0) and GuiAllowed and not GetHideValidationDialog() then
            if CouldDimensionsBeKept() then
                if not ConfirmKeepExistingDimensions(OldDimSetID) then begin
                    "Dimension Set ID" := OldDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(Rec."Dimension Set ID", Rec."Shortcut Dimension 1 Code", Rec."Shortcut Dimension 2 Code");
                end;

        if (OldDimSetID <> "Dimension Set ID") and PurchLinesExist() then begin
            Modify();
            UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;


    local procedure ConfirmKeepExistingDimensions(OldDimSetID: Integer) Confirmed: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeConfirmKeepExistingDimensions(Rec, xRec, CurrFieldNo, OldDimSetID, Confirmed, IsHandled);
        if IsHandled then
            exit(Confirmed);

        Confirmed := Confirm(DoYouWantToKeepExistingDimensionsQst);
    end;

    procedure CouldDimensionsBeKept() Result: Boolean;
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeCouldDimensionsBeKept(Rec, xRec, Result, IsHandled);
        if not IsHandled then begin
            if (xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> Rec."Buy-from Vendor No.") then
                exit(false);
            if (xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> Rec."Pay-to Vendor No.") then
                exit(false);
            if (Rec."Location Code" = '') and (xRec."Location Code" <> '') and (CurrFieldNo = Rec.FieldNo("Location Code")) then
                exit(true);
            if (xRec."Location Code" <> Rec."Location Code") and ((CurrFieldNo = Rec.FieldNo("Location Code"))
                or ((Rec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> Rec."Sell-to Customer No."))) then
                exit(true);
            if (xRec."Purchaser Code" <> '') and (xRec."Purchaser Code" <> Rec."Purchaser Code") then
                exit(true);
            if (xRec."Responsibility Center" <> '') and (xRec."Responsibility Center" <> Rec."Responsibility Center") then
                exit(true);
            if (xRec."Sell-to Customer No." <> '') and (xRec."Sell-to Customer No." <> Rec."Sell-to Customer No.") then
                exit(true);
        end;
        // OnAfterCouldDimensionsBeKept(Rec, xRec, Result);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        //  OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify();

        if OldDimSetID <> "Dimension Set ID" then begin
            if not IsNullGuid(Rec.SystemId) then
                Modify();
            if PurchLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;

        //  OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;

    local procedure ValidateDocumentDateWithPostingDate()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeValidateDocumentDateWithPostingDate(Rec, CurrFieldNo, IsHandled, xRec);
        if IsHandled then
            exit;

        Validate("Document Date", "Posting Date");
    end;

    procedure ReceivedPurchLinesExist(): Boolean
    begin
        PurchRqLine.Reset();
        PurchRqLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        PurchRqLine.SetFilter("Quantity Received", '<>0');
        exit(not PurchRqLine.IsEmpty());
    end;

    procedure ReturnShipmentExist(): Boolean
    begin
        PurchRqLine.Reset();
        PurchRqLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        PurchRqLine.SetFilter("Return Qty. Shipped", '<>0');
        exit(not PurchRqLine.IsEmpty());
    end;

    procedure UpdateShipToAddress()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //    OnBeforeUpdateShipToAddress(Rec, IsHandled, CurrFieldNo);
        if IsHandled then
            exit;

        if IsCreditDocType() then begin
            //  OnAfterUpdateShipToAddress(Rec);
            exit;
        end;

        if ("Location Code" <> '') and Location.Get("Location Code") and ("Sell-to Customer No." = '') then begin
            SetShipToAddress(
              Location.Name, Location."Name 2", Location.Address, Location."Address 2",
              Location.City, Location."Post Code", Location.County, Location."Country/Region Code");
            "Ship-to Contact" := Location.Contact;
            //OnUpdateShipToAddressOnAfterCopyFromLocation(Rec, Location);
        end;

        if ("Location Code" = '') and ("Sell-to Customer No." = '') then begin
            CompanyInfo.Get();
            "Ship-to Code" := '';
            SetShipToAddress(
              CompanyInfo."Ship-to Name", CompanyInfo."Ship-to Name 2", CompanyInfo."Ship-to Address", CompanyInfo."Ship-to Address 2",
              CompanyInfo."Ship-to City", CompanyInfo."Ship-to Post Code", CompanyInfo."Ship-to County",
              CompanyInfo."Ship-to Country/Region Code");
            "Ship-to Contact" := CompanyInfo."Ship-to Contact";
            //   OnUpdateShipToAddressOnAfterCopyFromCompany(Rec, CompanyInfo);
        end;

        //   OnAfterUpdateShipToAddress(Rec);
    end;

    local procedure DeletePurchaseLines()
    var
        ReservMgt: Codeunit "Reservation Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeDeletePurchaseLines(PurchLine, IsHandled, Rec);
        if IsHandled then
            exit;

        if PurchRqLine.FindSet() then begin
            ReservMgt.DeleteDocumentReservation(
                Database::"Purchase Line", "Document Type".AsInteger(), "No.", GetHideValidationDialog());
            repeat
                PurchRqLine.SuspendStatusCheck(true);
                PurchRqLine.Delete(true);
            until PurchRqLine.Next() = 0;
        end;
    end;

    local procedure DeleteRecordInApprovalRequest()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeDeleteRecordInApprovalRequest(Rec, IsHandled);
        if IsHandled then
            exit;

        ApprovalsMgmt.OnDeleteRecordInApprovalRequest(RecordId);
    end;

    local procedure ClearItemAssgntPurchFilter(var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary)
    begin
        TempItemChargeAssgntPurch.SetRange("Document Line No.");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Type");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. No.");
        TempItemChargeAssgntPurch.SetRange("Applies-to Doc. Line No.");
    end;

    local procedure CheckReceiptInfo(var PurchLine: Record "Purchase request Line"; PayTo: Boolean)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCheckReceiptInfo(Rec, xRec, PurchLine, PayTo, IsHandled);
        if IsHandled then
            exit;

        if "Document Type" = "Document Type"::Order then
            PurchRqLine.SetFilter("Quantity Received", '<>0')
        else
            if "Document Type" = "Document Type"::Invoice then begin
                if not PayTo then
                    PurchRqLine.SetRange("Buy-from Vendor No.", xRec."Buy-from Vendor No.");
                PurchRqLine.SetFilter("Receipt No.", '<>%1', '');
            end;

        if PurchRqLine.FindFirst() then
            if "Document Type" = "Document Type"::Order then
                PurchRqLine.TestField("Quantity Received", 0)
            else
                PurchRqLine.TestField("Receipt No.", '');
        PurchRqLine.SetRange("Receipt No.");
        PurchRqLine.SetRange("Quantity Received");
        if not PayTo then
            PurchRqLine.SetRange("Buy-from Vendor No.");
    end;

    local procedure CheckPrepmtInfo(var PurchLine: Record "Purchase request Line")
    begin
        if "Document Type" = "Document Type"::Order then begin
            PurchRqLine.SetFilter("Prepmt. Amt. Inv.", '<>0');
            if PurchRqLine.Find('-') then
                PurchRqLine.TestField("Prepmt. Amt. Inv.", 0);
            PurchRqLine.SetRange("Prepmt. Amt. Inv.");
        end;
    end;

    local procedure CheckReturnInfo(var PurchLine: Record "Purchase request Line"; PayTo: Boolean)
    begin
        if "Document Type" = "Document Type"::"Return Order" then
            PurchRqLine.SetFilter("Return Qty. Shipped", '<>0')
        else
            if "Document Type" = "Document Type"::"Credit Memo" then begin
                if not PayTo then
                    PurchRqLine.SetRange("Buy-from Vendor No.", xRec."Buy-from Vendor No.");
                PurchRqLine.SetFilter("Return Shipment No.", '<>%1', '');
            end;

        if PurchRqLine.FindFirst() then
            if "Document Type" = "Document Type"::"Return Order" then
                PurchRqLine.TestField("Return Qty. Shipped", 0)
            else
                PurchRqLine.TestField("Return Shipment No.", '');
    end;

    local procedure CheckShipToCodeChange(PurchHeader: Record "Purchase request"; xPurchaseHeader: Record "Purchase request")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeCheckShipToCodeChange(PurchHeader, IsHandled, xPurchaseHeader);
        if IsHandled then
            exit;

        if (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) and (xRec."Ship-to Code" <> PurchHeader."Ship-to Code") then begin
            PurchRqLine.SetRange("Document Type", PurchRqLine."Document Type"::Order);
            PurchRqLine.SetRange("Document No.", PurchHeader."No.");
            PurchRqLine.SetFilter("Sales Order Line No.", '<>0');
            if not PurchRqLine.IsEmpty() then
                Error(YouCannotChangeFieldErr, PurchHeader.FieldCaption("Ship-to Code"));
        end;
    end;

    local procedure CheckSpecialOrderSalesLineLink()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeCheckSpecialOrderSalesLineLink(Rec, IsHandled);
        if IsHandled then
            exit;

        PurchRqLine.SetRange("Sales Order Line No.");
        PurchRqLine.SetFilter("Special Order Sales Line No.", '<>0');
        if not PurchRqLine.IsEmpty() then
            Error(
              YouCannotChangeFieldErr,
              FieldCaption("Sell-to Customer No."));
    end;

    local procedure CheckShipToCode(ShipToCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeCheckShipToCode(Rec, IsHandled);
        if IsHandled then
            exit;

        TestField("Ship-to Code", ShipToCode);
    end;

    procedure UpdateBuyFromCont(VendorNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Vend: Record Vendor;
        OfficeContact: Record Contact;
        OfficeMgt: Codeunit "Office Management";
    begin
        if OfficeMgt.GetContact(OfficeContact, VendorNo) then begin
            SetHideValidationDialog(true);
            UpdateBuyFromVend(OfficeContact."No.");
            SetHideValidationDialog(false);
        end else
            if Vend.Get(VendorNo) then begin
                if Vend."Primary Contact No." <> '' then
                    "Buy-from Contact No." := Vend."Primary Contact No."
                else
                    "Buy-from Contact No." := ContBusRel.GetContactNo(ContBusRel."Link to Table"::Vendor, "Buy-from Vendor No.");
                "Buy-from Contact" := Vend.Contact;
            end;

        if "Buy-from Contact No." <> '' then
            if OfficeContact.Get("Buy-from Contact No.") then
                OfficeContact.CheckIfPrivacyBlockedGeneric();

        ///  OnAfterUpdateBuyFromCont(Rec, Vend, OfficeContact);
    end;

    local procedure UpdatePayToCont(VendorNo: Code[20])
    var
        ContBusRel: Record "Contact Business Relation";
        Vend: Record Vendor;
        Contact: Record Contact;
    begin
        if Vend.Get(VendorNo) then begin
            if Vend."Primary Contact No." <> '' then
                "Pay-to Contact No." := Vend."Primary Contact No."
            else
                "Pay-to Contact No." := ContBusRel.GetContactNo(ContBusRel."Link to Table"::Vendor, "Pay-to Vendor No.");
            "Pay-to Contact" := Vend.Contact;
        end;

        if "Pay-to Contact No." <> '' then
            if Contact.Get("Pay-to Contact No.") then
                Contact.CheckIfPrivacyBlockedGeneric();

        // OnAfterUpdatePayToCont(Rec, Vend, Contact);
    end;

    local procedure UpdateBuyFromVend(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Vend: Record Vendor;
        Cont: Record Contact;
        ShouldUpdateFromContact: Boolean;
    begin
        ShouldUpdateFromContact := Cont.Get(ContactNo);
        //  OnUpdateBuyFromVendOnAfterGetContact(Rec, Cont, ShouldUpdateFromContact);
        if ShouldUpdateFromContact then begin
            "Buy-from Contact No." := Cont."No.";
            if Cont.Type = Cont.Type::Person then
                "Buy-from Contact" := Cont.Name
            else
                if Vend.Get("Buy-from Vendor No.") then
                    "Buy-from Contact" := Vend.Contact
                else
                    "Buy-from Contact" := ''
        end else begin
            "Buy-from Contact" := '';
            exit;
        end;

        if ContBusinessRelation.FindByContact(ContBusinessRelation."Link to Table"::Vendor, Cont."Company No.") then begin
            if ("Buy-from Vendor No." <> '') and
               ("Buy-from Vendor No." <> ContBusinessRelation."No.")
            then
                Error(Text037, Cont."No.", Cont.Name, "Buy-from Vendor No.");
            if "Buy-from Vendor No." = '' then begin
                SkipBuyFromContact := true;
                Validate("Buy-from Vendor No.", ContBusinessRelation."No.");
                SkipBuyFromContact := false;
            end;
        end else
            ContactIsNotRelatedToVendorError(Cont, ContactNo);

        //OnCheckBuyFromContactOnAfterFindByContact(Rec, ContBusinessRelation, Cont);

        if ("Buy-from Vendor No." = "Pay-to Vendor No.") or
           ("Pay-to Vendor No." = '')
        then
            Validate("Pay-to Contact No.", "Buy-from Contact No.");

        // OnAfterUpdateBuyFromVend(Rec, Cont);
    end;

    local procedure UpdatePayToVend(ContactNo: Code[20])
    var
        ContBusinessRelation: Record "Contact Business Relation";
        Vend: Record Vendor;
        Cont: Record Contact;
        ShouldUpdateFromContact: Boolean;
    begin
        ShouldUpdateFromContact := Cont.Get(ContactNo);
        //  OnUpdatePayToVendOnAfterGetContact(Rec, Cont, ShouldUpdateFromContact);
        if ShouldUpdateFromContact then begin
            "Pay-to Contact No." := Cont."No.";
            if Cont.Type = Cont.Type::Person then
                "Pay-to Contact" := Cont.Name
            else
                if Vend.Get("Pay-to Vendor No.") then
                    "Pay-to Contact" := Vend.Contact
                else
                    "Pay-to Contact" := '';
        end else begin
            "Pay-to Contact" := '';
            exit;
        end;

        //  OnUpdatePayToVendOnBeforeFindByContact(Rec, Vend, Cont);
        if ContBusinessRelation.FindByContact(ContBusinessRelation."Link to Table"::Vendor, Cont."Company No.") then begin
            if "Pay-to Vendor No." = '' then begin
                SkipPayToContact := true;
                Validate("Pay-to Vendor No.", ContBusinessRelation."No.");
                SkipPayToContact := false;
            end else
                if "Pay-to Vendor No." <> ContBusinessRelation."No." then
                    Error(Text037, Cont."No.", Cont.Name, "Pay-to Vendor No.");
        end else
            ContactIsNotRelatedToVendorError(Cont, ContactNo);
        //   OnAfterUpdatePayToVend(Rec, Cont);
    end;

    local procedure ContactIsNotRelatedToVendorError(Cont: Record Contact; ContactNo: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        Error(Text039, Cont."No.", Cont.Name);
    end;

    procedure CreateInvtPutAwayPick()
    var
        WhseRequest: Record "Warehouse Request";
    begin
        TestField(Status, Status::Released);

        WhseRequest.Reset();
        WhseRequest.SetCurrentKey("Source Document", "Source No.");
        case "Document Type" of
            "Document Type"::Order:
                WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Purchase Order");
            "Document Type"::"Return Order":
                WhseRequest.SetRange("Source Document", WhseRequest."Source Document"::"Purchase Return Order");
        end;
        WhseRequest.SetRange("Source No.", "No.");
        REPORT.RunModal(REPORT::"Create Invt Put-away/Pick/Mvmt", true, false, WhseRequest);
    end;

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeShowDocDim(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            Rec, "Dimension Set ID", StrSubstNo('%1 %2', "Document Type", "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        // OnShowDocDimOnAfterSetDimensionSetID(Rec, xRec);

        if OldDimSetID <> "Dimension Set ID" then begin
            //    OnShowDocDimOnBeforePurchHeaderModify(Rec);
            Modify();
            if PurchLinesExist() then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;

    procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        NewDimSetID: Integer;
        ReceivedShippedItemLineDimChangeConfirmed: Boolean;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeUpdateAllLineDim(Rec, NewParentDimSetID, OldParentDimSetID, IsHandled, xRec);
        if IsHandled then
            exit;

        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not GetHideValidationDialog() then
            if not ConfirmManagement.GetResponseOrDefault(Text051, true) then
                exit;

        PurchRqLine.Reset();
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        //OnUpdateAllLineDimOnAfterPurchLineSetFilters(PurchLine);
        PurchRqLine.LockTable();
        if PurchRqLine.Find('-') then
            repeat
                //   OnUpdateAllLineDimOnBeforeGetPurchLineNewDimsetID(PurchLine, NewParentDimSetID, OldParentDimSetID);
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchRqLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                //  OnUpdateAllLineDimOnAfterGetPurchLineNewDimsetID(Rec, xRec, PurchLine, NewDimSetID, NewParentDimSetID, OldParentDimSetID);
                if PurchRqLine."Dimension Set ID" <> NewDimSetID then begin
                    PurchRqLine."Dimension Set ID" := NewDimSetID;

                    if not GetHideValidationDialog() and GuiAllowed then
                        VerifyReceivedShippedItemLineDimChange(ReceivedShippedItemLineDimChangeConfirmed);

                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchRqLine."Dimension Set ID", PurchRqLine."Shortcut Dimension 1 Code", PurchRqLine."Shortcut Dimension 2 Code");

                    //   OnUpdateAllLineDimOnBeforePurchLineModify(PurchLine);
                    PurchRqLine.Modify();
                end;
            until PurchRqLine.Next() = 0;
    end;

    local procedure VerifyReceivedShippedItemLineDimChange(var ReceivedShippedItemLineDimChangeConfirmed: Boolean)
    begin
        if PurchRqLine.IsReceivedShippedItemDimChanged() then
            if not ReceivedShippedItemLineDimChangeConfirmed then
                ReceivedShippedItemLineDimChangeConfirmed := PurchRqLine.ConfirmReceivedShippedItemDimChange();
    end;

    procedure SetAmountToApply(AppliesToDocNo: Code[20]; VendorNo: Code[20])
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        //   OnBeforeSetAmountToApply(Rec, VendLedgEntry);

        VendLedgEntry.SetCurrentKey("Document No.");
        VendLedgEntry.SetRange("Document No.", AppliesToDocNo);
        VendLedgEntry.SetRange("Vendor No.", VendorNo);
        VendLedgEntry.SetRange(Open, true);
        if VendLedgEntry.FindFirst() then begin
            if VendLedgEntry."Amount to Apply" = 0 then begin
                VendLedgEntry.CalcFields("Remaining Amount");
                VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
            end else
                VendLedgEntry."Amount to Apply" := 0;
            VendLedgEntry."Accepted Payment Tolerance" := 0;
            VendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
            CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
        end;
    end;

    procedure SetShipToForSpecOrder()
    begin
        if Location.Get("Location Code") then begin
            "Ship-to Code" := '';
            SetShipToAddress(
              Location.Name, Location."Name 2", Location.Address, Location."Address 2",
              Location.City, Location."Post Code", Location.County, Location."Country/Region Code");
            "Ship-to Contact" := Location.Contact;
            "Location Code" := Location.Code;
        end else begin
            CompanyInfo.Get();
            "Ship-to Code" := '';
            SetShipToAddress(
              CompanyInfo."Ship-to Name", CompanyInfo."Ship-to Name 2", CompanyInfo."Ship-to Address", CompanyInfo."Ship-to Address 2",
              CompanyInfo."Ship-to City", CompanyInfo."Ship-to Post Code", CompanyInfo."Ship-to County",
              CompanyInfo."Ship-to Country/Region Code");
            "Ship-to Contact" := CompanyInfo."Ship-to Contact";
            "Location Code" := '';
        end;

        // OnAfterSetShipToForSpecOrder(Rec, Location, CompanyInfo);
    end;

    local procedure JobUpdatePurchLines(SkipJobCurrFactorUpdate: Boolean)
    begin
        PurchRqLine.SetFilter("Job No.", '<>%1', '');
        PurchRqLine.SetFilter("Job Task No.", '<>%1', '');
        PurchRqLine.LockTable();
        if PurchRqLine.FindSet(true) then begin
            // PurchRqLine.SetPurchHeader(Rec);
            repeat
                JobUpdatePurchaseLine(SkipJobCurrFactorUpdate);
            until PurchRqLine.Next() = 0;
        end;
    end;

    local procedure JobUpdatePurchaseLine(SkipJobCurrFactorUpdate: Boolean)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //    OnBeforeJobUpdatePurchaseLine(PurchLine, IsHandled);
        if IsHandled then
            exit;

        if not SkipJobCurrFactorUpdate then
            PurchRqLine.JobSetCurrencyFactor();
        PurchRqLine.CreateTempJobJnlLine(false);
        PurchRqLine.UpdateJobPrices();
        PurchRqLine.Modify();
    end;

    procedure GetPstdDocLinesToReverse()
    var
        PurchPostedDocLines: Page "Posted Purchase Document Lines";
    begin
        GetVend("Buy-from Vendor No.");
        // PurchPostedDocLines.SetToPurchHeader(Rec);
        PurchPostedDocLines.SetRecord(Vend);
        PurchPostedDocLines.LookupMode := true;
        if PurchPostedDocLines.RunModal() = ACTION::LookupOK then
            //PurchPostedDocLines.CopyLineToDoc();

        Clear(PurchPostedDocLines);
    end;

    procedure SetSecurityFilterOnRespCenter()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //    OnBeforeSetSecurityFilterOnRespCenter(Rec, IsHandled);
        if (not IsHandled) and (UserSetupMgt.GetPurchasesFilter() <> '') then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserSetupMgt.GetPurchasesFilter());
            FilterGroup(0);
        end;

        Rec.SetRange("Date Filter", 0D, WorkDate());
        // OnAfterSetSecurityFilterOnRespCenter(Rec);
    end;

    procedure CalcInvDiscForHeader()
    var
        PurchaseInvDisc: Codeunit "Purch.-Calc.Discount";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeCalcInvDiscForHeader(Rec, IsHandled);
        if IsHandled then
            exit;

        GetPurchSetup();
        if PurchSetup."Calc. Inv. Discount" then;
        //  PurchaseInvDisc.CalculateIncDiscForHeader(Rec);
    end;

    procedure AddShipToAddress(SalesHeader: Record "Sales Header"; ShowError: Boolean)
    var
        PurchLine2: Record "Purchase Line";
    begin
        if ShowError then begin
            PurchLine2.Reset();
            PurchLine2.SetRange("Document Type", "Document Type"::Order);
            PurchLine2.SetRange("Document No.", "No.");
            if not PurchLine2.IsEmpty() then begin
                if "Ship-to Name" <> SalesHeader."Ship-to Name" then
                    Error(Text052, FieldCaption("Ship-to Name"), "No.", SalesHeader."No.");
                if "Ship-to Name 2" <> SalesHeader."Ship-to Name 2" then
                    Error(Text052, FieldCaption("Ship-to Name 2"), "No.", SalesHeader."No.");
                if "Ship-to Address" <> SalesHeader."Ship-to Address" then
                    Error(Text052, FieldCaption("Ship-to Address"), "No.", SalesHeader."No.");
                if "Ship-to Address 2" <> SalesHeader."Ship-to Address 2" then
                    Error(Text052, FieldCaption("Ship-to Address 2"), "No.", SalesHeader."No.");
                if "Ship-to Post Code" <> SalesHeader."Ship-to Post Code" then
                    Error(Text052, FieldCaption("Ship-to Post Code"), "No.", SalesHeader."No.");
                if "Ship-to Country/Region Code" <> SalesHeader."Ship-to Country/Region Code" then
                    Error(Text052, FieldCaption("Ship-to Country/Region Code"), "No.", SalesHeader."No.");
                if "Ship-to County" <> SalesHeader."Ship-to County" then
                    Error(Text052, FieldCaption("Ship-to County"), "No.", SalesHeader."No.");
                if "Ship-to City" <> SalesHeader."Ship-to City" then
                    Error(Text052, FieldCaption("Ship-to City"), "No.", SalesHeader."No.");
                if "Ship-to Contact" <> SalesHeader."Ship-to Contact" then
                    Error(Text052, FieldCaption("Ship-to Contact"), "No.", SalesHeader."No.");
            end else begin
                // no purchase line exists
                SetShipToAddress(
                    SalesHeader."Ship-to Name", SalesHeader."Ship-to Name 2", SalesHeader."Ship-to Address",
                    SalesHeader."Ship-to Address 2", SalesHeader."Ship-to City", SalesHeader."Ship-to Post Code",
                    SalesHeader."Ship-to County", SalesHeader."Ship-to Country/Region Code");
                "Ship-to Contact" := SalesHeader."Ship-to Contact";
            end;
        end;

        //  OnAfterAddShipToAddress(Rec, SalesHeader, ShowError);
    end;

    local procedure BuyFromPostCodeOnBeforeLookupHandled() IsHandled: Boolean
    begin
        //  OnBeforeBuyFromPostCodeOnBeforeLookupHandled(Rec, PostCode, IsHandled);
    end;

    local procedure CopyAddressInfoFromOrderAddress()
    var
        OrderAddr: Record "Order Address";
    begin
        OrderAddr.Get("Buy-from Vendor No.", "Order Address Code");
        "Buy-from Vendor Name" := OrderAddr.Name;
        "Buy-from Vendor Name 2" := OrderAddr."Name 2";
        "Buy-from Address" := OrderAddr.Address;
        "Buy-from Address 2" := OrderAddr."Address 2";
        "Buy-from City" := OrderAddr.City;
        "Buy-from Contact" := OrderAddr.Contact;
        "Buy-from Post Code" := OrderAddr."Post Code";
        "Buy-from County" := OrderAddr.County;
        "Buy-from Country/Region Code" := OrderAddr."Country/Region Code";

        if IsCreditDocType() then begin
            SetShipToAddress(
                OrderAddr.Name, OrderAddr."Name 2", OrderAddr.Address, OrderAddr."Address 2",
                OrderAddr.City, OrderAddr."Post Code", OrderAddr.County, OrderAddr."Country/Region Code");
            "Ship-to Contact" := OrderAddr.Contact;
        end;
        //  OnAfterCopyAddressInfoFromOrderAddress(OrderAddr, Rec);
    end;

    procedure DropShptOrderExists(SalesHeader: Record "Sales Header"): Boolean
    var
        SalesLine2: Record "Sales Line";
    begin
        // returns TRUE if sales is either Drop Shipment of Special Order
        SalesLine2.Reset();
        SalesLine2.SetRange("Document Type", SalesLine2."Document Type"::Order);
        SalesLine2.SetRange("Document No.", SalesHeader."No.");
        SalesLine2.SetRange("Drop Shipment", true);
        exit(not SalesLine2.IsEmpty());
    end;

    procedure SpecialOrderExists(SalesHeader: Record "Sales Header"): Boolean
    var
        SalesLine3: Record "Sales Line";
    begin
        SalesLine3.Reset();
        SalesLine3.SetRange("Document Type", SalesLine3."Document Type"::Order);
        SalesLine3.SetRange("Document No.", SalesHeader."No.");
        SalesLine3.SetRange("Special Order", true);
        exit(not SalesLine3.IsEmpty());
    end;

    local procedure CheckDropShipmentLineExists()
    var
        SalesShipmentLine: Record "Sales Shipment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        SalesShipmentLine.SetRange("Purchase Order No.", "No.");
        SalesShipmentLine.SetRange("Drop Shipment", true);
        if not SalesShipmentLine.IsEmpty() then
            Error(YouCannotChangeFieldErr, FieldCaption("Buy-from Vendor No."));
    end;

    procedure QtyToReceiveIsZero(): Boolean
    begin
        PurchRqLine.Reset();
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        PurchRqLine.SetFilter("Qty. to Receive", '<>0');
        // OnQtyToReceiveIsZeroOnAfterSetFilters(PurchrqLine);
        exit(PurchRqLine.IsEmpty);
    end;

    procedure IsApprovedForPosting() Approved: Boolean
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin

    end;

    procedure IsApprovedForPostingBatch() Approved: Boolean
    begin
        Approved := ApprovedForPostingBatch();
        // OnAfterIsApprovedForPostingBatch(Rec, Approved);
    end;

    [TryFunction]
    local procedure ApprovedForPostingBatch()
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin

    end;

    procedure IsTotalValid(): Boolean
    var
        IncomingDocument: Record "Incoming Document";
        PurchaseLine: Record "Purchase Line";
        TempTotalPurchaseLine: Record "Purchase Line" temporary;
        GeneralLedgerSetup: Record "General Ledger Setup";
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
        IsHandled: Boolean;
    begin
        //  OnBeforeIsTotalValid(Rec, IsHandled);
        if IsHandled then
            exit(true);

        if not IncomingDocument.Get(Rec."Incoming Document Entry No.") then
            exit(true);

        if IncomingDocument."Amount Incl. VAT" = 0 then
            exit(true);

        PurchaseLine.SetRange("Document Type", "Document Type");
        PurchaseLine.SetRange("Document No.", "No.");
        if not PurchaseLine.FindFirst() then
            exit(true);

        GeneralLedgerSetup.Get();
        if (IncomingDocument."Currency Code" <> PurchaseLine."Currency Code") and
           (IncomingDocument."Currency Code" <> GeneralLedgerSetup."LCY Code")
        then
            exit(true);

        TempTotalPurchaseLine.Init();
        DocumentTotals.PurchaseCalculateTotalsWithInvoiceRounding(PurchaseLine, VATAmount, TempTotalPurchaseLine);

        exit(IncomingDocument."Amount Incl. VAT" = TempTotalPurchaseLine."Amount Including VAT");
    end;

    procedure SendToPosting(PostingCodeunitID: Integer) IsSuccess: Boolean
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorMessageHandler: Codeunit "Error Message Handler";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeSendToPosting(Rec, IsSuccess, IsHandled, PostingCodeunitID);
        if IsHandled then
            exit(IsSuccess);

        if not IsApprovedForPosting() then
            exit;

        Commit();
        ErrorMessageMgt.Activate(ErrorMessageHandler);
        ErrorMessageMgt.PushContext(ErrorContextElement, RecordId, 0, '');
        IsSuccess := CODEUNIT.Run(PostingCodeunitID, Rec);
        if not IsSuccess then
            ErrorMessageHandler.ShowErrors();
    end;

    procedure CancelBackgroundPosting()
    var
        PurchasePostViaJobQueue: Codeunit "Purchase Post via Job Queue";
    begin
        //  PurchasePostViaJobQueue.CancelQueueEntry(Rec);
    end;

    procedure AddSpecialOrderToAddress(var SalesHeader: Record "Sales Header"; ShowError: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeAddSpecialOrderToAddress(Rec, SalesHeader, IsHandled, ShowError);
        if IsHandled then
            exit;

        if ShowError then
            if PurchLinesExist() then begin
                // PurchaseHeader := Rec;
                PurchaseHeader.SetShipToForSpecOrder();
                if "Ship-to Name" <> PurchaseHeader."Ship-to Name" then
                    Error(Text052, FieldCaption("Ship-to Name"), "No.", SalesHeader."No.");
                if "Ship-to Name 2" <> PurchaseHeader."Ship-to Name 2" then
                    Error(Text052, FieldCaption("Ship-to Name 2"), "No.", SalesHeader."No.");
                if "Ship-to Address" <> PurchaseHeader."Ship-to Address" then
                    Error(Text052, FieldCaption("Ship-to Address"), "No.", SalesHeader."No.");
                if "Ship-to Address 2" <> PurchaseHeader."Ship-to Address 2" then
                    Error(Text052, FieldCaption("Ship-to Address 2"), "No.", SalesHeader."No.");
                if "Ship-to Post Code" <> PurchaseHeader."Ship-to Post Code" then
                    Error(Text052, FieldCaption("Ship-to Post Code"), "No.", SalesHeader."No.");
                if "Ship-to City" <> PurchaseHeader."Ship-to City" then
                    Error(Text052, FieldCaption("Ship-to City"), "No.", SalesHeader."No.");
                if "Ship-to Contact" <> PurchaseHeader."Ship-to Contact" then
                    Error(Text052, FieldCaption("Ship-to Contact"), "No.", SalesHeader."No.");
            end else
                SetShipToForSpecOrder();

        //  OnAfterAddSpecialOrderToAddress(Rec, SalesHeader, ShowError);
    end;

    procedure InvoicedLineExists(): Boolean
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        PurchRqLine.SetFilter(Type, '<>%1', PurchRqLine.Type::" ");
        PurchRqLine.SetFilter("Quantity Invoiced", '<>%1', 0);
        exit(not PurchRqLine.IsEmpty);
    end;

    procedure CreateDimSetForPrepmtAccDefaultDim()
    var
        PurchaseLine: Record "Purchase Line";
        TempPurchaseLine: Record "Purchase Line" temporary;
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeCreateDimSetForPrepmtAccDefaultDim(Rec, IsHandled);
        if IsHandled then
            exit;

        PurchaseLine.SetRange("Document Type", "Document Type");
        PurchaseLine.SetRange("Document No.", "No.");
        PurchaseLine.SetFilter("Prepmt. Amt. Inv.", '<>%1', 0);
        if PurchaseLine.FindSet() then
            repeat
                CollectParamsInBufferForCreateDimSet(TempPurchaseLine, PurchaseLine);
            until PurchaseLine.Next() = 0;
        TempPurchaseLine.Reset();
        TempPurchaseLine.MarkedOnly(false);
        if TempPurchaseLine.FindSet() then
            repeat
                InitPurchaseLineDefaultDimSource(DefaultDimSource, TempPurchaseLine);
                TempPurchaseLine.CreateDim(DefaultDimSource);
            until TempPurchaseLine.Next() = 0;
    end;

    local procedure InitPurchaseLineDefaultDimSource(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; SourcePurchaseLine: Record "Purchase Line")
    var
        IsHandled: Boolean;
    begin
        Clear(DefaultDimSource);
        IsHandled := false;
        //  OnBeforeInitPurchaseLineDefaultDimSource(Rec, DefaultDimSource, SourcePurchaseLine, IsHandled);
        if IsHandled then
            exit;

        DimMgt.AddDimSource(DefaultDimSource, Database::"G/L Account", SourcePurchaseLine."No.");
        DimMgt.AddDimSource(DefaultDimSource, Database::Job, SourcePurchaseLine."Job No.");
        DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", SourcePurchaseLine."Responsibility Center");
        DimMgt.AddDimSource(DefaultDimSource, Database::"Work Center", SourcePurchaseLine."Work Center No.");
    end;

    local procedure CollectParamsInBufferForCreateDimSet(var TempPurchaseLine: Record "Purchase Line" temporary; PurchaseLine: Record "Purchase Line")
    var
        GenPostingSetup: Record "General Posting Setup";
        DefaultDimension: Record "Default Dimension";
    begin
        TempPurchaseLine.SetRange("Gen. Bus. Posting Group", PurchaseLine."Gen. Bus. Posting Group");
        TempPurchaseLine.SetRange("Gen. Prod. Posting Group", PurchaseLine."Gen. Prod. Posting Group");
        if not TempPurchaseLine.FindFirst() then begin
            GenPostingSetup.Get(PurchaseLine."Gen. Bus. Posting Group", PurchaseLine."Gen. Prod. Posting Group");
            GenPostingSetup.TestField("Purch. Prepayments Account");
            DefaultDimension.SetRange("Table ID", Database::"G/L Account");
            DefaultDimension.SetRange("No.", GenPostingSetup."Purch. Prepayments Account");
            InsertTempPurchaseLineInBuffer(TempPurchaseLine, PurchaseLine,
              GenPostingSetup."Purch. Prepayments Account", DefaultDimension.IsEmpty);
        end else
            if not TempPurchaseLine.Mark() then begin
                TempPurchaseLine.SetRange("Job No.", PurchaseLine."Job No.");
                TempPurchaseLine.SetRange("Responsibility Center", PurchaseLine."Responsibility Center");
                TempPurchaseLine.SetRange("Work Center No.", PurchaseLine."Work Center No.");
                if TempPurchaseLine.IsEmpty() then
                    InsertTempPurchaseLineInBuffer(TempPurchaseLine, PurchaseLine, TempPurchaseLine."No.", false)
            end;
    end;

    local procedure InsertTempPurchaseLineInBuffer(var TempPurchaseLine: Record "Purchase Line" temporary; PurchaseLine: Record "Purchase Line"; AccountNo: Code[20]; DefaultDimenstionsNotExist: Boolean)
    begin
        TempPurchaseLine.Init();
        TempPurchaseLine."Document Type" := PurchaseLine."Document Type";
        TempPurchaseLine."Document No." := PurchaseLine."Document No.";
        TempPurchaseLine."Line No." := PurchaseLine."Line No.";
        TempPurchaseLine."No." := AccountNo;
        TempPurchaseLine."Job No." := PurchaseLine."Job No.";
        TempPurchaseLine."Responsibility Center" := PurchaseLine."Responsibility Center";
        TempPurchaseLine."Work Center No." := PurchaseLine."Work Center No.";
        TempPurchaseLine."Gen. Bus. Posting Group" := PurchaseLine."Gen. Bus. Posting Group";
        TempPurchaseLine."Gen. Prod. Posting Group" := PurchaseLine."Gen. Prod. Posting Group";
        TempPurchaseLine.Mark := DefaultDimenstionsNotExist;
        TempPurchaseLine.Insert();
    end;

    procedure TransferItemChargeAssgntPurchToTemp(var ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //    OnBeforeTransferItemChargeAssgntPurchToTemp(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        ItemChargeAssgntPurch.SetRange("Document Type", "Document Type");
        ItemChargeAssgntPurch.SetRange("Document No.", "No.");
        if ItemChargeAssgntPurch.FindSet() then begin
            repeat
                TempItemChargeAssgntPurch := ItemChargeAssgntPurch;
                TempItemChargeAssgntPurch.Insert();
            until ItemChargeAssgntPurch.Next() = 0;
            ItemChargeAssgntPurch.DeleteAll();
        end;
    end;

    procedure OpenPurchaseOrderStatistics()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeOpenPurchaseOrderStatistics(Rec, IsHandled);
        if IsHandled then
            exit;

        OpenDocumentStatisticsInternal();
    end;

    procedure OpenDocumentStatistics()
    begin
        OpenDocumentStatisticsInternal();
    end;

    procedure PrepareOpeningDocumentStatistics()
    var
        [SecurityFiltering(SecurityFilter::Ignored)]
        PurchaseHeader: Record "Purchase Header";
        [SecurityFiltering(SecurityFilter::Ignored)]
        PurchaseLine: Record "Purchase Line";
    begin
        if not PurchaseHeader.WritePermission() or not PurchaseLine.WritePermission() then
            Error(StatisticsInsuffucientPermissionsErr);

        CalcInvDiscForHeader();
        if IsOrderDocument() then
            CreateDimSetForPrepmtAccDefaultDim();

        // OnAfterPrepareOpeningDocumentStatistics(Rec);

        Commit();
    end;

    procedure ShowDocumentStatisticsPage()
    var
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        StatisticsPageId: Integer;
    begin
        StatisticsPageId := GetStatisticsPageID();

        //   OnGetStatisticsPageID(StatisticsPageId, Rec);

        PAGE.RunModal(StatisticsPageId, Rec);

        //   PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
    end;

    local procedure OpenDocumentStatisticsInternal()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeOpenDocumentStatistics(Rec, IsHandled);
        if IsHandled then
            exit;

        PrepareOpeningDocumentStatistics();
        ShowDocumentStatisticsPage();
    end;

    local procedure IsOrderDocument(): Boolean
    begin
        case "Document Type" of
            "Document Type"::Order,
            "Document Type"::"Blanket Order",
            "Document Type"::"Return Order":
                exit(true);
        end;

        exit(false);
    end;

    local procedure GetStatisticsPageID(): Integer
    begin
        if IsOrderDocument() then
            exit(PAGE::"Purchase Order Statistics");

        exit(PAGE::"Purchase Statistics");
    end;

    [IntegrationEvent(true, false)]
    procedure OnCheckPurchasePostRestrictions()
    begin
    end;

    procedure CheckPurchasePostRestrictions()
    begin
        OnCheckPurchasePostRestrictions();
    end;

    [IntegrationEvent(true, false)]
    local procedure OnCheckPurchaseReleaseRestrictions()
    begin
    end;

    procedure CheckPurchaseReleaseRestrictions()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OnCheckPurchaseReleaseRestrictions();
        // ApprovalsMgmt.PrePostApprovalCheckPurch(Rec);
    end;

    procedure SetStatus(NewStatus: Option)
    begin
        Status := Enum::"Purchase Document Status".FromInteger(NewStatus);
        Modify();
    end;

    procedure TriggerOnAfterPostPurchaseDoc(var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20])
    var
        PurchPost: Codeunit "Purch.-Post";
    begin
        //PurchPost.OnAfterPostPurchaseDoc(Rec, GenJnlPostLine, PurchRcpHdrNo, RetShptHdrNo, PurchInvHdrNo, PurchCrMemoHdrNo, false);
    end;

    procedure DeferralHeadersExist(): Boolean
    var
        DeferralHeader: Record "Deferral Header";
    begin
        DeferralHeader.SetRange("Deferral Doc. Type", "Deferral Document Type"::Purchase);
        DeferralHeader.SetRange("Gen. Jnl. Template Name", '');
        DeferralHeader.SetRange("Gen. Jnl. Batch Name", '');
        DeferralHeader.SetRange("Document Type", "Document Type");
        DeferralHeader.SetRange("Document No.", "No.");
        exit(not DeferralHeader.IsEmpty);
    end;

    local procedure ConfirmUpdateDeferralDate()
    begin
        if GetHideValidationDialog() or not GuiAllowed then
            Confirmed := true
        else
            Confirmed := Confirm(DeferralLineQst, false, FieldCaption("Posting Date"));
        if Confirmed then
            UpdatePurchLinesByFieldNo(PurchRqLine.FieldNo("Deferral Code"), false);
    end;

    local procedure ConfirmUpdateField(UpdatingFieldNo: Integer) Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeConfirmUpdateField(Rec, xRec, UpdatingFieldNo, CurrFieldNo, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if GetHideValidationDialog() or not GuiAllowed then
            Result := true
        else
            Result := Confirm(ConfirmChangeQst, false, GetUpdatedFieldCaption(UpdatingFieldNo));
    end;

    procedure GetUpdatedFieldCaption(UpdatingFieldNo: Integer): Text
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        case UpdatingFieldNo of
            FieldNo("Buy-from Vendor No."):
                exit(BuyFromVendorTxt);
            FieldNo("Pay-to Vendor No."):
                exit(PayToVendorTxt);
        end;

        RecRef.Get(RecordId);
        FldRef := RecRef.Field(UpdatingFieldNo);
        exit(FldRef.Caption);
    end;

    procedure IsCreditDocType(): Boolean
    var
        CreditDocType: Boolean;
    begin
        CreditDocType := "Document Type" in ["Document Type"::"Return Order", "Document Type"::"Credit Memo"];
        //  OnBeforeIsCreditDocType(Rec, CreditDocType);
        exit(CreditDocType);
    end;

    procedure SetBuyFromVendorFromFilter()
    var
        BuyFromVendorNo: Code[20];
    begin
        BuyFromVendorNo := GetFilterVendNo();
        if BuyFromVendorNo = '' then begin
            FilterGroup(2);
            BuyFromVendorNo := GetFilterVendNo();
            FilterGroup(0);
        end;
        if BuyFromVendorNo <> '' then begin
            Clear(xRec);
            Validate("Buy-from Vendor No.", BuyFromVendorNo);
        end;

        // OnAfterSetBuyFromVendorFromFilter(Rec);
    end;

    procedure CopyBuyFromVendorFilter()
    var
        BuyFromVendorFilter: Text;
        re: Record 10865;
    begin
        BuyFromVendorFilter := GetFilter("Buy-from Vendor No.");
        if BuyFromVendorFilter <> '' then begin
            FilterGroup(2);
            SetFilter("Buy-from Vendor No.", BuyFromVendorFilter);
            FilterGroup(0)
        end;
    end;

    local procedure GetFilterVendNo(): Code[20]
    begin
        if GetFilter("Buy-from Vendor No.") <> '' then
            if GetRangeMin("Buy-from Vendor No.") = GetRangeMax("Buy-from Vendor No.") then
                exit(GetRangeMax("Buy-from Vendor No."));
    end;

    procedure HasBuyFromAddress() Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeHasBuyFromAddress(Rec, Result, IsHandled);
        if IsHandled then
            exit(Result);

        case true of
            "Buy-from Address" <> '':
                exit(true);
            "Buy-from Address 2" <> '':
                exit(true);
            "Buy-from City" <> '':
                exit(true);
            "Buy-from Country/Region Code" <> '':
                exit(true);
            "Buy-from County" <> '':
                exit(true);
            "Buy-from Post Code" <> '':
                exit(true);
            "Buy-from Contact" <> '':
                exit(true);
        end;

        exit(false);
    end;

    procedure HasShipToAddress() Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeHasShipToAddress(Rec, Result, IsHandled);
        if IsHandled then
            exit(Result);

        case true of
            "Ship-to Address" <> '':
                exit(true);
            "Ship-to Address 2" <> '':
                exit(true);
            "Ship-to City" <> '':
                exit(true);
            "Ship-to Country/Region Code" <> '':
                exit(true);
            "Ship-to County" <> '':
                exit(true);
            "Ship-to Post Code" <> '':
                exit(true);
            "Ship-to Contact" <> '':
                exit(true);
        end;

        exit(false);
    end;

    procedure HasPayToAddress() Result: Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeHasPayToAddress(Rec, Result, IsHandled);
        if IsHandled then
            exit(Result);

        case true of
            "Pay-to Address" <> '':
                exit(true);
            "Pay-to Address 2" <> '':
                exit(true);
            "Pay-to City" <> '':
                exit(true);
            "Pay-to Country/Region Code" <> '':
                exit(true);
            "Pay-to County" <> '':
                exit(true);
            "Pay-to Post Code" <> '':
                exit(true);
            "Pay-to Contact" <> '':
                exit(true);
        end;

        exit(false);
    end;

    procedure HasItemChargeAssignment(): Boolean
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
        ItemChargeAssgntPurch.SetRange("Document Type", "Document Type");
        ItemChargeAssgntPurch.SetRange("Document No.", "No.");
        ItemChargeAssgntPurch.SetFilter("Amount to Assign", '<>%1', 0);
        exit(not ItemChargeAssgntPurch.IsEmpty());
    end;

    local procedure CopyBuyFromVendorAddressFieldsFromVendor(var BuyFromVendor: Record Vendor; ForceCopy: Boolean)
    begin
        if BuyFromVendorIsReplaced() or ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) or ForceCopy then begin
            "Buy-from Address" := BuyFromVendor.Address;
            "Buy-from Address 2" := BuyFromVendor."Address 2";
            "Buy-from City" := BuyFromVendor.City;
            "Buy-from Post Code" := BuyFromVendor."Post Code";
            "Buy-from County" := BuyFromVendor.County;
            "Buy-from Country/Region Code" := BuyFromVendor."Country/Region Code";
            // OnAfterCopyBuyFromVendorAddressFieldsFromVendor(Rec, BuyFromVendor);
        end;
    end;

    local procedure CopyShipToVendorAddressFieldsFromVendor(var BuyFromVendor: Record Vendor; ForceCopy: Boolean)
    begin
        if BuyFromVendorIsReplaced() or (not HasShipToAddress()) or ForceCopy then begin
            "Ship-to Address" := BuyFromVendor.Address;
            "Ship-to Address 2" := BuyFromVendor."Address 2";
            "Ship-to City" := BuyFromVendor.City;
            "Ship-to Post Code" := BuyFromVendor."Post Code";
            "Ship-to County" := BuyFromVendor.County;
            Validate("Ship-to Country/Region Code", BuyFromVendor."Country/Region Code");
            //   OnAfterCopyShipToVendorAddressFieldsFromVendor(Rec, BuyFromVendor);
        end;
    end;

    local procedure CopyPayToVendorAddressFieldsFromVendor(var PayToVendor: Record Vendor; ForceCopy: Boolean)
    begin
        if PayToVendorIsReplaced() or ShouldCopyAddressFromPayToVendor(PayToVendor) or ForceCopy then begin
            "Pay-to Address" := PayToVendor.Address;
            "Pay-to Address 2" := PayToVendor."Address 2";
            "Pay-to City" := PayToVendor.City;
            "Pay-to Post Code" := PayToVendor."Post Code";
            "Pay-to County" := PayToVendor.County;
            "Pay-to Country/Region Code" := PayToVendor."Country/Region Code";
            // OnAfterCopyPayToVendorAddressFieldsFromVendor(Rec, PayToVendor);
        end;
    end;

    procedure SetShipToAddress(ShipToName: Text[100]; ShipToName2: Text[50]; ShipToAddress: Text[100]; ShipToAddress2: Text[50]; ShipToCity: Text[30]; ShipToPostCode: Code[20]; ShipToCounty: Text[30]; ShipToCountryRegionCode: Code[10])
    begin
        "Ship-to Name" := ShipToName;
        "Ship-to Name 2" := ShipToName2;
        "Ship-to Address" := ShipToAddress;
        "Ship-to Address 2" := ShipToAddress2;
        "Ship-to City" := ShipToCity;
        "Ship-to Post Code" := ShipToPostCode;
        "Ship-to County" := ShipToCounty;
        "Ship-to Country/Region Code" := ShipToCountryRegionCode;
    end;

    local procedure ShouldCopyAddressFromBuyFromVendor(BuyFromVendor: Record Vendor): Boolean
    begin
        exit((not HasBuyFromAddress()) and BuyFromVendor.HasAddress());
    end;

    local procedure ShouldCopyAddressFromPayToVendor(PayToVendor: Record Vendor): Boolean
    begin
        exit((not HasPayToAddress()) and PayToVendor.HasAddress());
    end;

    procedure ShouldSearchForVendorByName(VendorNo: Code[20]) Result: Boolean
    var
        Vendor: Record Vendor;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit(Result);

        if VendorNo = '' then
            exit(true);

        GetPurchSetup();
        if PurchSetup."Disable Search by Name" then
            exit(false);

        if not Vendor.Get(VendorNo) then
            exit(true);

        exit(not Vendor."Disable Search by Name");
    end;

    local procedure BuyFromVendorIsReplaced(): Boolean
    begin
        exit((xRec."Buy-from Vendor No." <> '') and (xRec."Buy-from Vendor No." <> "Buy-from Vendor No."));
    end;

    local procedure PayToVendorIsReplaced(): Boolean
    begin
        exit((xRec."Pay-to Vendor No." <> '') and (xRec."Pay-to Vendor No." <> "Pay-to Vendor No."));
    end;

    procedure CopyBuyFromAddressToPayToAddress()
    begin
        if "Pay-to Vendor No." = "Buy-from Vendor No." then begin
            "Pay-to Address" := "Buy-from Address";
            "Pay-to Address 2" := "Buy-from Address 2";
            "Pay-to Post Code" := "Buy-from Post Code";
            "Pay-to Country/Region Code" := "Buy-from Country/Region Code";
            "Pay-to City" := "Buy-from City";
            "Pay-to County" := "Buy-from County";
            // OnAfterCopyBuyFromAddressToPayToAddress(Rec);
        end;
    end;

    local procedure UpdatePayToAddressFromBuyFromAddress(FieldNumber: Integer)
    begin
        if ("Order Address Code" = '') and PayToAddressEqualsOldBuyFromAddress() then
            case FieldNumber of
                FieldNo("Pay-to Address"):
                    if xRec."Buy-from Address" = "Pay-to Address" then
                        "Pay-to Address" := "Buy-from Address";
                FieldNo("Pay-to Address 2"):
                    if xRec."Buy-from Address 2" = "Pay-to Address 2" then
                        "Pay-to Address 2" := "Buy-from Address 2";
                FieldNo("Pay-to City"), FieldNo("Pay-to Post Code"):
                    begin
                        if xRec."Buy-from City" = "Pay-to City" then
                            "Pay-to City" := "Buy-from City";
                        if xRec."Buy-from Post Code" = "Pay-to Post Code" then
                            "Pay-to Post Code" := "Buy-from Post Code";
                        if xRec."Buy-from County" = "Pay-to County" then
                            "Pay-to County" := "Buy-from County";
                        if xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" then
                            "Pay-to Country/Region Code" := "Buy-from Country/Region Code";
                    end;
                FieldNo("Pay-to County"):
                    if xRec."Buy-from County" = "Pay-to County" then
                        "Pay-to County" := "Buy-from County";
                FieldNo("Pay-to Country/Region Code"):
                    if xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code" then
                        "Pay-to Country/Region Code" := "Buy-from Country/Region Code";
            end;
        //  OnAfterUpdatePayToAddressFromBuyFromAddress(Rec, xRec, FieldNumber);
    end;

    local procedure PayToAddressEqualsOldBuyFromAddress(): Boolean
    begin
        if (xRec."Buy-from Address" = "Pay-to Address") and
           (xRec."Buy-from Address 2" = "Pay-to Address 2") and
           (xRec."Buy-from City" = "Pay-to City") and
           (xRec."Buy-from County" = "Pay-to County") and
           (xRec."Buy-from Post Code" = "Pay-to Post Code") and
           (xRec."Buy-from Country/Region Code" = "Pay-to Country/Region Code")
        then
            exit(true);
    end;

    procedure ConfirmCloseUnposted() Result: Boolean
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeConfirmCloseUnposted(Rec, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if PurchLinesExist() then
            if InstructionMgt.IsUnpostedEnabledForRecord(Rec) then
                exit(InstructionMgt.ShowConfirm(DocumentNotPostedClosePageQst, InstructionMgt.QueryPostOnCloseCode()));
        exit(true)
    end;

    procedure InitFromPurchHeader(SourcePurchHeader: Record "Purchase Header")
    begin
        "Document Date" := SourcePurchHeader."Document Date";
        "Invoice Received Date" := SourcePurchHeader."Invoice Received Date";
        "Expected Receipt Date" := SourcePurchHeader."Expected Receipt Date";
        "Shortcut Dimension 1 Code" := SourcePurchHeader."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := SourcePurchHeader."Shortcut Dimension 2 Code";
        "Dimension Set ID" := SourcePurchHeader."Dimension Set ID";
        "Location Code" := SourcePurchHeader."Location Code";
        SetShipToAddress(
          SourcePurchHeader."Ship-to Name", SourcePurchHeader."Ship-to Name 2", SourcePurchHeader."Ship-to Address",
          SourcePurchHeader."Ship-to Address 2", SourcePurchHeader."Ship-to City", SourcePurchHeader."Ship-to Post Code",
          SourcePurchHeader."Ship-to County", SourcePurchHeader."Ship-to Country/Region Code");
        "Ship-to Contact" := SourcePurchHeader."Ship-to Contact";

        //  OnInitFromPurchHeader(Rec, SourcePurchHeader);
    end;

    local procedure InitFromVendor(VendorNo: Code[20]; VendorCaption: Text): Boolean
    begin
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        if VendorNo = '' then begin
            if not PurchRqLine.IsEmpty() then
                Error(Text005, VendorCaption);
            Init();
            "No. Series" := xRec."No. Series";
            // OnInitFromVendorOnBeforeInitRecord(Rec, xRec);
            InitRecord();
            InitNoSeries();
            exit(true);
        end;
    end;

    local procedure InitFromContact(ContactNo: Code[20]; VendorNo: Code[20]; ContactCaption: Text): Boolean
    begin
        PurchRqLine.SetRange("Document Type", "Document Type");
        PurchRqLine.SetRange("Document No.", "No.");
        if (ContactNo = '') and (VendorNo = '') then begin
            if not PurchRqLine.IsEmpty() then
                Error(Text005, ContactCaption);
            Init();
            GetPurchSetup();
            "No. Series" := xRec."No. Series";
            //    OnInitFromContactOnBeforeInitRecord(Rec, xRec);
            InitRecord();
            InitNoSeries();
            exit(true);
        end;
    end;

    local procedure LookupContact(VendorNo: Code[20]; ContactNo: Code[20]; var Contact: Record Contact)
    var
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Vendor, VendorNo) then
            Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.")
        else
            Contact.SetRange("Company No.", '');
        if ContactNo <> '' then
            if Contact.Get(ContactNo) then;
    end;

    procedure BuyfromContactLookup(): Boolean
    var
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeLookupBuyFromContactNo(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if "Buy-from Vendor No." <> '' then
            if Contact.Get("Buy-from Contact No.") then
                Contact.SetRange("Company No.", Contact."Company No.")
            else
                if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Vendor, "Buy-from Vendor No.") then
                    Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.")
                else
                    Contact.SetRange("No.", '');

        if "Buy-from Contact No." <> '' then
            if Contact.Get("Buy-from Contact No.") then;
        if Page.RunModal(0, Contact) = Action::LookupOK then begin
            xRec := Rec;
            CurrFieldNo := FieldNo("Buy-from Contact No.");
            Validate("Buy-from Contact No.", Contact."No.");
            exit(true);
        end;
        exit(false);
    end;

    procedure SendRecords()
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        ReportSelections: Record "Report Selections";
        DocTxt: Text[150];
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeSendRecords(Rec, IsHandled);
        if IsHandled then
            exit;

        CheckMixedDropShipment();
        //  OnSendRecordsOnAfterCheckMixedDropShipment(Rec);

        GetReportSelectionsUsageFromDocumentType(ReportSelections.Usage, DocTxt);

        IsHandled := false;
        //  OnSendRecordsOnBeforeSendVendorRecords(ReportSelections.Usage, Rec, DocTxt, IsHandled);
        if not IsHandled then
            DocumentSendingProfile.SendVendorRecords(
                ReportSelections.Usage.AsInteger(), Rec, DocTxt, "Buy-from Vendor No.", "No.",
                FieldNo("Buy-from Vendor No."), FieldNo("No."));
    end;

    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        DummyReportSelections: Record "Report Selections";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforePrintRecords(Rec, ShowRequestForm, IsHandled);
        if IsHandled then
            exit;

        CheckMixedDropShipment();
        //  OnPrintRecordsOnAfterCheckMixedDropShipment(Rec);

        IsHandled := false;
        //  OnPrintRecordsOnBeforeTrySendToPrinterVendor(Rec, IsHandled, ShowRequestForm);
        if not IsHandled then
            DocumentSendingProfile.TrySendToPrinterVendor(
                DummyReportSelections.Usage::"P.Order".AsInteger(), Rec, FieldNo("Buy-from Vendor No."), ShowRequestForm);
    end;

    procedure SendProfile(var DocumentSendingProfile: Record "Document Sending Profile")
    var
        DummyReportSelections: Record "Report Selections";
        ReportDistributionMgt: Codeunit "Report Distribution Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeSendProfile(Rec, DocumentSendingProfile, IsHandled);
        if IsHandled then
            exit;

        CheckMixedDropShipment();
        IsHandled := false;
        //   OnSendProfileOnBeforeSendVendor(Rec, IsHandled);
        if not IsHandled then
            DocumentSendingProfile.SendVendor(
                DummyReportSelections.Usage::"P.Order".AsInteger(), Rec, "No.", "Buy-from Vendor No.",
                ReportDistributionMgt.GetFullDocumentTypeText(Rec), FieldNo("Buy-from Vendor No."), FieldNo("No."));
    end;

    local procedure CheckMixedDropShipment()
    begin
        if HasMixedDropShipment() then
            Error(MixedDropshipmentErr);
    end;

    local procedure HasMixedDropShipment() Result: Boolean
    var
        PurchaseLine: Record "Purchase Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //   OnBeforeHasMixedDropShipment(Rec, Result, IsHandled);
        if IsHandled then
            exit(Result);

        PurchaseLine.SetRange("Document Type", "Document Type");
        PurchaseLine.SetRange("Document No.", "No.");
        PurchaseLine.SetFilter("No.", '<>%1', '');
        PurchaseLine.SetFilter(Type, '%1|%2', PurchaseLine.Type::Item, PurchaseLine.Type::"Fixed Asset");
        PurchaseLine.SetRange("Drop Shipment", true);
        if PurchaseLine.IsEmpty() then
            exit(false);

        PurchaseLine.SetRange("Drop Shipment", false);
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine.IsInventoriableItem() or (PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset") then
                    exit(true);
            until PurchaseLine.Next() = 0;

        exit(false);
    end;

    local procedure SetDefaultPurchaser()
    var
        UserSetupPurchaserCode: Code[20];
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeSetDefaultPurchaser(Rec, IsHandled);
        if IsHandled then
            exit;

        UserSetupPurchaserCode := GetUserSetupPurchaserCode();
        if UserSetupPurchaserCode <> '' then
            if SalespersonPurchaser.Get(UserSetupPurchaserCode) then
                if not SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then
                    Validate("Purchaser Code", UserSetupPurchaserCode);
    end;

    procedure GetUserSetupPurchaserCode(): Code[20]
    var
        UserSetup: Record "User Setup";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeGetUserSetupPurchaserCode(Rec, IsHandled);
        if IsHandled then
            exit;

        if not UserSetup.Get(UserId) then
            exit;

        exit(UserSetup."Salespers./Purch. Code");
    end;

    local procedure InitPostingNoSeries()
    var
#if not CLEAN24
        NoSeriesMgt: Codeunit NoSeriesManagement;
#endif
        PostingNoSeries: Code[20];
    begin
        GLSetup.GetRecordOnce();
        if GLSetup."Journal Templ. Name Mandatory" then begin
            if "Journal Templ. Name" = '' then begin
                if not IsCreditDocType() then
                    GenJournalTemplate.Get(PurchSetup."P. Invoice Template Name")
                else
                    GenJournalTemplate.Get(PurchSetup."P. Cr. Memo Template Name");
                "Journal Templ. Name" := GenJournalTemplate.Name;
            end else
                if GenJournalTemplate.Name = '' then
                    GenJournalTemplate.Get("Journal Templ. Name");
            PostingNoSeries := GenJournalTemplate."Posting No. Series";
        end else
            if IsCreditDocType() then
                PostingNoSeries := PurchSetup."Posted Credit Memo Nos."
            else
                PostingNoSeries := PurchSetup."Posted Invoice Nos.";

        case "Document Type" of
            "Document Type"::Quote, "Document Type"::Order:
                begin
#if CLEAN24                    
                    if NoSeries.IsAutomatic(PostingNoSeries) then
                        "Posting No. Series" := PostingNoSeries;
                    if NoSeries.IsAutomatic(PurchSetup."Posted Receipt Nos.") then
                        "Receiving No. Series" := PurchSetup."Posted Receipt Nos.";
                    if "Document Type" = "Document Type"::Order then begin
                        if NoSeries.IsAutomatic(PurchSetup."Posted Prepmt. Inv. Nos.") then
                            "Prepayment No. Series" := PurchSetup."Posted Prepmt. Inv. Nos.";
                        if NoSeries.IsAutomatic(PurchSetup."Posted Prepmt. Cr. Memo Nos.") then
                            "Prepmt. Cr. Memo No. Series" := PurchSetup."Posted Prepmt. Cr. Memo Nos.";
                    end;
#else
#pragma warning disable AL0432
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series", PostingNoSeries);
                    NoSeriesMgt.SetDefaultSeries("Receiving No. Series", PurchSetup."Posted Receipt Nos.");
                    if "Document Type" = "Document Type"::Order then begin
                        NoSeriesMgt.SetDefaultSeries("Prepayment No. Series", PurchSetup."Posted Prepmt. Inv. Nos.");
                        NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series", PurchSetup."Posted Prepmt. Cr. Memo Nos.");
                    end;
#pragma warning restore AL0432
#endif
                end;
            "Document Type"::Invoice:
                begin
                    if ("No. Series" <> '') and (PurchSetup."Invoice Nos." = PostingNoSeries) then
                        "Posting No. Series" := "No. Series"
                    else
#if CLEAN24
                    if NoSeries.IsAutomatic(PostingNoSeries) then
                        "Posting No. Series" := PostingNoSeries;
#else
#pragma warning disable AL0432
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", PostingNoSeries);
#pragma warning restore AL0432
#endif
                    if PurchSetup."Receipt on Invoice" then
#if CLEAN24
                    if NoSeries.IsAutomatic(PurchSetup."Posted Receipt Nos.") then
                        "Receiving No. Series" := PurchSetup."Posted Receipt Nos.";
#else
#pragma warning disable AL0432
                        NoSeriesMgt.SetDefaultSeries("Receiving No. Series", PurchSetup."Posted Receipt Nos.");
#pragma warning restore AL0432
#endif
                end;
            "Document Type"::"Return Order":
                begin
#if CLEAN24
                    if NoSeries.IsAutomatic(PostingNoSeries) then
                        "Posting No. Series" := PostingNoSeries;
                    if NoSeries.IsAutomatic(PurchSetup."Posted Return Shpt. Nos.") then
                        "Return Shipment No. Series" := PurchSetup."Posted Return Shpt. Nos.";
#else
#pragma warning disable AL0432
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series", PostingNoSeries);
                    NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series", PurchSetup."Posted Return Shpt. Nos.");
#pragma warning restore AL0432
#endif
                end;
            "Document Type"::"Credit Memo":
                begin
                    if ("No. Series" <> '') and (PurchSetup."Credit Memo Nos." = PostingNoSeries) then
                        "Posting No. Series" := "No. Series"
                    else
#if CLEAN24
                    if NoSeries.IsAutomatic(PostingNoSeries) then
                        "Posting No. Series" := PostingNoSeries;
#else
#pragma warning disable AL0432
                        NoSeriesMgt.SetDefaultSeries("Posting No. Series", PostingNoSeries);
#pragma warning restore AL0432
#endif
                    if PurchSetup."Return Shipment on Credit Memo" then
#if CLEAN24
                    if NoSeries.IsAutomatic(PurchSetup."Posted Return Shpt. Nos.") then
                        "Return Shipment No. Series" := PurchSetup."Posted Return Shpt. Nos.";
#else
#pragma warning disable AL0432
                        NoSeriesMgt.SetDefaultSeries("Return Shipment No. Series", PurchSetup."Posted Return Shpt. Nos.");
#pragma warning restore AL0432
#endif
                end;
        end;

        //  OnAfterInitPostingNoSeries(Rec, xRec);
    end;

    local procedure SetShipToCodeEmpty()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeSetShipToCodeEmpty(Rec, IsHandled);
        if IsHandled then
            exit;

        Rec.Validate("Ship-to Code", '');
    end;

    procedure OnAfterValidateBuyFromVendorNo(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader.GetFilter("Buy-from Vendor No.") = xPurchaseHeader."Buy-from Vendor No." then
            if PurchaseHeader."Buy-from Vendor No." <> xPurchaseHeader."Buy-from Vendor No." then
                PurchaseHeader.SetRange("Buy-from Vendor No.");

        SelectDefaultRemitAddress(PurchaseHeader);
    end;

    procedure SelectDefaultRemitAddress(var PurchaseHeader: Record "Purchase Header")
    var
        RemitAddress: Record "Remit Address";
    begin
        RemitAddress.SetRange("Vendor No.", PurchaseHeader."Buy-from Vendor No.");
        RemitAddress.SetRange(Default, true);
        if not RemitAddress.IsEmpty() then begin
            RemitAddress.FindFirst();
            PurchaseHeader.Validate("Remit-to Code", RemitAddress.Code);
        end;
    end;

#if not CLEAN22
    [Obsolete('Replaced by BatchConfirmUpdateDeferralDate with VAT Date parameters.', '22.0')]
    procedure BatchConfirmUpdateDeferralDate(var BatchConfirm: Option " ",Skip,Update; ReplacePostingDate: Boolean; PostingDateReq: Date)
    begin
        if (not ReplacePostingDate) or (PostingDateReq = "Posting Date") or (BatchConfirm = BatchConfirm::Skip) then
            exit;

        if not DeferralHeadersExist() then
            exit;

        "Posting Date" := PostingDateReq;
        case BatchConfirm of
            BatchConfirm::" ":
                begin
                    ConfirmUpdateDeferralDate();
                    if Confirmed then
                        BatchConfirm := BatchConfirm::Update
                    else
                        BatchConfirm := BatchConfirm::Skip;
                end;
            BatchConfirm::Update:
                UpdatePurchLinesByFieldNo(PurchRqLine.FieldNo("Deferral Code"), false);
        end;
        Commit();
    end;
#endif

    procedure BatchConfirmUpdateDeferralDate(var BatchConfirm: Option " ",Skip,Update; ReplacePostingDate: Boolean; PostingDateReq: Date; ReplaceVATDate: Boolean; VATDateReq: Date)
    begin
        if ((not ReplacePostingDate) and (not ReplaceVATDate)) or (BatchConfirm = BatchConfirm::Skip) then
            exit;
        if (PostingDateReq = "Posting Date") and (VATDateReq = "VAT Reporting Date") then
            exit;
        if not DeferralHeadersExist() then
            exit;

        if ReplacePostingDate then
            "Posting Date" := PostingDateReq;
        if ReplaceVATDate then
            "VAT Reporting Date" := VATDateReq;

        case BatchConfirm of
            BatchConfirm::" ":
                begin
                    ConfirmUpdateDeferralDate();
                    if Confirmed then
                        BatchConfirm := BatchConfirm::Update
                    else
                        BatchConfirm := BatchConfirm::Skip;
                end;
            BatchConfirm::Update:
                UpdatePurchLinesByFieldNo(PurchRqLine.FieldNo("Deferral Code"), false);
        end;
        Commit();
    end;

    procedure BatchConfirmUpdatePostingDate(ReplacePostingDate: Boolean; PostingDateReq: Date; ReplaceDocDate: Boolean)
    begin
        if not ReplacePostingDate then
            exit;
        if (PostingDateReq = "Posting Date") then
            exit;
        if DeferralHeadersExist() then
            exit;

        if ReplacePostingDate then begin
            "Posting Date" := PostingDateReq;
            Validate("Currency Code");
        end;

        if ReplacePostingDate and ReplaceDocDate and ("Document Date" <> PostingDateReq) then begin
            SetReplaceDocumentDate();
            Validate("Document Date", PostingDateReq);
        end;

        Commit();
    end;

    procedure SetAllowSelectNoSeries()
    begin
        SelectNoSeriesAllowed := true;
    end;

    local procedure ModifyPayToVendorAddress()
    var
        Vendor: Record Vendor;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeModifyPayToVendorAddress(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        GetPurchSetup();
        if PurchSetup."Ignore Updated Addresses" then
            exit;
        if IsCreditDocType() then
            exit;
        if ("Pay-to Vendor No." <> "Buy-from Vendor No.") and Vendor.Get("Pay-to Vendor No.") then
            if HasPayToAddress() and HasDifferentPayToAddress(Vendor) then
                ShowModifyAddressNotification(GetModifyPayToVendorAddressNotificationId(),
                  ModifyVendorAddressNotificationLbl, ModifyVendorAddressNotificationMsg,
                  'CopyPayToVendorAddressFieldsFromSalesDocument', "Pay-to Vendor No.",
                  "Pay-to Name", FieldName("Pay-to Vendor No."));
    end;

    local procedure ModifyVendorAddress()
    var
        Vendor: Record Vendor;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeModifyVendorAddress(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        GetPurchSetup();
        if PurchSetup."Ignore Updated Addresses" then
            exit;
        if IsCreditDocType() then
            exit;
        if Vendor.Get("Buy-from Vendor No.") and HasBuyFromAddress() and HasDifferentBuyFromAddress(Vendor) then
            ShowModifyAddressNotification(GetModifyVendorAddressNotificationId(),
              ModifyVendorAddressNotificationLbl, ModifyVendorAddressNotificationMsg,
              'CopyBuyFromVendorAddressFieldsFromSalesDocument', "Buy-from Vendor No.",
              "Buy-from Vendor Name", FieldName("Buy-from Vendor No."));
    end;

    local procedure ShowModifyAddressNotification(NotificationID: Guid; NotificationLbl: Text; NotificationMsg: Text; NotificationFunctionTok: Text; VendorNumber: Code[20]; VendorName: Text[100]; VendorNumberFieldName: Text)
    var
        MyNotifications: Record "My Notifications";
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        ModifyVendorAddressNotification: Notification;
    begin
        if not MyNotifications.IsEnabled(NotificationID) then
            exit;

        ModifyVendorAddressNotification.Id := NotificationID;
        ModifyVendorAddressNotification.Message := StrSubstNo(NotificationMsg, VendorName);
        ModifyVendorAddressNotification.AddAction(NotificationLbl, CODEUNIT::"Document Notifications", NotificationFunctionTok);
        ModifyVendorAddressNotification.AddAction(
          DontShowAgainActionLbl, CODEUNIT::"Document Notifications", 'HidePurchaseNotificationForCurrentUser');
        ModifyVendorAddressNotification.Scope := NOTIFICATIONSCOPE::LocalScope;
        ModifyVendorAddressNotification.SetData(FieldName("Document Type"), Format("Document Type"));
        ModifyVendorAddressNotification.SetData(FieldName("No."), "No.");
        ModifyVendorAddressNotification.SetData(VendorNumberFieldName, VendorNumber);
        NotificationLifecycleMgt.SendNotification(ModifyVendorAddressNotification, RecordId);
    end;

    procedure RecallModifyAddressNotification(NotificationID: Guid)
    var
        MyNotifications: Record "My Notifications";
        ModifyVendorAddressNotification: Notification;
    begin
        if IsCreditDocType() or (not MyNotifications.IsEnabled(NotificationID)) then
            exit;
        ModifyVendorAddressNotification.Id := NotificationID;
        ModifyVendorAddressNotification.Recall();
    end;

    procedure GetModifyVendorAddressNotificationId(): Guid
    begin
        exit('CF3D0CD3-C54A-47D1-8A3F-57A6CCBA8DDE');
    end;

    procedure GetModifyPayToVendorAddressNotificationId(): Guid
    begin
        exit('16E45B3A-CB9F-4B2C-9F08-2BCE39E9E980');
    end;

    procedure GetShowExternalDocAlreadyExistNotificationId(): Guid
    begin
        exit('D87F624C-D3BE-4E6B-A369-D18AE269181A');
    end;

    procedure GetLineInvoiceDiscountResetNotificationId(): Guid
    begin
        exit('3DC9C8BC-0512-4A49-B587-256C308EBCAA');
    end;

    procedure GetWarnWhenZeroQuantityPurchaseLinePosting(): Guid
    begin
        exit('68354b20-7f89-11ec-a8a3-0242ac120002');
    end;

    procedure SetModifyVendorAddressNotificationDefaultState()
    var
        MyNotifications: Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetModifyVendorAddressNotificationId(),
          ModifyBuyFromVendorAddressNotificationNameTxt, ModifyBuyFromVendorAddressNotificationDescriptionTxt, true);
    end;

    procedure SetModifyPayToVendorAddressNotificationDefaultState()
    var
        MyNotifications: Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetModifyPayToVendorAddressNotificationId(),
          ModifyPayToVendorAddressNotificationNameTxt, ModifyPayToVendorAddressNotificationDescriptionTxt, true);
    end;

    procedure SetShowExternalDocAlreadyExistNotificationDefaultState(DefaultState: Boolean)
    var
        MyNotifications: Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetShowExternalDocAlreadyExistNotificationId(),
          ShowDocAlreadyExistNotificationNameTxt, ShowDocAlreadyExistNotificationDescriptionTxt, DefaultState);
    end;

    procedure DontNotifyCurrentUserAgain(NotificationID: Guid)
    var
        MyNotifications: Record "My Notifications";
    begin
        if not MyNotifications.Disable(NotificationID) then
            case NotificationID of
                GetModifyVendorAddressNotificationId():
                    MyNotifications.InsertDefault(NotificationID, ModifyBuyFromVendorAddressNotificationNameTxt,
                      ModifyBuyFromVendorAddressNotificationDescriptionTxt, false);
                GetModifyPayToVendorAddressNotificationId():
                    MyNotifications.InsertDefault(NotificationID, ModifyPayToVendorAddressNotificationNameTxt,
                      ModifyPayToVendorAddressNotificationDescriptionTxt, false);
            end;
    end;

    local procedure HasDifferentBuyFromAddress(Vendor: Record Vendor) Result: Boolean
    begin
        Result := ("Buy-from Address" <> Vendor.Address) or
          ("Buy-from Address 2" <> Vendor."Address 2") or
          ("Buy-from City" <> Vendor.City) or
          ("Buy-from Country/Region Code" <> Vendor."Country/Region Code") or
          ("Buy-from County" <> Vendor.County) or
          ("Buy-from Post Code" <> Vendor."Post Code") or
          ("Buy-from Contact" <> Vendor.Contact);
        //  OnAfterHasDifferentBuyFromAddress(Rec, Vendor, Result);
    end;

    local procedure HasDifferentPayToAddress(Vendor: Record Vendor) Result: Boolean
    begin
        Result := ("Pay-to Address" <> Vendor.Address) or
          ("Pay-to Address 2" <> Vendor."Address 2") or
          ("Pay-to City" <> Vendor.City) or
          ("Pay-to Country/Region Code" <> Vendor."Country/Region Code") or
          ("Pay-to County" <> Vendor.County) or
          ("Pay-to Post Code" <> Vendor."Post Code") or
          ("Pay-to Contact" <> Vendor.Contact);
        //  OnAfterHasDifferentPayToAddress(Rec, Vendor, Result);
    end;

    procedure SetWarnZeroQuantityPurchasePosting()
    var
        MyNotifications: Record "My Notifications";
    begin
        MyNotifications.InsertDefault(GetWarnWhenZeroQuantityPurchaseLinePosting(),
         WarnZeroQuantityPostingTxt, WarnZeroQuantityPostingDescriptionTxt, true);
    end;

    procedure FindPostedDocumentWithSameExternalDocNo(var VendorLedgerEntry: Record "Vendor Ledger Entry"; ExternalDocumentNo: Code[35]): Boolean
    var
        VendorMgt: Codeunit "Vendor Mgt.";
    begin
        VendorMgt.SetFilterForExternalDocNo(
          VendorLedgerEntry, GetGenJnlDocumentType(), ExternalDocumentNo, "Pay-to Vendor No.", "Document Date");
        exit(VendorLedgerEntry.FindFirst())
    end;

    procedure FilterPartialReceived()
    var
        PurchaseHeaderOriginal: Record "Purchase Header";
        ReceiveFilter: Text;
        IsMarked: Boolean;
        ReceiveValue: Boolean;
    begin
        ReceiveFilter := GetFilter(Receive);
        SetRange(Receive);
        Evaluate(ReceiveValue, ReceiveFilter);

        // PurchaseHeaderOriginal := Rec;
        if FindSet() then
            repeat
                if not HasReceivedLines() then
                    IsMarked := not ReceiveValue
                else
                    IsMarked := ReceiveValue;
                Mark(IsMarked);
            until Next() = 0;

        // Rec := PurchaseHeaderOriginal;
        MarkedOnly(true);
    end;

    procedure FilterPartialInvoiced()
    var
        PurchaseHeaderOriginal: Record "Purchase Header";
        InvoiceFilter: Text;
        IsMarked: Boolean;
        InvoiceValue: Boolean;
    begin
        InvoiceFilter := GetFilter(Invoice);
        SetRange(Invoice);
        Evaluate(InvoiceValue, InvoiceFilter);

        //    PurchaseHeaderOriginal := Rec;
        if FindSet() then
            repeat
                if not HasInvoicedLines() then
                    IsMarked := not InvoiceValue
                else
                    IsMarked := InvoiceValue;
                Mark(IsMarked);
            until Next() = 0;

        //   Rec := PurchaseHeaderOriginal;
        MarkedOnly(true);
    end;

    local procedure HasReceivedLines(): Boolean
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", "Document Type");
        PurchaseLine.SetRange("Document No.", "No.");
        PurchaseLine.SetFilter("No.", '<>%1', '');
        PurchaseLine.SetFilter("Quantity Received", '<>%1', 0);
        exit(not PurchaseLine.IsEmpty);
    end;

    local procedure HasInvoicedLines(): Boolean
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", "Document Type");
        PurchaseLine.SetRange("Document No.", "No.");
        PurchaseLine.SetFilter("No.", '<>%1', '');
        PurchaseLine.SetFilter("Quantity Invoiced", '<>%1', 0);
        exit(not PurchaseLine.IsEmpty);
    end;

    local procedure ShowExternalDocAlreadyExistNotification(VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
        InstructionMgt: Codeunit "Instruction Mgt.";
        DocAlreadyExistNotification: Notification;
    begin
        InstructionMgt.CreateMissingMyNotificationsWithDefaultState(GetShowExternalDocAlreadyExistNotificationId());

        if not IsDocAlreadyExistNotificationEnabled() then
            exit;

        DocAlreadyExistNotification.Id := GetShowExternalDocAlreadyExistNotificationId();
        DocAlreadyExistNotification.Message :=
          StrSubstNo(PurchaseAlreadyExistsTxt, VendorLedgerEntry."Document Type", VendorLedgerEntry."External Document No.");
        DocAlreadyExistNotification.AddAction(ShowVendLedgEntryTxt, CODEUNIT::"Document Notifications", 'ShowVendorLedgerEntry');
        DocAlreadyExistNotification.Scope := NOTIFICATIONSCOPE::LocalScope;
        DocAlreadyExistNotification.SetData(FieldName("Document Type"), Format("Document Type"));
        DocAlreadyExistNotification.SetData(FieldName("No."), "No.");
        DocAlreadyExistNotification.SetData(VendorLedgerEntry.FieldName("Entry No."), Format(VendorLedgerEntry."Entry No."));
        NotificationLifecycleMgt.SendNotificationWithAdditionalContext(
          DocAlreadyExistNotification, RecordId, GetShowExternalDocAlreadyExistNotificationId());
    end;

    local procedure GetGenJnlDocumentType(): Enum "Gen. Journal Document Type"
    var
        RefGenJournalLine: Record "Gen. Journal Line";
    begin
        case "Document Type" of
            "Document Type"::"Blanket Order",
            "Document Type"::Quote,
            "Document Type"::Invoice,
            "Document Type"::Order:
                exit(RefGenJournalLine."Document Type"::Invoice);
            else
                exit(RefGenJournalLine."Document Type"::"Credit Memo");
        end;
    end;

    local procedure RecallExternalDocAlreadyExistsNotification()
    var
        NotificationLifecycleMgt: Codeunit "Notification Lifecycle Mgt.";
    begin
        if not IsDocAlreadyExistNotificationEnabled() then
            exit;

        NotificationLifecycleMgt.RecallNotificationsForRecordWithAdditionalContext(
          RecordId, GetShowExternalDocAlreadyExistNotificationId(), true);
    end;

    procedure IsDocAlreadyExistNotificationEnabled(): Boolean
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        exit(InstructionMgt.IsMyNotificationEnabled(GetShowExternalDocAlreadyExistNotificationId()));
    end;

    procedure ShipToAddressEqualsCompanyShipToAddress(): Boolean
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get();
        //  exit(IsShipToAddressEqualToCompanyShipToAddress(Rec, CompanyInformation));
    end;

    local procedure IsShipToAddressEqualToCompanyShipToAddress(PurchaseHeader: Record "Purchase Header"; CompanyInformation: Record "Company Information") Result: Boolean
    begin
        Result :=
          (PurchaseHeader."Ship-to Address" = CompanyInformation."Ship-to Address") and
          (PurchaseHeader."Ship-to Address 2" = CompanyInformation."Ship-to Address 2") and
          (PurchaseHeader."Ship-to City" = CompanyInformation."Ship-to City") and
          (PurchaseHeader."Ship-to County" = CompanyInformation."Ship-to County") and
          (PurchaseHeader."Ship-to Post Code" = CompanyInformation."Ship-to Post Code") and
          (PurchaseHeader."Ship-to Country/Region Code" = CompanyInformation."Ship-to Country/Region Code") and
          (PurchaseHeader."Ship-to Name" = CompanyInformation."Ship-to Name");

        //  OnAfterIsShipToAddressEqualToCompanyShipToAddress(Rec, CompanyInformation, Result);
    end;

    procedure BuyFromAddressEqualsShipToAddress() Result: Boolean
    begin
        Result :=
          ("Ship-to Address" = "Buy-from Address") and
          ("Ship-to Address 2" = "Buy-from Address 2") and
          ("Ship-to City" = "Buy-from City") and
          ("Ship-to County" = "Buy-from County") and
          ("Ship-to Post Code" = "Buy-from Post Code") and
          ("Ship-to Country/Region Code" = "Buy-from Country/Region Code") and
          ("Ship-to Name" = "Buy-from Vendor Name");

        // OnAfterBuyFromAddressEqualsShipToAddress(Rec, Result);
    end;

    procedure BuyFromAddressEqualsPayToAddress() Result: Boolean
    begin
        Result :=
          ("Pay-to Address" = "Buy-from Address") and
          ("Pay-to Address 2" = "Buy-from Address 2") and
          ("Pay-to City" = "Buy-from City") and
          ("Pay-to County" = "Buy-from County") and
          ("Pay-to Post Code" = "Buy-from Post Code") and
          ("Pay-to Country/Region Code" = "Buy-from Country/Region Code") and
          ("Pay-to Contact No." = "Buy-from Contact No.") and
          ("Pay-to Contact" = "Buy-from Contact");

        // OnAfterBuyFromAddressEqualsPayToAddress(Rec, Result);
    end;

    local procedure SetPurchaserCode(PurchaserCodeToCheck: Code[20]; var PurchaserCodeToAssign: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeSetPurchaserCode(Rec, PurchaserCodeToCheck, PurchaserCodeToAssign, IsHandled);
        if IsHandled then
            exit;

        if PurchaserCodeToCheck = '' then
            PurchaserCodeToCheck := GetUserSetupPurchaserCode();
        if SalespersonPurchaser.Get(PurchaserCodeToCheck) then begin
            if SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then
                PurchaserCodeToAssign := ''
            else
                PurchaserCodeToAssign := PurchaserCodeToCheck;
        end else
            PurchaserCodeToAssign := '';
    end;

    procedure ValidatePurchaserOnPurchHeader(PurchaseHeader2: Record "Purchase Request"; IsTransaction: Boolean; IsPostAction: Boolean)
    begin
        if PurchaseHeader2."Purchaser Code" <> '' then
            if SalespersonPurchaser.Get(PurchaseHeader2."Purchaser Code") then
                if SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then begin
                    if IsTransaction then
                        Error(
                            ErrorInfo.Create(
                                SalespersonPurchaser.GetPrivacyBlockedTransactionText(SalespersonPurchaser, IsPostAction, false),
                                true,
                                SalespersonPurchaser));
                    if not IsTransaction then
                        Error(
                            ErrorInfo.Create(
                                SalespersonPurchaser.GetPrivacyBlockedGenericText(SalespersonPurchaser, false),
                                true,
                                SalespersonPurchaser));
                end;
    end;

    local procedure GetReportSelectionsUsageFromDocumentType(var ReportSelectionsUsage: Enum "Report Selection Usage"; var DocTxt: Text[150])
    var
        ReportSelections: Record "Report Selections";
        ReportDistributionMgt: Codeunit "Report Distribution Management";
        ReportUsage: Option;
    begin
        DocTxt := ReportDistributionMgt.GetFullDocumentTypeText(Rec);

        case "Document Type" of
            "Document Type"::Order:
                ReportSelectionsUsage := ReportSelections.Usage::"P.Order";
            "Document Type"::Quote:
                ReportSelectionsUsage := ReportSelections.Usage::"P.Quote";
        end;

        ReportUsage := ReportSelectionsUsage.AsInteger();
        //  OnAfterGetReportSelectionsUsageFromDocumentType(Rec, ReportUsage, DocTxt);
        ReportSelectionsUsage := Enum::"Report Selection Usage".FromInteger(ReportUsage);
    end;

    procedure CanCalculateTax(): Boolean
    begin
        exit(SkipTaxCalculation);
    end;

    procedure SetSkipTaxCalulation(Skip: Boolean)
    begin
        SkipTaxCalculation := Skip;
    end;

    procedure ValidateEmptySellToCustomerAndLocation()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeValidateEmptySellToCustomerAndLocation(Rec, Vend, IsHandled, xRec);
        if IsHandled then
            exit;

        Validate("Sell-to Customer No.", '');

        if "Buy-from Vendor No." <> '' then
            GetVend("Buy-from Vendor No.");
        UpdateLocationCode(Vend."Location Code");
    end;

    procedure CheckForBlockedLines()
    var
        CurrentPurchRqLine: Record "Purchase request Line";
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        Resource: Record Resource;
    begin
        CurrentPurchRqLine.SetCurrentKey("Document Type", "Document No.", Type);
        CurrentPurchRqLine.SetRange("Document Type", "Document Type");
        CurrentPurchRqLine.SetRange("Document No.", "No.");
        CurrentPurchRqLine.SetFilter(Type, '%1|%2', CurrentPurchRqLine.Type::Item, CurrentPurchRqLine.Type::Resource);
        CurrentPurchRqLine.SetFilter("No.", '<>''''');
        if "Document Type" = "Document Type"::"Blanket Order" then
            CurrentPurchRqLine.SetFilter("Qty. to Receive", '<>0');

        if CurrentPurchRqLine.FindSet() then
            repeat
                case CurrentPurchRqLine.Type of
                    CurrentPurchRqLine.Type::Item:
                        begin
                            Item.Get(CurrentPurchRqLine."No.");
                            Item.TestField(Blocked, false);

                            if CurrentPurchRqLine."Variant Code" <> '' then begin
                                ItemVariant.SetLoadFields(Blocked);
                                ItemVariant.Get(CurrentPurchRqLine."No.", CurrentPurchRqLine."Variant Code");
                                ItemVariant.TestField(Blocked, false);
                            end
                        end;
                    CurrentPurchRqLine.Type::Resource:
                        begin
                            Resource.Get(CurrentPurchRqLine."No.");
                            Resource.CheckResourcePrivacyBlocked(false);
                            Resource.TestField(Blocked, false);
                        end;
                end;
            until CurrentPurchRqLine.Next() = 0;
    end;

    procedure TestStatusIsNotPendingApproval() NotPending: Boolean;
    begin
        NotPending := Status <> Status::"Pending Approval";

        //   OnTestStatusIsNotPendingApproval(Rec, NotPending);
    end;

    procedure TestStatusIsNotPendingPrepayment() NotPending: Boolean;
    begin
        NotPending := Status <> Status::"Pending Prepayment";

        //  OnTestStatusIsNotPendingPrepayment(Rec, NotPending);
    end;

    procedure TestStatusIsNotReleased() NotReleased: Boolean;
    begin
        NotReleased := Status <> Status::Released;

        //  OnTestStatusIsNotReleased(Rec, NotReleased);
    end;

    procedure TestStatusOpen()
    var
        Recusertsetup: Record "User Setup";
    begin
        //OnBeforeTestStatusOpen(Rec, xRec, CurrFieldNo);

        if StatusCheckSuspended then
            exit;
        TestField(Statut, Statut::Open);

    end;

    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
        StatusCheckSuspended := Suspend;
    end;

    procedure UpdateInboundWhseHandlingTime()
    begin
        if "Location Code" = '' then begin
            if InvtSetup.Get() then
                "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
        end else begin
            if Location.Get("Location Code") then;
            "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
        end;

        //  OnAfterUpdateInboundWhseHandlingTime(Rec, CurrFieldNo);
    end;

    procedure GetFullDocTypeTxt() FullDocTypeTxt: Text
    var
        IsHandled: Boolean;
    begin
        //   OnBeforeGetFullDocTypeTxt(Rec, FullDocTypeTxt, IsHandled);

        if IsHandled then
            exit;

        FullDocTypeTxt := SelectStr("Document Type".AsInteger() + 1, FullPurchaseTypesTxt);
    end;

    local procedure LookupPostCode(var City: Text[30]; var PCode: Code[20]; var County: Text[30]; var CountryRegionCode: Code[10]; CalledFromFieldNo: Integer)
    var
        xRecPurchaseHeader: Record "Purchase Header";
    begin
        // xRecPurchaseHeader := Rec;
        PostCode.LookupPostCode(City, PCode, County, CountryRegionCode);
        // OnLookupPostCode(CalledFromFieldNo, xRecPurchaseHeader, Rec);
    end;

    procedure CopyDocument()
    var
        CopyPurchaseDocument: Report "Copy Purchase Document";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeCopyDocument(Rec, IsHandled);
        if IsHandled then
            exit;

        //  CopyPurchaseDocument.SetPurchHeader(Rec);
        CopyPurchaseDocument.RunModal();
    end;

    local procedure CheckContactRelatedToVendorCompany(ContactNo: Code[20]; VendorNo: Code[20]; CurrFieldNo: Integer);
    var
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeCheckContactRelatedToVendorCompany(Rec, CurrFieldNo, IsHandled);
        if IsHandled then
            exit;

        Contact.Get(ContactNo);
        if ContactBusinessRelation.FindByRelation(Enum::"Contact Business Relation Link to Table"::Vendor, VendorNo) then
            if (ContactBusinessRelation."Contact No." <> Contact."Company No.") and (ContactBusinessRelation."Contact No." <> Contact."No.") then
                Error(Text038, Contact."No.", Contact.Name, VendorNo);
    end;

    local procedure CheckBlockedVendOnDocs(Vend: Record Vendor)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCheckBlockedVendOnDocs(Rec, xRec, Vend, CurrFieldNo, IsHandled);
        if IsHandled then
            exit;

        Vend.CheckBlockedVendOnDocs(Vend, false);
    end;

    procedure LookupBuyFromVendorName(var VendorName: Text): Boolean
    var
        Vendor: Record Vendor;
        LookupStateManager: Codeunit "Lookup State Manager";
        RecVariant: Variant;
        SearchVendorName: Text;
    begin
        SearchVendorName := VendorName;
        Vendor.SetFilter("Date Filter", GetFilter("Date Filter"));
        if "Buy-from Vendor No." <> '' then
            Vendor.Get("Buy-from Vendor No.");

        if Vendor.SelectVendor(Vendor) then begin
            if Rec."Buy-from Vendor Name" = Vendor.Name then
                VendorName := SearchVendorName
            else
                VendorName := Vendor.Name;
            RecVariant := Vendor;
            LookupStateManager.SaveRecord(RecVariant);
            exit(true);
        end;
    end;

    procedure LookupPayToVendorName(var VendorName: Text): Boolean
    var
        Vendor: Record Vendor;
        LookupStateManager: Codeunit "Lookup State Manager";
        RecVariant: Variant;
        SearchVendorName: Text;
    begin
        SearchVendorName := VendorName;
        Vendor.SetFilter("Date Filter", GetFilter("Date Filter"));
        if "Pay-to Vendor No." <> '' then
            Vendor.Get("Pay-To Vendor No.");

        if Vendor.SelectVendor(Vendor) then begin
            if Rec."Pay-To Name" = Vendor.Name then
                VendorName := SearchVendorName
            else
                VendorName := Vendor.Name;
            RecVariant := Vendor;
            LookupStateManager.SaveRecord(RecVariant);
            exit(true);
        end;
    end;

    local procedure CheckVendorPostingGroupChange()
    var
        PayToVendor: Record Vendor;
        PostingGroupChangeInterface: Interface "Posting Group Change Method";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //    OnBeforeCheckVendorPostingGroupChange(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if ("Vendor Posting Group" <> xRec."Vendor Posting Group") and (xRec."Vendor Posting Group" <> '') then begin
            TestField("Pay-to Vendor No.");
            PayToVendor.Get("Pay-to Vendor No.");
            GetPurchSetup();
            if PurchSetup."Allow Multiple Posting Groups" then begin
                PayToVendor.TestField("Allow Multiple Posting Groups");
                PostingGroupChangeInterface := PurchSetup."Check Multiple Posting Groups";
                PostingGroupChangeInterface.ChangePostingGroup("Vendor Posting Group", xRec."Vendor Posting Group", Rec);
            end;
        end;
    end;

    procedure RecreateTempPurchLines(var TempPurchLine: Record "Purchase request Line")
    begin
        repeat
            TestPurchLineFieldsBeforeRecreate();
            TempPurchLine := PurchRQLine;
            if PurchRqLine.Nonstock then begin
                PurchRqLine.Nonstock := false;
                PurchRqLine.Modify();
            end;
            //   OnRecreatePurchLinesOnBeforeTempPurchLineInsert(TempPurchLine, PurchLine);
            if not IsServiceChargeLine(PurchRQLine) then
                TempPurchLine.Insert();
        //  OnRecreateTempPurchLinesOnAfterTempPurchLineInsert(Rec, PurchLine, TempPurchLine);
        until PurchRqLine.Next() = 0;
    end;

    local procedure IsServiceChargeLine(PurchLine: Record "Purchase request Line"): Boolean
    begin
        if PurchRqLine."System-Created Entry" then
            if PurchRqLine.Type = PurchRqLine.Type::"G/L Account" then
                if PurchRqLine.IsServiceCharge() then
                    exit(true);
    end;

    local procedure TestPurchLineFieldsBeforeRecreate()
    var
        SalesHeader: Record "Sales Header";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeTestPurchLineFieldsBeforeRecreate(Rec, PurchLine, IsHandled);
        if IsHandled then
            exit;

        PurchRqLine.TestField("Quantity Received", 0);
        PurchRqLine.TestField("Quantity Invoiced", 0);
        PurchRqLine.TestField("Return Qty. Shipped", 0);
        PurchRqLine.CalcFields("Reserved Qty. (Base)");
        PurchRqLine.TestField("Reserved Qty. (Base)", 0);
        PurchRqLine.TestField("Receipt No.", '');
        PurchRqLine.TestField("Return Shipment No.", '');
        PurchRqLine.TestField("Blanket Order No.", '');
        IsHandled := false;
        //  OnRecreatePurchLinesOnDropShipmentSpecialOrder(PurchLine, IsHandled);
        if not IsHandled then
            if PurchRqLine."Drop Shipment" or PurchRqLine."Special Order" then begin
                case true of
                    PurchRqLine."Drop Shipment":
                        SalesHeader.Get(SalesHeader."Document Type"::Order, PurchRqLine."Sales Order No.");
                    PurchRqLine."Special Order":
                        SalesHeader.Get(SalesHeader."Document Type"::Order, PurchRqLine."Special Order Sales No.");
                end;
                TestField("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
                CheckShipToCode(SalesHeader."Ship-to Code");
            end;

        PurchRqLine.TestField("Prepmt. Amt. Inv.", 0);
    end;

    procedure DeletePurchCommentLines()
    var
        PurchCommentLine: Record "Purch. Comment Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeDeletePurchCommentLines(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        PurchCommentLine.DeleteComments("Document Type".AsInteger(), "No.");
    end;

    procedure DeletePurchLines(var PurchLine: Record "Purchase request Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeDeletePurchLines(Rec, xRec, PurchLine, IsHandled);
        if IsHandled then
            exit;

        PurchRqLine.DeleteAll(true);
    end;

    procedure GetCalledFromWhseDoc(): Boolean
    begin
        exit(CalledFromWhseDoc);
    end;

    procedure SetCalledFromWhseDoc(NewCalledFromWhseDoc: Boolean)
    begin
        CalledFromWhseDoc := NewCalledFromWhseDoc;
    end;

    procedure SetReplaceDocumentDate()
    begin
        ReplaceDocumentDate := true;
    end;

    local procedure UpdatePrepmtAmounts(var PurchaseLine: Record "Purchase Line")
    var
        Currency: Record Currency;
    begin
        Currency.Initialize("Currency Code");
        if "Document Type" = "Document Type"::Order then begin
            PurchaseLine."Prepmt. Line Amount" := Round(
                PurchaseLine."Line Amount" * PurchaseLine."Prepayment %" / 100, Currency."Amount Rounding Precision");
            if Abs(PurchaseLine."Inv. Discount Amount" + PurchaseLine."Prepmt. Line Amount") > Abs(PurchaseLine."Line Amount") then
                PurchaseLine."Prepmt. Line Amount" := PurchaseLine."Line Amount" - PurchaseLine."Inv. Discount Amount";
        end;
    end;

    procedure GetUseDate(): Date
    begin
        if "Posting Date" = 0D then
            exit(WorkDate());

        exit("Posting Date");
    end;

    local procedure CreateDimensionsFromValidatePayToVendorNo()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //  OnBeforeCreateDimensionsFromValidatePayToVendorNo(Rec, IsHandled);
        if IsHandled then
            exit;

        CreateDimFromDefaultDim(Rec.FieldNo("Pay-to Vendor No."));
    end;

    procedure CreateDimFromDefaultDim(FieldNo: Integer)
    var
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        InitDefaultDimensionSources(DefaultDimSource, FieldNo);
        CreateDim(DefaultDimSource);
    end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        DimMgt.AddDimSource(DefaultDimSource, Database::Vendor, Rec."Pay-to Vendor No.", FieldNo = Rec.FieldNo("Pay-to Vendor No."));
        DimMgt.AddDimSource(DefaultDimSource, Database::"Salesperson/Purchaser", Rec."Purchaser Code", FieldNo = Rec.FieldNo("Purchaser Code"));
        DimMgt.AddDimSource(DefaultDimSource, Database::Campaign, Rec."Campaign No.", FieldNo = Rec.FieldNo("Campaign No."));
        DimMgt.AddDimSource(DefaultDimSource, Database::"Responsibility Center", Rec."Responsibility Center", FieldNo = Rec.FieldNo("Responsibility Center"));
        DimMgt.AddDimSource(DefaultDimSource, Database::Location, Rec."Location Code", FieldNo = Rec.FieldNo("Location Code"));

        //   OnAfterInitDefaultDimensionSources(Rec, DefaultDimSource, FieldNo);
    end;

    local procedure ShouldCheckShowRecurringSalesLines(var xHeader: Record "Purchase Header"; var Header: Record "Purchase Header"): Boolean
    begin
        exit(
            (xHeader."Pay-to Vendor No." <> '') and
            (Header."No." <> '') and
            (Header."Currency Code" <> xHeader."Currency Code")
        );
    end;

    procedure PurchaseLinesEditable() IsEditable: Boolean;
    begin
        IsEditable := Rec."Buy-from Vendor No." <> '';

        // OnAfterPurchaseLinesEditable(Rec, IsEditable);
    end;

    internal procedure GetQtyReservedFromStockState() Result: Enum "Reservation From Stock"
    var
        PurchaseLineLocal: Record "Purchase Line";
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        QtyReservedFromStock: Decimal;
    begin
        //  QtyReservedFromStock := PurchLineReserve.GetReservedQtyFromInventory(Rec);

        PurchaseLineLocal.SetRange("Document Type", "Document Type");
        PurchaseLineLocal.SetRange("Document No.", "No.");
        PurchaseLineLocal.SetRange(Type, PurchaseLineLocal.Type::Item);
        PurchaseLineLocal.CalcSums("Outstanding Qty. (Base)");

        case QtyReservedFromStock of
            0:
                exit(Result::None);
            PurchaseLineLocal."Outstanding Qty. (Base)":
                exit(Result::Full);
            else
                exit(Result::Partial);
        end;
    end;

    procedure TestPurchasePrepayment()
    var
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
    begin

    end;

}

