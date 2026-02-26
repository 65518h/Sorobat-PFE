Table 8001432 "Sales Document Model"
{
    // #8228 SD 13/09/10
    // //BAT Renumering 167 -> 8004160
    // //RTC CW 26/01/10 -"Document Type" and Key
    // //+REF+DOCUMENT GESWAY 27/05/03 Table des options d'impression des devis
    //                17/06/03 Ajout champ "Totaling Field Identification"
    //                19/06/03 Ajout champs "Description Page Title","Interline","Include Title Page"
    //                14/08/03 Ajout champs "Send Quote To","Title Page Address 1","Title Page Address 2"
    //                12/09/03 Ajout champs "Free Field No. 1" à "Free Field No. 5"
    //                         Ajout champs "Free Field Caption 1" à "Free Field Caption 5"
    //                         Modif Date Type du champ "Totaling Field Reference" -> Option vers Integer
    //                         Ajout champs "Totaling Field Ref. Caption"
    //                10/10/03 Ajout champs "Free Field No. 1" à "Free Field No. 5"
    //                         Ajout champs "Free Field Caption 1" à "Free Field Caption 5"
    //                27/10/03 Ajout champ "Print Bill Of Quantities"
    //                10/03/04 Ajout champ "Salutation Formula"
    //                26/07/04 Ajout Journal interaction, Archiver document
    // //+REF+TRANSLATION CW 11/10/05 OnDelete, OnRename

    Caption = 'Sales Document Model';
    // DrillDownPageID = 8001450;
    //LookupPageID = 8001450;

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; "No. Of Copies"; Integer)
        {
            Caption = 'Nombre de copies';
        }
        field(4; "Print Prices"; Boolean)
        {
            Caption = 'Print Prices';
        }
        field(9; "Print Description"; Option)
        {
            Caption = 'Print Description';
            OptionCaption = 'None,Externe,Internal';
            OptionMembers = "None",External,Internal;
        }
        field(13; "Reference Field No."; Integer)
        {
            Caption = 'Reference Field No.';
            TableRelation = Field."No.";

            trigger OnLookup()
            begin
                InitLineFieldList;
                //DYS page Addon non migrer
                // if PAGE.RunModal(page::"Field List BGW", FieldTable) = Action::LookupOK then
                //     Validate("Reference Field No.", FieldTable."No.");
            end;

            trigger OnValidate()
            begin
                GetFieldDescription("Reference Field No.", "Reference Field Caption");
            end;
        }
        field(14; "Header Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8001432),
                                                                FieldID = const(14),
                                                                Code = field("No.")));
            Caption = 'Header Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Title; Text[50])
        {
            Caption = 'Title';
        }
        field(19; "Print Continued"; Boolean)
        {
            Caption = 'Print Continued';
        }
        field(20; "Using Pre-Printed"; Boolean)
        {
            Caption = 'Using Pre-Printed';
        }
        field(21; "Release Sales Document"; Boolean)
        {
            Caption = 'Release Document';

            trigger OnValidate()
            begin
                if "Release Sales Document" then
                    TestField("Status Control", "status control"::" ");
            end;
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
                GetFieldDescription("Free Field No. 1", "Free Field Caption 1");
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
                GetFieldDescription("Free Field No. 2", "Free Field Caption 2");
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
                GetFieldDescription("Free Field No. 3", "Free Field Caption 3");
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
                GetFieldDescription("Free Field No. 4", "Free Field Caption 4");
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
                GetFieldDescription("Free Field No. 5", "Free Field Caption 5");
            end;
        }
        field(30; "Free Field Caption 1"; Text[30])
        {
            Caption = 'Free Field Caption 1';
            FieldClass = Normal;
        }
        field(31; "Free Field Caption 2"; Text[30])
        {
            Caption = 'Free Field Caption 2';
            FieldClass = Normal;
        }
        field(32; "Free Field Caption 3"; Text[30])
        {
            Caption = 'Free Field Caption 3';
            FieldClass = Normal;
        }
        field(33; "Free Field Caption 4"; Text[30])
        {
            Caption = 'Free Field Caption 4';
            FieldClass = Normal;
        }
        field(34; "Free Field Caption 5"; Text[30])
        {
            Caption = 'Free Field Caption 5';
            FieldClass = Normal;
        }
        field(35; "Reference Field Caption"; Text[30])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = const(37),
                                                              "No." = field("Reference Field No.")));
            Caption = 'Ref. Field Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Header Free Field No. 1"; Text[30])
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
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 1", FieldSelection.GetResult);
                //     "Header Free Field Caption 1" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 1"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 1", "Header Free Field Caption 1");
            end;
        }
        field(50; "Header Free Field No. 2"; Text[30])
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
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 2", FieldSelection.GetResult);
                //     "Header Free Field Caption 2" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 2"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 2", "Header Free Field Caption 2");
            end;
        }
        field(51; "Header Free Field No. 3"; Text[30])
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
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 3", FieldSelection.GetResult);
                //     "Header Free Field Caption 3" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 3"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 3", "Header Free Field Caption 3");
            end;
        }
        field(52; "Header Free Field No. 4"; Text[30])
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
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 4", FieldSelection.GetResult);
                //     "Header Free Field Caption 4" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 4"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 4", "Header Free Field Caption 4");
            end;
        }
        field(53; "Header Free Field No. 5"; Text[30])
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
                // if FieldSelection.RunModal = Action::LookupOK then begin
                //     Validate("Header Free Field No. 5", FieldSelection.GetResult);
                //     "Header Free Field Caption 5" := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen("Header Free Field Caption 5"));
                // end;
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Header Free Field No. 5", "Header Free Field Caption 5");
            end;
        }
        field(54; "Header Free Field Caption 1"; Text[30])
        {
            Caption = 'Header Free Field Caption 1';
        }
        field(55; "Header Free Field Caption 2"; Text[30])
        {
            Caption = 'Header Free Field Caption 2';
        }
        field(56; "Header Free Field Caption 3"; Text[30])
        {
            Caption = 'Header Free Field Caption 3';
        }
        field(57; "Header Free Field Caption 4"; Text[30])
        {
            Caption = 'Header Free Field Caption 4';
        }
        field(58; "Header Free Field Caption 5"; Text[30])
        {
            Caption = 'Header Free Field Caption 5';
        }
        field(59; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(61; "Saluation Formula"; Option)
        {
            Caption = 'Use Saluation Formula';
            OptionCaption = ' ,Formal,Informal';
            OptionMembers = " ",Formal,Informal;
        }
        field(63; "Log Interaction"; Boolean)
        {
            Caption = 'Journal interaction';

            trigger OnValidate()
            begin
                if "Log Interaction" then
                    "Archive Document" := true;
            end;
        }
        field(64; "Archive Document"; Boolean)
        {
            Caption = 'Archiver document';

            trigger OnValidate()
            begin
                if not "Archive Document" then
                    "Log Interaction" := false;
            end;
        }
        field(65; "Unit Price Minus Discount"; Boolean)
        {
            Caption = 'Unit Price Minus Discount';
        }
        field(66; "Footer Free Field No. 1"; Text[30])
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
        field(67; "Footer Free Field No. 2"; Text[30])
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
        field(68; "Footer Free Field No. 3"; Text[30])
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
        field(69; "Footer Free Field No. 4"; Text[30])
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
        field(70; "Footer Free Field No. 5"; Text[30])
        {
            Caption = 'Footer Free Field No. 5';

            trigger OnLookup()
            begin
                InitTableList;
                //DYS page Addon non migrer
                // Clear(FieldSelection);
                // FieldSelection.LookupMode(true);
                // FieldSelection.InitRequest("Footer Free Field No. 5");
                // FieldSelection.SetTableview(HeaderTable);
                // if FieldSelection.RunModal = Action::LookupOK then
                //     Validate("Footer Free Field No. 5", FieldSelection.GetResult);
            end;

            trigger OnValidate()
            var
                i: Integer;
            begin
                GetHeaderFieldCaption("Footer Free Field No. 1", "Footer Free Field Caption 1");
            end;
        }
        field(71; "Footer Free Field Caption 1"; Text[30])
        {
            Caption = 'Footer Free Field Caption 1';
        }
        field(72; "Footer Free Field Caption 2"; Text[30])
        {
            Caption = 'Footer Free Field Caption 2';
        }
        field(73; "Footer Free Field Caption 3"; Text[30])
        {
            Caption = 'Footer Free Field Caption 3';
        }
        field(74; "Footer Free Field Caption 4"; Text[30])
        {
            Caption = 'Footer Free Field Caption 4';
        }
        field(75; "Footer Free Field Caption 5"; Text[30])
        {
            Caption = 'Footer Free Field Caption 5';
        }
        field(76; "Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8001432),
                                                                FieldID = const(76),
                                                                Code = field("No.")));
            Caption = 'FooterText';
            Editable = false;
            FieldClass = FlowField;
        }
        field(86; "Hide Column Title"; Boolean)
        {
            Caption = 'Hide Title Line';
        }
        field(87; "Print Description 2"; Boolean)
        {
            Caption = 'Print Description 2';
        }
        field(88; City; Option)
        {
            Caption = 'City';
            OptionCaption = 'Company information,Responsibility centre, ';
            OptionMembers = "Company information","Responsibility centre"," ";
        }
        field(89; "Status Control"; Option)
        {
            Caption = 'Status Control';
            OptionCaption = ' ,Open,Released';
            OptionMembers = " ",Open,Released;

            trigger OnValidate()
            begin
                if "Status Control" > "status control"::" " then
                    TestField("Release Sales Document", false);
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
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
        //TRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 1"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 2"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 3"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 4"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Free Field Caption 5"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Reference Field Caption"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 1"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 2"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 3"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 4"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 5"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 1"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 2"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 3"), "No.");
        lTranslationMgt.DeleteTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 4"), "No.");
        //TRANSLATION//
    end;

    trigger OnRename()
    var
        lTranslationMgt: Codeunit "Translation Management";
        lRecordRef: RecordRef;
    begin
        //TRANSLATION
        lRecordRef.GetTable(Rec);
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 1"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 2"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 3"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 4"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Free Field Caption 5"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Reference Field Caption"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 1"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 2"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 3"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 4"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Header Free Field Caption 5"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 1"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 2"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 3"), xRec."No.", "No.");
        lTranslationMgt.RenameTranslations(lRecordRef.Number, FieldNo("Footer Free Field Caption 4"), xRec."No.", "No.");
        //TRANSLATION
    end;

    var
        Text001: label 'Vous avez saisi une valeur illégale.';
        Criteria: Record "Code";
        //GL2024 License  "Table": Record "Object";
        //GL2024 License HeaderTable: Record "Object";
        //GL2024 License
        "Table": Record AllObj;
        HeaderTable: Record AllObj;
        //GL2024 License
        FieldTable: Record "Field";
        RefFieldTable: Record "Field" temporary;
        TableNo: Integer;
        // FieldSelection: Page 8001437;
        TableFilter: Text[250];


    procedure InitTableList()
    begin
        //BAT
        //#8228
        //TableFilter := '3|10|13|18|36|79|167|289|5050|5714';
        TableFilter := '3|10|13|18|36|79|8004160|289|5050|5714';
        //#8228//
        //BAT//
        Table.SetRange("Object Type", Table."Object Type"::Table);
        HeaderTable.SetRange("Object Type", HeaderTable."Object Type"::Table);
        HeaderTable.SetFilter("Object id", TableFilter);
    end;


    procedure InitLineFieldList()
    var
        lFilter: Text[250];
    begin
        TableNo := Database::"Sales Line";
        RefFieldTable.DeleteAll;
        FieldTable.Reset;
        FieldTable.SetRange(TableNo, TableNo);
        FieldTable.SetFilter("No.", '%1|%2|%3|%4', 6, 47, 5705, 8004056);
        if FieldTable.Find('-') then
            repeat
                RefFieldTable := FieldTable;
                RefFieldTable.Insert;
            until FieldTable.Next = 0;

        FieldTable.Reset;
        FieldTable.SetRange(TableNo, TableNo);
        FieldTable.Find('-');
    end;


    procedure GetFieldDescription(pFieldNo: Integer; var pDescription: Text[30])
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

        /*lRecordRef.GETTABLE(NavibatSetup);
        CASE lTableNo OF
          36: BEGIN
            CASE lTableFieldNo OF
              8003912:
                pCaption := NavibatSetup."Person Responsible Name 1";
              8003947..8004050: BEGIN
                lSetupFieldNo := lTableFieldNo - 31;
                lFieldRef := lRecordRef.FIELD(lSetupFieldNo);
                pCaption := lFieldRef.VALUE;
              END;
              8003956..8003965: BEGIN
                lSetupFieldNo := lTableFieldNo - 36;
                lFieldRef := lRecordRef.FIELD(lSetupFieldNo);
                pCaption := lFieldRef.VALUE;
              END;
            END;
          END;
        END; */
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

