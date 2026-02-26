Page 58001 "RTC Guarantee Analysis"
{
    // //PROJET GESWAY 07/07/05 Analyse des cautions

    Caption = 'RTC Guarantee Analysis';
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Bank Account";
    SourceTableView = sorting("No.")
                      where("Bank Type" = const(" "));
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            group(Option)
            {
                Caption = 'Option';
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = all;
                    Caption = 'Period';
                    OptionCaption = 'Day,Week,Month,Quarter,Year';

                    trigger OnValidate()
                    var
                        lIndex: Integer;
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
            repeater(Control800390000)
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
                field("Guarantee Celling"; rec."Guarantee Celling")
                {
                    ApplicationArea = all;
                    BlankNumbers = DontBlank;
                }
                field("BankAccount.""Guarantee in Progress"""; BankAccount."Guarantee in Progress")
                {
                    ApplicationArea = all;
                    BlankNumbers = DontBlank;
                    //blankzero = true;
                    Caption = 'Guarantees Values in Progress';

                    trigger OnDrillDown()
                    var
                        lGuaranteeEntry: Record "Guarantee Entry";
                    begin
                        lGuaranteeEntry.SetCurrentkey("Job No.", Open);
                        lGuaranteeEntry.SetRange(Open, true);
                        lGuaranteeEntry.SetRange("Bank Account No.", rec."No.");
                        //GL2024  page.RunModal(page::"Guarantee Entry", lGuaranteeEntry);
                    end;
                }
                field(Field1; ColumnValue[1])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[1];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(1);
                    end;
                }
                field(Field2; ColumnValue[2])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[2];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(2);
                    end;
                }
                field(Field3; ColumnValue[3])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[3];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(3);
                    end;
                }
                field(Field4; ColumnValue[4])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[4];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(4);
                    end;
                }
                field(Field5; ColumnValue[5])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[5];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(5);
                    end;
                }
                field(Field6; ColumnValue[6])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[6];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; ColumnValue[7])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[7];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; ColumnValue[8])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[8];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; ColumnValue[9])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[9];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; ColumnValue[10])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[10];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; ColumnValue[11])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[11];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; ColumnValue[12])
                {
                    ApplicationArea = all;
                    //blankzero = true;
                    //CaptionClass = '3,' + MatrixColumnCaptions[12];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12);
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
        BankAccount.Get(REC."No.");
        BankAccount.CalcFields("Guarantee in Progress");
        //GL2024    MATRIX_OnFindRecord('=><');  //sd
        lIndex := 0;
        while (lIndex < CurrSetLength) do begin
            lIndex += 1;
            MATRIX_OnAfterGetRecord(lIndex);
        end;
    end;

    trigger OnOpenPage()
    begin
        SetColumns(Setwanted::Initial);
    end;

    var
        PeriodType: Option Day,Week,Month,Quarter,Year;
        QtyType: Option DatetoDate,toDate;
        //gl2024 PeriodFormMgt: Codeunit 359;
        BankAccount: Record "Bank Account";
        GuaranteeInProgress: Decimal;
        ColumnValue: array[12] of Decimal;
        "---------": Integer;
        gMatrixPeriods: array[32] of Record Date;
        MatrixColumnCaptions: array[32] of Text[1024];
        ColumnSet: Text[1024];
        CurrSetLength: Integer;
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];


    procedure SetColumns(pPeriodType: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilter: Text[30];
    begin
        MatrixMgt.GeneratePeriodMatrixData(pPeriodType, ArrayLen(ColumnValue), false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, gMatrixPeriods);
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    begin
        SetDateFilter(ColumnID);
        rec.CalcFields("Guarantee in Progress");
        if rec."Guarantee in Progress" <> 0 then
            ColumnValue[ColumnID] := rec."Guarantee in Progress"
        else
            ColumnValue[ColumnID] := 0;
    end;

    local procedure SetDateFilter(ColumnID: Integer)
    begin
        if QtyType = Qtytype::DatetoDate then begin
            rec.SetRange("Due Date Filter", gMatrixPeriods[ColumnID]."Period Start", gMatrixPeriods[ColumnID]."Period End");
        end else begin
            rec.SetRange("Date Filter", 0D, gMatrixPeriods[ColumnID]."Period End");
            rec.SetFilter("Due Date Filter", '%1..%2|%3', gMatrixPeriods[ColumnID]."Period Start", 99991231D, 0D);
        end;
    end;


    procedure MatrixOnDrillDown(ColumnID: Integer)
    var
        lGuaranteeEntries: Record "Guarantee Entry";
    begin
        SetDateFilter(ColumnID);
        lGuaranteeEntries.SetCurrentkey("Job No.", Open, "Bank Account No.", "Closed Date", "Posting Date");
        lGuaranteeEntries.SetRange("Bank Account No.", rec."No.");
        lGuaranteeEntries.SetRange(Open, true);
        lGuaranteeEntries.SetFilter("Posting Date", rec.GetFilter("Date Filter"));
        lGuaranteeEntries.SetFilter("Closed Date", rec.GetFilter("Due Date Filter"));
        PAGE.Run(0, lGuaranteeEntries);
    end;


    procedure "---"()
    begin
    end;

    /*GL2024  local procedure MATRIX_OnFindRecord(Which: Text[1024]): Boolean
      var
          lMatrixRecord: Record Date;
      begin
          exit(PeriodFormMgt.FindDate(Which, lMatrixRecord, PeriodType));
      end;*/
}

