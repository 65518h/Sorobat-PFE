Codeunit 8003948 "Import/Export Management"
{
    // //DEVIS GESWAY 16/03/05 Gestion des lignes des import/export Devis
    // //PERF AC 03/04/06


    trigger OnRun()
    begin
    end;

    var
        ExcelBuf: Record "Excel Buffer";
        ExcelBuf2: Record "Excel Buffer";
        ExcelBufExt: Record "Excel Buffer Extended";
        SetupHeader: Record "Import/Export Setup";
        SetupLine: Record "Import/Export Setup Lines";
        UnitMeasure: Record "Unit of Measure";
        ItemUnitMeasure: Record "Item Unit of Measure";
        ExtendedTextMemo: Record "Sales Line" temporary;
        "-": Integer;
        i: Integer;
        LineCount: Integer;
        Window: Dialog;
        MarkerSeparator: Text[30];
        LastMarker: Text[30];
        PreInitLevel: Boolean;
        CurrLevel: Integer;
        LevelFieldRef: Integer;
        DescriptionMemo: Text[1024];
        SetupCode: Code[10];
        "--": Integer;
        ExcelMngt: Codeunit "Excel Management";
        PresentMgt: Codeunit "Presentation Management";
        StructureMgt: Codeunit "Structure Management";
        tErrorAttachedLine: label 'Invalide value field %1 in line %2.';
        tUnitNotExists: label 'Unit %1 does not exist.';
        tIncorrectValue: label 'Value %1 is invalid for column %2, line .';
        SubcontractingMgt: Codeunit "Subcontracting Management";
        tPrepareFile: label 'Preparing file...';
        AttachedLineNo: array[10] of Integer;
        tIncorrectLevelValue: label 'Level value in line %1 is %2. Current level is .';
        wRollBackLog: Record "RollBack Log";
        wNaviBatSetup: Record NavibatSetup;


    procedure Initialize(pSetupCode: Code[10]; pDeleteBuffer: Boolean)
    begin
        GetImportSetup(pSetupCode);
        if pDeleteBuffer then
            DeleteBuffer;
    end;


    procedure DeleteBuffer()
    begin
        ExcelBuf.Reset;
        ExcelBuf.DeleteAll;
        ExcelBufExt.Reset;
        ExcelBufExt.DeleteAll;
        ExtendedTextMemo.Reset;
        ExtendedTextMemo.DeleteAll;
    end;


    procedure GetImportSetup(pSetupCode: Code[10])
    begin
        SetupCode := pSetupCode;
        SetupHeader.Get(SetupCode);
        LevelFieldRef := 0;
        if SetupHeader."Source File Type" = SetupHeader."source file type"::Excel then begin
            SetupLine.Reset;
            SetupLine.SetRange(Code, SetupCode);
            SetupLine.SetFilter(Usage, '%1|%2', SetupLine.Usage::Both, SetupLine.Usage::Import);

            SetupLine.SetRange("Target Field No.", 8004057);
            if SetupLine.Find('-') then
                LevelFieldRef := 8004057
            else begin
                SetupLine.SetRange("Target Field No.", 5705);
                if SetupLine.Find('-') then
                    LevelFieldRef := 5705;
            end;
        end;
    end;


    procedure GetLineCount(): Integer
    begin
        exit(LineCount);
    end;


    procedure GetNextLineNo(pSalesLine: Record "Sales Line"): Integer
    var
        lSalesLine: Record "Sales Line";
    begin
        lSalesLine.SetRange("Document Type", pSalesLine."Document Type");
        lSalesLine.SetRange("Document No.", pSalesLine."Document No.");
        if lSalesLine.FindLast then
            exit(lSalesLine."Line No." + 10000)
        else
            exit(10000);
    end;


    procedure isExcludeLine(pSalesLine: Record "Sales Line"): Boolean
    var
        lRecordRef: RecordRef;
        lFieldRef: FieldRef;
    begin
        if SetupHeader."Source File Type" = SetupHeader."source file type"::Excel then begin
            lRecordRef.GetTable(pSalesLine);
            SetupLine.Reset;
            SetupLine.SetRange(Code, SetupCode);
            SetupLine.SetRange("Exclude Line", true);
            SetupLine.SetFilter(Usage, '%1|%2', SetupLine.Usage::Both, SetupLine.Usage::Import);
            if SetupLine.Find('-') then
                repeat
                    lFieldRef := lRecordRef.Field(SetupLine."Target Field No.");
                    if Format(lFieldRef.Value) = '' then
                        exit(true);
                until SetupLine.Next = 0;
        end;
        exit(false);
    end;


    procedure isNewMarker(pSalesLine: Record "Sales Line"): Boolean
    var
        lMarker: Text[30];
        lLevel: Integer;
    begin
        /***********************
        IF LastCrossRef[1] = '' THEN BEGIN
          ExtractCrossReference(pSalesLine,LastCrossRef);
          CurrLevel := 1;
          EXIT(LastCrossRef[1]<>'');
        END;
        
        lLevel := 1;
        ExtractCrossReference(pSalesLine,lCrossRef);
        WHILE (lCrossRef[lLevel+1] <> '') AND (lLevel <= ARRAYLEN(LastCrossRef)) DO
           lLevel += 1;
        COPYARRAY(LastCrossRef,lCrossRef,1,ARRAYLEN(LastCrossRef));
        IF lLevel <> CurrLevel THEN BEGIN
          CurrLevel := lLevel;
          EXIT(TRUE);
        END;
        EXIT(FALSE);
        ***********************/

        if pSalesLine."Line Type" <> pSalesLine."line type"::Totaling then
            exit(false);
        if LastMarker = '' then begin
            LastMarker := ExtractMarker(pSalesLine);
            exit(false);
        end;
        lMarker := ExtractMarker(pSalesLine);
        if LastMarker <> lMarker then begin
            LastMarker := lMarker;
            exit(true);
        end else
            exit(false);

    end;


    procedure ExtractMarker(pSalesLine: Record "Sales Line"): Text[30]
    var
        lMarker: Text[30];
        lPresentation: array[5] of Text[30];
        llevel: Integer;
    begin
        /***********************
        llevel := 1;
        WITH pSalesLine DO BEGIN
           lCrossRef := "Cross-Reference No.";
           i := STRPOS(lCrossRef,'.');
           IF i = 0 THEN
             lPresentation[llevel] := lCrossRef
           ELSE BEGIN
             lPresentation[llevel] := DELCHR(COPYSTR(lCrossRef, 1, i-1),'=',' ');
             lCrossRef := DELSTR(lCrossRef, 1, i);
             llevel += 1;
             i := STRPOS(lCrossRef,'.');
           END;
           WHILE (i > 0) AND (STRLEN(lCrossRef) > 1) AND (llevel<=ARRAYLEN(LastCrossRef)) DO BEGIN
             lPresentation[llevel] := DELCHR(COPYSTR(lCrossRef, 1, i-1),'=',' ');
             lCrossRef := DELSTR(lCrossRef, 1, i);
             llevel += 1;
             i := STRPOS(lCrossRef,'.');
           END;
           lPresentation[llevel] := lCrossRef;
        END;
        COPYARRAY(pPresentation,lPresentation,1,ARRAYLEN(LastCrossRef));
        ***********************/

        MarkerSeparator := '.+-/*,#~_';
        with pSalesLine do begin
            i := MaxStrLen(Marker);
            while (i > 1) and (not isMarkerSeparator(Marker, i)) do
                i := i - 1;
            if i > 1 then
                lMarker := CopyStr(Marker, 1, i - 1)
            else
                lMarker := Marker;
        end;
        exit(DelChr(lMarker, '=', ' '));

    end;


    procedure isMarkerSeparator(pMarker: Text[30]; pRefPos: Integer): Boolean
    var
        lPos: Integer;
        lMarker: Text[30];
    begin
        lMarker := CopyStr(pMarker, i, 1);
        for lPos := 1 to StrLen(MarkerSeparator) do
            if (lMarker = CopyStr(MarkerSeparator, lPos, 1)) then
                exit(true);
        exit(false);
    end;


    procedure MakeDescriptionField(pText: Text[1024]): Text[250]
    var
        lSalesLine: Record "Sales Line";
        lDescription: Text[250];
        lLenght: Integer;
        lLineBreak: Text[30];
        lLineCutPos: Integer;
        lLineBreakPos: Integer;
        CR: Char;
        LF: Char;
    begin
        CR := 13;
        LF := 10;
        lLineBreak := Format(LF);
        lLenght := MaxStrLen(lSalesLine.Description);

        lLineBreakPos := StrPos(pText, lLineBreak);
        if lLineBreakPos > 0 then
            if lLineBreakPos > lLenght then begin
                //#8027_
                //    lLineCutPos := SearchCutPosition(pText);
                lLineCutPos := SearchCutPosition(CopyStr(pText, 1, lLineBreakPos - 1));   ////////////
                                                                                          //#8027_//
                lDescription := CopyStr(pText, 1, lLineCutPos);
                DescriptionMemo := CopyStr(pText, lLineCutPos + 1);
            end else begin
                lDescription := CopyStr(pText, 1, lLineBreakPos - 1);
                DescriptionMemo := CopyStr(pText, lLineBreakPos + 1);
            end
        else
            if StrLen(pText) > lLenght then begin
                lLineCutPos := SearchCutPosition(pText);
                lDescription := CopyStr(pText, 1, lLineCutPos);
                DescriptionMemo := CopyStr(pText, lLineCutPos + 1);
            end else begin
                lDescription := pText;
                DescriptionMemo := '';
            end;
        exit(lDescription);
    end;


    procedure SearchCutPosition(pText: Text[1024]): Integer
    var
        lSalesLine: Record "Sales Line";
        lCut: Integer;
        lSpacePos: Integer;
    begin
        lCut := MaxStrLen(lSalesLine.Description);
        //#8027
        lSpacePos := StrPos(pText, ' ');
        if (lSpacePos <> 0) then begin
            //#8027//
            while (lCut > 1) and (CopyStr(pText, lCut, 1) <> ' ') do
                lCut := lCut - 1;
            //#8027
        end;
        //#8027//
        exit(lCut);
    end;


    procedure MemorizeExtendedText(pSalesLine: Record "Sales Line")
    var
        lDescription: Text[250];
        lLenght: Integer;
        lLineBreak: Text[30];
        lLineCutPos: Integer;
        lLineBreakPos: Integer;
        lLineNo: Integer;
        CR: Char;
        LF: Char;
    begin
        if StrLen(DescriptionMemo) = 0 then
            exit;

        CR := 13;
        LF := 10;
        lLineBreak := Format(LF);
        lLenght := MaxStrLen(pSalesLine.Description);

        with ExtendedTextMemo do begin
            if Find('+') then
                lLineNo := "Line No."
            else
                lLineNo := 0;
            repeat
                Init;
                lLineNo += 10000;
                "Document Type" := pSalesLine."Document Type";
                "Document No." := pSalesLine."Document No.";
                "Line No." := lLineNo;
                "Attached to Line No." := pSalesLine."Line No.";
                "Line Type" := "line type"::" ";
                Type := Type::" ";

                lLineBreakPos := StrPos(DescriptionMemo, lLineBreak);
                if lLineBreakPos > 0 then
                    if lLineBreakPos > lLenght then begin
                        //#8027
                        //        lLineCutPos := SearchCutPosition(DescriptionMemo);
                        lLineCutPos := SearchCutPosition(CopyStr(DescriptionMemo, 1, lLineBreakPos - 1));
                        //#8027//

                        Description := CopyStr(DescriptionMemo, 1, lLineCutPos);
                        DescriptionMemo := CopyStr(DescriptionMemo, lLineCutPos + 1);
                    end else begin
                        Description := CopyStr(DescriptionMemo, 1, lLineBreakPos - 1);
                        DescriptionMemo := CopyStr(DescriptionMemo, lLineBreakPos + 1);
                    end
                else
                    if StrLen(DescriptionMemo) > lLenght then begin
                        lLineCutPos := SearchCutPosition(DescriptionMemo);
                        Description := CopyStr(DescriptionMemo, 1, lLineCutPos);
                        DescriptionMemo := CopyStr(DescriptionMemo, lLineCutPos + 1);
                    end else begin
                        Description := DescriptionMemo;
                        DescriptionMemo := '';
                    end;
                Insert;
            until StrLen(DescriptionMemo) = 0;
        end;
    end;


    procedure InsertExtendedText(var pSalesLine: Record "Sales Line"; pLineNo: Integer)
    var
        lSalesLine: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
    begin
        with ExtendedTextMemo do begin
            SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
            SetRange("Attached to Line No.", pLineNo);
            if Find('-') then
                repeat
                    lSalesLine.Init;
                    lSalesLine."Document Type" := pSalesLine."Document Type";
                    lSalesLine."Document No." := pSalesLine."Document No.";
                    if (pSalesLine."Line Type" <> pSalesLine."line type"::" ") or (pSalesLine."No." <> '') then begin
                        lSalesLine."Line No." := GetNextLineNo(pSalesLine);
                        lSalesLine."Presentation Code" := pSalesLine."Presentation Code";
                        lSalesLine.Level := pSalesLine.Level;
                        lSalesLine."Attached to Line No." := pSalesLine."Line No.";
                    end
                    else begin
                        PresentMgt.OnNewRecord(lSalesLine, pSalesLine, true, false);
                        lSalesLine."Line No." := GetNextLineNo(pSalesLine);
                        lSalesLine."Line Type" := lSalesLine."line type"::" ";
                        lSalesLine.Type := lSalesLine.Type::" ";
                        if pSalesLine."Attached to Line No." <> 0 then begin
                            lSalesLine."Presentation Code" := pSalesLine."Presentation Code";
                            lSalesLine.Level := pSalesLine.Level;
                        end;
                        lSalesLine."Attached to Line No." := pSalesLine."Attached to Line No."
                    end;
                    lSalesLine.Description := Description;

                    //      IF (pSalesLine."Attached to Line No." <> 0) AND
                    //         (pSalesLine."Line Type" = pSalesLine."Line Type"::" ") OR
                    //         (pSalesLine."No." = '')
                    //      THEN
                    //        lSalesLine."Attached to Line No." := pSalesLine."Attached to Line No."
                    //      ELSE
                    //        lSalesLine."Attached to Line No." := pSalesLine."Line No.";
                    //#7988
                    lSalesLine."Job No." := pSalesLine."Job No.";
                    lSalesLine."Job Task No." := pSalesLine."Job Task No.";
                    //#7988//

                    lSalesLine.Insert;
                    //#7826
                    wNaviBatSetup.GET;
                    wRollBackLog.CommitLine(lSalesLine, wNaviBatSetup."Line Committed");
                    //#7826//
                    pSalesLine := lSalesLine;
                until Next = 0;
        end;
    end;


    procedure GetExcelBufferExtendedText(pRowID: Text[10]; pColID: Text[10])
    var
        lExcelBufExt: Record "Excel Buffer Extended";
    begin
        lExcelBufExt.Reset;
        lExcelBufExt.SetRange(xlRowID, pRowID);
        lExcelBufExt.SetRange(xlColID, pColID);
        if lExcelBufExt.Find('-') then
            repeat
                DescriptionMemo := DescriptionMemo + lExcelBufExt."Cell Value";
            until lExcelBufExt.Next = 0;
    end;


    procedure CreateSalesLine(var pTmpSalesLine: Record "Sales Line"; var pSalesLine: Record "Sales Line"; var pPrevSaleLine: Record "Sales Line"; var pCount: Integer; var pWindow: Dialog)
    var
        lLevel: Integer;
        lPresentation: Text[50];
        lStructureMgt: Codeunit "Structure Management";
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        if isExcludeLine(pTmpSalesLine) then
            exit;
        with pTmpSalesLine do begin
            pSalesLine.Init;
            pSalesLine."Document Type" := "Document Type";
            pSalesLine."Document No." := "Document No.";
            pSalesLine."Line No." := 0;
            PresentMgt.OnNewRecord(pSalesLine, pPrevSaleLine, true, false);
            if pSalesLine."Line No." = pSalesLine."Attached to Line No." then
                Error(
                  tErrorAttachedLine,
                  pSalesLine.FieldCaption("Attached to Line No."),
                  pSalesLine."Line No.");

            PreInitLevel := (pTmpSalesLine.Level > 0);

            lPresentation := pSalesLine."Presentation Code";
            lLevel := pSalesLine.Level;
            //#7826
            if SetupHeader."Source File Type" = SetupHeader."source file type"::Excel then
                InitLineType(pTmpSalesLine, pSalesLine)
            else
                pSalesLine."Line Type" := pTmpSalesLine."Line Type";
            //#7826//
            pSalesLine.Validate("Line Type");
            pSalesLine."Presentation Code" := lPresentation;
            pSalesLine.Level := lLevel;

            //pSalesLine.Type := pTmpSalesLine.Type;
            pSalesLine."Imported Line" := true;
            pSalesLine.Insert(true);

            //#7826
            wNaviBatSetup.GET;
            wRollBackLog.CommitLine(pSalesLine, wNaviBatSetup."Line Committed");

            //  InitLineType(pTmpSalesLine,pSalesLine);
            //#7826//
            //PERF  pSalesLine.VALIDATE("Line Type");

            //**********************
            //Force "Attaché à la ligne" pour les textes - ** A SUPPRIMER ?????**
            //  IF (pSalesLine.Level > 1) AND
            //     (pSalesLine."Line Type" = pSalesLine."Line Type"::" ")
            //  THEN
            //    pSalesLine."Attached to Line No." := AttachedLineNo[CurrLevel];
            //**********************

            if (pSalesLine."No." = '.') and
               (pSalesLine."Attached to Line No." = 0) and
               (pSalesLine."Line Type" = pSalesLine."line type"::" ")
            then
                pSalesLine."No." := '';
            if "Item Reference No." <> '' then
                pSalesLine.Validate("Item Reference No.", "Item Reference No.");
            pSalesLine.Validate(Marker, Marker);

            //Init du niveau
            InitLevel(pTmpSalesLine, pSalesLine, pPrevSaleLine);

            if (pSalesLine."No." = '') and
               (pSalesLine."Line Type" = pSalesLine."line type"::Structure) and
               (SetupHeader."Default Structure No." <> '')
            then
                "No." := SetupHeader."Default Structure No.";

            if "No." <> '' then
                pSalesLine.Validate("No.", "No.");

            pSalesLine.Validate(Description, Description);

            if (pPrevSaleLine."Line Type" = pPrevSaleLine."line type"::" ") and
               (pSalesLine."Line Type" = pSalesLine."line type"::" ") and
               (pSalesLine."No." = '') and
               (pPrevSaleLine."No." = '') and
               (pPrevSaleLine."Attached to Line No." <> 0) then begin
                pSalesLine.Level := pPrevSaleLine.Level;
                pSalesLine."Presentation Code" := pPrevSaleLine."Presentation Code";
                pSalesLine."Attached to Line No." := pPrevSaleLine."Attached to Line No.";
                pSalesLine."Imported Line" := true;
            end;

            if (pSalesLine."No." = '') and
               (pSalesLine."Structure Line No." = 0) and
               (pSalesLine."Item Reference No." = '') and
               (pSalesLine.Marker = '') and
               ((Quantity = 0) and ("Unit Cost (LCY)" = 0) and ("Unit Price" = 0)) and ("Unit of Measure Code" = '') and
               (pSalesLine."Line Type" = pSalesLine."line type"::Structure)
            then begin
                pSalesLine.Validate("Line Type", "line type"::" ");
                pSalesLine."No." := '';
            end;

            if pSalesLine.Type = pSalesLine.Type::" " then begin
                "Unit of Measure Code" := '';
                Quantity := 0;
                "Unit Cost (LCY)" := 0;
                "Unit Price" := 0;
            end;

            if "Unit of Measure Code" <> '' then begin
                if not UnitMeasure.Get("Unit of Measure Code") then
                    Error(tUnitNotExists, "Unit of Measure Code");
                if (pSalesLine."No." <> '') and (pSalesLine."Line Type" = pSalesLine."line type"::Item) then
                    if not ItemUnitMeasure.Get("No.", "Unit of Measure Code") then
                        Error(tIncorrectValue, "Unit of Measure Code", pSalesLine."No.");
                if (pSalesLine."No." <> '') and (pSalesLine."Unit of Measure Code" <> "Unit of Measure Code") then
                    pSalesLine.Validate("Unit of Measure Code", "Unit of Measure Code")
                else begin
                    pSalesLine."Unit of Measure Code" := "Unit of Measure Code";
                    pSalesLine."Unit of Measure" := UnitMeasure.Description;
                    if pSalesLine."No." = '' then
                        pSalesLine."Qty. per Unit of Measure" := 1;
                end;
            end;

            if Quantity <> 0 then
                pSalesLine.Validate(Quantity, Quantity);
            if "Unit Cost (LCY)" <> 0 then
                pSalesLine.Validate("Unit Cost (LCY)", "Unit Cost (LCY)");
            if "Unit Price" <> 0 then begin
                pSalesLine.Validate("Unit Price", "Unit Price");
                pSalesLine."Fixed Price" := true;
            end;

            if pSalesLine."Line No." = pSalesLine."Attached to Line No." then
                Error(
                  tErrorAttachedLine,
                  pSalesLine.FieldCaption("Attached to Line No."),
                  pSalesLine."Line No.");

            //  InsertExtendedText(pSalesLine,pTmpSalesLine."Line No.");
            pSalesLine."Imported Line" := true;
            pSalesLine."Excel Line No." := "Excel Line No.";
            pSalesLine.Modify(true);

            //#7826
            lSingleInstance.wGetFrequencyCommit();
            //#7826//
            if (pSalesLine."Line Type" = pSalesLine."line type"::Structure) then begin
                StructureMgt.ExplodeStructure(pSalesLine);
                //#7826
                lSingleInstance.wGetFrequencyCommit();
                //#7826//

                SubcontractingMgt.UpdateSubcontractor(pSalesLine);
            end;


            InsertExtendedText(pSalesLine, pTmpSalesLine."Line No.");
            //#7826
            lSingleInstance.wGetFrequencyCommit();
            //#7826//

            if pSalesLine.Level = 0 then begin
                pSalesLine.Level := 1;
                pSalesLine.Modify;
            end;

            LineCount += 1;
            //#9157
            /*delete
            //#6722
            //  pWindow.UPDATE(2,ROUND(LineCount / pCount * 10000,1));
              pWindow.UPDATE(1,ROUND(LineCount / pCount * 10000,1));
            //#6722/
            */
            pWindow.Update(2, ROUND(LineCount / pCount * 10000, 1));
            //#9157//
        end;

    end;


    procedure CreateSalesOverHead(pDocType: Integer; pDocNo: Code[20])
    var
        lSalesOverhead: Record "Sales Overhead-Margin";
        lSalesHeader: Record "Sales Header";
    begin
        lSalesHeader.Get(pDocType, pDocNo);
        lSalesOverhead.SetRange("Document Type", pDocType);
        lSalesOverhead.SetRange("Document No.", pDocNo);
        if lSalesOverhead.IsEmpty then
            if (lSalesHeader."Sell-to Customer No." <> '') or
               (lSalesHeader."Sell-to Customer Templ. Code" <> '')
            then
                Codeunit.Run(Codeunit::"Overhead Calculation", lSalesHeader);
    end;


    procedure InitLineType(pTmpSalesLine: Record "Sales Line" temporary; var pSalesLine: Record "Sales Line")
    begin
        if pTmpSalesLine.Disable then
            exit;
        with pTmpSalesLine do
            if "Line Type" = "line type"::" " then begin
                pSalesLine.Type := pSalesLine.Type::" ";
                if ((Quantity <> 0) or ("Unit Price" <> 0) or ("Unit Cost (LCY)" <> 0) or ("Unit of Measure Code" <> '')) then begin
                    pSalesLine."Line Type" := pSalesLine."line type"::Structure;
                    pSalesLine.Type := pSalesLine.Type::Resource;
                end else
                    if ("No." <> '') or (Marker <> '') then
                        pSalesLine."Line Type" := pSalesLine."line type"::Totaling;
            end;
    end;


    procedure InitLevel(pTmpSalesLine: Record "Sales Line" temporary; var pSalesLine: Record "Sales Line"; pPrevSaleLine: Record "Sales Line")
    begin
        //#6160
        CurrLevel := pSalesLine.Level;
        //#6160//
        if not PreInitLevel then begin
            case LevelFieldRef of
                0:
                    begin
                        case pSalesLine."Line Type" of
                            pSalesLine."line type"::Totaling:
                                while pSalesLine.Level > 1 do
                                    PresentMgt.wLeft(pSalesLine, true);
                        end;
                    end;
                5705:
                    begin
                        if (LineCount > 0) and
                           (pSalesLine.Level > 1) and
                           isNewMarker(pSalesLine)
                        then
                            PresentMgt.wLeft(pSalesLine, true);
                        if (LineCount > 0) and
                           ((pPrevSaleLine."Line Type" <> pPrevSaleLine."line type"::Totaling) and
                            (pPrevSaleLine.Level > 1) and (pSalesLine.Level > 1)) and
                           (pSalesLine."Line Type" = pSalesLine."line type"::Totaling)
                        then
                            PresentMgt.wLeft(pSalesLine, true);
                    end;
                8004057:
                    //MovingLine(CurrLevel,pSalesLine);
                    if pTmpSalesLine.Level < CurrLevel then begin
                        pSalesLine.Level := CurrLevel;
                        PresentMgt.wLeft(pSalesLine, true);
                    end;
            end;
        end else
            if (pTmpSalesLine.Level <> 0) and (pTmpSalesLine.Level <> CurrLevel)
               and ((pSalesLine."Line Type" <> pSalesLine."line type"::" ")
                or ((pSalesLine."Line Type" = pSalesLine."line type"::" ") and (pSalesLine."No." <> ''))) then begin
                while pTmpSalesLine.Level < CurrLevel do begin
                    pSalesLine.Level := CurrLevel;
                    PresentMgt.wLeft(pSalesLine, true);
                    CurrLevel := pSalesLine.Level;
                end;
                while pTmpSalesLine.Level > CurrLevel do begin
                    pSalesLine.Level := CurrLevel;
                    PresentMgt.wRight(pSalesLine, true);
                    CurrLevel := pSalesLine.Level;
                end;
            end;

        pSalesLine.TestField(Level);
        if (CurrLevel < pSalesLine.Level) and (CurrLevel <> 0) then begin
            if (pSalesLine.Level - CurrLevel) > 1 then
                Error(tIncorrectLevelValue, pTmpSalesLine.Description, pSalesLine.Level, CurrLevel);
        end;
        CurrLevel := pSalesLine.Level;
        case CurrLevel of
            1:
                Clear(AttachedLineNo);
            else
                if pSalesLine."Line Type" <> pSalesLine."line type"::" " then
                    pSalesLine."Attached to Line No." := AttachedLineNo[CurrLevel - 1]
                else
                    pSalesLine."Attached to Line No." := AttachedLineNo[CurrLevel];
        end;

        if pSalesLine."Line Type" <> pSalesLine."line type"::" " then
            AttachedLineNo[CurrLevel] := pSalesLine."Line No."
    end;


    procedure MovingLine(pLevel: Integer; var pSalesLine: Record "Sales Line")
    begin
        if pLevel = 0 then
            pSalesLine.Level := 1
        else begin
            while pSalesLine.Level > pLevel do
                PresentMgt.wLeft(pSalesLine, true);
            while pSalesLine.Level < pLevel do
                PresentMgt.wRight(pSalesLine, false);
        end;
    end;


    procedure XMLBeforeImport(pFileName: Text[250]; pFilenameTmp: Text[250])
    var
        lIFile: File;
        lIFileTmp: File;
        lIStr: InStream;
        lOStr: OutStream;
        lData: Text[1024];
    begin
        //GL2024 License  lIFile.Open(pFileName);
        //GL2024 License  lIFile.CreateInstream(lIStr);
        //GL2024 License if Exists(pFilenameTmp) then
        //GL2024 License       Erase(pFilenameTmp);
        //GL2024 License   lIFileTmp.Create(pFilenameTmp);
        //GL2024 License   lIFileTmp.CreateOutstream(lOStr);
        while not lIStr.eos do begin
            lIStr.ReadText(lData);
            if StrLen(lData) > 0 then begin
                XMLDeleteNameSpace(lData);
                XMLReplaceText(lData, 'dt:dt', 'dt_dt');
                XMLReplaceText(lData, 'ss:', 'ss_');
                XMLReplaceText(lData, 'sc:', 'sc_');
                XMLReplaceText(lData, 'x:', 'x_');
            end;
            lOStr.WriteText(lData);
        end;
        //GL2024 License  lIFile.Close;
        //GL2024 License lIFileTmp.Close;
    end;


    procedure XMLReplaceText(var pText: Text[1000]; pOld: Text[30]; pNew: Text[30])
    var
        p: Integer;
    begin
        p := StrPos(pText, pOld);
        while p > 0 do begin
            pText := CopyStr(pText, 1, p - 1) + pNew + CopyStr(pText, p + StrLen(pOld));
            p := StrPos(pText, pOld);
        end;
    end;


    procedure XMLDeleteNameSpace(var pText: Text[1000])
    var
        p: Integer;
    begin
        p := StrPos(pText, 'xmlns');
        if p > 0 then
            pText := CopyStr(pText, 1, p - 1) + '>';
    end;


    procedure XMLDeleteXSLLine(pFileName: Text[250]; pFilenameTmp: Text[250])
    var
        LF: Char;
        CR: Char;
        lIFile: File;
        lIFileTmp: File;
        lIStr: InStream;
        lOStr: OutStream;
        lReadChar: Char;
        lWriteData: Text[1024];
        lMarkup: Text[1024];
        lCurrentMarkup: Text[1024];
        lOpenMarkup: Boolean;
        lStartMemo: Boolean;
        lEndMemo: Boolean;
        lStartMemoText: array[2] of Text[30];
        lEndMemoText: Text[30];
    begin
        //GL2024 License     Window.Open(tPrepareFile);
        //GL2024 License     lIFile.Open(pFileName);
        //GL2024 License  lIFile.CreateInstream(lIStr);
        //GL2024 License     if Exists(pFilenameTmp) then
        //GL2024 License         Erase(pFilenameTmp);
        //GL2024 License    lIFileTmp.Create(pFilenameTmp);
        //GL2024 License   lIFileTmp.CreateOutstream(lOStr);

        LF := 10;
        CR := 13;
        lMarkup := 'Table';
        lStartMemoText[1] := '<' + lMarkup + '>';
        lStartMemoText[2] := '<' + lMarkup + ' ';
        lEndMemoText := '</' + lMarkup + '>';

        while not lIStr.eos and (lEndMemo = false) do begin
            lIStr.Read(lReadChar);
            case lReadChar of
                '<':
                    begin
                        lCurrentMarkup := '';
                        lOpenMarkup := true;
                    end;
                '>', ' ', CR, LF:
                    begin
                        if (lCurrentMarkup + Format(lReadChar) = lStartMemoText[1]) or
                           (lCurrentMarkup + Format(lReadChar) = lStartMemoText[2])
                        then begin
                            lStartMemo := true;
                            lOStr.WriteText(lCurrentMarkup);
                        end;

                        if (lCurrentMarkup = '<ss_Data') or
                           (lCurrentMarkup = '<ss_Data' + Format(CR)) or
                           (lCurrentMarkup = '<Font') or
                           (lCurrentMarkup = '<Font' + Format(CR))
                        then
                            while lReadChar <> '>' do
                                lIStr.Read(lReadChar);

                        if lCurrentMarkup + Format(lReadChar) = lEndMemoText then
                            lEndMemo := true;
                        if lReadChar = '>' then
                            lOpenMarkup := false;
                    end;
            end;
            if lOpenMarkup and (lReadChar = ':') then
                lReadChar := '_';
            lCurrentMarkup := lCurrentMarkup + Format(lReadChar);
            if lStartMemo then begin
                lWriteData := Format(lReadChar);
                lOStr.WriteText(lWriteData);
            end;
        end;
        //GL2024 License   lIFile.Close;
        //GL2024 License  lIFileTmp.Close;
        Window.Close;
    end;
}

