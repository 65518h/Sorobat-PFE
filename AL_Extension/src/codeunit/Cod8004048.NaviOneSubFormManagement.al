Codeunit 8004048 "NaviOne SubForm Management"
{

    trigger OnRun()
    begin
    end;


    procedure gHasChildren(ActualSalesLine: Record "Sales Line"): Boolean
    var
        lRec: Record "Sales Line";
    begin
        Clear(lRec);
        lRec.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        lRec.SetRange("Order Type", ActualSalesLine."Order Type");
        lRec.SetRange("Document Type", ActualSalesLine."Document Type");
        lRec.SetRange("Document No.", ActualSalesLine."Document No.");
        lRec.SetFilter("Line Type", '<>%1', ActualSalesLine."line type"::" ");
        lRec.SetFilter("Presentation Code", '%1', ActualSalesLine."Presentation Code" + '.*');
        lRec.SetRange("Structure Line No.", 0);
        exit(not lRec.IsEmpty);
    end;


    procedure gIsExpanded(var ActualsalesLine: Record "Sales Line"): Boolean
    var
        lRec: Record "Sales Line";
    begin
        lRec.Copy(ActualsalesLine);
        lRec.SetFilter("Line Type", '<>%1', ActualsalesLine."line type"::" ");
        lRec.SetFilter("Presentation Code", '%1', ActualsalesLine."Presentation Code" + '.*');
        exit(not lRec.IsEmpty);
    end;


    procedure gToggleExpandCollapse(pExpandAll: Boolean; ActualExpansionStatus: Integer; var ActualSalesLine: Record "Sales Line"; var pMarked: Boolean) Return: Boolean
    var
        lSalesLine: Record "Sales Line";
    begin
        if pMarked then begin
            ActualSalesLine.MarkedOnly(false);
            lSalesLine := ActualSalesLine;
            if ActualExpansionStatus = 0 then begin // Has children, but not expanded
                ActualSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code");
                ActualSalesLine.SetRange("Order Type", ActualSalesLine."Order Type");
                ActualSalesLine.SetRange("Document Type", ActualSalesLine."Document Type");
                ActualSalesLine.SetRange("Document No.", ActualSalesLine."Document No.");
                ActualSalesLine.SetFilter("Presentation Code", '%1', ActualSalesLine."Presentation Code" + '.*');
                if pExpandAll then
                    ActualSalesLine.SetRange(Level, ActualSalesLine.Level + 1, 9999)
                else
                    ActualSalesLine.SetRange(Level, ActualSalesLine.Level + 1);
                repeat
                    ActualSalesLine.Mark(true);
                until ActualSalesLine.Next = 0;
            end else
                if ActualExpansionStatus = 1 then  // Has children and is already expanded
                    repeat
                        ActualSalesLine.Mark(false);
                    until (ActualSalesLine.Next = 0) or (ActualSalesLine.Level <= ActualSalesLine.Level);
            ActualSalesLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Line No.");
            ActualSalesLine.MarkedOnly(true);
            Return := true;
        end;
        Return := false;
    end;


    procedure gRefreshExtendedText(pShowExtendedText: Boolean; var ActualSalesLine: Record "Sales Line"; var pMarked: Boolean) Return: Boolean
    var
        lRec: Record "Sales Line";
    begin
        Return := false;
        if pMarked and pShowExtendedText then begin
            ActualSalesLine.MarkedOnly(false);
            lRec := ActualSalesLine;
            ActualSalesLine.SetRange("Document Type", ActualSalesLine."Document Type");
            ActualSalesLine.SetRange("Document No.", ActualSalesLine."Document No.");
            ActualSalesLine.SetRange("Attached to Line No.", ActualSalesLine."Line No.");
            ActualSalesLine.SetFilter("Line No.", '<>%1', ActualSalesLine."Line No.");
            if not ActualSalesLine.IsEmpty then begin
                ActualSalesLine.FindSet(false, false);
                repeat
                    ActualSalesLine.Mark(true);
                until ActualSalesLine.Next = 0;
                Return := true;
            end;
            ActualSalesLine.SetRange("Attached to Line No.");
            ActualSalesLine.SetRange("Line No.");
            ActualSalesLine.Get(lRec."Document Type", lRec."Document No.", lRec."Line No.");
            ActualSalesLine.MarkedOnly(true);
        end;
    end;


    procedure gSetMarked(var pMarked: Boolean; var pShowExtendedText: Boolean; var pKOLookup: Boolean; var pBOQLoad: Boolean; pSalesHeader: Record "Sales Header"; var ActualSalesLine: Record "Sales Line"; var pBOQMgt: Codeunit "BOQ Management")
    var
        lRec: Record "Sales Line";
        lRecRef: RecordRef;
    begin
        ActualSalesLine.MarkedOnly(false);
        ActualSalesLine.ClearMarks;
        if not pMarked and pShowExtendedText then
            exit;

        if pMarked then begin
            lRec := ActualSalesLine;
            ActualSalesLine.SetRange(Level, 1);
            if ActualSalesLine.Find('-') then
                repeat
                    if pShowExtendedText or (ActualSalesLine."Attached to Line No." = 0) then
                        ActualSalesLine.Mark(true);
                until ActualSalesLine.Next = 0;
            ActualSalesLine.SetRange(Level, 2, 15);
            ActualSalesLine.SetRange("Line Type", ActualSalesLine."line type"::Totaling);
            if ActualSalesLine.Find('-') then
                repeat
                    ActualSalesLine.Mark(true);
                    if gRefreshExtendedText(pShowExtendedText, ActualSalesLine, pMarked) then
                        ActualSalesLine.MarkedOnly(false);
                until ActualSalesLine.Next = 0;
            ActualSalesLine.MarkedOnly(true);
            ActualSalesLine.SetRange(Level);
            ActualSalesLine.SetRange("Line Type");
            if ActualSalesLine.Get(lRec."Document Type", lRec."Document No.", lRec."Line No.") then;
            pKOLookup := true;
        end
        else begin
            lRec := ActualSalesLine;
            if ActualSalesLine.Find('-') then
                repeat
                    if not ((ActualSalesLine."Line Type" = ActualSalesLine."line type"::" ") and
                           (ActualSalesLine."Attached to Line No." <> 0)) then
                        ActualSalesLine.Mark(true);
                until ActualSalesLine.Next = 0;
            ActualSalesLine.MarkedOnly(true);
            if ActualSalesLine.Get(lRec."Document Type", lRec."Document No.", lRec."Line No.") then;
            pKOLookup := true;
        end;
        //#6115
        Clear(pBOQMgt);
        lRecRef.GetTable(pSalesHeader);
        pBOQLoad := pBOQMgt.Load(lRecRef.RecordId);
        //#6115//
    end;


    procedure fCheckBOQLine(var pBoqMgt: Codeunit "BOQ Management"; pSalesLine: Record "Sales Line"; pBOQLoaded: Boolean; var pOKBOQ: Integer; var pBOQState: Option " ","None","Only Variable","Has Results","Has Errors")
    var
        lRecRef: RecordRef;
    begin
        //#8919
        if pBOQLoaded then begin
            lRecRef.GetTable(pSalesLine);
            pOKBOQ := pBoqMgt.GetBOQDefined(lRecRef.RecordId);
        end else
            pOKBOQ := 0;

        if (pSalesLine.Type = pSalesLine.Type::" ") then
            pBOQState := 0
        else
            pBOQState := (pOKBOQ + 1);
        //#8919//
    end;


    procedure fShowBOQ(var pBOQMgt: Codeunit "BOQ Management"; var pSalesLine: Record "Sales Line"; var pShowExtendedText: Boolean; var pMarked: Boolean; var pBoqLoad: Boolean)
    var
        lxRec: Record "Sales Line";
        lSetupSty: Record "Quantity Setup";
        lRecref: RecordRef;
        lSalesHeader: Record "Sales Header";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        //#8919
        if lSetupSty.Get then
            if not lSetupSty."Formula desactivated / Sales" then begin
                pSalesLine.TestField("Value 1", 0);
                pSalesLine.TestField("Value 2", 0);
                pSalesLine.TestField("Value 3", 0);
                pSalesLine.TestField("Value 4", 0);
                pSalesLine.TestField("Value 5", 0);
                pSalesLine.TestField("Value 6", 0);
                pSalesLine.TestField("Value 7", 0);
                pSalesLine.TestField("Value 8", 0);
                pSalesLine.TestField("Value 9", 0);
                pSalesLine.TestField("Value 10", 0);
            end;
        //#6115
        if pSalesLine."Line Type" = pSalesLine."line type"::" " then
            exit;
        lRecref.GetTable(pSalesLine);
        if not lBOQCustMgt.fShowBOQLine(lRecref) then
            exit;
        //#6115//
        pSalesLine.Find;
        pSalesLine.wUpdateLine(pSalesLine, lxRec, true);
        //#6115
        Clear(pBOQMgt);
        lSalesHeader.Get(pSalesLine."Document Type", pSalesLine."Document No.");
        lRecref.GetTable(lSalesHeader);
        pBoqLoad := pBOQMgt.Load(lRecref.RecordId);
        //#6115//
        gRefreshExtendedText(pShowExtendedText, pSalesLine, pMarked);
        //#8919//
    end;


    procedure fLoadBOQ(pSalesHeader: Record "Sales Header"; var pBOQMgt: Codeunit "BOQ Management"; var pBOQLoad: Boolean)
    var
        lRecRef: RecordRef;
    begin
        //#8919
        Clear(pBOQMgt);
        lRecRef.GetTable(pSalesHeader);
        pBOQLoad := pBOQMgt.Load(lRecRef.RecordId);
        //#8919//
    end;


    procedure fShowStructureBOQ(var pSalesLine: Record "Sales Line"; var pModified: Boolean)
    var
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        if not (pSalesLine."Line Type" in [pSalesLine."line type"::Item,
                                           pSalesLine."line type"::Person,
                                           pSalesLine."line type"::Machine,
                                           pSalesLine."line type"::Structure]) then
            exit;
        if (pSalesLine.Rate <> 0) and (pSalesLine."Rate Quantity" <> 0) then
            pSalesLine.TestField("Rate Quantity", 0);

        //#6115
        lRecRef.GetTable(pSalesLine);
        if not lBOQCustMgt.fShowBOQLine(lRecRef) then
            exit;
        //#6115//
        pSalesLine.Find;
        pModified := true;

        if (pSalesLine."Line Type" = pSalesLine."line type"::Structure) and (pSalesLine.Type <> pSalesLine.Type::" ") then begin
            pSalesLine.Modify(true);
            Codeunit.Run(Codeunit::"Explode Structure", pSalesLine);
            Commit;
        end;
    end;


    /* GL2024   procedure fUpdateDimension(pOldLineNo: Integer; pSalesLine: Record 37)
        var
            lDocDim: Record 357;
            lNewDocDim: Record 357;
        begin
            //#9178
            //Table ID,Document Type,Document No.,Line No.,Dimension Code
            if (pOldLineNo <> pSalesLine."Line No.") then begin
                lDocDim.SetRange(lDocDim."Table ID", 37);
                lDocDim.SetRange(lDocDim."Document Type", pSalesLine."Document Type");
                lDocDim.SetRange(lDocDim."Document No.", pSalesLine."Document No.");
                lDocDim.SetRange(lDocDim."Line No.", pOldLineNo);
                if (not lDocDim.IsEmpty) then begin
                    lDocDim.FindSet(false, false);
                    repeat
                        lNewDocDim.Init();
                        lNewDocDim.TransferFields(lDocDim);
                        lNewDocDim."Line No." := pSalesLine."Line No.";
                        lNewDocDim.Insert(true);
                    until (lDocDim.Next() = 0);
                    lDocDim.DeleteAll(true);
                end;
            end;
            //#9178//
        end;*/
}

