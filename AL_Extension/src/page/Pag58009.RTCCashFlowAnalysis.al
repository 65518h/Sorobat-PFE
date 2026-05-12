Page 58009 "RTC Cash-Flow Analysis"
{
    // //+PMT+CASH_ANALYSIS CW 15/06/06 from form 159 & 355

    Caption = 'RTC Cash-Flow Analysis';
    DataCaptionExpression = '';
    PageType = List;
    SourceTable = Date;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                group(Filters)
                {
                    Caption = 'Filters';
                    field(RoundingFactor; RoundingFactor)
                    {
                        ApplicationArea = all;
                        Caption = 'Rounding Factor';
                        OptionCaption = 'None,1,1000,1000000';
                    }
                    field("GenJournalTemplate.Name"; GenJournalTemplate.Name)
                    {
                        ApplicationArea = all;
                        Caption = 'Forecast Template Name';
                        TableRelation = "Gen. Journal Template".Name where(Type = const(General));
                        Visible = false;
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
                            SetColumns(Matrix_setwanted::Initial);
                        end;
                    }
                    field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                    {
                        ApplicationArea = all;
                        Caption = 'Column Set';
                        Editable = false;
                    }
                    field(AmountType; AmountType)
                    {
                        ApplicationArea = all;
                        Caption = 'Quantity Type';
                        OptionCaption = 'Net Change,Balance at Date';
                    }
                }
            }
            repeater(Control1100287013)
            {
                ShowCaption = false;
                field("Period Start"; rec."Period Start")
                {
                    ApplicationArea = all;
                }
                field("Period Name"; rec."Period Name")
                {
                    ApplicationArea = all;
                }
                field("GLSetup.""Cust. Balances Due"""; GLSetup."Cust. Balances Due")
                {
                    ApplicationArea = all;
                    Caption = 'Cust. Balances Due';

                    trigger OnDrillDown()
                    begin
                        ShowCustEntriesDue(0);
                    end;
                }
                field("GLSetup.""Vendor Balances Due"""; GLSetup."Vendor Balances Due")
                {
                    ApplicationArea = all;
                    Caption = 'Vendor Balances Due';

                    trigger OnDrillDown()
                    begin
                        ShowVendEntriesDue(0);
                    end;
                }
                field("BankAccLedgEntry.""Amount (LCY)"""; BankAccLedgEntry."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Bank Amount (LCY)';

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue('', 0);
                    end;
                }
                field("GenJnlLine.""Amount (LCY)"""; GenJnlLine."Amount (LCY)")
                {
                    ApplicationArea = all;
                    Caption = 'Forecast';

                    trigger OnAssistEdit()
                    begin
                        ShowForecastLines(0);
                    end;
                }
                field("BankAccLedgEntry.""Amount (LCY)""+GLSetup.""Cust. Balances Due""-GLSetup.""Vendor Balances Due"""; BankAccLedgEntry."Amount (LCY)" + GLSetup."Cust. Balances Due" - GLSetup."Vendor Balances Due")
                {
                    ApplicationArea = all;
                    Caption = 'Receivables-Payables';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[1];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[1]."No.", 1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[2];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[2]."No.", 2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[3];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[3]."No.", 3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[4];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[4]."No.", 4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[5];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[5]."No.", 5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[6];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[6]."No.", 6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[7];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[7]."No.", 7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[8];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[8]."No.", 8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[9];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[9]."No.", 9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[10];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[10]."No.", 10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[11];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[11]."No.", 11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[12];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[12]."No.", 12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[13];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[13]."No.", 13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[14];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[14]."No.", 14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[15];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[15]."No.", 15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[16];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[16]."No.", 16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[17];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[17]."No.", 17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[18];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[18]."No.", 18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[19];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[19]."No.", 19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[20];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[20]."No.", 20);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[21];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[21]."No.", 21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[22];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[22]."No.", 22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[23];

                    trigger OnAssistEdit()
                    begin
                        ShowBankEntriesDue(MatrixRecords[23]."No.", 23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[24];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[24]."No.", 24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[25];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[25]."No.", 25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[26];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[26]."No.", 26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[27];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[27]."No.", 27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[28];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[28]."No.", 28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[29];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[29]."No.", 29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[30];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[30]."No.", 30);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[31];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[31]."No.", 31);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    ApplicationArea = all;
                    //CaptionClass = '3,' + MATRIX_CaptionSet[32];

                    trigger OnDrillDown()
                    begin
                        ShowBankEntriesDue(MatrixRecords[32]."No.", 32);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
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
                    SetColumns(Matrix_setwanted::NextColumn);
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
                    SetColumns(Matrix_setwanted::PreviousColumn);
                end;
            }
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
        }
    }

    trigger OnAfterGetRecord()
    var
        lAmountLCY: Decimal;
        lIndex: Integer;
    begin
        lIndex := 0;
        if MatrixRecord.Find('-') then
            repeat
                lIndex += 1;

                SetDateFilter(lIndex);
                GLSetup.CalcFields("Cust. Balances Due", "Vendor Balances Due");
                BankAccLedgEntry.SetCurrentkey("Bank Account No.", "Posting Date", "Due Date");
                BankAccLedgEntry.CalcSums("Amount (LCY)");
                if GenJournalTemplate.Name <> '' then
                    with GenJnlLine do begin
                        SetCurrentkey("Journal Template Name");
                        SetRange("Journal Template Name", GenJournalTemplate.Name);
                        if Find('-') then
                            repeat
                                lAmountLCY += "Amount (LCY)";
                            until Next = 0;
                        "Amount (LCY)" := lAmountLCY
                    end;

                MATRIX_OnAfterGetRecord(lIndex);
            until (MatrixRecord.Next() = 0) or (lIndex = MATRIX_CurrSetLength);
        GLSetupCustBalancesDueOnFormat(Format(GLSetup."Cust. Balances Due"));
        GLSetupVendorBalancesDueOnForm(Format(GLSetup."Vendor Balances Due"));
        BankAccLedgEntryAmountLCYOnFor(Format(BankAccLedgEntry."Amount (LCY)"));
        GenJnlLineAmountLCYOnFormat(Format(GenJnlLine."Amount (LCY)"));
        BankAccLedgEntryAmountLCY43GLS(Format(BankAccLedgEntry."Amount (LCY)" + GLSetup.
        "Cust. Balances Due" - GLSetup."Vendor Balances Due"));
        MATRIXCellData1OnFormat(Format(MATRIX_CellData[1]));
        MATRIXCellData2OnFormat(Format(MATRIX_CellData[2]));
        MATRIXCellData3OnFormat(Format(MATRIX_CellData[3]));
        MATRIXCellData4OnFormat(Format(MATRIX_CellData[4]));
        MATRIXCellData5OnFormat(Format(MATRIX_CellData[5]));
        MATRIXCellData6OnFormat(Format(MATRIX_CellData[6]));
        MATRIXCellData7OnFormat(Format(MATRIX_CellData[7]));
        MATRIXCellData8OnFormat(Format(MATRIX_CellData[8]));
        MATRIXCellData9OnFormat(Format(MATRIX_CellData[9]));
        MATRIXCellData10OnFormat(Format(MATRIX_CellData[10]));
        MATRIXCellData11OnFormat(Format(MATRIX_CellData[11]));
        MATRIXCellData12OnFormat(Format(MATRIX_CellData[12]));
        MATRIXCellData13OnFormat(Format(MATRIX_CellData[13]));
        MATRIXCellData14OnFormat(Format(MATRIX_CellData[14]));
        MATRIXCellData15OnFormat(Format(MATRIX_CellData[15]));
        MATRIXCellData16OnFormat(Format(MATRIX_CellData[16]));
        MATRIXCellData17OnFormat(Format(MATRIX_CellData[17]));
        MATRIXCellData18OnFormat(Format(MATRIX_CellData[18]));
        MATRIXCellData19OnFormat(Format(MATRIX_CellData[19]));
        MATRIXCellData20OnFormat(Format(MATRIX_CellData[20]));
        MATRIXCellData21OnFormat(Format(MATRIX_CellData[21]));
        MATRIXCellData22OnFormat(Format(MATRIX_CellData[22]));
        MATRIXCellData23OnFormat(Format(MATRIX_CellData[23]));
        MATRIXCellData24OnFormat(Format(MATRIX_CellData[24]));
        MATRIXCellData25OnFormat(Format(MATRIX_CellData[25]));
        MATRIXCellData26OnFormat(Format(MATRIX_CellData[26]));
        MATRIXCellData27OnFormat(Format(MATRIX_CellData[27]));
        MATRIXCellData28OnFormat(Format(MATRIX_CellData[28]));
        MATRIXCellData29OnFormat(Format(MATRIX_CellData[29]));
        MATRIXCellData30OnFormat(Format(MATRIX_CellData[30]));
        MATRIXCellData31OnFormat(Format(MATRIX_CellData[31]));
        MATRIXCellData32OnFormat(Format(MATRIX_CellData[32]));
    end;

    /*GL2024 trigger OnFindRecord(Which: Text): Boolean
     begin
         exit(PeriodFormMgt.FindDate(Which, Rec, PeriodType));
     end;

     trigger OnNextRecord(Steps: Integer): Integer
     begin
         exit(PeriodFormMgt.NextDate(Steps, Rec, PeriodType));
     end;*/

    trigger OnOpenPage()
    begin
        fInitialize();
        //SetColumns(MATRIX_SetWanted::Initial);
    end;

    var
        PeriodType: Option Day,Week,Month,Quarter,Year,Period;
        AmountType: Option "Net Change","Balance at Date";
        GLSetup: Record "General Ledger Setup";
        //GL2024 PeriodFormMgt: Codeunit 359;
        RoundingFactor: Option "None","1","1000","1000000";
        Text000: label '<Sign><Integer Thousand><Decimals,2>';
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJnlLine: Record "Gen. Journal Line";
        cRed: Integer;
        "---------": Integer;
        gHoursQty: Decimal;
        MatrixRecord: Record "Bank Account";
        MatrixRecords: array[32] of Record "Bank Account";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;
        MATRIX_CellData: array[32] of Decimal;

    local procedure SetDateFilter(pColumnID: Integer)
    begin
        if AmountType = Amounttype::"Net Change" then begin
            GLSetup.SetRange("Date Filter", rec."Period Start", rec."Period End");
            if (pColumnID <> 0) then
                MatrixRecords[pColumnID].SetRange("Due Date Filter", rec."Period Start", rec."Period End");
            BankAccLedgEntry.SetRange("Due Date", rec."Period Start", rec."Period End");
            GenJnlLine.SetRange("Due Date", rec."Period Start", rec."Period End");
        end else begin
            GLSetup.SetRange("Date Filter", 0D, rec."Period End");
            if (pColumnID <> 0) then
                MatrixRecords[pColumnID].SetRange("Due Date Filter", 0D, rec."Period End");
            BankAccLedgEntry.SetRange("Due Date", 0D, rec."Period End");
            GenJnlLine.SetRange("Due Date", 0D, rec."Period End");
        end
    end;

    local procedure ShowCustEntriesDue(pColumnID: Integer)
    var
        lCustLedgEntry: Record "Cust. Ledger Entry";
    begin
        SetDateFilter(pColumnID);
        lCustLedgEntry.SetCurrentkey(Open, "Due Date");
        lCustLedgEntry.SetRange(Open, true);
        lCustLedgEntry.SetFilter("Due Date", GLSetup.GetFilter("Date Filter"));
        PAGE.Run(0, lCustLedgEntry);
    end;

    local procedure ShowVendEntriesDue(pColumnID: Integer)
    var
        lVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        SetDateFilter(pColumnID);
        lVendLedgEntry.SetCurrentkey(Open, "Due Date");
        lVendLedgEntry.SetRange(Open, true);
        lVendLedgEntry.SetFilter("Due Date", GLSetup.GetFilter("Date Filter"));
        PAGE.Run(0, lVendLedgEntry);
    end;

    local procedure ShowBankEntriesDue(pBankAccountNo: Code[20]; pColumnID: Integer)
    var
        lBankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        SetDateFilter(pColumnID);
        lBankAccLedgEntry.SetCurrentkey("Bank Account No.", "Posting Date", "Due Date");
        if pBankAccountNo <> '' then
            lBankAccLedgEntry.SetRange("Bank Account No.", pBankAccountNo);
        lBankAccLedgEntry.SetFilter("Due Date", GLSetup.GetFilter("Date Filter"));
        PAGE.Run(0, lBankAccLedgEntry);
    end;

    local procedure ShowForecastLines(pColumnID: Integer)
    var
        lGenJnlLine: Record "Gen. Journal Line";
    begin
        GenJournalTemplate.TestField(Name);
        GenJournalTemplate.Get(GenJournalTemplate.Name);

        SetDateFilter(pColumnID);
        lGenJnlLine.SetFilter("Due Date", GLSetup.GetFilter("Date Filter"));
        PAGE.Run(GenJournalTemplate."Page ID", lGenJnlLine);
    end;

    local procedure FormatAmount(var Text: Text[250])
    var
        Amount: Decimal;
    begin
        if (Text = '') or (RoundingFactor = Roundingfactor::None) then
            exit;
        Evaluate(Amount, Text);
        case RoundingFactor of
            Roundingfactor::"1":
                Amount := ROUND(Amount, 1);
            Roundingfactor::"1000":
                Amount := ROUND(Amount / 1000, 0.1);
            Roundingfactor::"1000000":
                Amount := ROUND(Amount / 1000000, 0.1);
        end;
        if Amount = 0 then
            Text := ''
        else
            case RoundingFactor of
                Roundingfactor::"1":
                    Text := Format(Amount);
                Roundingfactor::"1000", Roundingfactor::"1000000":
                    Text := Format(Amount, 0, Text000);
            end;
    end;


    procedure fInitialize()
    begin
        cRed := 255;
        with BankAccLedgEntry do begin
            SetCurrentkey("Bank Account No.", "Posting Date", "Due Date");
            SetRange("Due Date", 0D);
            if Find('+') then
                repeat
                    "Due Date" := "Posting Date";
                    Modify;
                until Next(-1) = 0;
        end;
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

        CaptionFieldNo := MatrixRecord.FieldNo("No.");

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
        MatrixRecords[ColumnID].CalcFields("Net Change (LCY)");
        MATRIX_CellData[ColumnID] := MatrixRecords[ColumnID]."Net Change (LCY)";
    end;

    local procedure GLSetupCustBalancesDueOnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure GLSetupVendorBalancesDueOnForm(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure BankAccLedgEntryAmountLCYOnFor(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure GenJnlLineAmountLCYOnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure BankAccLedgEntryAmountLCY43GLS(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData1OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData2OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData3OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData4OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData5OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData6OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData7OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData8OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData9OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData10OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData11OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData12OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData13OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData14OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData15OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData16OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData17OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData18OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData19OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData20OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData21OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData22OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData23OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData24OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData25OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData26OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData27OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData28OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData29OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData30OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData31OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;

    local procedure MATRIXCellData32OnFormat(Text: Text[1024])
    begin
        FormatAmount(Text);
    end;
}

