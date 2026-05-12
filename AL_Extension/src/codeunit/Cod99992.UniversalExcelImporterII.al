Codeunit 99992 "Universal Excel Importer II"
{
    // //
    // // Universal Excel Importer
    // // (c) 2006-2008 Slawek Guzek, sguzek@onet.pl
    // //
    // 
    // HOW TO USE IMPORTER INSIDE CODE
    // 
    //  There are 2 possible function calls -  3 parameter funcion call and 6 parameter function call.
    //  3 parameter funcion call provides minimum parameters and rely on user choices of file, and various options.
    // 
    // ImportData(tableNo, columnFilter, importOptions) : Integer
    // 
    //   tableNo - destination table number. If set to 0 Importer tries to read table no
    //     from Excel File, from any cell from first non-emty row of imported worksheet.
    //     If doesn't find 'table:<destinationTableNo>' in a cell then asks user
    // 
    //   columnFilter - put here filter (in Navision syntax) which fields are allowed
    //     to import. Putting empty string here causes all fields are allowed. Importer
    //     don't allow to import data to flowfields or flowfilters, regardless of columnFilter
    //     value.
    //     When specifying filter remember to include primary key fields in it !
    // 
    //   importOptions - define Importer behaviour, tells Importer what to do with data
    // 
    // 
    // ImportDataFromFile(VAR fileName, VAR sheetName,tableNo,headerRow,columnFilter,importOptions)
    // 
    //   fileName - put a TEXT VARIABLE here storing Excel file name to import. If variable
    //     is empty or file does not exist Importer asks for new file, and returns
    //     here selected filename.
    // 
    //   sheetName - put a TEXT VARIABLE here storing Excel worksheet to import. If variable
    //     is empty, or worksheet doesn't exist in Excel file, Importer allows user
    //     fo select one workheet among existing in file and returns user selection here
    // 
    //   tableNo - destination table number. Described in ImportData() function.
    // 
    //   headerRow - tells Importer where to find in Excel file row with field captions,
    //     names or numbers, or with parameters. The data to import is assumed to be
    //     in non empty rows below header.
    // 
    //   columnFilter - Described in ImportData() function.
    // 
    //   importOptions - define Importer behaviour, tells Importer what to do with data
    // 
    // 
    // OPIONS THAT CAN BE SET PROGRAMATICALLY
    // 
    // To set option programatically (during run-time) an integer value have to be passed to
    // Importer function call. Some bits of the integer has assigned meaning,
    // 
    //  Allowed values are:
    // 
    //    d1 d0
    //    0  0 - illegal, Importer will change to 3 - Insert or Update
    //    0  1 (importOptions=1) - insert new records
    //    1  0 (importOptions=2) - update existing data
    //    1  1 (importOptions=3) - insert new or update data
    //      when inserting new records insert will be done just after filling primary
    //      key fields, then fills the rest and launches MODIFY
    // 
    //   d2=1 (importOptions=4) - Delayed insert.
    //     when inserting Importer inserts records after filling all fields
    //   d3=1 (importOptions=8) - import all
    //     imports all columne regardless of Excel Italic attribute in Excel header
    // 
    //   searching for fields in Excel header
    //    d5 d4
    //    0  0 - match Excel column header to Field Caption
    //    0  1 (importOptions=16) - match Excel column header to Field Name
    //    1  x (importOptions=32) - match Excel column header to Field No.
    // 
    //   use of VALIDATE trigger
    //    d7 d6
    //    0  0 - VALIDATE all by default
    //    0  1 (importOptions=64)  - Don't VALIDATE all by default
    //    1  x (importOptions=128) - VALIDATE according to header in Excel (Bold=VALIDATE)
    // 
    //    d8=1 (importOptions=256) - don't use INSERT(True)/Modify(True)
    // 
    //    d10=1 (importOptions=1024) - don't allow to change options
    //      user will not be allowed to change options (update,insert,OnInsert(True))
    // 
    //    d11=1 (importOptions=2048) - don't allow to change mapping
    //      user will not be allowed to add or change destination fields
    // 
    //    d12=1 (importOptions=4096) - don't allow to change validation
    //      user will not be allowed to choose whether to VALIDATE destination field or not
    // 
    //    d31=1 (importOptions=2147483648) - silent mode
    //      no questions, no field mapping dialog, just import based on parameters and excel settings
    // 
    // HOW TO COMBINE VARIOUS OPTIONS ?
    // 
    //  Just add their decimal values. For example: if you want Importer to update only
    //  fields in destination table you need ImportOption=2, and if you've put field numbers
    //  as header row in Excel and wants Importer to try to match it using field numbers you
    //  will need to pass ImportOption=32. To have both option set just pass the sum of options'
    //  decimal values, importOption=34 (2+32)
    // 
    //  Usually put 0 here which mean Importer will try to match header assuming that
    //  it contains field captions IN CURRENT LANGUAGE, and insert new or update existing
    //  records in the destination table.
    // 
    // WHAT OPTIONS CAN BE SET INSIDE EXCEL FILE ?
    // 
    //  Importer options can be set by specyfying parameter keywords with values in one or a few cells
    //  in single row, or by formating column headers. First non-empty row is considered as a config
    //  row if contains in any cell at least one recognizable parameter.
    // 
    //  If there is no recognizable parameters found the first nonempty row is then considered
    //  as the header row. Otherwise the next non-empty row is considered as header row, or one set
    //  by parameter
    // 
    //  Two options can be set by formatting cells in header row:
    // 
    //   BOLD - this tells importer to launch VALIDATE trigger on this field.
    //     This works if options passed to importer funcion call
    //     has bit 7 set (ImporterOption = 128)
    // 
    //   ITALIC - this tells importer to SKIP the field during import.
    //     This can be overrided by passing to importer funcion call
    //     integer with bit d3 set (ImporterOption = 8)
    // 
    // Accepted parameters formats are:
    //   1. ParameterID:ParameterValue
    //   2. ParameterID:TargetField=ParameterValue
    //     - target field can be field name, or field number
    // 
    // Acceptable excel parameters description:
    //   table:number
    //       - tells Importer the destination table number
    //     Example:
    //       table:27
    //   importall
    //       - has no additional parameter values, tells Importer to import all columns to which
    //         matching field will be found, and ignore Italic settings
    // 
    //   header:number
    //       - tell the importer the row number from where Importer starts to search for row
    //         interpreted as table header. All rows above given number are skipped, and can contain
    //         any data, fo example some comments, etc.
    //     Example:
    //        header:6 - importer skip all rows between current row and row number 5 inclusive,
    //            and will start to search for header from row 6
    // 
    //   const:field_name=constant_value
    //       - field 'field_name' in every record will be filled with constant_value
    //     Example:
    //        const:description 2=My preset - if the destination table is set to one having field
    //            'Description 2' (example Item - 27), field named 'Description 2' in every imported
    //            line will be filled in with text 'My preset'
    //        const:5=My preset - in this case parameter Table:number has to be setup proir to instance
    //            of const parameter. If destination table will be set to 27, then in every imported
    //            record field number 5 ('Description 2' in case of table 27) will be filled in with
    //            text 'My preset'
    // 
    //    counter:field_name=start_value
    //        - field 'field_name' in every record will be filled with value, starting with 'start_value'
    //          in first record, and incremented with every record inserted. Very usefull for reading into
    //          journal tables
    //       Example:
    //         counter:No.=IT0001 - when importing to table 27 field No. in first imported row will have
    //           IT0001 value, in second IT0001, and so on
    //         counter:1=IT0001 - in this case parameter Table:number has to be setup proir to instance
    //           of counter parameter. Then 1 is interpreted as field number of table set by parameter
    //           table:number
    // 
    // Parameters can be passed on per cell, or combined in one or more cell, separated by semicolons.
    //    Example:
    //      1. cell A1-> table:27,  cell A2-> counter:No.=I0001, cell A3-> const:5=My preset
    //      2. cell A1-> table:27,  cell A3-> counter:No.=I0001;const:5=My preset
    // 
    // Parameters are always read from first row containing any of recognizeable parameters, and only
    // from this one single row (so-called 'config row'). Parameters are read from left cell to right
    // and last read takes precedence before first. There no need to put parameters in
    // consequtive cells. There can be another data put in config row - it will be ignored.


    trigger OnRun()
    var
        t: Text[120];
        dat: Date;
    begin
        ImportData(0, '', 1 + 2 + 128);
    end;

    var
        PARAMDEF_TABLE: label 'table';
        PARAMDEF_HEADER: label 'TableHeader';
        PARAMDEF_IMPORTALL: label 'ImportAll';
        PARAMDEF_COUNTER: label 'Incr';
        PARAMDEF_COUNTER2: label 'Count';
        PARAMDEF_CONSTANT: label 'Const';
        PARAMDEF_COPY: label 'Copy';
        PARAMDEF_SKIPTRIGGERS: label 'SkipTriggers';
        F_EXCLELSRC: label 'E';
        F_PKEY: label 'K';
        Text000: label 'Open source file';
        Text001: label 'Import/update of data finished successfully';
        Text002: label 'Importing...\@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text003: label '''No such option: %1''';
        Text004: label 'The Excel worksheet %1 does not exist.';
        Text005: label 'No header information in buffer row %1';
        Text006: label '''No required primary key field "%1" (%2) in user filter';
        Text007: label 'Reading Excel worksheet...\\';
        Text008: label 'Import stopped at user request';
        Text009: label '''Select Import, Update, or both options''';
        Text010: label '''No field mapping information in buffer''';
        Text011: label 'Fields:\%1\were not imported. Fields type of\%2\can not be read form Excel.  ';
        //GL2024 Automation non compatible XlWrkSht: Automation;
        //GL2024 Automation non compatible XlApp: Automation;
        //GL2024 Automation non compatible  XlWrkBk: Automation;
        warn: Boolean;
        Text012: label 'No such table no: %1';
        Text013: label 'Intenal error: No primary key info in buffer table';
        Text014: label 'Error in format of data for BigInteger type field ';
        EXCELBuffer: Record "Excel Buffer";


    procedure ImportData(tableNo: Integer; columnFilter: Text[1024]; importOptions: Integer): Integer
    var
        filename: Text[250];
        sheetName: Text[50];
    begin
        filename := '';
        sheetName := '';
        exit(
          ImportDataFromFile(filename, sheetName, tableNo, 0, columnFilter, importOptions)
          );
    end;


    procedure ImportDataFromFile(var fileName: Text[512]; var sheetName: Text[50]; tableNo: Integer; headerRow: Integer; columnList: Text[1024]; ImporterOptions: Integer): Integer
    var
        fieldMapping: Record "Excel Buffer" temporary;
        EXCELBuffer2: Record "Excel Buffer";
        recRef: RecordRef;
        columnFilter: Text[1024];
        optInsert: Boolean;
        optUpdate: Boolean;
        optNoOnInsertTrigger: Boolean;
        optDelayedInsert: Boolean;
        statusWindow: Dialog;
        recordFound: Boolean;
        rowCount: Integer;
        lineCount: Integer;
        dataStart: Integer;
        dataEnd: Integer;
        newHeaderRow: Integer;
        searchByOption: Option FieldCaption,FieldName,FieldNo;
        validateOption: Option All,"None",FileDefined;
        i: Integer;
    begin
        if ImporterOptions MOD 4 = 0 then
            ImporterOptions += 3; // import OR update

        if SelectExcelSource(fileName, sheetName) < 0 then
            exit(-1);

        headerRow := readHeader(fileName, sheetName, headerRow, tableNo, ImporterOptions);

        if not testTableNo(tableNo) then
            exit(-1);

        optInsert := testBit(0, ImporterOptions);
        optUpdate := testBit(1, ImporterOptions);

        case true of
            testBit(5, ImporterOptions):
                searchByOption := Searchbyoption::FieldNo;
            testBit(4, ImporterOptions):
                searchByOption := Searchbyoption::FieldName;
            else
                searchByOption := Searchbyoption::FieldCaption;
        end;
        case true of
            testBit(7, ImporterOptions):
                validateOption := Validateoption::FileDefined;
            testBit(6, ImporterOptions):
                validateOption := Validateoption::None;
            else
                validateOption := Validateoption::All;
        end;

        generatePrimaryKeyInfo(tableNo, EXCELBuffer);
        checkUserColumnFilter(columnList, EXCELBuffer);
        generateFieldMapping(tableNo, columnList, headerRow, ImporterOptions);
        postProcessParams(headerRow);

        columnFilter := ChooseColumnsToImport(tableNo, columnList, ImporterOptions);

        readFieldMapping(fieldMapping, ImporterOptions, FieldMappingRowFiler);

        EXCELBuffer.SetFilter("Row No.", '>%1', headerRow);
        ReadSelectedSheetArea(fileName, sheetName, StrSubstNo('>%1', headerRow), columnFilter);

        //GL2024 Automation non compatible  clearExcel;

        optInsert := testBit(0, ImporterOptions);
        optUpdate := testBit(1, ImporterOptions);
        optDelayedInsert := testBit(2, ImporterOptions);
        optNoOnInsertTrigger := testBit(8, ImporterOptions);

        EXCELBuffer.Reset;
        EXCELBuffer.SetFilter("Row No.", '>%1', headerRow);
        rowCount := EXCELBuffer."Row No.";

        statusWindow.Open(Text002);
        EXCELBuffer.Find('-');

        repeat
            EXCELBuffer2 := EXCELBuffer;
            Clear(recRef);
            recRef.Open(tableNo);
            i := EXCELBuffer."Row No.";
            EXCELBuffer.SetRange("Row No.", i);
            statusWindow.Update(1, ROUND(10000 * i / rowCount, 1));

            recRef.Init;
            recordFound := findRecord(recRef, fieldMapping, searchByOption);

            if optInsert and not recordFound then begin
                fillRecord(recRef, fieldMapping, searchByOption, not optDelayedInsert);
                if optNoOnInsertTrigger then
                    recRef.Insert(false)
                else
                    recRef.Insert(true);
            end;
            if (optInsert and not optDelayedInsert) or (recordFound and optUpdate) then begin
                fillRecord(recRef, fieldMapping, searchByOption, false);
                if optNoOnInsertTrigger then
                    recRef.Modify(false)
                else
                    recRef.Modify(true);
            end;
            lineCount += 1;

            EXCELBuffer := EXCELBuffer2;
            EXCELBuffer.Find('+');
            EXCELBuffer.SetRange("Row No.");
            EXCELBuffer.Find('=');
            recRef.Close;
        until EXCELBuffer.Next = 0;

        statusWindow.Close;
        generateWarning(fieldMapping);
        exit(lineCount);
    end;


    procedure PrimaryKeyInfoBeginRow(): Integer
    begin
        exit(-999);
    end;


    procedure PrimaryKeyInfoEndRow(): Integer
    begin
        exit(-900);
    end;


    procedure ConstantsAreaBeginRow(): Integer
    begin
        exit(-809);
    end;


    procedure ConstantsAreaEndRow(): Integer
    begin
        exit(-701);
    end;


    procedure FieldMapBeginRow(): Integer
    begin
        exit(-700);
    end;


    procedure FieldMapEndRow(): Integer
    begin
        exit(-1);
    end;


    procedure FieldMappingMaxRange(): Integer
    begin
        exit(FieldMapEndRow);
    end;


    procedure FieldMappingMinRange(): Integer
    begin
        exit(PrimaryKeyInfoBeginRow);
    end;

    local procedure FieldMappingRowFiler(): Text[50]
    begin
        exit(Format(FieldMappingMinRange, 0, 2) + '..' + Format(FieldMappingMaxRange, 0, 2));
    end;


    procedure getPARAMDEF_INCREMENT(): Text[30]
    begin
        exit(PARAMDEF_COUNTER);
    end;


    procedure getPARAMDEF_INCREMENT2(): Text[30]
    begin
        exit(PARAMDEF_COUNTER2);
    end;


    procedure getPARAMDEF_CONSTANT(): Text[30]
    begin
        exit(PARAMDEF_CONSTANT);
    end;


    procedure getPARAMDEF_COPY(): Text[30]
    begin
        exit(PARAMDEF_COPY);
    end;

    local procedure testTableNo(var tableNo: Integer): Boolean
    var
        //GL2024 License "Object": Record "Object";
        //GL2024 License
        "Object": Record AllObj;
    //GL2024 License
    begin
        case true of
            tableNo > 0:
                if not Object.Get(Object."Object Type"::Table, '', tableNo) then begin
                    //GL2024 Automation non compatible     clearExcel;
                    Error(Text012, tableNo)
                end else
                    exit(true);
            tableNo = 0:
                begin
                    Commit;
                    /* GL2024 if Page.RunModal(Page::"UEI - Table List", Object) = Action::LookupOK then begin
                          tableNo := Object.ID;
                          exit(true);
                      end else begin
                          clearExcel;
                          Error('');
                      end;*/
                end;
        end;
        exit(false);
    end;

    local procedure LeaveCharacters(text: Text[512]; charsToLeave: Text[255]) newText: Text[512]
    var
        l: Integer;
        t: Text[1];
    begin
        l := StrLen(text);
        while l > 0 do begin
            t[1] := text[l];
            if StrPos(charsToLeave, t) > 0 then
                newText := t + newText;
            l -= 1;
        end;
        exit(newText);
    end;


    procedure testBit(BitNo: Integer; value: Integer) retVal: Boolean
    begin
        // test if bit BitNo is set in word Value
        if (BitNo >= 0) and (BitNo < 32) then
            exit(ROUND(value / Power(2, BitNo), 1, '<') MOD 2 > 0)
    end;


    procedure setBit(BitNo: Integer; var value: Integer) retVal: Integer
    begin
        if (BitNo >= 0) and (BitNo < 32) then
            if not testBit(BitNo, value) then
                value += Power(2, BitNo);
    end;


    procedure clearBit() retVal: Integer
    var
        BitNo: Integer;
        value: Integer;
    begin
        if (BitNo >= 0) and (BitNo < 32) then
            if testBit(BitNo, value) then
                value -= Power(2, BitNo);
    end;

    local procedure findFieldNoByCaption(tableNo: Integer; fieldCaption: Text[100]) columnNo: Integer
    var
        FieldList: Record "Field";
        fc: Code[100];
    begin
        FieldList.Reset;
        FieldList.SetRange(TableNo, tableNo);
        fieldCaption := UpperCase(fieldCaption);

        FieldList.Find('-');
        repeat
            fc := FieldList."Field Caption";
            if fc = fieldCaption then
                exit(FieldList."No.");
        until FieldList.Next = 0;

        exit(0);
    end;

    local procedure findFieldNoByName(tableNo: Integer; fieldName: Text[40]) columnNo: Integer
    var
        FieldList: Record "Field";
    begin
        FieldList.Reset;
        FieldList.SetRange(TableNo, tableNo);
        fieldName := UpperCase(fieldName);

        FieldList.Find('-');
        repeat
            if UpperCase(FieldList.FieldName) = fieldName then
                exit(FieldList."No.");
        until FieldList.Next = 0;

        exit(0);
    end;

    local procedure findTextInList(list: Text[1024]; textToSearchFor: Text[250]; onlyFullMatch: Boolean): Integer
    var
        i: Integer;
        optionNo: Integer;
        beginOptionText: Integer;
        optionTextLen: Integer;
        optionListLen: Integer;
        textToSearchForLen: Integer;
        optionText: Text[250];
    begin
        textToSearchFor := UpperCase(textToSearchFor);
        textToSearchForLen := StrLen(textToSearchFor);

        optionListLen := StrLen(list);

        beginOptionText := 1;
        i := 1;

        while i < optionListLen do begin
            while (i <= optionListLen) and (list[i] <> ',') do
                i += 1;
            optionTextLen := i - beginOptionText;
            optionText := CopyStr(list, beginOptionText, optionTextLen);
            if onlyFullMatch then begin
                if UpperCase(optionText) = textToSearchFor then
                    exit(optionNo);
            end else
                if UpperCase(CopyStr(optionText, 1, textToSearchForLen)) = textToSearchFor then
                    exit(optionNo);
            optionNo += 1;
            i += 1;
            beginOptionText := i;
        end;

        optionText := '';
        exit(-1);
    end;

    /* //GL2024 Automation non compatible  local procedure clearExcel()
       begin
           if not ISCLEAR(XlApp) then begin
               XlWrkBk.Close(false);
               if not ISCLEAR(XlWrkSht) then
                   Clear(XlWrkSht);
               XlApp.Quit;
               Clear(XlApp);
           end;
       end;*/
    /*
    //GL2024 Automation non compatible
        local procedure openExcelSheet(fileName: Text[512]; sheetName: Text[50]; var XlWrkSht: Automation)
        var
            XlWrkshts: Automation;
            i: Integer;
        begin
            if ISCLEAR(XlApp) then begin
                if not Create(XlApp, true) then
                    Error(Text000);
            end else
                if not ISCLEAR(XlWrkSht) then
                    if (XlWrkBk.FullName = UpperCase(fileName))
                      and (UpperCase(sheetName) = UpperCase(XlWrkSht.Name))
                    then
                        exit;

            XlApp.Workbooks._Open(fileName, true);

            XlWrkBk := XlApp.ActiveWorkbook;
            i := XlWrkBk.Worksheets.Count;

            while i > 0 do begin
                XlWrkshts := XlWrkBk.Worksheets.Item(i);
                if UpperCase(sheetName) = UpperCase(XlWrkshts.Name) then
                    i := 0;
                i -= 1;
            end;

            if i < 0 then
                XlWrkSht := XlWrkBk.Worksheets.Item(sheetName)
            else begin
                XlWrkBk.Close(false);
                XlApp.Quit;
                Clear(XlApp);
                Error(Text004, sheetName);
            end;
        end;

    */
    procedure removeDigits(inTxt: Text[500]) retVal: Text[512]
    var
        thousandsSeparator: Text[1];
    begin
        thousandsSeparator := ' ';
        thousandsSeparator[1] := Format(1000.0) [2];

        retVal := DelChr(inTxt, '<=>', '0123456789' + thousandsSeparator);
        exit(retVal)
    end;

    local procedure evaluateOption(var fieldRef: FieldRef; optionText: Text[30]; searchOption: Option FieldCaption,FieldName,FieldNo): Integer
    var
        optionNo: Integer;
        optionList: Text[250];
    begin

        case searchOption of
            Searchoption::FieldCaption:
                optionList := UpperCase(fieldRef.OptionCaption)
            else
                optionList := UpperCase(fieldRef.OptionString)
        end;

        optionNo := findTextInList(optionList, optionText, false);

        if optionNo >= 0 then
            exit(optionNo);

        optionList := removeDigits(optionText);
        if optionList <> '' then
            exit(-1);

        Evaluate(optionNo, optionText);
        exit(optionNo);
    end;

    local procedure SelectExcelSource(var FileName: Text[100]; var SheetName: Text[50]): Integer
    var
    //GL2024   DialogWindow: Codeunit 412;
    begin
        //GL2024 License   // if (FileName = '') or (not Exists(FileName)) then begin
        //     //GL2024    FileName := DialogWindow.OpenFile(Text000, '', 2/*=Excel*/, '', 0/*=Open*/);
        //GL2024 License    //     if FileName = '' then
        //GL2024 License  //         exit(-1);
        //GL2024 License    // end;

        /*//GL2024 License     if SheetName = '' then
                 SheetName := EXCELBuffer.SelectSheetsName(FileName);//GL2024 License*/

        if SheetName = '' then
            exit(-1);

    end;

    local procedure ReadSelectedSheetArea(fileName: Text[512]; sheetName: Text[50]; rowList: Text[1024]; columnList: Text[1024]): Integer
    var
        //GL2024 Automation non compatible XlWrkshts: Automation;
        //GL2024 Automation non compatible   XlRange: Automation;
        currRow: Integer;
        currCol: Integer;
        MaxRow: Integer;
        MaxCol: Integer;
        Window: Dialog;
        t: Text[100];
        row: Record "Integer";
        col: Record "Integer";
        cleanXLApp: Boolean;
        untilFirst: Boolean;
        firstFound: Boolean;
        rowCount: Integer;
        cellValue: Text[1024];
        lastRow: Integer;
        i: Integer;
        boolVal: Boolean;
    begin
        // open Excel book

        //GL2024 Automation non compatible   openExcelSheet(fileName, sheetName, XlWrkSht);

        if CopyStr(rowList, 1, 1) = '-' then begin
            untilFirst := true;
            rowList := CopyStr(rowList, 2);
        end;

        if rowList <> '' then begin
            row.FilterGroup(8);
            row.SetFilter(Number, rowList);
            row.FilterGroup(0);
        end;

        if columnList <> '' then begin
            col.FilterGroup(8);
            col.SetFilter(Number, columnList);
            col.FilterGroup(0);
        end;

        Window.Open(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.Update(1, 0);
        with EXCELBuffer do begin
            DeleteAll;
            //GL2024 Automation non compatible    XlRange := XlWrkSht.Range(GetExcelReference(5)).SpecialCells(11);
            //GL2024 Automation non compatible   MaxRow := XlRange.Row;
            //GL2024 Automation non compatible   MaxCol := XlRange.Column;
            rowCount := 0;
            currRow := 1;
            repeat
                currCol := 1;
                row.SetRange(Number, currRow);
                if (rowList = '') or (row.Find('-')) then begin // row No. in filter
                    repeat
                        col.SetRange(Number, currCol);
                        if (columnList = '') or (col.Find('-')) then begin // column No in filter
                            Init;
                            Validate("Row No.", currRow);
                            Validate("Column No.", currCol);
                            //          cellValue := DELCHR(FORMAT(XlWrkSht.Range(xlColID + xlRowID).Value,0,2),'<>','  ');
                            //GL2024 Automation non compatible    cellValue := DelChr(Format(XlWrkSht.Range(xlColID + xlRowID).Value), '<>', '  ');
                            if cellValue <> '' then begin
                                firstFound := true;
                                "Cell Value as Text" := CopyStr(cellValue, 1, 250);

                                //GL2024 Automation non compatible  cellValue := DelChr(Format(XlWrkSht.Range(xlColID + xlRowID).Value2, 0, 2), '<>', '  ');
                                Formula := CopyStr(cellValue, 1, 250);

                                //GL2024 Automation non compatible boolVal := XlWrkSht.Range(xlColID + xlRowID).Font.Bold;   // Bold=yes -> Validate
                                Bold := boolVal;

                                //GL2024 Automation non compatible  boolVal := XlWrkSht.Range(xlColID + xlRowID).Font.Italic; // italic=yes -> skip reading (but import)
                                Italic := boolVal;                                        //

                                if currRow <> lastRow then begin
                                    rowCount += 1;
                                    lastRow := currRow;
                                end;
                                Insert;
                            end;
                        end;
                        currCol += 1;
                    until currCol > MaxCol;
                end;
                currRow += 1;
                Window.Update(1, ROUND(currRow / MaxRow * 10000, 1));
            until (currRow > MaxRow) or (untilFirst and firstFound);
        end;

        Window.Close;
        exit(currRow - 1);
    end;

    local procedure checkUserColumnFilter(ColumnFilter: Text[1024]; var PKFieldList: Record "Excel Buffer"): Boolean
    var
        t: Text[100];
        "Field": Record "Field";
        Column: Record "Integer";
    begin

        PKFieldList.Reset;
        PKFieldList.SetRange("Row No.", PrimaryKeyInfoBeginRow, PrimaryKeyInfoEndRow);
        PKFieldList.SetRange("Column No.", 0);
        if not PKFieldList.Find('-') then begin
            //GL2024 Automation non compatible   clearExcel;
            Error(Text013);
        end;

        if ColumnFilter = '' then
            exit(true);

        Column.FilterGroup(8);
        Column.SetFilter(Number, ColumnFilter);
        Column.FilterGroup(0);

        if PKFieldList.Find('-') then
            repeat
                Column.SetRange(Number, PKFieldList."Column No.");
                if not Column.Find('-') then begin
                    //GL2024 Automation non compatible    clearExcel;
                    Error(Text006, PKFieldList.Formula, PKFieldList."Column No.");
                end;
            until PKFieldList.Next = 0;

        PKFieldList.Reset;
        exit(true);
    end;

    local procedure ChooseColumnsToImport(tableNo: Integer; ColFilter: Text[1024]; var ImporterOptions: Integer) columnFilter: Text[1024]
    var
        //GL2024 Automation non compatible  FieldMapDialog: Page 99991;
        i: Integer;
    begin
        /*GL2024  if not testBit(31, ImporterOptions) then begin   // d31=1 -> silent mode
              Clear(FieldMapDialog);
              Commit;

              FieldMapDialog.setParameters(tableNo, ImporterOptions, ColFilter);
              FieldMapDialog.LookupMode(true);

              if FieldMapDialog.RunModal <> Action::LookupOK then begin
                 //GL2024 Automation non compatible clearExcel;
                  Clear(FieldMapDialog);
                  Error(Text008);
              end;

              ImporterOptions := FieldMapDialog.getOptions;
          end;*/

        columnFilter := buildFilterString();
    end;

    local procedure buildFilterString(): Text[1024]
    var
        fieldMapping: Record "Excel Buffer" temporary;
        FirstItem: Integer;
        LastItem: Integer;
        PrevItem: Integer;
        CurrItem: Integer;
        LatestItem: Integer;
        SelectionFilter: Text[1024];
    begin
        with EXCELBuffer do begin
            Reset;
            SetRange("Row No.", FieldMappingMinRange, FieldMappingMaxRange);
            SetRange(Italic, true);   // now Italic=TRUE -> field importable
                                      // SETRANGE("Column No.",1,256);
            if Find('-') then
                repeat
                    fieldMapping := EXCELBuffer;
                    fieldMapping."Row No." := 0;
                    if not fieldMapping.Insert then;
                until Next = 0;
            Reset;
        end;

        if fieldMapping.Find('-') then begin
            FirstItem := fieldMapping."Column No.";
            PrevItem := FirstItem;
            repeat
                CurrItem := fieldMapping."Column No.";
                if CurrItem - PrevItem > 1 then begin
                    if PrevItem = FirstItem then
                        SelectionFilter := SelectionFilter + '|' + Format(FirstItem)
                    else
                        SelectionFilter := SelectionFilter + '|' + Format(FirstItem) + '..' + Format(PrevItem);
                    FirstItem := CurrItem;
                end;
                PrevItem := CurrItem;
            until fieldMapping.Next = 0;

            if PrevItem = FirstItem then
                SelectionFilter := SelectionFilter + '|' + Format(FirstItem)
            else
                SelectionFilter := SelectionFilter + '|' + Format(FirstItem) + '..' + Format(CurrItem);
        end;

        if SelectionFilter <> '' then
            SelectionFilter := CopyStr(SelectionFilter, 2);

        fieldMapping.Reset;
        fieldMapping.DeleteAll;
        Clear(fieldMapping);

        exit(SelectionFilter);
    end;

    local procedure findRecord(var recRef: RecordRef; var fieldMapping: Record "Excel Buffer"; searchOption: Option FieldCaption,FieldName,FieldNo): Boolean
    var
        fieldRef: FieldRef;
        cellFound: Boolean;
        cellValue: Text[262];
        cellValue2: Text[262];
        fieldNo: Integer;
        option: Integer;
        i_value: Integer;
        dec_value: Decimal;
        dat_value: Date;
        tim_value: Time;
        b_value: Boolean;
        bi_value: BigInteger;
        //GL2024 bin_value: Binary[200];
        dattim_value: DateTime;
        datform_value: DateFormula;
    begin

        fieldMapping.RESET;
        fieldMapping.MODIFYALL(Italic, FALSE);
        fieldMapping.SETFILTER(Formula2, '<>%1', ''); // only PrimaryKey
        fieldMapping.SETFILTER(Comment, '<>%1', '');  // only mapped

        fieldMapping.FIND('-');
        REPEAT
            EVALUATE(fieldNo, fieldMapping.Comment);
            fieldRef := recRef.FIELD(fieldNo);
            IF fieldMapping."Column No." = 0 THEN BEGIN
                EXCELBuffer."Cell Value as Text" := fieldMapping.Formula3;
                EXCELBuffer.Formula := fieldMapping.Formula3;
                cellFound := TRUE;
            END ELSE
                cellFound := EXCELBuffer.GET(EXCELBuffer."Row No.", fieldMapping."Column No.");
            IF cellFound THEN BEGIN
                cellValue := EXCELBuffer."Cell Value as Text";
                cellValue2 := EXCELBuffer.Formula
            END;
            CASE fieldMapping.Formula4 OF // field.type
                'Text', 'Code':
                    IF cellFound THEN BEGIN
                        fieldRef.VALUE := COPYSTR(cellValue2, 1, fieldRef.LENGTH);
                    END ELSE
                        fieldRef.VALUE := '';
                'Boolean':
                    IF cellFound THEN
                        fieldRef.VALUE := calcBool(cellValue)
                    ELSE
                        fieldRef.VALUE := FALSE;
                'Date':
                    IF cellFound THEN BEGIN
                        EVALUATE(dat_value, cellValue);
                        fieldRef.VALUE := dat_value;
                    END;
                'Time':
                    IF cellFound THEN BEGIN
                        tim_value := calcTime(cellValue);
                        fieldRef.VALUE := tim_value;
                    END;
                'DateFormula':
                    IF cellFound THEN BEGIN
                        EVALUATE(datform_value, cellValue);
                        fieldRef.VALUE := datform_value;
                    END;
                'DateTime':
                    IF cellFound THEN BEGIN
                        fieldRef.VALUE := calcDateTime(cellValue, cellValue2);
                    END;
                'BigInteger':
                    IF cellFound THEN BEGIN
                        EVALUATE(bi_value, cellValue);
                        fieldRef.VALUE := bi_value;
                    END;
                'Integer':
                    IF cellFound THEN BEGIN
                        EVALUATE(i_value, cellValue);
                        fieldRef.VALUE := i_value;
                    END;
                'Decimal':
                    IF cellFound THEN BEGIN
                        EVALUATE(dec_value, cellValue);
                        fieldRef.VALUE := dec_value;
                    END;
                'Option':
                    IF cellFound THEN BEGIN
                        option := evaluateOption(fieldRef, cellValue, searchOption);
                        fieldRef.VALUE := option;
                    END
            END;
        UNTIL fieldMapping.NEXT = 0;

        cellFound := recRef.FIND('=');

        EXIT(cellFound);
    end;

    local procedure fillRecord(var recRef: RecordRef; var fieldMapping: Record "Excel Buffer"; searchOption: Option FieldCaption,FieldName,FieldNo; InsertPKOnly: Boolean): Boolean
    var
        fieldRef: FieldRef;
        fieldNo: Integer;
        cellFound: Boolean;
        cellValue: Text[250];
        cellValue2: Text[250];
        t: Text[250];
        i_value: Integer;
        dec_value: Decimal;
        dat_value: Date;
        tim_value: Time;
        b_value: Boolean;
        bi_value: BigInteger;
        //GL2024 bin_value: Binary[200];
        dattim_value: DateTime;
        datform_value: DateFormula;
        i: Integer;
    begin

        fieldMapping.RESET;
        fieldMapping.SETFILTER(Comment, '<>%1', '');  // only mapped
        IF InsertPKOnly THEN
            fieldMapping.SETFILTER(Formula2, '<>%1', ''); // only PrimaryKey
        fieldMapping.SETRANGE(Italic, FALSE);

        IF fieldMapping.FIND('-') THEN
            REPEAT
                IF fieldMapping."Column No." = 0 THEN BEGIN
                    EXCELBuffer."Cell Value as Text" := fieldMapping.Formula3;
                    EXCELBuffer.Formula := fieldMapping.Formula3;
                    IF fieldMapping.Underline THEN BEGIN
                        cellValue := INCSTR(fieldMapping.Formula3);
                        IF cellValue <> '' THEN
                            fieldMapping.Formula3 := cellValue;
                    END;
                    cellFound := TRUE;
                END ELSE
                    cellFound := EXCELBuffer.GET(EXCELBuffer."Row No.", fieldMapping."Column No.");

                IF cellFound THEN BEGIN
                    EVALUATE(fieldNo, fieldMapping.Comment);
                    fieldRef := recRef.FIELD(fieldNo);
                    fieldMapping.Italic := TRUE;
                    fieldMapping.MODIFY;
                    cellValue := EXCELBuffer."Cell Value as Text";
                    cellValue2 := EXCELBuffer.Formula;

                    CASE FORMAT(fieldRef.TYPE) OF
                        'Text', 'Code':
                            BEGIN
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(COPYSTR(DELCHR(cellValue2, '<>', ' '), 1, fieldRef.LENGTH))
                                ELSE
                                    fieldRef.VALUE := COPYSTR(DELCHR(cellValue2, '<>', ' '), 1, fieldRef.LENGTH);
                            END;
                        'Option':
                            BEGIN
                                i_value := evaluateOption(fieldRef, cellValue, searchOption);
                                IF i_value >= 0 THEN BEGIN
                                    IF fieldMapping.Bold THEN
                                        fieldRef.VALIDATE(i_value)
                                    ELSE
                                        fieldRef.VALUE := i_value;
                                END;
                            END;
                        'Integer':
                            BEGIN
                                EVALUATE(i_value, cellValue);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(i_value)
                                ELSE
                                    fieldRef.VALUE := i_value;
                            END;
                        'BigInteger':
                            BEGIN
                                bi_value := calcBigInt(cellValue);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(bi_value)
                                ELSE
                                    fieldRef.VALUE := bi_value;
                            END;
                        'Decimal':
                            BEGIN
                                dec_value := calcDecimal(cellValue);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(dec_value)
                                ELSE
                                    fieldRef.VALUE := dec_value;
                            END;
                        'Date':
                            BEGIN
                                EVALUATE(dat_value, cellValue);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(dat_value)
                                ELSE
                                    fieldRef.VALUE := dat_value;
                            END;
                        'Time':
                            BEGIN
                                tim_value := calcTime(cellValue);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(tim_value)
                                ELSE
                                    fieldRef.VALUE := tim_value;
                            END;
                        'DateTime':
                            BEGIN
                                dattim_value := calcDateTime(cellValue, cellValue2);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(dattim_value)
                                ELSE
                                    fieldRef.VALUE := dattim_value;
                            END;
                        'DateFormula':
                            BEGIN
                                EVALUATE(datform_value, cellValue);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(datform_value)
                                ELSE
                                    fieldRef.VALUE := datform_value;
                            END;
                        'Boolean':
                            BEGIN
                                b_value := calcBool(cellValue);
                                IF fieldMapping.Bold THEN
                                    fieldRef.VALIDATE(b_value)
                                ELSE
                                    fieldRef.VALUE := b_value;
                            END;
                        ELSE BEGIN
                            warn := TRUE;
                            fieldMapping.NumberFormat := 'warn';
                            fieldMapping.MODIFY;
                        END;
                    END;
                END;
            UNTIL fieldMapping.NEXT = 0;
        EXIT(FALSE);
    end;

    local procedure calcBigInt(txt: Code[50]) bi: BigInteger
    var
        i: Integer;
        tBase: Text[50];
        tExp: Text[30];
        d: Decimal;
    begin
        i := STRPOS(txt, 'E');
        IF i > 0 THEN BEGIN
            tBase := COPYSTR(txt, 1, i - 1);
            tExp := COPYSTR(txt, i + 1);
            i := 1;
            CASE tExp[1] OF
                '+':
                    tExp := COPYSTR(tExp, 2);
                '-':
                    BEGIN
                        //GL2024 Automation non compatible    clearExcel;
                        ERROR(Text014, txt);
                    END;
            END;
            EVALUATE(d, tExp);
            bi := POWER(10, i * d);
            EVALUATE(d, tBase);
            bi := d * bi;
            EXIT(bi);
        END;
        EVALUATE(bi, txt);
    end;

    local procedure calcDecimal(txt: Code[50]) dec: Decimal
    var
        i: Integer;
        tBase: Text[50];
        tExp: Text[30];
        d: Decimal;
    begin
        i := STRPOS(txt, 'E');
        IF i > 0 THEN BEGIN
            tBase := COPYSTR(txt, 1, i - 1);
            tExp := COPYSTR(txt, i + 1);
            i := 1;
            CASE tExp[1] OF
                '+':
                    tExp := COPYSTR(tExp, 2);
                '-':
                    BEGIN
                        tExp := COPYSTR(tExp, 2);
                        i := -1;
                    END;
            END;
            EVALUATE(d, tExp);
            dec := POWER(10, i * d);
            EVALUATE(d, tBase);
            dec := d * dec;
            EXIT(dec);
        END;
        EVALUATE(dec, txt);
    end;

    local procedure calcBool(BoolText: Text[250]): Boolean
    var
        b: Boolean;
    begin
        CASE LOWERCASE(BoolText) OF
            LOWERCASE(STRSUBSTNO('%1', TRUE)), 'true', 'y', 't', 'yes', '1':
                EXIT(TRUE);
            LOWERCASE(STRSUBSTNO('%1', FALSE)), 'false', 'f', 'n', 'no', '0':
                EXIT(FALSE);
        END;
        EVALUATE(b, BoolText);
        EXIT(b);
    end;

    local procedure calcDateTime(DatTimText: Text[100]; DatTimText2: Text[100]): DateTime
    var
        ts: Text[2];
        dt: DateTime;
        tim: Time;
        dat: Date;
        dec: Decimal;
        day: Integer;
        i: Integer;
        bi: BigInteger;
    begin
        ts := '  ';
        ts[1] := FORMAT(1000.0) [2];


        EVALUATE(dat, DatTimText);

        DatTimText2 := DELCHR(DatTimText2, '<=>', ts);
        EVALUATE(dec, DatTimText2);
        i := ROUND(dec, 1, '<');
        tim := 000000T;
        tim := tim + ROUND((dec - i) * (1000 * 60 * 60 * 24), 1);

        dt := CREATEDATETIME(dat, tim);

        EXIT(dt);
    end;

    local procedure calcTime(TimeText: Text[100]): Time
    var
        ts: Text[2];
        tim: Time;
        i: Integer;
        dec: Decimal;
    begin
        ts := '  ';
        ts[1] := FORMAT(1000.0) [2];

        TimeText := DELCHR(TimeText, '<=>', ts);
        EVALUATE(dec, TimeText);
        i := ROUND(dec, 1, '<');
        tim := 000000T;
        tim := tim + ROUND((dec - i) * (1000 * 60 * 60 * 24), 1);
        EXIT(tim);
    end;

    local procedure readFieldMapping(var fieldMapping: Record "Excel Buffer"; var importerOptions: Integer; SourceRowsFilter: Text[50])
    var
        keyFieldNo: Integer;
        Inserted: Boolean;
    begin
        CLEAR(fieldMapping);
        fieldMapping.RESET;
        fieldMapping.DELETEALL;

        EXCELBuffer.RESET;
        EXCELBuffer.SETFILTER("Row No.", SourceRowsFilter);
        EXCELBuffer.SETRANGE(Italic, TRUE);

        IF EXCELBuffer.FIND('-') THEN
            REPEAT
                fieldMapping.INIT;
                fieldMapping := EXCELBuffer;
                IF EXCELBuffer.Formula2 <> '' THEN BEGIN
                    EVALUATE(keyFieldNo, LeaveCharacters(EXCELBuffer.Formula2, '0123456789'));
                    fieldMapping."Row No." := keyFieldNo + PrimaryKeyInfoBeginRow;
                END;
                fieldMapping.INSERT;
            UNTIL EXCELBuffer.NEXT = 0
        ELSE BEGIN
            //GL2024 Automation non compatible clearExcel;
            ERROR(Text010);
        END;
    end;

    local procedure generateWarning(var fieldMapping: Record "Excel Buffer")
    var
        FieldName: Text[512];
        FieldType: Text[512];
    begin
        IF warn THEN BEGIN
            fieldMapping.RESET;
            fieldMapping.SETFILTER(NumberFormat, '>%1', '');
            IF fieldMapping.FIND('-') THEN
                REPEAT
                    FieldName := FieldName + fieldMapping.Formula4 + ',';
                    FieldType := FieldType + fieldMapping."Cell Value as Text" + ',';
                UNTIL fieldMapping.NEXT = 0;
            MESSAGE(Text011, FieldName, FieldType);
        END;
    end;


    procedure checkPrimaryKeyFieldNo(tableNo: Integer; fieldNo: Integer): Integer
    var
        recRef: RecordRef;
        keyRef: KeyRef;
        fieldRef: FieldRef;
        keyCount: Integer;
    begin
        recRef.OPEN(tableNo);
        keyRef := recRef.KEYINDEX(1);
        keyCount := keyRef.FIELDCOUNT;
        WHILE keyCount > 0 DO BEGIN
            fieldRef := keyRef.FIELDINDEX(keyCount);
            IF fieldRef.NUMBER = fieldNo THEN
                EXIT(keyCount);
            keyCount -= 1;
        END;
        EXIT(0);
    end;

    local procedure generatePrimaryKeyInfo(tableNo: Integer; var primaryKeyFields: Record "Excel Buffer"): Integer
    var
        recRef: RecordRef;
        keyRef: KeyRef;
        fieldRef: FieldRef;
        PKFieldCount: Integer;
        i: Integer;
    begin
        recRef.OPEN(tableNo);

        keyRef := recRef.KEYINDEX(1);

        PKFieldCount := keyRef.FIELDCOUNT;

        FOR i := 1 TO PKFieldCount DO BEGIN
            fieldRef := keyRef.FIELDINDEX(i);
            primaryKeyFields.INIT;
            primaryKeyFields."Row No." := i + PrimaryKeyInfoBeginRow;
            primaryKeyFields."Column No." := 0;
            primaryKeyFields."Cell Value as Text" := '';// sssss fieldRef.CAPTION;
            primaryKeyFields.Comment := FORMAT(fieldRef.NUMBER, 0, 2);
            primaryKeyFields.NumberFormat := F_PKEY;
            primaryKeyFields.Formula := fieldRef.NAME;
            primaryKeyFields.Formula2 := 'KeyField' + FORMAT(i, 0, 2);
            primaryKeyFields.Formula4 := FORMAT(fieldRef.TYPE);
            primaryKeyFields.INSERT;
        END;

        recRef.CLOSE;
        EXIT(PKFieldCount);
    end;

    local procedure generateFieldMapping(tableNo: Integer; columnFilter: Text[1024]; headerRow: Integer; ImporterOptions: Integer): Integer
    var
        xlBuffer2: Record "Excel Buffer";
        "field": Record Field;
        ColumnHeader: Text[250];
        fieldNo: Integer;
        ColumnOrderNo: Integer;
        fieldsFound: Integer;
        i: Integer;
        newRowNo: Integer;
        searchOption: Option FieldCaption,FieldName,FieldNo;
        validateOption: Option All,"None",FileDefined;
        row: Integer;
        col: Integer;
        importall: Boolean;
    begin
        searchOption := ROUND(ImporterOptions / 16, 1, '<') MOD 4;  // same as ((ImporterOptions<<4) && 0x03)
        validateOption := ROUND(ImporterOptions / 64, 1, '<') MOD 4;// same as ((ImporterOptions<<6) && 0x03)
        importall := testBit(3, ImporterOptions);

        EXCELBuffer.RESET;
        IF columnFilter <> '' THEN
            EXCELBuffer.SETFILTER("Column No.", columnFilter);

        EXCELBuffer.SETFILTER("Row No.", '%1..%2|%3', ConstantsAreaBeginRow, ConstantsAreaEndRow, headerRow);
        IF EXCELBuffer.FIND('-') THEN BEGIN
            REPEAT
                ColumnHeader := EXCELBuffer."Cell Value as Text";
                CASE searchOption OF
                    searchOption::FieldCaption:
                        fieldNo := findFieldNoByCaption(tableNo, ColumnHeader);
                    searchOption::FieldName:
                        fieldNo := findFieldNoByName(tableNo, ColumnHeader);
                    searchOption::FieldNo:
                        EVALUATE(fieldNo, ColumnHeader);
                    ELSE BEGIN
                        //GL2024 Automation non compatible    clearExcel;
                        ERROR(Text003, searchOption);
                    END;
                END;
                CASE validateOption OF
                    validateOption::All:
                        EXCELBuffer.Bold := TRUE;
                    validateOption::None:
                        EXCELBuffer.Bold := FALSE;
                    validateOption::FileDefined:
                        ; // BOLDed header inside Excel decides
                END;
                IF fieldNo > 0 THEN BEGIN
                    fieldsFound += 1;
                    field.GET(tableNo, fieldNo);
                    IF field.Class = field.Class::Normal THEN BEGIN // field importable
                        IF EXCELBuffer.NumberFormat = '' THEN
                            EXCELBuffer.NumberFormat := F_EXCLELSRC;
                    END ELSE
                        EXCELBuffer.NumberFormat := ''; // not importable
                    IF importall THEN
                        EXCELBuffer.Italic := TRUE
                    ELSE
                        EXCELBuffer.Italic := NOT EXCELBuffer.Italic;   // italic=1 -> skip import ;
                    EXCELBuffer.Comment := FORMAT(fieldNo, 0, 2);    // maps to Field No
                    EXCELBuffer.Formula := field.FieldName;        // maps to Field Name
                    EXCELBuffer.Formula4 := FORMAT(field.Type);
                END ELSE BEGIN            // no destination found
                    EXCELBuffer.Comment := '';
                    EXCELBuffer.Formula := '';
                    EXCELBuffer.NumberFormat := '';
                    EXCELBuffer.Bold := FALSE;
                    EXCELBuffer.Italic := FALSE;
                END;
                EXCELBuffer.MODIFY;
            UNTIL EXCELBuffer.NEXT = 0;
        END;

        EXCELBuffer.SETFILTER("Row No.", '%1', headerRow);
        IF EXCELBuffer.FIND('-') THEN BEGIN
            ColumnOrderNo := FieldMapBeginRow;
            newRowNo := ColumnOrderNo;
            REPEAT
                IF EXCELBuffer.Comment <> '' THEN BEGIN
                    EVALUATE(fieldNo, EXCELBuffer.Comment);
                    i := checkPrimaryKeyFieldNo(tableNo, fieldNo);
                    IF i > 0 THEN BEGIN
                        newRowNo := PrimaryKeyInfoBeginRow + i; // moves key columns to the PK area
                        IF xlBuffer2.GET(newRowNo, 0) THEN
                            xlBuffer2.DELETE;
                        EXCELBuffer.Formula2 := 'KeyField' + FORMAT(i, 0, 2);  // field in primary key
                        EXCELBuffer.NumberFormat := F_PKEY;
                        EXCELBuffer.Italic := TRUE;
                    END;
                END;
                EXCELBuffer.RENAME(newRowNo, EXCELBuffer."Column No.");
                ColumnOrderNo += 5;
                newRowNo := ColumnOrderNo;
            UNTIL EXCELBuffer.NEXT = 0;
        END;

        EXCELBuffer.RESET;
        EXIT(fieldsFound);
    end;


    procedure renumberMappingData(var xlBuffer: Record "Excel Buffer")
    var
        tempXlBuffer: Record "Excel Buffer" temporary;
        span: Integer;
        i: Integer;
    begin
        xlBuffer.RESET;
        xlBuffer.SETRANGE("Row No.", FieldMappingMinRange, FieldMappingMaxRange);
        xlBuffer.SETRANGE(Italic, TRUE);
        xlBuffer.SETRANGE("Column No.", 0, 256);

        span := xlBuffer.COUNT();
        span := ROUND(ABS(FieldMappingMaxRange - FieldMappingMinRange) / span, 1, '<');

        i := FieldMappingMinRange;
        IF xlBuffer.FIND('-') THEN
            REPEAT
                tempXlBuffer := xlBuffer;
                tempXlBuffer."Row No." := i;
                i += span;
                IF NOT tempXlBuffer.INSERT THEN;
            UNTIL xlBuffer.NEXT = 0;

        xlBuffer.DELETEALL;

        IF tempXlBuffer.FIND('-') THEN
            REPEAT
                xlBuffer := tempXlBuffer;
                IF NOT xlBuffer.INSERT THEN;
            UNTIL tempXlBuffer.NEXT = 0;
    end;

    local procedure readHeader(fileName: Text[512]; sheetName: Text[50]; headerRow: Integer; var tableNo: Integer; var ImporterOptions: Integer): Integer
    var
        xlBuffer2: Record "Excel Buffer";
        HeaderRowFilter: Code[40];
        newTableno: Integer;
        newHeaderRow: Integer;
        dataRangeFilter: Text[30];
    begin
        EXCELBuffer.RESET;

        IF headerRow <= 0 THEN
            HeaderRowFilter := '-'
        ELSE
            HeaderRowFilter := '-' + FORMAT(headerRow, 0, 2) + '..';

        headerRow := ReadSelectedSheetArea(fileName, sheetName, HeaderRowFilter, '');
        EXCELBuffer.RESET;
        EXCELBuffer.SETRANGE("Row No.", headerRow);

        IF tableNo > 0 THEN BEGIN
            IF EXCELBuffer.FIND('-') THEN
                REPEAT
                    xlBuffer2 := EXCELBuffer;
                    xlBuffer2."Row No." := 0;
                    xlBuffer2.INSERT;
                UNTIL EXCELBuffer.NEXT = 0;
            EXIT(headerRow);
        END;

        EXCELBuffer.SETRANGE("Row No.", headerRow);

        IF EXCELBuffer.FIND('-') THEN BEGIN
            IF readParameters(newTableno, newHeaderRow, EXCELBuffer, ImporterOptions) THEN BEGIN
                IF (tableNo <= 0) AND (newTableno > 0) THEN
                    tableNo := newTableno;
                IF newHeaderRow > 0 THEN
                    headerRow := newHeaderRow - 1;
                HeaderRowFilter := '-' + FORMAT(headerRow + 1, 0, 2) + '..';
                headerRow := ReadSelectedSheetArea(fileName, sheetName, HeaderRowFilter, '');
            END;
        END;

        EXCELBuffer.RESET;
        EXCELBuffer.SETRANGE("Row No.", headerRow);
        IF EXCELBuffer.FIND('-') THEN
            REPEAT
                xlBuffer2 := EXCELBuffer;
                xlBuffer2."Row No." := 0;
                xlBuffer2.INSERT;
            UNTIL EXCELBuffer.NEXT = 0;

        EXIT(headerRow);
    end;

    local procedure readParameters(var tableNo: Integer; var headerRow: Integer; var xlBuffer: Record "Excel Buffer"; var ImporterOptions: Integer) paramOK: Boolean
    var
        paramStr: Text[250];
        paramVal: Text[250];
    begin
        xlBuffer.SETRANGE("Row No.", xlBuffer."Row No.");
        IF xlBuffer.FIND('-') THEN
            REPEAT
                paramStr := xlBuffer."Cell Value as Text";
                IF retrieveParamVal(paramStr, PARAMDEF_TABLE + ':', paramVal) THEN BEGIN
                    paramOK := paramOK OR EVALUATE(tableNo, paramVal);
                END;
                IF retrieveParamVal(paramStr, PARAMDEF_HEADER + ':', paramVal) THEN BEGIN
                    paramOK := paramOK OR EVALUATE(headerRow, paramVal);
                END;
                IF retrieveParamVal(paramStr, PARAMDEF_IMPORTALL, paramVal) THEN BEGIN
                    paramOK := TRUE;
                    setBit(3, ImporterOptions); // d3 = importall
                END;
                IF retrieveParamVal(paramStr, PARAMDEF_SKIPTRIGGERS, paramVal) THEN BEGIN
                    paramOK := TRUE;
                    setBit(8, ImporterOptions); // d8 = Skip OnIsert(TRUE)/OnModify(TRUE)
                END;

                WHILE retrieveParamVal(paramStr, PARAMDEF_CONSTANT + ':', paramVal) DO BEGIN
                    paramOK := paramOK OR addPredefinedValue(paramVal, 0, tableNo);
                END;
                WHILE retrieveParamVal(paramStr, PARAMDEF_COUNTER + ':', paramVal) DO BEGIN
                    paramOK := paramOK OR addPredefinedValue(paramVal, 1, tableNo);
                END;
                WHILE retrieveParamVal(paramStr, PARAMDEF_COPY + ':', paramVal) DO BEGIN
                    paramOK := paramOK OR addPredefinedValue(paramVal, 2, tableNo);
                END;
            UNTIL xlBuffer.NEXT = 0;
    end;

    local procedure retrieveParamVal(var paramStr: Text[512]; paramDef: Text[30]; var ParamVal: Text[250]): Boolean
    var
        i: Integer;
        l: Integer;
        paramBuf: Text[250];
    begin
        IF paramStr = '' THEN
            EXIT(FALSE);

        i := STRPOS(LOWERCASE(paramStr), LOWERCASE(paramDef));
        IF i = 0 THEN
            EXIT(FALSE);
        l := STRLEN(paramDef);
        paramBuf := COPYSTR(paramStr, i);
        paramStr := COPYSTR(paramStr, 1, i - 1);
        i := STRPOS(paramBuf, ';');
        IF i = 0 THEN
            i := STRLEN(paramBuf) + 1;
        ParamVal := COPYSTR(paramBuf, l + 1, i - l - 1);
        paramStr := paramStr + COPYSTR(paramBuf, i + 1);
        EXIT(TRUE);
    end;


    procedure addPredefinedValue(ParamStr: Text[250]; MappingOption: Option "Const",Incr,Copy; tableNo: Integer): Boolean
    var
        xlBuffer2: Record "Excel Buffer";
        i: Integer;
        paramVal: Text[512];
        paramDef: Text[30];
    begin
        i := STRPOS(ParamStr, '=');
        IF i = 0 THEN
            EXIT(FALSE);

        paramDef := COPYSTR(ParamStr, 1, i - 1);
        paramVal := COPYSTR(ParamStr, i + 1);

        IF (tableNo > 0) AND (removeDigits(paramDef) = '') THEN BEGIN // paramDef is a field number
            EVALUATE(i, paramDef);
            paramDef := getFieldNameByNo(tableNo, i);
        END;
        xlBuffer2 := EXCELBuffer;
        xlBuffer2.COPYFILTERS(EXCELBuffer);
        EXCELBuffer.RESET;
        EXCELBuffer.SETRANGE("Row No.", ConstantsAreaBeginRow, ConstantsAreaEndRow);
        IF EXCELBuffer.FIND('+') THEN
            i := EXCELBuffer."Row No." + 4
        ELSE
            i := ConstantsAreaBeginRow + 4;

        EXCELBuffer.INIT;
        EXCELBuffer."Row No." := i;
        EXCELBuffer."Column No." := 0;
        EXCELBuffer."Cell Value as Text" := paramDef; // field name in header
        EXCELBuffer.Formula3 := paramVal;             // field value

        CASE MappingOption OF
            MappingOption::Const:
                EXCELBuffer.NumberFormat := PARAMDEF_CONSTANT;
            MappingOption::Incr:
                EXCELBuffer.NumberFormat := PARAMDEF_COUNTER;
            MappingOption::Copy:
                EXCELBuffer.NumberFormat := PARAMDEF_COPY;
        END;

        EXCELBuffer.Bold := xlBuffer2.Bold;
        EXCELBuffer.Underline := MappingOption = MappingOption::Incr;
        EXCELBuffer.Italic := MappingOption = MappingOption::Copy;

        IF MappingOption = MappingOption::Copy THEN
            EXCELBuffer."Column No." := -1;

        EXCELBuffer.INSERT;
        EXCELBuffer := xlBuffer2;
        EXCELBuffer.COPYFILTERS(xlBuffer2);
    end;


    procedure getFieldNameByNo(TableNo: Integer; FieldNo: Integer) fName: Text[50]
    var
        recRef: RecordRef;
        fieldRef: FieldRef;
    begin
        recRef.OPEN(TableNo);
        fieldRef := recRef.FIELD(FieldNo);
        EXIT(fieldRef.NAME);
    end;

    local procedure postProcessParams(headerRow: Integer)
    var
        xlBuffer2: Record "Excel Buffer";
        xlBuffer3: Record "Excel Buffer";
        row: Integer;
        col: Integer;
        SearchAreaFilter: Text[80];
    begin
        xlBuffer2 := EXCELBuffer;
        xlBuffer2.COPYFILTERS(EXCELBuffer);

        SearchAreaFilter := STRSUBSTNO('%1..%2', FORMAT(ConstantsAreaBeginRow, 0, 2), FORMAT(ConstantsAreaEndRow, 0, 2));

        EXCELBuffer.RESET;
        EXCELBuffer.SETFILTER("Row No.", '%1..%2|%3..%4',
          FieldMapBeginRow, FieldMapEndRow, PrimaryKeyInfoBeginRow, PrimaryKeyInfoEndRow);
        EXCELBuffer.SETRANGE("Column No.", 1, 255);

        IF EXCELBuffer.FIND('-') THEN
            REPEAT
                WHILE findSourceColumnNo(EXCELBuffer, SearchAreaFilter, EXCELBuffer."Cell Value as Text", TRUE, row, col) DO BEGIN
                    xlBuffer3.GET(row, col);
                    xlBuffer3.DELETE;
                END;
            UNTIL EXCELBuffer.NEXT = 0;

        EXCELBuffer.RESET;
        EXCELBuffer.SETFILTER("Row No.", '%1..%2',
          PrimaryKeyInfoBeginRow, PrimaryKeyInfoEndRow);
        EXCELBuffer.SETRANGE("Column No.", 0);

        IF EXCELBuffer.FIND('-') THEN
            REPEAT
                WHILE findSourceColumnNo(EXCELBuffer, SearchAreaFilter, EXCELBuffer."Cell Value as Text", TRUE, row, col) DO BEGIN
                    xlBuffer3 := EXCELBuffer;
                    EXCELBuffer.GET(row, col);
                    xlBuffer3.Formula3 := EXCELBuffer.Formula3;
                    xlBuffer3.Bold := EXCELBuffer.Bold;
                    xlBuffer3.Underline := EXCELBuffer.Underline;
                    xlBuffer3.Italic := TRUE;
                    xlBuffer3.NumberFormat := EXCELBuffer.NumberFormat;
                    EXCELBuffer.DELETE;
                    EXCELBuffer := xlBuffer3;
                    EXCELBuffer.MODIFY;
                    EXCELBuffer.RENAME(EXCELBuffer."Row No.", col);
                END;
            UNTIL EXCELBuffer.NEXT = 0;

        SearchAreaFilter := STRSUBSTNO('%1..%2',
          FORMAT(FieldMappingMinRange, 0, 2), FORMAT(FieldMappingMaxRange, 0, 2));

        EXCELBuffer.RESET;
        EXCELBuffer.SETRANGE("Column No.", -1); // copy defs
        IF EXCELBuffer.FIND('-') THEN
            REPEAT
                IF findSourceColumnNo(EXCELBuffer, SearchAreaFilter, EXCELBuffer.Formula3, TRUE, row, col) THEN BEGIN
                    IF (EXCELBuffer."Row No." <> row) AND (EXCELBuffer."Column No." <> col) THEN BEGIN
                        xlBuffer3 := EXCELBuffer; // target
                        EXCELBuffer.GET(row, col); // source column
                        EXCELBuffer.Italic := TRUE;
                        EXCELBuffer.MODIFY;
                        xlBuffer3."Cell Value as Text" := EXCELBuffer."Cell Value as Text";
                        xlBuffer3.NumberFormat := xlBuffer3.NumberFormat + ':' + EXCELBuffer.NumberFormat;
                        xlBuffer3.Formula3 := EXCELBuffer.Formula3;
                        xlBuffer3.Italic := TRUE;
                        col := EXCELBuffer."Column No.";
                        EXCELBuffer := xlBuffer3;
                        EXCELBuffer.MODIFY;
                        EXCELBuffer.RENAME(EXCELBuffer."Row No.", col);
                    END;
                END ELSE BEGIN
                    EXCELBuffer.Italic := FALSE;
                    EXCELBuffer.MODIFY;
                END;
            UNTIL EXCELBuffer.NEXT = 0;

        EXCELBuffer := xlBuffer2;
        EXCELBuffer.COPYFILTERS(xlBuffer2);
    end;


    procedure findSourceColumnNo(var xlBuffer: Record "Excel Buffer"; SearchAreaRowFilter: Text[250]; SourceColName: Text[250]; fullMatch: Boolean; var Row: Integer; var Col: Integer): Boolean
    var
        xlBuffer2: Record "Excel Buffer";
        i: Integer;
    begin
        SourceColName := LOWERCASE(SourceColName);

        xlBuffer2 := xlBuffer;
        xlBuffer2.COPYFILTERS(xlBuffer);
        xlBuffer.RESET;
        xlBuffer.SETFILTER("Row No.", SearchAreaRowFilter);

        IF xlBuffer.FIND('-') THEN
            REPEAT
                IF (fullMatch AND (LOWERCASE(xlBuffer."Cell Value as Text") = SourceColName))
                  OR (NOT fullMatch AND ((LOWERCASE(COPYSTR(xlBuffer."Cell Value as Text", 1, STRLEN(SourceColName))) = SourceColName)))
                THEN BEGIN
                    Row := xlBuffer."Row No.";
                    Col := xlBuffer."Column No.";
                    xlBuffer := xlBuffer2;
                    xlBuffer.COPYFILTERS(xlBuffer2);
                    EXIT(TRUE);
                END;
            UNTIL xlBuffer.NEXT = 0;

        xlBuffer := xlBuffer2;
        xlBuffer.COPYFILTERS(xlBuffer2);
    end;


    procedure activeMappingExists(DestFieldFilter: Text[30]; IsActive: Boolean; currRec: Record "Excel Buffer") retVal: Text[250]
    var
        tempFMap: Record "Excel Buffer";
    begin
        tempFMap.RESET;
        tempFMap.SETRANGE(Comment, DestFieldFilter);
        IF IsActive THEN
            tempFMap.SETRANGE(Italic, TRUE);

        IF tempFMap.FIND('-') THEN
            REPEAT
                IF (tempFMap."Row No." <> currRec."Row No.")
                  OR (tempFMap."Column No." <> currRec."Column No.")
                THEN BEGIN // another mapping found
                    IF tempFMap."Cell Value as Text" <> '' THEN
                        EXIT(tempFMap."Cell Value as Text");
                    EXIT(Text006);
                END;
            UNTIL tempFMap.NEXT = 0;

        EXIT('');
    end;


    procedure SourceFieldLookup(fname: Text[200]; var SkipOnModify: Boolean; var MappingLine: Record "Excel Buffer"): Boolean
    var
        SourceFields: Record "Excel Buffer" temporary;
    begin
        fname := LOWERCASE(fname);

        EXCELBuffer.RESET;
        EXCELBuffer.SETRANGE("Column No.", 1, 256);
        EXCELBuffer.SETRANGE("Row No.", 0);
        IF fname <> '' THEN
            EXCELBuffer.SETFILTER("Cell Value as Text", '@' + fname + '*')
        ELSE
            EXCELBuffer.SETFILTER("Cell Value as Text", '<>%1', '');

        IF NOT EXCELBuffer.FIND('-') THEN
            EXCELBuffer.SETFILTER("Cell Value as Text", '<>%1', '')
        ELSE
            IF EXCELBuffer.NEXT = 0 THEN BEGIN
                MappingLine."Cell Value as Text" := EXCELBuffer."Cell Value as Text";
                MappingLine.Formula3 := '';
                MappingLine.Italic := TRUE;
                MappingLine.MODIFY;
                SkipOnModify := TRUE;
                MappingLine.RENAME(MappingLine."Row No.", EXCELBuffer."Column No.");
                EXIT(TRUE);
            END;

        IF EXCELBuffer.FIND('-') THEN
            REPEAT
                IF NOT SourceFields.GET(0, EXCELBuffer."Column No.") THEN BEGIN
                    SourceFields := EXCELBuffer;
                    SourceFields."Row No." := 0;
                    SourceFields.INSERT;
                END;
            UNTIL EXCELBuffer.NEXT = 0
        ELSE
            EXIT(FALSE);

        SourceFields.FIND('-');

        /*gl2024 IF PAGE.RUNMODAL(PAGE::"UEI - Source Field List", SourceFields) = ACTION::LookupOK THEN BEGIN
             MappingLine."Cell Value as Text" := SourceFields."Cell Value as Text";
             MappingLine.Formula3 := '';
             MappingLine.Italic := TRUE;
             MappingLine.MODIFY;
             SkipOnModify := TRUE;
             MappingLine.RENAME(MappingLine."Row No.", SourceFields."Column No.");
             EXIT(TRUE);
         END*/
    end;
}

