Codeunit 8001413 "Sort Management"
{
    // #8048 AC 03/06/10
    // #7698 CW 26/11/09
    // #7483 CW 31/08/09
    // #5540 AC 18/02/08
    // //+BGW+SORT CW 31/07/04 Sort Management


    trigger OnRun()
    begin
    end;

    var
        Sort: Record Sort;
        tSortMax1: label 'Only first level of %1 is used for this report.';
        tSortMaxN: label 'Olny %1 levels of %2 are used for this report.';
        tProgress: label 'Procesing...';
        tOrderBy: label 'Order by :';
        SortKey: Record "Sort Key";
        SortField: array[5] of Record "Sort Field";
        SortMax: Integer;
        SortLevel: Integer;
        SortNewPage: Boolean;
        InputCount: array[5] of Integer;
        OutputCount: array[5] of Integer;
        DistinctCount: array[5] of Integer;
        TotalInput: Integer;
        TotalOutput: Integer;
        Progress: array[2] of BigInteger;
        ProgressDialog: Dialog;
        ProgressCount: Integer;
        ProgressEnabled: Boolean;
        tGroupTitle: label '%1 %2 ';
        tGroupTotal: label 'Total %1 %2 ';
        AccountingStartPeriod: array[20] of Date;
        gRecordRef: RecordRef;
        AddCurrFactor: Decimal;
        tPeriod: label '%1 from %2 to %3';
        tAtDate: label '%1 at %2';
        RoundingFactor: Option "None","1","1000","1000000";
        NormalFormatString: Text[50];
        tFormatAmount: label 'All amounts are in %1';
        tThousands: label '(Thousands)';
        tMillions: label '(Millions)';


    procedure InitReport(var pRecordRef: RecordRef; var pSortKey: Record "Sort Key"; pSortMax: Integer)
    begin
        pSortKey.SetRange(TableNo, pRecordRef.Number);
        pSortKey.TableNo := pRecordRef.Number;
        SortMax := pSortMax;
    end;


    procedure OpenForm(var pSortKey: Record "Sort Key")
    begin
        if pSortKey.Get(pSortKey.GetRangeMin(TableNo), pSortKey.SortKey) then;
    end;


    procedure AssistEdit(var pSortKey: Record "Sort Key")
    var
        lSortField: Record "Sort Field";
        lCount: Integer;
    begin
        /* //GL2024 NAVIBAT  if Page.RunModal(Page::"Sort Keys", pSortKey) = Action::LookupOK then begin
             lSortField.SetRange(TableNo, pSortKey.TableNo);
             lSortField.SetRange(SortKey, pSortKey.SortKey);
             with lSortField do
                 if Find('-') then
                     repeat
                         if NewPage or Header or Footer then
                             lCount += 1;
                     until Next = 0;
             if lCount > SortMax then
                 if SortMax = 1 then
                     Message(tSortMax1, SortMax)
                 else
                     Message(tSortMaxN, SortMax, lSortField.Count);
         end;*/
    end;


    procedure PreReport(var pSortKey: Record "Sort Key")
    var
        lSortField: Record "Sort Field";
        lAccountingPeriod: Record "Accounting Period";
        i: Integer;
    begin
        Sort.DateTime := CurrentDatetime;
        lSortField.SetRange(TableNo, pSortKey.TableNo);
        lSortField.SetRange(SortKey, pSortKey.SortKey);
        if lSortField.Find('-') then
            repeat
                i += 1;
                lSortField.CalcFields("Field Caption");
                SortField[i] := lSortField;
            until (lSortField.Next = 0) or (i = 5);

        i := 0;

        lAccountingPeriod.SetRange("New Fiscal Year", true);
        if lAccountingPeriod.Find('-') then
            repeat
                i += 1;
                AccountingStartPeriod[i] := lAccountingPeriod."Starting Date";
            until (i = 20) or (lAccountingPeriod.Next = 0);
    end;


    procedure SortInsert(var pRecordRef: RecordRef)
    var
        lSortField: Record "Sort Field";
    begin
        with Sort do begin
            lInitKey(pRecordRef, SortField[1], "Key 1");
            lInitKey(pRecordRef, SortField[2], "Key 2");
            lInitKey(pRecordRef, SortField[3], "Key 3");
            lInitKey(pRecordRef, SortField[4], "Key 4");
            lInitKey(pRecordRef, SortField[5], "Key 5");
            "Entry No." += 1;
            RecID := pRecordRef.RecordId;
            Insert;
        end;

        Progress[1] += 1;
        if ProgressEnabled then
            ProgressDialog.Update(1, Progress[1] * 10000 DIV ProgressCount);
    end;


    procedure lInitKey(var pRecordRef: RecordRef; var pSortField: Record "Sort Field"; var pKey: Text[30])
    begin
        if pSortField."Sort Direction" = pSortField."sort direction"::Descending then
            pKey := lGetFieldValue(pRecordRef, pSortField.FieldNo, 30, true, 1)
        else
            pKey := lGetFieldValue(pRecordRef, pSortField.FieldNo, 30, false, 1);

        if pSortField."Start Position" <> 0 then
            pKey := CopyStr(pKey, pSortField."Start Position", pSortField.Length);
    end;


    procedure ProgressInit(pProgressCount: Integer)
    begin
        ProgressDialog.Open(tProgress + '\' + '@1@@@@@@@@@@@@@@@@@@' + '\' + '@2@@@@@@@@@@@@@@@@@@');
        ProgressCount := pProgressCount;
        ProgressEnabled := true;
    end;


    procedure PreDataItem()
    begin
    end;


    procedure GroupHeader(pLevel: Integer; pCausedBy: Integer) Return: Boolean
    begin
        SortLevel := pLevel;
        Return := SortField[pLevel].Header and (pCausedBy = 10 + pLevel); // "Key 1" : FieldNo = 11, "Key 2" : FieldNo = 12...
        if pCausedBy = 10 + pLevel then begin // "Key 1" : FieldNo = 11, "Key 2" : FieldNo = 12...
            InputCount[pLevel] := 1;
            OutputCount[pLevel] := 0;
            DistinctCount[pLevel + 1] := 0;
            exit(SortField[pLevel].Header)
        end;
    end;


    procedure AfterGetRecord(var pSort: Record Sort; var pRecordRef: RecordRef)
    var
        i: Integer;
    begin
        Sort.Copy(pSort);
        Progress[2] += 1;
        if ProgressEnabled then
            ProgressDialog.Update(2, Progress[2] * 10000 DIV Progress[1]);
        for i := 1 to 5 do
            InputCount[i] += 1;
        TotalInput += 1;

        gRecordRef := pRecordRef.Duplicate;
    end;


    procedure Body(lShowOutput: Boolean): Boolean
    var
        i: Integer;
    begin
        if SortKey.SortKey = 0 then
            lShowOutput := true
        else
            case SortKey.Print of
                SortKey.Print::Always:
                    lShowOutput := true;
                SortKey.Print::Never:
                    lShowOutput := false;
                else
            end;

        if lShowOutput then begin
            for i := 1 to 5 do
                OutputCount[i] += 1;
            TotalOutput += 1;
        end;
        exit(lShowOutput);
    end;


    procedure GroupFooter(pLevel: Integer; pCausedBy: Integer): Boolean
    begin
        SortLevel := pLevel;
        if pCausedBy = 10 + pLevel then begin
            SortNewPage := SortNewPage or SortField[pLevel].NewPage;
            if OutputCount[pLevel] <> 0 then
                DistinctCount[pLevel] += 1;
            exit(SortField[pLevel].Footer);
        end;
    end;


    procedure Footer()
    begin
        SortLevel := 0;
    end;


    procedure PostDataItem()
    begin
    end;


    procedure Caption(pSortLevel: Integer): Text[250]
    var
        lSortLevel: Integer;
    begin
        if pSortLevel = 0 then
            lSortLevel := SortLevel
        else
            lSortLevel := pSortLevel;
        with SortField[lSortLevel] do
            if Header or Footer then
                exit(GetHeaderFieldCaption("Field Caption", lSortLevel));
    end;


    procedure Value(var pRecordRef: RecordRef; pSortLevel: Integer): Text[250]
    var
        lSortLevel: Integer;
    begin
        if pSortLevel = 0 then
            lSortLevel := SortLevel
        else
            lSortLevel := pSortLevel;

        if SortField[lSortLevel].Header or SortField[lSortLevel].Footer then
            if SortField[lSortLevel]."Sort Direction" = SortField[lSortLevel]."sort direction"::Descending then
                exit(lGetFieldValue(pRecordRef, SortField[lSortLevel].FieldNo, 0, true, lSortLevel))
            else
                exit(lGetFieldValue(pRecordRef, SortField[lSortLevel].FieldNo, 0, false, lSortLevel));
    end;

    local procedure lGroupText(pText: Text[250]; pSortLevel: Integer): Text[250]
    var
        lField: Record "Field";
        lAccountingPeriod: Record "Accounting Period";
        lFieldRef: FieldRef;
        lSortLevel: Integer;
        lDescription: Text[250];
        lValue: Text[250];
        lDate: Date;
        tWeek: label 'On Week';
        tMonth: label 'On Month';
        tQuarter: label 'On Quarter';
        tYear: label 'On Year';
        taccountingPeriod: label 'On Accounting Period';
        i: Integer;
        lRelation: Integer;
    begin
        if pSortLevel = 0 then
            lSortLevel := SortLevel
        else
            lSortLevel := pSortLevel;
        if SortField[lSortLevel].Header or SortField[lSortLevel].Footer then begin
            case lSortLevel of
                1:
                    lValue := Sort."Key 1";
                2:
                    lValue := Sort."Key 2";
                3:
                    lValue := Sort."Key 3";
                4:
                    lValue := Sort."Key 4";
                5:
                    lValue := Sort."Key 5";
            end;
            //EXIT(STRSUBSTNO(pText,lSortLevel,SortField[lSortLevel])); //??
            lFieldRef := gRecordRef.Field(SortField[lSortLevel].FieldNo);
            lField.Get(gRecordRef.Number, lFieldRef.Number);
            Evaluate(lField.Type, Format(lFieldRef.Type));
            case lField.Type of
                lField.Type::Text, lField.Type::Code:
                    if lFieldRef.Relation = 0 then
                        exit(StrSubstNo(pText, Caption(lSortLevel), lValue, ''))
                    else begin
                        lDescription := GroupDescription(SortField[lSortLevel], lField, lValue, lFieldRef);
                        exit(StrSubstNo(pText, Caption(lSortLevel), lValue, lDescription));
                    end;
                lField.Type::Date:
                    case SortField[lSortLevel].Periodicity of
                        SortField[lSortLevel].Periodicity::" ":
                            exit(StrSubstNo(pText, Caption(lSortLevel), '', Format(lFieldRef.Value)));
                        SortField[lSortLevel].Periodicity::Week:
                            exit(StrSubstNo(pText, Caption(lSortLevel), tWeek, Format(lFieldRef.Value, 0, ' <Week>') + ' (' + Format(lFieldRef.Value) + ')'));
                        SortField[lSortLevel].Periodicity::Month:
                            exit(StrSubstNo(pText, Caption(lSortLevel), tMonth, Format(lFieldRef.Value, 0, ' <Month>-<Year4>')));
                        SortField[lSortLevel].Periodicity::Quarter:
                            exit(StrSubstNo(pText, Caption(lSortLevel), tQuarter, Format(lFieldRef.Value, 0, ' <Quarter>-<Year4>')));
                        SortField[lSortLevel].Periodicity::Year:
                            exit(StrSubstNo(pText, Caption(lSortLevel), tYear, Format(lFieldRef.Value, 0, ' <Year4>')));
                        SortField[lSortLevel].Periodicity::"Accounting Period":
                            begin
                                lDate := lFieldRef.Value;
                                lAccountingPeriod.SetRange("New Fiscal Year", true);
                                lAccountingPeriod.SetRange("Starting Date", 0D, lDate);
                                lAccountingPeriod.Find('+');
                                exit(StrSubstNo(pText, Caption(lSortLevel), taccountingPeriod, Format(lAccountingPeriod."Starting Date", 0,
                                  Format(lAccountingPeriod."Starting Date", 0, '<Day,2><Month,2><Year4>')) + ' ' + lAccountingPeriod.Name));
                            end;
                    end;
                lField.Type::Option:
                    begin
                        i := lFieldRef.Value; // Option rank
                        exit(StrSubstNo(pText, Caption(lSortLevel), SelectStr(i + 1, lFieldRef.OptionCaption), ''));
                    end;
                else
                    exit(StrSubstNo(pText, Caption(lSortLevel), lValue, ''));
            end;
        end;
    end;


    procedure GroupDescription(var pSortField: Record "Sort Field"; var pField: Record "Field"; pValue: Text[30]; var pFieldRef: FieldRef): Text[250]
    var
        lRecordRef: RecordRef;
        lFieldRef: array[3] of FieldRef;
        i: Integer;
        lField: Record "Field";
    begin
        case pFieldRef.Relation of
            0:
                exit('');
            Database::Code,
            8004222:
                begin //DATABASE::"Workflow Document Code":BEGIN
                      //    lRecordRef.OPEN(pField.RelationTableNo);
                    lRecordRef.Open(pFieldRef.Relation);
                    lFieldRef[1] := lRecordRef.FieldIndex(1);
                    lFieldRef[1].SetRange(pSortField.TableNo);
                    lFieldRef[2] := lRecordRef.FieldIndex(2);
                    lFieldRef[2].SetRange(pSortField.FieldNo);
                    lFieldRef[3] := lRecordRef.FieldIndex(3);
                    lFieldRef[3].SetRange(pValue);
                    if not lRecordRef.Find('-') then
                        exit('');
                end;
            else begin
                lRecordRef.Open(pFieldRef.Relation);
                lFieldRef[1] := lRecordRef.FieldIndex(1);
                Evaluate(lField.Type, Format(lFieldRef[1].Type));
                if lField.Type = pField.Type::Code then begin
                    lFieldRef[1].SetRange(pValue);
                    if not lRecordRef.Find('-') then
                        exit('');
                end;
            end;
        end;

        i := 1;
        while (i <= lRecordRef.FieldCount) do begin
            lFieldRef[1] := lRecordRef.FieldIndex(i);
            if lFieldRef[1].Name in ['Description', 'Name', 'City'] then
                exit(lFieldRef[1].Value);
            i += 1;
        end;
    end;


    procedure GroupTitle(pSortLevel: Integer): Text[250]
    begin
        exit(lGroupText(tGroupTitle, pSortLevel));
    end;


    procedure GroupTotal(pSortLevel: Integer): Text[250]
    begin
        exit(lGroupText(tGroupTotal, pSortLevel));
    end;


    procedure "Count"(pSortLevel: Integer): Integer
    begin
        if SortLevel = 0 then
            exit(TotalInput)
        else
            if pSortLevel = 0 then
                exit(InputCount[SortLevel])
            else
                exit(InputCount[pSortLevel]);
    end;


    procedure CountOutput(pSortLevel: Integer): Integer
    begin
        if SortLevel = 0 then
            exit(TotalOutput)
        else
            if pSortLevel = 0 then
                exit(OutputCount[SortLevel])
            else
                exit(OutputCount[pSortLevel]);
    end;


    procedure Distinct(pLevel: Integer): Integer
    begin
        exit(DistinctCount[pLevel]);
    end;


    procedure NewPage() Return: Boolean
    begin
        Return := SortNewPage;
        SortNewPage := false;
    end;


    procedure PostReport()
    begin
        Sort.SetRange(DateTime, Sort.DateTime);
        Sort.DeleteAll;

        if ProgressEnabled then
            ProgressDialog.Close;
    end;

    local procedure lGetFieldValue(var pRecordRef: RecordRef; pFieldNo: Integer; pLen: Integer; pDescending: Boolean; pSortlevel: Integer): Text[250]
    var
        lField: Record "Field";
        lFieldRef: FieldRef;
        lOptionNum: Integer;
        lDecimal: Decimal;
        lDate: Date;
        i: Integer;
    begin
        if pFieldNo = 0 then
            exit;
        lFieldRef := pRecordRef.Field(pFieldNo);
        Evaluate(lField.Class, Format(lFieldRef.CLASS));
        if lField.Class = lField.Class::FlowField then
            lFieldRef.CalcField;

        Evaluate(lField.Type, Format(lFieldRef.Type));
        case lField.Type of

            lField.Type::Decimal:
                begin
                    lDecimal := lFieldRef.Value;
                    if pDescending then
                        exit(Format((lDecimal * -1 + Power(10, 10)) * 100000, pLen, '<Integer>')) // Reverse negative & décimal
                    else
                        exit(Format((lDecimal * 100000) + Power(10, 10), pLen, '<Integer>')); // Right alignment
                end;

            lField.Type::Integer:
                begin
                    lDecimal := lFieldRef.Value;
                    if pDescending then
                        exit(Format((lDecimal + Power(10, 10)) * -1, pLen, '<Integer>'))
                    else
                        exit(Format(lDecimal + Power(10, 10), pLen, '<Integer>'));
                end;

            lField.Type::Date:
                begin
                    //#5540
                    if not Evaluate(lDate, Format(lFieldRef.Value)) then
                        lDate := 0D;
                    if lDate = 0D then
                        exit('0');
                    //#5540//
                    case SortField[pSortlevel].Periodicity of
                        SortField[pSortlevel].Periodicity::Week:
                            begin
                                lDecimal := Date2dwy(lDate, 2) + Date2dwy(lDate, 3) * 100;
                                if pDescending then begin
                                    lDecimal := -lDecimal;
                                    exit(Format((lDecimal + Power(10, 10)) * 100000, pLen, '<Integer>'));
                                end else
                                    exit(Format(lDecimal, pLen, '<Integer>'));
                            end;
                        SortField[pSortlevel].Periodicity::Month:
                            begin
                                lDecimal := Date2dmy(lDate, 2) + Date2dmy(lDate, 3) * 100;
                                if pDescending then begin
                                    lDecimal := 1000000 - lDecimal;
                                    exit(Format(lDecimal, pLen, '<Integer>'));
                                end else
                                    exit(Format(lDecimal, pLen, '<Integer>'));
                            end;
                        SortField[pSortlevel].Periodicity::Quarter:
                            begin
                                if pDescending then begin
                                    lDate := CalcDate('<-CQ>', lDate);
                                    lDecimal := ((19000101D - lDate) + 8001450000.0) * -1;
                                    exit(Format(lDecimal, pLen, '<Integer>'));
                                end else
                                    exit(Format(lDate, pLen, '<Year4><Quarter>'));
                            end;
                        SortField[pSortlevel].Periodicity::Year:
                            begin
                                lDecimal := Date2dmy(lDate, 3);
                                if pDescending then begin
                                    lDecimal := 10000 - lDecimal;
                                    exit(Format(lDecimal, pLen, '<Integer>'));
                                end else
                                    exit(Format(lDecimal, pLen, '<Integer>'));
                            end;
                        SortField[pSortlevel].Periodicity::"Accounting Period":
                            begin
                                if pDescending then begin
                                    repeat
                                        i += 1
                                    until (lDate < AccountingStartPeriod[i]) or (i = 20) or (AccountingStartPeriod[i] = 0D);
                                    exit(Format(21 - i, pLen, '<Integer>'));
                                end else begin
                                    repeat
                                        i += 1
                                    until (lDate < AccountingStartPeriod[i]) or (i = 20) or (AccountingStartPeriod[i] = 0D);
                                    exit(Format(i - 1, pLen, '<Integer>'));
                                end;
                            end;
                        else begin
                            if pDescending then begin
                                lDecimal := 99991231D - lDate;
                                exit(Format(lDecimal, pLen, '<Integer>'));
                            end else
                                exit(Format(lDate, pLen, '<Year4><Month,2><Day,2>'));
                        end;
                    end;

                end;
            else begin
                if (pLen = 0) and (lField.Type = lField.Type::Option) then begin
                    lOptionNum := lFieldRef.Value;
                    exit(SelectStr(lOptionNum + 1, lFieldRef.OptionCaption))
                end else
                    exit(CopyStr(Format(lFieldRef.Value), 1, pLen));
            end;
        end;
    end;


    procedure SortFields(var pSortKey: Record "Sort Key") Return: Text[250]
    var
        lSortField: Record "Sort Field";
        lRecordRef: RecordRef;
        lText: Text[30];
        lTableNo: Integer;
        lTableFieldNo: Integer;
        lFieldRef: FieldRef;
        lSetupFieldNo: Integer;
        lCaption: Text[250];
        lCaptionClassTranslation: Record "CaptionClass Translation";
    begin
        //CLEAR(SortKey);
        if pSortKey.TableNo = 0 then
            exit;
        SortKey.Copy(pSortKey);
        if SortKey.Find then; // Get "Print"
        lRecordRef.Open(pSortKey.TableNo);
        lSortField.SetRange(TableNo, pSortKey.TableNo);
        lSortField.SetRange(SortKey, pSortKey.SortKey);

        if lSortField.Find('-') then
            repeat
                lSortField.CalcFields("Field Caption");
                if Return <> '' then
                    Return := Return + ', ';

                if lCaptionClassTranslation.GetCaption(lSortField.TableNo, lSortField.FieldNo, GlobalLanguage) then
                    lCaption := CopyStr(lCaptionClassTranslation.GetCaptionClass(GlobalLanguage,
                                StrSubstNo('%1,%2,%3', 8001400, lSortField.TableNo, lSortField.FieldNo))
                                , 1, MaxStrLen(lCaption));

                with lSortField do begin
                    if "Start Position" <> 0 then begin
                        if "Sort Direction" = "sort direction"::Descending then
                            Return := Return + lCaption + '[' + Format("Start Position") + ':' + Format(Length) + ',' + Format("Sort Direction", 4) + ']'
                        else
                            Return := Return + lCaption + '[' + Format("Start Position") + ':' + Format(Length) + ']';
                    end;
                    if Periodicity <> 0 then begin
                        if "Sort Direction" = "sort direction"::Descending then
                            Return := Return + lCaption + '[' + Format(Periodicity) + ',' + Format("Sort Direction", 4) + ']'
                        else
                            Return := Return + lCaption + '[' + Format(Periodicity) + ']';
                    end
                    else begin
                        if "Sort Direction" = "sort direction"::Descending then
                            Return := Return + lCaption + '[' + Format("Sort Direction", 4) + ']'
                        else
                            Return := Return + lCaption;
                    end;
                end;
            until lSortField.Next = 0;
    end;


    procedure OrderBy(var pSortKey: Record "Sort Key") Return: Text[250]
    var
        lSortField: Record "Sort Field";
        lRecordRef: RecordRef;
    begin
        exit(tOrderBy + SortFields(pSortKey));
    end;


    procedure Rate(pNumerator: Decimal; pDenominator: Decimal): Decimal
    begin
        if pDenominator <> 0 then
            exit(pNumerator / pDenominator);
    end;


    procedure Percentage(pNumerator: Decimal; pDenominator: Decimal): Decimal
    begin
        if pDenominator <> 0 then
            exit(pNumerator / pDenominator * 100);
    end;


    procedure GetHeaderFieldCaption(var pCaption: Text[30]; pLevel: Integer): Text[250]
    var
        lText: Text[30];
        lTableNo: Integer;
        lTableFieldNo: Integer;
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
        lSetupFieldNo: Integer;
    //GL2024 NAVIBAT   FieldSelection: Page 8001437;
    begin
        with SortField[pLevel] do begin
            lText := Format(TableNo) + '.' + Format(FieldNo);
            //GL2024 NAVIBAT      FieldSelection.InitRequest(lText);
            //GL2024 NAVIBAT     lText := CopyStr(FieldSelection.GetFieldCaption, 1, MaxStrLen(pCaption));
            if "Start Position" <> 0 then
                exit(lText + '[' + Format("Start Position") + ':' + Format(Length) + ']')
            else
                exit(lText);
        end;
    end;


    procedure ReportCaption(pObjectID: Text[250]): Text[250]
    begin
        exit(CopyStr(pObjectID, 8)); // Avoid 'Report '
    end;


    procedure ReportCaptionPeriod(pObjectID: Text[250]; pDateFilter: Text[250]) Return: Text[250]
    var
        lDate: Record Date;
    begin
        if CopyStr(pObjectID, 1, 7) = 'Report ' then
            Return := CopyStr(pObjectID, 8)
        else
            Return := pObjectID;
        if pDateFilter <> '' then begin
            lDate.SetRange("Period Type", lDate."period type"::Date);
            lDate.SetFilter("Period Start", pDateFilter);
            if lDate.GetRangeMin("Period Start") = 0D then
                Return := StrSubstNo(tAtDate, Return, lDate.GetRangemax("Period Start"))
            else
                Return := StrSubstNo(tPeriod, Return, lDate.GetRangeMin("Period Start"), lDate.GetRangemax("Period Start"));
        end;
    end;


    procedure SetFormat(pUseAddCurrency: Boolean; pDate: Date; pRoundingFactor: Integer) Return: Text[80]
    var
        lGLSetup: Record "General Ledger Setup";
        lCurrExchRate: Record "Currency Exchange Rate";
        lFormat1: label '<Precision,';
        lFormat2: label '><Standard Format,0>';
    begin
        lGLSetup.Get;
        AddCurrFactor := 1;

        if (RoundingFactor in [Roundingfactor::None, Roundingfactor::"1"]) and not pUseAddCurrency and (lGLSetup."LCY Code" = '') then
            exit('');
        if pUseAddCurrency then begin
            lGLSetup.TestField("Additional Reporting Currency");
            Return := StrSubstNo(tFormatAmount, lGLSetup."Additional Reporting Currency");
            if pDate = 0D then
                AddCurrFactor := lCurrExchRate.ExchangeRate(WorkDate, lGLSetup."Additional Reporting Currency")
            else
                AddCurrFactor := lCurrExchRate.ExchangeRate(pDate, lGLSetup."Additional Reporting Currency");
        end else
            Return := StrSubstNo(tFormatAmount, lGLSetup."LCY Code");

        NormalFormatString := lFormat1 + lGLSetup."Amount Decimal Places" + lFormat2;
        RoundingFactor := pRoundingFactor;
        if RoundingFactor = Roundingfactor::"1000" then
            Return := Return + ' ' + tThousands;
        if RoundingFactor = Roundingfactor::"1000000" then
            Return := Return + ' ' + tMillions;
    end;


    procedure FormatAmount(pAmount: Decimal): Text[30]
    var
        lAmount: Decimal;
        lStandardFormat: label '<Sign><Integer Thousand><Decimals,2>';
    begin
        if AddCurrFactor <> 0 then
            pAmount := pAmount * AddCurrFactor;

        if pAmount = 0 then
            exit('')
        else
            if RoundingFactor = Roundingfactor::None then
                exit(Format(pAmount, 0, NormalFormatString));

        case RoundingFactor of
            Roundingfactor::"1":
                pAmount := ROUND(pAmount, 1);
            Roundingfactor::"1000":
                pAmount := ROUND(pAmount / 1000, 0.1);
            Roundingfactor::"1000000":
                pAmount := ROUND(pAmount / 1000000, 0.1);
        end;
        if pAmount = 0 then
            exit('')
        else
            case RoundingFactor of
                Roundingfactor::"1":
                    exit(Format(pAmount));
                Roundingfactor::"1000", Roundingfactor::"1000000":
                    exit(Format(pAmount, 0, lStandardFormat));
            end;
    end;


    procedure GetAddCurrFactor(): Decimal
    begin
        if AddCurrFactor = 0 then
            exit(1)
        else
            exit(AddCurrFactor);
    end;
}

