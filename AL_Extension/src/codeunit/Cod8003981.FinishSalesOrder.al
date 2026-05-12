Codeunit 8003981 "Finish Sales Order"
{
    // //PROJET_FACT CLA 08/11/04 Solder la commande + affaire

    TableNo = "Sales Header";

    trigger OnRun()
    begin
        SalesHeader := Rec;
        Code;
        Rec := SalesHeader;
    end;

    var
        SalesHeader: Record "Sales Header";
        EverythingInvoiced: Boolean;


    procedure "Code"()
    var
        lSalesOrderHeader: Record "Sales Header";
        lSalesOrderLine: Record "Sales Line";
        lSalesInvLine: Record "Sales Line";
        lCdePrinc: Code[20];
        lOK: Boolean;
        lJob: Record Job;
    begin
        with SalesHeader do begin
            lCdePrinc := '';
            if "Document Type" = "document type"::Order then begin
                if "Order Type" = "order type"::"Supply Order" then begin
                    if CheckProduction(SalesHeader) then begin
                        SalesHeader.Finished := true;
                        SalesHeader.Modify;
                    end else begin
                        if SalesHeader.Finished then begin
                            SalesHeader.Finished := false;
                            SalesHeader.Modify;
                        end;
                    end;
                    exit;
                end else
                    case SalesHeader."Invoicing Method" of
                        SalesHeader."invoicing method"::Direct:
                            begin
                                if not EverythingInvoiced then begin
                                    if SalesHeader.Finished then begin
                                        SalesHeader.Finished := false;
                                        SalesHeader.Modify;
                                    end;
                                    exit;
                                end;
                                SalesHeader.Finished := true;
                                SalesHeader.Modify;
                                exit;
                            end;
                        SalesHeader."invoicing method"::Scheduler,
                        SalesHeader."invoicing method"::Completion:
                            begin
                                if not CheckProduction(SalesHeader) then begin
                                    if SalesHeader.Finished then begin
                                        SalesHeader.Finished := false;
                                        SalesHeader.Modify;
                                    end;
                                    exit;
                                end;
                                if not CheckCompletion(SalesHeader) then begin
                                    if SalesHeader.Finished then begin
                                        SalesHeader.Finished := false;
                                        SalesHeader.Modify;
                                    end;
                                    exit;
                                end;
                                SalesHeader.Finished := true;
                                SalesHeader.Modify;
                                exit;
                            end;
                    end;
            end else begin
                if SalesHeader."Scheduler Origin" or (SalesHeader."No. Prepayment Invoiced" <> 0) then begin
                    //#4029
                    /*
                        lSalesInvLine.SETRANGE(lSalesInvLine."Document Type",SalesHeader."Document Type");
                        lSalesInvLine.SETRANGE(lSalesInvLine."Document No.",SalesHeader."No.");
                        lSalesInvLine.SETFILTER(lSalesInvLine."Invoice No.",'<>''''');
                    */
                    lSalesInvLine.SetRange("Order No.", SalesHeader."No.");
                    //#4029//
                    if lSalesInvLine.IsEmpty then
                        exit;
                end else
                    exit;
                if SalesHeader."Scheduler Origin" then begin
                    lSalesInvLine.SetFilter("Scheduler Line No.", '<>0');
                    lSalesInvLine.FindFirst;
                    lSalesOrderHeader.Get(lSalesOrderHeader."document type"::Order, lSalesInvLine."Order No.");
                    if not CheckProduction(lSalesOrderHeader) then begin
                        if lSalesOrderHeader.Finished then begin
                            lSalesOrderHeader.Finished := false;
                            lSalesOrderHeader.Modify;
                        end;
                        exit;
                    end;
                    if not CheckCompletion(lSalesOrderHeader) then begin
                        if lSalesOrderHeader.Finished then begin
                            lSalesOrderHeader.Finished := false;
                            lSalesOrderHeader.Modify;
                        end;
                        exit;
                    end;
                    lSalesOrderHeader.Finished := true;
                    lSalesOrderHeader.Modify;
                    exit;
                end;
            end;
        end;

    end;

    local procedure CheckProduction(pSalesOrderHeader: Record "Sales Header"): Boolean
    var
        lSalesLine: Record "Sales Line";
    begin
        pSalesOrderHeader.CalcFields("Completely Shipped");
        exit(pSalesOrderHeader."Completely Shipped");
    end;

    local procedure CheckCompletion(pSalesOrderHeader: Record "Sales Header"): Boolean
    var
        lInvScheduler: Record "Invoice Scheduler";
        lSalesLine: Record "Sales Line";
        lNotInvoiced: Boolean;
    begin
        case pSalesOrderHeader."Invoicing Method" of
            pSalesOrderHeader."invoicing method"::Scheduler:
                begin
                    pSalesOrderHeader.CalcFields("Amount Excl. VAT (LCY)");
                    lInvScheduler.SetRange("Sales Header Doc. Type", pSalesOrderHeader."Document Type");
                    lInvScheduler.SetRange("Sales Header Doc. No.", pSalesOrderHeader."No.");
                    lInvScheduler.CalcSums("Amount Emitted (LCY)");
                    exit(pSalesOrderHeader."Amount Excl. VAT (LCY)" = lInvScheduler."Amount Emitted (LCY)");
                end;
            pSalesOrderHeader."invoicing method"::Completion:
                begin
                    //         pSalesOrderHeader.CALCFIELDS("Completely Invoiced");
                    //        EXIT(pSalesOrderHeader."Completely Invoiced");
                    //#5357
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.");
                    lSalesLine.SetRange("Document Type", pSalesOrderHeader."Document Type");
                    lSalesLine.SetRange("Document No.", pSalesOrderHeader."No.");
                    lSalesLine.SetRange("Structure Line No.", 0);
                    lSalesLine.SetFilter("Line Type", '>1');
                    lSalesLine.SetRange("Assignment Basis", 0);
                    lSalesLine.SetRange(Option, false);
                    lNotInvoiced := false;
                    if lSalesLine.FindSet then
                        repeat
                            //#8888
                            if ((lSalesLine."Line Type" <> lSalesLine."line type"::Other) or
                               (lSalesLine."Quote No." = '')) then
                                lNotInvoiced := not lSalesLine."Completely Invoiced";
                        //#8888//
                        until (lSalesLine.Next = 0) or lNotInvoiced;
                    exit(not lNotInvoiced);
                    //#5357//
                end;
        end;
    end;


    procedure InitEverythingInvoiced(pEverythingInvoiced: Boolean)
    begin
        EverythingInvoiced := pEverythingInvoiced;
    end;


    procedure FinishedJob(var pJob: Record Job; pByPosting: Boolean)
    var
        lNavibatSetup: Record NavibatSetup;
    begin
        //3482
        if not pByPosting then
            lNavibatSetup."Close Job with Sales Doc." := true
        else
            //3482//
            lNavibatSetup.Get;
        if lNavibatSetup."Close Job with Sales Doc." then begin
            if CheckFinishedJob(pJob."No.") then begin
                pJob.Finished := true;
                pJob.Modify;
            end else begin
                if pJob.Finished then begin
                    pJob.Finished := false;
                    pJob.Modify;
                end;
            end;
        end;
    end;


    procedure CheckFinishedJob(pJobCode: Code[20]) retour: Boolean
    var
        lSalesLine: Record "Sales Line";
        lSalesHeader: Record "Sales Header";
    begin
        //#8987
        /*
        WITH lSalesLine DO BEGIN
          SETCURRENTKEY("Order Type","Document Type","Document No.","Presentation Code","Structure Line No.","Job No.");
          SETRANGE("Order Type",lSalesLine."Order Type"::" ");
          SETRANGE("Job No.",pJobCode);
        //#6554
        //  IF ISEMPTY THEN
        //    EXIT(FALSE);
          IF ISEMPTY THEN
            EXIT(TRUE);
        //#6554//
          SETRANGE("Structure Line No.",0);
          SETFILTER("Line Type",'>=2');
          SETRANGE("Completely Shipped",FALSE);
          IF NOT ISEMPTY THEN
            EXIT(FALSE);
          SETRANGE("Completely Shipped");
        //  SETRANGE("Completely Invoiced",FALSE);
          IF NOT ISEMPTY THEN
            EXIT(FALSE);
          EXIT(TRUE);
        END;
        */
        retour := true;
        lSalesHeader.SetRange("Order Type", lSalesHeader."order type"::" ");
        lSalesHeader.SetRange("Job No.", pJobCode);
        if (not lSalesHeader.IsEmpty()) then begin
            lSalesHeader.FindSet(false, false);
            repeat
                retour := retour and (lSalesHeader.Finished);
            until (lSalesHeader.Next() = 0);
        end;
        //#8987//

    end;
}

