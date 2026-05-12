Page 58007 "RTC Resources by Work Type"
{
    // //POINTAGE GESWAY 28/08/02 Création d'une matrice de contrôle

    Caption = 'RTC Resources by Work Type';
    PageType = Card;
    SourceTable = Resource;
    SourceTableView = sorting(Type, "Bal. Job No.", "No.")
                      where(Type = filter(Person | Machine), "WT Allowed" = const(true));
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filters';
                field("Date Filter"; rec."Date Filter")
                {
                    ApplicationArea = all;
                    Caption = 'Date Filter';

                    trigger OnValidate()
                    begin
                        DateFilterOnAfterValidate;
                    end;
                }
                field(FiltreHeures; FiltreHeures)
                {
                    ApplicationArea = all;
                    Caption = 'Hours Filter';

                    trigger OnValidate()
                    begin
                        for i := 1 to StrLen(FiltreHeures) do
                            if not (FiltreHeures[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '&', '|', '<', '=', '>']) then
                                Error(Text8003901);
                        FiltreHeuresOnAfterValidate;
                    end;
                }
                field(ShowColumnName; ShowColumnName)
                {
                    ApplicationArea = all;
                    Caption = 'Show Column Name';

                    trigger OnValidate()
                    begin
                        ShowColumnNameOnAfterValidate;
                    end;
                }
                field(PostedFilter; FiltreValide)
                {
                    ApplicationArea = all;
                    Caption = 'Show Entries';
                    OptionCaption = 'All,Posted,Journal';
                    Visible = PostedFilterVisible;

                    trigger OnValidate()
                    begin
                        FiltreValideOnAfterValidate;
                    end;
                }
                field(FiltresWT; FiltresWT)
                {
                    ApplicationArea = all;
                    Caption = 'Work Time Filter';
                    //  OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
                    Visible = FiltresWTVisible;

                    trigger OnValidate()
                    begin
                        FiltresWTOnAfterValidate;
                    end;
                }
                field(Bouton; FiltresWTOpt)
                {
                    ApplicationArea = all;
                    Caption = 'Work Time Filter';
                    OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
                    Visible = BoutonVisible;

                    trigger OnValidate()
                    begin
                        FiltresWTOptOnAfterValidate;
                    end;
                }
            }
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                {
                    ApplicationArea = all;
                    Caption = 'Column Set';
                    Editable = false;
                }
            }
            repeater(Control800390005)
            {
                ShowCaption = false;
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                }
                field(Heures; gHoursQty)
                {
                    ApplicationArea = all;
                    Caption = 'Hours (Qty.)';
                }






                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    DecimalPlaces = 0 : 5;
                    Visible = Field1Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    DecimalPlaces = 0 : 5;
                    Visible = Field2Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    DecimalPlaces = 0 : 5;
                    Visible = Field3Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    DecimalPlaces = 0 : 5;
                    Visible = Field4Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    DecimalPlaces = 0 : 5;
                    Visible = Field5Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    DecimalPlaces = 0 : 5;
                    Visible = Field6Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    DecimalPlaces = 0 : 5;
                    Visible = Field7Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    DecimalPlaces = 0 : 5;
                    Visible = Field8Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    DecimalPlaces = 0 : 5;
                    Visible = Field9Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    DecimalPlaces = 0 : 5;
                    Visible = Field10Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    DecimalPlaces = 0 : 5;
                    Visible = Field11Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    DecimalPlaces = 0 : 5;
                    Visible = Field12Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[13];
                    DecimalPlaces = 0 : 5;
                    Visible = Field13Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[14];
                    DecimalPlaces = 0 : 5;
                    Visible = Field14Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[15];
                    DecimalPlaces = 0 : 5;
                    Visible = Field15Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[16];
                    DecimalPlaces = 0 : 5;
                    Visible = Field16Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[17];
                    DecimalPlaces = 0 : 5;
                    Visible = Field17Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[18];
                    DecimalPlaces = 0 : 5;
                    Visible = Field18Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[19];
                    DecimalPlaces = 0 : 5;
                    Visible = Field19Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[20];
                    DecimalPlaces = 0 : 5;
                    Visible = Field20Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[21];
                    DecimalPlaces = 0 : 5;
                    Visible = Field21Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[22];
                    DecimalPlaces = 0 : 5;
                    Visible = Field22Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[23];
                    DecimalPlaces = 0 : 5;
                    Visible = Field23Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[24];
                    DecimalPlaces = 0 : 5;
                    Visible = Field24Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[25];
                    DecimalPlaces = 0 : 5;
                    Visible = Field25Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[26];
                    DecimalPlaces = 0 : 5;
                    Visible = Field26Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[27];
                    DecimalPlaces = 0 : 5;
                    Visible = Field27Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[28];
                    DecimalPlaces = 0 : 5;
                    Visible = Field28Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[29];
                    DecimalPlaces = 0 : 5;
                    Visible = Field29Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[30];
                    DecimalPlaces = 0 : 5;
                    Visible = Field30Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[31];
                    DecimalPlaces = 0 : 5;
                    Visible = Field31Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[32];
                    DecimalPlaces = 0 : 5;
                    Visible = Field32Visible;

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(32);
                    end;
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = all;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';

                trigger OnAction()
                begin
                    SetColumns(Matrix_setwanted::Previous);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = all;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';

                trigger OnAction()
                begin
                    SetColumns(Matrix_setwanted::Next);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        fSetFilters();
        gHoursQty := rec."Job. Posted Quantity (Base)" + ResQtyPlanning;
        lIndex := 0;
        if MatrixRecord.Find('-') then
            repeat
                lIndex += 1;
                MATRIX_OnAfterGetRecord(lIndex);
            until (MatrixRecord.Next() = 0) or (lIndex = MATRIX_CurrSetLength);
    end;

    trigger OnClosePage()
    var
        lJobJnlLine3: Record "Job Journal Line";
    begin
        if rec.GetFilter("No.") = '' then begin
            lJobJnlLine3.Reset;
            lJobJnlLine3.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Attached to Line No.");
            lJobJnlLine3.SetFilter("Attached to Line No.", '<>0');
            lJobJnlLine3.DeleteAll;
        end;
    end;

    trigger OnInit()
    begin
        Field32Visible := true;
        Field31Visible := true;
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
        PostedFilterVisible := true;
        BoutonVisible := true;
        FiltresWTVisible := true;
    end;

    trigger OnOpenPage()
    begin
        fInitialize();
        SetColumns(Matrix_setwanted::Initial);
    end;

    var
        wJobJnlTmp: Record "Job Journal Line" temporary;
        ResLedgerEntry: Record "Res. Ledger Entry";
        WT: Record "Work Type";
        CreateJobJnlLine: Codeunit "Create Job Journal Line WT";
        MatrixHeader: Text[250];
        FiltreWT: Text[250];
        FiltresWT: Text[250];
        TabOpt: array[7] of Text[30];
        FiltreHeures: Text[250];
        FiltresWTOpt: Option " ","Producted Hours","Unproduced Hours","Absence Hours",Premium,Transport,Meal;
        Text8003900: label ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
        FiltreValide: Option All,Posted,Journal;
        i: Integer;
        KO: Boolean;
        Text8003901: label 'The filter is unavailable.';
        Text8003902: label '(Posted)';
        Text8003903: label '(In progress)';
        ShowColumnName: Boolean;
        FiltreWTGlob: Text[250];
        wQtyPlanning: Decimal;
        ResQtyPlanning: Decimal;
        "-------": Integer;
        gHoursQty: Decimal;
        MatrixRecord: Record "Work Type";
        MatrixRecords: array[32] of Record "Work Type";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Decimal;
        [InDataSet]
        FiltresWTVisible: Boolean;
        [InDataSet]
        BoutonVisible: Boolean;
        [InDataSet]
        PostedFilterVisible: Boolean;
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        [InDataSet]
        Field21Visible: Boolean;
        [InDataSet]
        Field22Visible: Boolean;
        [InDataSet]
        Field23Visible: Boolean;
        [InDataSet]
        Field24Visible: Boolean;
        [InDataSet]
        Field25Visible: Boolean;
        [InDataSet]
        Field26Visible: Boolean;
        [InDataSet]
        Field27Visible: Boolean;
        [InDataSet]
        Field28Visible: Boolean;
        [InDataSet]
        Field29Visible: Boolean;
        [InDataSet]
        Field30Visible: Boolean;
        [InDataSet]
        Field31Visible: Boolean;
        [InDataSet]
        Field32Visible: Boolean;


    procedure InitForm(pPostedFilter: Option All,Posted,Journal)
    begin
        FiltreValide := pPostedFilter;
    end;


    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next)
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        Clear(MATRIX_CaptionSet);
        Clear(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GetTable(MatrixRecord);
        MatrixRecordRef.SetTable(MatrixRecord);

        if ShowColumnName then
            CaptionFieldNo := MatrixRecord.FieldNo(Description)
        else
            CaptionFieldNo := MatrixRecord.FieldNo(Code);

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CurrSetLength > 0 then begin
            MatrixRecord.SetPosition(MATRIX_PKFirstRecInCurrSet);
            MatrixRecord.Find;
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].Copy(MatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (MatrixRecord.Next <> 1);
        end;
    end;


    procedure fInitialize()
    var
        lCreateJobJnlLine: Codeunit "Create Job Journal Line WT";
    begin
        WT.SetFilter("Work Time Type", '%1|%2|%3', WT."work time type"::"Producted Hours", WT."work time type"::"Unproduced Hours",
                     WT."work time type"::"Absence Hours");
        if WT.Find('-') then
            repeat
                if FiltreWT <> '' then
                    FiltreWT += '|';
                FiltreWT += WT.Code;
            until WT.Next = 0;
        FiltreWTGlob := FiltreWT;
        for i := 1 to 7 do
            TabOpt[i] := SelectStr(i, Text8003900);

        lCreateJobJnlLine.wSetTempRec(true);
        lCreateJobJnlLine.wInsertTmpJnlLine(wJobJnlTmp);

        if rec.GetFilter("No.") <> '' then begin
            MatrixRecord.SetFilter(Code, rec.GetFilter("Work Type Filter"));
            FiltreWT := rec.GetFilter("Work Type Filter");
            FiltreHeures := '';
            FiltresWTVisible := false;
            BoutonVisible := false;
            PostedFilterVisible := false;
        end else begin
            MatrixRecord.SetFilter("Work Time Type", FiltresWT);
        end;
        rec.ClearMarks;
    end;


    procedure fSetFilters()
    var
        lResLoc: Record Resource temporary;
    begin
        rec.SetFilter("Work Type Filter", FiltreWT);
        if FiltreValide <> Filtrevalide::Journal then
            rec.CalcFields("Job. Posted Quantity (Base)");
        if FiltreValide <> Filtrevalide::Posted then
            ResQtyPlanning := CreateJobJnlLine.wCalcQtyPerRes(Rec, wJobJnlTmp);

        KO := false;
        if FiltreHeures <> '' then begin
            lResLoc.Copy(Rec);
            lResLoc.Insert;
            lResLoc.SetFilter("Work Type Filter", FiltreWT);
            lResLoc.CalcFields("Job. Posted Quantity (Base)");
            if FiltreValide = Filtrevalide::Journal then
                lResLoc."Job. Posted Quantity (Base)" := 0;
            lResLoc."Unit Cost" := lResLoc."Job. Posted Quantity (Base)" + wQtyPlanning;
            lResLoc.Modify;
            lResLoc.SetFilter("Unit Cost", FiltreHeures);
            rec.Mark := not lResLoc.IsEmpty;
            KO := rec.Mark;
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    var
        lRes: Record Resource;
        lResLoc: Record Resource temporary;
    begin
        lRes.Copy(Rec);
        wQtyPlanning := 0;
        lRes.SetRange("Work Type Filter", MatrixRecords[ColumnID].Code);
        if FiltreValide <> Filtrevalide::Journal then
            lRes.CalcFields("Job Usage (Qty)");
        if FiltreValide <> Filtrevalide::Posted then
            wQtyPlanning := CreateJobJnlLine.wCalcQtyPerRes(lRes, wJobJnlTmp);

        KO := false;
        if FiltresWT <> '' then
            if FiltreWT = '' then begin
                WT.SetFilter("Work Time Type", FiltresWT);
                if WT.Find('-') then
                    repeat
                        if FiltreWT <> '' then
                            FiltreWT += '|';
                        FiltreWT += WT.Code;
                    until WT.Next = 0;
            end;

        if FiltreHeures <> '' then begin
            lResLoc.Copy(lRes);
            lResLoc.Insert;
            lResLoc.SetRange("Work Type Filter", MatrixRecords[ColumnID].Code);
            if FiltreValide = Filtrevalide::Posted then
                wQtyPlanning := 0;
            if FiltreValide <> Filtrevalide::Journal then
                lResLoc.CalcFields("Job Usage (Qty)");
            lResLoc."Unit Cost" := lResLoc."Job Usage (Qty)" + wQtyPlanning;
            lResLoc.Modify;
            lResLoc.SetFilter("Unit Cost", FiltreHeures);
            rec.Mark := not lResLoc.IsEmpty;
            KO := rec.Mark;
        end;

        MATRIX_CellData[ColumnID] := lRes."Job Usage (Qty)" + wQtyPlanning;
        SetVisible;
    end;


    procedure SetVisible()
    begin
        Field1Visible := MATRIX_CaptionSet[1] <> '';
        Field2Visible := MATRIX_CaptionSet[2] <> '';
        Field3Visible := MATRIX_CaptionSet[3] <> '';
        Field4Visible := MATRIX_CaptionSet[4] <> '';
        Field5Visible := MATRIX_CaptionSet[5] <> '';
        Field6Visible := MATRIX_CaptionSet[6] <> '';
        Field7Visible := MATRIX_CaptionSet[7] <> '';
        Field8Visible := MATRIX_CaptionSet[8] <> '';
        Field9Visible := MATRIX_CaptionSet[9] <> '';
        Field10Visible := MATRIX_CaptionSet[10] <> '';
        Field11Visible := MATRIX_CaptionSet[11] <> '';
        Field12Visible := MATRIX_CaptionSet[12] <> '';
        Field13Visible := MATRIX_CaptionSet[13] <> '';
        Field14Visible := MATRIX_CaptionSet[14] <> '';
        Field15Visible := MATRIX_CaptionSet[15] <> '';
        Field16Visible := MATRIX_CaptionSet[16] <> '';
        Field17Visible := MATRIX_CaptionSet[17] <> '';
        Field18Visible := MATRIX_CaptionSet[18] <> '';
        Field19Visible := MATRIX_CaptionSet[19] <> '';
        Field20Visible := MATRIX_CaptionSet[20] <> '';
        Field21Visible := MATRIX_CaptionSet[21] <> '';
        Field22Visible := MATRIX_CaptionSet[22] <> '';
        Field23Visible := MATRIX_CaptionSet[23] <> '';
        Field24Visible := MATRIX_CaptionSet[24] <> '';
        Field25Visible := MATRIX_CaptionSet[25] <> '';
        Field26Visible := MATRIX_CaptionSet[26] <> '';
        Field27Visible := MATRIX_CaptionSet[27] <> '';
        Field28Visible := MATRIX_CaptionSet[28] <> '';
        Field29Visible := MATRIX_CaptionSet[29] <> '';
        Field30Visible := MATRIX_CaptionSet[30] <> '';
        Field31Visible := MATRIX_CaptionSet[31] <> '';
        Field32Visible := MATRIX_CaptionSet[32] <> '';
    end;


    procedure MatrixOnDrillDown(pColumnID: Integer)
    begin
        CreateJobJnlLine.fDrillDown(wJobJnlTmp, rec."No.", MatrixRecords[pColumnID].Code, rec.GetFilter("Date Filter"), FiltreValide)
    end;

    local procedure FiltresWTOnAfterValidate()
    var
        FiltreLoc: Text[250];
    begin
        if (StrPos(FiltresWT, '*') > 1) then begin
            FiltresWT := CopyStr(FiltresWT, 1, StrPos(FiltresWT, '*') - 1);
            for i := 1 to 7 do
                if StrPos(TabOpt[i], FiltresWT) <> 0 then begin
                    if FiltreLoc <> '' then
                        FiltreLoc += '|';
                    FiltreLoc += TabOpt[i];
                end;
            if FiltreLoc <> '' then
                FiltresWT := FiltreLoc;
            //CurrForm.ItemAvailMatrix.MatrixRec.SETFILTER("Work Time Type",FiltresWT);
        end;
        //IF (FiltresWT = '') THEN
        //CurrForm.ItemAvailMatrix.MatrixRec.SETFILTER("Work Time Type",FiltresWT);
        if (FiltresWT <> '') then
            FiltreWT := ''
        else
            FiltreWT := FiltreWTGlob;
        CurrPage.Update(false);
        SetColumns(Matrix_setwanted::Initial);
    end;

    local procedure FiltresWTOptOnAfterValidate()
    begin
        if FiltresWT <> '' then
            if FiltresWT[StrLen(FiltresWT)] <> '|' then
                FiltresWT := '';
        FiltresWT += SelectStr(FiltresWTOpt + 1, Text8003900);
        FiltresWTOpt := Filtreswtopt::" ";
        if (FiltresWT <> '') then
            FiltreWT := ''
        else
            FiltreWT := FiltreWTGlob;
        //CurrForm.ItemAvailMatrix.MatrixRec.SETFILTER("Work Time Type",FiltresWT);
        SetColumns(Matrix_setwanted::Initial);
    end;

    local procedure FiltreValideOnAfterValidate()
    begin
        CurrPage.Update(false);
        SetColumns(Matrix_setwanted::Initial);
    end;

    local procedure DateFilterOnAfterValidate()
    begin
        SetColumns(Matrix_setwanted::Initial);
    end;

    local procedure FiltreHeuresOnAfterValidate()
    begin
        if (FiltresWT <> '') then
            FiltreWT := ''
        else
            FiltreWT := FiltreWTGlob;

        rec.ClearMarks;
        rec.MarkedOnly(false);

        SetColumns(Matrix_setwanted::Initial);
    end;

    local procedure ShowColumnNameOnAfterValidate()
    begin
        SetColumns(Matrix_setwanted::Initial);
    end;
}

