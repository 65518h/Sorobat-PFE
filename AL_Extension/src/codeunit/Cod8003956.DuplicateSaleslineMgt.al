Codeunit 8003956 "Duplicate Salesline Mgt"
{
    // //#5814 Ne
    // //DEVIS AC 01/01/08 Copie des lignes table 37 sans recalcul


    trigger OnRun()
    begin
    end;

    var
        FromSalesHeader: Record "Sales Header";
        ToSalesHeader: Record "Sales Header";
        LastPresentationCode: Integer;
        LastLineNo: Integer;
        wNaviBatSetup: Record NavibatSetup;
        wBOQExist: Boolean;
        wBOQmgt: Codeunit "BOQ Management";
        wFromOwnerRef: RecordRef;
        wToOwnerRef: RecordRef;


    procedure Init(pFromSalesHeader: Record "Sales Header"; pToSalesHeader: Record "Sales Header")
    begin
        pFromSalesHeader.TestField("No.");
        pToSalesHeader.TestField("No.");

        FromSalesHeader := pFromSalesHeader;
        ToSalesHeader := pToSalesHeader;
    end;


    procedure "Code"(var pDialog: Dialog)
    var
        lSalesLine: Record "Sales Line";
        lFromSalesLine: Record "Sales Line";
        lFromDescriptionLine: Record "Description Line";
        lFromJobCostAssig: Record "Job Cost Assignment";
        lFromItemChargeAssign: Record "Item Charge Assignment (Sales)";
        lFromDocumentDimension: Record "Gen. Jnl. Dim. Filter";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lMax: Integer;
        lIndex: Integer;
        lSalesLineTmp: Record "Sales Line" temporary;
    begin
        lSalesLine.SetRange("Document Type", ToSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", ToSalesHeader."No.");
        if not lSalesLine.IsEmpty then begin
            lSalesLine.FindLast;
            LastLineNo := ROUND(lSalesLine."Line No.", 10000, '>');
            lSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
            //#5443
            lSalesLine.SetFilter("Line Type", '<>%1', lSalesLine."line type"::Other);
            //#5443//
            lSalesLine.FindLast;
            //#8351 BAT-ABO
            //  EVALUATE(LastPresentationCode,COPYSTR(lSalesLine."Presentation Code",1,3));
            if Evaluate(LastPresentationCode, CopyStr(lSalesLine."Presentation Code", 1, 3)) then;
            //8351 BAT-ABO//
        end else begin
            LastLineNo := 0;
            LastPresentationCode := 0;
        end;

        //COMMIT-LINE
        lSingleInstance.wGetNaviBatSetup(wNaviBatSetup);
        //COMMIT-LINE//

        //*******************************//
        //           SalesLine           //
        //*******************************//
        //#6524
        lFromSalesLine.SetCurrentkey("Order Type", "Document Type", "Document No.", "Presentation Code", "Structure Line No.", "Job No.");
        //#6524//
        lFromSalesLine.SetRange("Document Type", FromSalesHeader."Document Type");
        lFromSalesLine.SetRange("Document No.", FromSalesHeader."No.");
        //#7154
        lSalesLineTmp.DeleteAll;
        //#7154//
        if not lFromSalesLine.IsEmpty then begin
            //#6115
            wFromOwnerRef.GetTable(FromSalesHeader);
            wToOwnerRef.GetTable(ToSalesHeader);
            //#7202
            if (wBOQmgt.IsEmpty()) then begin
                wBOQExist := wBOQmgt.Load(wFromOwnerRef.RecordId);
            end else begin
                wBOQExist := true;
            end;
            //#7202//
            //#6115//
            lFromSalesLine.FindSet(true, true);
            pDialog.Update(1, lFromSalesLine.TableCaption);
            lMax := lFromSalesLine.Count;
            lIndex := 0;
            repeat
                lIndex += 1;
                pDialog.Update(2, ROUND((lIndex / lMax) * 10000, 1));
                //#7154
                if (lFromSalesLine."Line Type" = lFromSalesLine."line type"::Other) and (lFromSalesLine."Quote No." = '')
                   and (lFromSalesLine."Prepayment Line") then begin
                    lSalesLineTmp := lFromSalesLine;
                    lSalesLineTmp.Insert;
                end else
                    //#7154//
                    //#7202
                    CopySalesLine(lFromSalesLine, wBOQmgt);
            until lFromSalesLine.Next = 0;
            wBOQmgt.Save('');
            //#7202//
        end;


        //*******************************//
        //       Description Line        //
        //*******************************//
        lFromDescriptionLine.SetRange("Document Type", FromSalesHeader."Document Type");
        lFromDescriptionLine.SetRange("Document No.", FromSalesHeader."No.");
        lFromDescriptionLine.SetRange("Table ID", 37);
        if not lFromDescriptionLine.IsEmpty then begin
            lFromDescriptionLine.FindSet(true, true);
            pDialog.Update(1, lFromDescriptionLine.TableCaption);
            lMax := lFromDescriptionLine.Count;
            lIndex := 0;
            repeat
                lIndex += 1;
                pDialog.Update(2, ROUND((lIndex / lMax) * 10000, 1));
                //#7154
                if not lSalesLineTmp.Get(lFromDescriptionLine."Document Type",
                                         lFromDescriptionLine."Document No.",
                                         lFromDescriptionLine."Document Line No.") then
                    //#7154//
                    CopyDescriptionLine(lFromDescriptionLine);
            until lFromDescriptionLine.Next = 0;
        end;

        //*******************************//
        //              URL              //
        //*******************************//
        /*
        lFromURL.SETRANGE(TableID,37);
        CASE ToSalesHeader."Document Type" OF
          ToSalesHeader."Document Type"::Quote :
            lFromURL.SETRANGE("Document Type", 0);
          ToSalesHeader."Document Type"::Order :
            lFromURL.SETRANGE("Document Type", 1);
        END;
        lFromURL.SETRANGE("No.",FromSalesHeader."No.");
        IF NOT lFromURL.ISEMPTY THEN BEGIN
          lFromURL.FINDSET(TRUE,TRUE);
          pDialog.UPDATE(1,lFromURL.TABLECAPTION);
          lMax := lFromURL.COUNT;
          lIndex := 0;
          REPEAT
            lIndex += 1;
            pDialog.UPDATE(2,ROUND((lIndex/lMax) * 10000,1));
            CopyURL(lFromURL);
          UNTIL lFromURL.NEXT = 0;
        END;
        */

        //*******************************//
        //    Job Cost Assignment        //
        //*******************************//
        lFromJobCostAssig.SetRange("Document Type", FromSalesHeader."Document Type");
        lFromJobCostAssig.SetRange("Document No.", FromSalesHeader."No.");
        if not lFromJobCostAssig.IsEmpty then begin
            lFromJobCostAssig.FindSet(true, true);
            pDialog.Update(1, lFromJobCostAssig.TableCaption);
            lMax := lFromJobCostAssig.Count;
            lIndex := 0;
            repeat
                lIndex += 1;
                pDialog.Update(2, ROUND((lIndex / lMax) * 10000, 1));
                //#7154
                if not lSalesLineTmp.Get(lFromJobCostAssig."Document Type",
                                         lFromJobCostAssig."Document No.",
                                         lFromJobCostAssig."Applies-to Doc. Line No.") then
                    //#7154//
                    CopyJobCostAssignment(lFromJobCostAssig);
            until lFromJobCostAssig.Next = 0;
        end;

        //*******************************//
        //      Document Dimmension      //
        //*******************************//
        /* GL2024    lFromDocumentDimension.SetRange("Document Type", FromSalesHeader."Document Type");
             lFromDocumentDimension.SetRange("Document No.", FromSalesHeader."No.");
             lFromDocumentDimension.SetRange("Table ID", 37);
             if not lFromDocumentDimension.IsEmpty then begin
                 lFromDocumentDimension.FindSet(true, true);
                 pDialog.Update(1, lFromDocumentDimension.TableCaption);
                 lMax := lFromDocumentDimension.Count;
                 lIndex := 0;
                 repeat
                     lIndex += 1;
                     pDialog.Update(2, ROUND((lIndex / lMax) * 10000, 1));
                     //#7154
                     if not lSalesLineTmp.Get(lFromDocumentDimension."Document Type",
                                              lFromDocumentDimension."Document No.",
                                              lFromDocumentDimension."Line No.") then
                         //#7154//
                         CopyDocDimension(lFromDocumentDimension);
                 until lFromDocumentDimension.Next = 0;
             end;*/

        //*******************************//
        //     Item Charge Assignment    //
        //*******************************//
        lFromItemChargeAssign.SetRange("Document Type", FromSalesHeader."Document Type");
        lFromItemChargeAssign.SetRange("Document No.", FromSalesHeader."No.");
        if not lFromItemChargeAssign.IsEmpty then begin
            lFromItemChargeAssign.FindSet(true, true);
            pDialog.Update(1, lFromItemChargeAssign.TableCaption);
            lMax := lFromItemChargeAssign.Count;
            lIndex := 0;
            repeat
                lIndex += 1;
                pDialog.Update(2, ROUND((lIndex / lMax) * 10000, 1));
                CopyItemChargeAssign(lFromItemChargeAssign);
            until lFromItemChargeAssign.Next = 0;
        end;

    end;


    procedure CopySalesLine(pFromSalesLine: Record "Sales Line"; var pBoqMgt: Codeunit "BOQ Management")
    var
        lToSalesLine: Record "Sales Line";
        lPresentationManagement: Codeunit "Presentation Management";
        lRollBackLog: Record "RollBack Log";
        lJob: Record Job;
        lCopyDocFurther: Codeunit "Copy Document Further";
    begin
        lToSalesLine.Init;
        lToSalesLine.TransferFields(pFromSalesLine);
        lToSalesLine."Document Type" := ToSalesHeader."Document Type";
        lToSalesLine."Document No." := ToSalesHeader."No.";
        lToSalesLine."Line No." += LastLineNo;

        if lToSalesLine."Attached to Line No." <> 0 then
            lToSalesLine."Attached to Line No." += LastLineNo;
        if lToSalesLine."Structure Line No." <> 0 then
            lToSalesLine."Structure Line No." += LastLineNo;

        lPresentationManagement.OnCopyRecord(lToSalesLine, pFromSalesLine, LastPresentationCode);
        lToSalesLine."Sell-to Customer No." := ToSalesHeader."Sell-to Customer No.";
        lToSalesLine."Bill-to Customer No." := ToSalesHeader."Bill-to Customer No.";
        lToSalesLine."Order Type" := ToSalesHeader."Order Type";
        lToSalesLine."Currency Code" := ToSalesHeader."Currency Code";
        lToSalesLine."Job No." := ToSalesHeader."Job No.";
        //#5275
        if lToSalesLine."Job No." = '' then
            lToSalesLine."Job Task No." := ''
        else begin
            lJob.Get(lToSalesLine."Job No.");
            lToSalesLine."Job Task No." := lJob.gGetDefaultJobTask();
        end;
        //#5275//
        //#8531
        lToSalesLine."Rider Rank" := 0;
        //#8531//
        //#9213
        lToSalesLine."Order Date" := 0D;
        //#9213//
        lToSalesLine."Location Code" := ToSalesHeader."Location Code";
        lToSalesLine."Customer Price Group" := ToSalesHeader."Customer Price Group";
        lToSalesLine."Customer Disc. Group" := ToSalesHeader."Customer Disc. Group";
        lToSalesLine."Allow Line Disc." := ToSalesHeader."Allow Line Disc.";
        lToSalesLine."Transaction Type" := ToSalesHeader."Transaction Type";
        lToSalesLine."Transport Method" := ToSalesHeader."Transport Method";
        if (lToSalesLine."Gen. Bus. Posting Group" = ToSalesHeader."Gen. Bus. Posting Group") or
           (lToSalesLine."VAT Bus. Posting Group" = ToSalesHeader."VAT Bus. Posting Group") then begin
            lToSalesLine."VAT Bus. Posting Group" := ToSalesHeader."VAT Bus. Posting Group";
            lToSalesLine.Validate("Gen. Bus. Posting Group", ToSalesHeader."Gen. Bus. Posting Group");
        end;
        lToSalesLine."Exit Point" := ToSalesHeader."Exit Point";
        lToSalesLine.Area := ToSalesHeader.Area;
        lToSalesLine."Transaction Specification" := ToSalesHeader."Transaction Specification";
        lToSalesLine."Tax Area Code" := ToSalesHeader."Tax Area Code";
        lToSalesLine."Tax Liable" := ToSalesHeader."Tax Liable";
        lToSalesLine."Responsibility Center" := ToSalesHeader."Responsibility Center";
        lToSalesLine."Shipping Agent Code" := ToSalesHeader."Shipping Agent Code";
        lToSalesLine."Shipping Agent Service Code" := ToSalesHeader."Shipping Agent Service Code";
        lToSalesLine."Outbound Whse. Handling Time" := ToSalesHeader."Outbound Whse. Handling Time";
        lToSalesLine."Shipping Time" := ToSalesHeader."Shipping Time";
        lToSalesLine."Promised Delivery Date" := ToSalesHeader."Promised Delivery Date";
        lToSalesLine."Requested Delivery Date" := ToSalesHeader."Requested Delivery Date";
        //#6446  Delete
        //lToSalesLine."Shortcut Dimension 1 Code" := ToSalesHeader."Shortcut Dimension 1 Code";
        //lToSalesLine."Shortcut Dimension 2 Code" := ToSalesHeader."Shortcut Dimension 2 Code";
        //#6446//
        lToSalesLine."Shipment Date" := 0D;

        lToSalesLine."Imported Line" := false;
        lToSalesLine."Completely Shipped" := false;
        lToSalesLine."Purchasing Order No." := '';
        lToSalesLine."Purchasing Order Line No." := 0;
        lToSalesLine."Special Order Purchase No." := '';
        lToSalesLine."Special Order Purch. Line No." := 0;
        //#5814
        //lToSalesLine."Special Order" := FALSE;
        //#5814//
        lToSalesLine."Supply Order No." := '';
        lToSalesLine."Supply Order Line No." := 0;
        lToSalesLine."Quantity Shipped" := 0;
        lToSalesLine."Qty. Shipped (Base)" := 0;
        lToSalesLine."Return Qty. Received" := 0;
        lToSalesLine."Return Qty. Received (Base)" := 0;
        lToSalesLine."Quantity Invoiced" := 0;
        lToSalesLine."Qty. Invoiced (Base)" := 0;
        lToSalesLine."Reserved Quantity" := 0;
        lToSalesLine."Reserved Qty. (Base)" := 0;
        lToSalesLine."Qty. to Ship" := 0;
        lToSalesLine."Qty. to Ship (Base)" := 0;
        lToSalesLine."Return Qty. to Receive" := 0;
        lToSalesLine."Return Qty. to Receive (Base)" := 0;
        lToSalesLine."Qty. to Invoice" := 0;
        lToSalesLine."Qty. to Invoice (Base)" := 0;
        lToSalesLine."Qty. Shipped Not Invoiced" := 0;
        lToSalesLine."Return Qty. Rcd. Not Invd." := 0;
        lToSalesLine."Shipped Not Invoiced" := 0;
        lToSalesLine."Return Rcd. Not Invd." := 0;
        lToSalesLine."Qty. Shipped Not Invd. (Base)" := 0;
        lToSalesLine."Ret. Qty. Rcd. Not Invd.(Base)" := 0;
        lToSalesLine."Shipped Not Invoiced (LCY)" := 0;
        lToSalesLine."Return Rcd. Not Invd. (LCY)" := 0;
        lToSalesLine."Appl.-from Item Entry" := 0;
        lToSalesLine."Appl.-to Item Entry" := 0;
        lToSalesLine."Purchase Order No." := '';
        lToSalesLine."Purch. Order Line No." := 0;
        lToSalesLine."Special Order Purchase No." := '';
        lToSalesLine."Special Order Purch. Line No." := 0;

        //#5597
        lToSalesLine."Prepayment %" := 0;
        lToSalesLine."Prepayment VAT %" := 0;
        lToSalesLine."Prepmt. VAT Calc. Type" := 0;
        lToSalesLine."Prepayment VAT Identifier" := '';
        lToSalesLine."Prepayment VAT %" := 0;
        lToSalesLine."Prepayment Tax Group Code" := '';
        lToSalesLine."Prepmt. Line Amount" := 0;
        lToSalesLine."Prepmt. Amt. Incl. VAT" := 0;
        lToSalesLine."Prepmt. Amt. Inv." := 0;
        lToSalesLine."Prepayment Amount" := 0;
        lToSalesLine."Prepmt. VAT Base Amt." := 0;
        lToSalesLine."Prepmt Amt to Deduct" := 0;
        lToSalesLine."Prepmt Amt Deducted" := 0;
        lToSalesLine."Prepmt. Amount Inv. Incl. VAT" := 0;
        //#5597//
        //#8351 BATABO
        lToSalesLine."Subscription Posting Date" := 0D;
        //#8351 BATABO//
        //#6229
        lToSalesLine."Quote No." := '';
        if (lToSalesLine."Line Type" = lToSalesLine."line type"::Other) then
            lToSalesLine."Prepayment Line" := (lToSalesLine."Document Type" = lToSalesLine."document type"::Order) and
                                              (ToSalesHeader."Invoicing Method" = ToSalesHeader."invoicing method"::Completion) and
                                              pFromSalesLine."Prepayment Line";
        //#6229//
        lToSalesLine.InitOutstanding;
        if lToSalesLine."Document Type" in
             [lToSalesLine."document type"::"Return Order", lToSalesLine."document type"::"Credit Memo"]
          then
            lToSalesLine.InitQtyToReceive
        else
            lToSalesLine.InitQtyToShip;
        lToSalesLine.Insert;

        //#6115
        //#7202
        lCopyDocFurther.wCopyBillOfQtyToLine(ToSalesHeader, lToSalesLine, FromSalesHeader, pFromSalesLine, wBOQExist, pBoqMgt);
        //#7202//
        //#6115//

        //COMMIT-LINE
        if (lToSalesLine."Structure Line No." = 0) and
           ((lToSalesLine."Line Type" <> lToSalesLine."line type"::" ") or
           ((lToSalesLine."Line Type" = lToSalesLine."line type"::" ") and
            (lToSalesLine."No." <> ''))) then
            lRollBackLog.CommitLine(lToSalesLine, wNaviBatSetup."Line Committed");
        //COMMIT-LINE//
    end;


    procedure CopyDescriptionLine(pFromDescriptionLine: Record "Description Line")
    var
        lToDescriptionLine: Record "Description Line";
    begin
        lToDescriptionLine.Init;
        lToDescriptionLine.TransferFields(pFromDescriptionLine);
        lToDescriptionLine."Document Type" := ToSalesHeader."Document Type";
        lToDescriptionLine."Document No." := ToSalesHeader."No.";
        if (lToDescriptionLine."Line No." <> 0) and (LastLineNo <> 0) then
            lToDescriptionLine."Line No." += LastLineNo;
        lToDescriptionLine.Insert;
    end;


    procedure CopyJobCostAssignment(pFromJobCostAssignment: Record "Job Cost Assignment")
    var
        lToJobCostAssignment: Record "Job Cost Assignment";
    begin
        lToJobCostAssignment.Init;
        lToJobCostAssignment.TransferFields(pFromJobCostAssignment);
        lToJobCostAssignment."Document Type" := ToSalesHeader."Document Type";
        lToJobCostAssignment."Document No." := ToSalesHeader."No.";
        if (lToJobCostAssignment."Document Line No." <> 0) and (LastLineNo <> 0) then
            lToJobCostAssignment."Document Line No." += LastLineNo;
        lToJobCostAssignment.Insert;
    end;


    /* GL2024
     procedure CopyDocDimension(var pFromDocumentDimension: Record 357)
     var
         lToDocumentDimension: Record 357;
     begin
         lToDocumentDimension.Init;
         lToDocumentDimension.TransferFields(pFromDocumentDimension);
         lToDocumentDimension."Document Type" := ToSalesHeader."Document Type";
         lToDocumentDimension."Document No." := ToSalesHeader."No.";
         if (lToDocumentDimension."Line No." <> 0) and (LastLineNo <> 0) then
             lToDocumentDimension."Line No." += LastLineNo;
         lToDocumentDimension.Insert;
     end;*/


    procedure CopyItemChargeAssign(pFromItemChargeAssign: Record "Item Charge Assignment (Sales)")
    var
        lToItemChargeAssign: Record "Item Charge Assignment (Sales)";
    begin
        lToItemChargeAssign.Init;
        lToItemChargeAssign.TransferFields(pFromItemChargeAssign);
        lToItemChargeAssign."Document Type" := ToSalesHeader."Document Type";
        lToItemChargeAssign."Document No." := ToSalesHeader."No.";
        lToItemChargeAssign."Applies-to Doc. Type" := ToSalesHeader."Document Type";
        lToItemChargeAssign."Applies-to Doc. No." := ToSalesHeader."No.";
        if (lToItemChargeAssign."Document Line No." <> 0) and (LastLineNo <> 0) then begin
            lToItemChargeAssign."Document Line No." += LastLineNo;
            lToItemChargeAssign."Applies-to Doc. Line No." += LastLineNo;
        end;
        lToItemChargeAssign.Insert;
    end;


    procedure SetBoqManagement(pBoqManagement: Codeunit "BOQ Management")
    begin
        //#7202
        wBOQmgt := pBoqManagement;
        //#7202//
    end;
}

