Page 58029 "RTC Planning Assign Matrix"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Planning Line";
    SourceTableView = sorting("Project Header No.", "WBS Code");
    Caption = 'RTC Planning Assign Matrix';
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(gOption; gOption)
                {
                    ApplicationArea = all;
                    Caption = 'Assignment type';
                    OptionCaption = 'Resource,Resource Group,Skill';

                    trigger OnValidate()
                    begin
                        gInitTempTable(gFullShow);
                        gOptionOnAfterValidate;
                    end;
                }
                field(gFullShow; gFullShow)
                {
                    ApplicationArea = all;
                    Caption = 'Show All';

                    trigger OnValidate()
                    begin
                        gFullShowOnPush;
                    end;
                }
                field(gFilter; gFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Filter';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lFilterHeader: Record "Filter Header";
                    begin
                        if gOption = Goption::Resource then
                            lFilterHeader.SetRange(lFilterHeader."Table ID", Database::Resource)
                        else
                            lFilterHeader.SetRange(lFilterHeader."Table ID", Database::"Resource Group");

                        if PAGE.RunModal(0, lFilterHeader) = Action::LookupOK then
                            gFilter := lFilterHeader.Code;
                        gInitTempTable(gFullShow);
                        CurrPage.Update(false);
                    end;

                    trigger OnValidate()
                    var
                        lFilterHeader: Record "Filter Header";
                    begin
                        if gFilter <> '' then begin
                            if gOption = Goption::Resource then
                                lFilterHeader.Get(Database::Resource, gFilter)
                            else
                                lFilterHeader.Get(Database::"Resource Group", gFilter);
                        end;
                        gFilterOnAfterValidate;
                    end;
                }
            }
            group(Option)
            {
                Caption = 'Option';
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
            }
            repeater(Lists)
            {
                ShowCaption = false;
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(WorkLoad; gDuration)
                {
                    ApplicationArea = all;
                    Caption = 'Work Load (h)';
                    Editable = false;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[1];
                    Editable = Field1Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(1);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(1);
                    end;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[2];
                    Editable = Field2Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(2);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(2);
                    end;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[3];
                    Editable = Field3Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(3);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(3);
                    end;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[4];
                    Editable = Field4Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(4);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(4);
                    end;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[5];
                    Editable = Field5Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(5);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(5);
                    end;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[6];
                    Editable = Field6Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(6);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(6);
                    end;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[7];
                    Editable = Field7Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(7);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(7);
                    end;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[8];
                    Editable = Field8Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(8);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(8);
                    end;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[9];
                    Editable = Field9Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(9);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(9);
                    end;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[10];
                    Editable = Field10Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(10);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(10);
                    end;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[11];
                    Editable = Field11Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(11);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(11);
                    end;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[12];
                    Editable = Field12Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(12);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(12);
                    end;
                }
                field(Field13; ColumnValue[13])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[13];
                    Editable = Field13Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(13);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(13);
                    end;
                }
                field(Field14; ColumnValue[14])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[14];
                    Editable = Field14Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(14);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(14);
                    end;
                }
                field(Field15; ColumnValue[15])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[15];
                    Editable = Field15Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(15);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(15);
                    end;
                }
                field(Field16; ColumnValue[16])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[16];
                    Editable = Field16Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(16);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(16);
                    end;
                }
                field(Field17; ColumnValue[17])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[17];
                    Editable = Field17Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(17);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(17);
                    end;
                }
                field(Field18; ColumnValue[18])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[18];
                    Editable = Field18Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(18);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(18);
                    end;
                }
                field(Field19; ColumnValue[19])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[19];
                    Editable = Field19Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(19);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(19);
                    end;
                }
                field(Field20; ColumnValue[20])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[20];
                    Editable = Field20Editable;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        MATRIX_OnLookUp(20);
                    end;

                    trigger OnValidate()
                    begin
                        MATRIX_OnValidate(20);
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
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    MATRIX_SetColumns(Matrix_setwanted::Previous);
                    MATRIX_RefreshData();
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = all;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Column';

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    MATRIX_SetColumns(Matrix_setwanted::PreviousColumn);
                    MATRIX_RefreshData();
                end;
            }
            action("Next Column")
            {
                ApplicationArea = all;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Column';

                trigger OnAction()
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    MATRIX_SetColumns(Matrix_setwanted::NextColumn);
                    MATRIX_RefreshData();
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
                var
                    MATRIX_Step: Option Initial,Previous,Same,Next;
                begin
                    MATRIX_SetColumns(Matrix_setwanted::Next);
                    MATRIX_RefreshData();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lWBSMgt: Codeunit "WBS Management";
    begin
        REC.CalcFields("Work Load (h)");
        if REC.Type = REC.Type::"Group Task" then begin
            REC.SetFilter("WBS Code Filter", lWBSMgt.gGetFilter(Rec));
            REC.CalcFields("Work Load Totaling (h)");
            REC."Work Load (h)" := REC."Work Load Totaling (h)";
        end;
        gDuration := REC."Work Load (h)" * 3600000;
        MATRIX_RefreshData();
        OnAfterGetCurrRecord;
        DescriptionOnFormat;
        gDurationOnFormat;
        ColumnValue1OnFormat;
        ColumnValue2OnFormat;
        ColumnValue3OnFormat;
        ColumnValue4OnFormat;
        ColumnValue5OnFormat;
        ColumnValue6OnFormat;
        ColumnValue7OnFormat;
        ColumnValue8OnFormat;
        ColumnValue9OnFormat;
        ColumnValue10OnFormat;
        ColumnValue11OnFormat;
        ColumnValue12OnFormat;
        ColumnValue13OnFormat;
        ColumnValue14OnFormat;
        ColumnValue15OnFormat;
        ColumnValue16OnFormat;
        ColumnValue17OnFormat;
        ColumnValue18OnFormat;
        ColumnValue19OnFormat;
        ColumnValue20OnFormat;
    end;

    trigger OnInit()
    begin
        Field20Editable := true;
        Field19Editable := true;
        Field18Editable := true;
        Field17Editable := true;
        Field16Editable := true;
        Field15Editable := true;
        Field14Editable := true;
        Field13Editable := true;
        Field12Editable := true;
        Field11Editable := true;
        Field10Editable := true;
        Field9Editable := true;
        Field8Editable := true;
        Field7Editable := true;
        Field6Editable := true;
        Field5Editable := true;
        Field4Editable := true;
        Field3Editable := true;
        Field2Editable := true;
        Field1Editable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    var
        lPlanHeader: Record "Planning Header";
        lEditable: Boolean;
    begin
        gFullShow := true;
        gInitTempTable(gFullShow);

        if lPlanHeader.Get(REC."Project Header No.") then begin
            lEditable := lPlanHeader.Status = lPlanHeader.Status::Open;
            Field1Editable := lEditable;
            Field2Editable := lEditable;
            Field3Editable := lEditable;
            Field4Editable := lEditable;
            Field5Editable := lEditable;
            Field6Editable := lEditable;
            Field7Editable := lEditable;
            Field8Editable := lEditable;
            Field9Editable := lEditable;
            Field10Editable := lEditable;
            Field11Editable := lEditable;
            Field12Editable := lEditable;
            Field13Editable := lEditable;
            Field14Editable := lEditable;
            Field15Editable := lEditable;
            Field16Editable := lEditable;
            Field17Editable := lEditable;
            Field18Editable := lEditable;
            Field19Editable := lEditable;
            Field20Editable := lEditable;
        end;
    end;

    var
        gQuantity: Decimal;
        gDescription: Text[50];
        gOption: Option Resource,"Resource Group";
        gxOption: Option Resource,"Resource Group";
        gTempTable: Record Resource temporary;
        gFullShow: Boolean;
        gxFullShow: Boolean;
        gDuration: Duration;
        gFilter: Code[20];
        "---": InStream;
        ColumnValue: array[20] of Integer;
        MatrixColumnCaptions: array[20] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        gPeriodIndex: Integer;
        PeriodType: Option;
        MatrixRecordRef: RecordRef;
        MatrixRecord: Record Resource temporary;
        MatrixRecords: array[20] of Record Resource temporary;
        MatrixCaptionFieldNo: Integer;
        "----": Integer;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Text[1024];
        [InDataSet]
        Field1Editable: Boolean;
        [InDataSet]
        Field2Editable: Boolean;
        [InDataSet]
        Field3Editable: Boolean;
        [InDataSet]
        Field4Editable: Boolean;
        [InDataSet]
        Field5Editable: Boolean;
        [InDataSet]
        Field6Editable: Boolean;
        [InDataSet]
        Field7Editable: Boolean;
        [InDataSet]
        Field8Editable: Boolean;
        [InDataSet]
        Field9Editable: Boolean;
        [InDataSet]
        Field10Editable: Boolean;
        [InDataSet]
        Field11Editable: Boolean;
        [InDataSet]
        Field12Editable: Boolean;
        [InDataSet]
        Field13Editable: Boolean;
        [InDataSet]
        Field14Editable: Boolean;
        [InDataSet]
        Field15Editable: Boolean;
        [InDataSet]
        Field16Editable: Boolean;
        [InDataSet]
        Field17Editable: Boolean;
        [InDataSet]
        Field18Editable: Boolean;
        [InDataSet]
        Field19Editable: Boolean;
        [InDataSet]
        Field20Editable: Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        WorkLoadEmphasize: Boolean;
        [InDataSet]
        Field1Emphasize: Boolean;
        [InDataSet]
        Field2Emphasize: Boolean;
        [InDataSet]
        Field3Emphasize: Boolean;
        [InDataSet]
        Field4Emphasize: Boolean;
        [InDataSet]
        Field5Emphasize: Boolean;
        [InDataSet]
        Field6Emphasize: Boolean;
        [InDataSet]
        Field7Emphasize: Boolean;
        [InDataSet]
        Field8Emphasize: Boolean;
        [InDataSet]
        Field9Emphasize: Boolean;
        [InDataSet]
        Field10Emphasize: Boolean;
        [InDataSet]
        Field11Emphasize: Boolean;
        [InDataSet]
        Field12Emphasize: Boolean;
        [InDataSet]
        Field13Emphasize: Boolean;
        [InDataSet]
        Field14Emphasize: Boolean;
        [InDataSet]
        Field15Emphasize: Boolean;
        [InDataSet]
        Field16Emphasize: Boolean;
        [InDataSet]
        Field17Emphasize: Boolean;
        [InDataSet]
        Field18Emphasize: Boolean;
        [InDataSet]
        Field19Emphasize: Boolean;
        [InDataSet]
        Field20Emphasize: Boolean;


    procedure fGetQuantity(pRec: Record "Planning Line"; pMatrixRec: Record Resource) return: Decimal
    var
        lTaskAssignment: Record "Planning Task Assignment";
    begin
        with pRec do begin
            lTaskAssignment.SetRange("Project Header No.", "Project Header No.");
            lTaskAssignment.SetRange("Task No.", "Task No.");
            lTaskAssignment.SetRange(Type, gOption);
            lTaskAssignment.SetRange("No.", pMatrixRec."No.");
            if lTaskAssignment.FindFirst and (pMatrixRec."No." <> '') then
                return := lTaskAssignment.Quantity
            else
                return := 0;
        end
    end;


    procedure fSetQuantity(pRec: Record "Planning Line"; pNo: Code[20]; pValue: Decimal)
    var
        lTaskAssignment: Record "Planning Task Assignment";
        lRec: Record "Planning Line";
    begin
        with pRec do begin
            if Type = Type::"Group Task" then begin
                lRec.SetCurrentkey("Attached To Task No.");
                lRec.SetRange("Project Header No.", "Project Header No.");
                lRec.SetRange("Attached To Task No.", "Task No.");
                if lRec.FindSet then
                    repeat
                        fSetQuantity(lRec, pNo, pValue);
                    until lRec.Next = 0;
            end else begin
                lTaskAssignment.SetRange("Project Header No.", "Project Header No.");
                lTaskAssignment.SetRange("Task No.", "Task No.");
                lTaskAssignment.SetRange(Type, gOption);
                lTaskAssignment.SetRange("No.", pNo);
                if pValue = 0 then begin
                    lTaskAssignment.DeleteAll;
                end else
                    if lTaskAssignment.FindFirst then begin
                        lTaskAssignment.Quantity := pValue;
                        lTaskAssignment.Modify(true);
                    end else begin
                        lTaskAssignment.Init;
                        lTaskAssignment."Project Header No." := "Project Header No.";
                        lTaskAssignment."Task No." := "Task No.";
                        lTaskAssignment.Type := gOption;
                        lTaskAssignment."No." := pNo;
                        lTaskAssignment.Quantity := pValue;
                        lTaskAssignment.Insert(true);
                    end;
            end;
        end
    end;


    procedure gInitTempTable(pFull: Boolean)
    var
        lRes: Record Resource;
        lResGP: Record "Resource Group";
        lSkill: Record "Planning Skill";
        lFilterHeader: Record "Filter Header";
    begin
        if gOption <> gxOption then
            gFilter := '';
        gTempTable.DeleteAll;
        case gOption of
            Goption::Resource:
                begin
                    if lFilterHeader.Get(Database::Resource, gFilter) then
                        lRes.SetView(lFilterHeader.Get_View)
                    else
                        lRes.SetRange(Type, lRes.Type::Person, lRes.Type::Machine);
                    if lRes.FindSet(false, false) then
                        repeat
                            gTempTable."No." := lRes."No.";
                            gTempTable.Name := lRes.Name;
                            if fInitInsert(Rec, gTempTable, pFull) then
                                gTempTable.Insert;
                        until lRes.Next = 0;
                end;
            Goption::"Resource Group":
                begin
                    if lFilterHeader.Get(Database::"Resource Group", gFilter) then
                        lResGP.SetView(lFilterHeader.Get_View)
                    else
                        lResGP.SetRange(Type, lResGP.Type::Person, lResGP.Type::Machine);
                    if lResGP.FindSet(false, false) then
                        repeat
                            gTempTable."No." := lResGP."No.";
                            gTempTable.Name := lResGP.Name;
                            if fInitInsert(Rec, gTempTable, pFull) then
                                gTempTable.Insert;
                        until lResGP.Next = 0;
                end;
        end;
        if Rec.FindFirst then;
        if gTempTable.FindSet then;
        gTempTable.Init;

        MATRIX_SetColumns(Matrix_setwanted::Initial);
        MATRIX_RefreshData();
    end;


    procedure fInitInsert(pRec: Record "Planning Line"; pMatrixRec: Record Resource; pFull: Boolean) return: Boolean
    var
        lTaskAssignment: Record "Planning Task Assignment";
    begin
        if pFull then
            exit(true);

        with pRec do begin
            lTaskAssignment.SetRange("Project Header No.", "Project Header No.");
            lTaskAssignment.SetRange(Type, gOption);
            lTaskAssignment.SetRange("No.", pMatrixRec."No.");
            exit(not lTaskAssignment.IsEmpty);
        end;
    end;


    procedure gSetOptionShowing(pOption: Option Resource,"Resource Group",Skill)
    begin
        gOption := pOption;
    end;


    procedure "--"()
    begin
    end;


    procedure MATRIX_SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        Clear(MATRIX_CaptionSet);
        for lIndex := 1 to ArrayLen(MatrixRecords) do
            MatrixRecords[lIndex].Init;

        MatrixRecordRef.GetTable(gTempTable);
        MatrixRecordRef.SetTable(gTempTable);

        MatrixCaptionFieldNo := MatrixRecord.FieldNo("No.");

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, pPeriodType, ArrayLen(MatrixRecords), MatrixCaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CurrSetLength > 0 then begin
            lIndex := 1;
            gTempTable.SetPosition(MATRIX_PKFirstRecInCurrSet);
            gTempTable.FindSet;
            repeat
                MatrixRecords[lIndex].Copy(gTempTable);
                MATRIX_CaptionSet[lIndex] := MatrixRecords[lIndex].Name;
                //SetFilterSubForm(lIndex);
                lIndex += +1;
            until (lIndex > MATRIX_CurrSetLength) or (gTempTable.Next <> 1);
        end;
    end;

    local procedure MATRIX_OnAfterGetRecord(pColumnID: Integer)
    begin
        ColumnValue[pColumnID] := fGetQuantity(Rec, MatrixRecords[pColumnID]);
    end;


    procedure MATRIX_OnDrillDown(ColumnID: Integer)
    var
        lTaskResGrpAssign: Record "Planning Task Res. Grp. Assign";
    begin
        if gOption = Goption::"Resource Group" then begin
            lTaskResGrpAssign.SetRange("Project Header No.", REC."Project Header No.");
            lTaskResGrpAssign.SetRange("Task No.", REC."Task No.");
            lTaskResGrpAssign.SetRange("Resource Group No.", MatrixRecords[ColumnID]."No.");
            //GL2024   if PAGE.RunModal(PAGE::"Task Res. Grp. Assign List", lTaskResGrpAssign) = Action::LookupOK then;
        end;
    end;


    procedure MATRIX_SetPeriodIndex(pColumnID: Integer)
    begin
        gPeriodIndex := 0;
    end;


    procedure MATRIX_OnValidate(pColumnID: Integer)
    begin
        fSetQuantity(Rec, MatrixRecords[pColumnID]."No.", gQuantity);
    end;


    procedure MATRIX_OnFormat(pColumnID: Integer) return: Boolean
    var
        lTaskResGrpAssign: Record "Planning Task Res. Grp. Assign";
    begin
        if gOption = Goption::"Resource Group" then begin
            lTaskResGrpAssign.SetRange("Project Header No.", REC."Project Header No.");
            lTaskResGrpAssign.SetRange("Task No.", REC."Task No.");
            lTaskResGrpAssign.SetRange("Resource Group No.", MatrixRecords[pColumnID]."No.");
            return := not lTaskResGrpAssign.IsEmpty;
        end else
            return := false;
    end;


    procedure MATRIX_OnLookUp(pColumnID: Integer)
    var
        lTaskResGrpAssign: Record "Planning Task Res. Grp. Assign";
    begin
        if gOption = Goption::"Resource Group" then begin
            lTaskResGrpAssign.SetRange("Project Header No.", REC."Project Header No.");
            lTaskResGrpAssign.SetRange("Task No.", REC."Task No.");
            lTaskResGrpAssign.SetRange("Resource Group No.", MatrixRecords[pColumnID]."No.");
            //GL2024 if PAGE.RunModal(PAGE::"Task Res. Grp. Assign List", lTaskResGrpAssign) = Action::LookupOK then;
        end;
    end;


    procedure MATRIX_InitialiseValue(pColumnID: Integer)
    begin
        ColumnValue[pColumnID] := 0;
    end;


    procedure MATRIX_RefreshData()
    var
        lIndex: Integer;
    begin
        lIndex := 0;
        while (lIndex < MATRIX_CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
        for lIndex := MATRIX_CurrSetLength + 1 to ArrayLen(ColumnValue) do
            ColumnValue[lIndex] := 0;
    end;

    local procedure gOptionOnAfterValidate()
    begin
        CurrPage.Update(false);
    end;

    local procedure gFilterOnAfterValidate()
    begin
        gInitTempTable(gFullShow);
        CurrPage.Update(false);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        MATRIX_RefreshData();
    end;

    local procedure gFullShowOnPush()
    begin
        gInitTempTable(gFullShow);
    end;

    local procedure DescriptionOnFormat()
    var
        lFontBold: Boolean;
        lIndent: Integer;
    begin
        lFontBold := REC.Type = REC.Type::"Group Task";
        DescriptionEmphasize := lFontBold;
        if not ISSERVICETIER then
            lIndent := (REC.Indentation - 1) * 220
        else
            lIndent := REC.Indentation;

        begin
        end;
    end;

    local procedure gDurationOnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := REC.Type = REC.Type::"Group Task";
        WorkLoadEmphasize := lFontBold;
    end;

    local procedure ColumnValue1OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(1);
        Field1Emphasize := lFontBold;
    end;

    local procedure ColumnValue2OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(2);
        Field2Emphasize := lFontBold;
    end;

    local procedure ColumnValue3OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(3);
        Field3Emphasize := lFontBold;
    end;

    local procedure ColumnValue4OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(4);
        Field4Emphasize := lFontBold;
    end;

    local procedure ColumnValue5OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(5);
        Field5Emphasize := lFontBold;
    end;

    local procedure ColumnValue6OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(6);
        Field6Emphasize := lFontBold;
    end;

    local procedure ColumnValue7OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(7);
        Field7Emphasize := lFontBold;
    end;

    local procedure ColumnValue8OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(8);
        Field8Emphasize := lFontBold;
    end;

    local procedure ColumnValue9OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(9);
        Field9Emphasize := lFontBold;
    end;

    local procedure ColumnValue10OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(10);
        Field10Emphasize := lFontBold;
    end;

    local procedure ColumnValue11OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(11);
        Field11Emphasize := lFontBold;
    end;

    local procedure ColumnValue12OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(12);
        Field12Emphasize := lFontBold;
    end;

    local procedure ColumnValue13OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(13);
        Field13Emphasize := lFontBold;
    end;

    local procedure ColumnValue14OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(14);
        Field14Emphasize := lFontBold;
    end;

    local procedure ColumnValue15OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(15);
        Field15Emphasize := lFontBold;
    end;

    local procedure ColumnValue16OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(16);
        Field16Emphasize := lFontBold;
    end;

    local procedure ColumnValue17OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(17);
        Field17Emphasize := lFontBold;
    end;

    local procedure ColumnValue18OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(18);
        Field18Emphasize := lFontBold;
    end;

    local procedure ColumnValue19OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(19);
        Field19Emphasize := lFontBold;
    end;

    local procedure ColumnValue20OnFormat()
    var
        lFontBold: Boolean;
    begin
        lFontBold := MATRIX_OnFormat(20);
        Field20Emphasize := lFontBold;
    end;
}

