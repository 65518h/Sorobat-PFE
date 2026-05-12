Table 8001433 "Purch. Document Model"
{
    // //BAT Renumering 167 -> 8004160
    // //+REF+DOCUMENT GESWAY 27/05/03 Table des options d'impression documents achats
    // //+REF+TRANSLATION CW 11/10/05 OnDelete, OnRename

    Caption = 'Purchase Document Model';
    //DrillDownPageID = 8001451;
    //LookupPageID = 8001451;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            NotBlank = true;
            SQLDataType = Variant;
        }
        field(2; "No. Of Copies"; Integer)
        {
            Caption = 'Nombre de copies';
        }
        field(4; "Header Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8001433),
                                                                FieldID = const(4),
                                                                Code = field("No.")));
            Caption = 'Header Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Reference Field No."; Integer)
        {
            Caption = 'Reference Field No.';

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldRefTable) = Action::LookupOK then
                //     Validate("Reference Field No.", FieldRefTable."No.");
            end;

            trigger OnValidate()
            begin
                InitLineFieldList;
                GetLineFieldDescription("Reference Field No.", "Reference Field Caption");
            end;
        }
        field(10; "Print Continued"; Boolean)
        {
            Caption = 'Print Continued';
        }
        field(11; "Using Pre-Printed"; Boolean)
        {
            Caption = 'Using Pre-Printed';
        }
        field(12; "Appendix Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8001433),
                                                                FieldID = const(12),
                                                                Code = field("No.")));
            Caption = 'Appendix Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Print Appendix"; Option)
        {
            Caption = 'Print Appendix';
            OptionCaption = ' ,First copy,All copies';
            OptionMembers = " ","First copy","All copies";
        }
        field(25; "Free Field No. 1"; Integer)
        {
            Caption = 'Free Field No. 1';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 1", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetLineFieldDescription("Free Field No. 1", "Free Field Caption 1");
            end;
        }
        field(26; "Free Field No. 2"; Integer)
        {
            Caption = 'Free Field No. 2';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 2", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetLineFieldDescription("Free Field No. 2", "Free Field Caption 2");
            end;
        }
        field(27; "Free Field No. 3"; Integer)
        {
            Caption = 'Free Field No. 3';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 3", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetLineFieldDescription("Free Field No. 3", "Free Field Caption 3");
            end;
        }
        field(28; "Free Field No. 4"; Integer)
        {
            Caption = 'Free Field No. 4';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 4", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetLineFieldDescription("Free Field No. 4", "Free Field Caption 4");
            end;
        }
        field(29; "Free Field No. 5"; Integer)
        {
            Caption = 'Free Field No. 5';
            MinValue = 0;
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Free Field No. 5", FieldTable."No.");
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetLineFieldDescription("Free Field No. 5", "Free Field Caption 5");
            end;
        }
        field(30; "Free Field Caption 1"; Text[30])
        {
            Caption = 'Free Field Caption 1';
        }
        field(31; "Free Field Caption 2"; Text[30])
        {
            Caption = 'Free Field Caption 2';
        }
        field(32; "Free Field Caption 3"; Text[30])
        {
            Caption = 'Free Field Caption 3';
        }
        field(33; "Free Field Caption 4"; Text[30])
        {
            Caption = 'Free Field Caption 4';
        }
        field(34; "Free Field Caption 5"; Text[30])
        {
            Caption = 'Free Field Caption 5';
        }
        field(35; "Reference Field Caption"; Text[50])
        {
            Caption = 'Reference Field Caption';
        }
        field(36; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(37; "Saluation Formula"; Option)
        {
            Caption = 'Use Saluation Formula';
            OptionCaption = ' ,Formal,Informal';
            OptionMembers = " ",Formal,Informal;
        }
        field(38; "Header Free Field No. 1"; Text[50])
        {
            Caption = 'Header Free Field No. 1';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 1");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Header Free Field No. 1", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 1", "Header Free Field Caption 1");
            end;
        }
        field(39; "Header Free Field No. 2"; Text[50])
        {
            Caption = 'Header Free Field No. 2';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 2");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Header Free Field No. 2", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 2", "Header Free Field Caption 2");
            end;
        }
        field(40; "Header Free Field No. 3"; Text[50])
        {
            Caption = 'Header Free Field No. 3';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 3");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Header Free Field No. 3", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 3", "Header Free Field Caption 3");
            end;
        }
        field(41; "Header Free Field No. 4"; Text[50])
        {
            Caption = 'Header Free Field No. 4';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 4");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Header Free Field No. 4", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 4", "Header Free Field Caption 4");
            end;
        }
        field(42; "Header Free Field No. 5"; Text[50])
        {
            Caption = 'Header Free Field No. 5';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Header Free Field No. 5");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Header Free Field No. 5", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 5", "Header Free Field Caption 5");
            end;
        }
        field(43; "Header Free Field Caption 1"; Text[50])
        {
            Caption = 'Header Free Field Caption 1';
        }
        field(44; "Header Free Field Caption 2"; Text[50])
        {
            Caption = 'Header Free Field Caption 2';
        }
        field(45; "Header Free Field Caption 3"; Text[50])
        {
            Caption = 'Header Free Field Caption 3';
        }
        field(46; "Header Free Field Caption 4"; Text[50])
        {
            Caption = 'Header Free Field Caption 4';
        }
        field(47; "Header Free Field Caption 5"; Text[50])
        {
            Caption = 'Header Free Field Caption 5';
        }
        field(48; "Print Buy-to Telephony"; Option)
        {
            Caption = 'Add With Buy-to Address';
            OptionCaption = ' ,Phone,Fax,Phone and Fax';
            OptionMembers = " ",Phone,Fax,"Phone and Fax";
        }
        field(49; "Footer Free Field No. 1"; Text[50])
        {
            Caption = 'Footer Free Field No. 1';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 1");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 1", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 1", "Footer Free Field Caption 1");
            end;
        }
        field(50; "Footer Free Field No. 2"; Text[50])
        {
            Caption = 'Footer Free Field No. 2';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 2");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 2", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 2", "Footer Free Field Caption 2");
            end;
        }
        field(51; "Footer Free Field No. 3"; Text[50])
        {
            Caption = 'Footer Free Field No. 3';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 3");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 3", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 3", "Footer Free Field Caption 3");
            end;
        }
        field(52; "Footer Free Field No. 4"; Text[50])
        {
            Caption = 'Footer Free Field No. 4';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 4");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 4", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 4", "Footer Free Field Caption 4");
            end;
        }
        field(53; "Footer Free Field Caption 1"; Text[50])
        {
            Caption = 'Footer Free Field Caption 1';
        }
        field(54; "Footer Free Field Caption 2"; Text[50])
        {
            Caption = 'Footer Free Field Caption 2';
        }
        field(55; "Footer Free Field Caption 3"; Text[50])
        {
            Caption = 'Footer Free Field Caption 3';
        }
        field(56; "Footer Free Field Caption 4"; Text[50])
        {
            Caption = 'Footer Free Field Caption 4';
        }
        field(57; Title; Text[50])
        {
            Caption = 'Title';
        }
        field(58; "Print Description 2"; Boolean)
        {
            Caption = 'Print Description 2';
        }
        field(59; "Log Interaction"; Boolean)
        {
            Caption = 'Journal interaction';

            trigger OnValidate()
            begin
                if "Log Interaction" then
                    "Archive Document" := true;
            end;
        }
        field(60; "Archive Document"; Boolean)
        {
            Caption = 'Archiver document';

            trigger OnValidate()
            begin
                if not "Archive Document" then
                    "Log Interaction" := false;
            end;
        }
        field(61; "Reference on new line"; Boolean)
        {
            Caption = 'Reference on new line';
        }
        field(62; "Print Prices"; Boolean)
        {
            Caption = 'Print Prices';
        }
        field(63; "Print Header Description"; Boolean)
        {
            Caption = 'Print Header Description';
        }
        field(64; "Hide Column Title"; Boolean)
        {
            Caption = 'Hide Title Line';
            InitValue = true;
        }
        field(65; "Print Shipment Address"; Boolean)
        {
            Caption = 'Print Shipment Address';
        }
        field(66; "Picture No."; Code[10])
        {
            Caption = 'Picture No.';
            TableRelation = "Header/Footer Logos"."No.";
        }
        field(67; "Release Doc Before Print"; Boolean)
        {
            Caption = 'Release';
        }
        field(68; "Item Total"; Boolean)
        {
            Caption = 'Item Total';
        }
        field(69; City; Option)
        {
            Caption = 'City';
            OptionCaption = 'None,Company information,Responsibility centre';
            OptionMembers = "None","Company information","Responsibility centre";
        }
        field(70; "Status Control"; Option)
        {
            Caption = 'Status Control';
            OptionCaption = ' ,Open,Released';
            OptionMembers = " ",Open,Released;
        }
    }

    keys
    {
        key(STG_Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+REF+TRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, 0, "No.");
        //+REF+TRANSLATION//
    end;

    trigger OnRename()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //+RE+FTRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.RenameTranslations(lRecordRef.Number, 0, xRec."No.", "No.");
        //+REF+TRANSLATION//
    end;

    var
        FieldRefTable: Record "Field" temporary;
        Text001: label 'Vous avez saisi une valeur illégale.';
        //GL2024 License  HeaderTable: Record "Object";
        //GL2024 License
        HeaderTable: Record AllObj;
        //GL2024 License

        FieldTable: Record "Field";
        TableNo: Integer;
        TableFilter: Text[250];
        // FieldSelection: Page 8001437;
        TmpText: Text[30];


    procedure InitLineFieldList()
    var
        lFilter: Text[250];
    begin
        TableNo := Database::"Purchase Line";
        FieldRefTable.DeleteAll;
        FieldTable.Reset;
        FieldTable.SetRange(TableNo, TableNo);
        if FieldTable.Find('-') then
            repeat
                FieldRefTable := FieldTable;
                FieldRefTable.Insert;
            until FieldTable.Next = 0;

        FieldTable.Reset;
        FieldTable.SetRange(TableNo, TableNo);
        FieldTable.Find('-');
    end;


    procedure InitTableList()
    begin
        //BAT
        //#8228
        //TableFilter := '3|10|13|23|38|79|167|289|5050|5714';
        //#8317
        //TableFilter := '3|10|13|18|36|79|8004160|289|5050|5714';
        TableFilter := '3|10|13|23|38|79|8004160|289|5050|5714';
        //#8317//
        //#8228//
        //BAT//

        HeaderTable.SetRange("Object Type", HeaderTable."Object Type"::Table);
        HeaderTable.SetFilter("Object id", TableFilter);
    end;


    procedure GetLineFieldDescription(pFieldNo: Integer; var pDescription: Text[30])
    begin
        InitLineFieldList;
        if pFieldNo > 0 then begin
            if not FieldTable.Get(TableNo, pFieldNo) then
                Error(Text001);
            pDescription := FieldTable."Field Caption";
        end else
            pDescription := '';
    end;


    procedure GetHeaderFieldCaption(var pText: Text[30]; var pCaption: Text[30])
    var
        i: Integer;
        lTableNo: Integer;
        lTableFieldNo: Integer;
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lSetupFieldNo: Integer;
    begin
        InitTableList;
        i := StrPos(pText, '.');
        if i > 0 then begin
            Evaluate(lTableNo, CopyStr(pText, 1, i - 1));
            Evaluate(lTableFieldNo, CopyStr(pText, i + 1));
        end else begin
            if not ((pText = '0') or (pText = '')) then
                Error(Text001);
            pText := '';
            pCaption := '';
            exit;
        end;

        if not isTableInFilter(lTableNo) then
            Error(Text001);
        if not FieldTable.Get(lTableNo, lTableFieldNo) then
            Error(Text001);
        if pCaption = '' then begin
            //DYS page Addon non migrer
            // FieldSelection.InitRequest(pText);
            // pCaption := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen(pCaption));
        end;

        HeaderTable.Reset;
    end;


    procedure isTableInFilter(pTableNo: Integer): Boolean
    begin
        if HeaderTable.Find('-') then
            repeat
                if HeaderTable."Object id" = pTableNo then
                    exit(true);
            until HeaderTable.Next = 0;
        exit(false);
    end;
}

