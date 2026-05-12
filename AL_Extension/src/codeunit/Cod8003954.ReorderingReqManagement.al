Codeunit 8003954 "Reordering Req. Management"
{
    // //CDE_INTERNE GESWAY 11/08/03 Fonctions liées à la commande interne


    trigger OnRun()
    begin
    end;

    var
        Text8003901: label 'This line is not linked with a requisition order.\Do you want to display the requisition order associed to this job?';
        Text8003902: label 'This line is not linked with a transfer.';
        Text8003903: label 'Only one line selected. Do you want to continue?';


    procedure FindLinesOrder(pRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
    begin
        with pRec do begin
            lSalesHeader.SetRange("Document Type", "document type"::Order);
            lSalesHeader.SetRange("Order Type", lSalesHeader."order type"::"Supply Order");
            lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
            lSalesLine.SetRange("Document Type", "Document Type");
            lSalesLine.SetRange("Document No.", "Document No.");
            lSalesLine.SetRange("Structure Line No.", "Line No.");
            lSalesLine.SetRange(Type, Type::Item);
            lSalesLine.SetFilter("Supply Order No.", '<>%1', '');

            if "Supply Order No." <> '' then begin
                lSalesHeader.SetRange("No.", "Supply Order No.");
            end else
                if lSalesLine.Find('-') then begin
                    repeat
                        lSalesHeader.Get("document type"::Order, lSalesLine."Supply Order No.");
                        lSalesHeader.Mark(true);
                    until lSalesLine.Next = 0;
                    lSalesHeader.MarkedOnly(true);
                end
                else
                    if Confirm(Text8003901, true, "Job No.") then
                        lSalesHeader.SetRange("Job No.", "Job No.")
                    else
                        exit;
            if not ISSERVICETIER then begin
                if lSalesHeader.Count <> 1 then
                    /*  //GL2024 NAVIBAT   Page.RunModal(Page::"Reordering Requisition", lSalesHeader)
                   else*/
                    Page.RunModal(Page::"Sales List", lSalesHeader);
            end else begin
                if lSalesHeader.Count <> 1 then
                    /*   //GL2024 NAVIBAT  Page.RunModal(Page::"Reordering Requisition", lSalesHeader)
                   else*/
                    Page.RunModal(Page::"Sales List", lSalesHeader);
            end;
        end;
    end;


    procedure FindTransfer(pRec: Record "Sales Line")
    var
        lSalesLine: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
        lTransferOrderLink: Record "Transfer Order Link";
    begin
        with pRec do begin
            lTransferOrderLink.SetRange("Document Type", "Document Type");
            lTransferOrderLink.SetRange("Document No.", "Document No.");
            lTransferOrderLink.SetRange("Structure Line No.", "Structure Line No.");
            lTransferOrderLink.SetRange("Line No.", "Line No.");
            if lTransferOrderLink.Find('-') then begin
                repeat
                    lSalesHeader.Get(lTransferOrderLink."Transfer Document Type", lTransferOrderLink."Transfer Document No.");
                    lSalesHeader.Mark(true);
                until lTransferOrderLink.Next = 0;
                lSalesHeader.MarkedOnly(true);
            end
            else begin
                Message(Text8003902, true, "Job No.");
                exit;
            end;
            if lSalesHeader.Count <> 1 then
                /*   //GL2024 NAVIBAT   Page.RunModal(Page::"Internal Order", lSalesHeader)
                else*/
                Page.RunModal(Page::"Sales List", lSalesHeader);
        end;
    end;


    procedure SupplyOrder(pActualRec: Record "Sales Line"; var pRec: Record "Sales Line")
    var
        //GL2024 NAVIBAT   lGenerateSupplyOrder: Report 8003958;
        lSalesHeader: Record "Sales Header";
        lSalesHeaderInternal: Record "Sales Header";
        lJobNo: Code[20];
        lSalesLineTmp: Record "Sales Line" temporary;
        lSalesLine3: Record "Sales Line";
        lFilterCount: Integer;
        lSalesList: Page "Sales List";
        lSalesLine: Record "Sales Line";
    begin
        if lSalesHeader.Get(pActualRec."Document Type", pActualRec."Document No.") then;
        if pRec.Count = 1 then begin
            if not Confirm(Text8003903, true) then
                exit;
            if fGenerateSupplyOrder(lSalesHeader, pRec, pActualRec."Job No.", lSalesHeaderInternal) then
                lFilterCount := 1;
        end
        else begin
            lSalesLine3.CopyFilters(pRec);
            /*
              //  lSalesLineTmp.DELETEALL;
              pRec.FIND('-');
              REPEAT
            //    pRec.MARK(TRUE);
                lSalesLine3 := pRec;
                lSalesLine3.MARK(TRUE);
            //    lSalesLineTmp := pRec;
            //    lSalesLineTmp.INSERT;
              UNTIL pRec.NEXT = 0;
            //  pRec.MARKEDONLY(TRUE);
              lSalesLine3.MARKEDONLY(TRUE);
            */
            lSalesLine3.SetCurrentkey("Job No.", "Job Task No.", "Document Type", "Gen. Prod. Posting Group", Disable, Option, "Line Type",
                "Structure Line No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            //#//

            lSalesLine3.FindSet(true, true);
            Message('%1', lSalesLine3.Count);
            lJobNo := '';
            repeat
                //    IF pRec.GET(lSalesHeader."Document Type",lSalesHeader."No.",lSalesLine3."Line No.") THEN BEGIN
                if (lJobNo <> lSalesLine3."Job No.") then begin
                    /*
                            lSalesLineTmp.RESET;
                            lSalesLineTmp.COPYFILTERS(pRec);
                            lSalesLineTmp.SETRANGE("Job No.",lSalesLine3."Job No.");
                            lSalesLine.RESET;
                            lSalesLineTmp.FINDSET(FALSE,FALSE);
                            REPEAT
                              lSalesLine.GET(lSalesLineTmp."Document Type",lSalesLineTmp."Document No.",lSalesLineTmp."Line No.");
                              lSalesLine.MARK(TRUE);
                            UNTIL lSalesLineTmp.NEXT = 0;
                            lSalesLine.MARKEDONLY(TRUE);
                    */
                    pRec.SetRange("Job No.", lSalesLine3."Job No.");
                    if fGenerateSupplyOrder(lSalesHeader, pRec, lSalesLine3."Job No.", lSalesHeaderInternal) then
                        lFilterCount += 1;
                    pRec.SetRange("Job No.");
                end;
                //    END;
                lJobNo := lSalesLine3."Job No.";
            until lSalesLine3.Next = 0;
        end;

        if lFilterCount > 1 then begin
            lSalesHeaderInternal.MarkedOnly(true);
            lSalesList.SetTableview(lSalesHeaderInternal);
            lSalesList.RunModal;
        end;
        /*  //GL2024 NAVIBAT  else
              Page.RunModal(Page::"Reordering Requisition", lSalesHeaderInternal);*/

        //#6630//

    end;


    procedure fGenerateSupplyOrder(pSalesHeader: Record "Sales Header"; var pRec: Record "Sales Line"; pJobNo: Code[20]; var pSalesInternalHeader: Record "Sales Header"): Boolean
    var
    //GL2024 NAVIBAT   lGenerateSupplyOrder: Report 8003958;
    begin
        /* //GL2024 NAVIBAT   lGenerateSupplyOrder.PassJob(pJobNo, pSalesHeader."Responsibility Center");
          lGenerateSupplyOrder.PassDest(pSalesHeader."Ship-to Code");
          lGenerateSupplyOrder.InitRequest(pSalesHeader);
          lGenerateSupplyOrder.SetTableview(pRec);
          lGenerateSupplyOrder.RunModal;
          lGenerateSupplyOrder.RecupCdeInterne(pRec);*/
        if pSalesInternalHeader.Get(pRec."Document Type", pRec."Document No.") then begin
            pSalesInternalHeader.Mark(true);
            exit(true);
        end;
        exit(false);
    end;
}

