Page 58021 "RTC Job Status Change Matrix"
{
    // //JOB_STATUS CW 24/10/05 New

    Caption = 'RTC Job Status Change Matrix';
    DataCaptionExpression = '';
    PageType = List;
    SaveValues = true;
    SourceTable = "Job Status";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Option)
                {
                    Caption = 'Option';
                    field(ShowColumnName; ShowColumnName)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Column Name';
                    }
                }
                group("Matrix Option")
                {
                    Caption = 'Matrix Option';
                    field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                    {
                        ApplicationArea = all;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                }
            }
            repeater(Control800390007)
            {
                ShowCaption = false;
                field("Code"; REC.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; REC.Description)
                {
                    ApplicationArea = all;
                }
                field("Start Status"; REC."Start Status")
                {
                    ApplicationArea = all;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[1];
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[2];
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[3];
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[4];
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[5];
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[6];
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[7];
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[8];
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[9];
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[10];
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[11];
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[12];
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[13];
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[14];
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[15];
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[16];
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[17];
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[18];
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[19];
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[20];
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[21];
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[22];
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[23];
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[24];
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[25];
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[26];
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[27];
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[28];
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[29];
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[30];
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[31];
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[32];
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
        lIndex := 0;
        if MatrixRecord.Find('-') then
            repeat
                lIndex += 1;
                MATRIX_OnAfterGetRecord(lIndex);
            until (MatrixRecord.Next() = 0) or (lIndex = MATRIX_CurrSetLength);
    end;

    trigger OnOpenPage()
    begin
        SetColumns(Matrix_setwanted::Initial);
    end;

    var
        JobStatusMatrix: Record "Job Status Matrix";
        MatrixHeader: Text[250];
        ShowColumnName: Boolean;
        CheckMark: Boolean;
        "-------": Integer;
        gHoursQty: Decimal;
        MatrixRecord: Record "Job Status";
        MatrixRecords: array[32] of Record "Job Status";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Boolean;


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

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    var
        lRes: Record Resource;
        lResLoc: Record Resource temporary;
    begin
        Rec.SetRange("To Status Filter", MatrixRecords[ColumnID].Code);
        Rec.CalcFields("To Status Granted");
        MATRIX_CellData[ColumnID] := Rec."To Status Granted"
    end;
}

