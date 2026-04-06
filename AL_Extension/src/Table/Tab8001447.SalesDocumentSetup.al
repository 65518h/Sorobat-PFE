Table 8001447 "Sales Document Setup"
{
    // #6359 CW 07/08/08

    Caption = 'Sales Document Setup';
    // LookupPageID = 8001448;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Address Description"; Text[30])
        {
            Caption = 'Address Description';
        }
        field(3; "Invoice/Credit Memo Footer"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(8001447),
                                                                FieldID = const(3)));
            Caption = 'Invoice/Cr. Memo FooterText';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Header Free Field No. 1"; Text[30])
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
        field(12; "Header Free Field No. 2"; Text[30])
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
        field(13; "Header Free Field No. 3"; Text[30])
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
        field(14; "Header Free Field No. 4"; Text[30])
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
        field(15; "Header Free Field No. 5"; Text[30])
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
        field(21; "Header Free Field Caption 1"; Text[30])
        {
            Caption = 'Header Free Field Caption 1';
        }
        field(22; "Header Free Field Caption 2"; Text[30])
        {
            Caption = 'Header Free Field Caption 2';
        }
        field(23; "Header Free Field Caption 3"; Text[30])
        {
            Caption = 'Header Free Field Caption 3';
        }
        field(24; "Header Free Field Caption 4"; Text[30])
        {
            Caption = 'Header Free Field Caption 4';
        }
        field(25; "Header Free Field Caption 5"; Text[30])
        {
            Caption = 'Header Free Field Caption 5';
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FieldRefTable: Record "Field" temporary;
        //GL2024 License    HeaderTable: Record "Object";
        //GL2024 License
        HeaderTable: Record AllObj;
        //GL2024 License
        FieldTable: Record "Field";
        TableNo: Integer;
        TableFilter: Text[250];
        //DYS page Addon non migrer
        //FieldSelection: Page 8001437;
        TmpText: Text[30];
        Text001: label 'You have entered an illegal value.';


    procedure InitTableList()
    begin
        TableFilter := '3|10|13|18|112|79|167|8004160|289|5050|5714';
        HeaderTable.SetRange("Object Type", HeaderTable."Object Type"::Table);
        HeaderTable.SetFilter("Object id", TableFilter);
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

