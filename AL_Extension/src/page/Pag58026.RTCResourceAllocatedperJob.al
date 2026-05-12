Page 58026 "RTC Resource Allocated per Job"
{
    Caption = 'RTC Resource Allocated per Job';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = Job;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group("Filter")
                {
                    Caption = 'Filter';
                    field("Resource Filter"; REC."Resource Filter")
                    {
                        ApplicationArea = all;
                    }
                }
                group("Matrix Options")
                {
                    Caption = 'Matrix Options';
                    field(PeriodType; PeriodType)
                    {
                        ApplicationArea = all;
                        Caption = 'Period';
                        OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';

                        trigger OnValidate()
                        begin
                            SetColumns(Setwanted::Initial);
                        end;
                    }
                    field(ColumnSet; ColumnSet)
                    {
                        ApplicationArea = all;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                    field(QtyType; QtyType)
                    {
                        ApplicationArea = all;
                        Caption = 'Quantity Type';
                        OptionCaption = 'Net Change,Balance at Date';
                    }
                }
            }
            repeater(Control800390013)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field("Bill-to Name"; REC."Bill-to Name")
                {
                    ApplicationArea = all;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[1];

                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[2];

                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[3];

                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[4];

                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[5];

                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[6];

                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[7];

                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[8];

                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[9];

                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[10];

                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[11];

                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MatrixColumnCaptions[12];

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
                    SetColumns(Setwanted::Previous);
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
                begin
                    SetColumns(Setwanted::PreviousColumn);
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
                begin
                    SetColumns(Setwanted::NextColumn);
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
                    SetColumns(Setwanted::Next);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        lIndex: Integer;
    begin
        lIndex := 0;
        for lIndex := 1 to CurrSetLength do begin
            MATRIX_OnAfterGetRecord(lIndex);
        end;
    end;

    trigger OnOpenPage()
    begin
        SetColumns(Setwanted::Initial);
    end;

    var

        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        QtyType: Option "Net Change","Balance at Date";
        "-----": Integer;
        ColumnValue: array[12] of Integer;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        MatrixBoldValue: array[12] of Boolean;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if QtyType = Qtytype::"Net Change" then
            if gMatrixPeriods[pColumnID]."Period Start" = gMatrixPeriods[pColumnID]."Period End" then
                rec.SetRange("Planning Date Filter", gMatrixPeriods[pColumnID]."Period Start")
            else
                rec.SetRange("Planning Date Filter", gMatrixPeriods[pColumnID]."Period Start", gMatrixPeriods[pColumnID]."Period End")
        else
            rec.SetRange("Planning Date Filter", 0D, gMatrixPeriods[pColumnID]."Period End");
    end;


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilter: Text[30];
        lIndex: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        rec.CalcFields("Scheduled Res. Qty.");
        ColumnValue[ColumnID] := Rec."Scheduled Res. Qty.";
    end;


    procedure MatrixOnActivate(pColumnID: Integer)
    begin
        SetDateFilter(pColumnID);
    end;
}

