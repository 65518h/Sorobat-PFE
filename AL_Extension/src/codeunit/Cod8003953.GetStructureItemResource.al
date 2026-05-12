Codeunit 8003953 "Get Structure Item Resource"
{
    // //DEVIS GESWAY 01/12/03 Sélection multiple
    // //PERF CLA 09/06/05
    // //PERF AC 04/12/06 Amélioration performances sur insertion multiple d'ouvrage

    TableNo = "Sales Line";

    trigger OnRun()
    begin
    end;

    var
        Text000: label 'The %1 on the %2  and the %4 %5 must be the same.';
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        GetStructure: Page "Get Receipt Lines";
        RecRef1: RecordRef;
        PresentationMgt: Codeunit "Presentation Management";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        StructureMgt: Codeunit "Structure Management";
        Structure: Record Resource;
        StructLine: Record "Structure Component";
        JobJnlLine: Record "Job Journal Line";
        PurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        xPurchLine: Record "Purchase Line";
        TooMuchLine: label 'There are too much line to insert here';
        wNbEnr: Integer;


    procedure CreateSalesLines(var pRecRef: RecordRef)
    var
        lNumLine: Integer;
        lFieldRef: FieldRef;
        lSalesLine: Record "Sales Line";
    begin
        //Pas utiliser car impossible de passer le marquage au recordref
        with pRecRef do begin
            if FindSet then begin
                lSalesLine.LockTable;
                lSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                lSalesLine.SetRange("Document No.", SalesHeader."No.");
                lSalesLine."Document Type" := SalesHeader."Document Type";
                lSalesLine."Document No." := SalesHeader."No.";
                if lSalesLine.FindLast then
                    lNumLine := SalesLine."Line No.";
                repeat
                    lFieldRef := pRecRef.Field(1);
                    lSalesLine."Line No." := lNumLine;
                    if lSalesLine.Insert(true) then;
                    lNumLine := lSalesLine."Line No." + 10000;
                    lSalesLine.Validate(Type, SalesLine.Type);
                    lSalesLine.Validate("No.", Format(lFieldRef.Value));
                    lSalesLine.Modify(true);
                until Next = 0;
            end;
        end;
    end;


    procedure SetSalesHeader(var SalesHeader2: Record "Sales Header")
    begin
        SalesHeader.Copy(SalesHeader2);
    end;


    procedure SetSalesLine(var SalesLine2: Record "Sales Line")
    begin
        SalesLine.Copy(SalesLine2);
    end;


    procedure CreateSalesLinesFromItem(var pItem: Record Item; pBelowxrec: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lOldSalesline: Record "Sales Line";
        lSaleslineTest: Record "Sales Line";
        lRec: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lIncrement: Integer;
    begin
        pItem.SetCurrentkey("No.");
        pItem.SetRange("Tree Code");
        with pItem do begin
            if FindFirst then begin
                lSalesLine.LockTable;
                //    IF SalesLine."Structure Line No." = 0 THEN
                //      lSalesLine.SETCURRENTKEY("Order Type","Document Type","Document No.","Presentation Code")
                //    ELSE
                if SalesLine."Structure Line No." <> 0 then
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
                lSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                lSalesLine.SetRange("Document No.", SalesHeader."No.");
                if lSalesLine.FindLast then;
                lSalesLine."Document Type" := SalesHeader."Document Type";
                lSalesLine."Document No." := SalesHeader."No.";
                lOldSalesline."Line No." := SalesLine."Line No.";
                lSalesLine."Line No." := SalesLine."Line No.";
                lOldSalesline."Presentation Code" := SalesLine."Presentation Code";
                lSalesLine."Presentation Code" := SalesLine."Presentation Code";
                lSalesLine."Structure Line No." := SalesLine."Structure Line No.";
                lSalesLine.Level := SalesLine.Level;
                lSalesLine."Line Type" := SalesLine."Line Type";
                lSalesLine."Attached to Line No." := SalesLine."Attached to Line No.";
                lSalesLine.Option := SalesLine.Option;
                //#5020
                lSalesLine."Quantity Shipped" := 0;
                lSalesLine."Quantity Invoiced" := 0;
                lSalesLine."Qty. Shipped Not Invoiced" := 0;
                lSalesLine."Qty. Shipped (Base)" := 0;
                lSalesLine."Qty. Invoiced (Base)" := 0;
                lSalesLine."Qty. Shipped Not Invd. (Base)" := 0;
                //#5020/

                //#4434
                if wNbEnr <= 0 then
                    wNbEnr := 1;
                lRec.SetRange("Document Type", lSalesLine."Document Type");
                lRec.SetRange("Document No.", lSalesLine."Document No.");
                lRec.SetRange("Line No.", lOldSalesline."Line No." - 10000, lOldSalesline."Line No.");
                if not lRec.IsEmpty then begin
                    lRec.FindLast;
                    lOldSalesline."Line No." := lRec."Line No.";
                    lRec.SetRange("Line No.");
                    if lRec.Find('>') then
                        if (lRec."Line No." - lOldSalesline."Line No.") <= 10 * wNbEnr then
                            Error(TooMuchLine)
                        else
                            lIncrement := (lRec."Line No." - lOldSalesline."Line No.") DIV wNbEnr
                    else
                        lIncrement := 10000;
                end else
                    lIncrement := 10000;
                //#4434//

                repeat
                    //MERGE MB 03/04/06
                    if SalesHeader."Order Type" <> SalesHeader."order type"::"Supply Order" then begin
                        //MERGE//
                        if lSalesLine."Structure Line No." = 0 then
                            PresentationMgt.OnNewRecord(lSalesLine, lOldSalesline, pBelowxrec, true)
                        else begin
                            lSalesLine."Line No." := lOldSalesline."Line No." + lIncrement;
                            lSalesLine."Presentation Code" := SalesLine."Presentation Code";
                        end;
                        //        PresentationMgt.OnNewRecord(lSalesLine,lOldSalesline,FALSE,FALSE);
                    end else begin
                        //#4434
                        /*DELETE
                                lRec.SETRANGE("Document Type",lSalesLine."Document Type");
                                lRec.SETRANGE("Document No.",lSalesLine."Document No.");
                                lRec.SETRANGE("Line No.",lOldSalesline."Line No.");
                                IF NOT lRec.ISEMPTY THEN BEGIN
                                  lRec.SETRANGE("Line No.");
                                  IF lRec.FIND('>') THEN
                                    lSalesLine."Line No." := lOldSalesline."Line No." + ROUND((lRec."Line No." - lOldSalesline."Line No.")/2,1)
                                  ELSE
                                    lSalesLine."Line No." += lOldSalesline."Line No." + 10000;
                                END;
                        DELETE*/
                        lSalesLine."Line No." := lOldSalesline."Line No." + lIncrement;
                        //#4434//
                    end;
                    if not lSaleslineTest.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.") then
                        while not lSalesLine.Insert(true) do
                            lSalesLine."Line No." += 10000;

                    lSalesLine.Type := lSalesLine.Type::Item;
                    if SalesHeader."Order Type" <> SalesHeader."order type"::"Supply Order" then
                        lSalesLine.Validate("Line Type", SalesLine."Line Type");
                    lSalesLine.Validate("No.", pItem."No.");
                    lSalesLine.Validate(Quantity, SalesLine.Quantity);
                    lSalesLine.Modify(true);
                    if lSalesLine."Structure Line No." = 0 then  //#5044 : Plus d'insertion du texte étendu dans sous-détail
                        if TransferExtendedText.SalesCheckIfAnyExtText(lSalesLine, false) then
                            TransferExtendedText.InsertSalesExtText(lSalesLine);
                    lOldSalesline := lSalesLine;
                    lSalesLine."Line No." := 0;
                    Clear(lSalesLine."Presentation Code");       //#5001
                    if SalesLine."Structure Line No." = 0 then
                        lSalesLine."Line Type" := lSalesLine."line type"::" ";
                until Next = 0;

                //#4434
                lSalesLine.SetRange("Line Type", lSalesLine."line type"::Item);
                lSalesLine.SetFilter("No.", '%1', '');
                if not lSalesLine.IsEmpty then begin
                    lSalesLine.Find('-');
                    repeat
                        lSalesLine2.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
                        lSalesLine2.Delete;
                    until lSalesLine.Next = 0;
                end;
                //#4434//

            end;
        end;

    end;


    procedure CreateSalesLinesFromRes(var pRes: Record Resource; pBelowxrec: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lOldSalesline: Record "Sales Line";
        lSaleslineTest: Record "Sales Line";
        lxRec: Record "Sales Line";
        lTab: array[20] of Integer;
        lLineNo: Integer;
        lIncrement: Integer;
        lrec: Record "Sales Line";
    begin
        pRes.SetCurrentkey("No.");
        pRes.SetRange("Tree Code");
        with pRes do begin
            if FindSet then begin
                lSalesLine.LockTable;
                if SalesLine."Structure Line No." = 0 then
                    lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code")
                else
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
                lSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                lSalesLine.SetRange("Document No.", SalesHeader."No.");
                if lSalesLine.FindLast then;
                lSalesLine."Document Type" := SalesHeader."Document Type";
                lSalesLine."Document No." := SalesHeader."No.";
                lSalesLine."Line No." := SalesLine."Line No.";
                lLineNo := SalesLine."Line No.";
                lOldSalesline."Line No." := SalesLine."Line No.";
                lOldSalesline."Presentation Code" := SalesLine."Presentation Code";
                lSalesLine."Presentation Code" := SalesLine."Presentation Code";
                lSalesLine."Structure Line No." := SalesLine."Structure Line No.";
                lSalesLine.Level := SalesLine.Level;
                lSalesLine."Line Type" := SalesLine."Line Type";
                lSalesLine."Attached to Line No." := SalesLine."Attached to Line No.";
                lSalesLine.Option := SalesLine.Option;
                //Calcul du premier code présentation
                if lSalesLine."Structure Line No." = 0 then
                    PresentationMgt.OnNewRecord(lSalesLine, lOldSalesline, pBelowxrec, true)
                else
                    PresentationMgt.OnNewRecord(lSalesLine, lOldSalesline, false, false);
                //Calcul du premier code présentation
                PresentationMgt.wMajTab(lSalesLine, lTab);
                //PERF//
                //#4434
                if wNbEnr <= 0 then
                    wNbEnr := 1;
                lrec.SetRange("Document Type", lSalesLine."Document Type");
                lrec.SetRange("Document No.", lSalesLine."Document No.");
                lrec.SetRange("Line No.", lOldSalesline."Line No." - 10000, lOldSalesline."Line No.");
                if not lrec.IsEmpty then begin
                    lrec.FindLast;
                    lOldSalesline."Line No." := lrec."Line No.";
                    lrec.SetRange("Line No.");
                    if lrec.Find('>') then
                        if (lrec."Line No." - lOldSalesline."Line No.") <= 10 * wNbEnr then
                            Error(TooMuchLine)
                        else
                            lIncrement := (lrec."Line No." - lOldSalesline."Line No.") DIV (wNbEnr + 1)
                    else
                        lIncrement := 10000;
                end else
                    lIncrement := 10000;
                //#4434//

                repeat
                    lSalesLine.Init;
                    lSalesLine."Document Type" := SalesHeader."Document Type";
                    lSalesLine."Document No." := SalesHeader."No.";
                    lSalesLine."Line No." := lLineNo;
                    lSalesLine."Structure Line No." := SalesLine."Structure Line No.";
                    if lSalesLine."Structure Line No." = 0 then
                        lSalesLine."Presentation Code" := PresentationMgt.wCreatePresentationCode(lTab, SalesLine.Level)
                    else
                        lSalesLine."Presentation Code" := SalesLine."Presentation Code";
                    lSalesLine.Level := SalesLine.Level;
                    lSalesLine."Line Type" := SalesLine."Line Type";
                    lSalesLine."Attached to Line No." := SalesLine."Attached to Line No.";
                    lSalesLine.Option := SalesLine.Option;
                    lSalesLine.Type := SalesLine.Type;
                    lSalesLine."Line Type" := SalesLine."Line Type";
                    lSalesLine.Validate("No.", pRes."No.");
                    lSalesLine.Quantity := SalesLine.Quantity;
                    lSalesLine."Found Price" := pRes."Unit Price";
                    if not lSaleslineTest.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.") then
                        while not lSalesLine.Insert(true) do
                            lSalesLine."Line No." += 10000
                    else
                        //#7203
                        lSalesLine.Modify(true);
                    //#7203//
                    //Début insertion structure de l'ouvrage
                    if (SalesLine."Structure Line No." = 0) and (lSalesLine."Line Type" = lSalesLine."line type"::Structure) then begin
                        lxRec := lSalesLine;
                        StructureMgt.ExplodeStructure(lSalesLine);
                        lSalesLine.wUpdateLine(lSalesLine, lxRec, false);
                    end;
                    //Fin insertion structure de l'ouvrage

                    if SalesLine."Line No." = lSalesLine."Line No." then
                        SalesLine.Get(SalesHeader."Document Type", SalesHeader."No.", SalesLine."Line No.");

                    //Début insertion texte attaché
                    if lSalesLine."Structure Line No." = 0 then  //#5044 : Plus d'insertion du texte étendu dans sous-détail
                        if TransferExtendedText.SalesCheckIfAnyExtText(lSalesLine, false) then
                            TransferExtendedText.InsertSalesExtText(lSalesLine);
                    //Fin insertion texte attaché

                    //Calcul du nouveau code présentation
                    if lSalesLine."Structure Line No." = 0 then begin
                        lTab[lSalesLine.Level] += 1;
                        lLineNo := lSalesLine.wGetLastCurrNo(SalesHeader."Document Type", SalesHeader."No.", 10000);
                    end else
                        lLineNo += lIncrement;
                //Fin Calcul du nouveau code presentation//
                until Next = 0;
            end;
        end;
    end;


    procedure CreateStructLinesFromItem(var pItem: Record Item)
    var
        lStructLine: Record "Structure Component";
        lStructLine2: Record "Structure Component";
    begin
        pItem.SetCurrentkey("No.");
        pItem.SetRange("Tree Code");
        with pItem do begin
            if Find('-') then begin
                lStructLine.LockTable;
                lStructLine.SetCurrentkey("Parent Structure No.", "Line No.");
                lStructLine.SetRange("Parent Structure No.", Structure."No.");
                if lStructLine.Find('+') then;
                lStructLine."Line No." := StructLine."Line No.";
                lStructLine."Parent Structure No." := Structure."No.";
                repeat
                    if lStructLine.Insert(true) then;
                    lStructLine.Validate(Type, StructLine.Type);
                    lStructLine.Validate("No.", pItem."No.");
                    lStructLine.Modify(true);
                    lStructLine2.SetRange("Parent Structure No.", lStructLine."Parent Structure No.");
                    lStructLine2.SetRange("Line No.", lStructLine."Line No.");
                    if lStructLine2.Find('-') then begin
                        lStructLine2.SetRange("Line No.");
                        if lStructLine2.Find('>') then
                            lStructLine."Line No." := lStructLine."Line No." + ROUND((lStructLine2."Line No." - lStructLine."Line No.") / 2, 1)
                        else
                            lStructLine."Line No." += 10000;
                    end;
                until Next = 0;
            end;
        end;
    end;


    procedure CreateStructLinesFromRes(var pRes: Record Resource)
    var
        lStructLine: Record "Structure Component";
        lStructLine2: Record "Structure Component";
    begin
        pRes.SetCurrentkey("No.");
        pRes.SetRange("Tree Code");
        with pRes do begin
            if Find('-') then begin
                lStructLine.LockTable;
                lStructLine.SetCurrentkey("Parent Structure No.", "Line No.");
                lStructLine.SetRange("Parent Structure No.", Structure."No.");
                if lStructLine.FindLast then;
                lStructLine."Parent Structure No." := Structure."No.";
                lStructLine."Line No." := StructLine."Line No.";
                repeat
                    if lStructLine.Insert(true) then;
                    lStructLine.Validate(Type, StructLine.Type);
                    lStructLine.Validate("No.", pRes."No.");
                    lStructLine.Modify(true);
                    lStructLine2.SetRange("Parent Structure No.", lStructLine."Parent Structure No.");
                    lStructLine2.SetRange("Line No.", lStructLine."Line No.");
                    if lStructLine2.FindFirst then begin
                        lStructLine2.SetRange("Line No.");
                        if lStructLine2.Find('>') then
                            lStructLine."Line No." := lStructLine."Line No." + ROUND((lStructLine2."Line No." - lStructLine."Line No.") / 2, 1)
                        else
                            lStructLine."Line No." += 10000;
                    end;
                until Next = 0;
            end;
        end;
    end;


    procedure SetStructure(var pStrucutre: Record Resource)
    begin
        Structure.Copy(pStrucutre);
    end;


    procedure SetStructureLine(var pStructureLine: Record "Structure Component")
    begin
        StructLine.Copy(pStructureLine);
    end;


    procedure SetJobJnlLine(var pJobJnlLine: Record "Job Journal Line")
    begin
        JobJnlLine.Copy(pJobJnlLine);
    end;


    procedure CreateJobJnlLineFromRes(var pRes: Record Resource)
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlLine2: Record "Job Journal Line";
        lGrRes: Record "Resource / Resource Group";
        lLineNo: Integer;
    begin
        pRes.SetCurrentkey("No.");
        pRes.SetRange("Tree Code");
        with pRes do begin
            if FindSet then begin
                lJobJnlLine.LockTable;
                lLineNo := JobJnlLine."Line No.";
                repeat
                    lJobJnlLine := JobJnlLine;
                    lJobJnlLine."Line No." := lLineNo;
                    if lJobJnlLine.Insert(true) then;
                    lJobJnlLine.Validate(Type, JobJnlLine.Type);
                    if lJobJnlLine."Resource Group No." <> pRes."Resource Group No." then
                        if not lGrRes.Get(pRes."No.", lJobJnlLine."Resource Group No.") then
                            lJobJnlLine."Resource Group No." := '';
                    lJobJnlLine.Validate("No.", pRes."No.");
                    lJobJnlLine.Modify(true);
                    lJobJnlLine2.SetRange("Journal Template Name", JobJnlLine."Journal Template Name");
                    lJobJnlLine2.SetRange("Journal Batch Name", JobJnlLine."Journal Batch Name");
                    lJobJnlLine2.SetRange("Line No.", lJobJnlLine."Line No.");
                    if lJobJnlLine2.Find('-') then begin
                        lJobJnlLine2.SetRange("Line No.");
                        /*
                                IF lJobJnlLine2.FIND('>') THEN
                                  lJobJnlLine."Line No." := lJobJnlLine."Line No." + ROUND((lJobJnlLine2."Line No." - lJobJnlLine."Line No.")/2,1)
                                ELSE
                                  lJobJnlLine."Line No." += 10000;
                        */
                        if lJobJnlLine2.Find('>') then
                            lLineNo += ROUND((lJobJnlLine2."Line No." - lJobJnlLine."Line No.") / 2, 1)
                        else
                            lLineNo += 10000;
                    end;
                until Next = 0;
            end;
        end;

    end;


    procedure CreateJobJnlLineFromItem(var pItem: Record Item)
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlLine2: Record "Job Journal Line";
    begin
        pItem.SetCurrentkey("No.");
        pItem.SetRange("Tree Code");
        with pItem do begin
            if FindSet then begin
                lJobJnlLine.LockTable;
                lJobJnlLine := JobJnlLine;
                repeat
                    if lJobJnlLine.Insert(true) then;
                    lJobJnlLine.Validate(Type, JobJnlLine.Type);
                    lJobJnlLine.Validate("No.", pItem."No.");
                    lJobJnlLine.Modify(true);
                    lJobJnlLine2.SetRange("Journal Template Name", lJobJnlLine."Journal Template Name");
                    lJobJnlLine2.SetRange("Journal Batch Name", lJobJnlLine."Journal Batch Name");
                    lJobJnlLine2.SetRange("Line No.", lJobJnlLine."Line No.");
                    if lJobJnlLine2.Find('-') then begin
                        lJobJnlLine2.SetRange("Line No.");
                        if lJobJnlLine2.Find('>') then
                            lJobJnlLine."Line No." := lJobJnlLine."Line No." + ROUND((lJobJnlLine2."Line No." - lJobJnlLine."Line No.") / 2, 1)
                        else
                            lJobJnlLine."Line No." += 10000;
                    end;
                until Next = 0;
            end;
        end;
    end;


    procedure CreateJobJnlLineFromInterim(var pInterim: Record "Interim Mission")
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlLine2: Record "Job Journal Line";
    begin
        pInterim.SetCurrentkey("Resource No.");
        with pInterim do begin
            if Find('-') then begin
                lJobJnlLine.LockTable;
                lJobJnlLine := JobJnlLine;
                repeat
                    if lJobJnlLine.Insert(true) then;
                    lJobJnlLine.Validate(Type, JobJnlLine.Type);
                    lJobJnlLine."Mission No." := pInterim."Mission No.";
                    lJobJnlLine.Validate("No.", pInterim."Resource No.");
                    lJobJnlLine.Modify(true);
                    lJobJnlLine2.SetRange("Journal Template Name", JobJnlLine."Journal Template Name");
                    lJobJnlLine2.SetRange("Journal Batch Name", JobJnlLine."Journal Batch Name");
                    lJobJnlLine2.SetRange("Line No.", lJobJnlLine."Line No.");
                    if lJobJnlLine2.Find('-') then begin
                        lJobJnlLine2.SetRange("Line No.");
                        if lJobJnlLine2.Find('>') then
                            lJobJnlLine."Line No." := lJobJnlLine."Line No." + ROUND((lJobJnlLine2."Line No." - lJobJnlLine."Line No.") / 2, 1)
                        else
                            lJobJnlLine."Line No." += 10000;
                    end;
                until Next = 0;
            end;
        end;
    end;


    procedure CreatePurchLinesFromItem(var pItem: Record Item)
    var
        lPurchLine: Record "Purchase Line";
        lPurchLine2: Record "Purchase Line";
        lOldPurchLine: Record "Purchase Line";
        lRec: Record "Purchase Line";
        lPurchLineTest: Record "Purchase Line";
        lNbEnr: Integer;
        lIncrement: Integer;
    begin
        if PurchLine."Line No." = 0 then begin
            lRec.Copy(PurchLine);
            if lRec.FindLast then
                if (xPurchLine."Line No." = lRec."Line No.") then
                    lRec.SetFilter("Line No.", '<=%1', xPurchLine."Line No.")
                else
                    lRec.SetFilter("Line No.", '<%1', xPurchLine."Line No.");
            if not lRec.FindLast then
                PurchLine."Line No." := xPurchLine."Line No." + 10000
            else begin
                xPurchLine."Line No." := lRec."Line No.";
                lRec.SetRange("Line No.");
                if not lRec.Find('>') then
                    PurchLine."Line No." := xPurchLine."Line No." + 10000
                else
                    PurchLine."Line No." := xPurchLine."Line No." + ROUND((lRec."Line No." - xPurchLine."Line No.") / 2, 1);
            end;
        end;
        pItem.SetCurrentkey("No.");
        pItem.SetRange("Tree Code");
        with pItem do begin
            //#5084
            lNbEnr := Count + 1;
            if lNbEnr = 0 then
                lNbEnr := 1;
            //#5084//
            if Find('-') then begin
                lPurchLine.LockTable;
                lPurchLine.Init;
                lPurchLine."Document Type" := PurchHeader."Document Type";
                lPurchLine."Document No." := PurchHeader."No.";
                lPurchLine.Validate(Type, PurchLine.Type);
                lOldPurchLine."Line No." := PurchLine."Line No.";
                lPurchLine."Line No." := PurchLine."Line No.";
                lOldPurchLine."No." := PurchLine."No.";
                lPurchLine."Attached to Line No." := PurchLine."Attached to Line No.";
                //#5084
                lRec.SetRange("Document Type", lPurchLine."Document Type");
                lRec.SetRange("Document No.", lPurchLine."Document No.");
                lRec.SetRange("Line No.", lOldPurchLine."Line No." - 10000, lOldPurchLine."Line No.");
                if not lRec.IsEmpty then begin
                    lRec.Find('+');
                    lOldPurchLine."Line No." := lRec."Line No.";
                    lRec.SetRange("Line No.");
                    if lRec.Find('>') then
                        if (lRec."Line No." - lOldPurchLine."Line No.") <= 10 * lNbEnr then
                            Error(TooMuchLine)
                        else
                            lIncrement := (lRec."Line No." - lOldPurchLine."Line No.") DIV lNbEnr
                    else
                        lIncrement := 10000;
                end else
                    lIncrement := 10000;
                //#5084//
                repeat
                    //#5084
                    /*DELETE
                          lRec.SETRANGE("Line No.",lOldPurchLine."Line No.");
                          IF lRec.FIND('-') THEN BEGIN
                            lRec.SETRANGE("Line No.");
                          IF lOldPurchLine."No." <> '' THEN BEGIN
                            IF lRec.FIND('>') THEN
                              lPurchLine."Line No." := lOldPurchLine."Line No." + ROUND((lRec."Line No." - lOldPurchLine."Line No.")/2,1)
                            ELSE
                              lPurchLine."Line No." += lOldPurchLine."Line No." + 10000;
                            END;
                          END;
                    DELETE*/
                    lPurchLine."Line No." := lOldPurchLine."Line No." + lIncrement;
                    //#5084//
                    if not lPurchLineTest.Get(lPurchLine."Document Type", lPurchLine."Document No.", lPurchLine."Line No.") then
                        while not lPurchLine.Insert(true) do
                            lPurchLine."Line No." += 10000;
                    lPurchLine.Validate("No.", pItem."No.");
                    lPurchLine.Validate(Quantity, PurchLine.Quantity);
                    lPurchLine.Modify(true);
                    //#5084
                    PurchLine := lPurchLine;
                    //#5084//
                    if TransferExtendedText.PurchCheckIfAnyExtText(lPurchLine, false) then
                        TransferExtendedText.InsertPurchExtText(lPurchLine);
                    lOldPurchLine := lPurchLine;
                    //#5084      lOldPurchLine."Line No." := lPurchLine."Special Order Sales Line No.";
                    lPurchLine."Special Order Sales Line No." := 0;
                    lOldPurchLine."Special Order Sales Line No." := 0;
                    lPurchLine."Line No." := 0;
                until Next = 0;
            end;
        end;

    end;


    procedure GetPurchLine(var pPurchline: Record "Purchase Line")
    begin
        pPurchline.Copy(PurchLine);
    end;


    procedure SetPurchLine(var pPurchline: Record "Purchase Line"; var pxPurchLine: Record "Purchase Line")
    begin
        PurchLine.Copy(pPurchline);
        xPurchLine.Copy(pxPurchLine);
    end;


    procedure SetPurchHeader(var pPurchHeader: Record "Purchase Header")
    begin
        PurchHeader.Copy(pPurchHeader);
    end;


    procedure SetNbEnr(pNbEnr: Integer)
    begin
        wNbEnr := pNbEnr + 1;
    end;


    procedure CreateSalesLinesFromAccount(var pGLAccount: Record "G/L Account"; pBelowxrec: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lOldSalesline: Record "Sales Line";
        lSaleslineTest: Record "Sales Line";
        lRec: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lIncrement: Integer;
    begin
        //#7203
        pGLAccount.SetCurrentkey("No.");
        //pglaccount.SETRANGE("Tree Code");
        with pGLAccount do begin
            if FindFirst then begin
                lSalesLine.LockTable;
                if SalesLine."Structure Line No." <> 0 then
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
                lSalesLine.SetRange("Document Type", SalesHeader."Document Type");
                lSalesLine.SetRange("Document No.", SalesHeader."No.");
                if lSalesLine.FindLast then;
                lSalesLine."Document Type" := SalesHeader."Document Type";
                lSalesLine."Document No." := SalesHeader."No.";
                lOldSalesline."Line No." := SalesLine."Line No.";
                lSalesLine."Line No." := SalesLine."Line No.";
                lOldSalesline."Presentation Code" := SalesLine."Presentation Code";
                lSalesLine."Presentation Code" := SalesLine."Presentation Code";
                lSalesLine."Structure Line No." := SalesLine."Structure Line No.";
                lSalesLine.Level := SalesLine.Level;
                lSalesLine."Line Type" := SalesLine."Line Type";
                lSalesLine."Attached to Line No." := SalesLine."Attached to Line No.";
                lSalesLine.Option := SalesLine.Option;

                lSalesLine."Quantity Shipped" := 0;
                lSalesLine."Quantity Invoiced" := 0;
                lSalesLine."Qty. Shipped Not Invoiced" := 0;
                lSalesLine."Qty. Shipped (Base)" := 0;
                lSalesLine."Qty. Invoiced (Base)" := 0;
                lSalesLine."Qty. Shipped Not Invd. (Base)" := 0;

                if wNbEnr <= 0 then
                    wNbEnr := 1;
                lRec.SetRange("Document Type", lSalesLine."Document Type");
                lRec.SetRange("Document No.", lSalesLine."Document No.");
                lRec.SetRange("Line No.", lOldSalesline."Line No." - 10000, lOldSalesline."Line No.");
                if not lRec.IsEmpty then begin
                    lRec.FindLast;
                    lOldSalesline."Line No." := lRec."Line No.";
                    lRec.SetRange("Line No.");
                    if lRec.Find('>') then
                        if (lRec."Line No." - lOldSalesline."Line No.") <= 10 * wNbEnr then
                            Error(TooMuchLine)
                        else
                            lIncrement := (lRec."Line No." - lOldSalesline."Line No.") DIV wNbEnr
                    else
                        lIncrement := 10000;
                end else
                    lIncrement := 10000;

                repeat
                    //MERGE MB 03/04/06
                    if SalesHeader."Order Type" <> SalesHeader."order type"::"Supply Order" then begin
                        //MERGE//
                        if lSalesLine."Structure Line No." = 0 then
                            PresentationMgt.OnNewRecord(lSalesLine, lOldSalesline, pBelowxrec, true)
                        else begin
                            lSalesLine."Line No." := lOldSalesline."Line No." + lIncrement;
                            lSalesLine."Presentation Code" := SalesLine."Presentation Code";
                        end;
                    end else begin
                        lSalesLine."Line No." := lOldSalesline."Line No." + lIncrement;
                    end;
                    if not lSaleslineTest.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.") then
                        while not lSalesLine.Insert(true) do
                            lSalesLine."Line No." += 10000;

                    lSalesLine.Type := lSalesLine.Type::"G/L Account";
                    if SalesHeader."Order Type" <> SalesHeader."order type"::"Supply Order" then
                        lSalesLine.Validate("Line Type", SalesLine."Line Type");
                    lSalesLine.Validate("No.", pGLAccount."No.");
                    //7203      lSalesLine.VALIDATE(Quantity,SalesLine.Quantity);
                    lSalesLine.Modify(true);
                    //7203
                    //      IF lSalesLine."Structure Line No." = 0 THEN  //#5044 : Plus d'insertion du texte étendu dans sous-détail
                    //        IF TransferExtendedText.SalesCheckIfAnyExtText(lSalesLine,FALSE) THEN
                    //          TransferExtendedText.InsertSalesExtText(lSalesLine);
                    //
                    lOldSalesline := lSalesLine;
                    lSalesLine."Line No." := 0;
                    Clear(lSalesLine."Presentation Code");       //#5001
                    if SalesLine."Structure Line No." = 0 then
                        lSalesLine."Line Type" := lSalesLine."line type"::" ";
                until Next = 0;

                lSalesLine.SetRange("Line Type", lSalesLine."line type"::"G/L Account");
                lSalesLine.SetFilter("No.", '%1', '');
                if not lSalesLine.IsEmpty then begin
                    lSalesLine.Find('-');
                    repeat
                        lSalesLine2.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
                        lSalesLine2.Delete;
                    until lSalesLine.Next = 0;
                end;

            end;
        end;
        //#7203//
    end;


    procedure CreatePurchLinesFromAccount(var pGLAccount: Record "G/L Account")
    var
        lPurchLine: Record "Purchase Line";
        lPurchLine2: Record "Purchase Line";
        lOldPurchLine: Record "Purchase Line";
        lRec: Record "Purchase Line";
        lPurchLineTest: Record "Purchase Line";
        lNbEnr: Integer;
        lIncrement: Integer;
    begin
        //#7750
        if PurchLine."Line No." = 0 then begin
            lRec.Copy(PurchLine);
            if lRec.FindLast then
                if (xPurchLine."Line No." = lRec."Line No.") then
                    lRec.SetFilter("Line No.", '<=%1', xPurchLine."Line No.")
                else
                    lRec.SetFilter("Line No.", '<%1', xPurchLine."Line No.");
            if not lRec.FindLast then
                PurchLine."Line No." := xPurchLine."Line No." + 10000
            else begin
                xPurchLine."Line No." := lRec."Line No.";
                lRec.SetRange("Line No.");
                if not lRec.Find('>') then
                    PurchLine."Line No." := xPurchLine."Line No." + 10000
                else
                    PurchLine."Line No." := xPurchLine."Line No." + ROUND((lRec."Line No." - xPurchLine."Line No.") / 2, 1);
            end;
        end;
        pGLAccount.SetCurrentkey("No.");
        with pGLAccount do begin
            //#5084
            lNbEnr := Count + 1;
            if lNbEnr = 0 then
                lNbEnr := 1;
            //#5084//
            if Find('-') then begin
                lPurchLine.LockTable;
                lPurchLine.Init;
                lPurchLine."Document Type" := PurchHeader."Document Type";
                lPurchLine."Document No." := PurchHeader."No.";
                lPurchLine.Validate(Type, PurchLine.Type);
                lOldPurchLine."Line No." := PurchLine."Line No.";
                lPurchLine."Line No." := PurchLine."Line No.";
                lOldPurchLine."No." := PurchLine."No.";
                lPurchLine."Attached to Line No." := PurchLine."Attached to Line No.";
                //#5084
                lRec.SetRange("Document Type", lPurchLine."Document Type");
                lRec.SetRange("Document No.", lPurchLine."Document No.");
                lRec.SetRange("Line No.", lOldPurchLine."Line No." - 10000, lOldPurchLine."Line No.");
                if not lRec.IsEmpty then begin
                    lRec.Find('+');
                    lOldPurchLine."Line No." := lRec."Line No.";
                    lRec.SetRange("Line No.");
                    if lRec.Find('>') then
                        if (lRec."Line No." - lOldPurchLine."Line No.") <= 10 * lNbEnr then
                            Error(TooMuchLine)
                        else
                            lIncrement := (lRec."Line No." - lOldPurchLine."Line No.") DIV lNbEnr
                    else
                        lIncrement := 10000;
                end else
                    lIncrement := 10000;
                //#5084//
                repeat
                    //#5084
                    lPurchLine."Line No." := lOldPurchLine."Line No." + lIncrement;
                    //#5084//
                    if not lPurchLineTest.Get(lPurchLine."Document Type", lPurchLine."Document No.", lPurchLine."Line No.") then
                        while not lPurchLine.Insert(true) do
                            lPurchLine."Line No." += 10000;
                    lPurchLine.Validate("No.", pGLAccount."No.");
                    lPurchLine.Validate(Quantity, PurchLine.Quantity);
                    lPurchLine.Modify(true);
                    //#5084
                    PurchLine := lPurchLine;
                    //#5084//
                    if TransferExtendedText.PurchCheckIfAnyExtText(lPurchLine, false) then
                        TransferExtendedText.InsertPurchExtText(lPurchLine);
                    lOldPurchLine := lPurchLine;
                    //#5084      lOldPurchLine."Line No." := lPurchLine."Special Order Sales Line No.";
                    lPurchLine."Special Order Sales Line No." := 0;
                    lOldPurchLine."Special Order Sales Line No." := 0;
                    lPurchLine."Line No." := 0;
                until Next = 0;
            end;
        end;
        //#7750//
    end;
}

