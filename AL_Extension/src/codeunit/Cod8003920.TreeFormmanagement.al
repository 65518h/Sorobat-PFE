Codeunit 8003920 "Tree Form management"
{

    trigger OnRun()
    begin
    end;


    procedure InitTempTable(var pTempRec: Record Tree temporary; var pToggleAll: Boolean; pCurrentType: Option Person,Machine,Structure,Item)
    var
        lRec: Record Tree;
    begin
        pTempRec.DeleteAll;
        lRec.SetRange(Type, pCurrentType);
        if not pToggleAll and not ISSERVICETIER then
            lRec.SetRange(Level, 0);
        pToggleAll := not pToggleAll;
        if lRec.Find('-') then
            repeat
                pTempRec := lRec;
                pTempRec.Insert;
            until lRec.Next = 0;
    end;


    procedure OnOpenForm(var pRec: Record Tree; var pTempRec: Record Tree temporary; pToggleAll: Boolean; pCurrentType: Option Person,Machine,Structure,Item)
    var
        lRec: Record Tree;
        i: Integer;
    begin
        lRec := pRec;
        InitTempTable(pTempRec, pToggleAll, pCurrentType);
        pRec := lRec;

        if ISSERVICETIER then
            exit;

        if (StrPos(pRec.Code, ' ') <> 0) then begin // Expand Branch
                                                    // Expand Current Branch
            i := StrLen(lRec.Code);
            repeat
                if i > 1 then
                    i -= 1;
            until (i = 1) or (lRec.Code[i] = ' ');
            lRec.SetRange(Level, pRec.Level);
            lRec.SetFilter(Code, '%1', CopyStr(lRec.Code, 1, i) + '*');
            if lRec.Find('-') then
                repeat
                    pTempRec := lRec;
                    if pTempRec.Insert then;
                until lRec.Next = 0;

            // Expand Upper Branch
            lRec.SetRange(Level);
            i := StrLen(lRec.Code);
            repeat
                if i > 1 then
                    i -= 1;
                if lRec.Code[i] = ' ' then begin
                    lRec.Code := CopyStr(lRec.Code, 1, i - 1);
                    lRec.SetRange(Code, lRec.Code);
                    if lRec.Find('-') then begin
                        pTempRec := lRec;
                        if pTempRec.Insert then;
                    end;
                end;
            until i = 1;
        end;
    end;


    procedure OnInsert(var pRec: Record Tree; var pTempRec: Record Tree temporary) return: Boolean
    var
        RecRef: RecordRef;
        ChangeLogMgt: Codeunit "Change Log Management";
    begin
        pRec.CheckInsert;
        pTempRec := pRec;
        RecRef.GetTable(pRec);
        ChangeLogMgt.LogInsertion(RecRef);
        return := pTempRec.Insert;
    end;


    procedure OnDelete(var pRec: Record Tree; var pTempRec: Record Tree temporary; var pOkMultiple: Boolean) return: Boolean
    var
        xRecRef: RecordRef;
        ChangeLogMgt: Codeunit "Change Log Management";
    begin
        pRec.CheckDelete(pOkMultiple);
        pTempRec := pRec;
        xRecRef.GetTable(pRec);
        ChangeLogMgt.LogDeletion(xRecRef);
        return := pTempRec.Delete;
    end;


    procedure OnModify(var pRec: Record Tree; var pTempRec: Record Tree temporary; xCode: Code[20]; pToggleAll: Boolean; pCurrentType: Option Person,Machine,Structure,Item) return: Boolean
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
        ChangeLogMgt: Codeunit "Change Log Management";
    begin
        RecRef.GetTable(pRec);
        xRecRef.GetTable(pTempRec);
        if pRec.Modify then begin
            pTempRec := pRec;
            if pTempRec.Modify then
                /*   //GL2024  ChangeLogMgt.LogModification(RecRef, xRecRef)
                else*/
                InitTempTable(pTempRec, pToggleAll, pCurrentType);
        end
        else begin
            pRec.CheckRename(xCode);
            ChangeLogMgt.LogRename(RecRef, xRecRef);
            RefreshTable(pRec, pTempRec, pToggleAll, pCurrentType);
        end;
        exit(false);
    end;


    procedure OnNextRecord(var pRec: Record Tree; var pTempRec: Record Tree; Steps: Integer) ResultSteps: Integer
    begin
        pTempRec.Copy(pRec);
        ResultSteps := pTempRec.Next(Steps);
        pRec := pTempRec;
        exit(ResultSteps);
    end;


    procedure OnFindRecord(var pRec: Record Tree; var pTempRec: Record Tree; Which: Text[1024]; var pOkDelete: Boolean; var pOkMultiple: Boolean; pToggleAll: Boolean; pCurrentType: Option Person,Machine,Structure,Item) Found: Boolean
    begin
        if pOkDelete then begin
            InitTempTable(pTempRec, pToggleAll, pCurrentType);
            pOkDelete := false;
            pOkMultiple := false;
        end;
        pTempRec.Copy(pRec);
        Found := pTempRec.Find(Which);
        pRec := pTempRec;
        exit(Found);
    end;


    procedure GetExpensionStatus(var pRec: Record Tree; var pTempRec: Record Tree temporary; pCurrentType: Option Person,Machine,Structure,Item) return: Integer
    begin
        if ISSERVICETIER then
            exit;

        if IsExpanded(pRec, pTempRec) then
            return := 1
        else
            if HasChildren(pRec, pCurrentType) then
                return := 0
            else
                return := 2;
    end;


    procedure ExpandAll(var pTempRec: Record Tree temporary; pCurrentType: Option Person,Machine,Structure,Item)
    var
        lRec: Record Tree;
    begin
        pTempRec.DeleteAll;
        lRec.SetRange(Type, pCurrentType);
        if lRec.Find('-') then
            repeat
                pTempRec := lRec;
                pTempRec.Insert;
            until lRec.Next = 0;
    end;


    procedure HasChildren(var pRec: Record Tree; pCurrentType: Option Person,Machine,Structure,Item): Boolean
    var
        lRec: Record Tree;
    begin
        if ISSERVICETIER then
            exit;

        lRec := pRec;
        lRec.SetRange(Type, pCurrentType);
        if lRec.Next = 0 then
            exit(false)
        else
            exit(lRec.Level > pRec.Level);
    end;


    procedure IsExpanded(var pRec: Record Tree; var pTempRec: Record Tree temporary): Boolean
    begin
        if ISSERVICETIER then
            exit;

        pTempRec.Get(pRec.Type, pRec.Code);
        if pTempRec.Next = 0 then
            exit(false)
        else
            exit(pTempRec.Level > pRec.Level);
    end;


    procedure ToggleExpandCollapse(var pRec: Record Tree; var pTempRec: Record Tree temporary; pExpandAll: Boolean; pCurrentType: Option Person,Machine,Structure,Item; pActualExpansionStatus: Integer)
    var
        lRec: Record Tree;
    begin
        if ISSERVICETIER then
            exit;

        if pActualExpansionStatus = 0 then begin // Has children, but not expanded
            lRec.SetRange(Type, pCurrentType);
            lRec.SetFilter(Code, '>=%1', pRec.Code);
            if pExpandAll then
                lRec.SetRange(Level, pRec.Level, 9999)
            else
                lRec.SetRange(Level, pRec.Level, pRec.Level + 1);
            lRec := pRec;
            if lRec.Next <> 0 then
                repeat
                    if lRec.Level > pRec.Level then begin
                        pTempRec := lRec;
                        if pTempRec.Insert then;
                    end;
                until (lRec.Next = 0) or (lRec.Level = pRec.Level);
        end else
            if pActualExpansionStatus = 1 then begin // Has children and is already expanded
                pTempRec := pRec;
                while (pTempRec.Next <> 0) and (pTempRec.Level > pRec.Level) do
                    pTempRec.Delete;
            end;
    end;


    procedure GetPyramid(var pRec: Record Tree): Text[20]
    begin
        exit(pRec.Code);
    end;


    procedure RefreshTable(pRec: Record Tree; var pTempRec: Record Tree temporary; var pToggleAll: Boolean; pCurrentType: Option Person,Machine,Structure,Item)
    var
        lRec: Record Tree;
    begin
        pTempRec := pRec;
    end;
}

