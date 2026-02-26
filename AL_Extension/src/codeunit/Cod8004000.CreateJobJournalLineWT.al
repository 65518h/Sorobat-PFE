Codeunit 8004000 "Create Job Journal Line WT"
{
    TableNo = "Job Journal Line";

    trigger OnRun()
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlLine2: Record "Job Journal Line";
    begin
        LineNo := 0;
        lJobJnlLine.Copy(Rec);
        lJobJnlLine2.CopyFilters(Rec);
        Code(lJobJnlLine);
        Rec.Copy(lJobJnlLine);
        Rec.CopyFilters(lJobJnlLine2);
    end;

    var
        Text1100280001: label 'Item Balanced total / %1';
        Text1100280000: label 'Human Ressource Balance / %1';
        Text1100280007: label 'G/L Account Balance / %1';
        //GL2024  JnlLineDim: Record 356;
        Text8003900: label 'Working time setup is not coherent for %1.';
        Text8003901: label 'Le filtre sur le champ "%1"  empèche le bon fonctionnement du traitement de validation\Veuillez retirer ce filtre de la feuille de saisie.';
        wProgressDlg: Codeunit "Progress Dialog2";
        DimMgt: Codeunit DimensionManagement;
        LineNo: Integer;
        wProgressOK: Boolean;
        wTemporary: Boolean;
        //GL2024  JnlLineDim2: Record 356;
        tErrJobJnlLineRes: label 'The resource No. is necessary for the batch name : %1 at the posting date %2, for the job No. : %3 and for the document No. %4.';


    procedure "Code"(var pJobJnlLine: Record "Job Journal Line")
    var
        lFromJnlLineTmp: Record "Job Journal Line" temporary;
        lToJobJnlLineTmp: Record "Job Journal Line" temporary;
        ljnlTmpName: Code[20];
        ljnlTmpBatch: Code[20];
    begin
        //TEST-FILTER
        wTestFilter(pJobJnlLine);
        //TEST-FILTER//

        lToJobJnlLineTmp.DeleteAll;
        lFromJnlLineTmp.DeleteAll;

        if pJobJnlLine.IsEmpty then
            exit;

        //#7474
        if LineNo = 0 then
            LineNo := lLastLineNo(pJobJnlLine."Journal Template Name", pJobJnlLine."Journal Batch Name") + 10000;
        //7474//

        pJobJnlLine.FindSet;
        repeat
            lFromJnlLineTmp := pJobJnlLine;
            lFromJnlLineTmp.Insert;
            //#5053
            if pJobJnlLine.Quantity = 0 then
                pJobJnlLine.Delete;
        //#5053//
        until pJobJnlLine.Next = 0;
        if pJobJnlLine.FindFirst then;

        lFromJnlLineTmp.CopyFilters(pJobJnlLine);
        //#7474
        /*MOVE
        //#5292
        IF LineNo = 0 THEN
          LineNo := lLastLineNo(pJobJnlLine."Journal Template Name",pJobJnlLine."Journal Batch Name")+10000;
        //#5292
        */
        //7474//

        with lFromJnlLineTmp do begin           //Créer nouvelles lignes
                                                //GL2024  JnlLineDim.Reset;
                                                //GL2024   JnlLineDim.SetRange("Table ID", Database::"Job Journal Line");
                                                //#6205
                                                //  JnlLineDim.SETRANGE("Journal Template Name",ljnlTmpName);
                                                //  JnlLineDim.SETRANGE("Journal Batch Name",ljnlTmpBatch);
                                                //GL2024    JnlLineDim.SetRange("Journal Template Name", "Journal Template Name");
                                                //GL2024     JnlLineDim.SetRange("Journal Batch Name", "Journal Batch Name");
                                                //#6205//
            if FindSet then
                repeat
                    if (ljnlTmpName <> "Journal Template Name") and (ljnlTmpBatch <> pJobJnlLine."Journal Batch Name") then begin
                        //7474
                        //        LineNo := lLastLineNo(pJobJnlLine."Journal Template Name",pJobJnlLine."Journal Batch Name");
                        //7474//
                        ljnlTmpName := pJobJnlLine."Journal Template Name";
                        ljnlTmpBatch := pJobJnlLine."Journal Batch Name";
                    end;
                    if wProgressOK then
                        wProgressDlg.Update;
                    //GL2024      JnlLineDim.SetRange("Journal Line No.", "Line No.");
                    if "Machine No." <> '' then
                        wMachine(lToJobJnlLineTmp, lFromJnlLineTmp);

                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 1, "Quantity 1");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 2, "Quantity 2");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 3, "Quantity 3");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 4, "Quantity 4");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 5, "Quantity 5");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 6, "Quantity 6");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 7, "Quantity 7");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 8, "Quantity 8");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 9, "Quantity 9");
                    wQte(lToJobJnlLineTmp, lFromJnlLineTmp, "Journal Template Name", "Journal Batch Name", 10, "Quantity 10");

                    if ("Intervention Zone Code" <> '') and ("Intervention Zone Qty" <> 0) then
                        wDepl(lToJobJnlLineTmp, lFromJnlLineTmp)
                    else
                        if ("Driver Code" <> '') and ("Driver Quantity" <> 0) then
                            wDepl(lToJobJnlLineTmp, lFromJnlLineTmp);
                //#7722
                //GL2024   fPurgeJnlLineDim(lFromJnlLineTmp);
                //#7722//
                until Next = 0;

            lToJobJnlLineTmp.Reset;                      //Insérer nouvelles lignes
            if lToJobJnlLineTmp.FindSet then
                repeat
                    pJobJnlLine.Copy(lToJobJnlLineTmp);
                    //#5292
                    while not pJobJnlLine.Insert do
                        pJobJnlLine."Line No." += 10000;
                //#5292//
                until lToJobJnlLineTmp.Next = 0;
            pJobJnlLine.CopyFilters(lFromJnlLineTmp);
        end;

    end;


    procedure wMachine(var pToJobJnlLine: Record "Job Journal Line"; var pFromJobJnlLine: Record "Job Journal Line")
    var
        Resource: Record Resource;
        lToJobJnlLine2: Record "Job Journal Line";
        lToJobJnlLineTmp: Record "Job Journal Line" temporary;
    begin
        //POINTAGE
        with pToJobJnlLine do begin
            if pFromJobJnlLine."Machine No." <> '' then begin
                Copy(pFromJobJnlLine);
                LineNo += 10000;
                "Line No." := LineNo;
                Resource.Get(pFromJobJnlLine."Machine No.");
                "Job No." := pFromJobJnlLine."Job No.";
                "Job Task No." := pFromJobJnlLine."Job Task No.";
                Type := pFromJobJnlLine.Type::Resource;
                "Resource Group No." := '';
                "Mission No." := '';
                "Vendor No." := '';
                Validate("No.", pFromJobJnlLine."Machine No.");
                Validate(Quantity, pFromJobJnlLine.Quantity);
                //2009
                "Quantity 1" := pFromJobJnlLine."Quantity 1";
                "Quantity 2" := pFromJobJnlLine."Quantity 2";
                "Quantity 3" := pFromJobJnlLine."Quantity 3";
                "Quantity 4" := pFromJobJnlLine."Quantity 4";
                "Quantity 5" := pFromJobJnlLine."Quantity 5";
                "Quantity 6" := pFromJobJnlLine."Quantity 6";
                "Quantity 7" := pFromJobJnlLine."Quantity 7";
                "Quantity 8" := pFromJobJnlLine."Quantity 8";
                "Quantity 9" := pFromJobJnlLine."Quantity 9";
                "Quantity 10" := pFromJobJnlLine."Quantity 10";
                //2009//
                "Attached to Line No." := pFromJobJnlLine."Line No.";
                pFromJobJnlLine."Attached to Line No." := pFromJobJnlLine."Line No.";
                pFromJobJnlLine.Modify;

                Insert;
                /*  GL2024    if not wTemporary then begin
                          //#7280
                          JnlLineDim2.SetRange("Table ID", Database::"Job Journal Line");
                          JnlLineDim2.SetRange("Journal Template Name", "Journal Template Name");
                          JnlLineDim2.SetRange("Journal Batch Name", "Journal Batch Name");
                          JnlLineDim2.SetRange("Journal Line No.", "Line No.");
                          if not JnlLineDim2.IsEmpty then
                              JnlLineDim2.DeleteAll;
                          JnlLineDim2.Reset;
                          //#7280//
                          DimMgt.MoveJnlLineDimToJnlLineDim(JnlLineDim, Database::"Job Journal Line",
                                                          "Journal Template Name", "Journal Batch Name", "Line No.");
                      end;*/
                lToJobJnlLine2 := pToJobJnlLine;
                lToJobJnlLineTmp := pToJobJnlLine;
                lToJobJnlLineTmp.Insert;

                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 1, "Quantity 1");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 2, "Quantity 2");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 3, "Quantity 3");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 4, "Quantity 4");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 5, "Quantity 5");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 6, "Quantity 6");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 7, "Quantity 7");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 8, "Quantity 8");
                wQte(pToJobJnlLine, lToJobJnlLineTmp, "Journal Template Name", "Journal Batch Name", 9, "Quantity 9");
                pToJobJnlLine.Get(lToJobJnlLine2."Journal Template Name", lToJobJnlLine2."Journal Batch Name", lToJobJnlLine2."Line No.");
                wQte(pToJobJnlLine, pToJobJnlLine, "Journal Template Name", "Journal Batch Name", 10, "Quantity 10");
                pToJobJnlLine.Get(lToJobJnlLine2."Journal Template Name", lToJobJnlLine2."Journal Batch Name", lToJobJnlLine2."Line No.");
                if (pToJobJnlLine.Quantity = 0) then begin
                    pToJobJnlLine.Delete(true);
                end;
            end;
        end;
    end;


    procedure wQte(var pToJobJnlLine: Record "Job Journal Line"; var pFromJobJnlLine: Record "Job Journal Line"; pJnlTmpName: Code[10]; pJnlBatchName: Code[10]; pNo: Integer; pQte: Decimal)
    var
        WTSetup: Record "Working Time Setup";
        Resource: Record Resource;
        lDimMgt: Codeunit DimensionManagement;
        lOk: Boolean;
    begin
        if pQte = 0 then
            exit;
        with pToJobJnlLine do begin
            lOk := true;
            if not WTSetup.Get(pJnlTmpName, pJnlBatchName, pNo) then
                //#5800
                if not WTSetup.Get(pJnlTmpName, '', pNo) then
                    //#5800//
                    if not WTSetup.Get('', '', pNo) then
                        lOk := false;
            if lOk then begin
                Copy(pFromJobJnlLine);
                //#70107
                LineNo += 10000;
                "Line No." := LineNo;
                //#7107//
                if WTSetup."Control Type" = WTSetup."control type"::"Same Code" then
                    Type := WTSetup.Type;
                if WTSetup."Control No." = WTSetup."control no."::"Same Code" then
                    "No." := WTSetup."No.";

                //#4497
                case Type of
                    Type::Resource:
                        begin
                            //#8189
                            //Resource.GET("No.");
                            if (Resource.Get("No.")) then begin
                                //#8189//
                                if (Resource.Type = Resource.Type::Machine) and (WTSetup."Week Day" = 0) and ("Attached to Line No." <> 0) then
                                    exit;
                                Description := Resource.Name;
                                //#5224         IF (Resource."Resource Group No." <> '') AND ("No." <> pFromJobJnlLine."No.") THEN
                                if (Resource."Resource Group No." <> '') and ("No." <> pFromJobJnlLine."No.") and ("Resource Group No." = '') then
                                    "Resource Group No." := Resource."Resource Group No.";
                                if "Gen. Prod. Posting Group" = '' then
                                    "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                                //#6844
                                //         "Shortcut Dimension 1 Code" := Resource."Global Dimension 1 Code";
                                //         "Shortcut Dimension 2 Code" := Resource."Global Dimension 2 Code";
                                //#6844
                                UpdateAllAmounts();
                                //#8189
                            end else begin
                                Error(StrSubstNo(tErrJobJnlLineRes, pToJobJnlLine."Journal Batch Name",
                                                                    pToJobJnlLine."Posting Date",
                                                                    pToJobJnlLine."Job No.",
                                                                    pToJobJnlLine."Document No."));

                            end;
                            //#8189//
                        end;
                    Type::Item,
                  Type::"G/L Account":
                        Validate("No.");
                end;
                //#4497//

                case WTSetup."Control Work Type Code" of
                    WTSetup."control work type code"::"Same Code":
                        Validate("Work Type Code", WTSetup."Work Type Code");
                    WTSetup."control work type code"::"No Code":
                        "Work Type Code" := '';
                end;
                case WTSetup."Control Gen. Prod. Posting Gr." of
                    WTSetup."control gen. prod. posting gr."::"Same Code":
                        "Gen. Prod. Posting Group" := WTSetup."Gen. Prod. Posting Group";
                    WTSetup."control gen. prod. posting gr."::"No Code":
                        "Gen. Prod. Posting Group" := '';
                end;
                if WTSetup."Control Job No." = WTSetup."control job no."::"Same Code" then
                    Validate("Job No.", WTSetup."Job No.");
                if WTSetup."Control Job Task No." = WTSetup."control job task no."::"Same Code" then
                    Validate("Job Task No.", WTSetup."Job Task No.");

                "Shortcut Dimension 1 Code" := pFromJobJnlLine."Shortcut Dimension 1 Code";
                "Shortcut Dimension 2 Code" := pFromJobJnlLine."Shortcut Dimension 2 Code";

                Validate(Quantity, pQte);
                wMajDescription;
                "Attached to Line No." := pFromJobJnlLine."Line No.";
                pFromJobJnlLine."Attached to Line No." := pFromJobJnlLine."Line No.";
                pFromJobJnlLine.Modify;
                if WTSetup."Week Day" <> 0 then
                    "Posting Date" := Dwy2Date(WTSetup."Week Day", Date2dwy("Posting Date", 2), Date2dwy("Posting Date", 3));

                if Quantity <> 0 then begin
                    Insert;
                    /* //GL2024 if not wTemporary then
                         DimMgt.MoveJnlLineDimToJnlLineDim(JnlLineDim, Database::"Job Journal Line",
                                                         "Journal Template Name", "Journal Batch Name", "Line No.");*/
                end;

            end;
        end; //End With
    end;


    procedure wDepl(var pToJobJnlLine: Record "Job Journal Line"; var pFromJobJnlLine: Record "Job Journal Line")
    begin
        with pToJobJnlLine do begin
            //POINTAGE
            Copy(pFromJobJnlLine);
            LineNo += 10000;
            "Line No." := LineNo;
            "Direct Unit Cost (LCY)" := 0;
            Validate("Work Type Code", pFromJobJnlLine."Intervention Zone Code");
            Validate(Quantity, pFromJobJnlLine."Intervention Zone Qty");
            "Unit Price" := 0;
            "Total Price" := 0;

            wMajDescription;

            "Attached to Line No." := pFromJobJnlLine."Line No.";
            pFromJobJnlLine."Attached to Line No." := pFromJobJnlLine."Line No.";
            pFromJobJnlLine.Modify;

            if Quantity <> 0 then begin
                Insert;
                //#6205
                /*  //GL2024 if not wTemporary then
                      DimMgt.MoveJnlLineDimToJnlLineDim(JnlLineDim, Database::"Job Journal Line",
                                                        "Journal Template Name", "Journal Batch Name", "Line No.");*/
                //#6205//
            end;

            if pFromJobJnlLine."Driver Quantity" <> 0 then begin
                LineNo += 10000;
                "Line No." := LineNo;
                "Direct Unit Cost (LCY)" := 0;
                Validate("Work Type Code", pFromJobJnlLine."Driver Code");
                Validate(Quantity, pFromJobJnlLine."Driver Quantity");

                wMajDescription;

                "Attached to Line No." := pFromJobJnlLine."Line No.";
                pFromJobJnlLine."Attached to Line No." := pFromJobJnlLine."Line No.";
                pFromJobJnlLine.Modify;

                "Job Task No." := pFromJobJnlLine."Job Task No.";

                if Quantity <> 0 then begin
                    Insert;
                    /*  //GL2024  if not wTemporary then
                           DimMgt.MoveJnlLineDimToJnlLineDim(JnlLineDim, Database::"Job Journal Line",
                                                           "Journal Template Name", "Journal Batch Name", "Line No.");*/
                end;
            end;

            //POINTAGE//
        end;
    end;


    procedure wTestFilter(pJobJnlLine: Record "Job Journal Line")
    begin
        with pJobJnlLine do begin
            if (GetFilter("Work Type Code") <> '') then
                wTestFilterError(FieldCaption("Work Type Code"));
            if (GetFilter("Unit of Measure Code") <> '') then
                wTestFilterError(FieldCaption("Unit of Measure Code"));

            if (GetFilter(Quantity) <> '') then
                wTestFilterError(FieldCaption(Quantity));
            if (GetFilter("Quantity 1") <> '') then
                wTestFilterError(FieldCaption("Quantity 1"));
            if (GetFilter("Quantity 2") <> '') then
                wTestFilterError(FieldCaption("Quantity 2"));
            if (GetFilter("Quantity 3") <> '') then
                wTestFilterError(FieldCaption("Quantity 3"));
            if (GetFilter("Quantity 4") <> '') then
                wTestFilterError(FieldCaption("Quantity 4"));
            if (GetFilter("Quantity 5") <> '') then
                wTestFilterError(FieldCaption("Quantity 5"));
            if (GetFilter("Quantity 6") <> '') then
                wTestFilterError(FieldCaption("Quantity 6"));
            if (GetFilter("Quantity 7") <> '') then
                wTestFilterError(FieldCaption("Quantity 7"));
            if (GetFilter("Quantity 8") <> '') then
                wTestFilterError(FieldCaption("Quantity 8"));
            if (GetFilter("Quantity 9") <> '') then
                wTestFilterError(FieldCaption("Quantity 9"));
            if (GetFilter("Quantity 10") <> '') then
                wTestFilterError(FieldCaption("Quantity 10"));

            if (GetFilter("Intervention Zone Code") <> '') then
                wTestFilterError(FieldCaption("Intervention Zone Code"));
            if (GetFilter("Intervention Zone Qty") <> '') then
                wTestFilterError(FieldCaption("Intervention Zone Qty"));
            if (GetFilter("Driver Code") <> '') then
                wTestFilterError(FieldCaption("Driver Code"));
            if (GetFilter("Driver Quantity") <> '') then
                wTestFilterError(FieldCaption("Driver Quantity"));

            if (GetFilter("Resource Group No.") <> '') then
                wTestFilterError(FieldCaption("Resource Group No."));
        end;
    end;


    procedure wTestFilterError(pCaptionField: Text[50])
    begin
        Error(Text8003901, pCaptionField);
    end;


    procedure wInsertTmpJnlLine(var pJobJnlTmp: Record "Job Journal Line" temporary)
    var
        lJobJnl: Record "Job Journal Line";
        lJournal: Record "Job Journal Batch";
        lJournalTemp: Record "Job Journal Template";
    begin
        if pJobJnlTmp.GetFilter("No.") <> '' then
            lJobJnl.SetFilter("No.", pJobJnlTmp.GetFilter("No."));

        pJobJnlTmp.DeleteAll;
        //#6138
        //lJournalTemp.SETRANGE(Type,lJournalTemp.Type::"1");
        //#6138//
        if lJournalTemp.FindSet then
            repeat
                lJournal.SetRange("Journal Template Name", lJournalTemp.Name);
                wProgressDlg.Open('', lJournal.Count * 2);
                wProgressOK := true;
                if lJournal.FindSet then
                    repeat
                        lJobJnl.SetRange("Journal Template Name", lJournal."Journal Template Name");
                        lJobJnl.SetRange("Journal Batch Name", lJournal.Name);
                        if lJobJnl.FindSet then begin
                            repeat
                                wProgressDlg.Update;
                                pJobJnlTmp := lJobJnl;
                                pJobJnlTmp.Insert;
                            until lJobJnl.Next = 0;
                        end;
                    until lJournal.Next = 0;
            until lJournalTemp.Next = 0;
        Code(pJobJnlTmp);
        wProgressDlg.Close;
    end;


    procedure wCalcQtyPerRes(var pResource: Record Resource; var pJobJnlLine: Record "Job Journal Line"): Decimal
    begin
        with pResource do begin
            pJobJnlLine.SetCurrentkey(Type, "No.", "Work Type Code", "Posting Date", "Work Time Type", "Job No.");

            pJobJnlLine.SetRange(Type, pJobJnlLine.Type::Resource);
            pJobJnlLine.SetRange("No.", "No.");

            if GetFilter("Work Type Filter") <> '' then
                pJobJnlLine.SetFilter("Work Type Code", GetFilter("Work Type Filter"));

            if GetFilter("Date Filter") <> '' then
                pJobJnlLine.SetFilter("Posting Date", GetFilter("Date Filter"));

            if GetFilter("Job No. Filter") <> '' then
                pJobJnlLine.SetFilter("Job No.", GetFilter("Job No. Filter"));

            if GetFilter("Journal Template Name Filter") <> '' then
                pJobJnlLine.SetFilter("Journal Template Name", GetFilter("Journal Template Name Filter"));

            if GetFilter("Journal Batch Name Filter") <> '' then
                pJobJnlLine.SetFilter("Journal Batch Name", GetFilter("Journal Batch Name Filter"));

            if not pJobJnlLine.IsEmpty then begin
                pJobJnlLine.CalcSums("Quantity (Base)");
                exit(pJobJnlLine."Quantity (Base)");
            end else
                exit(0);
        end;
    end;


    procedure fCalcQtyPerWorkType(var pWorkType: Record "Work Type"; var pJobJnlLine: Record "Job Journal Line"): Decimal
    begin
        with pWorkType do begin
            pJobJnlLine.SetCurrentkey(Type, "No.", "Work Type Code", "Posting Date", "Work Time Type", "Job No.");

            pJobJnlLine.SetRange(Type, pJobJnlLine.Type::Resource);
            if GetFilter("Resource Filter") <> '' then
                pJobJnlLine.SetFilter("No.", GetFilter("Resource Filter"));

            pJobJnlLine.SetRange("Work Type Code", Code);

            if GetFilter("Date Filter") <> '' then
                pJobJnlLine.SetFilter("Posting Date", GetFilter("Date Filter"));

            if not pJobJnlLine.IsEmpty then begin
                pJobJnlLine.CalcSums("Quantity (Base)");
                exit(pJobJnlLine."Quantity (Base)");
            end else
                exit(0);
        end;
    end;


    procedure fDrillDown(var pJobJnlLine: Record "Job Journal Line"; pResFilter: Text[250]; pWorkTypeCode: Code[20]; pDateFilter: Text[250]; pShowOption: Option Both,Posted,Journal)
    var
        lJobLedgerEntry: Record "Job Ledger Entry";
        lTempJobJnlLine: Record "Job Journal Line" temporary;
        lTextPosted: label '(Posted)';
        lTextInProgress: label '(In progress)';
    begin
        //#5403
        if pShowOption in [Pshowoption::Both, Pshowoption::Posted] then begin
            lJobLedgerEntry.SetCurrentkey("Job No.", "Gen. Prod. Posting Group", "Entry Type", "Work Type Code",
                                          Type, "Resource Type", "No.", "Posting Date", "Work Time Type", "Bal. Created Entry");
            lJobLedgerEntry.SetRange("Entry Type", lJobLedgerEntry."entry type"::Usage);
            lJobLedgerEntry.SetFilter("Work Type Code", pWorkTypeCode);
            if pResFilter <> '' then
                lJobLedgerEntry.SetFilter("No.", pResFilter);
            lJobLedgerEntry.SetFilter("Posting Date", pDateFilter);
            lJobLedgerEntry.SetRange("Bal. Created Entry", false);
            if lJobLedgerEntry.FindSet then
                repeat
                    lTempJobJnlLine."Line No." += 1;
                    lTempJobJnlLine."Document No." := lJobLedgerEntry."Document No.";
                    lTempJobJnlLine."Posting Date" := lJobLedgerEntry."Posting Date";
                    lTempJobJnlLine.Type := lTempJobJnlLine.Type::Resource;
                    lTempJobJnlLine."No." := lJobLedgerEntry."No.";
                    lTempJobJnlLine."Resource Group No." := lJobLedgerEntry."Resource Group No.";
                    lTempJobJnlLine.Description := lJobLedgerEntry.Description;
                    lTempJobJnlLine.Description := CopyStr(StrSubstNo('%1 %2', lTempJobJnlLine.Description, lTextPosted), 1,
                                                           MaxStrLen(lTempJobJnlLine.Description));
                    lTempJobJnlLine."Work Type Code" := lJobLedgerEntry."Work Type Code";
                    lTempJobJnlLine."Job No." := lJobLedgerEntry."Job No.";
                    lTempJobJnlLine."Unit of Measure Code" := lJobLedgerEntry."Unit of Measure Code";
                    lTempJobJnlLine.Quantity := lJobLedgerEntry."Quantity (Base)";
                    lTempJobJnlLine."Direct Unit Cost (LCY)" := lJobLedgerEntry."Direct Unit Cost (LCY)";
                    lTempJobJnlLine."Unit Cost (LCY)" := lJobLedgerEntry."Unit Cost (LCY)";
                    lTempJobJnlLine."Total Cost (LCY)" := lJobLedgerEntry."Total Cost (LCY)";
                    lTempJobJnlLine."Unit Price (LCY)" := lJobLedgerEntry."Unit Price (LCY)";
                    lTempJobJnlLine."Total Price (LCY)" := lJobLedgerEntry."Total Price (LCY)";
                    lTempJobJnlLine."Shortcut Dimension 1 Code" := lJobLedgerEntry."Global Dimension 1 Code";
                    lTempJobJnlLine."Shortcut Dimension 2 Code" := lJobLedgerEntry."Global Dimension 2 Code";
                    lTempJobJnlLine."Source Code" := lJobLedgerEntry."Source Code";
                    lTempJobJnlLine."Journal Batch Name" := lJobLedgerEntry."Journal Batch Name";
                    lTempJobJnlLine."Reason Code" := lJobLedgerEntry."Reason Code";
                    lTempJobJnlLine."Gen. Bus. Posting Group" := lJobLedgerEntry."Gen. Bus. Posting Group";
                    lTempJobJnlLine."Gen. Prod. Posting Group" := lJobLedgerEntry."Gen. Prod. Posting Group";
                    lTempJobJnlLine."Document Date" := lJobLedgerEntry."Document Date";
                    lTempJobJnlLine."External Document No." := lJobLedgerEntry."External Document No.";
                    while not lTempJobJnlLine.Insert do
                        lTempJobJnlLine."Line No." += 1;
                until lJobLedgerEntry.Next = 0;
        end;

        if pShowOption in [Pshowoption::Both, Pshowoption::Journal] then begin
            pJobJnlLine.Reset;
            pJobJnlLine.SetCurrentkey(Type, "No.", "Work Type Code", "Posting Date", "Work Time Type", "Job No.");
            pJobJnlLine.SetRange(Type, pJobJnlLine.Type::Resource);
            if pResFilter <> '' then
                pJobJnlLine.SetFilter("No.", pResFilter);
            pJobJnlLine.SetFilter("Posting Date", pDateFilter);
            pJobJnlLine.SetRange("Work Type Code", pWorkTypeCode);
            if pJobJnlLine.FindSet then
                repeat
                    lTempJobJnlLine.Copy(pJobJnlLine);
                    lTempJobJnlLine.Description := CopyStr(StrSubstNo('%1 %2', pJobJnlLine.Description, lTextInProgress), 1,
                                                       MaxStrLen(lTempJobJnlLine.Description));
                    lTempJobJnlLine.Quantity := pJobJnlLine.Quantity;
                    while not lTempJobJnlLine.Insert do
                        lTempJobJnlLine."Line No." += 10000;
                until pJobJnlLine.Next = 0;
        end;

        //GL2024 NAVIBAT   PAGE.Run(page::"Job Journal Line Detail", lTempJobJnlLine);
        //#5403//
    end;


    procedure lLastLineNo(pTemplateName: Code[20]; pBatchName: Code[20]) Return: Integer
    var
        lJnlLine: Record "Job Journal Line";
    begin
        //#5292
        lJnlLine.SetRange("Journal Template Name", pTemplateName);
        lJnlLine.SetRange("Journal Batch Name", pBatchName);
        if lJnlLine.FindLast then
            Return := lJnlLine."Line No." + 10000
        else
            Return := 10000;
        //#5292//
    end;


    procedure wSetTempRec(Value: Boolean)
    begin
        wTemporary := Value;
    end;


    /*GL2024   procedure fPurgeJnlLineDim(pJobJnlLine: record 210)
       var
           lJnlLineDim: Record 356;
           lDimMgt: Codeunit 408;
           lJobJnlLine: record 210;
       begin
           //#7722
           // pJobJnlLine est une table tempo, alors il faut verifier s'il existe encore dans la tabel "Job Journal Line"
           if (not pJobJnlLine.Get(pJobJnlLine."Journal Template Name",
                                   pJobJnlLine."Journal Batch Name", pJobJnlLine."Line No.")) then begin
               // Puisque la ligne n'existe pas
               // Verifions sir des "Journal Line Dimension" existe encore pour le "Job Journal Line" Manquant
               lJnlLineDim.Reset;
               lJnlLineDim.SetRange("Table ID", Database::"Job Journal Line");
               lJnlLineDim.SetRange("Journal Template Name", pJobJnlLine."Journal Template Name");
               lJnlLineDim.SetRange("Journal Batch Name", pJobJnlLine."Journal Batch Name");
               lJnlLineDim.SetRange("Journal Line No.", pJobJnlLine."Line No.");
               lJnlLineDim.SetRange("Allocation Line No.", 0);
               if (not lJnlLineDim.IsEmpty()) then begin
                   // C'est pas vide, allez hop on supprime
                   lDimMgt.DeleteJnlLineDim(Database::"Job Journal Line",
                                            pJobJnlLine."Journal Template Name",
                                            pJobJnlLine."Journal Batch Name",
                                            pJobJnlLine."Line No.", 0);
               end;
           end;
           //#7722//
       end;*/
}

