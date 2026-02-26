Table 8004172 "Job Planning Line2"
{
    // //PROJET MB 12/07/07 +wSetType
    //          MB 19/07/07 +Order line type
    //                      + Key Job No.,Job Task No.,Gen. Prod. Posting Group
    //                            ,Type,Resource Type,No.,Variant Code
    // //MIGRATION5.00 MB 23/05/07 Ajout des champs Resource Type,Entry Type,Gross Total Cost,Document Type
    //                             Ajout de la clé Document Type,Document No.
    //                    28/05/07 Ajout de la clé Job No.,Type,Resource Type,Entry Type
    //                                              Type,No.,Work Type Code,Planning Date
    // //MASK CW 24/05/07 +"Mask Code"

    Caption = 'Job Planning Line';
    //DrillDownPageID = 8004185;
    //LookupPageID = 8004185;
    PasteIsValid = false;
    Permissions = TableData "Job Entry No.2" = rimd;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Editable = false;
            TableRelation = Job2;
        }
        field(3; "Planning Date"; Date)
        {
            Caption = 'Planning Date';

            trigger OnValidate()
            begin
                Validate("Document Date", "Planning Date");
                if ("Currency Date" = 0D) or ("Currency Date" = xRec."Planning Date") then
                    Validate("Currency Date", "Planning Date");
                if (Type <> Type::Text) and ("No." <> '') then
                    UpdateAllAmounts;
            end;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account,Text';
            OptionMembers = Resource,Item,"G/L Account",Text;

            trigger OnValidate()
            begin
                Validate("No.", '');
                if Type = Type::Item then begin
                    GetLocation("Location Code");
                    Location.TestField("Directed Put-away and Pick", false);
                end;
            end;
        }
        field(7; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Text)) "Standard Text";

            trigger OnValidate()
            begin
                if ("No." = '') or ("No." <> xRec."No.") then begin
                    Description := '';
                    "Unit of Measure Code" := '';
                    "Qty. per Unit of Measure" := 1;
                    "Variant Code" := '';
                    "Work Type Code" := '';
                    "Gen. Bus. Posting Group" := '';
                    "Gen. Prod. Posting Group" := '';
                    DeleteAmounts;
                    "Cost Factor" := 0;
                    CheckedAvailability := false;
                    if "No." <> '' then begin
                        // Preserve quantities after resetting all amounts:
                        Quantity := xRec.Quantity;
                        "Quantity (Base)" := xRec."Quantity (Base)";
                    end else
                        exit;
                end;

                GetJob;
                "Customer Price Group" := Job."Customer Price Group";

                case Type of
                    Type::Resource:
                        begin
                            Res.Get("No.");
                            Res.TestField(Blocked, false);
                            Description := Res.Name;
                            "Description 2" := Res."Name 2";
                            "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
                            "Resource Group No." := Res."Resource Group No.";
                            Validate("Unit of Measure Code", Res."Base Unit of Measure");
                            //#4563
                            "Resource Type" := Res.Type;
                            //#4563//
                        end;
                    Type::Item:
                        begin
                            GetItem;
                            Item.TestField(Blocked, false);
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            if Job."Language Code" <> '' then
                                GetItemTranslation;
                            "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                            Validate("Unit of Measure Code", Item."Base Unit of Measure");
                        end;
                    Type::"G/L Account":
                        begin
                            GLAcc.Get("No.");
                            GLAcc.CheckGLAcc;
                            GLAcc.TestField("Direct Posting", true);
                            Description := GLAcc.Name;
                            "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
                            "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
                            "Unit of Measure Code" := '';
                            "Direct Unit Cost (LCY)" := 0;
                            "Unit Cost (LCY)" := 0;
                            "Unit Price" := 0;
                        end;
                    Type::Text:
                        begin
                            StdTxt.Get("No.");
                            Description := StdTxt.Description;
                        end;
                end;

                if Type <> Type::Text then
                    Validate(Quantity);
            end;
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                case Type of
                    Type::Item:
                        begin
                            if not Item.Get("No.") then
                                Error(Text004, Type, Item.FieldCaption("No."));
                            CheckItemAvailable;
                        end;
                    Type::Resource:
                        if not Res.Get("No.") then
                            Error(Text004, Type, Res.FieldCaption("No."));
                    Type::"G/L Account":
                        if not GLAcc.Get("No.") then
                            Error(Text004, Type, GLAcc.FieldCaption("No."));
                end;

                "Quantity (Base)" := CalcBaseQty(Quantity);
                UpdateAllAmounts;
            end;
        }
        field(11; "Direct Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost (LCY)';
        }
        field(12; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                if (Type = Type::Item) and
                   Item.Get("No.") and
                   (Item."Costing Method" = Item."costing method"::Standard) then
                    UpdateAllAmounts
                else begin
                    GetJob;
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Currency Date", "Currency Code",
                          "Unit Cost (LCY)", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                    UpdateAllAmounts;
                end;
            end;
        }
        field(13; "Total Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Cost (LCY)';
            Editable = false;
        }
        field(14; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Unit Price" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Currency Date", "Currency Code",
                      "Unit Price (LCY)", "Currency Factor"),
                    UnitAmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(15; "Total Price (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price (LCY)';
            Editable = false;
        }
        field(16; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            Editable = false;
            TableRelation = "Resource Group";
        }
        field(17; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure";

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                GetGLSetup;
                case Type of
                    Type::Item:
                        begin
                            Item.Get("No.");
                            "Qty. per Unit of Measure" :=
                              UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
                        end;
                    Type::Resource:
                        begin
                            if CurrFieldNo <> FieldNo("Work Type Code") then
                                if "Work Type Code" <> '' then begin
                                    WorkType.Get("Work Type Code");
                                    if WorkType."Unit of Measure Code" <> '' then
                                        TestField("Unit of Measure Code", WorkType."Unit of Measure Code");
                                end else
                                    TestField("Work Type Code", '');
                            if "Unit of Measure Code" = '' then begin
                                Resource.Get("No.");
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            end;
                            ResUnitofMeasure.Get("No.", "Unit of Measure Code");
                            "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                            "Quantity (Base)" := Quantity * "Qty. per Unit of Measure";
                        end;
                    Type::"G/L Account":
                        begin
                            "Qty. per Unit of Measure" := 1;
                        end;
                end;
                Validate(Quantity);
            end;
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location where("Use As In-Transit" = const(false));

            trigger OnValidate()
            begin
                "Bin Code" := '';
                if Type = Type::Item then begin
                    GetLocation("Location Code");
                    Location.TestField("Directed Put-away and Pick", false);
                    Validate(Quantity);
                end;
            end;
        }
        field(29; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(30; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(32; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                TestField(Type, Type::Resource);
                Validate("Line Discount %", 0);
                if (Rec."Work Type Code" = '') and (xRec."Work Type Code" <> '') then begin
                    Res.Get("No.");
                    "Unit of Measure Code" := Res."Base Unit of Measure";
                    Validate("Unit of Measure Code");
                end;
                if WorkType.Get("Work Type Code") then begin
                    if WorkType."Unit of Measure Code" <> '' then begin
                        "Unit of Measure Code" := WorkType."Unit of Measure Code";
                        if ResUnitofMeasure.Get("No.", "Unit of Measure Code") then
                            "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
                    end else begin
                        Res.Get("No.");
                        "Unit of Measure Code" := Res."Base Unit of Measure";
                        Validate("Unit of Measure Code");
                    end;
                end;
                Validate(Quantity);
            end;
        }
        field(33; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";

            trigger OnValidate()
            begin
                if (Type = Type::Item) and ("No." <> '') then begin
                    UpdateAllAmounts;
                end;
            end;
        }
        field(79; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(80; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Editable = false;
            TableRelation = "Gen. Business Posting Group";
        }
        field(81; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            Editable = false;
            TableRelation = "Gen. Product Posting Group";
        }
        field(83; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(1000; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task2"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1001; "Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Line Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Currency Date", "Currency Code",
                      "Line Amount (LCY)", "Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1002; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1003; "Total Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Cost';
            Editable = false;
        }
        field(1004; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1005; "Total Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Total Price';
            Editable = false;
        }
        field(1006; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1007; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1008; "Line Discount Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount (LCY)';
            Editable = false;

            trigger OnValidate()
            begin
                GetJob;
                "Line Discount Amount" := ROUND(
                    CurrExchRate.ExchangeAmtLCYToFCY(
                      "Currency Date", "Currency Code",
                      "Line Discount Amount (LCY)", "Currency Factor"),
                    AmountRoundingPrecision);
                UpdateAllAmounts;
            end;
        }
        field(1015; "Cost Factor"; Decimal)
        {
            Caption = 'Cost Factor';
            Editable = false;

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1019; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            Editable = false;
        }
        field(1020; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
        field(1021; "Line Discount %"; Decimal)
        {
            //blankzero = true;
            Caption = 'Line Discount %';

            trigger OnValidate()
            begin
                UpdateAllAmounts;
            end;
        }
        field(1022; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = 'Schedule,Contract,Both Schedule and Contract';
            OptionMembers = Schedule,Contract,"Both Schedule and Contract";

            trigger OnValidate()
            begin
                "Schedule Line" := true;
                "Contract Line" := true;
                if "Line Type" = "line type"::Schedule then
                    "Contract Line" := false;
                if "Line Type" = "line type"::Contract then
                    "Schedule Line" := false;
            end;
        }
        field(1023; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;

            trigger OnValidate()
            begin
                UpdateCurrencyFactor;
                UpdateAllAmounts;
            end;
        }
        field(1024; "Currency Date"; Date)
        {
            Caption = 'Currency Date';

            trigger OnValidate()
            begin
                UpdateCurrencyFactor;
                if (CurrFieldNo <> FieldNo("Planning Date")) and ("No." <> '') then
                    UpdateFromCurrency;
            end;
        }
        field(1025; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                if ("Currency Code" = '') and ("Currency Factor" <> 0) then
                    FieldError("Currency Factor", StrSubstNo(Text001, FieldCaption("Currency Code")));
                UpdateAllAmounts;
            end;
        }
        field(1026; "Schedule Line"; Boolean)
        {
            Caption = 'Schedule Line';
            Editable = false;
            InitValue = true;
        }
        field(1027; "Contract Line"; Boolean)
        {
            Caption = 'Contract Line';
            Editable = false;
        }
        field(1028; Invoiced; Boolean)
        {
            Caption = 'Invoiced';
            Editable = false;
        }
        field(1029; Transferred; Boolean)
        {
            Caption = 'Transferred';
            Editable = false;
        }
        field(1030; "Job Contract Entry No."; Integer)
        {
            Caption = 'Job Contract Entry No.';
            Editable = false;
        }
        field(1031; "Invoice Type"; Option)
        {
            Caption = 'Invoice Type';
            Editable = false;
            OptionCaption = ' ,Invoice,Credit Memo,Posted Invoice,Posted Credit Memo';
            OptionMembers = " ",Invoice,"Credit Memo","Posted Invoice","Posted Credit Memo";
        }
        field(1032; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            Editable = false;
            TableRelation = if ("Invoice Type" = const(Invoice),
                                "Invoice Type" = const("Credit Memo")) "Sales Invoice Header"
            else
            if ("Invoice Type" = const("Credit Memo")) "Sales Cr.Memo Header";

            trigger OnLookup()
            var
            //   JobCreateInvoice: Codeunit "Job Create-Invoice2";
            begin
                //GL2024   JobCreateInvoice.GetSalesInvoice(Rec);
            end;
        }
        field(1033; "Transferred Date"; Date)
        {
            Caption = 'Transferred Date';
            Editable = false;
        }
        field(1034; "Invoiced Date"; Date)
        {
            Caption = 'Invoiced Date';
            Editable = false;
        }
        field(1035; "Invoiced Amount (LCY)"; Decimal)
        {
            Caption = 'Invoiced Amount (LCY)';
            Editable = false;
        }
        field(1036; "Invoiced Cost Amount (LCY)"; Decimal)
        {
            Caption = 'Invoiced Cost Amount (LCY)';
            Editable = false;
        }
        field(1037; "VAT Unit Price"; Decimal)
        {
            Caption = 'VAT Unit Price';
        }
        field(1038; "VAT Line Discount Amount"; Decimal)
        {
            Caption = 'VAT Line Discount Amount';
        }
        field(1039; "VAT Line Amount"; Decimal)
        {
            Caption = 'VAT Line Amount';
        }
        field(1041; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
        }
        field(1042; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(1043; "Job Ledger Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'Job Ledger Entry No.';
            Editable = false;
            TableRelation = "Job Ledger Entry2";
        }
        field(1044; "Inv. Curr. Unit Price"; Decimal)
        {
            AutoFormatExpression = "Invoice Currency Code";
            AutoFormatType = 2;
            Caption = 'Inv. Curr. Unit Price';
            Editable = false;
        }
        field(1045; "Inv. Curr. Line Amount"; Decimal)
        {
            AutoFormatExpression = "Invoice Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Curr. Line Amount';
            Editable = false;
        }
        field(1046; "Invoice Currency"; Boolean)
        {
            Caption = 'Invoice Currency';
            Editable = false;
        }
        field(1047; "Invoice Currency Code"; Code[10])
        {
            Caption = 'Invoice Currency Code';
            TableRelation = Currency;
        }
        field(1048; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            InitValue = "Order";
            OptionCaption = 'Planning,Quote,Order,Completed';
            OptionMembers = Planning,Quote,"Order",Completed;
        }
        field(1049; "Invoice Currency Factor"; Decimal)
        {
            Caption = 'Invoice Currency Factor';
            Editable = false;
        }
        field(1050; "Ledger Entry Type"; Option)
        {
            Caption = 'Ledger Entry Type';
            OptionCaption = ' ,Resource,Item,G/L Account';
            OptionMembers = " ",Resource,Item,"G/L Account";
        }
        field(1051; "Ledger Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'Ledger Entry No.';
            TableRelation = if ("Ledger Entry Type" = const(Resource)) "Res. Ledger Entry"
            else
            if ("Ledger Entry Type" = const(Item)) "Item Ledger Entry"
            else
            if ("Ledger Entry Type" = const("G/L Account")) "G/L Entry";
        }
        field(1052; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));

            trigger OnValidate()
            begin
                if "Variant Code" = '' then begin
                    if Type = Type::Item then begin
                        Item.Get("No.");
                        Description := Item.Description;
                        "Description 2" := Item."Description 2";
                        GetItemTranslation;
                    end;
                    exit;
                end;

                TestField(Type, Type::Item);

                ItemVariant.Get("No.", "Variant Code");
                Description := ItemVariant.Description;
                "Description 2" := ItemVariant."Description 2";

                Validate(Quantity);
            end;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));

            trigger OnValidate()
            begin
                TestField("Location Code");
                CheckItemAvailable;
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5410; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate(Quantity, "Quantity (Base)");
            end;
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8003904; "Resource Type"; Option)
        {
            Caption = 'Resource Type';
            OptionCaption = 'Person,Machine,Structure,Other';
            OptionMembers = Person,Machine,Structure,Other;
        }
        field(8003905; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8003906; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8003909; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionCaption = 'Initial,Audit,Difference';
            OptionMembers = Initial,Audit,Difference;
        }
        field(8003910; "Cession Transferred"; Boolean)
        {
            Caption = 'Cession Transferred';
        }
        field(8003911; "Gross Total Cost"; Decimal)
        {
            Caption = 'Gross Total Cost';
            Editable = false;
        }
        field(8003919; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(8004055; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
    }

    keys
    {
        key(Key1; "Job No.", "Job Task No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Job No.", "Job Task No.", "Schedule Line", "Planning Date")
        {
            SumIndexFields = "Total Price (LCY)", "Total Cost (LCY)", "Line Amount (LCY)";
        }
        key(Key3; "Job No.", "Job Task No.", "Contract Line", "Planning Date")
        {
            SumIndexFields = "Line Amount (LCY)", "Total Price (LCY)", "Total Cost (LCY)", "Invoiced Amount (LCY)", "Invoiced Cost Amount (LCY)";
        }
        key(Key4; "Job No.", "Job Task No.", "Schedule Line", "Currency Date")
        {
        }
        key(Key5; "Job No.", "Job Task No.", "Contract Line", "Currency Date")
        {
        }
        key(Key6; "Job No.", "Schedule Line", Type, "No.", "Planning Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key7; "Job No.", "Schedule Line", Type, "Resource Group No.", "Planning Date")
        {
            SumIndexFields = "Quantity (Base)", Quantity, "Total Cost";
        }
        key(Key8; Status, "Schedule Line", Type, "No.", "Planning Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key9; Status, "Schedule Line", Type, "Resource Group No.", "Planning Date")
        {
            SumIndexFields = "Quantity (Base)", Quantity, "Total Cost";
        }
        key(Key10; "Job Contract Entry No.")
        {
        }
        key(Key11; Type, "No.")
        {
        }
        key(Key12; "Document Type", "Document No.")
        {
        }
        key(Key13; "Job No.", Type, "Resource Type", "Gen. Prod. Posting Group", "Entry Type", "Planning Date")
        {
            SumIndexFields = "Quantity (Base)", "Total Price (LCY)", "Total Cost (LCY)", "Line Amount (LCY)", "Gross Total Cost", Quantity, "Total Cost", "Total Price";
        }
        key(Key14; "Job No.", Type, "No.", "Work Type Code", "Planning Date")
        {
            SumIndexFields = "Quantity (Base)";
        }
        key(Key15; "Gen. Prod. Posting Group")
        {
            SumIndexFields = "Total Price (LCY)";
        }
        key(Key16; "Job No.", "Job Task No.", "Gen. Prod. Posting Group", Type, "Resource Type", "No.", "Variant Code", "Entry Type", "Planning Date", "Order Date", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            SumIndexFields = Quantity, "Total Cost", "Total Cost (LCY)", "Total Price", "Gross Total Cost", "Quantity (Base)", "Line Amount (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Transferred, false);
    end;

    trigger OnInsert()
    begin
        LockTable;
        GetJob;
        if Job.Blocked = Job.Blocked::All then
            Job.TestBlocked;
        JT.Get("Job No.", "Job Task No.");
        JT.TestField("Job Task Type", JT."job task type"::Posting);
        "Job Contract Entry No." := JobEntryNo.GetNextEntryNo;
        InitJobPlanningLine;
        "User ID" := UserId;
        "Last Date Modified" := 0D;
        Status := Job.Status;
        //MASK
        "Mask Code" := Job."Mask Code";
        //MASK//
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "User ID" := UserId;
    end;

    trigger OnRename()
    begin
        Error(Text002, TableCaption);
    end;

    var
        GLAcc: Record "G/L Account";
        Location: Record Location;
        Item: Record Item;
        JobEntryNo: Record "Job Entry No.2";
        JT: Record "Job Task2";
        ItemVariant: Record "Item Variant";
        Res: Record Resource;
        ResCost: Record "Resource Cost2";
        WorkType: Record "Work Type";
        Job: Record Job2;
        ResUnitofMeasure: Record "Resource Unit of Measure";
        ItemJnlLine: Record "Item Journal Line";
        CurrExchRate: Record "Currency Exchange Rate";
        SKU: Record "Stockkeeping Unit";
        StdTxt: Record "Standard Text";
        Currency: Record Currency;
        ItemTranslation: Record "Item Translation";
        GLSetup: Record "General Ledger Setup";
        // SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        // PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        UOMMgt: Codeunit "Unit of Measure Management";
        // ResFindUnitCost: Codeunit "Resource-Find Cost";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        Text001: label 'cannot be specified without %1';
        Text002: label 'You cannot rename a %1.';
        CurrencyDate: Date;
        Text004: label 'You must specify %1 %2 in planning line.';
        HasGotGLSetup: Boolean;
        UnitAmountRoundingPrecision: Decimal;
        AmountRoundingPrecision: Decimal;
        CheckedAvailability: Boolean;

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TestField("Qty. per Unit of Measure");
        exit(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    local procedure CheckItemAvailable()
    begin
        if (CurrFieldNo <> 0) and (Type = Type::Item) and (Quantity > 0) and not CheckedAvailability then begin
            ItemJnlLine."Item No." := "No.";
            ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Negative Adjmt.";
            ItemJnlLine."Location Code" := "Location Code";
            ItemJnlLine."Variant Code" := "Variant Code";
            ItemJnlLine."Bin Code" := "Bin Code";
            ItemJnlLine."Unit of Measure Code" := "Unit of Measure Code";
            ItemJnlLine."Qty. per Unit of Measure" := "Qty. per Unit of Measure";
            ItemJnlLine.Quantity := Quantity;
            ItemCheckAvail.ItemJnlCheckLine(ItemJnlLine);
            CheckedAvailability := true;
        end;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;


    procedure GetJob()
    begin
        TestField("Job No.");
        if "Job No." <> Job."No." then begin
            Job.Get("Job No.");
            if Job."Currency Code" = '' then begin
                GetGLSetup;
                Currency.InitRoundingPrecision;
                AmountRoundingPrecision := GLSetup."Amount Rounding Precision";
                UnitAmountRoundingPrecision := GLSetup."Unit-Amount Rounding Precision";
            end else begin
                GetCurrency;
                Currency.Get(Job."Currency Code");
                Currency.TestField("Amount Rounding Precision");
                AmountRoundingPrecision := Currency."Amount Rounding Precision";
                UnitAmountRoundingPrecision := Currency."Unit-Amount Rounding Precision";
            end;
        end;
    end;


    procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
            if "Currency Date" = 0D then
                CurrencyDate := WorkDate
            else
                CurrencyDate := "Currency Date";
            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    local procedure GetItem()
    begin
        TestField("No.");
        if "No." <> Item."No." then
            Item.Get("No.");
    end;

    local procedure GetSKU(): Boolean
    begin
        if (SKU."Location Code" = "Location Code") and
           (SKU."Item No." = "No.") and
           (SKU."Variant Code" = "Variant Code")
        then
            exit(true);

        if SKU.Get("Location Code", "No.", "Variant Code") then
            exit(true);

        exit(false);
    end;

    local procedure GetCurrency()
    begin
        if "Currency Code" = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision
        end else begin
            Currency.Get("Currency Code");
            Currency.TestField("Amount Rounding Precision");
            Currency.TestField("Unit-Amount Rounding Precision");
        end;
    end;


    procedure Caption(): Text[250]
    var
        Job: Record Job2;
        JT: Record "Job Task2";
    begin
        if not Job.Get("Job No.") then
            exit('');
        if not JT.Get("Job No.", "Job Task No.") then
            exit('');
        exit(StrSubstNo('%1 %2 %3 %4',
            Job."No.",
            Job.Description,
            JT."Job Task No.",
            JT.Description));
    end;


    procedure SetUpNewLine(LastJobPlanningLine: Record "Job Planning Line2")
    begin
        "Document Date" := LastJobPlanningLine."Planning Date";
        "Document No." := LastJobPlanningLine."Document No.";
        Type := LastJobPlanningLine.Type;
        Validate("Line Type", LastJobPlanningLine."Line Type");
        GetJob;
        "Currency Code" := Job."Currency Code";
        if LastJobPlanningLine."Planning Date" <> 0D then
            Validate("Planning Date", LastJobPlanningLine."Planning Date");
    end;


    procedure InitJobPlanningLine()
    begin
        Transferred := false;
        Invoiced := false;
        "Invoiced Amount (LCY)" := 0;
        "Invoiced Cost Amount (LCY)" := 0;
        "Invoice Type" := 0;
        "Invoice No." := '';
        "Transferred Date" := 0D;
        "Invoiced Date" := 0D;
        "VAT Unit Price" := 0;
        "VAT Line Discount Amount" := 0;
        "VAT Line Amount" := 0;
        "VAT %" := 0;
        "Job Ledger Entry No." := 0;
        "Inv. Curr. Unit Price" := 0;
        "Inv. Curr. Line Amount" := 0;
        "Invoice Currency Code" := '';
        "Invoice Currency" := false;
    end;


    procedure DeleteAmounts()
    begin
        "Unit Cost" := ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              "Currency Date", "Currency Code",
              "Unit Cost (LCY)", "Currency Factor"),
            Currency."Unit-Amount Rounding Precision");
        "Total Cost" := ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              "Currency Date", "Currency Code",
              "Total Cost (LCY)", "Currency Factor"),
            Currency."Amount Rounding Precision");
    end;


    procedure UpdateCostLCY()
    begin
        "Unit Cost (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Unit Cost", "Currency Factor"),
            Currency."Unit-Amount Rounding Precision");
        "Total Cost (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Total Cost", "Currency Factor"),
            Currency."Amount Rounding Precision");
    end;


    procedure UpdatePriceFCY()
    begin
        "Unit Price" := ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              "Currency Date", "Currency Code",
              "Unit Price (LCY)", "Currency Factor"),
            Currency."Unit-Amount Rounding Precision");
        "Total Price" := ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              "Currency Date", "Currency Code",
              "Total Price (LCY)", "Currency Factor"),
            Currency."Amount Rounding Precision");
    end;


    procedure UpdatePriceLCY()
    begin
        GetGLSetup;
        "Unit Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Unit Price", "Currency Factor"),
            GLSetup."Unit-Amount Rounding Precision");
        "Total Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Total Price", "Currency Factor"));
    end;


    procedure UpdateFromCurrency()
    begin
        GetJob;
        UpdateAllAmounts;
    end;


    procedure GetItemTranslation()
    begin
        GetJob;
        if ItemTranslation.Get("No.", "Variant Code", Job."Language Code") then begin
            Description := ItemTranslation.Description;
            "Description 2" := ItemTranslation."Description 2";
        end;
    end;


    procedure GetGLSetup()
    begin
        if HasGotGLSetup then
            exit;
        GLSetup.Get;
        HasGotGLSetup := true;
    end;


    procedure UpdateAllAmounts()
    begin
        GetJob;

        UpdateUnitCost;
        UpdateTotalCost;
        FindPriceAndDiscount(Rec, CurrFieldNo);
        HandleCostFactor;
        UpdateUnitPrice;
        UpdateTotalPrice;
        UpdateAmountsAndDiscounts;
    end;

    local procedure UpdateUnitCost()
    var
        RetrievedCost: Decimal;
    begin
        if (Type = Type::Item) and Item.Get("No.") then begin
            if Item."Costing Method" = Item."costing method"::Standard then begin
                if RetrieveCostPrice then begin
                    if GetSKU then
                        "Unit Cost (LCY)" := SKU."Unit Cost" * "Qty. per Unit of Measure"
                    else
                        "Unit Cost (LCY)" := Item."Unit Cost" * "Qty. per Unit of Measure";
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Currency Date", "Currency Code",
                          "Unit Cost (LCY)", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end else begin
                    if "Unit Cost" <> xRec."Unit Cost" then
                        "Unit Cost (LCY)" := ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              "Currency Date", "Currency Code",
                              "Unit Cost", "Currency Factor"),
                            UnitAmountRoundingPrecision)
                    else
                        "Unit Cost" := ROUND(
                            CurrExchRate.ExchangeAmtLCYToFCY(
                              "Currency Date", "Currency Code",
                              "Unit Cost (LCY)", "Currency Factor"),
                            UnitAmountRoundingPrecision);
                end;
            end else begin
                if RetrieveCostPrice then begin
                    if GetSKU then
                        RetrievedCost := SKU."Unit Cost" * "Qty. per Unit of Measure"
                    else
                        RetrievedCost := Item."Unit Cost" * "Qty. per Unit of Measure";
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Currency Date", "Currency Code",
                          RetrievedCost, "Currency Factor"),
                        UnitAmountRoundingPrecision);
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Currency Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end else begin
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Currency Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end;
            end;
        end else
            if (Type = Type::Resource) and Res.Get("No.") then begin
                if RetrieveCostPrice then begin
                    ResCost.Init;
                    ResCost.Code := "No.";
                    ResCost."Work Type Code" := "Work Type Code";
                    //DYS A VERIFIER
                    //ResFindUnitCost.Run(ResCost);
                    "Direct Unit Cost (LCY)" := ResCost."Direct Unit Cost" * "Qty. per Unit of Measure";
                    RetrievedCost := ROUND(ResCost."Unit Cost" * "Qty. per Unit of Measure", UnitAmountRoundingPrecision);
                    "Unit Cost" := ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          "Currency Date", "Currency Code",
                          RetrievedCost, "Currency Factor"),
                        UnitAmountRoundingPrecision);
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Currency Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end else begin
                    "Unit Cost (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Currency Date", "Currency Code",
                          "Unit Cost", "Currency Factor"),
                        UnitAmountRoundingPrecision);
                end;
            end else begin
                "Unit Cost (LCY)" := ROUND(
                    CurrExchRate.ExchangeAmtFCYToLCY(
                      "Currency Date", "Currency Code",
                      "Unit Cost", "Currency Factor"),
                    UnitAmountRoundingPrecision);
            end;
    end;


    procedure RetrieveCostPrice(): Boolean
    begin
        case Type of
            Type::Item:
                if ("No." <> xRec."No.") or
                   ("Location Code" <> xRec."Location Code") or
                   ("Variant Code" <> xRec."Variant Code") or
                   ("Unit of Measure Code" <> xRec."Unit of Measure Code") then
                    exit(true);
            Type::Resource:
                if ("No." <> xRec."No.") or
                   ("Work Type Code" <> xRec."Work Type Code") or
                   ("Unit of Measure Code" <> xRec."Unit of Measure Code") then
                    exit(true);
            Type::"G/L Account":
                if "No." <> xRec."No." then
                    exit(true);
            else
                exit(false);
        end;
        exit(false);
    end;

    local procedure UpdateTotalCost()
    begin
        "Total Cost" := ROUND("Unit Cost" * Quantity, AmountRoundingPrecision);
        "Total Cost (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Total Cost", "Currency Factor"),
            AmountRoundingPrecision);
    end;


    procedure FindPriceAndDiscount(var JobPlanningLine: Record "Job Planning Line2"; CalledByFieldNo: Integer)
    begin
        if RetrieveCostPrice and ("No." <> '') then begin
            //DYS A VERIFIER
            // SalesPriceCalcMgt.FindJobPlanningLinePrice(JobPlanningLine, CalledByFieldNo);

            // if Type <> Type::"G/L Account" then
            //     PurchPriceCalcMgt.FindJobPlanningLinePrice(JobPlanningLine, CalledByFieldNo)
            //else 
            begin
                // Because the SalesPriceCalcMgt.FindJobJnlLinePrice function also retrieves costs for G/L Account,
                // cost and total cost need to get updated again.
                UpdateUnitCost;
                UpdateTotalCost;
            end;

        end;
    end;

    local procedure HandleCostFactor()
    begin
        if ("Unit Cost" <> xRec."Unit Cost") or ("Cost Factor" <> xRec."Cost Factor") then begin
            if "Cost Factor" <> 0 then
                "Unit Price" := ROUND("Unit Cost" * "Cost Factor", UnitAmountRoundingPrecision)
            else
                if xRec."Cost Factor" <> 0 then
                    "Unit Price" := 0;
        end;
    end;

    local procedure UpdateUnitPrice()
    begin
        "Unit Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Unit Price", "Currency Factor"),
            UnitAmountRoundingPrecision);
    end;

    local procedure UpdateTotalPrice()
    begin
        "Total Price" := ROUND(Quantity * "Unit Price", AmountRoundingPrecision);
        "Total Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Total Price", "Currency Factor"),
            AmountRoundingPrecision);
    end;

    local procedure UpdateAmountsAndDiscounts()
    begin
        if "Total Price" <> 0 then begin
            if ("Line Amount" <> xRec."Line Amount") and ("Line Discount Amount" = xRec."Line Discount Amount") then begin
                "Line Amount" := ROUND("Line Amount", AmountRoundingPrecision);
                "Line Discount Amount" := "Total Price" - "Line Amount";
                "Line Discount %" :=
                  ROUND("Line Discount Amount" / "Total Price" * 100);
            end else
                if ("Line Discount Amount" <> xRec."Line Discount Amount") and ("Line Amount" = xRec."Line Amount") then begin
                    "Line Discount Amount" := ROUND("Line Discount Amount", AmountRoundingPrecision);
                    "Line Amount" := "Total Price" - "Line Discount Amount";
                    "Line Discount %" :=
                      ROUND("Line Discount Amount" / "Total Price" * 100);
                end else begin
                    "Line Discount Amount" :=
                      ROUND("Total Price" * "Line Discount %" / 100, AmountRoundingPrecision);
                    "Line Amount" := "Total Price" - "Line Discount Amount";
                end;
        end else begin
            "Line Amount" := 0;
            "Line Discount Amount" := 0;
        end;

        "Line Amount (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Line Amount", "Currency Factor"),
            AmountRoundingPrecision);

        "Line Discount Amount (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Line Discount Amount", "Currency Factor"),
            AmountRoundingPrecision);
    end;


    procedure wSetType(pType: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)")
    begin
        //PROJET
        case pType of
            Ptype::" ":
                Type := Type::Text;
            Ptype::"G/L Account":
                Type := Type::"G/L Account";
            Ptype::Item:
                Type := Type::Item;
            Ptype::Resource:
                Type := Type::Resource;
            //  pType::"Fixed Asset":
            Ptype::"Charge (Item)":
                Type := Type::"G/L Account";
        end;
        //PROJET//
    end;
}

