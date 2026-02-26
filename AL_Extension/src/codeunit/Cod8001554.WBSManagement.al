Codeunit 8001554 "WBS Management"
{
    //GL2024  ID dans Nav 2009 : "8035007"
    trigger OnRun()
    begin
    end;

    var
        LeftTotaling: Boolean;
        ErrorIndentation: label 'You are limited at 4 levels of totaling.';
        Text8003900: label 'You must delete or change the level of the next line.\The current line cannot have a down tree.';
        Text8003901: label 'The level of the previous line is incompatible with this move.';
        Text8003902: label 'You mustn''t change %1 in %2, because this line has a down tree.';
        Text8003913: label 'You must have in the previous lines %1 level %2.';
        Text8003914: label 'You must move to the left before to move down.';
        Text8003915: label 'You must move to the left before to move up.';
        Text8003916: label 'You mustn''t move a line without a totaling line.';
        Text8003917: label 'This move is not possible.';
        RefreshPres: Boolean;
        MoveAftTot: Boolean;
        RefreshSalesLine: Record "Planning Line";
        tDeleteDesc: label 'Do you want to delete the Task of this group';


    procedure OnInsert(var pRec: Record "Planning Line"; pFormSource: Boolean)
    var
        lRec: Record "Planning Line";
        lRecBis: Record "Planning Line";
        lStruct: Record "Planning Line";
        lIndentation: Integer;
        lAttachLine: Code[20];
        lCurrAttachedLine: Code[20];
        lTabCode: array[2, 20] of Integer;
        lDiff: Integer;
        lIncSuite: Boolean;
    begin
        with pRec do begin
            lRec.Reset;
            lRec.SetCurrentkey("Project Header No.", "WBS Code");
            lRec.SetRange("Project Header No.", "Project Header No.");
            if Type = Type::"Group Task" then
                lRec.SetFilter("WBS Code", '%1..', "WBS Code")
            else
                lRec.SetRange("WBS Code", "WBS Code", CopyStr("WBS Code", 1, StrLen("WBS Code") - 3) + '999');
            lRec.SetFilter("Task No.", '<>%1', "Task No.");
            lRec.SetRange("Attached To Task No.", "Attached To Task No.");
            if (Type = Type::"Group Task") and (Indentation > 1) and pFormSource then begin
                lAttachLine := "Attached To Task No.";
                lMajTab("WBS Code", Indentation, lTabCode[1]);
                lDiff -= (lTabCode[1, Indentation] - 1);
                lIncIndent(Indentation, -1);
                lTabCode[1, Indentation] += 1;
                Validate("WBS Code", lCreatePresentationCode(lTabCode[1], Indentation));
            end;

            if (Indentation = 1) then
                "Attached To Task No." := ''
            else
                if (Type = Type::"Group Task") and lRecBis.Get(lAttachLine) then begin
                    "Attached To Task No." := lRecBis."Attached To Task No.";
                end;

            lRec.SetFilter("Attached To Task No.", '%1|%2', "Attached To Task No.", lAttachLine);
            if lRec.IsEmpty then
                exit;


            if Indentation = 0 then
                Indentation := 1;

            lIndentation := Indentation;

            lRec.FindSet(true, true);
            repeat
                if not lRec.Mark then begin
                    lRecBis.Copy(lRec);
                    if pRec.Type = pRec.Type::"Group Task" then begin
                        if (lRecBis.Indentation = Indentation + 1) and
                          (lAttachLine = lRecBis."Attached To Task No.") then
                            lRecBis."Attached To Task No." := "Task No.";
                        lRecBis.Validate("WBS Code", fIncWBS(lRecBis."WBS Code", lRecBis.Indentation, lIndentation, 1));
                        lMajTab(lRecBis."WBS Code", lRecBis.Indentation, lTabCode[2]);
                        if lTabCode[2, lIndentation] = lTabCode[1, lIndentation] then
                            lRecBis.Validate("WBS Code", fIncWBS(lRecBis."WBS Code", lRecBis.Indentation, lIndentation, lDiff));
                    end else
                        lRecBis.Validate("WBS Code", fIncWBS(lRecBis."WBS Code", lRecBis.Indentation, lIndentation, 1));
                    lMoveTree(lRecBis, lRecBis, 4);
                    lRecBis.Modify;
                end;
                lRec.Mark(true);
            until lRec.Next = 0;
        end;
    end;


    procedure OnDelete(pRec: Record "Planning Line")
    var
        lRec: Record "Planning Line";
        lRecBis: Record "Planning Line";
        llevel: Integer;
        lConfirm: Boolean;
    begin
        // suppression de la descendance
        with pRec do begin
            if (Type = Type::"Group Task") and ("WBS Code" <> '') then begin
                lRec.SetRange("Project Header No.", "Project Header No.");
                lRec.SetRange("Attached To Task No.", "Task No.");
                Dummy := lRec.IsEmpty;
                if Dummy then
                    lConfirm := Dummy
                else
                    lConfirm := Confirm(tDeleteDesc, false);
                if lConfirm then begin
                    lRec.ModifyAll(Dummy, true);
                    lRec.DeleteAll(true);
                end;
            end;
        end;

        lShiftLines(pRec, pRec."WBS Code", pRec."Attached To Task No.", 3);
    end;


    procedure OnDeleteAll(pRec: Record "Planning Header")
    var
        lRec: Record "Planning Line";
    begin
        // suppression de la descendance
        with pRec do begin
            lRec.SetRange("Project Header No.", "No.");
            if not lRec.IsEmpty then begin
                lRec.ModifyAll(Dummy, true);
                lRec.DeleteAll(true);
            end;
        end;
    end;


    procedure OnNewRecord(var pRec: Record "Planning Line"; pxRec: Record "Planning Line"; pBelowxRec: Boolean; pMulti: Boolean)
    var
        lRec: Record "Planning Line";
        lOk: Boolean;
        lTabCode: array[20] of Integer;
        lRecordID: RecordID;
        i: Integer;
    begin

        with pRec do begin
            //gestion de "Project Header No."
            pRec."Project Header No." := pxRec."Project Header No.";
            //Initialise le N° de projet
            lInitProjectHeader(pRec);
            if "Task No." = '' then begin
                lRec.SetRange("Project Header No.", "Project Header No.");
                lRec.SetCurrentkey("Project Header No.", "WBS Code");
                if "WBS Code" = '' then begin
                    if not pBelowxRec then
                        lRec.SetFilter("WBS Code", '<%1', pxRec."WBS Code");

                    lOk := not lRec.IsEmpty;
                    if not lOk then begin
                        Indentation := 1;
                        "WBS Code" := '  1';
                        "Attached To Task No." := '';
                    end else begin
                        //Calcul du attached to Line No.
                        lRec.FindLast;
                        if lRec.Type = lRec.Type::"Group Task" then begin
                            Indentation := lRec.Indentation + 1;
                            "Attached To Task No." := lRec."Task No.";
                        end else begin
                            Indentation := lRec.Indentation;
                            "Attached To Task No." := lRec."Attached To Task No.";
                        end;
                        //Calcul du "WBS Code"
                        lMajTab(lRec."WBS Code", Indentation, lTabCode);
                        lTabCode[Indentation] += 1;
                        "WBS Code" := lCreatePresentationCode(lTabCode, Indentation);
                    end;
                end;
            end;

            lJobAssign(pRec);

            //  IF EVALUATE(lRecordID,GETFILTER("Source Record ID")) THEN
            //    "Source Record ID" := lRecordID;

        end;
    end;


    procedure wLeft(var pRec: Record "Planning Line"; Loop: Boolean)
    var
        lRec: Record "Planning Line";
        lCurrent: Record "Planning Line";
        lRec2: Record "Planning Line";
        lTabCode: array[20] of Integer;
        lPresMax: Code[80];
    begin
        with pRec do begin
            if Indentation = 0 then
                Indentation := 1;
            if Type <> Type::"Group Task" then begin
                lRec.SetCurrentkey("Project Header No.", "WBS Code");     //vers la gauche
                lRec.SetRange("Project Header No.", "Project Header No.");
                lRec.SetRange("WBS Code", "WBS Code", CopyStr("WBS Code", 1, StrLen("WBS Code") - 3) + '999');
                lRec.SetRange(Indentation, Indentation);
                if not lRec.IsEmpty then
                    if lRec.FindLast then
                        if (lRec.Indentation >= Indentation) and (lRec."WBS Code" <> "WBS Code")
                             /*AND (lRec.Type <> lRec.Type::G)*/ then   //ML
                            Error(Text8003900);
                if not lRec.IsEmpty then
                    if lRec.FindLast then
                        if (lRec.Indentation >= Indentation) and (lRec.Type <> lRec.Type::"Group Task")
                            and (lRec."WBS Code" <> "WBS Code") then
                            Error(Text8003900);
            end;

            lRec.Reset;
            lRec.SetCurrentkey("Project Header No.", "WBS Code");
            lRec.SetRange("Project Header No.", "Project Header No.");
            lRec.SetFilter("WBS Code", '<%1', "WBS Code");
            if lRec.IsEmpty then
                Error(Text8003916);

            if (Type = Type::"Group Task") then begin
                if Loop then begin
                    lPresMax := '';
                    lRec.Reset;
                    lRec.SetCurrentkey("Project Header No.", "WBS Code");
                    lRec.SetRange("Project Header No.", "Project Header No.");
                    lRec.SetFilter("WBS Code", '>=%1', "WBS Code");
                    lRec.SetFilter(Indentation, '>=%1', Indentation);
                    lRec.SetFilter("Task No.", '<>%1', "Task No.");
                    lRec.SetRange(Type, lRec.Type::"Group Task");
                    if not lRec.IsEmpty then
                        if lRec.FindFirst then
                            lPresMax := lRec."WBS Code";
                    lRec.SetRange(Type);
                    if lPresMax <> '' then
                        lRec.SetRange("WBS Code", "WBS Code", lPresMax);
                    if not lRec.IsEmpty then
                        if lRec.Find('+') then
                            repeat
                                if lRec.Type <> lRec.Type::"Group Task" then begin
                                    lRec2 := lRec;
                                    wLeft(lRec2, false);
                                    lRec2.Modify;
                                end;
                            until (lRec.Next(-1) = 0);
                end else begin

                    lRec.Reset;                                                                          //Déplacement des lignes suivantes
                    lRec.SetCurrentkey("Project Header No.", "WBS Code"); //pour les attacher à ce lot
                    lRec.SetRange("Project Header No.", "Project Header No.");
                    lRec.SetFilter("WBS Code", '>=%1', "WBS Code");
                    lRec.SetFilter("Task No.", '<>%1', "Task No.");
                    lRec.SetRange("Attached To Task No.", "Attached To Task No.");
                    if not lRec.IsEmpty then
                        if lRec.Find('-') then
                            repeat
                                LeftTotaling := true;
                                lRec2 := lRec;
                                wRight(lRec2, LeftTotaling);
                                lRec2.Modify;
                                LeftTotaling := false;
                            until lRec.Next = 0;
                end;
            end;


            lMajTab(pRec."WBS Code", pRec.Indentation, lTabCode);
            lTabCode[Indentation] := 0;
            lIncIndent(Indentation, -1);
            lTabCode[Indentation] += 1;

            if not RefreshPres then
                Validate("WBS Code", lCreatePresentationCode(lTabCode, Indentation))
            else begin
                Validate("WBS Code", lCreatePresentationCode(lTabCode, Indentation));
                RefreshSalesLine := pRec;
                RefreshSalesLine.Mark(true);
            end;

            lMoveTree(pRec, pRec, 1);                //Changement de niveau de la descendance
            lAssignAttachedLine(pRec);             //Modification N° ligne attachée
            Modify;

            //Changement de niveau des lignes suivantes
            lShiftLines(pRec, "WBS Code", "Attached To Task No.", 4);
        end;

    end;


    procedure wRight(var pRec: Record "Planning Line"; AfterMove: Boolean)
    var
        lRec: Record "Planning Line";
        lRec2: Record "Planning Line";
        lTabCode: array[20] of Integer;
        lOrigAttach: Code[20];
        lOrigpresentCode: Text[255];
    begin
        with pRec do begin
            if Indentation = 0 then
                Indentation := 1;

            lRec.SetCurrentkey("Project Header No.", "WBS Code");       //Recherche si possibilité de déplacer
            lRec.SetRange("Project Header No.", "Project Header No.");                               //vers la droite
            lRec.SetFilter("WBS Code", '<=%1', "WBS Code");
            lRec.SetFilter("Task No.", '<>%1', "Task No.");
            lRec.SetRange(Type, Type::"Group Task");
            if not AfterMove then begin
                if lRec.IsEmpty then
                    Error(Text8003916)
                else begin
                    lRec.SetFilter(Type, '<>%1', lRec.Type::" ");
                    if lRec.FindLast then begin
                        if lRec.Indentation < Indentation then
                            if Type <> Type::"Group Task" then
                                Error(Text8003901);
                        if (lRec.Indentation = Indentation) and (lRec.Type <> lRec.Type::"Group Task") and not MoveAftTot then begin
                            lRec.Type := lRec.Type::"Group Task";
                            Error(Text8003913, lRec.Type, Indentation);
                        end;
                        if (lRec.Indentation < Indentation) and (lRec.Type = lRec.Type::"Group Task") and     //ML
                          not MoveAftTot then begin
                            lRec.Type := lRec.Type::"Group Task";
                            Error(Text8003913, lRec.Type, Indentation);
                        end;
                    end;
                end;
            end;

            lRec.SetFilter("WBS Code", '<%1', "WBS Code");
            lRec.SetRange(Type);
            if lRec.FindLast then;

            lOrigAttach := "Attached To Task No.";
            lMajTab(lRec."WBS Code", lRec.Indentation, lTabCode);  //Changement de niveau
            if (Indentation > 5) or ((Type = Type::"Group Task") and (Indentation = 5)) then
                Error(ErrorIndentation);

            lIncIndent(Indentation, 1);
            lTabCode[Indentation] += 1;

            lOrigpresentCode := "WBS Code";

            if not RefreshPres then
                Validate("WBS Code", lCreatePresentationCode(lTabCode, Indentation))
            else begin
                Validate("WBS Code", lCreatePresentationCode(lTabCode, Indentation));
                RefreshSalesLine := pRec;
                RefreshSalesLine.Mark(true);
            end;

            lMoveTree(pRec, pRec, 2);                //Changement de niveau de la descendance
            lAssignAttachedLine(pRec);             //Modification N° ligne attachée
            Modify;

            lIncIndent(Indentation, -1);
            lShiftLines(pRec, lOrigpresentCode, lOrigAttach, 3);
            lIncIndent(Indentation, 1);
        end;

        MoveAftTot := false;
    end;


    procedure wRightTotaling(var pRec: Record "Planning Line"; var pTabCode: array[20] of Integer; pAttachedToLine: Code[20])
    var
        lRec: Record "Planning Line";
        lRec2: Record "Planning Line";
    begin
        with pRec do begin
            if Indentation = 0 then
                Indentation := 1;

            if (Indentation = 5) or ((Type = Type::"Group Task") and (Indentation = 4)) then
                Error(ErrorIndentation);

            lIncIndent(Indentation, 1);
            pTabCode[Indentation] += 1;

            Validate("WBS Code", lCreatePresentationCode(pTabCode, Indentation));
            "Attached To Task No." := pAttachedToLine;
            Modify;
            RefreshSalesLine := pRec;
            RefreshSalesLine.Mark(true);
            lMoveTree(pRec, pRec, 2);           //Changement de niveau de la descendance
        end;
    end;


    procedure wDown(var pRec: Record "Planning Line"; AfterMove: Boolean)
    var
        lRec: Record "Planning Line";
        lRec2: Record "Planning Line";
        lTabCode: array[20] of Integer;
        lPresentationCode: Text[250];
    begin
        with pRec do begin
            if Indentation = 0 then
                Indentation := 1;
            if not AfterMove then begin
                lRec.SetCurrentkey("Project Header No.", "WBS Code");
                lRec.SetRange("Project Header No.", "Project Header No.");
                lRec.SetFilter("WBS Code", '>%1', "WBS Code");
                lRec.SetRange("Attached To Task No.", "Attached To Task No.");

                if lRec.IsEmpty then
                    Error(Text8003914);
            end;
            lRec.FindFirst;
            lExchangePresCode(pRec, lRec, true);
        end;
    end;


    procedure wUp(var pRec: Record "Planning Line"; AfterMove: Boolean)
    var
        lRec: Record "Planning Line";
        lRec2: Record "Sales Line";
        lTabCode: array[20] of Integer;
        lPresentationCode: Text[250];
    begin
        with pRec do begin
            if Indentation = 0 then
                Indentation := 1;
            if not AfterMove /*AND (Type <> Type::" ")*/ then begin
                lRec.SetCurrentkey("Project Header No.", "WBS Code");
                lRec.SetRange("Project Header No.", "Project Header No.");
                lRec.SetFilter("WBS Code", '<%1', "WBS Code");
                lRec.SetRange("Attached To Task No.", "Attached To Task No.");

                if lRec.IsEmpty then
                    Error(Text8003915);
            end;
            lRec.FindLast;
            lExchangePresCode(pRec, lRec, true);
        end;

    end;

    local procedure lAssignAttachedLine(var pRec: Record "Planning Line")
    var
        lRec: Record "Planning Line";
        lTabCode: array[20] of Integer;
    begin
        with pRec do begin
            if (Indentation = 1) then
                "Attached To Task No." := ''
            else begin
                lRec.Reset;
                lRec.SetCurrentkey("Project Header No.", "WBS Code");
                lRec.SetRange("Project Header No.", "Project Header No.");
                lMajTab("WBS Code", Indentation, lTabCode);
                lRec.SetRange("WBS Code", lCreatePresentationCode(lTabCode, Indentation - 1));

                if lRec.FindFirst then begin
                    if lRec.Type = lRec.Type::"Group Task" then
                        "Attached To Task No." := lRec."Task No."
                    else
                        "Attached To Task No." := lRec."Attached To Task No.";
                end else
                    "Attached To Task No." := '';
            end;
        end;
    end;

    local procedure lExchangePresCode(var pRecLeft: Record "Planning Line"; var pRecRight: Record "Planning Line"; pValidate: Boolean)
    var
        lTmp: Text[250];
    begin
        lTmp := pRecLeft."WBS Code";
        if pValidate then begin
            pRecLeft.Validate("WBS Code", pRecRight."WBS Code");
            pRecRight.Validate("WBS Code", lTmp);
        end else begin
            pRecLeft.Validate("WBS Code", pRecRight."WBS Code");
            pRecRight.Validate("WBS Code", lTmp);
            RefreshSalesLine := pRecLeft;
            RefreshSalesLine.Mark(true);
            RefreshSalesLine := pRecRight;
            RefreshSalesLine.Mark(true);
        end;
        pRecLeft.Modify;
        pRecRight.Modify;
        lMoveTree(pRecLeft, pRecLeft, 4);
        lMoveTree(pRecRight, pRecRight, 4);
    end;

    local procedure lMoveTree(SalesLine: Record "Planning Line"; SalesLineOrig: Record "Planning Line"; MoveOpt: Option Same,Left,Right,Up,Down)
    var
        lRec: Record "Planning Line";
        lTabCode: array[20] of Integer;
        i: Integer;
        lTabCodeMove: array[20] of Integer;
        lRec2: Record "Planning Line";
        lShift: Boolean;
    begin
        if (SalesLineOrig.Type <> SalesLineOrig.Type::"Group Task") then
            exit;

        lMajTab(SalesLineOrig."WBS Code", SalesLineOrig.Indentation, lTabCodeMove);
        lRec.Reset;
        lRec.SetCurrentkey("Attached To Task No.");
        lRec.SetRange("Project Header No.", SalesLine."Project Header No.");
        lRec.SetRange("Attached To Task No.", SalesLine."Task No.");
        if not lRec.IsEmpty then
            case MoveOpt of
                Moveopt::Left:
                    begin
                        lRec.Find('-');
                        repeat
                            //#7442
                            lShift := fNeedShift(lRec);
                            if (lShift) then begin
                                //#7442//

                                lMajTab(lRec."WBS Code", lRec.Indentation, lTabCode);
                                for i := 1 to SalesLineOrig.Indentation do
                                    lTabCode[i] := lTabCodeMove[i];
                                lIncIndent(lRec.Indentation, -1);
                                for i := SalesLineOrig.Indentation + 1 to lRec.Indentation do
                                    lTabCode[i] := lTabCode[i + 1];
                                lTabCode[lRec.Indentation + 1] := 0;
                                lRec.Validate("WBS Code", lCreatePresentationCode(lTabCode, lRec.Indentation));
                                lRec.Modify;
                                //#7442
                            end;
                            //#7442//
                            lMoveTree(lRec, lRec, MoveOpt);
                        until lRec.Next = 0;
                    end;
                Moveopt::Right:
                    if lRec.Find('-') then
                        repeat
                            lMajTab(lRec."WBS Code", lRec.Indentation, lTabCode);
                            if ((lRec.Indentation = 5) or ((lRec.Indentation = 4) and (lRec.Type = lRec.Type::"Group Task"))) and
                               not LeftTotaling then
                                Error(ErrorIndentation);
                            lIncIndent(lRec.Indentation, 1);
                            for i := lRec.Indentation downto SalesLineOrig.Indentation + 1 do
                                lTabCode[i] := lTabCode[i - 1];
                            for i := 1 to SalesLineOrig.Indentation do
                                lTabCode[i] := lTabCodeMove[i];
                            lRec.Validate("WBS Code", lCreatePresentationCode(lTabCode, lRec.Indentation));
                            lRec.Modify;
                            lMoveTree(lRec, lRec, MoveOpt);
                        until lRec.Next = 0;
                Moveopt::Up,
              Moveopt::Down:
                    if lRec.Find('-') then
                        repeat
                            lMajTab(lRec."WBS Code", lRec.Indentation, lTabCode);
                            for i := 1 to SalesLineOrig.Indentation do
                                lTabCode[i] := lTabCodeMove[i];
                            lRec.Validate("WBS Code", lCreatePresentationCode(lTabCode, lRec.Indentation));
                            lRec.Modify;
                            lMoveTree(lRec, lRec, MoveOpt);
                        until lRec.Next = 0;
                else
                    ;
            end;
    end;

    local procedure lShiftLines(pRec: Record "Planning Line"; pOrigWBSCode: Text[80]; pAttachedLineNo: Code[20]; MoveOpt: Option Same,Left,Right,Up,Down)
    var
        lRec: Record "Planning Line";
        lRec2: Record "Planning Line";
    begin
        with pRec do begin
            //Déplacement des lignes suivantes
            lRec.SetCurrentkey("Project Header No.", "WBS Code");
            lRec.SetRange("Project Header No.", "Project Header No.");
            lRec.SetFilter("WBS Code", '>=%1', pOrigWBSCode);
            lRec.SetRange("Attached To Task No.", pAttachedLineNo);
            lRec.SetFilter("Task No.", '<>%1', "Task No.");
            if not lRec.IsEmpty then begin
                lRec.FindSet(true, true);
                repeat
                    if not lRec.Mark then begin
                        lRec2 := lRec;
                        case MoveOpt of
                            Moveopt::Up:
                                begin
                                    lRec2.Validate("WBS Code", fIncWBS(lRec2."WBS Code", Indentation, Indentation, -1));
                                    lMoveTree(lRec2, lRec2, 3);
                                end;
                            Moveopt::Down:
                                begin
                                    lRec2.Validate("WBS Code", fIncWBS(lRec2."WBS Code", Indentation, Indentation, 1));
                                    lMoveTree(lRec2, lRec2, 4);
                                end;
                        end;
                        lRec2.Modify;
                        lRec.Mark(true);
                    end;
                until lRec.Next = 0;
            end;
        end;
    end;


    procedure gGetFilter(pRec: Record "Planning Line") Return: Text[100]
    var
        lTabCode: array[20] of Integer;
    begin
        lMajTab(pRec."WBS Code", pRec.Indentation, lTabCode);
        lTabCode[pRec.Indentation + 1] := 1;
        Return := '''' + lCreatePresentationCode(lTabCode, pRec.Indentation + 1) + '''';
        lTabCode[pRec.Indentation + 1] := 999;
        Return := Return + '..' + lCreatePresentationCode(lTabCode, pRec.Indentation + 1);
    end;

    local procedure lCreatePresentationCode(TabCode: array[20] of Integer; Niveau: Integer) Return: Text[80]
    var
        i: Integer;
    begin
        for i := 1 to Niveau do begin
            if Return <> '' then
                Return += '.';
            Return += CopyStr('   ', 1, 3 - StrLen(Format(TabCode[i]))) + Format(TabCode[i]);
        end;
    end;

    local procedure lMajTab(pCode: Text[100]; pLevel: Integer; var TabCode: array[20] of Integer)
    var
        i: Integer;
    begin
        Clear(TabCode);
        if pCode = '' then
            exit;

        for i := 1 to pLevel do begin
            if StrPos(pCode, '.') <> 0 then begin
                Evaluate(TabCode[i], CopyStr(pCode, 1, StrPos(pCode, '.') - 1));
                pCode := CopyStr(pCode, StrPos(pCode, '.') + 1);
            end else begin
                Evaluate(TabCode[i], pCode);
                pCode := '0';
            end;
            if TabCode[i] < 0 then
                TabCode[i] := 0;
        end;
    end;


    procedure fIncWBS(pCode: Text[100]; pLevel: Integer; pLevelToInc: Integer; pInc: Integer) Return: Text[80]
    var
        lTabCode: array[20] of Integer;
        lCode: Text[255];
        i: Integer;
    begin
        lMajTab(pCode, pLevel, lTabCode);
        lTabCode[pLevelToInc] += pInc;
        Return += lCreatePresentationCode(lTabCode, pLevel);
    end;

    local procedure fNeedShift(pRec: Record "Planning Line") return: Boolean
    var
        lParentRec: Record "Planning Line";
    begin
        //#7442
        return := true;
        if (pRec."Attached To Task No." <> '') then begin
            lParentRec.SetRange("Project Header No.", pRec."Project Header No.");
            lParentRec.SetRange("Task No.", pRec."Attached To Task No.");
            if (not lParentRec.IsEmpty()) then begin
                lParentRec.FindFirst;
                return := not (pRec.Indentation <= lParentRec.Indentation);
            end;
        end;
        //#7442//
    end;

    local procedure lIncIndent(var pIndent: Integer; pInc: Integer)
    begin
        pIndent := pIndent + pInc;
        if pIndent = 0 then begin
            pIndent := 1;
            Error(Text8003917);
        end;
    end;


    procedure lJobAssign(var pRec: Record "Planning Line")
    var
        lRecHeader: Record "Planning Header";
        lJob: Record Job;
    begin
        //affectation de l'affaire
        if lRecHeader.Get(pRec."Project Header No.") then begin
            pRec."Job No." := lRecHeader."Job No.";
            if lJob.Get(lRecHeader."Job No.") then
                pRec."Job Task No." := lJob.gGetDefaultJobTask;
            pRec."Responsibility Center" := lRecHeader."Responsibility Center";
            pRec."Person Responsible" := lRecHeader."Person Responsible";
            pRec."Source Record ID" := lRecHeader."Source Record ID";
        end;
    end;

    local procedure lInitProjectHeader(var pRec: Record "Planning Line")
    var
        i: Integer;
    begin
        while (pRec."Project Header No." = '') and (i < 10) do begin
            pRec.FilterGroup(i);
            if pRec.GetFilter("Project Header No.") <> '' then
                pRec."Project Header No." := pRec.GetRangemax("Project Header No.");
            pRec.FilterGroup(0);
            i += 1;
        end;
    end;
}

