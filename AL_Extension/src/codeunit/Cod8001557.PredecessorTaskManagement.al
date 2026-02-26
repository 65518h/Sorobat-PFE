Codeunit 8001557 "Predecessor Task Management"
{
    //GL2024  ID dans Nav 2009 : "8035010"
    trigger OnRun()
    begin
    end;

    var
        Text001: label 'la référence interne que vous venez de saisir ne correspond pas à une tâche';
        Text002: label 'Référence circulaire.\ Vous ne pouvez pas attacher une tache sur elle-même';


    procedure GetPredecessor(pRec: Record "Planning Line") return: Text[250]
    var
        lPlaTaskPred: Record "Planning Task Predecessor";
        lRec: Record "Planning Line";
        lCode: Text[30];
        lPlaTaskPred2: Record "Planning Task Predecessor";
    begin
        lPlaTaskPred.SetRange("Project Header", pRec."Project Header No.");
        lPlaTaskPred.SetRange("Task No.", pRec."Task No.");
        if lPlaTaskPred.IsEmpty then
            exit('');
        lPlaTaskPred.FindSet(false, false);
        repeat
            if lRec.Get(lPlaTaskPred."Task No. Predecessor") then begin
                if lRec."Internal Reference" <> '' then
                    lCode := lRec."Internal Reference"
                else
                    lCode := DelChr(lRec."WBS Code", '=', ' ');
                if return = '' then
                    return := lCode
                else
                    return := return + ',' + lCode;
            end;
        until lPlaTaskPred.Next = 0;
    end;


    procedure SetPredecessor(pRec: Record "Planning Line"; pValue: Text[1024])
    var
        lPlaTaskPred: Record "Planning Task Predecessor";
        lNb: Integer;
        i: Integer;
        lTaskNo: Text[20];
    begin
        lNb := lCountComma(pValue, ',');
        lPlaTaskPred.SetRange("Task No.", pRec."Task No.");
        lPlaTaskPred.DeleteAll;
        if lNb = 1 then
            lSetRecord(pRec, pValue, false)
        else
            for i := 1 to lNb do
                lSetRecord(pRec, SelectStr(i, pValue), false);
    end;


    procedure GetNext(pRec: Record "Planning Line") return: Text[250]
    var
        lPlaTaskPred: Record "Planning Task Predecessor";
        lRec: Record "Planning Line";
        lCode: Text[30];
    begin
        lPlaTaskPred.SetRange("Project Header", pRec."Project Header No.");
        lPlaTaskPred.SetRange("Task No. Predecessor", pRec."Task No.");
        if lPlaTaskPred.IsEmpty then
            exit('');
        lPlaTaskPred.FindSet(false, false);
        repeat
            if lRec.Get(lPlaTaskPred."Task No.") then begin
                if lRec."Internal Reference" <> '' then
                    lCode := lRec."Internal Reference"
                else
                    lCode := DelChr(lRec."WBS Code", '=', ' ');
                if return = '' then
                    return := lCode
                else
                    return := return + ',' + lCode;
            end;
        until lPlaTaskPred.Next = 0;
    end;


    procedure SetNext(pRec: Record "Planning Line"; pValue: Text[1024])
    var
        lPlaTaskPred: Record "Planning Task Predecessor";
        lNb: Integer;
        i: Integer;
        lTaskNo: Text[20];
    begin
        lNb := lCountComma(pValue, ',');
        lPlaTaskPred.SetRange("Task No. Predecessor", pRec."Task No.");
        lPlaTaskPred.DeleteAll;
        if lNb = 1 then
            lSetRecord(pRec, pValue, true)
        else
            for i := 1 to lNb do
                lSetRecord(pRec, SelectStr(i, pValue), true);
    end;

    local procedure lCountComma(pString: Text[1024]; pChar: Text[1]) return: Integer
    var
        lString: Text[1024];
    begin
        lString := pString;
        if lString <> '' then
            return := 1
        else
            return := 0;

        while StrPos(lString, pChar) <> 0 do begin
            return += 1;
            lString := CopyStr(lString, StrPos(lString, pChar) + 1);
        end;
    end;

    local procedure lGetTaskNo(pRec: Record "Planning Line"; var pTaskPred: Record "Planning Line"; pValue: Text[1024])
    var
        lTabCode: array[20] of Integer;
    begin
        if pRec."Task No." = pTaskPred."Task No." then
            Error(Text002);
        if pRec."Task No." = pTaskPred."Task No." then
            Error(Text002);
        pTaskPred.SetRange("Project Header No.", pRec."Project Header No.");
        pTaskPred.SetRange("Internal Reference", pValue);
        if pTaskPred.FindFirst then begin
            if pRec."Task No." = pTaskPred."Task No." then
                Error(Text002);
        end else begin
            lMajTab(pValue, lCountComma(pValue, '.'), lTabCode);
            pTaskPred.SetRange("Internal Reference");
            pTaskPred.SetRange("WBS Code", lCreatePresentationCode(lTabCode, lCountComma(pValue, '.')));
            if pTaskPred.FindFirst then begin
                if pRec."Task No." = pTaskPred."Task No." then
                    Error(Text002);
            end else
                Error(Text001);
        end;
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

    local procedure lSetRecord(pRec: Record "Planning Line"; pValue: Text[1024]; pNext: Boolean)
    var
        lPlaTaskPred: Record "Planning Task Predecessor";
        lTaskPred: Record "Planning Line";
    begin
        lGetTaskNo(pRec, lTaskPred, pValue);
        if not pNext then begin
            if lPlaTaskPred.Get(lTaskPred."Project Header No.", lTaskPred."Task No.", pRec."Project Header No.", pRec."Task No.") then
                lPlaTaskPred.Delete;
            lPlaTaskPred."Project Header" := pRec."Project Header No.";
            lPlaTaskPred."Task No." := pRec."Task No.";
            lPlaTaskPred."Project Header Predecessor" := lTaskPred."Project Header No.";
            lPlaTaskPred."Task No. Predecessor" := lTaskPred."Task No.";
        end else begin
            if lPlaTaskPred.Get(pRec."Project Header No.", pRec."Task No.", lTaskPred."Project Header No.", lTaskPred."Task No.") then
                lPlaTaskPred.Delete;
            lPlaTaskPred."Project Header" := lTaskPred."Project Header No.";
            lPlaTaskPred."Task No." := lTaskPred."Task No.";
            lPlaTaskPred."Project Header Predecessor" := pRec."Project Header No.";
            lPlaTaskPred."Task No. Predecessor" := pRec."Task No.";
        end;
        lCircularRefVerify(lPlaTaskPred."Project Header Predecessor", lPlaTaskPred."Task No. Predecessor",
                           lPlaTaskPred."Project Header", lPlaTaskPred."Task No.", true);
        if lPlaTaskPred.Insert(true) then;
    end;


    procedure lCircularRefVerify(pHeaderNo: Code[20]; pTaskNo: Text[30]; pHeaderTest: Code[20]; pTaskTest: Text[30]; pFirst: Boolean) return: Boolean
    var
        lPlaTaskPred: Record "Planning Task Predecessor";
    begin
        //test des antécédants
        if not pFirst and ((pTaskNo = pTaskTest) and (pHeaderNo = pHeaderTest)) then
            Error(Text002);
        lPlaTaskPred.SetRange("Project Header", pHeaderNo);
        lPlaTaskPred.SetRange("Task No.", pTaskNo);
        if lPlaTaskPred.FindSet then begin
            repeat
                lCircularRefVerify(lPlaTaskPred."Project Header Predecessor", lPlaTaskPred."Task No. Predecessor", pHeaderTest, pTaskTest, false);
            until lPlaTaskPred.Next = 0;
        end;
    end;
}

