Codeunit 8004052 "Presentation Management"
{
    // //DEVIS CW 24/03/03 Gestion du code présentation depuis la table 37 et les formulaires
    // //PERF AC 02/06/05 Performance traitement devis
    // //DEVIS AC 17/11/06 ReFreshPresentation : mise à jour du code présentation d'un document
    // //DEVIS AC 11/02/08 fCalcNewLineNo(VAR pRec,pxrec,pBelowxRec,pMulti) -> Calcul du numéro de ligne
    //            - pBelowxRec : Boolean  ->  hérité du trigger OnNewRecord d'un formulaire appelant.
    //               Ce paramètre indique si le nouveau record a été inséré dessous le xRec ou non.
    //            - pMulti : Boolean  -> Ce paramètre indique si la fonction est appelé dans un contexte multi insertion.
    //                     lCalcOnNewPresentation -> Calcul du code présentation
    //                     lCalcOnNewAttached -> Calcul du Champ "Attached To Line No."


    trigger OnRun()
    begin
    end;

    var
        Text8003900: label 'You must delete or change the level of the next line.\The current line cannot have a down tree.';
        Text8003901: label 'The level of the previous line is incompatible with this move.';
        Text8003902: label 'You mustn''t change %1 in %2, because this line has a down tree.';
        Text8003913: label 'You must have in the previous lines %1 level %2.';
        Text8003914: label 'You must move to the left before to move down.';
        Text8003915: label 'You must move to the left before to move up.';
        Text8003916: label 'You mustn''t move a line without a totaling line.';
        Text8003917: label 'This move is not possible.';
        Text8003918: label 'The system failed, you can''t insert a new line.\ You can use NavPad to resolve this problem.';
        ErrorInsertBetweenText: label 'You cannot insert %1 above a extended text.';
        GlobalVar: Codeunit "Variable Global";
        ErrorLevel: label 'You are limited at 4 levels of totaling.';
        LeftTotaling: Boolean;
        MoveAftTot: Boolean;
        RefreshPres: Boolean;
        RefreshSalesLine: Record "Sales Line";
        tProgress: label 'Update in Progress...';
        MaxLevel: Integer;


    procedure OnInsert(var pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lRecBis: Record "Sales Line";
        lStruct: Record "Sales Line";
        llevel: Integer;
        lAttachLine: Integer;
        lCurrAttachedLine: Integer;
        lTabCode: array[2, 20] of Integer;
        lDiff: Integer;
        lIncSuite: Boolean;
    begin
        with pRec do begin
            //#5295
            if "Line Type" = "line type"::Other then begin
                "Presentation Code" := '999';
                Level := 1;
                exit;
            end;
            //#5295//
            if ("Structure Line No." = 0) and (("Line Type" <> 0) or ("No." <> '') or ("Attached to Line No." = 0)) then begin
                lRec.Reset;                                                                  //Déplacement des lignes suivantes
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                if "Line Type" = "line type"::Totaling then
                    lRec.SetFilter("Presentation Code", '%1..', "Presentation Code")
                else
                    lRec.SetRange("Presentation Code", "Presentation Code", CopyStr("Presentation Code", 1, StrLen("Presentation Code") - 3) + '999');
                lRec.SetRange("Structure Line No.", 0);
                lRec.SetFilter("Line No.", '<>%1', "Line No.");
                lRec.SetRange("Attached to Line No.", "Attached to Line No.");
                //#5295
                lRec.SetFilter("Line Type", '<>%1', "line type"::Other);
                //#5295//
                if ("Line Type" = "line type"::Totaling) and (Level > 1) then begin
                    lAttachLine := "Attached to Line No.";
                    wMajTab(pRec, lTabCode[1]);
                    lDiff -= (lTabCode[1, Level] - 1);
                    Level -= 1;
                    lTabCode[1, Level] += 1;
                    Validate("Presentation Code", wCreatePresentationCode(lTabCode[1], Level));
                end;

                if (Level = 1) then
                    "Attached to Line No." := 0
                else
                    if ("Line Type" = "line type"::Totaling) and
                 lRecBis.Get("Document Type", "Document No.", "Attached to Line No.") then begin
                        "Attached to Line No." := lRecBis."Attached to Line No.";
                    end;

                lRec.SetFilter("Attached to Line No.", '%1|%2', "Attached to Line No.", lAttachLine);
                if lRec.IsEmpty then
                    exit;


                if Level = 0 then
                    Level := 1;

                llevel := Level;

                lRec.FindSet(true, true);
                repeat
                    if not lRec.Mark then begin
                        lRecBis.Copy(lRec);
                        if (lRec."Line Type" <> lRec."line type"::" ") or (lRec."No." <> '') or
                           ("Attached to Line No." = 0) then begin
                            if pRec."Line Type" = pRec."line type"::Totaling then begin
                                if (lRecBis.Level = Level + 1) and
                                  (lAttachLine = lRecBis."Attached to Line No.") then
                                    lRecBis."Attached to Line No." := "Line No.";
                                lRecBis."Presentation Code" := wIncPresentation(lRecBis, llevel, 1);
                                wMajTab(lRecBis, lTabCode[2]);
                                if lTabCode[2, llevel] = lTabCode[1, llevel] then
                                    lRecBis."Presentation Code" := wIncPresentation(lRecBis, llevel + 1, lDiff);
                            end else
                                lRecBis."Presentation Code" := wIncPresentation(lRecBis, llevel, 1);
                            lRecBis.Validate("Presentation Code");
                            wMoveTree(lRecBis, lRecBis, 4);
                            lRecBis.Modify;
                        end;
                    end;
                    lRec.Mark(true);
                until lRec.Next = 0;
            end;
        end;
    end;


    procedure OnDelete(pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lRecBis: Record "Sales Line";
        lSalesLineMng: Codeunit "SalesLine Management";
        llevel: Integer;
    begin
        with pRec do
            if ("Structure Line No." = 0) and (("Line Type" <> 0) or ("Attached to Line No." = 0) or ("No." <> '')) then //BEGIN
                wShiftLines(pRec, "Presentation Code", "Attached to Line No.", 3);
    end;


    procedure OnNewRecord(var pRec: Record "Sales Line"; pxrec: Record "Sales Line"; pBelowxRec: Boolean; pMulti: Boolean)
    var
        lRec: Record "Sales Line";
        lOk: Boolean;
    begin
        GlobalVar.GiveAttNo(pxrec."Attached to Line No.");
        with pRec do
            if "Line No." = 0 then begin
                //#5486
                lCalcOnNewLineNo(pRec, pxrec, pBelowxRec, pMulti);
                //#5486//

                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                if "Presentation Code" = '' then begin
                    lRec.SetRange("Structure Line No.", 0);
                    //#5295
                    lRec.SetFilter("Line Type", '<>%1', "line type"::Other);
                    //#5295//
                    if not pBelowxRec then begin
                        if ((pxrec."Line Type" = pxrec."line type"::" ") and (pxrec."No." = '') and
                            (pxrec."Attached to Line No." <> 0)) or pMulti then
                            lRec.SetFilter("Presentation Code", '<=%1', pxrec."Presentation Code")
                        else
                            lRec.SetFilter("Presentation Code", '<%1', pxrec."Presentation Code");
                    end;

                    lOk := not lRec.IsEmpty;
                    if not lOk then begin
                        Level := 1;
                        "Presentation Code" := '  1';
                        "Line Type" := "line type"::Structure;
                        Type := Type::Resource;
                        lRec.Type := Type::Resource;
                    end else begin
                        //#5486
                        lCalcOnNewAttached(pRec, lRec);
                        lCalcOnNewPresentation(pRec, lRec);
                        //#5486//
                    end;
                end;
            end;
    end;

    local procedure lCalcOnNewLineNo(var pRec: Record "Sales Line"; pxrec: Record "Sales Line"; pBelowxRec: Boolean; pMulti: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lRec: Record "Sales Line";
        lMinLine: Integer;
    begin
        //#5486
        with pRec do begin
            if "Line No." <> 0 then
                exit;
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            if lRec.IsEmpty then begin
                "Line No." := 10000;
                Level := 1;
                "Presentation Code" := '  1';
                "Line Type" := "line type"::Structure;
                Type := Type::Resource;
                lRec.Type := Type::Resource;
            end else begin
                if pBelowxRec or pMulti or
                   (("Line Type" > "line type"::" ") and ("Structure Line No." = 0)) then begin
                    "Line No." := lRec.wGetLastCurrNo("Document Type", "Document No.", 10000);
                end else begin
                    //Calcul du numéro a insérer par dicotomie
                    lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
                    //#6539
                    lSalesLine.SetRange("Document Type", pxrec."Document Type");
                    lSalesLine.SetRange("Document No.", pxrec."Document No.");
                    //#6539
                    //#6810
                    //#6970      lSalesLine.SETRANGE("Structure Line No.", 0);
                    lSalesLine.SetRange("Structure Line No.", "Structure Line No.");
                    //#6970//
                    lSalesLine.SetFilter("Line Type", '<>%1', lSalesLine."line type"::Other);
                    //#6810//
                    lSalesLine.Get(pxrec."Document Type", pxrec."Document No.", pxrec."Line No.");
                    if lSalesLine.Find('<') then
                        lMinLine := lSalesLine."Line No.";
                    if lMinLine > pxrec."Line No." then
                        "Line No." := lRec.wGetLastCurrNo("Document Type", "Document No.", 10000)
                    else begin
                        //#5991
                        if lMinLine = pxrec."Line No." then
                            lMinLine := 0;
                        //#5991//
                        "Line No." := (lMinLine + pxrec."Line No.") DIV 2;
                        while lRec.Get("Document Type", "Document No.", "Line No.") do begin
                            if ("Line No." = ("Line No." + pxrec."Line No.") DIV 2) then
                                Error(Text8003918);
                            "Line No." := ("Line No." + pxrec."Line No.") DIV 2;
                        end;
                    end;
                end;
                Clear(lSalesLine);
            end;
        end;
        //#5486//
    end;

    local procedure lCalcOnNewAttached(var pRec: Record "Sales Line"; var pSalesLine: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lOk: Boolean;
    begin
        with pRec do begin
            lOk := pSalesLine.FindLast;
            while (pSalesLine."Line Type" = pSalesLine."line type"::" ") and
                  (pSalesLine."No." = '') and (pSalesLine."Attached to Line No." <> 0) and lOk do
                lOk := pSalesLine.Find('<');

            "Line Type" := pSalesLine."Line Type";
            //#5150
            if "Line Type" = "line type"::Other then
                "Line Type" := "line type"::Structure;
            //#5150//
            if pSalesLine."Line Type" = pSalesLine."line type"::Totaling then begin
                if pSalesLine.Level = 5 then
                    Error(ErrorLevel);
                pSalesLine.Level += 1;
                if pRec."Line Type" <> pRec."line type"::" " then
                    "Attached to Line No." := pSalesLine."Line No."
                else
                    "Attached to Line No." := 0;
                "Line Type" := "line type"::Structure;
                pSalesLine.Type := Type::Resource;
            end else begin  //Vérifier que pSalesLine est attaché à un lot (sinon c'est du texte étendu)
                if pSalesLine."Line Type" = pSalesLine."line type"::" " then begin
                    "Line Type" := "line type"::Structure;
                    pSalesLine.Type := Type::Resource;
                    if lSalesLine.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Attached to Line No.") then begin
                        if lSalesLine."Line Type" <> lSalesLine."line type"::Totaling then
                            "Attached to Line No." := lSalesLine."Attached to Line No."
                        else
                            "Attached to Line No." := lSalesLine."Line No.";
                    end else
                        "Attached to Line No." := 0;
                end else begin
                    if lSalesLine.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Attached to Line No.") then;
                    if lSalesLine."Line Type" <> lSalesLine."line type"::" " then
                        "Attached to Line No." := pSalesLine."Attached to Line No."
                    else
                        "Attached to Line No." := lSalesLine."Attached to Line No.";
                end;
            end;
        end;
    end;

    local procedure lCalcOnNewPresentation(var pRec: Record "Sales Line"; pSalesLine: Record "Sales Line")
    var
        lTabCode: array[20] of Integer;
    begin
        with pRec do begin
            Type := pSalesLine.Type;
            Level := pSalesLine.Level;
            if (pSalesLine."Presentation Code" <> '') and (Level > 0) then begin
                if (pSalesLine."Line Type" = pSalesLine."line type"::" ") and ("Line Type" = "line type"::" ") then
                    "Presentation Code" := pSalesLine."Presentation Code"
                else begin
                    wMajTab(pSalesLine, lTabCode);
                    lTabCode[Level] += 1;
                    "Presentation Code" := wCreatePresentationCode(lTabCode, Level);
                end;
            end else
                "Presentation Code" := '  1';
        end;
    end;


    procedure FindPresLevel(var pRec: Record "Sales Line"; pNewLine: Boolean)
    var
        lPrevSalesLine: Record "Sales Line";
        lTabCode: array[20] of Integer;
    begin
        lPrevSalesLine.Reset;
        lPrevSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Attached to Line No.",
                                      "Structure Line No.", "Presentation Code");
        lPrevSalesLine.SetRange("Order Type", pRec."Order Type");
        lPrevSalesLine.SetRange("Document Type", pRec."Document Type");
        lPrevSalesLine.SetRange("Document No.", pRec."Document No.");
        lPrevSalesLine.SetRange("Structure Line No.", 0);

        if lPrevSalesLine.IsEmpty then begin                  //Aucune ligne dans le document
            pRec.Level := 1;
            pRec.Validate("Presentation Code", '  1');
            exit;
        end
        else begin
            if pNewLine then
                lPrevSalesLine.SetFilter("Presentation Code", '<=%1', pRec."Presentation Code");
            lPrevSalesLine.FindLast;
        end;

        if (pRec."Attached to Line No." <> 0) and (pRec."Line Type" = 0) and (pRec."No." = '') then begin            //Texte étendu
            if lPrevSalesLine.Get(pRec."Document Type", pRec."Document No.", pRec."Attached to Line No.") then;
            pRec.Level := lPrevSalesLine.Level;
            pRec.Validate("Presentation Code", lPrevSalesLine."Presentation Code");
            exit;
        end;
        if (pRec."Attached to Line No." <> 0) then begin            //Attaché à lot
            if lPrevSalesLine.Get(pRec."Document Type", pRec."Document No.", pRec."Attached to Line No.") then;
        end else
            if not pNewLine then begin
                lPrevSalesLine.SetFilter("Presentation Code", '<%1', pRec."Presentation Code");
                if lPrevSalesLine.IsEmpty then
                    exit
                else
                    lPrevSalesLine.FindLast;
            end;

        case lPrevSalesLine."Line Type" of
            lPrevSalesLine."line type"::Totaling:
                begin
                    pRec.Level := lPrevSalesLine.Level + 1;
                    if (pRec."No." <> '') then
                        pRec."Attached to Line No." := lPrevSalesLine."Line No."
                    else
                        pRec."Attached to Line No." := 0;
                end;
            else begin
                pRec.Level := lPrevSalesLine.Level;
                pRec."Attached to Line No." := lPrevSalesLine."Attached to Line No.";
            end;
        end;

        if pNewLine and (pRec."Presentation Code" > '  1') then begin
            if pRec."Presentation Code" > '' then
                lPrevSalesLine.SetFilter("Presentation Code", '<%1', pRec."Presentation Code")
            else
                lPrevSalesLine.SetRange("Presentation Code");
        end
        else begin
            if lPrevSalesLine."Line Type" = lPrevSalesLine."line type"::Totaling then begin
                lPrevSalesLine.SetFilter("Presentation Code", '<=%1', lPrevSalesLine."Presentation Code");
                pRec.Level := lPrevSalesLine.Level + 1;
            end
            else begin
                lPrevSalesLine.SetFilter("Presentation Code", '<=%1', pRec."Presentation Code");
            end;
        end;
        lPrevSalesLine.FindLast;

        if lPrevSalesLine."Presentation Code" <> '' then begin
            wMajTab(lPrevSalesLine, lTabCode);
            if (pRec."No." <> '') then
                lTabCode[pRec.Level] += 1;
            pRec.Validate("Presentation Code", wCreatePresentationCode(lTabCode, pRec.Level));
        end else
            pRec.Validate("Presentation Code", '  1');
    end;


    procedure wCreatePresentationCode(TabCode: array[20] of Integer; Niveau: Integer) Return: Text[80]
    var
        i: Integer;
    begin
        for i := 1 to Niveau do begin
            if Return <> '' then
                Return += '.';
            Return += CopyStr('   ', 1, 3 - StrLen(Format(TabCode[i]))) + Format(TabCode[i]);
        end;
    end;


    procedure wMajTab(pRec: Record "Sales Line"; var TabCode: array[20] of Integer)
    var
        lCode: Text[80];
        i: Integer;
    begin
        Clear(TabCode);
        //#4407
        if pRec."Presentation Code" = '' then
            exit;
        //#4407//
        lCode := pRec."Presentation Code";
        for i := 1 to pRec.Level do begin
            if StrPos(lCode, '.') <> 0 then begin
                Evaluate(TabCode[i], CopyStr(lCode, 1, StrPos(lCode, '.') - 1));
                lCode := CopyStr(lCode, StrPos(lCode, '.') + 1);
            end else begin
                Evaluate(TabCode[i], lCode);
                lCode := '0';
            end;
            if TabCode[i] < 0 then
                TabCode[i] := 0;
        end;
    end;


    procedure wMoveTree(SalesLine: Record "Sales Line"; SalesLineOrig: Record "Sales Line"; MoveOpt: Option Same,Left,Right,Up,Down)
    var
        lRec: Record "Sales Line";
        lTabCode: array[20] of Integer;
        i: Integer;
        lTabCodeMove: array[20] of Integer;
        lRec2: Record "Sales Line";
        lShift: Boolean;
    begin
        if (SalesLineOrig."Line Type" <> SalesLineOrig."line type"::Totaling) then
            exit;

        wMajTab(SalesLineOrig, lTabCodeMove);
        lRec.Reset;
        lRec.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
        lRec.SetRange("Document Type", SalesLine."Document Type");
        lRec.SetRange("Document No.", SalesLine."Document No.");
        lRec.SetRange("Attached to Line No.", SalesLine."Line No.");
        lRec.SetRange("Structure Line No.", 0);

        if not lRec.IsEmpty then
            case MoveOpt of
                Moveopt::Left:
                    begin
                        lRec.FindSet(true, false);
                        repeat
                            //#7442
                            lShift := fNeedShift(lRec);
                            if (lShift) then begin
                                //#7442//

                                wMajTab(lRec, lTabCode);
                                for i := 1 to SalesLineOrig.Level do
                                    lTabCode[i] := lTabCodeMove[i];
                                lRec.Level -= 1;
                                for i := SalesLineOrig.Level + 1 to lRec.Level do
                                    lTabCode[i] := lTabCode[i + 1];
                                lTabCode[lRec.Level + 1] := 0;
                                lRec.Validate("Presentation Code", wCreatePresentationCode(lTabCode, lRec.Level));
                                lRec.Modify;
                                //#7442
                            end;
                            //#7442//
                            wMoveTree(lRec, lRec, MoveOpt);
                        until lRec.Next = 0;
                    end;
                Moveopt::Right:
                    if lRec.FindSet(true, false) then
                        repeat
                            wMajTab(lRec, lTabCode);
                            if ((lRec.Level = 5) or ((lRec.Level = 4) and (lRec."Line Type" = lRec."line type"::Totaling))) and
                               not LeftTotaling then
                                Error(ErrorLevel);
                            lRec.Level += 1;
                            for i := lRec.Level downto SalesLineOrig.Level + 1 do
                                lTabCode[i] := lTabCode[i - 1];
                            for i := 1 to SalesLineOrig.Level do
                                lTabCode[i] := lTabCodeMove[i];
                            lRec.Validate("Presentation Code", wCreatePresentationCode(lTabCode, lRec.Level));
                            lRec.Modify;
                            wMoveTree(lRec, lRec, MoveOpt);
                        until lRec.Next = 0;
                Moveopt::Up,
              Moveopt::Down:
                    if lRec.FindSet(true, false) then
                        repeat
                            wMajTab(lRec, lTabCode);
                            for i := 1 to SalesLineOrig.Level do
                                lTabCode[i] := lTabCodeMove[i];
                            lRec.Validate("Presentation Code", wCreatePresentationCode(lTabCode, lRec.Level));
                            lRec.Modify;
                            wMoveTree(lRec, lRec, MoveOpt);
                        until lRec.Next = 0;
                else
                    ;
            end;
    end;


    procedure wLeft(var pRec: Record "Sales Line"; Loop: Boolean)
    var
        lRec: Record "Sales Line";
        lTabCode: array[20] of Integer;
        lPresMax: Code[80];
        lCurrent: Record "Sales Line";
        lRec2: Record "Sales Line";
    begin
        with pRec do begin
            if ("Line Type" = "line type"::" ") and ("Attached to Line No." <> 0) and ("No." = '') then
                exit;
            if Level = 0 then
                Level := 1;
            if "Line Type" <> "line type"::Totaling then begin
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");     //vers la gauche
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetRange("Presentation Code", "Presentation Code", CopyStr("Presentation Code", 1, StrLen("Presentation Code") - 3) + '999');
                lRec.SetRange(Level, Level);
                lRec.SetFilter("Line Type", '<>%1', "line type"::" ");
                lRec.SetRange("Structure Line No.", 0);
                if not lRec.IsEmpty then
                    if lRec.FindLast then
                        if (lRec.Level >= Level) and (lRec."Presentation Code" <> "Presentation Code")
                             /*AND (lRec."Line Type" <> lRec."Line Type"::Totaling)*/ then   //ML
                            Error(Text8003900);
                lRec.SetRange("Line Type", "line type"::" ");
                lRec.SetFilter("No.", '<>%1', '');
                if not lRec.IsEmpty then
                    if lRec.FindLast then
                        if (lRec.Level >= Level) and (lRec."Line Type" <> lRec."line type"::Totaling)
                            and (lRec."Presentation Code" <> "Presentation Code") then
                            Error(Text8003900);
            end;

            lRec.Reset;
            lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
            lRec.SetRange("Order Type", "Order Type");
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetFilter("Presentation Code", '<%1', "Presentation Code");
            lRec.SetRange("Structure Line No.", 0);
            if lRec.IsEmpty then
                Error(Text8003916);

            if ("Line Type" = "line type"::Totaling) then begin
                if Loop then begin
                    lPresMax := '';
                    lRec.Reset;
                    lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                    lRec.SetRange("Order Type", "Order Type");
                    lRec.SetRange("Document Type", "Document Type");
                    lRec.SetRange("Document No.", "Document No.");
                    lRec.SetFilter("Presentation Code", '>=%1', "Presentation Code");
                    lRec.SetFilter(Level, '>=%1', Level);
                    lRec.SetFilter("Line No.", '<>%1', "Line No.");
                    lRec.SetRange("Structure Line No.", 0);
                    lRec.SetRange("Line Type", lRec."line type"::Totaling);
                    if not lRec.IsEmpty then
                        if lRec.FindFirst then
                            lPresMax := lRec."Presentation Code";
                    lRec.SetRange("Line Type");
                    if lPresMax <> '' then
                        lRec.SetRange("Presentation Code", "Presentation Code", lPresMax);
                    //lRec.SETFILTER("Presentation Code",'>=%1&<=%2',"Presentation Code",lPresMax);
                    if not lRec.IsEmpty then
                        if lRec.Find('+') then
                            repeat
                                if lRec."Line Type" <> lRec."line type"::Totaling then begin
                                    lRec2 := lRec;
                                    wLeft(lRec2, false);
                                    lRec2.Modify;
                                end;
                            until (lRec.Next(-1) = 0);
                    //#9093
                end;
                //#9093//
            end else begin
                lRec.Reset;                                                                          //Déplacement des lignes suivantes
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code"); //pour les attacher à ce lot
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetFilter("Presentation Code", '>=%1', "Presentation Code");
                lRec.SetFilter("Line No.", '<>%1', "Line No.");
                lRec.SetRange("Attached to Line No.", "Attached to Line No.");
                lRec.SetRange("Structure Line No.", 0);
                if not lRec.IsEmpty then
                    if lRec.FindSet(true, false) then
                        repeat
                            LeftTotaling := true;
                            lRec2 := lRec;
                            wRight(lRec2, LeftTotaling);
                            lRec2.Modify;
                            LeftTotaling := false;
                        until lRec.Next = 0;
                //#9093
                //    END;
                //#9093//
            end;


            wMajTab(pRec, lTabCode);
            lTabCode[Level] := 0;
            Level -= 1;
            if Level = 0 then
                Error(Text8003917);
            lTabCode[Level] += 1;

            if not RefreshPres then
                Validate("Presentation Code", wCreatePresentationCode(lTabCode, Level))
            else begin
                "Presentation Code" := wCreatePresentationCode(lTabCode, Level);
                RefreshSalesLine := pRec;
                RefreshSalesLine.Mark(true);
            end;

            wMoveTree(pRec, pRec, 1);                //Changement de niveau de la descendance
            wAssignAttachedLine(pRec);             //Modification N° ligne attachée
            Modify;

            //Changement de niveau des lignes suivantes
            wShiftLines(pRec, "Presentation Code", "Attached to Line No.", 4);
        end;

    end;


    procedure wRight(var pRec: Record "Sales Line"; AfterMove: Boolean)
    var
        lRec: Record "Sales Line";
        lTabCode: array[20] of Integer;
        lOrigAttach: Integer;
        lOrigpresentCode: Text[255];
        lRec2: Record "Sales Line";
    begin
        with pRec do begin
            if ("Line Type" = "line type"::" ") and ("Attached to Line No." <> 0) and ("No." = '') then
                exit;

            if Level = 0 then
                Level := 1;

            //Recherche si possibilité de déplacer
            //#9088
            //lRec.SETCURRENTKEY("Order Type","Document Type","Document No.","Presentation Code");       //Recherche si possibilité de déplacer
            lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
            //#9088//
            lRec.SetRange("Order Type", "Order Type");
            lRec.SetRange("Document Type", "Document Type");                               //vers la droite
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetFilter("Presentation Code", '<=%1', "Presentation Code");
            lRec.SetFilter("Line No.", '<>%1', "Line No.");
            lRec.SetRange("Line Type", "line type"::Totaling);
            lRec.SetRange("Structure Line No.", 0);
            if not AfterMove then begin
                if lRec.IsEmpty then
                    Error(Text8003916)
                else begin
                    lRec.SetFilter("Line Type", '<>%1', lRec."line type"::" ");
                    if lRec.FindLast then begin
                        if lRec.Level < Level then
                            //#9088
                            //        IF "Line Type" <> "Line Type"::Totaling THEN
                            if lRec."Line Type" <> lRec."line type"::Totaling then
                                //#9088//
                                Error(Text8003901);
                        if (lRec.Level = Level) and (lRec."Line Type" <> lRec."line type"::Totaling) and
                          (lRec."Line Type" <> lRec."line type"::" ") and (lRec."No." <> '') and not MoveAftTot then begin
                            lRec."Line Type" := lRec."line type"::Totaling;
                            Error(Text8003913, lRec."Line Type", Level);
                        end;
                        if (lRec.Level < Level) and (lRec."Line Type" = lRec."line type"::Totaling) and     //ML
                          not MoveAftTot then begin
                            lRec."Line Type" := lRec."line type"::Totaling;
                            Error(Text8003913, lRec."Line Type", Level);
                        end;
                    end;
                end;
            end;


            lRec.SetFilter("Presentation Code", '<%1', "Presentation Code");
            lRec.SetRange("Line Type");
            if lRec.FindLast then;

            lOrigAttach := "Attached to Line No.";
            wMajTab(lRec, lTabCode);                                                             //Changement de niveau
            if (Level = 5) or (("Line Type" = "line type"::Totaling) and (Level = 4)) then
                Error(ErrorLevel);

            Level += 1;
            lTabCode[Level] += 1;

            lOrigpresentCode := "Presentation Code";

            if not RefreshPres then
                Validate("Presentation Code", wCreatePresentationCode(lTabCode, Level))
            else begin
                "Presentation Code" := wCreatePresentationCode(lTabCode, Level);
                RefreshSalesLine := pRec;
                RefreshSalesLine.Mark(true);
            end;

            wMoveTree(pRec, pRec, 2);                //Changement de niveau de la descendance
            wAssignAttachedLine(pRec);             //Modification N° ligne attachée
            Modify;

            Level -= 1;
            wShiftLines(pRec, lOrigpresentCode, lOrigAttach, 3);
            Level += 1;
        end;

        MoveAftTot := false;
    end;


    procedure wRightTotaling(var pRec: Record "Sales Line"; var pTabCode: array[20] of Integer; pAttachedToLine: Integer)
    var
        lRec: Record "Sales Line";
        lRec2: Record "Sales Line";
    begin
        with pRec do begin
            if ("Line Type" = "line type"::" ") and ("Attached to Line No." <> 0) and ("No." = '') then
                exit;

            if Level = 0 then
                Level := 1;

            if (Level = 5) or (("Line Type" = "line type"::Totaling) and (Level = 4)) then
                Error(ErrorLevel);

            Level += 1;
            pTabCode[Level] += 1;

            Validate("Presentation Code", wCreatePresentationCode(pTabCode, Level));
            "Attached to Line No." := pAttachedToLine;
            Modify;
            RefreshSalesLine := pRec;
            RefreshSalesLine.Mark(true);

            wMoveTree(pRec, pRec, 2);           //Changement de niveau de la descendance

        end;
    end;


    procedure wDown(var pRec: Record "Sales Line"; AfterMove: Boolean)
    var
        lRec: Record "Sales Line";
        lTabCode: array[20] of Integer;
        lPresentationCode: Text[250];
        lRec2: Record "Sales Line";
    begin
        with pRec do begin
            if ("Line Type" = "line type"::" ") and ("No." = '') and ("Attached to Line No." <> 0) then
                exit;
            if Level = 0 then
                Level := 1;
            if not AfterMove then begin
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetFilter("Presentation Code", '>%1', "Presentation Code");
                lRec.SetRange("Attached to Line No.", "Attached to Line No.");
                lRec.SetRange("Structure Line No.", 0);
                if lRec.IsEmpty then
                    Error(Text8003914);
            end;
            lRec.FindFirst;
            wExchangePresCode(pRec, lRec, true);
        end;
    end;


    procedure wUp(var pRec: Record "Sales Line"; AfterMove: Boolean)
    var
        lRec: Record "Sales Line";
        lTabCode: array[20] of Integer;
        lPresentationCode: Text[250];
        lRec2: Record "Sales Line";
    begin
        with pRec do begin
            if ("Line Type" = "line type"::" ") and ("No." = '') and ("Attached to Line No." <> 0) then
                exit;
            if Level = 0 then
                Level := 1;
            if not AfterMove /*AND ("Line Type" <> "Line Type"::" ")*/ then begin
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetFilter("Presentation Code", '<%1', "Presentation Code");
                lRec.SetRange("Attached to Line No.", "Attached to Line No.");
                lRec.SetRange("Structure Line No.", 0);
                if lRec.IsEmpty then
                    Error(Text8003915);
            end;
            lRec.FindLast;
            wExchangePresCode(pRec, lRec, true);
        end;

    end;


    procedure OnCopyRecord(var pToSalesLine: Record "Sales Line"; pFromSalesLine: Record "Sales Line"; pEcart: Integer): Integer
    var
        lToTabCode: array[20] of Integer;
        lFromTabCode: array[20] of Integer;
        lRec2: Record "Sales Line";
    begin
        with pToSalesLine do begin
            wMajTab(pToSalesLine, lToTabCode);
            wMajTab(pFromSalesLine, lFromTabCode);
            lToTabCode[1] := lFromTabCode[1] + pEcart;
            if "Line Type" = "line type"::Other then
                "Presentation Code" := '999'
            else
                Validate("Presentation Code", wCreatePresentationCode(lToTabCode, Level));

            if Level > 1 then begin
                lRec2.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.");
                lRec2.SetRange("Order Type", "Order Type");
                lRec2.SetRange("Document Type", "Document Type");
                lRec2.SetRange("Document No.", "Document No.");
                //#7895
                if "Line Type" > "line type"::" " then
                    //#7895//
                    lRec2.SetRange("Presentation Code", wCreatePresentationCode(lToTabCode, Level - 1))
                //#7895
                else
                    lRec2.SetRange("Presentation Code", wCreatePresentationCode(lToTabCode, Level));
                //#7895//
                lRec2.SetRange("Structure Line No.", 0);
                if lRec2.IsEmpty then
                    exit(0);
                lRec2.FindFirst;
                exit(lRec2."Line No.");
            end else
                exit(0);
        end;
    end;


    procedure wMoveAfterTotaling(pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lRec2: Record "Sales Line";
        lTabCode: array[20] of Integer;
        lDiff: array[20] of Integer;
    begin
        with pRec do
            if "Line Type" = "line type"::Totaling then begin
                wMajTab(pRec, lTabCode);
                Clear(lRec);                                                                  //Déplacement des lignes suivantes
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetFilter("Presentation Code", '>=%1', "Presentation Code");
                lRec.SetFilter("Line No.", '<>%1', "Line No.");
                lRec.SetRange("Attached to Line No.", "Attached to Line No.");
                lRec.SetRange("Structure Line No.", 0);
                if not lRec.IsEmpty then begin
                    SetRefreshPres(true);
                    lRec.FindSet(true, false);
                    repeat
                        MoveAftTot := true;
                        if (lRec."Line Type" = lRec."line type"::" ") and (lRec."No." = '') and (lRec."Attached to Line No." = 0) then begin
                            lRec."Presentation Code" := pRec."Presentation Code";
                            lRec.Level := pRec.Level;
                            lRec."Attached to Line No." := pRec."Line No.";
                            lRec.Modify;

                            lRec2.Reset;                                                                  //Déplacement des lignes suivantes
                            lRec2.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                            lRec2.SetRange("Order Type", "Order Type");
                            lRec2.SetRange("Document Type", "Document Type");
                            lRec2.SetRange("Document No.", "Document No.");
                            lRec2.SetFilter("Presentation Code", '>=%1', "Presentation Code");
                            lRec2.SetFilter("Line No.", '<>%1', "Line No.");
                            lRec2.SetRange("Attached to Line No.", "Attached to Line No.");
                            lRec2.SetRange("Structure Line No.", 0);
                            if not lRec2.IsEmpty then
                                if lRec2.Find('-') then
                                    repeat
                                        if not ((lRec2."No." = '') and (lRec2."Line Type" = lRec2."line type"::" ")) then
                                            wUp(lRec2, true);
                                    until lRec2.Next = 0;
                        end else
                            if lRec."Line Type" <> lRec."line type"::Totaling then
                                wRightTotaling(lRec, lTabCode, pRec."Line No.");
                    until lRec.Next = 0;
                    SetRefreshPres(false);

                    lTabCode[pRec.Level] += 1;
                    lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                    lRec.SetRange("Presentation Code",
                                      wCreatePresentationCode(lTabCode, pRec.Level),
                                      CopyStr(wCreatePresentationCode(lTabCode, pRec.Level), 1, StrLen("Presentation Code") - 3) + '999');
                    lTabCode[pRec.Level] -= 1;
                    lRec.SetRange(Level, pRec.Level);
                    lRec.SetRange("Attached to Line No.");
                    if not lRec.IsEmpty then begin
                        lRec2.Reset;
                        lRec.FindFirst;
                        wMajTab(lRec, lDiff);
                        lDiff[pRec.Level] := (lDiff[pRec.Level] - lTabCode[pRec.Level]) - 1;
                        lRec.SetRange(Level);
                        lRec.FindSet(true, true);
                        repeat
                            if (lRec."Line Type" <> lRec."line type"::" ") or (lRec."No." <> '') then begin
                                wMajTab(lRec, lTabCode);
                                lRec2 := lRec;
                                if lRec2."Attached to Line No." <> pRec."Line No." then
                                    lTabCode[pRec.Level] -= lDiff[pRec.Level];
                                lRec2."Presentation Code" := wCreatePresentationCode(lTabCode, lRec2.Level);
                                lRec2.Modify;
                                RefreshSalesLine := lRec2;
                                RefreshSalesLine.Mark(true);
                            end;
                        until lRec.Next = 0;
                    end;

                    RefreshSalesLine.MarkedOnly(true);
                    if not RefreshSalesLine.IsEmpty then begin
                        RefreshSalesLine.FindSet(true, false);
                        repeat
                            RefreshSalesLine.Validate("Presentation Code");
                            RefreshSalesLine.Modify;
                        until RefreshSalesLine.Next = 0;
                    end;
                end;
            end;
    end;


    procedure wNextRecordTextWithNo(var pRec: Record "Sales Line")
    var
        lTabCode: array[20] of Integer;
        lRec: Record "Sales Line";
    begin
        with pRec do
            if (("Line Type" = "line type"::" ") and ("No." <> '')) or ("Line Type" <> "line type"::" ") then begin
                lRec.Reset;
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetRange("Presentation Code", "Presentation Code");
                lRec.SetFilter("Line No.", '<>%1', "Line No.");
                lRec.SetRange("Structure Line No.", 0);
                if not lRec.IsEmpty then
                    if lRec.FindFirst then begin
                        wMajTab(pRec, lTabCode);
                        lTabCode[Level] += 1;
                        "Presentation Code" := wCreatePresentationCode(lTabCode, Level);
                        if lRec.Get("Document Type", "Document No.", "Attached to Line No.") then begin
                            if (lRec."Line Type" <> lRec."line type"::Totaling) then
                                "Attached to Line No." := lRec."Attached to Line No.";
                        end
                        else
                            "Attached to Line No." := 0;
                        wShiftLines(pRec, "Presentation Code", "Attached to Line No.", 4);
                    end;
            end;
    end;


    procedure wInsertBetweenExtendedText(var pRec: Record "Sales Line"; pxRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lRecPrev: Record "Sales Line";
        lRecNext: Record "Sales Line";
    begin
        with pRec do
            if (("Line Type" <> "line type"::" ") and ("No." = '')) or
               (("No." <> '') and ("Line Type" = "line type"::" ") and
                (pxRec."Line Type" <> pxRec."line type"::" ") and (pxRec."No." = ''))
            then begin
                lRec.Reset;
                //PERF
                lRec.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.");
                //PERF//
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                lRec.SetRange("Structure Line No.", 0);
                lRec.SetRange("Line No.", "Line No.");
                if not lRec.IsEmpty then begin
                    if lRec.FindFirst then begin
                        lRec.SetRange("Line No.");
                        lRecNext.Copy(lRec);
                        if lRecNext.Find('>') then
                            if (lRecNext."No." = '') and
                               (lRecNext."Attached to Line No." <> 0) and
                               (lRecNext."Line Type" = lRecNext."line type"::" ")
                            then
                                Error(ErrorInsertBetweenText, pRec."Line Type");
                    end;
                end else
                    if (pxRec."Attached to Line No." <> 0) and
                       (pxRec."Line Type" = pxRec."line type"::Structure)
                    then begin
                        lRecNext.Copy(lRec);
                        GlobalVar.GetAttNo(lRec."Attached to Line No.");
                        lRecNext.SetCurrentkey("Document Type", "Document No.", "Line No.");
                        lRecNext.SetFilter("Line No.", '>%1', "Line No.");
                        lRecNext.SetRange("Attached to Line No.", lRec."Attached to Line No.");
                        if lRecNext.FindLast then begin
                            if (lRecNext."No." = '') and
                               (lRecNext."Attached to Line No." <> 0) and
                               (lRecNext."Line Type" = lRecNext."line type"::" ") and
                               (lRecNext.Level = Level) then
                                Error(ErrorInsertBetweenText, pRec."Line Type");
                        end;
                    end;
            end;
    end;


    procedure wModifyRecordTextWithNo(var pRec: Record "Sales Line")
    var
        lTabCode: array[20] of Integer;
        lRec: Record "Sales Line";
    begin
        with pRec do
            if (("Line Type" = "line type"::" ") and ("No." <> '')) then begin
                if "Attached to Line No." = 0 then
                    exit;
                if lRec.Get("Document Type", "Document No.", "Attached to Line No.") then begin
                    //#4785
                    if (lRec."Presentation Code" <> "Presentation Code") then
                        exit;
                    //#4785//
                    "Attached to Line No." := lRec."Attached to Line No.";
                    if lRec."Line Type" = lRec."line type"::Totaling then begin
                        if Level = 5 then
                            Error(ErrorLevel);
                        Level := lRec.Level + 1;
                        "Attached to Line No." := lRec."Line No.";
                    end;
                end;

                wMajTab(pRec, lTabCode);
                lTabCode[Level] += 1;
                "Presentation Code" := wCreatePresentationCode(lTabCode, Level);
                Modify;
                OnInsert(pRec)
            end;
    end;


    procedure CreateInvoicePresLevel(var pRec: Record "Sales Line")
    var
        lPrevSalesLine: Record "Sales Line";
        lTabCode: array[20] of Integer;
    begin
        lPrevSalesLine.Reset;
        lPrevSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
        lPrevSalesLine.SetRange("Order Type", pRec."Order Type");
        lPrevSalesLine.SetRange("Document Type", pRec."Document Type");
        lPrevSalesLine.SetRange("Document No.", pRec."Document No.");
        lPrevSalesLine.SetRange("Structure Line No.", 0);

        if lPrevSalesLine.IsEmpty then begin                  //Aucune ligne dans le document
            pRec.Level := 1;
            pRec.Validate("Presentation Code", '  1');
            exit;
        end
        else
            lPrevSalesLine.FindLast;

        if (pRec."Attached to Line No." <> 0) and (pRec."Line Type" = 0) and (pRec."No." = '') then begin            //Texte étendu
            if lPrevSalesLine.Get(pRec."Document Type", pRec."Document No.", pRec."Attached to Line No.") then;
            pRec.Level := lPrevSalesLine.Level;
            pRec.Validate("Presentation Code", lPrevSalesLine."Presentation Code");
            exit;
        end;

        if (pRec."Line Type" = pRec."line type"::" ") and (pRec."Attached to Line No." = 0) then begin
            pRec.Level := 1;
            lPrevSalesLine.SetRange(Level, 1);
            if lPrevSalesLine.IsEmpty then
                exit
            else
                lPrevSalesLine.FindLast;
            if lPrevSalesLine."Presentation Code" <> '' then begin
                wMajTab(lPrevSalesLine, lTabCode);
                lTabCode[pRec.Level] += 1;
                pRec.Validate("Presentation Code", wCreatePresentationCode(lTabCode, pRec.Level));
            end else
                pRec.Validate("Presentation Code", '  1');
            exit;
        end;

        if (pRec."Attached to Line No." <> 0) then begin            //Attaché à lot
            if lPrevSalesLine.Get(pRec."Document Type", pRec."Document No.", pRec."Attached to Line No.") then;
        end else begin
            if lPrevSalesLine.IsEmpty then
                exit
            else begin
                lPrevSalesLine.FindLast;
                if (lPrevSalesLine."Line Type" = lPrevSalesLine."line type"::" ") and
                   (lPrevSalesLine."No." = '') then begin
                    lPrevSalesLine.SetFilter("No.", '<>%1', '');
                    lPrevSalesLine.FindLast;
                end;
            end;
        end;

        case lPrevSalesLine."Line Type" of
            lPrevSalesLine."line type"::Totaling:
                if pRec."Line Type" <> pRec."line type"::Totaling then begin
                    pRec.Level := lPrevSalesLine.Level + 1;
                    if (pRec."No." <> '') then
                        pRec."Attached to Line No." := lPrevSalesLine."Line No."
                    else
                        pRec."Attached to Line No." := 0;
                end;
            else begin
                if (pRec."Line Type" <> pRec."Line Type") or (pRec."Attached to Line No." <> 0) then begin
                    pRec.Level := lPrevSalesLine.Level;
                    pRec."Attached to Line No." := lPrevSalesLine."Attached to Line No.";
                end
                else begin
                    if pRec."Attached to Line No." = 0 then
                        pRec.Level := 1;
                end;
            end;
        end;

        lPrevSalesLine.FindLast;

        if lPrevSalesLine."Presentation Code" <> '' then begin
            wMajTab(lPrevSalesLine, lTabCode);
            if (pRec."No." <> '') or (pRec."Line Type" = pRec."line type"::Totaling) then
                lTabCode[pRec.Level] += 1;
            pRec.Validate("Presentation Code", wCreatePresentationCode(lTabCode, pRec.Level));
        end else
            pRec.Validate("Presentation Code", '  1');
    end;


    procedure AttachToTotaling(pRecLoc: Record "Sales Line"; pCurrent: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lTabCode: array[20] of Integer;
    begin
        with pRecLoc do begin
            lRec.Reset;                                                                          //Déplacement des lignes suivantes
            lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code"); //pour les attacher à ce lot
            lRec.SetRange("Order Type", "Order Type");
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetFilter("Presentation Code", '>=%1', pCurrent."Presentation Code");
            lRec.SetFilter("Line No.", '<>%1', "Line No.");
            lRec.SetRange("Attached to Line No.", pCurrent."Attached to Line No.");
            lRec.SetRange("Structure Line No.", 0);
            wMajTab(pRecLoc, lTabCode);
            if not lRec.IsEmpty then
                if lRec.FindSet(true, false) then
                    repeat
                        pCurrent := lRec;
                        lRec."Attached to Line No." := "Line No.";
                        lTabCode[lRec.Level] += 1;
                        lRec.Validate("Presentation Code", wCreatePresentationCode(lTabCode, lRec.Level));
                        lRec.Modify;
                        AttachToTotaling(lRec, pCurrent);
                    until lRec.Next = 0;
        end;
    end;


    procedure OnDetach(var pRec: Record "Sales Line"; pNoOrig: Integer)
    var
        lRec: Record "Sales Line";
        lRecBis: Record "Sales Line";
    begin
        with pRec do
            if ("Structure Line No." = 0) and (("Line Type" <> 0) or ("Attached to Line No." = 0)) then begin
                lRec.Reset;                                                                  //Déplacement des lignes suivantes
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                if ("Line Type" <> "line type"::" ") or ("Attached to Line No." = 0) or ("No." <> '') then
                    lRec.SetFilter("Presentation Code", '>=%1', "Presentation Code")
                else
                    lRec.SetFilter("Presentation Code", '>%1', "Presentation Code");
                //#    lRec.SETFILTER("Line No.",'<>%1&<>%2',"Line No.",pNoOrig);
                lRec.SetFilter("Line No.", '<>%1', pNoOrig);
                lRec.SetRange("Attached to Line No.", "Attached to Line No.");
                lRec.SetRange("Structure Line No.", 0);
                if not lRec.IsEmpty then
                    if lRec.FindSet(true, false) then
                        repeat
                            lRecBis.Copy(lRec);
                            if not lRec.Mark then
                                wDown(lRecBis, true);
                            lRec.Mark(true);
                        until lRec.Next = 0;
            end;
    end;


    procedure SetRefreshPres(pRefreshPres: Boolean)
    begin
        RefreshPres := pRefreshPres;
    end;


    procedure UpdatePresentation(pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lProgressDlg: Codeunit "Progress Dialog2";
    begin
        with pRec do begin
            lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
            lRec.SetRange("Order Type", "Order Type");
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetFilter("Presentation Code", '%1..', "Presentation Code");
            lRec.SetRange("Structure Line No.", 0);
            lProgressDlg.Open(tProgress, lRec.COUNTAPPROX);
            if lRec.FindSet(true, false) then
                repeat
                    lRec.Validate("Presentation Code", lRec."Presentation Code");
                    lRec.Modify;
                    lProgressDlg.Update;
                until lRec.Next = 0;
            lProgressDlg.Close;
        end;
    end;


    procedure ReFreshPresentation(pSalesHeader: Record "Sales Header"; var pProgress: Dialog)
    var
        lSalesLine: Record "Sales Line";
        lSalesLine2: Record "Sales Line";
        lSalesLineTmp: Record "Sales Line" temporary;
        lCurrArrayPres: array[20] of Integer;
        lxCurrArrayPres: array[20] of Integer;
        lArrayAttach: array[20] of Integer;
        lCurrLevel: Integer;
        i: Integer;
        j: Integer;
        lOK: Boolean;
        lMaxLevel: Integer;
        lxRecTmp: Record "Sales Line" temporary;
        lmax: Integer;
        index: Integer;
        lFirstLineTypeNotBlank: Boolean;
        lNextOK: Boolean;
        lStatPres: array[5] of Integer;
        lStatAttach: array[5] of Integer;
        lFirst: Boolean;
        lLevel: Integer;
    begin
        lFirstLineTypeNotBlank := true;
        lFirst := true;

        lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.");
        lSalesLine.SetRange("Order Type", pSalesHeader."Order Type");
        lSalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", pSalesHeader."No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        if lSalesLine.IsEmpty then
            exit;
        //Chargement des données dans une table temporaire

        lSalesLineTmp.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.");

        lSalesLineTmp.DeleteAll;
        lmax := lSalesLine.Count;
        if not lSalesLine.IsEmpty then begin
            lSalesLine.FindSet;
            repeat
                if not lSalesLine.Mark then begin
                    if lSalesLine."Line Type" = lSalesLine."line type"::Other then begin
                        //#5295
                        //        lSalesLine."Presentation Code" := '';
                        lSalesLine."Presentation Code" := '999';
                        //#5295//
                        lSalesLine.Modify;
                        lNextOK := (lSalesLine.Next = 0);
                    end else begin
                        index += 1;
                        pProgress.Update(2, ROUND((index / lmax) * 10000, 1));
                        if lSalesLine.Level = 0 then
                            lSalesLine.Level := 1;

                        lSalesLine2 := lSalesLine;
                        lFirstLineTypeNotBlank := lFirstLineTypeNotBlank and ((lSalesLine."No." = '') and
                                                  (lSalesLine."Line Type" = lSalesLine."line type"::" "));

                        if ((lSalesLine."Line Type" <> lSalesLine."line type"::" ") or lFirstLineTypeNotBlank or
                           ((lSalesLine."Line Type" = lSalesLine."line type"::" ") and (lSalesLine."No." <> ''))) then begin

                            if not lFirst then begin
                                if lSalesLine."Line Type" = lSalesLine."line type"::Totaling then
                                    lStatAttach[lSalesLine.Level] := lSalesLine."Line No.";
                                if (lSalesLine.Level = 1) then
                                    if lSalesLine."Attached to Line No." <> 0 then begin
                                        lSalesLine2."Attached to Line No." := 0;
                                        lSalesLine2.Modify;
                                    end;

                                if lSalesLine.Level > 1 then begin
                                    if lSalesLineTmp.Get(lSalesLine."Document Type", lSalesLine."Document No.",
                                                             lSalesLine."Attached to Line No.") then begin
                                        if lSalesLine.Level = lSalesLineTmp.Level then begin
                                            if lSalesLineTmp."Line Type" <> lSalesLineTmp."line type"::Totaling then begin
                                                lNextOK := true;
                                                while lNextOK do begin
                                                    lNextOK := lSalesLineTmp.Get(lSalesLineTmp."Document Type", lSalesLineTmp."Document No.",
                                                                             lSalesLineTmp."Attached to Line No.");

                                                    if (lSalesLineTmp."Line Type" = lSalesLineTmp."line type"::Totaling) and lNextOK then begin
                                                        lNextOK := false;
                                                        lSalesLine2."Attached to Line No." := lSalesLineTmp."Line No.";
                                                    end else
                                                        lSalesLine2."Attached to Line No." := lStatAttach[lSalesLine.Level - 1];
                                                end;
                                            end;
                                        end else begin
                                            if lSalesLineTmp."Line Type" <> lSalesLineTmp."line type"::Totaling then begin
                                                lNextOK := true;
                                                while lNextOK do begin
                                                    lNextOK := lSalesLineTmp.Get(lSalesLineTmp."Document Type", lSalesLineTmp."Document No.",
                                                                            lSalesLineTmp."Attached to Line No.");
                                                    if (lSalesLineTmp."Line Type" = lSalesLineTmp."line type"::Totaling) and lNextOK then begin
                                                        lNextOK := false;
                                                        lSalesLine2."Attached to Line No." := lSalesLineTmp."Line No.";
                                                    end else
                                                        lSalesLine2."Attached to Line No." := lStatAttach[lSalesLine.Level - 1];
                                                end;
                                            end;
                                        end;
                                    end else
                                        lSalesLine2."Attached to Line No." := lStatAttach[lSalesLine.Level - 1];
                                end;
                                lSalesLine2.Modify;
                                if lSalesLine2."Attached to Line No." <> 0 then
                                    lSalesLineTmp.Get(lSalesLine2."Document Type", lSalesLine2."Document No.", lSalesLine2."Attached to Line No.")
                                else begin
                                    lSalesLineTmp.SetRange(Level, 1);
                                    //#5442
                                    if not lSalesLineTmp.FindLast then
                                        lSalesLineTmp := lSalesLine;
                                    //#5442//
                                end;


                                wMajTab(lSalesLine, lCurrArrayPres);
                                wMajTab(lSalesLineTmp, lxCurrArrayPres);

                                if lSalesLineTmp."Line Type" = lSalesLineTmp."line type"::Totaling then
                                    lStatAttach[lSalesLineTmp.Level] := lSalesLineTmp."Line No.";

                                lLevel := lSalesLineTmp.Level;

                                for i := 1 to lLevel do begin
                                    lOK := lCurrArrayPres[i] = lxCurrArrayPres[i];
                                    if (lxCurrArrayPres[i] = 0) or (lCurrArrayPres[i] = 0) then
                                        lCurrArrayPres[i] := 1
                                    else
                                        lCurrArrayPres[i] := lxCurrArrayPres[i];
                                end;

                                if (lSalesLineTmp."Line Type" = lSalesLineTmp."line type"::Totaling) then
                                    if lCurrArrayPres[lLevel + 1] = 0 then
                                        lCurrArrayPres[lLevel + 1] := 1;

                                if (lSalesLineTmp."Line Type" = lSalesLineTmp."line type"::Totaling) and
                                  (lSalesLine2."Attached to Line No." <> lSalesLineTmp."Attached to Line No.") then
                                    lSalesLineTmp.SetRange(Level, lLevel + 1)
                                else
                                    lSalesLineTmp.SetRange(Level, lLevel);
                                lSalesLineTmp.SetFilter("Presentation Code", '%1', lSalesLineTmp."Presentation Code" + '*');

                                if not lSalesLineTmp.FindLast then begin
                                    lSalesLine2."Presentation Code" := wCreatePresentationCode(lCurrArrayPres, lSalesLineTmp.GetRangeMin(Level));
                                    lSalesLine2.Level := lSalesLineTmp.GetRangeMin(Level);
                                end else begin
                                    lSalesLine2."Presentation Code" := lSalesLineTmp."Presentation Code";
                                    lSalesLine2.Level := lSalesLineTmp.Level;
                                    lSalesLine2."Presentation Code" := wIncPresentation(lSalesLine2, lSalesLine2.Level, 1);
                                end;

                                lSalesLineTmp.SetRange("Presentation Code");
                                lSalesLineTmp.SetRange(Level);

                                lSalesLine2.Modify;
                                lSalesLine2.Validate("Presentation Code");
                            end;
                        end;
                        lSalesLineTmp.Init;
                        lSalesLineTmp.TransferFields(lSalesLine2);
                        lSalesLineTmp.Insert;
                        //#8680
                        if lSalesLine.Type <> lSalesLine.Type::" " then
                            //#8680//
                            lFirst := false;
                    end;
                end;
                lSalesLine.Mark := true;
            until lSalesLine.Next = 0;
        end;
    end;


    procedure wMoveAfterOther(var pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lRec2: Record "Sales Line";
    begin
        with pRec do begin
            if ("Line Type" = "line type"::Other) and (Level > 1) then
                //#5133
                Level := 1;
            //#5295
            //    "Presentation Code" := '';
            "Presentation Code" := '999';
            //#5295
        end;
    end;


    procedure wIncPresentation(pSalesLine: Record "Sales Line"; pLevel: Integer; pInc: Integer) Return: Text[30]
    var
        lTabCode: array[20] of Integer;
        lCode: Text[255];
        i: Integer;
    begin
        //PREPAYMENT
        if pLevel = 0 then
            pLevel := 1;
        //PREPAYMENT//
        wMajTab(pSalesLine, lTabCode);
        lTabCode[pLevel] += pInc;
        Return += wCreatePresentationCode(lTabCode, pSalesLine.Level);
    end;


    procedure wExchangePresCode(var pRecLeft: Record "Sales Line"; var pRecRight: Record "Sales Line"; pValidate: Boolean)
    var
        lTmp: Text[250];
    begin
        lTmp := pRecLeft."Presentation Code";
        if pValidate then begin
            pRecLeft.Validate("Presentation Code", pRecRight."Presentation Code");
            pRecRight.Validate("Presentation Code", lTmp);
        end else begin
            pRecLeft."Presentation Code" := pRecRight."Presentation Code";
            pRecRight."Presentation Code" := lTmp;
            RefreshSalesLine := pRecLeft;
            RefreshSalesLine.Mark(true);
            RefreshSalesLine := pRecRight;
            RefreshSalesLine.Mark(true);
        end;
        pRecLeft.Modify;
        pRecRight.Modify;
        wMoveTree(pRecLeft, pRecLeft, 4);
        wMoveTree(pRecRight, pRecRight, 4);
    end;


    procedure wShiftLines(pRec: Record "Sales Line"; pOrigpresentCode: Text[50]; pAttachedLineNo: Integer; MoveOpt: Option Same,Left,Right,Up,Down)
    var
        lRec: Record "Sales Line";
        lRec2: Record "Sales Line";
    begin
        with pRec do begin
            //Déplacement des lignes suivantes
            lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
            lRec.SetRange("Order Type", "Order Type");
            lRec.SetRange("Document Type", "Document Type");
            lRec.SetRange("Document No.", "Document No.");
            lRec.SetFilter("Presentation Code", '>=%1', pOrigpresentCode);
            lRec.SetRange("Attached to Line No.", pAttachedLineNo);
            lRec.SetFilter("Line No.", '<>%1', "Line No.");
            lRec.SetRange("Structure Line No.", 0);
            //#6341
            lRec.SetFilter("Line Type", '<>%1', "line type"::Other);
            //#6341//

            if not lRec.IsEmpty then begin
                lRec.FindSet(true, true);
                repeat
                    if not ((lRec."No." = '') and (lRec."Line Type" = lRec."line type"::" ")) and not lRec.Mark then begin
                        lRec2 := lRec;
                        case MoveOpt of
                            Moveopt::Up:
                                begin
                                    lRec2.Validate("Presentation Code", wIncPresentation(lRec2, Level, -1));
                                    wMoveTree(lRec2, lRec2, 3);
                                end;
                            Moveopt::Down:
                                begin
                                    lRec2.Validate("Presentation Code", wIncPresentation(lRec2, Level, 1));
                                    wMoveTree(lRec2, lRec2, 4);
                                end;
                        end;
                        lRec2.Modify;
                        lRec.Mark(true);
                    end;
                until lRec.Next = 0;
            end;
        end;
    end;


    procedure wAssignAttachedLine(var pRec: Record "Sales Line")
    var
        lRec: Record "Sales Line";
        lTabCode: array[20] of Integer;
    begin
        with pRec do begin
            if not (("Line Type" = "line type"::" ") and ("No." = '')) and (Level = 1) then
                "Attached to Line No." := 0
            else begin
                lRec.Reset;
                lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                lRec.SetRange("Order Type", "Order Type");
                lRec.SetRange("Document Type", "Document Type");
                lRec.SetRange("Document No.", "Document No.");
                wMajTab(pRec, lTabCode);
                lRec.SetRange("Presentation Code", wCreatePresentationCode(lTabCode, Level - 1));
                lRec.SetRange("Structure Line No.", 0);
                if lRec.FindFirst then begin
                    if lRec."Line Type" = lRec."line type"::Totaling then
                        "Attached to Line No." := lRec."Line No."
                    else
                        "Attached to Line No." := lRec."Attached to Line No.";
                end else
                    "Attached to Line No." := 0;
            end;
        end;
    end;


    procedure fNeedShift(pRec: Record "Sales Line") return: Boolean
    var
        lParentRec: Record "Sales Line";
    begin
        //#7442
        return := true;
        if (pRec."Attached to Line No." <> 0) then begin
            lParentRec.SetRange("Document Type", pRec."Document Type");
            lParentRec.SetRange("Document No.", pRec."Document No.");
            lParentRec.SetRange("Line No.", pRec."Attached to Line No.");
            if (not lParentRec.IsEmpty()) then begin
                lParentRec.FindFirst;
                return := not (pRec.Level <= lParentRec.Level);
            end;
        end;
        //#7442//
    end;


    procedure gGetFilter(pRec: Record "Sales Line") Return: Text[250]
    var
        lTabCode: array[20] of Integer;
    begin
        wMajTab(pRec, lTabCode);
        lTabCode[pRec.Level + 1] := 1;
        Return := '''' + wCreatePresentationCode(lTabCode, pRec.Level + 1) + '''';
        lTabCode[pRec.Level + 1] := 999;
        Return := Return + '..' + wCreatePresentationCode(lTabCode, pRec.Level + 1);
    end;
}

