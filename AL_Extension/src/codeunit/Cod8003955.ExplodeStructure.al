Codeunit 8003955 "Explode Structure"
{
    // //#6115 gestion
    // //OUVRAGE GESWAY 15/07/03 Eclater ouvrage multi-niveau
    //           AC 02/06/05 Gestion de la notion de nombre de ressource + quantité cadencée
    // //SUBCONTRACTING CLA 24/05/04 Gestion sous-traitance (Disable, Subcontracting)
    // //FRAIS CLA 17/03/05 Gestion frais directs
    // //PLANNING AC 02/11/05 Affectation du code tâche
    // //PERF AC 03/04/06

    TableNo = "Sales Line";

    trigger OnRun()
    begin
        SalesLine := Rec;
        Code;
        Rec := SalesLine;
    end;

    var
        Text001: label 'Structure %1 has no detail lines.';
        Text003: label 'There is not enough space to explode the structure.';
        StructureMng: Codeunit "Structure Management";
        SingleInstance: Codeunit "Import SingleInstance2";
        SalesLineMgt: Codeunit "SalesLine Management";
        UOMMgt: Codeunit "Unit of Measure Management";
        NavibatSetup: Record NavibatSetup;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        StructureLine: Record "Sales Line";
        Structure: Record Resource;
        BomComponent: Record "Structure Component";
        Item: Record Item;
        ItemTranslation: Record "Item Translation";
        BOMItemNo: array[99] of Code[20];
        NoOfBOMComp: Integer;
        NextLineNo: Integer;
        LineSpacing: Integer;
        FromStructureLine: Integer;
        NoLine: Integer;
        AttachedLineQuantity: Decimal;
        AttachedLineRate: Decimal;
        AttachedLineNo: Integer;
        AttachedLineLevel: Integer;
        StructureLineRate: Decimal;
        tNull: label 'The structure %1 has a line %2 without No.';
        FromStructureLineCost: Decimal;
        FromStructureLinePrice: Decimal;
        wBOQMgt: Codeunit "BOQ Management";
        wBOQLoad: Boolean;
        wToBOQLoad: Boolean;


    procedure SearchLineSpacing(pSalesLine: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
    begin
        lSalesLine.Reset;
        lSalesLine.SetRange("Document Type", pSalesLine."Document Type");
        lSalesLine.SetRange("Document No.", pSalesLine."Document No.");
        lSalesLine := pSalesLine;
        if lSalesLine.Find('>') then begin
            LineSpacing := (lSalesLine."Line No." - pSalesLine."Line No.") DIV (1 + NoOfBOMComp);
            if LineSpacing = 0 then
                Error(Text003);
        end else
            LineSpacing := 10000;
    end;


    procedure UpdSalesLineBillOfQuantities(var pSalesLine: Record "Sales Line")
    var
        lRecRef: RecordRef;
        lCustMgt: Codeunit "BOQ Custom Management";
    begin
        lRecRef.GetTable(pSalesLine);
        lCustMgt.fCalcBOQRef(lRecRef, false, false);
    end;


    procedure "Code"()
    var
        lSalesLine: Record "Sales Line";
        lToSalesLine: Record "Sales Line";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lRecRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
    begin
        if (SalesLine."Line Type" <> SalesLine."line type"::Structure) or (SalesLine.Type = SalesLine.Type::" ") then
            exit;
        BomComponent.SetRange("Parent Structure No.", SalesLine."No.");
        BomComponent.SetFilter(Type, '<>%1', BomComponent.Type::" ");
        //#7012
        //NoOfBOMComp := BomComponent.COUNTAPPROX;
        NoOfBOMComp := BomComponent.Count;
        //#7012//
        if NoOfBOMComp = 0 then begin
            //#7673
            lRecRef.GetTable(SalesLine);
            wBOQMgt.DeleteAllContains(lRecRef.RecordId);
            //#7673//
            exit;
        end;

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
        lSalesLine.SetRange("Document Type", SalesLine."Document Type");
        lSalesLine.SetRange("Document No.", SalesLine."Document No.");
        lSalesLine.SetRange("Structure Line No.", SalesLine."Line No.");
        lSalesLine.DeleteAll(true);

        FromStructureLine := SalesLine."Structure Line No.";
        if FromStructureLine <> 0 then begin
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine."Unit of Measure Code" := '';
            SalesLine."Unit of Measure" := '';
            SalesLine.Quantity := 0;
            SalesLine."Unit Cost" := 0;
            SalesLine."Unit Cost (LCY)" := 0;
            SalesLine."Unit Price" := 0;
            SalesLine.Subcontracting := SalesLine.Subcontracting::" ";
            SalesLine.Disable := false;
            SalesLine.Option := false;
            SalesLine.Modify;
            if StructureLine.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Structure Line No.") then
                StructureLineRate := StructureLine.Rate;
        end else begin
            StructureLineRate := SalesLine.Rate;
            StructureLine := SalesLine;
        end;

        SingleInstance.wGetSalesHeader(SalesHeader, SalesLine."Document Type", SalesLine."Document No.");
        NavibatSetup.GET2;

        lToSalesLine.Reset;
        lToSalesLine.SetRange("Document Type", SalesLine."Document Type");
        lToSalesLine.SetRange("Document No.", SalesLine."Document No.");
        lToSalesLine := SalesLine;
        if FromStructureLine <> 0 then begin
            NextLineNo := SalesLine."Line No.";
            SearchLineSpacing(SalesLine);
        end else
            if lToSalesLine.FindLast then begin
                NextLineNo := lToSalesLine."Line No.";
                //PERF    SearchLineSpacing(ToSalesLine);
                LineSpacing := 10000;
            end;
        //#4829
        StructureMng.InitSumStructure(SalesLine);
        //#4829//
        //#7202
        if (wBOQMgt.IsEmpty()) then begin
            lRecRef.GetTable(SalesHeader);
            if wBOQMgt.Load(lRecRef.RecordId) then begin
                lRecRef.GetTable(SalesLine);
                //lBOQCustMgt.fCalcBOQRef(lRecRef,TRUE,TRUE);
            end;
        end;
        //#7202//

        if FromStructureLine = 0 then begin
            ExplodeStructure(SalesLine, 0, wBOQMgt);
            //ExplodeStructure(SalesLine,0)
        end else begin
            //ExplodeStructure(SalesLine,SalesLine."Line No.");
            ExplodeStructure(SalesLine, SalesLine."Line No.", wBOQMgt);
        end;
        lBOQMgt.Save('');
        //#6592
        /*
          lRecRef.GETTABLE(SalesHeader);
          IF lBOQMgt.Load(lRecRef.RECORDID) THEN BEGIN
            lRecRef.GETTABLE(SalesLine);
        //#7202
            //lBOQCustMgt.fCalcBOQRef(lRecRef,TRUE,TRUE);
        //#7202//
          END;
        */
        //#6592//
        //#4829
        StructureMng.UpdateSumStructPrice(SalesLine);
        //#4829//

    end;

    local procedure ExplodeStructure(var pSalesLine: Record "Sales Line"; pAttachedToLine: Integer; var pBoqMgt: Codeunit "BOQ Management")
    var
        lBomComponent: Record "Structure Component";
        lSalesLine: Record "Sales Line";
        lAttachedLineNo: Integer;
        lAttachedLineRate: Decimal;
        lAttachedLineLevel: Integer;
        lAttachedLineQuantity: Decimal;
        lToSalesLine: Record "Sales Line";
        lRes: Record Resource;
        lFromRecRef: RecordRef;
        lToRecRef: RecordRef;
        lToFatherRef: RecordRef;
        lFromFatherRef: RecordRef;
        lT36: Record "Sales Header";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lFatherRef: RecordRef;
    begin
        //Gestion Ligne Attachée
        if pAttachedToLine <> 0 then begin
            lAttachedLineNo := pSalesLine."Line No.";
            lAttachedLineLevel := pSalesLine.Level + 1;
            lAttachedLineQuantity := pSalesLine."Quantity per" + pSalesLine."Quantity Fixed";
            lAttachedLineRate := pSalesLine.Rate
        end;
        //#6115
        lRes.Get(pSalesLine."No.");
        lFromRecRef.GetTable(lRes);
        lFromFatherRef := lFromRecRef.Duplicate;
        lToRecRef.GetTable(pSalesLine);
        lSingleInstance.wGetSalesHeader(lT36, pSalesLine."Document Type", pSalesLine."Document No.");
        lToFatherRef.GetTable(lT36);
        //IF ((pSalesLine.Type = pSalesLine.Type::Resource) AND (pSalesLine."Line Type" = pSalesLine."Line Type"::Structure))THEN BEGIN
        if (pSalesLine."Line Type" = pSalesLine."line type"::Structure) then begin
            /*
            IF NOT wBOQMgt.Load(lToFatherRef.RECORDID) THEN BEGIN
              lBOQCustMgt.gLoadSalesBOQ(lT36);
              wBOQMgt.Save('');
            END;
            IF wBOQMgt.CopyBOQFrom(lFromFatherRef.RECORDID,lFromRecRef.RECORDID,lToFatherRef.RECORDID,lToRecRef.RECORDID,FALSE) THEN BEGIN
        //#7202
              wBOQMgt.AddBOQFrom(lFromFatherRef.RECORDID, lFromRecRef.RECORDID, lToFatherRef.RECORDID, lToRecRef.RECORDID);
        //#7202//
            END;
        //#7202
            wBOQMgt.Save('');
            */
            if pBoqMgt.CopyBOQFrom(lFromFatherRef.RecordId, lFromRecRef.RecordId, lToFatherRef.RecordId, lToRecRef.RecordId, false) then begin
                pBoqMgt.AddBOQFrom(lFromFatherRef.RecordId, lFromRecRef.RecordId, lToFatherRef.RecordId, lToRecRef.RecordId);
            end else begin
                //#7673
                //#8441
                if (pSalesLine."Structure Line No." = 0) then
                    pBoqMgt.DeleteAllContains(lToRecRef.RecordId);
                //#8441//
                //#7673//
            end;
        end;
        //#7202//


        lBomComponent.SetRange("Parent Structure No.", pSalesLine."No.");
        //#4829
        if not lBomComponent.IsEmpty then begin
            lBomComponent.Find('-');
            //#4829//
            repeat
                AttachedLineNo := lAttachedLineNo;
                AttachedLineLevel := lAttachedLineLevel;
                AttachedLineQuantity := lAttachedLineQuantity;
                AttachedLineRate := lAttachedLineRate;

                InsertStructure(pSalesLine, lToSalesLine, lBomComponent);

                //#7202
                lFromRecRef.GetTable(lBomComponent);
                lToRecRef.GetTable(lToSalesLine);
                if (not pBoqMgt.fSearchReplaceAttValue(Format(lFromRecRef.RecordId), Format(lToRecRef.RecordId),
                    'Node', 'RecordID')) then begin
                    lBOQCustMgt.gGetFatherNode(lToRecRef, lFatherRef);
                    pBoqMgt.AppendNodeAt(lFatherRef.RecordId, lToRecRef.RecordId);

                    pBoqMgt.CopyBOQFrom(lFromFatherRef.RecordId, lFromRecRef.RecordId, lToFatherRef.RecordId, lToRecRef.RecordId, false);
                end;
                lToRecRef.SetTable(lToSalesLine);
                //#7202//

                if lBomComponent.Type = lBomComponent.Type::Structure then begin
                    AttachedLineQuantity := 0;
                    StructureMng.UpdateSubDetailStruct(lToSalesLine, pSalesLine, true);
                    ExplodeStructure(lToSalesLine, lToSalesLine."Line No.", pBoqMgt);
                end else
                    StructureMng.UpdateSubDetailStruct(lToSalesLine, pSalesLine, false);
                //#4829
                StructureMng.UpdateSumStructCost(pSalesLine, lToSalesLine);
            //#4829//
            until lBomComponent.Next = 0;
            if (pSalesLine."Line Type" = pSalesLine."line type"::Structure) and (pSalesLine."Structure Line No." <> 0) then
                pSalesLine.Validate("Quantity per")
            else begin
                pSalesLine.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Line No.");
                pSalesLine.Validate(Quantity);
            end;
        end;

    end;

    local procedure InsertStructure(pLine: Record "Sales Line"; var pToSalesline: Record "Sales Line"; pComponent: Record "Structure Component")
    var
        lSalesLine: Record "Sales Line";
        lGetSalesLine: Boolean;
        lRes: Record Resource;
        lDisable: Boolean;
        lStructureQty: Decimal;
        lLineQty: Decimal;
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lBOQMgt: Codeunit "BOQ Management";
    begin
        Clear(Structure);
        NextLineNo += LineSpacing;

        pToSalesline.Init;
        pToSalesline."Document Type" := SalesHeader."Document Type";
        pToSalesline."Document No." := SalesHeader."No.";
        pToSalesline."Line No." := NextLineNo;
        if pLine."Structure Line No." <> 0 then begin                              //sous-ouvrage
            pToSalesline."Attached to Line No." := AttachedLineNo;
            pToSalesline."Structure Line No." := pLine."Structure Line No.";
            pToSalesline.Level := pLine.Level;
            //#7077
            AttachedLineQuantity := 1;
            //#7077//
            if AttachedLineNo <> 0 then
                pToSalesline.Level := AttachedLineLevel;
            if pComponent.Subcontracting <> 0 then
                exit;
        end else begin
            pToSalesline."Structure Line No." := pLine."Line No.";
            AttachedLineQuantity := pLine."Quantity per" + pLine."Quantity Fixed";
            if AttachedLineQuantity = 0 then
                AttachedLineQuantity := 1;
            AttachedLineRate := pLine.Rate;
        end;
        pToSalesline."Presentation Code" := pLine."Presentation Code";
        if pToSalesline.Level = 0 then
            pToSalesline.Level := 1;
        case pComponent.Type of
            pComponent.Type::" ":
                begin
                    pToSalesline."Line Type" := pToSalesline."line type"::" ";
                    pToSalesline.Type := pToSalesline.Type::" ";
                end;
            pComponent.Type::Item:
                begin
                    pToSalesline."Line Type" := pToSalesline."line type"::Item;
                    pToSalesline.Type := pToSalesline.Type::Item;
                end;
            pComponent.Type::Person:
                begin
                    pToSalesline."Line Type" := pToSalesline."line type"::Person;
                    pToSalesline.Type := pToSalesline.Type::Resource;
                end;
            pComponent.Type::Machine:
                begin
                    pToSalesline."Line Type" := pToSalesline."line type"::Machine;
                    pToSalesline.Type := pToSalesline.Type::Resource;
                end;
            pComponent.Type::Structure:
                begin
                    pToSalesline."Line Type" := pToSalesline."line type"::Structure;
                    pToSalesline.Type := pToSalesline.Type::Resource;
                end;
            pComponent.Type::"G/L Account":
                begin
                    pToSalesline."Line Type" := pToSalesline."line type"::"G/L Account";
                    pToSalesline.Type := pToSalesline.Type::"G/L Account";
                end;
        end;
        if (pToSalesline.Type <> 0) and (pComponent."No." <> '') then begin
            if pLine."Quantity per" = 0 then
                pLine."Quantity per" := 1;
            pToSalesline.Validate("No.", pComponent."No.");
            if pToSalesline."Unit of Measure Code" <> pComponent."Unit of Measure Code" then
                pToSalesline.Validate("Unit of Measure Code", pComponent."Unit of Measure Code");
            if pToSalesline."Variant Code" <> pComponent."Variant Code" then
                pToSalesline.Validate("Variant Code", pComponent."Variant Code");
            pToSalesline."Quantity Fixed" := pComponent."Fixed Quantity";
            pToSalesline."Rate Quantity" := pComponent."Rate Quantity";
            pToSalesline."Number of Resources" := pComponent."Number of Resources";

            lStructureQty := (pLine."Quantity per" + pLine."Quantity Fixed") * AttachedLineQuantity;
            if lStructureQty = 0 then
                lStructureQty := 1;

            case pToSalesline."Line Type" of
                pToSalesline."line type"::Item:
                    begin
                        Item.Get(pComponent."No.");

                        //gestion de l'article de sous-traitance
                        pToSalesline.Subcontracting := pComponent.Subcontracting;
                        if pToSalesline.Subcontracting <> pToSalesline.Subcontracting::" " then
                            pToSalesline."Unit Cost (LCY)" := pComponent."Subcontracted Unit Cost";

                        lLineQty := ROUND(pComponent."Quantity per" * lStructureQty *
                              UOMMgt.GetQtyPerUnitOfMeasure(Item, pComponent."Unit of Measure Code") /
                                pToSalesline."Qty. per Unit of Measure", 0.00001);

                        //gestion Sous-traitance
                        if pToSalesline.Subcontracting > 0 then begin
                            if StructureLine.Subcontracting = 0 then
                                pToSalesline."Disable Quantity" := lLineQty
                            else
                                if StructureLine.Option then begin
                                    pToSalesline."Optionnal Quantity" := lLineQty;
                                    pToSalesline."Quantity per" := lLineQty;
                                    pToSalesline.Option := true;
                                end else begin
                                    if StructureLine.Subcontracting = pToSalesline.Subcontracting then
                                        pToSalesline.Validate("Quantity per", lLineQty)
                                    else
                                        pToSalesline."Disable Quantity" := lLineQty;
                                end;
                            //gestion Hors sous-traitance
                        end else begin
                            if StructureLine.Subcontracting = StructureLine.Subcontracting::"Furniture and Fixing" then
                                pToSalesline."Disable Quantity" := lLineQty
                            else
                                if StructureLine.Option then begin
                                    pToSalesline."Optionnal Quantity" := lLineQty;
                                    pToSalesline."Quantity per" := lLineQty;
                                    pToSalesline.Option := true;
                                end else
                                    pToSalesline."Quantity per" := lLineQty;
                        end;
                    end;

                pToSalesline."line type"::Person, pToSalesline."line type"::Machine:
                    begin
                        //#7590    IF (AttachedLineRate <> 0) OR (StructureLineRate <> 0) THEN
                        //      pToSalesline.Rate := StructureLineRate;
                        if pToSalesline."Attached to Line No." <> 0 then begin
                            if (pToSalesline."Line Type" = pToSalesline."line type"::Structure) then begin
                                lRes.Get(pToSalesline."No.");
                                AttachedLineRate := lRes.Rate;
                            end;
                            pToSalesline.Rate := AttachedLineRate;
                            StructureLineRate := AttachedLineRate;
                        end else
                            pToSalesline.Rate := StructureLineRate;
                        //#7590//
                        if pLine."Quantity per" * AttachedLineQuantity = 0 then begin
                            if (StructureLineRate = 0) then
                                lLineQty := pComponent."Quantity per" * lStructureQty
                            else
                                lLineQty := (pComponent."Rate Quantity" / StructureLineRate) * lStructureQty;
                        end else begin
                            if (StructureLineRate = 0) then
                                lLineQty := pLine."Quantity per" * pComponent."Quantity per" * AttachedLineQuantity
                            else begin
                                lLineQty := (pComponent."Rate Quantity" / StructureLineRate) * lStructureQty;
                                pToSalesline."Rate Quantity" := pComponent."Rate Quantity";
                            end;
                        end;

                        pToSalesline."Quantity per" := 0;
                        if StructureLine.Subcontracting > 0 then
                            pToSalesline."Disable Quantity" := lLineQty
                        else
                            if StructureLine.Option then begin
                                pToSalesline."Optionnal Quantity" := lLineQty;
                                pToSalesline."Quantity per" := lLineQty;
                                pToSalesline.Option := true;
                            end else
                                pToSalesline."Quantity per" := lLineQty;
                    end;

                pToSalesline."line type"::Structure:
                    begin
                        lLineQty := pComponent."Quantity per" * lStructureQty;
                        if StructureLine.Subcontracting > 0 then begin
                            pToSalesline."Disable Quantity" := lLineQty;
                            pToSalesline."Quantity per" := lLineQty;
                        end else
                            pToSalesline."Quantity per" := lLineQty;
                        //#7590
                        //    pToSalesline.Rate := AttachedLineRate;
                        //#7590//
                    end;

                else begin
                    lLineQty := pComponent."Quantity per" * lStructureQty;
                    if StructureLine.Subcontracting > 0 then
                        pToSalesline."Disable Quantity" := lLineQty
                    else
                        if StructureLine.Option then begin
                            pToSalesline."Optionnal Quantity" := lLineQty;
                            pToSalesline."Quantity per" := lLineQty;
                            pToSalesline.Option := true;
                        end else
                            pToSalesline."Quantity per" := lLineQty;
                end;
            end;

            if StructureLine."Line No." = SalesLine."Line No." then
                SalesLineMgt.wValidateQtyPer(pToSalesline, pToSalesline, SalesLine, pLine, pToSalesline."Attached to Line No." <> 0)
            else
                SalesLineMgt.wValidateQtyPer(pToSalesline, pToSalesline, StructureLine, pLine, pToSalesline."Attached to Line No." <> 0);

            //Spécification OUVRAGE
            if (pToSalesline."Line Type" = pToSalesline."line type"::Structure) then begin
                pToSalesline.Type := pToSalesline.Type::" ";
                pToSalesline."Unit Cost" := 0;
                pToSalesline."Unit of Measure Code" := '';
                pToSalesline."Unit of Measure" := '';
                pToSalesline.Quantity := 0;
            end else begin
                pToSalesline."Value 1" := pComponent."Value 1";
                pToSalesline."Value 2" := pComponent."Value 2";
                pToSalesline."Value 3" := pComponent."Value 3";
                pToSalesline."Value 4" := pComponent."Value 4";
                pToSalesline."Value 5" := pComponent."Value 5";
                pToSalesline."Value 6" := pComponent."Value 6";
                pToSalesline."Value 7" := pComponent."Value 7";
                pToSalesline."Value 8" := pComponent."Value 8";
                pToSalesline."Value 9" := pComponent."Value 9";
                pToSalesline."Value 10" := pComponent."Value 10";
                pToSalesline."Location Code" := SalesLine."Location Code";
            end;
            if (NavibatSetup."Profit Calculation Method" = NavibatSetup."profit calculation method"::Structure) and
              (pToSalesline.Type <> pToSalesline.Type::" ") then
                pToSalesline.Validate("Unit Price", 0);
        end;
        //TRANSLATION
        pToSalesline.Description := pComponent.Description;
        pToSalesline."Description 2" := pComponent."Description 2";
        if (SalesHeader."Language Code" <> '') and
           ItemTranslation.Get(pComponent."No.", pComponent."Variant Code", SalesHeader."Language Code") then begin
            pToSalesline.Description := ItemTranslation.Description;
            pToSalesline."Description 2" := ItemTranslation."Description 2";
        end;
        //TRANSLATION//
        pToSalesline."Job No." := SalesLine."Job No.";
        pToSalesline."Print Structure Line" := pComponent."Print Line on Doc.";
        //FRAIS
        pToSalesline."Assignment Basis" := SalesLine."Assignment Basis";
        //FRAIS//

        //SUBCONTRACTING
        case StructureLine.Subcontracting of
            StructureLine.Subcontracting::" ", StructureLine.Subcontracting::"Furniture and Fixing":
                lDisable := (pToSalesline.Subcontracting <> StructureLine.Subcontracting) and
                            (pToSalesline."Line Type" <> pToSalesline."line type"::Structure);
            StructureLine.Subcontracting::Fixing:
                lDisable := (pToSalesline."Line Type" in [pToSalesline."line type"::Person, pToSalesline."line type"::Machine]) or
                  ((pToSalesline.Type = pToSalesline.Type::Item) and
                   (pToSalesline.Subcontracting = pToSalesline.Subcontracting::"Furniture and Fixing"));
        end;

        if pToSalesline.Type = pToSalesline.Type::" " then begin
            pToSalesline.Subcontracting := pToSalesline.Subcontracting::" ";
            lDisable := false;
            //3399
            if (pToSalesline."Attached to Line No." <> 0) then
                pToSalesline.Level := AttachedLineLevel;//SalesLine.Level;
                                                        //3399//
        end;
        if lDisable then
            pToSalesline.Disable := true;
        //SUBCONTRACTING//
        pToSalesline."Completely Shipped" := false;

        //#5017
        pToSalesline."Shortcut Dimension 1 Code" := pLine."Shortcut Dimension 1 Code";
        pToSalesline."Shortcut Dimension 2 Code" := pLine."Shortcut Dimension 2 Code";
        //#5017//

        if ((pToSalesline.Type <> 0) and (pToSalesline."No." <> '')) or (pToSalesline.Type = 0) then
            while not pToSalesline.Insert do
                pToSalesline."Line No." += LineSpacing;

        //#6115
        //#7202
        //IF wBOQLoad THEN BEGIN
        //  lRecRef.GETTABLE(pToSalesline);
        //  lBOQCustMgt.gOnInsert(lRecRef);
        //END;
        //#7202//
        //#6115
    end;


    procedure AttachedToLineCalc(pParentNo: Code[20]; pLine: Record "Sales Line"; var pAttachSalesLine: Record "Sales Line"; var pGetAttached: Boolean) Return: Integer
    var
        lSalesLine: Record "Sales Line";
    begin
        with pAttachSalesLine do begin
            SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            SetRange("Document Type", pLine."Document Type");
            SetRange("Document No.", pLine."Document No.");
            SetRange("Structure Line No.", pLine."Structure Line No.");
            SetRange("Line Type", pLine."line type"::Structure);
            SetRange("No.", pParentNo);
            if IsEmpty then begin
                if pLine."Line Type" = pLine."line type"::Structure then begin
                    pGetAttached := true;
                    pAttachSalesLine := pLine;
                end;
                exit(pLine."Line No.")
            end else begin
                pGetAttached := FindLast;
                exit("Line No.");
            end;
        end;
    end;


    procedure fSetBoqManagement(var pBoqMgt: Codeunit "BOQ Management")
    begin
        wBOQMgt := pBoqMgt;
    end;
}

