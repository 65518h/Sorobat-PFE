Codeunit 8001411 "MemoPad Management"
{
    // //+WKF+ AC 02/11/10
    // //+BGW+MEMOPAD CW 07/02/05 Thank's to WaldoPad (Cf. Mibuso)
    //    WaldoNavPad have to be installed and registred on each client
    // 
    // Can be extended to other comment line tables with a couple of lines :
    // 
    // 1) Add a "Separator" field (convention = 8001400) in the comment line table
    // 
    // 2) Add this source code to CommentSheet.OnOpenForm
    // 
    // LocalVar (convention ID = 800140x)
    //   lMemoPad   Codeunit   MemoPad Management
    //   lRecordRef RecordRef
    // 
    // ---+REF+MEMOPAD
    // CurrentForm.saverecord;
    // lRecordRef.GETTABLE(Rec);
    // IF lMemoPad.Edit(lRecordRef,Caption) THEN
    //   CurrForm.CLOSE;
    // ---+REF+MEMOPAD---
    // 
    // 3) If Comment field name is not "Comment" or
    //       Separator field name is not "Separator
    // 
    //      Add a case to Edit function with this template :
    //      SetCommentLine(pRecordRef,Caption,CheckLine,CommentField,SeparatorField);


    trigger OnRun()
    begin
    end;

    var
        //GL2024 Automation non compatible  WaldoNavPad: Automation ;
        tCaption: label '%1 - NotePad';
        tError: label 'No memo for table %1.';
        gCheck: Boolean;
        gLineNoField: Integer;
        gCommentField: Integer;
        gSeparatorField: Integer;
        tWarning: label 'Warning : only %1 column will be kept.\Do you want to continue?';
        tCancel: label 'Cancel';
        tOK: label 'OK';
        tChangedText: label 'The text has been modified. Are you ue to cancel?';
        tChangedTitleText: label 'Warning';
        gReadOnly: Boolean;


    procedure Edit(var pRecordRef: RecordRef; pCaption: Text[80]): Boolean
    var
        lKeyRef: KeyRef;
    begin
        //#8326
        if (ISSERVICETIER) then
            exit(false);
        //#8326//
        /*//GL2024 Automation non compatible if not Create(WaldoNavPad, false, true) then
          exit(false);*/

        case pRecordRef.Number of
            Database::"Sales Line": // 37
                lSetCommentLine(pRecordRef, pCaption, false, 11, 8001400); // Description
            Database::"Purchase Line": // 39
                lSetCommentLine(pRecordRef, pCaption, false, 11, 8001400); // Description
            Database::"Extended Text Line": // 280
                lSetCommentLine(pRecordRef, pCaption, false, 6, 8001400); // Text
            Database::Translation2: // 8001411
                lSetCommentLine(pRecordRef, pCaption, false, 5, 8001400); // Text

            //#9314   réactivé
            // //DELETE
            // //NE FAIT PAS DE BGW
            // {
            Database::"Description Line": // 8004075 : "Description Line"
                lSetCommentLine(pRecordRef, pCaption, false, 9, 8001400); // Description
                                                                          // }
                                                                          // //DELETE//
                                                                          //9314//
                                                                          //+WKF+
            Database::"Workflow Document Line": // 8004226 : "Workflow Document Line"
                lSetCommentLine(pRecordRef, pCaption, false, 6, 8001400); // Comment
                                                                          //#6656
            Database::"Workflow Comment Line": //8004211
                lSetCommentLine(pRecordRef, pCaption, false, 6, 8001400); // Comment
                                                                          //#6656//
                                                                          //+WKF+//
            else
                if not lSetDefaultCommentLine(pRecordRef, pCaption) then
                    Error(tError, pRecordRef.Number);
        end;

        /*//GL2024 Automation non compatible if not lGetMemo(pRecordRef,gCheck) then begin
           Clear(WaldoNavPad);
           exit(false);
         end;*/

        if pCaption <> '' then
            pCaption := pCaption + ' ';
        lKeyRef := pRecordRef.KeyIndex(1);
        /*  //GL2024 Automation non compatible WaldoNavPad.FormTitle := StrSubstNo(tCaption,pCaption + lCaptionFields(lKeyRef));
           WaldoNavPad.OKButtonText := tOK;
           WaldoNavPad.CancelButtonText := tCancel;
           WaldoNavPad.ChangedWarningText := tChangedText;
           WaldoNavPad.ChangedWarningTitleText := tChangedTitleText;
           WaldoNavPad.ReadonlyPane := gReadOnly;
           WaldoNavPad.FontSize := 10;
           WaldoNavPad.FontName := 'Tahoma';
           WaldoNavPad.ShowDialog;

           if WaldoNavPad.DialogResultOK then begin
             lDeleteMemo(pRecordRef)
             //#8196
             lSaveMemo(pRecordRef, false);
             //#8196//
           end;*/
        //GL2024 Automation non compatible  Clear(WaldoNavPad);
        exit(true);
    end;

    local procedure lSetCommentLine(pRecordRef: RecordRef; pCaption: Text[80]; pCheck: Boolean; pCommentField: Integer; pSeparatorField: Integer)
    var
        lFieldRef: FieldRef;
        lKeyRef: KeyRef;
    begin
        gCheck := pCheck;
        lKeyRef := pRecordRef.KeyIndex(1);
        lFieldRef := lKeyRef.FieldIndex(lKeyRef.FieldCount); // LastField of Primary Key
        gLineNoField := lFieldRef.Number;
        gCommentField := pCommentField;
        gSeparatorField := pSeparatorField;
    end;

    local procedure lSetDefaultCommentLine(var pRecordRef: RecordRef; pCaption: Text[250]): Boolean
    var
        lCommentField: Record "Field";
        lSeparatorField: Record "Field";
    begin
        lCommentField.SetRange(TableNo, pRecordRef.Number);
        lCommentField.SetRange(FieldName, 'Comment');
        if not lCommentField.Find('-') then
            exit(false);
        lSeparatorField.SetRange(TableNo, pRecordRef.Number);
        lSeparatorField.SetRange(FieldName, 'Separator');
        if not lSeparatorField.Find('-') then
            exit(false);
        lSetCommentLine(pRecordRef, pCaption, true, lCommentField."No.", lSeparatorField."No.");
        exit(true);
    end;

    local procedure lGetMemo(var pRecordRef: RecordRef; pCheck: Boolean): Boolean
    var
        lFieldRef: FieldRef;
        lComment: Text[250];
        lComment2: Text[250];
        lSeparator: Integer;
        lWarning: Boolean;
        lRecordRef: RecordRef;
    begin
        //GL2024 Automation non compatible WaldoNavPad.Text := '';
        lRecordRef := pRecordRef.Duplicate;
        with lRecordRef do begin
            if Number in [Database::"Sales Line", Database::"Purchase Line"] then begin
                lFieldRef := Field(gCommentField);
                lComment := lFieldRef.Value;
                lFieldRef := Field(gSeparatorField);
                lSeparator := lFieldRef.Value;
                lAppendMemo(lComment, lSeparator);
            end;
            if FindSet then
                repeat
                    if pCheck then
                        lWarning := lWarning or lCheckLineWarning(lRecordRef);
                    lFieldRef := Field(gCommentField);
                    lComment := lFieldRef.Value;
                    lFieldRef := Field(gSeparatorField);
                    lSeparator := lFieldRef.Value;
                    lAppendMemo(lComment, lSeparator);
                until Next = 0;
            exit(not lWarning);
        end;
    end;

    local procedure lDeleteMemo(var pRecordRef: RecordRef)
    var
        lRecordRef: RecordRef;
    begin
        lRecordRef := pRecordRef.Duplicate;
        if lRecordRef.FindSet then
            lRecordRef.DeleteAll(true);
    end;

    local procedure lSaveMemo(var pRecordRef: RecordRef; pValidate: Boolean)
    var
        lFieldRef: FieldRef;
        lLineNo: Integer;
    begin
        with pRecordRef do begin
            //GL2024 Automation non compatible        WaldoNavPad.AppendText(' ');
            if Number in [Database::"Sales Line", Database::"Purchase Line"] then begin
                lGetNextLine(pRecordRef);
                Modify;
            end;
            lFilterToValue(pRecordRef);
            lFieldRef := Field(gLineNoField);
            lLineNo := lFieldRef.Value;
            /* //GL2024 Automation non compatible while not WaldoNavPad.eos do begin
               lLineNo += 10;
               lFieldRef := Field(gLineNoField);
               lFieldRef.Value := lLineNo;
               lGetNextLine(pRecordRef);
               //#8196
               Insert(pValidate);
               //#8196//
             end;*/
        end;
    end;

    local procedure lGetNextLine(var pRecordRef: RecordRef)
    var
        lComment: Text[250];
        lSeparator: Integer;
        lFieldRef: FieldRef;
    begin
        lFieldRef := pRecordRef.Field(gCommentField);
        //GL2024 Automation non compatible  WaldoNavPad.TextFieldLength := lFieldRef.Length;
        //GL2024 Automation non compatible  WaldoNavPad.GetNextTextField(lComment,lSeparator);
        if StrLen(lComment) <> 0 then
            if lComment[StrLen(lComment)] = ' ' then
                lComment := DelStr(lComment, StrLen(lComment));
        lFieldRef.Value := lComment;
        lFieldRef := pRecordRef.Field(gSeparatorField);
        lFieldRef.Value := lSeparator - 1;
    end;

    local procedure lAppendMemo(pComment: Text[250]; pSeparator: Integer)
    var
        lChar13: Char;
        lChar10: Char;
        lSeparator: Integer;
    begin
        lChar13 := 13;
        lChar10 := 10;
        //GL2024 Automation non compatible     WaldoNavPad.AppendText(pComment);
        /* //GL2024 Automation non compatible case pSeparator + 1 of
            1:WaldoNavPad.AppendText(' ');
            2:WaldoNavPad.AppendText(Format(lChar13) + Format(lChar10));
          end;*/
    end;

    local procedure lCheckLineWarning(var pRecordRef: RecordRef): Boolean
    var
        i: Integer;
        k: Integer;
        lDate: Date;
        lDecimal: Decimal;
        lText: Text[250];
        lFieldRef: FieldRef;
        lField: Record "Field";
        lKeyRef: KeyRef;
    begin
        lKeyRef := pRecordRef.KeyIndex(1);
        with pRecordRef do begin
            i := 0;
            while i < FieldCount do begin
                i += 1;
                lFieldRef := FieldIndex(i);
                k := 1;
                while (k < lKeyRef.FieldCount) and (lKeyRef.FieldIndex(k).Number <> lFieldRef.Number) do
                    k += 1;
                if (lKeyRef.FieldIndex(k).Number <> lFieldRef.Number) and
                   (lFieldRef.Number <> gCommentField) and
                   (lFieldRef.Number <> gSeparatorField) then begin
                    Evaluate(lField.Type, Format(lFieldRef.Type));
                    case lField.Type of
                        lField.Type::Date, lField.Type::DateTime:
                            begin
                                lDate := lFieldRef.Value;
                                if lDate <> 0D then
                                    exit(true);
                            end;
                        lField.Type::Text, lField.Type::Code:
                            begin
                                lText := lFieldRef.Value;
                                if lText <> '' then
                                    exit(true);
                            end else
                                    lDecimal := lFieldRef.Value;
                                    if lDecimal <> 0 then
                                        exit(true);
                    end;
                end;
            end;
        end;
    end;

    local procedure lCaptionFields(var pKeyRef: KeyRef) Return: Text[250]
    var
        lFieldRef: FieldRef;
        lField: Record "Field";
        i: Integer;
    begin
        for i := 1 to pKeyRef.FieldCount - 1 do begin // Last field = "Line No."
            lFieldRef := pKeyRef.FieldIndex(i);
            if Return <> '' then
                Return := Return + ' ';
            Evaluate(lField.Type, Format(lFieldRef.Type));
            if lField.Type = lField.Type::Option then
                Return := Return + lGetOptionString(lFieldRef, Format(lFieldRef.Value))
            else
                Return := Return + Format(lFieldRef.Value);
        end;
    end;


    procedure fReadOnly(pReadOnly: Boolean)
    begin
        gReadOnly := pReadOnly;
    end;

    local procedure lGetOptionString(var FieldRef: FieldRef; Value: Text[250]): Text[250]
    var
        OptionIsInteger: Integer;
    begin
        if Value = '' then
            Value := '1';
        if not Evaluate(OptionIsInteger, Value) then
            exit(Value);
        OptionIsInteger := OptionIsInteger + 1;
        exit(SelectStr(OptionIsInteger, Format(FieldRef.OptionCaption)));
    end;

    local procedure lFilterToValue(var pRecordRef: RecordRef)
    var
        lFieldRef: FieldRef;
        i: Integer;
        lField: Record "Field";
        lInteger: Integer;
        lFilter: Text[50];
        lGUID: Guid;
        lDate: Date;
        lBasic: Codeunit Basic;
    begin
        pRecordRef.Init;
        for i := 1 to pRecordRef.FieldCount do begin
            lFieldRef := pRecordRef.FieldIndex(i);
            lFilter := lFieldRef.GetFilter;
            if lFilter <> '' then begin
                if lFilter[1] = '''' then
                    lFilter := DelStr(lFilter, 1, 1);
                if lFilter[StrLen(lFilter)] = '''' then
                    lFilter := DelStr(lFilter, StrLen(lFilter));
                Evaluate(lField.Type, Format(lFieldRef.Type));
                case lField.Type of
                    lField.Type::Code, lField.Type::Text:
                        lFieldRef.Value := lFilter;
                    lField.Type::Guid:
                        begin
                            Evaluate(lGUID, lFilter);
                            lFieldRef.Value := lGUID;
                        end;
                    lField.Type::Date:
                        begin
                            Evaluate(lDate, lFilter);
                            lFieldRef.Value := lDate;
                        end;
                    //#7407
                    lField.Type::Option:
                        begin
                            lFieldRef.Value := lBasic.fIndexOfOption(lFieldRef.OptionCaption, lFilter);
                        end;
                    //#7407//
                    else
                        if lField.Type <> lField.Type::Option then begin
                            Evaluate(lInteger, lFilter);
                            lFieldRef.Value := lInteger;
                        end;
                end;
            end;
        end;
    end;


    procedure EditWithValidation(var pRecordRef: RecordRef; pCaption: Text[80]): Boolean
    var
        lKeyRef: KeyRef;
    begin
        //#8326
        if (ISSERVICETIER) then
            exit(false);
        //#8326//
        //#8196
        /*//GL2024 Automation non compatible  if not Create(WaldoNavPad, false, true) then
            exit(false);*/

        case pRecordRef.Number of
            Database::"Sales Line": // 37
                lSetCommentLine(pRecordRef, pCaption, false, 11, 8001400); // Description
            Database::"Purchase Line": // 39
                lSetCommentLine(pRecordRef, pCaption, false, 11, 8001400); // Description
            Database::"Extended Text Line": // 280
                lSetCommentLine(pRecordRef, pCaption, false, 6, 8001400); // Text
            Database::Translation2: // 8001411
                lSetCommentLine(pRecordRef, pCaption, false, 5, 8001400); // Text
                                                                          //DELETE
                                                                          //NE FAIT PAS DE BGW
                                                                          /*
                                                                          //#5598
                                                                          DATABASE::"Description Line": // 8004075
                                                                            lSetCommentLine(pRecordRef,pCaption,FALSE,9,8001400); // Description
                                                                          //#5598//
                                                                          */
                                                                          //DELETE//
            Database::"Workflow Document Line": // 8004226
                lSetCommentLine(pRecordRef, pCaption, false, 6, 8001400); // Comment

            else
                if not lSetDefaultCommentLine(pRecordRef, pCaption) then
                    Error(tError, pRecordRef.Number);
        end;

        /* //GL2024 Automation non compatible if not lGetMemo(pRecordRef, gCheck) then begin
              Clear(WaldoNavPad);
              exit(false);
          end;*/

        if pCaption <> '' then
            pCaption := pCaption + ' ';
        lKeyRef := pRecordRef.KeyIndex(1);
        /* //GL2024 Automation non compatible WaldoNavPad.FormTitle := StrSubstNo(tCaption,pCaption + lCaptionFields(lKeyRef));
         WaldoNavPad.OKButtonText := tOK;
         WaldoNavPad.CancelButtonText := tCancel;
         WaldoNavPad.ChangedWarningText := tChangedText;
         WaldoNavPad.ChangedWarningTitleText := tChangedTitleText;
         WaldoNavPad.ReadonlyPane := gReadOnly;
         WaldoNavPad.FontSize := 10;
         WaldoNavPad.FontName := 'Tahoma';
         WaldoNavPad.ShowDialog;

         if WaldoNavPad.DialogResultOK then begin
           lDeleteMemo(pRecordRef);
           lSaveMemo(pRecordRef, true);
         end;
         Clear(WaldoNavPad);*/
        exit(true);
        //#8196//

    end;
}

