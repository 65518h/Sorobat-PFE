Codeunit 8004085 "Total Need Management"
{

    trigger OnRun()
    begin
    end;

    var
        TextTotalItemNo: label 'ITEM TOTAL';
        TextTotalResNo: label 'RES TOTAL';
        TextTotalMachNo: label 'MACHINE TOTAL';
        TextTotalStrucNo: label 'STRUCTURE TOTAL';
        TextTotalSTNo: label 'SUBCONTRACTING TOTAL';
        TextTotalDesc: label 'Total %1';
        TextTotalSTDesc: label 'Subcontracting Total';
        tErrorFieldTest: label 'You can''t modify the %1 field because a purchasing %2 is joining it.';


    procedure fInitializeForm(var pRec: Record "Sales Line" temporary; wDocType: Option; wDocNo: Code[20]) rVisible: Boolean
    var
        lSalesLine: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
        lReleaseSalesDoc: Codeunit "Release Sales Document";
    begin
        if (wDocNo <> '') then begin
            lSalesLine.SetRange("Document Type", wDocType);
            lSalesLine.SetRange("Document No.", wDocNo);
            if (not lSalesLine.IsEmpty()) then
                lSalesLine.FindFirst();
            if (lSalesLine."Document Type" = lSalesLine."document type"::Quote) then begin
                if (lSalesHeader.Get(lSalesLine."Document Type", lSalesLine."Document No.")) then begin
                    if (lSalesHeader.Status = lSalesHeader.Status::Released) then begin
                        rVisible := true;
                        lReleaseSalesDoc.Reopen(lSalesHeader);
                    end;
                end;
            end else begin
                lSalesHeader.Get(lSalesLine."Document Type", lSalesLine."Document No.");
            end;
        end;
    end;


    procedure fLoadData(var pRec: Record "Sales Line" temporary; wDocType: Option; wDocNo: Code[20])
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    begin
        pRec.Reset();
        pRec.DeleteAll();

        fInitTempTable(pRec, wDocType, wDocNo, false);
        fAddTotalLines(pRec, '');
        if (not pRec.IsEmpty()) then begin
            pRec.Reset();
        end;
    end;


    procedure fInitTempTable(var pRec: Record "Sales Line" temporary; wDocType: Option; wDocNo: Code[20]; pShowDialog: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lLineNo: Integer;
        lProgress: Codeunit "Progress Dialog2";
        tProgress: label 'Cumul des lignes de type %1';
    begin
        pRec.Reset;
        pRec.DeleteAll;

        lSalesLine.Reset;
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Line Type");
        lSalesLine.SetRange("Document Type", wDocType);
        lSalesLine.SetRange("Document No.", wDocNo);
        lSalesLine.SetFilter(Type, '%1|%2', lSalesLine.Type::Item, lSalesLine.Type::Resource);
        lSalesLine.SetFilter("No.", '<>%1', '');
        lSalesLine.SetFilter(Quantity, '<>0');
        lSalesLine.SetFilter("Quantity (Base)", '<>0');
        if lSalesLine.FindSet then begin
            if pShowDialog then
                lProgress.Open(StrSubstNo(tProgress, lSalesLine."Line Type"), lSalesLine.COUNTAPPROX);
            repeat
                if pShowDialog then
                    lProgress.Update;
                pRec.Reset;
                pRec.SetCurrentkey("Document Type", "Document No.", "Line Type");
                pRec.SetRange("Document Type", lSalesLine."Document Type");
                pRec.SetRange("Document No.", lSalesLine."Document No.");
                pRec.SetRange("Line Type", lSalesLine."Line Type");
                if lSalesLine.Type = lSalesLine.Type::Item then
                    pRec.SetRange("Item Category Code", lSalesLine."Purchasing Code")
                else
                    pRec.SetRange("Item Category Code");
                pRec.SetRange("No.", lSalesLine."No.");
                pRec.SuspendStatusCheck(true);
                if pRec.FindFirst and
                    (lSalesLine."Item Type" = 0) and (lSalesLine.Subcontracting = lSalesLine.Subcontracting::" ") then begin

                    fSetRecovery(lSalesLine, pRec);

                    //gestion de fournisseur différents dans le doc d'origine
                    if (lSalesLine."Vendor No." <> pRec."Bill-to Customer No.") then
                        pRec."Bill-to Customer No." := '****';

                    //gestion de la cadence et des durées
                    if lSalesLine."Line Type" = lSalesLine."line type"::Structure then begin
                        pRec.Duration += lSalesLine.Duration;
                        if pRec.Duration <> 0 then
                            pRec.Rate := pRec.Quantity / pRec.Duration
                        else
                            pRec.Rate := 0;
                    end;

                    if pRec."Line Type" = pRec."line type"::Structure then
                        fSetStructureInfo(lSalesLine, pRec);

                    pRec.Modify;

                end else begin
                    pRec.Init;
                    pRec."Document Type" := lSalesLine."Document Type";
                    pRec."Document No." := lSalesLine."Document No.";
                    pRec.Type := lSalesLine.Type;
                    pRec."Line Type" := lSalesLine."Line Type";
                    pRec."No." := lSalesLine."No.";
                    pRec."Bill-to Customer No." := lSalesLine."Vendor No.";
                    pRec."Item Category Code" := lSalesLine."Purchasing Code";
                    pRec."Job No." := lSalesLine."Job No.";
                    pRec."Theoretical Profit Amount(LCY)" := 0;
                    lLineNo += 10;
                    pRec."Line No." := lLineNo;
                    pRec."Unit of Measure" := '';
                    pRec.Subcontracting := lSalesLine.Subcontracting;

                    case pRec.Type of
                        pRec.Type::Item:
                            begin
                                fSetItemInfo(lSalesLine, pRec);
                            end;
                        pRec.Type::Resource:
                            begin
                                fSetResourceInfo(lSalesLine, pRec);
                                if pRec."Line Type" = pRec."line type"::Structure then begin
                                    fInitStructureInfo(pRec);
                                    fSetStructureInfo(lSalesLine, pRec);
                                end;
                            end else begin
                            pRec.Description := lSalesLine.Description;
                            pRec."Description 2" := lSalesLine."Description 2";
                            pRec."Unit of Measure Code" := lSalesLine."Unit of Measure Code";
                            pRec."Unit of Measure" := lSalesLine."Unit of Measure";
                            pRec."Gen. Prod. Posting Group" := lSalesLine."Gen. Prod. Posting Group";
                        end;
                    end;

                    fSetRecovery(lSalesLine, pRec);
                    fSetDataStored(lSalesLine, pRec);

                    pRec.Insert;

                end;
            until lSalesLine.Next = 0;
            if pShowDialog then
                lProgress.Close;
        end;

        pRec.Reset;
    end;


    procedure fSetRecovery(pSalesLine: Record "Sales Line"; var pRec: Record "Sales Line" temporary)
    begin
        //cumul des éléments valorisés

        pRec."Quantity (Base)" += pSalesLine."Quantity (Base)";
        pRec."Qty. per Unit of Measure" := 1;

        if (pRec."Quantity (Base)" <> 0) then begin
            pRec."Total Cost (LCY)" += pSalesLine."Total Cost (LCY)";
            pRec."Unit Cost (LCY)" += ROUND(pRec."Total Cost (LCY)" / pRec."Quantity (Base)", 0.01);
        end else begin
            pRec."Unit Cost (LCY)" := 0;
            pRec."Total Cost (LCY)" := 0;
        end;

        //#9206
        //pRec.Quantity := pRec."Quantity (Base)";
        pRec.Quantity += pSalesLine.Quantity;
        //#9206//
    end;

    local procedure fSetDataStored(pSalesLine: Record "Sales Line"; var pRec: Record "Sales Line" temporary)
    var
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        // Récupération des infos déjà saisies par l'utilisateur et stocké en base.

        Clear(lTotalNeedParam);
        lTotalNeedParam.SetRange("Document Type", pRec."Document Type");
        lTotalNeedParam.SetRange("Document No.", pRec."Document No.");
        lTotalNeedParam.SetRange(Type);
        if pRec.Type = pRec.Type::Item then begin
            lTotalNeedParam.SetRange(Type, lTotalNeedParam.Type::Item);
            lTotalNeedParam.SetRange("Purchasing Code", pSalesLine."Purchasing Code");
        end;
        if pRec.Type = pRec.Type::Resource then
            lTotalNeedParam.SetRange(Type, lTotalNeedParam.Type::Resource);
        lTotalNeedParam.SetRange("No.", pRec."No.");
        if (pSalesLine."Item Type" <> 0) or (pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" ") then
            lTotalNeedParam.SetRange("Line No.", pSalesLine."Line No.");
        if not lTotalNeedParam.IsEmpty then begin
            lTotalNeedParam.FindFirst;
            pRec."Unit Cost" := lTotalNeedParam.Value;
            pRec."Vendor No." := lTotalNeedParam."Vendor No.";
            pRec."Purchasing Code" := lTotalNeedParam."Purchasing Code";
            pRec."Purchasing Document Type" := lTotalNeedParam."Purchasing Document Type";
            pRec."Purchasing Order No." := lTotalNeedParam."Purchasing Order No.";
            pRec."Purchasing Order Line No." := lTotalNeedParam."Purchasing Order Line No.";
            pRec.Dummy := lTotalNeedParam."Reference Purchase Quote";
            pRec."Line Discount Amount" := lTotalNeedParam.Rate;
        end else begin
            pRec."Unit Cost" := 0;
            pRec."Vendor No." := '';
            pRec."Purchasing Code" := '';
            pRec."Line Discount Amount" := 0;
            pRec.Dummy := '';
        end;

        if (pRec."Gross Weight" <> 0) and (pRec."Unit Cost" <> 0) then
            pRec."Net Weight" := (1 - (pRec."Unit Cost" / pRec."Gross Weight")) * 100
        else
            pRec."Net Weight" := 0;
    end;

    local procedure fSetItemInfo(pSalesLine: Record "Sales Line"; var pRec: Record "Sales Line" temporary)
    var
        lArt: Record Item;
        lUnitCode: Record "Unit of Measure";
    begin
        // Fonction d'initialisation des informations relatives à un article

        pRec."Purchasing Document Type" := pSalesLine."Purchasing Document Type";
        pRec."Purchasing Order No." := pSalesLine."Purchasing Order No.";
        pRec."Purchasing Order Line No." := pSalesLine."Purchasing Order Line No.";

        pRec."Item Type" := pSalesLine."Item Type";
        pRec."Drop Shipment" := pSalesLine."Drop Shipment";
        pRec."Special Order" := pSalesLine."Special Order";


        if (pSalesLine."Item Type" <> 0) or (pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" ") then begin
            pRec.Description := pSalesLine.Description;
            pRec."Description 2" := pSalesLine."Description 2";
            pRec."Unit of Measure Code" := pSalesLine."Unit of Measure Code";
            pRec."Unit of Measure" := pSalesLine."Unit of Measure";
            pRec."Gen. Prod. Posting Group" := pSalesLine."Gen. Prod. Posting Group";
            pRec."Structure Line No." := pSalesLine."Line No."
        end else begin
            lArt.Get(pSalesLine."No.");
            pRec.Description := lArt.Description;
            pRec."Description 2" := lArt."Description 2";
            pRec."Unit of Measure Code" := lArt."Base Unit of Measure";
            if pRec."Unit of Measure Code" <> '' then begin
                lUnitCode.Get(pRec."Unit of Measure Code");
                pRec."Unit of Measure" := lUnitCode.Description;
            end;
            pRec."Gen. Prod. Posting Group" := lArt."Gen. Prod. Posting Group";
            pRec."Gross Weight" := lArt."Public Price";
            pRec."Structure Line No." := 0;
        end;
    end;

    local procedure fSetResourceInfo(pSalesLine: Record "Sales Line"; var pRec: Record "Sales Line" temporary)
    var
        lRes: Record Resource;
        lUnitCode: Record "Unit of Measure";
    begin
        // Fonction d'initialisation des informations relatives à une ressource

        lRes.Get(pSalesLine."No.");
        pRec.Description := lRes.Name;
        pRec."Description 2" := lRes."Name 2";
        pRec."Unit of Measure Code" := lRes."Base Unit of Measure";
        if pRec."Unit of Measure Code" <> '' then begin
            lUnitCode.Get(pRec."Unit of Measure Code");
            pRec."Unit of Measure" := lUnitCode.Description;
        end;
        pRec."Gen. Prod. Posting Group" := lRes."Gen. Prod. Posting Group";
        if pSalesLine."Line Type" = pSalesLine."line type"::Structure then begin
            pRec.Duration := pSalesLine.Duration;
            pRec.Rate := pSalesLine.Rate;
        end;
    end;

    local procedure fSetStructureInfo(pSalesLine: Record "Sales Line"; var pSalesLineTemp: Record "Sales Line" temporary)
    begin
        // Fonction d'initialisation des informations relatives à une ressource de type ouvrage

        pSalesLine.CalcFields("Person Quantity");
        pSalesLineTemp."Qty. to Invoice" += pSalesLine."Person Quantity";

        pSalesLine.SetRange("Line Type Filter", pSalesLine."line type filter"::Item);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Qty. to Ship" += pSalesLine."Total Cost LCY by Line Type"; //Co═t Article

        pSalesLine.SetRange("Line Type Filter", pSalesLine."line type filter"::Person);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Quantity Shipped" += pSalesLine."Total Cost LCY by Line Type"; //Co═t M.O.

        pSalesLine.SetRange("Line Type Filter", pSalesLine."line type filter"::Machine);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Quantity Invoiced" += pSalesLine."Total Cost LCY by Line Type"; //Co═t Mat▓riel

        pSalesLine.SetFilter("Line Type Filter", '<>%1&<>%2&<>%3',
            pSalesLine."line type filter"::Machine, pSalesLine."line type filter"::Person, pSalesLine."line type filter"::Item);
        pSalesLine.CalcFields("Total Cost LCY by Line Type");
        pSalesLineTemp."Qty. to Invoice (Base)" += pSalesLine."Total Cost LCY by Line Type"; //Co═t autre

        pSalesLine.SetRange("Line Type Filter");
    end;

    local procedure fInitStructureInfo(var pRec: Record "Sales Line" temporary)
    begin
        //COR-2009\\
        pRec."Qty. to Invoice" := 0;
        pRec."Qty. to Ship" := 0;
        pRec."Quantity Shipped" := 0;
        pRec."Quantity Invoiced" := 0;
        pRec."Qty. to Invoice (Base)" := 0;
    end;


    procedure fChangeCategory(var pRec: Record "Sales Line" temporary; pLineType: Option Item,Person,Machine,SubContracting,Structure)
    begin
        case pLineType of
            Plinetype::Item:
                begin//Item
                    pRec.SetRange("Line Type", pRec."line type"::Item);
                    pRec.SetRange(Subcontracting, pRec.Subcontracting::" ");
                end;
            Plinetype::Person:
                begin//Person
                    pRec.SetRange("Line Type", pRec."line type"::Person);
                    pRec.SetRange(Subcontracting, pRec.Subcontracting::" ");
                end;
            Plinetype::Machine:
                begin//Machine
                    pRec.SetRange("Line Type", pRec."line type"::Machine);
                    pRec.SetRange(Subcontracting, pRec.Subcontracting::" ");
                end;
            Plinetype::SubContracting:
                begin//Item with Subcontracting
                    pRec.SetRange("Line Type", pRec."line type"::Item);
                    pRec.SetFilter(Subcontracting, '<>%1', pRec.Subcontracting::" ");
                end;
            Plinetype::Structure:
                begin//Structure
                    pRec.SetRange("Line Type", pRec."line type"::Structure);
                    pRec.SetRange(Subcontracting, pRec.Subcontracting::" ");
                end;
        end;
    end;


    procedure fAddTotalLines(var pRec: Record "Sales Line" temporary; pProdPostGroupFilter: Text[1024])
    var
        lSalesLine: Record "Sales Line";
    begin
        //fSetPosition();

        //ITEM
        lSalesLine.Reset();
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        lSalesLine.SetRange("Line Type", pRec."line type"::Item);
        lSalesLine.SetRange(Subcontracting, pRec.Subcontracting::" ");
        //#8336
        lSalesLine.SetFilter(Type, '%1', lSalesLine.Type::Item);
        lSalesLine.SetFilter("No.", '<>%1', '');
        lSalesLine.SetFilter(Quantity, '<>0');
        lSalesLine.SetFilter("Quantity (Base)", '<>0');
        //#8336//

        if pProdPostGroupFilter <> '' then
            lSalesLine.SetFilter("Gen. Prod. Posting Group", pProdPostGroupFilter);
        fInsertTotalLine(pRec, lSalesLine, pProdPostGroupFilter);
        //Person
        lSalesLine.Reset();
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        lSalesLine.SetRange("Line Type", pRec."line type"::Person);
        lSalesLine.SetRange(Subcontracting, pRec.Subcontracting::" ");
        //#8336
        lSalesLine.SetFilter(Type, '%1', lSalesLine.Type::Resource);
        lSalesLine.SetFilter("No.", '<>%1', '');
        lSalesLine.SetFilter(Quantity, '<>0');
        lSalesLine.SetFilter("Quantity (Base)", '<>0');
        //#8336//
        if pProdPostGroupFilter <> '' then
            lSalesLine.SetFilter("Gen. Prod. Posting Group", pProdPostGroupFilter);
        fInsertTotalLine(pRec, lSalesLine, pProdPostGroupFilter);
        //Machine
        lSalesLine.Reset();
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        lSalesLine.SetRange("Line Type", pRec."line type"::Machine);
        lSalesLine.SetRange(Subcontracting, pRec.Subcontracting::" ");
        //#8336
        lSalesLine.SetFilter(Type, '%1', lSalesLine.Type::Resource);
        lSalesLine.SetFilter("No.", '<>%1', '');
        lSalesLine.SetFilter(Quantity, '<>0');
        lSalesLine.SetFilter("Quantity (Base)", '<>0');
        //#8336//
        if pProdPostGroupFilter <> '' then
            lSalesLine.SetFilter("Gen. Prod. Posting Group", pProdPostGroupFilter);
        fInsertTotalLine(pRec, lSalesLine, pProdPostGroupFilter);
        //Subcontracting
        lSalesLine.Reset();
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        lSalesLine.SetRange("Line Type", pRec."line type"::Item);
        lSalesLine.SetFilter(Subcontracting, '<>%1', pRec.Subcontracting::" ");
        //#8336
        lSalesLine.SetFilter(Type, '%1', lSalesLine.Type::Item);
        lSalesLine.SetFilter("No.", '<>%1', '');
        lSalesLine.SetFilter(Quantity, '<>0');
        lSalesLine.SetFilter("Quantity (Base)", '<>0');
        //#8336//
        if pProdPostGroupFilter <> '' then
            lSalesLine.SetFilter("Gen. Prod. Posting Group", pProdPostGroupFilter);
        fInsertTotalLine(pRec, lSalesLine, pProdPostGroupFilter);
        //Structure
        lSalesLine.Reset();
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        lSalesLine.SetRange("Line Type", pRec."line type"::Structure);
        lSalesLine.SetRange(Subcontracting, pRec.Subcontracting::" ");
        if pProdPostGroupFilter <> '' then
            lSalesLine.SetFilter("Gen. Prod. Posting Group", pProdPostGroupFilter);
        fInsertTotalLine(pRec, lSalesLine, pProdPostGroupFilter);

        //fGetPosition();
    end;


    procedure fInsertTotalLine(var pRec: Record "Sales Line" temporary; var pSalesLine: Record "Sales Line"; pProdPostGroupFilter: Text[1024])
    var
        lLineNo: Integer;
        lTotalQty: Decimal;
        lTotalQtyBase: Decimal;
        lTotalCost: Decimal;
    begin
        Clear(lTotalQty);
        Clear(lTotalQtyBase);
        Clear(lTotalCost);
        if (not pSalesLine.IsEmpty) then begin
            if (pSalesLine."Line Type" = pSalesLine."line type"::Item) and (pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" ")
          then
                pSalesLine.SetFilter(Quantity, '<>%1', 0);
            pSalesLine.FindFirst();
            repeat
                lTotalQty += pSalesLine.Quantity;
                lTotalQtyBase += pSalesLine."Quantity (Base)";
                lTotalCost += pSalesLine."Total Cost (LCY)";
            until (pSalesLine.Next() = 0);
            if (pSalesLine."Line Type" = pSalesLine."line type"::Item) and (pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" ")
          then
                pSalesLine.SetRange(Quantity);
            pSalesLine.FindFirst();
        end;
        // Insertion d'une ligne dans la table temportaire
        //recherche du dernier numero
        pRec.Reset();

        if (pRec.FindLast()) and (not pSalesLine.IsEmpty()) then begin
            lLineNo := pRec."Line No.";
            lLineNo += 1;
            pRec.Init();
            pRec.Subcontracting := pSalesLine.Subcontracting;
            pRec."Document Type" := pSalesLine."Document Type";
            pRec."Document No." := pSalesLine."Document No.";
            if (pSalesLine.Type = pSalesLine.Type::Resource) then begin
                pRec.Quantity := lTotalQty;
                pRec."Quantity (Base)" := lTotalQtyBase;
            end;
            pRec."Total Cost (LCY)" := lTotalCost;
            pRec."Line No." := lLineNo;
            pRec."Gen. Bus. Posting Group" := pProdPostGroupFilter;
            pRec.Description := StrSubstNo(TextTotalDesc, pSalesLine."Line Type");
            case (pSalesLine."Line Type") of
                pSalesLine."line type"::Item:
                    begin
                        pRec.Type := pSalesLine.Type::Item;
                        pRec."Line Type" := pSalesLine."line type"::Item;
                        if (pSalesLine.Subcontracting <> pSalesLine.Subcontracting::" ") then begin
                            pRec.Description := TextTotalSTDesc;
                            pRec."No." := TextTotalSTNo;
                            pRec.Subcontracting := 1;
                        end else
                            pRec."No." := TextTotalItemNo;
                    end;
                pSalesLine."line type"::Person:
                    begin
                        pRec.Type := pSalesLine.Type::Resource;
                        pRec."Line Type" := pSalesLine."line type"::Person;
                        pRec."No." := TextTotalResNo;
                    end;
                pSalesLine."line type"::Machine:
                    begin
                        pRec.Type := pSalesLine.Type::Resource;
                        pRec."Line Type" := pSalesLine."line type"::Machine;
                        pRec."No." := TextTotalMachNo;
                    end;
                pSalesLine."line type"::Structure:
                    begin
                        pRec.Type := pSalesLine.Type::Resource;
                        pRec."Line Type" := pSalesLine."line type"::Structure;
                        pRec."No." := TextTotalStrucNo;
                    end;
            end;
            pRec.Insert();
        end;
    end;


    procedure fRefreshTotal(var pRec: Record "Sales Line" temporary; pProdPostGroupFilter: Text[1024])
    var
        lLineNo: Integer;
        lRecTmp: Record "Sales Line" temporary;
    begin
        lRecTmp := pRec;
        pRec.Reset();
        pRec.SetRange("No.", TextTotalItemNo);
        if pRec.FindSet then
            pRec.Delete(false);
        pRec.Reset();
        pRec.SetRange("No.", TextTotalResNo);
        if pRec.FindSet then
            pRec.Delete(false);
        pRec.Reset();
        pRec.SetRange("No.", TextTotalSTNo);
        if pRec.FindSet then
            pRec.Delete(false);
        pRec.Reset();
        pRec.SetRange("No.", TextTotalMachNo);
        if pRec.FindSet then
            pRec.Delete(false);
        pRec.Reset();
        pRec.SetRange("No.", TextTotalStrucNo);
        if pRec.FindSet then
            pRec.Delete(false);
        pRec.Reset();

        fAddTotalLines(pRec, pProdPostGroupFilter);

        pRec := lRecTmp;
    end;


    procedure fOnModify(var pRec: Record "Sales Line"; pxRec: Record "Sales Line"): Boolean
    var
        lItem: Record Item;
        lRec: Record "Sales Line";
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        //traitement de la procédure d'achat
        if (pRec.Type = pRec.Type::Item) and (pxRec."Purchasing Code" <> pRec."Purchasing Code") then begin
            if not (pRec."Purchasing Code" <> '') then begin
                pRec."Item Category Code" := pRec."Purchasing Code";
            end
            else begin
                if (pRec.Type = pRec.Type::Item) and (lItem.Get(pRec."No.")) then begin
                    pRec."Item Category Code" := lItem."Purchasing Code";
                end else
                    pRec."Item Category Code" := '';
                fSalesOverheadUpdateProc(pRec, lTotalNeedParam.Type::Item, pRec."Item Category Code", (pRec."Item Category Code" <> ''));
            end;
        end;

        //traitement du N° de fournisseur
        if (pRec.Type = pRec.Type::Item) and (pxRec."Vendor No." <> pRec."Vendor No.") then begin
            if (pRec."Vendor No." <> '') then begin
                pRec."Bill-to Customer No." := pRec."Vendor No.";
            end;
            fSalesOverheadUpdateVendor(pRec, lTotalNeedParam.Type::Item, pRec."Vendor No.", (pRec."Vendor No." <> ''));
        end;

        //traitement du prix unitaire
        if pxRec."Unit Cost" <> pRec."Unit Cost" then begin
            if not (pRec."Unit Cost" <> 0) then begin
                pRec."Unit Cost (LCY)" := pRec."Unit Cost";
                pRec."Total Cost (LCY)" := pRec."Unit Cost (LCY)" * pRec."Quantity (Base)";
            end
            else begin
                fFindUnitCost(pRec);
                pRec."Total Cost (LCY)" := pRec."Unit Cost (LCY)" * pRec."Quantity (Base)";
                pRec."Unit Cost" := 0;
            end;
        end;

        exit(pRec.Modify);
    end;


    procedure fValidatePurchasingCode(var pRec: Record "Sales Line")
    var
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        if pRec."No." in [TextTotalItemNo, TextTotalResNo, TextTotalMachNo, TextTotalStrucNo] then begin
            pRec."Unit Cost" := 0;
            exit;
        end;
        if pRec.Type = pRec.Type::Item then begin
            if lTotalNeedParam.Get(pRec."Document Type", pRec."Document No.", lTotalNeedParam.Type::Item,
                                         pRec."No.", pRec."Structure Line No.", pRec."Item Category Code") then
                if lTotalNeedParam."Purchasing Order No." <> '' then
                    Error(tErrorFieldTest, pRec.FieldCaption("Purchasing Code"));
            fSalesOverheadUpdateProc(pRec, lTotalNeedParam.Type::Item, pRec."Purchasing Code", pRec."Purchasing Code" = '');
            pRec."Item Category Code" := pRec."Purchasing Code";
            pRec.Modify;
        end;
    end;


    procedure fSalesOverheadUpdateProc(var pRec: Record "Sales Line"; pType: Integer; pPurchasing: Code[20]; pDelete: Boolean)
    var
        lTotalNeedParam: Record "Sales Document Cost";
        lSalesLine: Record "Sales Line";
        lStructureLine: Record "Sales Line";
        lOverhead: Codeunit "Overhead Calculation";
        lItem: Record Item;
        lModify: Boolean;
        lLineNo: Integer;
    begin
        fSetTotalNeedSetup(pRec, lTotalNeedParam, pType, pRec.FieldNo("Purchasing Code"));

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        if (pRec."Item Type" <> 0) or (pRec.Subcontracting <> pRec.Subcontracting::" ") then
            lSalesLine.SetRange("Line No.", pRec."Structure Line No.");
        lSalesLine.SetRange("Line Type", pRec."Line Type");
        if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then begin
            lSalesLine.SetRange("No.", pRec."No.");
            lSalesLine.SetRange("Purchasing Code", pRec."Item Category Code");
        end;

        if lSalesLine.Find('-') then
            repeat
                if lSalesLine."Line Type" <> lSalesLine."line type"::Structure then begin
                    if pType in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then begin
                        if pDelete then begin
                            if (lSalesLine.Type = lSalesLine.Type::Item) and lItem.Get(lSalesLine."No.") then begin
                                lSalesLine.Validate("Purchasing Code", lItem."Purchasing Code");
                            end;
                        end else
                            lSalesLine.Validate("Purchasing Code", lTotalNeedParam."Purchasing Code");
                        lSalesLine.Modify;
                    end;
                end;
            until lSalesLine.Next = 0;

        //Gestion du regroupement des articles
        if lItem.Get(pRec."No.") then begin
            if lItem."Item Type" = lItem."item type"::" " then begin
                lSalesLine := pRec;
                pRec.SetRange("No.", pRec."No.");
                pRec.SetRange("Item Category Code", pRec."Purchasing Code");
                pRec.SetFilter("Line No.", '<>%1', pRec."Line No.");
                lModify := not pRec.IsEmpty;
                if lModify then begin
                    pRec.FindFirst;
                    lLineNo := pRec."Line No.";
                    fSetRecovery(lSalesLine, pRec);

                    if pRec."Bill-to Customer No." <> lSalesLine."Bill-to Customer No." then
                        pRec."Bill-to Customer No." := '****';
                    pRec.Modify;
                end;
                pRec.SetRange("Line No.");
                pRec.SetRange("No.");
                pRec.SetRange("Item Category Code");
                if lModify then begin
                    pRec.Get(pRec."Document Type", pRec."Document No.", lSalesLine."Line No.");
                    pRec.Delete;
                    pRec.Get(pRec."Document Type", pRec."Document No.", lLineNo);
                end;
            end;
        end;
    end;


    procedure fSalesOverheadUpdateVendor(var pRec: Record "Sales Line"; pType: Integer; pVendor: Code[20]; pDelete: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lTotalNeedParam: Record "Sales Document Cost";
        lStructureLine: Record "Sales Line";
        lOverhead: Codeunit "Overhead Calculation";
        lItem: Record Item;
    begin
        fSetTotalNeedSetup(pRec, lTotalNeedParam, pType, pRec.FieldNo("Vendor No."));

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");

        if (pRec."Item Type" <> 0) or (pRec.Subcontracting <> pRec.Subcontracting::" ") then
            lSalesLine.SetRange("Line No.", pRec."Structure Line No.");

        lSalesLine.SetRange("Line Type", pRec."Line Type");

        if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then begin
            lSalesLine.SetRange("No.", pRec."No.");
            lSalesLine.SetRange("Purchasing Code", pRec."Item Category Code");
        end;

        if lSalesLine.FindSet(true, false) then
            repeat
                if lSalesLine."Line Type" <> lSalesLine."line type"::Structure then begin
                    if pType in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then begin
                        lSalesLine.Validate("Vendor No.", lTotalNeedParam."Vendor No.");
                        lSalesLine.Modify;
                    end;
                end;
            until lSalesLine.Next = 0;
    end;


    procedure fSetDefaultVendor(var pRec: Record "Sales Line"; pLineType: Option Item,Person,Machine,SubContracting,Structure; pProdPostGroupFilter: Text[1024])
    var
        tError: label 'This function is usable with the line type "Item"';
        lItem: Record Item;
        lRec: Record "Sales Line";
        lSalesLineTemp2: Record "Sales Line" temporary;
    begin
        pRec.FindSet;
        if (pRec.Type <> pRec.Type::Item) then
            Error(tError);
        lRec := pRec;
        lSalesLineTemp2.DeleteAll;
        repeat
            lSalesLineTemp2 := pRec;
            lSalesLineTemp2.Insert;
        until pRec.Next = 0;
        if lSalesLineTemp2.FindSet then
            repeat
                if lItem.Get(lSalesLineTemp2."No.") then begin
                    pRec := lSalesLineTemp2;
                    lSalesLineTemp2."Vendor No." := lItem."Vendor No.";
                    pRec."Vendor No." := lItem."Vendor No.";
                    fValidateVendor(lSalesLineTemp2, false, pLineType, pProdPostGroupFilter);
                    fOnModify(lSalesLineTemp2, pRec);
                end;
            until lSalesLineTemp2.Next = 0;
        pRec := lRec;
    end;


    procedure fValidateVendor(var pRec: Record "Sales Line"; pEmptyVendor: Boolean; pLineType: Option Item,Person,Machine,SubContracting,Structure; pProdPostGroupFilter: Text[1024])
    var
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        if (pRec."No." in [TextTotalItemNo, TextTotalResNo, TextTotalMachNo, TextTotalStrucNo]) then begin
            pRec."Unit Cost" := 0;
            exit;
        end;
        if pRec.Type = pRec.Type::Item then begin
            if lTotalNeedParam.Get(pRec."Document Type", pRec."Document No.", lTotalNeedParam.Type::Item
                                 , pRec."No.", pRec."Structure Line No.", pRec."Item Category Code") then
                if lTotalNeedParam."Purchasing Order No." <> '' then
                    Error(tErrorFieldTest, pRec.FieldCaption("Vendor No."), pRec."Purchasing Document Type", pRec."Purchase Order No.");
            pEmptyVendor := pRec."Vendor No." = '';
            fSalesOverheadUpdateVendor(pRec, lTotalNeedParam.Type::Item, pRec."Vendor No.", pEmptyVendor);
            fCalcBestPriceAndDisc(pRec, pRec."Vendor No.", pLineType, pProdPostGroupFilter);
            pRec."Bill-to Customer No." := pRec."Vendor No.";
            if lTotalNeedParam.Get(pRec."Document Type", pRec."Document No.", lTotalNeedParam.Type::Item
                                 , pRec."No.", pRec."Structure Line No.", pRec."Item Category Code") then
                if (lTotalNeedParam.Value <> 0) then
                    pRec."Unit Cost" := lTotalNeedParam.Value;
        end;
    end;


    procedure fCalcBestPriceAndDisc(var pRec: Record "Sales Line"; pVendor: Code[20]; pLineType: Option Item,Person,Machine,SubContracting,Structure; pProdPostGroupFilter: Text[1024])
    var
        lPurchLineTemp: Record "Purchase Line" temporary;
        lPurchHeaderTemp: Record "Purchase Header" temporary;
        lPurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        lItem: Record Item;
        lItemUnitOfmesure: Record "Item Unit of Measure";
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        if pVendor <> '' then begin
            lPurchHeaderTemp.Init;
            lPurchHeaderTemp."Document Type" := lPurchHeaderTemp."document type"::Quote;
            lPurchHeaderTemp.Validate("Buy-from Vendor No.", pVendor);

            lPurchLineTemp.Init;
            lPurchLineTemp.Type := lPurchLineTemp.Type::Item;
            lPurchLineTemp."No." := pRec."No.";
            lPurchLineTemp."Buy-from Vendor No." := pVendor;
            lPurchLineTemp."Pay-to Vendor No." := lPurchHeaderTemp."Pay-to Vendor No.";
            lItem.Get(pRec."No.");
            lPurchLineTemp."Unit of Measure Code" := lItem."Purch. Unit of Measure";
            lItemUnitOfmesure.Get(pRec."No.", lItem."Purch. Unit of Measure");
            lPurchLineTemp."Quantity (Base)" := pRec."Quantity (Base)";
            lPurchLineTemp.Quantity := pRec."Quantity (Base)" / lItemUnitOfmesure."Qty. per Unit of Measure";

            lPurchPriceCalcMgt.FindPurchLinePrice(lPurchHeaderTemp, lPurchLineTemp, 0);
            lPurchPriceCalcMgt.FindPurchLineLineDisc(lPurchHeaderTemp, lPurchLineTemp);

            pRec."Unit Cost" := lPurchLineTemp."Direct Unit Cost";
            pRec."Net Weight" := lPurchLineTemp."Line Discount %";
            fAfterValidateNetWeight(pRec, pLineType, pProdPostGroupFilter);
        end else begin
            pRec."Net Weight" := 0;
            pRec."Unit Cost" := 0;
            fSalesOverheadUpdate(pRec, lTotalNeedParam.Type::Item, pRec."Unit Cost", true);
            fRefreshTotal(pRec, pProdPostGroupFilter);
            fChangeCategory(pRec, pLineType);
        end;
    end;


    procedure fAfterValidateNetWeight(var pRec: Record "Sales Line"; pLineType: Option Item,Person,Machine,SubContracting,Structure; pProdPostGroupFilter: Text[1024])
    var
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        if pRec."Gross Weight" <> 0 then begin
            pRec."Unit Cost" := pRec."Gross Weight" * (1 - pRec."Net Weight" / 100);
            if (pRec."No." in [TextTotalItemNo, TextTotalResNo, TextTotalMachNo, TextTotalStrucNo]) then begin
                pRec."Unit Cost" := 0;
                exit;
            end;
            if pRec.Type = pRec.Type::Item then begin
                fSalesOverheadUpdate(pRec, lTotalNeedParam.Type::Item, pRec."Unit Cost", pRec."Net Weight" = 0);
                fRefreshTotal(pRec, pProdPostGroupFilter);
                fChangeCategory(pRec, pLineType);
            end;
        end;
    end;


    procedure fSalesOverheadUpdate(var pRec: Record "Sales Line"; pType: Integer; pValue: Decimal; pDelete: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lTotalNeedParam: Record "Sales Document Cost";
        lStructureLine: Record "Sales Line";
        lOverhead: Codeunit "Overhead Calculation";
        lxRec: Record "Sales Line";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lStructureMgt: Codeunit "Structure Management";
        lTotalCost: Decimal;
    begin
        fSetTotalNeedSetup(pRec, lTotalNeedParam, pType, pRec.FieldNo("Unit Cost"));

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        if (pRec."Item Type" <> 0) or (pRec.Subcontracting <> pRec.Subcontracting::" ") then
            lSalesLine.SetRange("Line No.", pRec."Structure Line No.");
        lSalesLine.SetRange("Line Type", pRec."Line Type");
        if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item] then
            lSalesLine.SetRange("Purchasing Code", pRec."Item Category Code");

        if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then
            lSalesLine.SetRange("No.", pRec."No.");
        if lSalesLine.FindSet(true, false) then
            repeat
                if lSalesLine."Line Type" <> lSalesLine."line type"::Structure then begin
                    if pType in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then begin
                        if pDelete then
                            fFindUnitCost(lSalesLine)
                        else
                            lSalesLine.Validate("Unit Cost (LCY)", lTotalNeedParam.Value * lSalesLine."Qty. per Unit of Measure");
                        lSalesLine.Modify;

                        lTotalCost := lSalesLine."Total Cost (LCY)";

                        if lSalesLine."Structure Line No." <> 0 then
                            if lStructureLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Structure Line No.") then begin
                                //A optimiser
                                lxRec := lStructureLine;
                                lStructureMgt.SumStructureLines(lStructureLine);
                                lStructureLine.Modify;
                                lStructureLine.wUpdateLine(lStructureLine, lxRec, false);
                            end;
                    end;
                end;
            until lSalesLine.Next = 0;
        //#9359
        //  pRec.VALIDATE("Unit Cost (LCY)",lSalesLine."Unit Cost (LCY)" * pRec."Qty. per Unit of Measure");
        pRec.Validate("Total Cost (LCY)", lSalesLine."Unit Cost (LCY)" * pRec."Qty. per Unit of Measure" * pRec."Quantity (Base)");
        //#9359//
        if pDelete then
            pRec."Unit Cost" := 0;
        pRec.Modify;

        //fRefreshTotal(pRec,ProdPostGroupFilter);
        //fChangeCategory(pRec,pLineType);
    end;


    procedure fValidateUnitCost(var pRec: Record "Sales Line"; pLineType: Option Item,Person,Machine,SubContracting,Structure; pProdPostGroupFilter: Text[1024])
    var
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        if (pRec."No." in [TextTotalItemNo, TextTotalResNo, TextTotalMachNo, TextTotalStrucNo]) then begin
            pRec."Unit Cost" := 0;
            exit;
        end;
        case pRec.Type of
            pRec.Type::Item:
                begin
                    fSalesOverheadUpdate(pRec, lTotalNeedParam.Type::Item, pRec."Unit Cost", pRec."Unit Cost" = 0);
                end;
            pRec.Type::Resource:
                begin
                    if pRec."Line Type" in [pRec."line type"::Person, pRec."line type"::Machine] then begin
                        fSalesOverheadUpdate(pRec, lTotalNeedParam.Type::Resource, pRec."Unit Cost", pRec."Unit Cost" = 0);
                    end else
                        if pRec."Line Type" = pRec."line type"::Structure then
                            pRec."Unit Cost" := 0;
                end;
        end;
        pRec.Modify;
        fRefreshTotal(pRec, pProdPostGroupFilter);
        fChangeCategory(pRec, pLineType);
    end;


    procedure fUpdateUnitCost(var pRec: Record "Sales Line" temporary; pLineType: Option Item,Person,Machine,SubContracting,Structure; pProdPostGroupFilter: Text[1024])
    var
        lPurchLine: Record "Purchase Line";
        lPurchLine2: Record "Purchase Line";
        lPurchSelectLine: Record "Purchase Line";
        lSalesLine: Record "Sales Line";
        lStructureLine: Record "Sales Line";
        lPriceOfferSetup: Record "Price Offer Setup";
        lOldLineType: Integer;
        lVendorNo: Code[20];
        lxRec: Record "Sales Line";
        NbreTot: Integer;
        tUpdate: label 'Update....';
        Jauge: Integer;
        Windows: Dialog;
        lTotalNeedParam: Record "Sales Document Cost";
        lStructureMgt: Codeunit "Structure Management";
    begin
        Windows.Open(tUpdate + '@1@@@@@@@@@@@@@@@@@@@');
        lPriceOfferSetup.Get;

        lOldLineType := pLineType;
        pLineType := Plinetype::Item;
        fChangeCategory(pRec, pLineType);

        pRec.SetFilter("No.", '<>%1', TextTotalItemNo);
        pRec.SetRange(Subcontracting, 0);
        NbreTot := pRec.Count;
        Jauge := 0;
        if pRec.Find('-') then
            repeat
                Jauge += 1;
                Windows.Update(1, ROUND(Jauge / NbreTot * 10000, 1));
                lVendorNo := pRec."Bill-to Customer No.";   //DEVIS
                if (pRec."Purchasing Code" <> '') and (pRec."Purchasing Order No." <> '') then begin
                    lPurchLine.Get(pRec."Purchasing Document Type", pRec."Purchasing Order No.", pRec."Purchasing Order Line No.");
                    //DEVIS
                    if lPurchSelectLine.Get(pRec."Purchasing Document Type", lPurchLine."Selected Doc. No.",
                                            lPurchLine."Selected Doc. Line No.") then
                        lVendorNo := lPurchSelectLine."Buy-from Vendor No.";
                    //DEVIS//
                    if lTotalNeedParam.Get(pRec."Document Type", pRec."Document No.", lTotalNeedParam.Type::Item, pRec."No.",
                                         pRec."Structure Line No.", pRec."Item Category Code") then begin
                        if lPurchLine."Unit Cost (LCY)" <> 0 then begin
                            lTotalNeedParam.Value := lPurchLine."Unit Cost (LCY)";
                            lTotalNeedParam.Modify;
                        end;
                    end else begin
                        //#4419
                        lTotalNeedParam.Init;
                        //#4419//
                        lTotalNeedParam."Document Type" := pRec."Document Type";
                        lTotalNeedParam."Document No." := pRec."Document No.";
                        lTotalNeedParam.Type := lTotalNeedParam.Type::Item;
                        lTotalNeedParam."No." := pRec."No.";
                        lTotalNeedParam."Purchasing Code" := pRec."Item Category Code";  //DEVIS
                        lTotalNeedParam."Line No." := pRec."Structure Line No.";
                        lTotalNeedParam.Value := lPurchLine."Unit Cost (LCY)";
                        lTotalNeedParam.Insert;
                    end;
                end else begin
                    if pRec."Unit Cost" <> 0 then
                        lTotalNeedParam.Value := pRec."Unit Cost"
                    else begin
                        fFindUnitCost(pRec);
                        lTotalNeedParam.Value := pRec."Unit Cost (LCY)";
                    end;
                    lTotalNeedParam.Type := lTotalNeedParam.Type::Item;
                end;

                lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
                lSalesLine.SetRange("Document Type", pRec."Document Type");
                lSalesLine.SetRange("Document No.", pRec."Document No.");
                if (pRec."Item Type" <> 0) or (pRec.Subcontracting <> pRec.Subcontracting::" ") then
                    lSalesLine.SetRange("Line No.", pRec."Structure Line No.");
                lSalesLine.SetRange("Line Type", pRec."Line Type");
                lSalesLine.SetRange(Subcontracting, lSalesLine.Subcontracting::" ");
                if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then begin
                    lSalesLine.SetRange("No.", pRec."No.");
                    //DEVIS
                    lSalesLine.SetRange("Purchasing Code", pRec."Item Category Code");
                end;
                //DEVIS
                if lSalesLine.Find('-') then
                    repeat
                        if lSalesLine."Line Type" <> lSalesLine."line type"::Structure then begin
                            if lVendorNo <> '' then
                                lSalesLine."Vendor No." := lVendorNo;
                            lSalesLine.Validate("Unit Cost (LCY)", lTotalNeedParam.Value * lSalesLine."Qty. per Unit of Measure");
                            lSalesLine.Modify;
                        end;
                    until lSalesLine.Next = 0;
            until pRec.Next = 0;

        lSalesLine.Reset;
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetRange("Line Type", pRec."line type"::Structure);
        lSalesLine.SetRange(Subcontracting, 0);
        if lSalesLine.Find('-') then
            repeat
                lxRec := lSalesLine;
                lStructureMgt.SumStructureLines(lSalesLine);
                lSalesLine.Modify;
                lSalesLine.wUpdateLine(lSalesLine, lxRec, false);
            until lSalesLine.Next = 0;

        Windows.Close;
        pRec.SetRange("No.");

        pLineType := lOldLineType;

        fRefreshTotal(pRec, pProdPostGroupFilter);
        fChangeCategory(pRec, pLineType);
    end;


    procedure fFindUnitCost(var pSalesLine: Record "Sales Line")
    var
        lTotalNeedParam: Record "Sales Document Cost";
        lRescost: Record "Resource Cost";
        lSalesHeader: Record "Sales Header";
        ResFindUnitCost: Codeunit "Resource-Find Cost";
        lItem: Record Item;
        lSKU: Record "Stockkeeping Unit";
    begin
        with pSalesLine do begin
            if Type = Type::Resource then begin
                if lSalesHeader.Get("Document Type", "Document No.") then;
                lRescost.Init;
                lRescost.Code := "No.";
                lRescost."Work Type Code" := "Work Type Code";
                if "Document Type" in ["document type"::Quote, "document type"::Order] then
                    lRescost."Starting Date" := lSalesHeader."Order Date"
                else
                    lRescost."Starting Date" := lSalesHeader."Posting Date";
                //GL2024    ResFindUnitCost.Run(lRescost);
                Validate("Unit Cost (LCY)", lRescost."Unit Cost");
            end;
            if Type = Type::Item then begin
                lItem.Get("No.");
                if lItem."Item Type" <> lItem."item type"::Generic then begin
                    if lItem."Standard Cost" = 0 then
                        lItem."Standard Cost" := lItem."Unit Cost";
                    //#7434
                    if (lItem."Standard Cost" = 0) and (lItem."Public Price" <> 0) then
                        lItem."Standard Cost" := lItem."Public Price";
                    //#7434//
                    if lSKU.Get("Location Code", "No.", "Variant Code") then begin
                        Validate("Unit Cost (LCY)", lSKU."Standard Cost" * "Qty. per Unit of Measure");
                    end else begin
                        Validate("Unit Cost (LCY)", lItem."Standard Cost" * "Qty. per Unit of Measure");
                    end;
                end;
            end;
        end;
    end;

    local procedure fSetTotalNeedSetup(var pRec: Record "Sales Line"; var pTotalNeedParam: Record "Sales Document Cost"; pType: Integer; pFieldNo: Integer)
    var
        lTotalNeedParam2: Record "Sales Document Cost";
    begin
        //Gestion de la table de paramètrage du besoin cumulé
        if pTotalNeedParam.Get(pRec."Document Type", pRec."Document No.", pType, pRec."No.",
                                pRec."Structure Line No.", pRec."Item Category Code") then begin

            if (pRec."Vendor No." = '') and (pRec."Unit Cost" = 0) and
               (pRec."Purchasing Code" = '') and (pRec."Line Discount Amount" = 0) then
                pTotalNeedParam.Delete
            else
                case pFieldNo of
                    pRec.FieldNo("Purchasing Code"):
                        begin
                            if not lTotalNeedParam2.Get(pRec."Document Type", pRec."Document No.", pType, pRec."No.",
                                     pRec."Structure Line No.", pRec."Purchasing Code") then
                                pTotalNeedParam.Rename(pRec."Document Type", pRec."Document No.", pType, pRec."No.",
                                                        pRec."Structure Line No.", pRec."Purchasing Code")
                            else begin
                                if lTotalNeedParam2."Vendor No." <> pTotalNeedParam."Vendor No." then begin
                                    lTotalNeedParam2."Vendor No." := '';
                                    //            pRec."Vendor No." := '';
                                end;
                                if lTotalNeedParam2.Value <> pTotalNeedParam.Value then begin
                                    lTotalNeedParam2.Value := 0;
                                    pRec."Unit Cost" := 0;
                                end;
                                lTotalNeedParam2.Modify;

                                pTotalNeedParam.Delete;
                                pTotalNeedParam := lTotalNeedParam2;
                                pRec.Modify;
                            end;
                        end;
                    pRec.FieldNo("Vendor No."):
                        begin
                            pTotalNeedParam."Vendor No." := pRec."Vendor No.";
                            pTotalNeedParam.Modify;
                        end;
                    pRec.FieldNo("Unit Cost"):
                        begin
                            pTotalNeedParam.Value := pRec."Unit Cost";
                            pTotalNeedParam.Modify;
                        end;
                    pRec.FieldNo(pRec."Line Discount Amount"):
                        begin
                            pTotalNeedParam.Rate := pRec."Line Discount Amount";
                            pTotalNeedParam.Modify;
                        end;
                end;

        end else
            if (pRec."Vendor No." <> '') or (pRec."Unit Cost" <> 0) or
               (pRec."Purchasing Code" <> '') or (pRec."Line Discount Amount" <> 0) then begin
                pTotalNeedParam.Init;
                pTotalNeedParam."Document Type" := pRec."Document Type";
                pTotalNeedParam."Document No." := pRec."Document No.";
                pTotalNeedParam.Type := pType;
                pTotalNeedParam."No." := pRec."No.";
                if pRec."Purchasing Code" <> '' then
                    pTotalNeedParam."Purchasing Code" := pRec."Purchasing Code"
                else
                    pTotalNeedParam."Purchasing Code" := pRec."Item Category Code";
                pTotalNeedParam."Vendor No." := pRec."Vendor No.";
                pTotalNeedParam.Value := pRec."Unit Cost";
                pTotalNeedParam.Rate := pRec."Line Discount Amount";
                pTotalNeedParam."Line No." := pRec."Structure Line No.";
                if not pTotalNeedParam.Insert then
                    pTotalNeedParam.Modify;
            end;
    end;


    procedure fSalesOverheadUpdateRate(var pRec: Record "Sales Line"; pType: Integer; pDelete: Boolean)
    var
        lSalesLine: Record "Sales Line";
        lStruct: Record Resource;
        lTotalNeedParam: Record "Sales Document Cost";
    begin
        fSetTotalNeedSetup(pRec, lTotalNeedParam, pType, pRec.FieldNo("Line Discount Amount"));

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        if (pRec."Item Type" <> 0) or (pRec.Subcontracting <> pRec.Subcontracting::" ") then
            lSalesLine.SetRange("Line No.", pRec."Structure Line No.");
        lSalesLine.SetRange("Line Type", lSalesLine."line type"::Structure);
        if lTotalNeedParam.Type in [lTotalNeedParam.Type::Item, lTotalNeedParam.Type::Resource] then
            lSalesLine.SetRange("No.", pRec."No.");
        pRec.Duration := 0;
        if lSalesLine.Find('-') then
            repeat
                if pDelete then begin
                    if lSalesLine."Line Type" = lSalesLine."line type"::Structure then
                        if lStruct.Get(lSalesLine."No.") then
                            lSalesLine.Validate(Rate, lStruct.Rate)
                        else
                            lSalesLine.Validate(Rate, 0);
                end
                else
                    lSalesLine.Validate(Rate, lTotalNeedParam.Rate);
                lSalesLine.Modify;
                pRec.Duration += lSalesLine.Duration;
            until lSalesLine.Next = 0;
    end;


    procedure fSalesOverheadUpdateQty(var pRec: Record "Sales Line"; pLineType: Option Item,Person,Machine,SubContracting,Structure; pProdPostGroupFilter: Text[1024])
    var
        lSalesLine: Record "Sales Line";
        lxRec: Record "Sales Line";
        lTotalNeedParam: Record "Sales Document Cost";
        lStructureLine: Record "Sales Line";
        lOverhead: Codeunit "Overhead Calculation";
        lItem: Record Item;
        lxStrRec: Record "Sales Line";
        lLast: Boolean;
        lQty: Decimal;
        lStructureMgt: Codeunit "Structure Management";
    begin
        //répartition de la quantité base au prorata de la quantité base de chaque ligne

        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", pRec."Document Type");
        lSalesLine.SetRange("Document No.", pRec."Document No.");
        if (pRec."Item Type" <> 0) or (pRec.Subcontracting <> pRec.Subcontracting::" ") then
            lSalesLine.SetRange("Line No.", pRec."Structure Line No.");
        if pRec."Line Type" = pRec."line type"::Item then begin
            lSalesLine.SetRange("Vendor No.", pRec."Bill-to Customer No.");
            lSalesLine.SetRange("Purchasing Code", pRec."Item Category Code");
        end;
        lSalesLine.SetRange("Line Type", pRec."Line Type");
        lSalesLine.SetRange(Option, false);
        lSalesLine.SetRange("No.", pRec."No.");
        //lSalesLine.SETFILTER("Structure Line No.",'%1',0);
        //IF lSalesLine.FINDSET THEN
        //  REPEAT
        //    lQty := lSalesLine."Quantity (Base)";
        //  UNTIL lSalesLine.NEXT = 0;

        //lSalesLine.SETFILTER("Structure Line No.",'<>%1',0);
        lQty := 0;

        if lSalesLine.FindSet(true, false) then
            repeat
                lxStrRec.Copy(lSalesLine);
                lLast := not lxStrRec.Find('>');
                lxStrRec.Copy(lSalesLine);
                lQty += lSalesLine.Quantity * lSalesLine."Qty. per Unit of Measure" * (pRec."Quantity (Base)" / pRec.Quantity);
                if lSalesLine."Line Type" <> lSalesLine."line type"::Structure then begin
                    if not lLast then begin
                        lSalesLine."Quantity (Base)" := lSalesLine.Quantity * lSalesLine."Qty. per Unit of Measure" *
                                                        (pRec."Quantity (Base)" / pRec.Quantity);
                        lSalesLine."Outstanding Qty. (Base)" := lSalesLine."Outstanding Quantity" * lSalesLine."Qty. per Unit of Measure" *
                                                             (pRec."Quantity (Base)" / pRec.Quantity);
                    end else begin
                        lSalesLine."Quantity (Base)" := lSalesLine.Quantity * lSalesLine."Qty. per Unit of Measure" *
                                                             (pRec."Quantity (Base)" / pRec.Quantity) +
                                                             (pRec."Quantity (Base)" - lQty);
                        lSalesLine."Outstanding Qty. (Base)" := lSalesLine."Outstanding Quantity" * lSalesLine."Qty. per Unit of Measure" *
                                                             (pRec."Quantity (Base)" - lQty);
                    end;
                    lSalesLine.Validate("Unit Cost (LCY)");
                    lSalesLine.Modify;
                    lOverhead.SalesLine(lSalesLine, true, true);
                    lSalesLine.Modify;
                    if lSalesLine."Structure Line No." <> 0 then
                        if lStructureLine.Get(lSalesLine."Document Type", lSalesLine."Document No.", lSalesLine."Structure Line No.") then begin
                            lxRec := lStructureLine;
                            lStructureMgt.wSumDiffStructureLine(lSalesLine, lxStrRec, lStructureLine);
                            lStructureLine.wUpdateLine(lStructureLine, lxRec, false);
                            //        IF (NaviBat."Number lines before commit" <> 0) THEN
                            //          COMMIT;
                        end;
                end;
            until lSalesLine.Next = 0;

        pRec."Total Cost (LCY)" := pRec."Quantity (Base)" * pRec."Unit Cost (LCY)";
        fRefreshTotal(pRec, pProdPostGroupFilter);
        fChangeCategory(pRec, pLineType);
    end;
}

