Table 8001511 "Discount Rule"
{
    //GL2024  ID dans Nav 2009 : "8001303"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Reserved for add-on "Discounts and commissions"

    Caption = 'Discount Rule';
    //LookupPageID = 8001501;

    fields
    {
        field(1; "Discount and comm. type"; Option)
        {
            Caption = 'Discount and comm. type';
            OptionCaption = 'Line discount,Footer discount,Back discount,Commission';
            OptionMembers = "Line discount","Footer discount","Back discount",Commission;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Starting Date" := CalcDate('-' + ConvertirFormuleDate.ConvertDateFormula(5), WorkDate);
                "Ending Date" := CalcDate('+' + ConvertirFormuleDate.ConvertDateFormula(5), WorkDate);
            end;
        }
        field(10; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(20; "Continue calculation"; Option)
        {
            Caption = 'Continue calculation';
            OptionCaption = 'Yes,Line discount,Footer discount,End of period discount,No';
            OptionMembers = Yes,"Line discount","Footer discount","End of period discount",No;
        }
        field(30; Basis; Option)
        {
            Caption = 'Basis';
            OptionCaption = 'Gross,Net line,Net footer,Net back discount';
            OptionMembers = Gross,"Net line","Net footer","Net back discount";
        }
        field(31; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Sale,Purchase';
            OptionMembers = Sale,Purchase;
        }
        field(100; "Salespers./Purch. Filter"; Text[40])
        {
            Caption = 'Salespers./Purch. Filter';
            TableRelation = "Salesperson/Purchaser";
            ValidateTableRelation = false;
        }
        field(101; "Source Filter"; Text[60])
        {
            Caption = 'Source Filter';
            TableRelation = if (Type = filter(Sale)) Customer
            else
            if (Type = filter(Purchase)) Vendor;
            ValidateTableRelation = false;
        }
        field(102; "Price code filter"; Text[40])
        {
            Caption = 'Price code filter';
            TableRelation = "Customer Price Group";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Discount and comm. type" >= "discount and comm. type"::"Back discount" then
                    Error(tError1);
            end;
        }
        field(103; "Source Posting Group Filter"; Text[40])
        {
            Caption = 'Source Posting Group Filter';
            TableRelation = if (Type = const(Sale)) "Customer Posting Group"
            else
            if (Type = const(Purchase)) "Vendor Posting Group";
            ValidateTableRelation = false;
        }
        field(104; "Gen. Bus. Posting Group filter"; Text[40])
        {
            Caption = 'Gen. Bus. Posting Group filter';
            TableRelation = "Gen. Business Posting Group";
            ValidateTableRelation = false;
        }
        field(105; "Cust./Item Disc. Gr. filter"; Text[40])
        {
            Caption = 'Cust./Item Disc. Gr. filter';
            TableRelation = "Customer Discount Group";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
                if "Discount and comm. type" >= "discount and comm. type"::"Back discount" then
                    Error(tError1);
            end;
        }
        field(106; "Inventory Posting Group filter"; Text[40])
        {
            Caption = 'Inventory Posting Group filter';
            TableRelation = "Inventory Posting Group";
            ValidateTableRelation = false;
        }
        field(107; "Gen.Prod. Posting Group filter"; Text[40])
        {
            Caption = 'Gen. Prod. Posting Group filter';
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;
        }
        field(108; "Item/Cust. Disc. Gr. filter"; Text[40])
        {
            Caption = 'Item/Cust. Disc. Gr. filter';
            TableRelation = "Item Discount Group";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Discount and comm. type" >= "discount and comm. type"::"Back discount" then
                    Error(tError1);
            end;
        }
        field(109; "Type Filter"; Option)
        {
            Caption = 'Type Filter';
            OptionCaption = 'All,Account (G/L),Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = All,"Account (G/L)",Item,Resource,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            begin
                if (Type = Type::Purchase) and ("Type Filter" = "type filter"::Resource) then begin
                    Error(tError1, FieldCaption("Type Filter"), "Type Filter", FieldCaption(Type), Type);
                    "Type Filter" := "type filter"::All;
                end;
            end;
        }
        field(110; "No. filter"; Text[60])
        {
            Caption = 'No. filter';
            TableRelation = if ("Type Filter" = const("Account (G/L)")) "G/L Account"
            else
            if ("Type Filter" = const(Item)) Item
            else
            if ("Type Filter" = const(Resource)) Resource
            else
            if ("Type Filter" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Type Filter" = const("Charge (Item)")) "Item Charge";
            ValidateTableRelation = false;
        }
        field(112; "Quantity filter"; Text[20])
        {
            Caption = 'Quantity filter';
        }
        field(113; "Amount filter"; Text[40])
        {
            Caption = 'Amount filter';

            trigger OnValidate()
            begin
                if "Discount and comm. type" >= "discount and comm. type"::"Back discount" then
                    Error(tError1);
                TestField("Amount Filter (LCY)", '');
            end;
        }
        field(115; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Ending Date" < "Starting Date" then
                    "Ending Date" := CalcDate('+' + ConvertirFormuleDate.ConvertDateFormula(5), "Starting Date");
            end;
        }
        field(117; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            NotBlank = true;

            trigger OnValidate()
            var
                lFinApresDebut: label '%1 is less than %2.';
            begin
                if "Ending Date" < "Starting Date" then
                    Error(lFinApresDebut, FieldCaption("Ending Date"), FieldCaption("Starting Date"));
            end;
        }
        field(120; "Reason Code filter"; Text[40])
        {
            Caption = 'Reason Code filter';
            TableRelation = "Reason Code";
            ValidateTableRelation = false;
        }
        field(121; "Global Dimension 1 Filter"; Text[40])
        {
            //CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(122; "Global Dimension 2 Filter"; Text[40])
        {
            //CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(123; "Currency Filter"; Text[20])
        {
            Caption = 'Currency Filter';
            TableRelation = Currency;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if "Discount and comm. type" >= "discount and comm. type"::"Back discount" then
                    Error(tError1);
            end;
        }
        field(124; "Amount Filter (LCY)"; Text[40])
        {
            Caption = 'Amount Filter( LCY)';

            trigger OnValidate()
            begin
                TestField("Amount filter", '');
            end;
        }
        field(125; "Job Filter"; Text[40])
        {
            Caption = 'Job Filter';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(130; "Return Reason Code Filter"; Text[30])
        {
            Caption = 'Return Reason Code Filter';
            TableRelation = "Return Reason";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(131; "Manufacturer Code Filter"; Text[30])
        {
            Caption = 'Manufacturer Code Filter';
            TableRelation = Manufacturer;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(132; "Item Category Code Filter"; Text[30])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(133; "Product Group Code Filter"; Text[30])
        {
            Caption = 'Product Group Code Filter';
            //GL2024 TableRelation = "Product Group".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            //GL2024  ValidateTableRelation = false;
        }
        field(134; "Service Item Group Filter"; Text[30])
        {
            Caption = 'Service Item Group Filter';
            TableRelation = "Service Item Group".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(200; "Calc method"; Option)
        {
            Caption = 'Calc method';
            OptionCaption = 'Quantity * Rate,Quantity (Base) * Rate,Amount * Rate,Specific amount * Rate';
            OptionMembers = "Quantité * Coefficient","Quantité (base) * Coefficient","Montant * Coefficient","Base spécifique * Coefficient";
        }
        field(201; Coefficient; Decimal)
        {
            //blankzero = true;
            Caption = 'Coefficient';
            DecimalPlaces = 0 : 5;
        }
        field(301; "Customer criteria filter 1"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99003';
            Caption = 'Customer criteria filter 1';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001301));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(302; "Customer criteria filter 2"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99004';
            Caption = 'Customer criteria filter 2';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001302));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(303; "Customer criteria filter 3"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99005';
            Caption = 'Customer criteria filter 3';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001303));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(304; "Customer criteria filter 4"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99006';
            Caption = 'Customer criteria filter 4';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001304));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(305; "Customer criteria filter 5"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99007';
            Caption = 'Customer criteria filter 5';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001305));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(306; "Customer criteria filter 6"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99008';
            Caption = 'Customer criteria filter 6';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001306));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(307; "Customer criteria filter 7"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99009';
            Caption = 'Customer criteria filter 7';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001307));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(308; "Customer criteria filter 8"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99010';
            Caption = 'Customer criteria filter 8';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001308));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(309; "Customer criteria filter 9"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99011';
            Caption = 'Customer criteria filter 9';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001309));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(310; "Customer criteria filter 10"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99012';
            Caption = 'Customer criteria filter 10';
            TableRelation = Code.Code where("Table No" = const(18),
                                             "Field No" = const(8001310));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                TestField(Type, Type::Sale);
            end;
        }
        field(311; "Item criteria filter 1"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99030';
            Caption = 'Item criteria filter 1';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001301));
            ValidateTableRelation = false;
        }
        field(312; "Item criteria filter 2"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99031';
            Caption = 'Item criteria filter 2';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001302));
            ValidateTableRelation = false;
        }
        field(313; "Item criteria filter 3"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99032';
            Caption = 'Item criteria filter 3';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001303));
            ValidateTableRelation = false;
        }
        field(314; "Item criteria filter 4"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99033';
            Caption = 'Item criteria filter 4';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001304));
            ValidateTableRelation = false;
        }
        field(315; "Item criteria filter 5"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99034';
            Caption = 'Item criteria filter 5';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001305));
            ValidateTableRelation = false;
        }
        field(316; "Item criteria filter 6"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99035';
            Caption = 'Item criteria filter 6';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001306));
            ValidateTableRelation = false;
        }
        field(317; "Item criteria filter 7"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99036';
            Caption = 'Item criteria filter 7';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001307));
            ValidateTableRelation = false;
        }
        field(318; "Item criteria filter 8"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99037';
            Caption = 'Item criteria filter 8';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001308));
            ValidateTableRelation = false;
        }
        field(319; "Item criteria filter 9"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99038';
            Caption = 'Item criteria filter 9';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001309));
            ValidateTableRelation = false;
        }
        field(320; "Item criteria filter 10"; Text[40])
        {
            //CaptionClass = '8001400,3,8001302,99039';
            Caption = 'Item criteria filter 10';
            TableRelation = Code.Code where("Table No" = const(27),
                                             "Field No" = const(8001310));
            ValidateTableRelation = false;
        }
        field(30001; "Dimension 1 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(1);
            Caption = 'Dimension 1 Value Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Dimension 1 Value Code"));

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 1 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 1 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30002; "Dimension 2 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(2);
            Caption = 'Dimension 2 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 2 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 2 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30003; "Dimension 3 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(3);
            Caption = 'Dimension 3 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 3 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 3 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30004; "Dimension 4 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(4);
            Caption = 'Dimension 4 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 4 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 4 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30005; "Dimension 5 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(5);
            Caption = 'Dimension 5 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 5 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 5 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30006; "Dimension 6 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(6);
            Caption = 'Dimension 6 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 6 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 6 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30007; "Dimension 7 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(7);
            Caption = 'Dimension 7 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 7 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 7 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30008; "Dimension 8 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(8);
            Caption = 'Dimension 8 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 8 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 8 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30009; "Dimension 9 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(9);
            Caption = 'Dimension 9 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 9 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 9 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30010; "Dimension 10 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(10);
            Caption = 'Dimension 10 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 10 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 10 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30011; "Dimension 11 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(11);
            Caption = 'Dimension 11 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 11 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 11 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30012; "Dimension 12 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(12);
            Caption = 'Dimension 12 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 12 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 12 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30013; "Dimension 13 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(13);
            Caption = 'Dimension 13 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 13 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 13 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30014; "Dimension 14 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(14);
            Caption = 'Dimension 14 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 14 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 14 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30015; "Dimension 15 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(15);
            Caption = 'Dimension 15 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 15 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 15 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30016; "Dimension 16 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(16);
            Caption = 'Dimension 16 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 16 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 16 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30017; "Dimension 17 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(17);
            Caption = 'Dimension 17 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 17 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 17 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30018; "Dimension 18 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(18);
            Caption = 'Dimension 18 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 18 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 18 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30019; "Dimension 19 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(19);
            Caption = 'Dimension 19 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 19 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 19 Value Code" := DimValue.Code;
                end;
            end;
        }
        field(30020; "Dimension 20 Value Code"; Text[30])
        {
            //CaptionClass = GetCaptionClass(20);
            Caption = 'Dimension 20 Value Code';

            trigger OnLookup()
            begin
                StatisticsSetup.Get;
                DimValue.SetRange("Dimension Code", StatisticsSetup."Dimension 20 Code");
                DimValue.SetRange("Dimension Value Type", DimValue."dimension value type"::Standard);
                if PAGE.RunModal(0, DimValue) = Action::LookupOK then begin
                    "Dimension 20 Value Code" := DimValue.Code;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "Discount and comm. type", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        StatisticsSetup: Record "Statistics setup";
        "Code": Record "Code";
        DimValue: Record "Dimension Value";
        // FaireFiltreDate: Codeunit MakeDateFilter;
        ConvertirFormuleDate: Codeunit "StatsExplorer, Tools";
        tError1: label 'The rule must be a discount.';


    procedure GetCaptionClass(AnalysisViewDimType: Integer): Text[250]
    var
        lStatisticsSetup: Record "Statistics setup";
        lText001: label '1,6,,Dimension 1 Value Code';
        lText002: label '1,6,,Dimension 2 Value Code';
        lText003: label '1,6,,Dimension 3 Value Code';
        lText004: label '1,6,,Dimension 4 Value Code';
        lText005: label '1,6,,Dimension 5 Value Code';
        lText006: label '1,6,,Dimension 6 Value Code';
        lText007: label '1,6,,Dimension 7 Value Code';
        lText008: label '1,6,,Dimension 8 Value Code';
        lText009: label '1,6,,Dimension 9 Value Code';
        lText010: label '1,6,,Dimension 10 Value Code';
        lText011: label '1,6,,Dimension 11 Value Code';
        lText012: label '1,6,,Dimension 12 Value Code';
        lText013: label '1,6,,Dimension 13 Value Code';
        lText014: label '1,6,,Dimension 14 Value Code';
        lText015: label '1,6,,Dimension 15 Value Code';
        lText016: label '1,6,,Dimension 16 Value Code';
        lText017: label '1,6,,Dimension 17 Value Code';
        lText018: label '1,6,,Dimension 18 Value Code';
        lText019: label '1,6,,Dimension 19 Value Code';
        lText020: label '1,6,,Dimension 20 Value Code';
    begin
        lStatisticsSetup.Get;
        case AnalysisViewDimType of
            1:
                begin
                    if lStatisticsSetup."Dimension 1 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 1 Code")
                    else
                        exit(lText001);
                end;
            2:
                begin
                    if lStatisticsSetup."Dimension 2 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 2 Code")
                    else
                        exit(lText002);
                end;
            3:
                begin
                    if lStatisticsSetup."Dimension 3 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 3 Code")
                    else
                        exit(lText003);
                end;
            4:
                begin
                    if lStatisticsSetup."Dimension 4 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 4 Code")
                    else
                        exit(lText004);
                end;
            5:
                begin
                    if lStatisticsSetup."Dimension 5 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 5 Code")
                    else
                        exit(lText005);
                end;
            6:
                begin
                    if lStatisticsSetup."Dimension 6 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 6 Code")
                    else
                        exit(lText006);
                end;
            7:
                begin
                    if lStatisticsSetup."Dimension 7 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 7 Code")
                    else
                        exit(lText007);
                end;
            8:
                begin
                    if lStatisticsSetup."Dimension 8 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 8 Code")
                    else
                        exit(lText008);
                end;
            9:
                begin
                    if lStatisticsSetup."Dimension 9 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 9 Code")
                    else
                        exit(lText009);
                end;
            10:
                begin
                    if lStatisticsSetup."Dimension 10 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 10 Code")
                    else
                        exit(lText010);
                end;
            11:
                begin
                    if lStatisticsSetup."Dimension 11 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 11 Code")
                    else
                        exit(lText011);
                end;
            12:
                begin
                    if lStatisticsSetup."Dimension 12 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 12 Code")
                    else
                        exit(lText012);
                end;
            13:
                begin
                    if lStatisticsSetup."Dimension 13 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 13 Code")
                    else
                        exit(lText013);
                end;
            14:
                begin
                    if lStatisticsSetup."Dimension 14 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 14 Code")
                    else
                        exit(lText014);
                end;
            15:
                begin
                    if lStatisticsSetup."Dimension 15 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 15 Code")
                    else
                        exit(lText015);
                end;
            16:
                begin
                    if lStatisticsSetup."Dimension 16 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 16 Code")
                    else
                        exit(lText016);
                end;
            17:
                begin
                    if lStatisticsSetup."Dimension 17 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 17 Code")
                    else
                        exit(lText017);
                end;
            18:
                begin
                    if lStatisticsSetup."Dimension 18 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 18 Code")
                    else
                        exit(lText018);
                end;
            19:
                begin
                    if lStatisticsSetup."Dimension 19 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 19 Code")
                    else
                        exit(lText019);
                end;
            20:
                begin
                    if lStatisticsSetup."Dimension 20 Code" <> '' then
                        exit('1,6,' + lStatisticsSetup."Dimension 20 Code")
                    else
                        exit(lText020);
                end;
        end;
    end;
}

