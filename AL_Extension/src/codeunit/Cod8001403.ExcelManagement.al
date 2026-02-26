Codeunit 8001403 "Excel Management"
{
    // #8027 SD 17/05/10 Excelshett de 30 à 250 fonction OpenBook  OpenSheet CreateSheet RenameSheet  SelectSheet
    // #7783 XPE 20/01/2010 Lors du traitement de la feuille Excel, on formate la valeur de la celulle
    // #6759 CW 02/12/08
    // #6592 AC-XP 16/02/09
    // //+BGW+OFFICE GESWAY 10/10/02 Echange avec Microsoft Excel


    trigger OnRun()
    begin
    end;

    var
        ExcelBuf: Record "Excel Buffer";
        ExcelBufExt: Record "Excel Buffer Extended";
        GLSetup: Record "General Ledger Setup";
        //GL2024 Automation non compatible    xlApp: Automation;
        //GL2024 Automation non compatible    XlWorkBook: Automation;
        //GL2024 Automation non compatible  XlWorkSheet: Automation;
        //GL2024 Automation non compatible   XlWorksheets: Automation;
        //GL2024 Automation non compatible    XlRange: Automation;
        Text000: label 'Excel not found.';
        Text001: label 'You must enter a file name.';
        Text002: label 'You must enter an Excel worksheet name.';
        Text003: label 'The file %1 does not exist.';
        Text004: label 'The Excel worksheet %1 does not exist.';
        Text005: label 'Creating Excel worksheet...\\';
        Text006: label '%1%3%4%3Page %2';
        Text007: label 'Reading Excel worksheet...\\';
        Text008: label ': Filter ';
        Text009: label ' can not be converted into an Excel formula.';
        Text010: label ': Operator ';
        Text011: label ' is not valid.';
        Text012: label ': Filter containing more than 1 comparison operator can not be converted into an Excel formula.';
        Text013: label '&B';
        Text014: label '&D';
        Text015: label '&P';
        Text016: label 'A1';
        Text017: label 'SUMIF';
        Text018: label '#N/A';
        HideValidationDialog: Boolean;
        xlDiagonalDown: Integer;
        xlDiagonalUp: Integer;
        xlEdgeLeft: Integer;
        xlEdgeTop: Integer;
        xlEdgeBottom: Integer;
        xlEdgeRight: Integer;
        xlHairLine: Integer;
        xlMedium: Integer;
        xlThick: Integer;
        xlThin: Integer;
        xlContinuous: Integer;
        xlLineStyleNone: Integer;
        xlLandscape: Integer;
        xlPortrait: Integer;
        xlVAlignBottom: Integer;
        xlVAlignCenter: Integer;
        xlVAlignDistributed: Integer;
        xlVAlignTop: Integer;
        xlHAlignCenter: Integer;
        xlHAlignGeneral: Integer;
        xlHAlignDistributed: Integer;
        xlHAlignLeft: Integer;
        xlHAlignRight: Integer;
        xlColorIndexAutomatic: Integer;
        xlColorIndexNone: Integer;
        xlEvaluateToError: Integer;
        xlTextDate: Integer;
        xlNumberAsText: Integer;
        xlInconsistentFormula: Integer;
        xlOmittedCells: Integer;
        xlUnlockedFormulaCells: Integer;
        xlEmptyCellReferences: Integer;
        xlErrorCells: Integer;
        gXlErrorMessage: Text[250];
        wLastRangeID: Text[80];
        wLastErrorIndex: Integer;
        wxlVersion: Decimal;

    /* 
    //GL2024 Automation non compatible
    procedure ClearApp()
    begin
        Clear(xlApp);
    end;


    procedure ClearContent(RangeID: Text[20])
    begin
        if RangeID <> '' then
            XlWorkSheet.Range(RangeID)._ClearContents
        else
            XlWorkSheet.Cells._ClearContents;
    end;


    procedure ClearFormat(RangeID: Text[20])
    begin
        if RangeID <> '' then
            XlWorkSheet.Range(RangeID).ClearFormats
        else
            XlWorkSheet.Cells.ClearFormats;
    end;


    procedure Quit()
    begin
        if not ISCLEAR(xlApp) then
            xlApp.Quit;
    end;


    procedure CreateBook(FileName: Text[1024])
    begin
        if (not ISSERVICETIER) then begin
            if not Create(xlApp, true) then
                Error(Text000);
        end else begin
            if not Create(xlApp, false, ISSERVICETIER) then
                Error(Text000);
        end;
        fGetVersion();
        InitConst;
        xlApp.Visible(false);
        XlWorkBook := xlApp.Workbooks.Add;
        if FileName <> '' then
            XlWorkBook.__SaveAs(FileName);
        XlWorkSheet := XlWorkBook.Worksheets.Item(1);
    end;


    procedure OpenBook(FileName: Text[1024]; SheetName: Text[250])
    var
        i: Integer;
        EndOfLoop: Integer;
    begin
        if FileName = '' then
            Error(Text001);
        //IF SheetName = '' THEN
        //  ERROR(Text002);
        if not Exists(FileName) then
            Error(Text003, FileName);
        if (not ISSERVICETIER) then begin
            if not Create(xlApp, true) then
                Error(Text000);
        end else begin
            if not Create(xlApp, false, ISSERVICETIER) then
                Error(Text000);
        end;
        fGetVersion();
        xlApp.Workbooks._Open(FileName);
        XlWorkBook := xlApp.ActiveWorkbook;
        if SheetName = '' then begin
            i := 1;
            EndOfLoop := XlWorkBook.Worksheets.Count;
            XlWorksheets := XlWorkBook.Worksheets.Item(1);
            SheetName := XlWorksheets.Name;
        end;
        if SheetName <> '' then
            OpenSheet(SheetName)
    end;


    procedure SaveBook(FileName: Text[1024]; FileFormat: Integer)
    begin
        if FileName = '' then
            XlWorkBook.Save
        else
            case FileFormat of
                0:
                    XlWorkBook.__SaveAs(FileName);
                1:
                    XlWorkBook.__SaveAs(FileName, 21); // TextMSDOS
            end;
    end;


    procedure CloseBook("Action": Boolean)
    begin
        XlWorkBook.Close(Action);
    end;


    procedure OpenSheet(SheetName: Text[250])
    var
        i: Integer;
        EndOfLoop: Integer;
        Found: Boolean;
    begin
        if SheetName = '' then
            XlWorksheets := XlWorkBook.Worksheets.Item(1)
        else begin
            i := 1;
            EndOfLoop := XlWorkBook.Worksheets.Count;

            while (i <= EndOfLoop) and (not Found) do begin
                XlWorksheets := XlWorkBook.Worksheets.Item(i);
                if SheetName = XlWorksheets.Name then
                    Found := true;
                i := i + 1;
            end;

            if Found then
                XlWorkSheet := XlWorkBook.Worksheets.Item(SheetName)
            else begin
                XlWorkBook.Close(false);
                xlApp.Quit;
                Clear(xlApp);
                Error(Text004, SheetName);
            end;
        end;
    end;


    procedure CreateSheet(SheetName: Text[250]; LeftHeader: Text[250]; CenterHeader: Text[250]; RightHeader: Text[250])
    begin
        InitConst;
        XlWorkSheet := XlWorkBook.Worksheets.Add;
        XlWorkSheet.Name := SheetName;
    end;


    procedure RenameSheet(OldSheetName: Text[250]; NewSheetName: Text[250])
    var
        i: Integer;
        EndOfLoop: Integer;
        OptionNo: Integer;
        SheetName: Text[250];
    begin
        InitConst;
        XlWorkBook := xlApp.ActiveWorkbook;
        i := 1;
        EndOfLoop := XlWorkBook.Worksheets.Count;
        while i <= EndOfLoop do begin
            XlWorksheets := XlWorkBook.Worksheets.Item(i);
            SheetName := XlWorksheets.Name;
            if SheetName = OldSheetName then begin
                XlWorksheets.Name := NewSheetName;
                i := EndOfLoop;
            end;
            i := i + 1;
        end;
    end;


    procedure ReadSheet(var Window: Dialog; Number: Integer)
    var
        i: Integer;
        j: Integer;
        Maxi: Integer;
        Maxj: Integer;
        CellValue: Text[1024];
        LineNo: Integer;
    begin
        XlRange := XlWorkSheet.Range(GetRef(5)).SpecialCells(11);
        Maxi := XlRange.Row;
        Maxj := XlRange.Column;
        i := 1;

        with ExcelBuf do begin
            DeleteAll;
            ExcelBufExt.DeleteAll;
            repeat
                j := 1;
                Validate("Row No.", i);
                repeat
                    Validate("Column No.", j);
                    //#5455
                    XlRange := XlWorkSheet.Range(xlColID + xlRowID);
                    XlRange.Calculate;
                    if wGetErrorXlIndexRangeCalc(XlRange) in [-1, 3] then begin
                        //#5455//
                        //#7783
                        CellValue := Format(XlWorkSheet.Range(xlColID + xlRowID).Value2);
                        //#8027
                        //CellValue := STRSUBSTNO('%1',CellValue);
                        //#8027//
                        //CellValue := STRSUBSTNO('%1',XlWorkSheet.Range(xlColID + xlRowID).Value2);
                        //#7783//
                        //#5455
                    end else
                        CellValue := '';
                    //#5455//
                    if StrLen(CellValue) > MaxStrLen("Cell Value as Text") then begin
                        "Cell Value as Text" := CopyStr(CellValue, 1, MaxStrLen("Cell Value as Text"));
                        CellValue := CopyStr(CellValue, MaxStrLen("Cell Value as Text") + 1);
                        LineNo := 0;
                        repeat
                            LineNo += 10000;
                            ExcelBufExt.Init;
                            ExcelBufExt.xlRowID := xlRowID;
                            ExcelBufExt.xlColID := xlColID;
                            ExcelBufExt."Line No." := LineNo;
                            if StrLen(CellValue) > MaxStrLen(ExcelBufExt."Cell Value") then begin
                                ExcelBufExt."Cell Value" := CopyStr(CellValue, 1, MaxStrLen(ExcelBufExt."Cell Value"));
                                CellValue := CopyStr(CellValue, MaxStrLen(ExcelBufExt."Cell Value") + 1);
                            end else begin
                                ExcelBufExt."Cell Value" := CellValue;
                                CellValue := '';
                            end;
                            ExcelBufExt.Insert;
                        until StrLen(CellValue) = 0;
                    end else
                        "Cell Value as Text" := CellValue;

                    if "Cell Value as Text" <> '' then
                        Insert;
                    j := j + 1;
                until j > Maxj;
                i := i + 1;
                if Number > 0 then
                    Window.Update(Number, ROUND(i / Maxi * 10000, 1));
            until i > Maxi;
        end;

        XlWorkBook.Close(false);
        xlApp.Quit;
        Clear(xlApp);
    end;


        procedure SelectSheet(FileName: Text[1024]): Text[250]
        var
            i: Integer;
            SheetName: Text[250];
            EndOfLoop: Integer;
            SheetsList: Text[250];
            OptionNo: Integer;
        begin
            if FileName <> '' then begin
                if not Exists(FileName) then
                    Error(Text003, FileName);
            end else
                exit('');
            if (not ISSERVICETIER) then begin
                if not Create(xlApp, true) then
                    Error(Text000);
            end else begin
                if not Create(xlApp, false, ISSERVICETIER) then
                    Error(Text000);
            end;
            fGetVersion();
            xlApp.Workbooks._Open(FileName);
            XlWorkBook := xlApp.ActiveWorkbook;
            i := 1;
            EndOfLoop := XlWorkBook.Worksheets.Count;
            while i <= EndOfLoop do begin
                XlWorksheets := XlWorkBook.Worksheets.Item(i);
                SheetName := XlWorksheets.Name;
                if (SheetName <> '') and (StrLen(SheetsList) + StrLen(SheetName) < 250) then
                    SheetsList := SheetsList + SheetName + ','
                else
                    i := EndOfLoop;
                i := i + 1;
            end;

            XlWorkBook.Close(false);
            xlApp.Quit;
            Clear(xlApp);
            OptionNo := StrMenu(SheetsList, 1);
            if OptionNo <> 0 then
                exit(SelectStr(OptionNo, SheetsList))
            else
                exit('');
        end;


        procedure SheetExists(SheetName: Text[250]): Boolean
        var
            i: Integer;
            EndOfLoop: Integer;
        begin
            i := 1;
            XlWorkBook := xlApp.ActiveWorkbook;
            EndOfLoop := XlWorkBook.Worksheets.Count;
            while i <= EndOfLoop do begin
                XlWorksheets := XlWorkBook.Worksheets.Item(i);
                if XlWorksheets.Name = SheetName then
                    exit(true);
                i := i + 1;
            end;
            exit(false);
        end;


        procedure GetSheetName(SheetNumber: Integer): Text[250]
        var
            EndOfLoop: Integer;
        begin
            EndOfLoop := XlWorkBook.Worksheets.Count;
            if SheetNumber <= EndOfLoop then begin
                XlWorksheets := XlWorkBook.Worksheets.Item(SheetNumber);
                exit(XlWorksheets.Name);
            end else
                exit('');
        end;


        procedure RangeName(RangeName: Text[30]; ColNo: Integer; FromRowNo: Integer; ToRowNo: Integer)
        begin
            XlWorkSheet.Names.Add(
              RangeName,
              '=' + GetRef(4) + ColID(ColNo) + GetRef(4) + RowID(FromRowNo) +
              ':' + GetRef(4) + ColID(ColNo) + GetRef(4) + RowID(ToRowNo));
        end;


        procedure EnterCell(RangeID: Text[10]; Value: Text[250]; Formula: Boolean)
        begin
            if Formula then
                XlWorkSheet.Range(RangeID).Formula := Value
            else
                XlWorkSheet.Range(RangeID).Value := Value;
        end;


        procedure GiveUserControl()
        begin
            xlApp.Visible(true);
            xlApp.UserControl(true);
            Clear(xlApp);
        end;


        procedure PageSetup(LeftHeader: Text[250]; CenterHeader: Text[250]; RightHeader: Text[250])
        begin
            if LeftHeader <> '' then
                XlWorkSheet.PageSetup.LeftHeader := LeftHeader;
            if CenterHeader <> '' then
                XlWorkSheet.PageSetup.CenterHeader := CenterHeader;
            if RightHeader <> '' then
                XlWorkSheet.PageSetup.RightHeader := RightHeader;
        end;


        procedure IsProtectBook(): Boolean
        begin
            exit(XlWorkBook.ProtectStructure or XlWorkBook.ProtectWindows);
        end;


        procedure IsProtectSheet(): Boolean
        begin
            exit(XlWorkSheet.ProtectContents);
        end;


        procedure ProtectSheet(PassWord: Text[30])
        begin
            XlWorkSheet._Protect(PassWord);
        end;


        procedure UnProtectSheet(PassWord: Text[30])
        begin
            XlWorkSheet.Unprotect(PassWord);
        end;


        procedure LockCell(RangeID: Text[10]; "Action": Boolean)
        begin
            if RangeID <> '' then
                XlWorkSheet.Range(RangeID).Locked := Action
            else
                XlWorkSheet.Cells.Locked := Action;
        end;


        procedure Autofit(RangeID: Text[10])
        begin
            if RangeID <> '' then
                XlWorkSheet.Range(RangeID).Columns.AutoFit
            else
                XlWorkSheet.Cells.Columns.AutoFit;
        end;


        procedure GridLines("Action": Boolean)
        begin
            xlApp.ActiveWindow.DisplayGridlines := Action;
        end;
    */

    procedure Format2(RangeID: Text[20]; FormatNo: Integer; Thousand: Boolean)
    var
        FormatString: Text[30];
        Separator: Text[30];
        p: Integer;
        Precision: Text[30];
    begin
        GLSetup.Get;
        FormatString := '';
        Precision := Format(GLSetup."Amount Rounding Precision");
        p := StrPos(Precision, ',');
        if p > 0 then
            Separator := ','
        else
            Separator := '.';

        if Thousand then
            case FormatNo of
                0:
                    FormatString := '# ##0';
                else
                    FormatString := '# ##0' + Separator + CopyStr('0000000000', 1, FormatNo);
            end
        else
            case FormatNo of
                0:
                    FormatString := '0';
                else
                    FormatString := '0' + Separator + CopyStr('0000000000', 1, FormatNo);
            end;

        /* //GL2024 Automation non compatible  if FormatString <> '' then begin
               if RangeID <> '' then
                   XlWorkSheet.Range(RangeID).NumberFormat := FormatString
               else
                   XlWorkSheet.Cells.NumberFormat := FormatString;
           end;*/
    end;


    procedure CustomFormat(RangeID: Text[10]; CustomFormat: Text[30])
    var
        FormatString: Text[30];
        Separator: Text[30];
        BadSeparator: Text[30];
        p: Integer;
        Precision: Text[30];
    begin
        GLSetup.Get;
        FormatString := '';
        Precision := Format(GLSetup."Amount Rounding Precision");
        p := StrPos(Precision, ',');
        if p > 0 then begin
            Separator := ',';
            BadSeparator := '.';
        end else begin
            Separator := '.';
            BadSeparator := ',';
        end;

        if CustomFormat <> '' then begin
            p := StrPos(CustomFormat, BadSeparator);
            if p > 0 then
                CustomFormat := CopyStr(CustomFormat, 1, p - 1) + Separator + CopyStr(CustomFormat, p + 1);
            /*//GL2024 Automation non compatible  if RangeID <> '' then
                  XlWorkSheet.Range(RangeID).NumberFormat := CustomFormat
              else
                  XlWorkSheet.Cells.NumberFormat := CustomFormat*/
        end;
    end;

    /*
    //GL2024 Automation non compatible
        procedure Height(RangeID: Text[10]; Heightx: Integer; Wrap: Boolean)
        begin
            XlWorkSheet.Range(RangeID).Rows.RowHeight := Heightx;
            XlWorkSheet.Range(RangeID).Rows.WrapText := Wrap;
        end;


        procedure ColWidth(RangeID: Text[10]; ColWidth: Integer)
        begin
            if RangeID <> '' then
                XlWorkSheet.Range(RangeID).ColumnWidth := ColWidth
            else
                XlWorkSheet.Cells.ColumnWidth := ColWidth;
        end;


        procedure FontName(RangeID: Text[10]; FontName: Text[30]; FontSize: Integer)
        begin
            if FontName <> '' then begin
                if RangeID <> '' then begin
                    XlWorkSheet.Range(RangeID).Font.Name := FontName;
                    if FontSize > 0 then
                        XlWorkSheet.Range(RangeID).Font.Size := FontSize;
                end else begin
                    XlWorkSheet.Cells.Font.Name := FontName;
                    if FontSize > 0 then
                        XlWorkSheet.Cells.Font.Size := FontSize;
                end;
            end;
        end;


        procedure FontStyle(RangeID: Text[10]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
        begin
            InitConst;
            if RangeID <> '' then begin
                XlWorkSheet.Range(RangeID).Font.Bold := Bold;
                XlWorkSheet.Range(RangeID).Font.Italic := Italic;
                if UnderLine then
                    XlWorkSheet.Range(RangeID).Borders.Item(xlEdgeBottom).LineStyle := xlContinuous
            end else begin
                XlWorkSheet.Cells.Font.Bold := Bold;
                XlWorkSheet.Cells.Font.Italic := Italic;
                if UnderLine then
                    XlWorkSheet.Cells.Borders.Item(xlEdgeBottom).LineStyle := xlContinuous
            end;
        end;

    */
    procedure Border(RangeID: Text[10]; Weight: Integer)
    var
        WeightValue: Integer;
    begin
        InitConst;
        WeightValue := 0;
        case Weight of
            0:
                WeightValue := xlHairLine;
            1:
                WeightValue := xlThin;
            2:
                WeightValue := xlMedium;
            3:
                WeightValue := xlThick;
        end;

        //GL2024 Automation non compatible  XlWorkSheet.Range(RangeID)._BorderAround(xlContinuous, WeightValue);
    end;


    procedure LineStyle(RangeID: Text[10]; Side: Integer; Weight: Integer)
    var
        WeightValue: Integer;
        SideValue: Integer;
    begin
        InitConst;
        SideValue := 0;
        WeightValue := 0;

        case Side of
            0:
                SideValue := xlEdgeLeft;
            1:
                SideValue := xlEdgeTop;
            2:
                SideValue := xlEdgeRight;
            3:
                SideValue := xlEdgeBottom;
        end;

        case Weight of
            0:
                WeightValue := xlHairLine;
            1:
                WeightValue := xlThin;
            2:
                WeightValue := xlMedium;
            3:
                WeightValue := xlThick;
        end;

        //GL2024 Automation non compatible    XlWorkSheet.Range(RangeID).Borders.Item(SideValue).LineStyle := xlContinuous;
        //GL2024 Automation non compatible      XlWorkSheet.Range(RangeID).Borders.Item(SideValue).Weight := WeightValue;
    end;

    /*
    //GL2024 Automation non compatible
        procedure Color(RangeID: Text[10]; Target: Integer; Color: Integer)
        begin
            InitConst;
            if Color = 0 then
                Color := xlColorIndexAutomatic;
            case Target of
                0: //Font
                    XlWorkSheet.Range(RangeID).Font.ColorIndex := Color;
                1: //Border:
                    XlWorkSheet.Range(RangeID).Borders.ColorIndex := Color;
                2: //Interior:
                    XlWorkSheet.Range(RangeID).Interior.ColorIndex := Color;
            end;
        end;


        procedure Merge(RangeID: Text[10])
        begin
            InitConst;
            XlWorkSheet.Range(RangeID).Merge;
        end;
    */

    procedure HAlign(RangeID: Text[10]; Alignment: Integer)
    var
        Align: Integer;
    begin
        InitConst;
        Align := 0;
        case Alignment of
            0:
                Align := xlHAlignGeneral;
            1:
                Align := xlHAlignCenter;
            2:
                Align := xlHAlignDistributed;
            3:
                Align := xlHAlignLeft;
            4:
                Align := xlHAlignRight;
        end;

        /*  //GL2024 Automation non compatibleif Align <> 0 then
              if RangeID <> '' then
                  XlWorkSheet.Range(RangeID).HorizontalAlignment := Align
              else
                  XlWorkSheet.Cells.HorizontalAlignment := Align;*/
    end;


    procedure VAlign(RangeID: Text[20]; Alignment: Integer)
    var
        Align: Integer;
    begin
        InitConst;
        Align := 0;
        case Alignment of
            0:
                Align := xlVAlignTop;
            1:
                Align := xlVAlignCenter;
            2:
                Align := xlVAlignDistributed;
            3:
                Align := xlVAlignBottom;
        end;

        /*//GL2024 Automation non compatible if Align <> 0 then
             if RangeID <> '' then
                 XlWorkSheet.Range(RangeID).VerticalAlignment := Align
             else
                 XlWorkSheet.Cells.VerticalAlignment := Align;*/
    end;


    procedure GetRef(Which: Integer): Text[250]
    begin
        case Which of
            1:
                exit(Text013);
            // DO NOT TRANSLATE: &B is the Excel code to turn bold printing on or off for customized Header/Footer.
            2:
                exit(Text014);
            // DO NOT TRANSLATE: &D is the Excel code to print the current date in customized Header/Footer.
            3:
                exit(Text015);
            // DO NOT TRANSLATE: &P is the Excel code to print the page number in customized Header/Footer.
            4:
                exit('$');
            // DO NOT TRANSLATE: $ is the Excel code for absolute reference to cells.
            5:
                exit(Text016);
            // DO NOT TRANSLATE: A1 is the Excel reference of the first cell.
            6:
                exit(Text017);
            // DO NOT TRANSLATE: SUMIF is the name of the Excel function used to summarize values according to some conditions.
            7:
                exit(Text018);
        // DO NOT TRANSLATE: The #N/A Excel error value occurs when a value is not available to a function or formula.
        end;
    end;


    procedure ColID(ColNo: Integer): Text[10]
    var
        ColID: Text[10];
        x: Integer;
        i: Integer;
        c: Char;
        z: Integer;
        toColID: Text[10];
    begin
        ColID := '';
        //RTC
        for z := 1 to 10 do
            ColID[z] := ' ';
        //RTC//
        if ColNo <> 0 then begin
            x := ColNo - 1;
            c := 65 + x MOD 26;
            ColID[10] := c;
            i := 10;
            while x > 25 do begin
                x := x DIV 26;
                i := i - 1;
                c := 64 + x MOD 26;
                ColID[i] := c;
            end;
            for x := i to 10 do begin
                ColID[1 + x - i] := ColID[x];
                toColID[1 + x - i] := ColID[x];
                //RTC
                //RTC//
            end;
            //RTC
            ColID := toColID;
            //RTC//
        end;
        exit(ColID);
    end;


    procedure RowID(RowNo: Integer): Text[10]
    var
        RowID: Text[10];
    begin
        RowID := '';
        if RowNo <> 0 then
            RowID := Format(RowNo);
        exit(RowID);
    end;


    procedure GetID(RowNo: Integer; ColNo: Integer): Text[10]
    begin
        if (ColNo > 0) and (RowNo > 0) then
            exit(ColID(ColNo) + RowID(RowNo));
        if (ColNo = 0) and (RowNo > 0) then
            exit(RowID(RowNo) + ':' + RowID(RowNo));
        if (ColNo > 0) and (RowNo = 0) then
            exit(ColID(ColNo) + ':' + ColID(ColNo));
    end;


    procedure InitConst()
    begin
        fInitErrorConstante;
        xlDiagonalDown := 5;
        xlDiagonalUp := 6;

        //Bordure de cellule
        xlEdgeLeft := 7;
        xlEdgeTop := 8;
        xlEdgeBottom := 9;
        xlEdgeRight := 10;

        //Border Weight
        xlHairLine := 1;
        xlMedium := -4138;
        xlThick := 4;
        xlThin := 2;

        //Border
        xlContinuous := 1;
        xlLineStyleNone := -4142;

        //Orientation
        xlLandscape := 2;
        xlPortrait := 1;

        //Alignement vertical
        xlVAlignTop := -4160;
        xlVAlignBottom := -4107;
        xlVAlignCenter := -4108;
        xlVAlignDistributed := -4117;

        //Alignement horizontal
        xlHAlignGeneral := 1;
        xlHAlignCenter := -4108;
        xlHAlignDistributed := -4117;
        xlHAlignLeft := -4131;
        xlHAlignRight := -4152;

        //Color
        xlColorIndexAutomatic := -4105;
        xlColorIndexNone := -4142;
    end;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;


    /*  
    //GL2024 Automation non compatible

    procedure wGetErrorXlIndexRangeCalc(var pXlRange: Automation) Return: Integer
      begin
          fInitErrorConstante;
          if fErrorEvalFunction(pXlRange, xlEvaluateToError) then
              Return := xlEvaluateToError
          else
              if fErrorEvalFunction(pXlRange, xlTextDate) then
                  Return := xlTextDate
              else
                  if fErrorEvalFunction(pXlRange, xlNumberAsText) then
                      Return := xlNumberAsText
                  else
                      if fErrorEvalFunction(pXlRange, xlInconsistentFormula) then
                          Return := xlInconsistentFormula
                      else
                          if fErrorEvalFunction(pXlRange, xlOmittedCells) then
                              Return := xlOmittedCells
                          else
                              if fErrorEvalFunction(pXlRange, xlUnlockedFormulaCells) then
                                  Return := xlUnlockedFormulaCells
                              else
                                  if fErrorEvalFunction(pXlRange, xlEmptyCellReferences) then
                                      Return := xlEmptyCellReferences
                                  else
                                      Return := -1;
      end;
  */

    procedure wGetErrorTextXlRangeCalc(pIndex: Integer): Text[250]
    var
        tErrValError: label 'La cellule contient une valeur d''erreur.';
        tErrTextDate: label 'La cellule contient une date de texte avec des années à deux chiffres.';
        tErrNumberText: label 'La cellule contient un nombre enregistré comme du texte.';
        tErrInconsistentFormula: label 'La cellule contient une formule incohérente pour une zone.';
        tErrOmittedCells: label 'La cellule contient une formule qui omet une cellule pour une zone.';
        tErrUnlockedFormulaCells: label 'La cellule qui est déverrouillée contient une formule.';
        tErrEmptyCellReferences: label 'La cellule contient une formule faisant référence à des cellules vides.';
        tErrCells: label 'An error has detected on the formula';
    begin
        case pIndex of
            xlEvaluateToError:
                exit(tErrValError);
            xlTextDate:
                exit(tErrTextDate);
            xlNumberAsText:
                exit(tErrNumberText);
            xlInconsistentFormula:
                exit(tErrInconsistentFormula);
            xlOmittedCells:
                exit(tErrOmittedCells);
            xlUnlockedFormulaCells:
                exit(tErrUnlockedFormulaCells);
            xlEmptyCellReferences:
                exit(tErrEmptyCellReferences);
            xlErrorCells:
                exit(tErrCells);
        end;
    end;

    local procedure fInitErrorConstante()
    begin
        xlEvaluateToError := 1;
        xlTextDate := 2;
        xlNumberAsText := 3;
        xlInconsistentFormula := 4;
        xlOmittedCells := 5;
        xlUnlockedFormulaCells := 6;
        xlEmptyCellReferences := 7;
        xlErrorCells := 8;
    end;
    /*

    //GL2024 Automation non compatible
        local procedure fErrorEvalFunction(var pXlRange: Automation; pXlErrorCode: Integer) Return: Boolean
        begin
            Evaluate(Return, Format(pXlRange.Errors.Item(pXlErrorCode).Value));
        end;


        procedure fGetValue(pRangeID: Text[50]) Retour: Text[250]
        var
            indexerror: Integer;
            toto: Variant;
        begin
            if (wLastRangeID <> pRangeID) then begin
                if (not fHasRangeError(pRangeID, indexerror)) then begin
                    XlRange := XlWorkSheet.Range(pRangeID);
                    Evaluate(Retour, Format(XlRange.Value2));
                end else begin
                    Retour := '';
                end;
            end else begin
                if (wLastErrorIndex <> 0) then begin
                    Retour := '';
                end else begin
                    XlRange := XlWorkSheet.Range(pRangeID);
                    Evaluate(Retour, Format(XlRange.Value2));
                end;
            end;
        end;

    */
    procedure fGetValueAt(pCell1: Text[30]; pCell2: Text[30]) Retour: Text[250]
    var
        lNullValue: Variant;
        indexerror: Integer;
        lCellName: Text[250];
    begin
        Clear(lNullValue);
        lCellName := '';
        if (pCell2 = '') then begin
            lCellName := pCell1;
        end else begin
            lCellName := pCell1 + ':' + pCell2;
        end;
        //indexerror := wGetErrorXlIndexRangeCalc(XlRange);
        /* //GL2024 Automation non compatible   if (not fHasRangeError(lCellName, indexerror)) then begin
                XlRange := XlWorkSheet.Range(lCellName);
                Evaluate(Retour, Format(XlRange.Value2));
            end else begin
                Retour := '';
            end;*/
    end;


    procedure fEvaluateFormula(pRangeID: Text[40]) retour: Boolean
    var
        indexerror: Integer;
        lEval: Boolean;
    begin
        retour := true;
        //GL2024 Automation non compatible XlRange := XlWorkSheet.Range(pRangeID);
        //GL2024 Automation non compatible Evaluate(lEval, Format(XlRange.HasFormula));
        if (lEval) then begin
            //GL2024 Automation non compatible  XlRange.Calculate;
            if (fHasRangeError(pRangeID, indexerror)) then begin
                //indexerror := wGetErrorXlIndexRangeCalc(XlRange);
                if (indexerror <> 0) then
                    retour := false;
            end;
        end;
    end;


    procedure fGetErrorMessage(pRangeID: Text[40]) Retour: Text[250]
    var
        indexerror: Integer;
    begin
        if (wLastRangeID <> pRangeID) then begin
            if (fHasRangeError(pRangeID, indexerror)) then begin
                Retour := wGetErrorTextXlRangeCalc(indexerror);
            end else begin
                Retour := '';
            end;
        end else begin
            if (wLastErrorIndex <> 0) then begin
                Retour := wGetErrorTextXlRangeCalc(wLastErrorIndex);
            end else begin
                Retour := '';
            end;
        end;
    end;

    /*
      //GL2024 Automation non compatible
        procedure fClearRange(pRangeID: Text[50])
        begin
            XlRange := XlWorkSheet.Range(pRangeID);
            XlRange.ClearComments();
            //IF (FORMAT(XlRange.Name) <> '') THEN
            //  XlRange.Name := '';
            XlRange.Clear();
        end;


        procedure fDeleteRange(pRangeID: Text[50])
        begin
            XlRange := XlWorkSheet.Range(pRangeID);
            XlRange.Delete();
        end;


        procedure fAddComments(pRangeID: Text[50]; pComment: Text[250])
        begin
            XlRange := XlWorkSheet.Range(pRangeID);
            XlRange.AddComment(pComment);
        end;


        procedure fRangeExist(pRangeID: Text[50]) Retour: Boolean
        var
            lIndex: Integer;
            lRangeName: Text[255];
        begin
            Retour := false;
            lIndex := 1;
            while ((not Retour) and (lIndex <= XlWorkSheet.Names.Count)) do begin
                lRangeName := XlWorkSheet.Names.Item(lIndex).Name;
                if (StrPos(lRangeName, XlWorkSheet.Name) > 0) then begin
                    lRangeName := CopyStr(lRangeName, StrLen(XlWorkSheet.Name) + 2);
                end;
                if (lRangeName = pRangeID) then
                    Retour := true;
                lIndex := lIndex + 1;
            end
        end;


        procedure fSetVisible(pShow: Boolean)
        begin
            xlApp.Visible := pShow;
        end;
    */

    //GL2024 Automation non compatible procedure fClearSheets()
    //GL2024 Automation non compatible var
    //GL2024 Automation non compatible     lXlrange: Boolean;
    //GL2024 Automation non compatible begin
    /*WHILE (XlWorkBook.Worksheets.Count - 1 <> 0) DO BEGIN
      XlWorkSheet := XlWorkBook.Worksheets.Item(1);
      XlWorkSheet.Delete();
    END;
    XlWorkBook := xlApp.Workbooks.Add;
    XlWorkSheet := XlWorkBook.Worksheets.Item(1);
    */
    //GL2024 Automation non compatible if (not ISCLEAR(XlWorkSheet)) then begin
    //XlWorkSheet.Cells.Select();
    //XlRange := xlApp.Selection();
    //XlRange.Delete();

    //GL2024 Automation non compatible   XlRange := XlWorkSheet.Cells;
    //GL2024 Automation non compatible   if (not ISCLEAR(XlRange)) then begin
    //GL2024 Automation non compatible         XlRange.Delete();
    //GL2024 Automation non compatible   end;
    //GL2024 Automation non compatible end;

    //GL2024 Automation non compatibleend;

    /*
        procedure fExcelIsActive() Retour: Boolean
        begin
            Retour := (not ISCLEAR(xlApp)) or
                      (not ISCLEAR(XlWorkBook)) or
                      (not ISCLEAR(XlWorkSheet));
        end;


        procedure fSetRangeName(pCelID: Text[50]; pRangeID: Text[255])
        begin
            XlRange := XlWorkSheet.Range(pCelID);
            XlRange.Name := pRangeID;
        end;


        procedure fDisplayAlerts(pShow: Boolean)
        begin
            xlApp.DisplayAlerts := pShow;
        end;
    */

    procedure fRangeError(pCellID: Text[50]) return: Boolean
    var
        indexerror: Integer;
    begin
        return := false;
        return := fHasRangeError(pCellID, indexerror);
    end;


    procedure fHasRangeError(pRangeID: Text[80]; var pErrNo: Integer) Return: Boolean
    var
        //GL2024 Automation non compatible  lxlRange: Automation;
        //GL2024 Automation non compatible  lxlRangeErrType: Automation;
        lCountryCode: Boolean;
        lValError: Text[10];
        lXlCountryCode: Integer;
    //GL2024 Automation non compatible   lmsoapp: Automation;
    //GL2024 Automation non compatible  lXlWorkSheetFct: Automation;
    begin
        Return := false;
        pErrNo := 0;
        //GL2024 Automation non compatible   lxlRange := XlWorkSheet.Range(pRangeID);
        //GL2024 Automation non compatible  lXlWorkSheetFct := xlApp.WorksheetFunction();
        /*   //GL2024 Automation non compatible if (lXlWorkSheetFct.IsError(lxlRange)) then begin
              Return := true;
              if (wxlVersion <= 9) then begin
                  pErrNo := xlErrorCells;
              end else begin
                  pErrNo := wGetErrorXlIndexRangeCalc(lxlRange);
              end;
          end;*/
        wLastRangeID := pRangeID;
        wLastErrorIndex := pErrNo;
    end;


    procedure fGetVersion()
    var
        lVersion: Text[250];
        lToSeparator: Text[1];
        lFromSeparator: Text[1];
        lGLSetup: Record "General Ledger Setup";
    begin
        //GL2024 Automation non compatible    lVersion := xlApp.Version;
        lGLSetup.Get;
        if StrPos(Format(lGLSetup."Amount Rounding Precision"), ',') <> 0 then begin
            lToSeparator := ',';
            lFromSeparator := '.';
        end else begin
            lToSeparator := '.';
            lFromSeparator := ',';
        end;
        lVersion := ConvertStr(lVersion, lFromSeparator, lToSeparator);
        Evaluate(wxlVersion, lVersion);
    end;

    /*
      //GL2024 Automation non compatible
        procedure fSetBackgroundChecking(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.BackgroundChecking := pEnabled;
        end;


        procedure fSetEmptyCellReferences(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.EmptyCellReferences := pEnabled;
        end;


        procedure fSetEvaluateToError(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.EvaluateToError := pEnabled;
        end;


        procedure fSetInconsistentFormula(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.InconsistentFormula := pEnabled;
        end;


        procedure fSetIndicatorColorIndex(pColor: Integer)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.IndicatorColorIndex := pColor;
        end;


        procedure fSetNumberAsText(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.NumberAsText := pEnabled;
        end;


        procedure fSetOmittedCells(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.OmittedCells := pEnabled;
        end;


        procedure fSetTextDate(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.TextDate := pEnabled;
        end;


        procedure fSetUnlockedFormulaCells(pEnabled: Boolean)
        begin
            if (wxlVersion > 9) then
                xlApp.ErrorCheckingOptions.UnlockedFormulaCells := pEnabled;
        end;


        procedure fSetR1C1ReferenceStyle()
        begin
            if (wxlVersion > 9) then
                xlApp.ReferenceStyle := -4150;
        end;


        procedure fSetA1ReferenceStyle()
        begin
            if (wxlVersion > 9) then
                xlApp.ReferenceStyle := 1;
        end;


        procedure fGetLine(pRangeID: Text[80]) retour: Integer
        var
            lxlRange: Automation;
        begin
            lxlRange := XlWorkSheet.Range(pRangeID);
            retour := lxlRange.Row;
        end;


        procedure fGetColumn(pRangeID: Text[80]) retour: Integer
        var
            lxlRange: Automation;
        begin
            lxlRange := XlWorkSheet.Range(pRangeID);
            retour := lxlRange.Column;
        end;
        */
}

