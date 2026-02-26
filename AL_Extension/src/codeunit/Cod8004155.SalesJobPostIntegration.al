Codeunit 8004155 "Sales Job-Post Integration"
{
    //     PostSalesJobEntry : validation de l'écriture affaire de type vente
    //     PostJobItemJnlLine : validation de l'écriture affaire de type activité pour les lignes de type article
    //     PostTransferOrder : validation de l'écriture affaire de type activité dans le cadre la commande interne
    //     GetPostProdCompletion : détermine si l'avancement en production doit être généré
    //     GetScheduleInvExist : Vérification ligne échéancier existe
    //     SetFinishOrder : gére l'achèvement de la commande ainsi que l'affaire.
    //     SetInitOutStanding : gère la mise à jour des quantité expédié, facturé et retourné sur la table temporaire
    //                          gère également la mise à jour de la commande ouverte liée si il y a lieu


    trigger OnRun()
    begin
    end;


    procedure PostJobEntry(pSalesHeader: Record "Sales Header"; var pSalesLine: Record "Sales Line"; var pSalesInvHeader: Record "Sales Invoice Header"; var pSalesShptHeader: Record "Sales Shipment Header"; var pSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var pSalesLineACY: Record "Sales Line"; pCurrency: Record Currency; var pTempDocDim: Record "Gen. Jnl. Dim. Filter"; var pSrcCode: Code[20]; var pGenJnlLineExtDocNo: Code[20])
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobTransferLine: Codeunit "Job Transfer Line2";
        //GL2024   lTempJnlLineDim: Record 356;
        lDimMgt: Codeunit DimensionManagement;
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
    begin
        PostSalesJobEntry(pSalesHeader, pSalesLine, pSalesInvHeader, pSalesCrMemoHeader,
                          pSalesLineACY, pCurrency, pTempDocDim, pSrcCode);

        PostJobItemJnlLine(pSalesHeader, pSalesLine, pSalesInvHeader, pSalesShptHeader, pSalesCrMemoHeader, ReturnRcptHeader,
                          pSalesLineACY, pCurrency, pTempDocDim, pSrcCode, pGenJnlLineExtDocNo);

        PostTransferOrder(pSalesHeader, pSalesLine, pSalesShptHeader, pSalesLineACY, pCurrency, pTempDocDim, pSrcCode, pGenJnlLineExtDocNo);
    end;


    procedure PostSalesJobEntry(pSalesHeader: Record "Sales Header"; var pSalesLine: Record "Sales Line"; var pSalesInvHeader: Record "Sales Invoice Header"; var pSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var pSalesLineACY: Record "Sales Line"; pCurrency: Record Currency; var pTempDocDim: Record "Gen. Jnl. Dim. Filter"; var pSrcCode: Code[20])
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobTransferLine: Codeunit "Job Transfer Line2";
        //GL2024  lTempJnlLineDim: Record 356;
        lDimMgt: Codeunit DimensionManagement;
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
    begin
        if (pSalesLine."Job No." <> '') and (pSalesLine."Qty. to Invoice" <> 0) and
           (pSalesLine.Type <> pSalesLine.Type::"Fixed Asset") and (pSalesLine."Order Type" = pSalesLine."order type"::" ")
        then begin
            lJobTransferLine.fFromSalesLineToJnlLine(
              pSalesHeader, pSalesInvHeader, pSalesCrMemoHeader, pSalesLine, pSalesLineACY, pCurrency, pSrcCode, lJobJnlLine);
            /*  GL2024   lTempJnlLineDim.DeleteAll;
               pTempDocDim.Reset;
                 pTempDocDim.SetRange("Table ID", Database::"Sales Line");
                   pTempDocDim.SetRange("Line No.", pSalesLine."Line No.");
               lDimMgt.CopyDocDimToJnlLineDim(pTempDocDim, lTempJnlLineDim);
               Clear(lJobJnlPostLine);
               lJobJnlPostLine.RunWithCheck(lJobJnlLine, lTempJnlLineDim);*/
        end;
    end;


    procedure PostJobItemJnlLine(pSalesHeader: Record "Sales Header"; var pSalesLine: Record "Sales Line"; var pSalesInvHeader: Record "Sales Invoice Header"; var pSalesShptHeader: Record "Sales Shipment Header"; var pSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var pReturnRcptHeader: Record "Return Receipt Header"; var pSalesLineACY: Record "Sales Line"; pCurrency: Record Currency; var pTempDocDim: Record "Gen. Jnl. Dim. Filter"; var pSrcCode: Code[20]; var pGenJnlLineExtDocNo: Code[20])
    var
        lJobJnlLine: Record "Job Journal Line";
        lJob: Record Job;
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
        //GL2024 lTempJnlLineDim: Record 356 temporary;
        ltBalItem: label 'Item Balanced total / %1';
        lCession: Codeunit "Create Bal. Job Journal Line";
        lJobTransferLine: Codeunit "Job Transfer Line2";
        lDimMgt: Codeunit DimensionManagement;
    begin
        //CDE_INTERNE
        with pSalesHeader do
            if (pSalesLine."Job No." <> '') and ((pSalesLine."Qty. to Ship" <> 0) or (pSalesLine."Return Qty. to Receive" <> 0))
                and not pSalesLine."Drop Shipment" and
               //#8877
               (pSalesLine.Type = pSalesLine.Type::Item) and
               (pSalesLine."Structure Line No." = 0) then begin
                lJobTransferLine.fFromSalesLineToJnlLine(
                  pSalesHeader, pSalesInvHeader, pSalesCrMemoHeader, pSalesLine, pSalesLineACY, pCurrency, pSrcCode, lJobJnlLine);
                //#8877//
                lJobJnlLine."Entry Type" := lJobJnlLine."entry type"::Usage;
                if pSalesLine."Document Type" in [pSalesLine."document type"::Order, pSalesLine."document type"::Invoice] then begin
                    lJobJnlLine."Document No." := pSalesShptHeader."No.";
                    lJobJnlLine."External Document No." := pGenJnlLineExtDocNo;
                    lJobJnlLine.Validate(Quantity, -pSalesLine."Qty. to Ship");
                    lJobJnlLine."Quantity (Base)" := -pSalesLine."Qty. to Ship (Base)";
                end else begin
                    lJobJnlLine."Document No." := pReturnRcptHeader."No.";
                    lJobJnlLine."External Document No." := pGenJnlLineExtDocNo;
                    lJobJnlLine.Validate(Quantity, -pSalesLine."Return Qty. to Receive");
                    lJobJnlLine."Quantity (Base)" := -pSalesLine."Return Qty. to Receive (Base)";
                end;
                //#8877  lJobJnlLine."Bal. Job No." := Cession.SearchBalJobNoFromType(lJobJnlLine);

                /* GL2024    lTempJnlLineDim.DeleteAll;
                   pTempDocDim.Reset;
                   pTempDocDim.SetRange("Table ID", Database::"Sales Line");
                    pTempDocDim.SetRange("Line No.", pSalesLine."Line No.");
                   lDimMgt.CopyDocDimToJnlLineDim(pTempDocDim, lTempJnlLineDim);
                   Clear(lJobJnlPostLine);
                   lJobJnlPostLine.RunWithCheck(lJobJnlLine, lTempJnlLineDim);*/
                //#8877
                /*DELETE
                //CONTRE_PARTIE (Ecriture cession)
                  lJobJnlLine."Job No." := lJobJnlLine."Bal. Job No.";
                  lJobJnlLine.Description := COPYSTR(STRSUBSTNO(ltBalItem,SalesLine."Job No."),1,MAXSTRLEN(lJobJnlLine.Description));
                  lJobJnlLine."Bal. Job No." := '';
                //#5055  lJobJnlLine."Job Task No." := '';
                  lJob.GET(lJobJnlLine."Job No.");
                  lJobJnlLine."Job Task No." := lJob.gGetDefaultJobTask;
                  lJobJnlLine.Quantity := 0;
                  lJobJnlLine."Total Cost" := - lJobJnlLine."Total Cost";
                //#5823
                  lJobJnlLine."Total Cost (LCY)" := - lJobJnlLine."Total Cost (LCY)";
                //#5823//
                  lJobJnlLine."Quantity (Base)" := -lJobJnlLine."Quantity (Base)";
                  lJobJnlLine."Total Price" := -lJobJnlLine."Total Price";
                  lJobJnlLine."Bal. Created Entry" := TRUE;
                  TempJnlLineDim.DELETEALL;
                  TempDocDim.RESET;
                  TempDocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
                  TempDocDim.SETRANGE("Line No.",SalesLine."Line No.");
                  DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
                  lJobJnlPostLine.RunWithCheck(lJobJnlLine,TempJnlLineDim);
                DELETE*/
                //#8877
            end;
        //CDE_INTERNE//

    end;


    procedure PostTransferOrder(pSalesHeader: Record "Sales Header"; var pSalesLine: Record "Sales Line"; var pSalesShptHeader: Record "Sales Shipment Header"; var pSalesLineACY: Record "Sales Line"; pCurrency: Record Currency; var pTempDocDim: Record "Gen. Jnl. Dim. Filter"; var pSrcCode: Code[20]; var pGenJnlLineExtDocNo: Code[20])
    var
        lJobJnlLine: Record "Job Journal Line";
        lJobJnlPostLine: Codeunit "Job Jnl.-Post Line2";
        //GL2024    lTempJnlLineDim: Record 356 temporary;
        lGenPostSetup: Record "General Posting Setup";
        lGLAccount: Record "G/L Account";
        lJobPostingGroup: Record "Job Posting Group";
        lJob: Record Job;
        lCurrency: Record Currency;
        lDimMgt: Codeunit DimensionManagement;
    begin
        //CESSION
        if (pSalesHeader."Transfer Job No." <> '') and (pSalesLine."Job No." <> '') and (pSalesLine."Qty. to Ship" <> 0) and
           (pSalesHeader."Order Type" = pSalesHeader."order type"::Transfer) then begin
            //Coût dans l'affaire de cession
            lJobJnlLine.Init;
            lJobJnlLine."Document No." := pSalesHeader."No.";
            lJobJnlLine."Posting Date" := pSalesHeader."Posting Date";
            lJobJnlLine."Document Date" := pSalesHeader."Document Date";
            lJobJnlLine."Location Code" := pSalesHeader."Location Code";
            lJobJnlLine."Country/Region Code" := pSalesHeader."VAT Country/Region Code";
            lJobJnlLine."Reason Code" := pSalesHeader."Reason Code";
            lJobJnlLine."Job No." := pSalesHeader."Transfer Job No.";
            lJobJnlLine.Description := pSalesLine.Description;
            lJobJnlLine."Unit of Measure Code" := pSalesLine."Unit of Measure Code";
            lJobJnlLine."Location Code" := pSalesLine."Location Code";
            lJobJnlLine."Posting Group" := pSalesLine."Posting Group";
            lJobJnlLine."Shortcut Dimension 1 Code" := pSalesLine."Shortcut Dimension 1 Code";
            lJobJnlLine."Shortcut Dimension 2 Code" := pSalesLine."Shortcut Dimension 2 Code";
            lJobJnlLine."Work Type Code" := pSalesLine."Work Type Code";
            lJobJnlLine."Job Task No." := pSalesLine."Job Task No.";
            lJobJnlLine."Gen. Bus. Posting Group" := pSalesLine."Gen. Bus. Posting Group";
            lJob.Get(pSalesHeader."Job No.");
            lJobPostingGroup.Get(lJob."Job Posting Group");
            lJobPostingGroup.TestField("Transfer Bal. Account");
            lGLAccount.Get(lJobPostingGroup."Transfer Bal. Account");
            lJobJnlLine.Type := lJobJnlLine.Type::"G/L Account";
            lJobJnlLine."No." := lGLAccount."No.";
            lJobJnlLine."Gen. Prod. Posting Group" := lGLAccount."Gen. Prod. Posting Group";
            lJobJnlLine."Transaction Type" := pSalesLine."Transaction Type";
            lJobJnlLine."Transport Method" := pSalesLine."Transport Method";
            lJobJnlLine."Entry/Exit Point" := pSalesLine."Exit Point";
            lJobJnlLine.Area := pSalesLine.Area;
            lJobJnlLine."Transaction Specification" := pSalesLine."Transaction Specification";
            lJobJnlLine."Entry Type" := lJobJnlLine."entry type"::Usage;
            lJobJnlLine."Document No." := pSalesShptHeader."No.";
            lJobJnlLine."External Document No." := pGenJnlLineExtDocNo;

            //#6791 26/02/09
            //#6791
            //  lJobJnlLine.Quantity := -pSalesLine."Qty. to Ship";
            //  lJobJnlLine."Quantity (Base)" := -pSalesLine."Qty. to Ship (Base)";
            //  lJobJnlLine.VALIDATE("Total Cost",-pSalesLineACY.Amount);
            //  lJobJnlLine.VALIDATE("Total Cost (LCY)",-pSalesLine."Amount Excl. VAT (LCY)");
            //#6791//
            lJobJnlLine.Quantity := -pSalesLine."Qty. to Ship";
            lJobJnlLine."Quantity (Base)" := -pSalesLine."Qty. to Ship (Base)";
            //Arrondi
            if lJobJnlLine."Currency Code" = '' then begin
                Clear(lCurrency);
                lCurrency.InitRoundingPrecision
            end else begin
                lCurrency.Get(lJobJnlLine."Currency Code");
                lCurrency.TestField("Amount Rounding Precision");
                lCurrency.TestField("Unit-Amount Rounding Precision");
            end;
            //lJobJnlLine.VALIDATE("Total Cost",pSalesLineACY.Amount);
            lJobJnlLine."Total Cost" := -pSalesLineACY.Amount;
            lJobJnlLine.Validate("Unit Cost", lJobJnlLine."Total Cost" / lJobJnlLine.Quantity);
            lJobJnlLine."Unit Cost" := ROUND(lJobJnlLine."Unit Cost", pCurrency."Unit-Amount Rounding Precision");
            //lJobJnlLine.VALIDATE("Total Cost (LCY)",pSalesLine."Amount Excl. VAT (LCY)");
            lJobJnlLine."Total Cost (LCY)" := -pSalesLineACY.Amount;
            lJobJnlLine.Validate("Unit Cost (LCY)", lJobJnlLine."Total Cost (LCY)" / lJobJnlLine.Quantity);
            lJobJnlLine."Unit Cost (LCY)" := ROUND(lJobJnlLine."Unit Cost (LCY)", pCurrency."Unit-Amount Rounding Precision");
            //#6791 26/02/09//

            lJobJnlLine."Total Price" := 0;
            lJobJnlLine."Source Code" := pSrcCode;
            lJobJnlLine."Job Posting Only" := true;
            lJobJnlLine."Posting No. Series" := pSalesHeader."Posting No. Series";
            lJobJnlLine."Source Currency Code" := pSalesHeader."Currency Code";
            lJobJnlLine."Source Currency Total Cost" := pSalesLineACY.Amount;
            lJobJnlLine."Source Currency Total Price" := 0;

            /* GL2024  lTempJnlLineDim.DeleteAll;
               pTempDocDim.Reset;
                pTempDocDim.SetRange("Table ID", Database::"Sales Line");
                  pTempDocDim.SetRange("Line No.", pSalesLine."Line No.");
            lDimMgt.CopyDocDimToJnlLineDim(pTempDocDim, lTempJnlLineDim);
            lJobJnlPostLine.RunWithCheck(lJobJnlLine, lTempJnlLineDim);*/

            //CONTRE_PARTIE
            lJobPostingGroup.TestField("Transfer Account");
            lJobJnlLine."No." := lJobPostingGroup."Transfer Account";
            lGLAccount.Get(lJobPostingGroup."Transfer Account");
            lJobJnlLine."Gen. Prod. Posting Group" := lGLAccount."Gen. Prod. Posting Group";
            lJobJnlLine."Job No." := pSalesHeader."Job No.";
            lJobJnlLine.Description := lJobJnlLine.Description;
            lJobJnlLine.Quantity := 0;
            lJobJnlLine."Quantity (Base)" := 0;
            lJobJnlLine."Total Cost" := -lJobJnlLine."Total Cost";
            lJobJnlLine."Unit Cost" := -lJobJnlLine."Unit Cost";
            lJobJnlLine."Total Cost (LCY)" := -lJobJnlLine."Total Cost (LCY)";
            lJobJnlLine."Unit Cost (LCY)" := -lJobJnlLine."Unit Cost (LCY)";
            lJobJnlLine."Source Currency Total Cost" := -lJobJnlLine."Source Currency Total Cost";
            lJobJnlLine."Bal. Job No." := '';
            //#5370  lJobJnlLine."Job Task No." := lJob.gGetDefaultJobTask;  //Garder celui de la ligne
            //  lJobJnlLine."Bal. Created Entry" := FALSE; CW 08/11/07 incompatible avec Quantity = 0
            lJobJnlLine."Bal. Created Entry" := true;
            /* GL2024      lTempJnlLineDim.DeleteAll;
                 pTempDocDim.Reset;
                  pTempDocDim.SetRange("Table ID", Database::"Sales Line");
                   pTempDocDim.SetRange("Line No.", pSalesLine."Line No.");
                 lDimMgt.CopyDocDimToJnlLineDim(pTempDocDim, lTempJnlLineDim);
                 lJobJnlPostLine.RunWithCheck(lJobJnlLine, lTempJnlLineDim);*/
            //CESSION//
        end;
    end;


    procedure GetPostProdCompletion(var pSalesHeader: Record "Sales Header") Return: Boolean
    begin
        if (pSalesHeader."Document Type" = pSalesHeader."document type"::Invoice) and (pSalesHeader."Deadline Code" = '###') and
           ((pSalesHeader."No. Prepayment Invoiced" <> 0) or pSalesHeader."Scheduler Origin") then begin
            Return := true;
            Clear(pSalesHeader."Deadline Code");
        end else
            Return := false;
    end;


    procedure GetScheduleInvExist(pSalesHeader: Record "Sales Header"; pSalesLine: Record "Sales Line")
    var
        lInvScheduler: Record "Invoice Scheduler";
        Text8003900: label '%1 deleted for job %2 %3 %4.';
    begin
        if pSalesHeader."No. Prepayment Invoiced" <> 0 then begin
            if pSalesLine."Scheduler Line No." <> 0 then begin
                lInvScheduler.SetRange("Job No.", pSalesLine."Job No.");
                lInvScheduler.SetRange("Line No.", pSalesLine."Scheduler Line No.");
                if lInvScheduler.IsEmpty then
                    Error(Text8003900,
                          lInvScheduler.TableCaption,
                          lInvScheduler."Job No.",
                          lInvScheduler.FieldCaption("Line No."), lInvScheduler."Line No.");
            end;
        end;
    end;


    procedure SetFinishOrder(var pSalesHeader: Record "Sales Header"; pEverythingInvoiced: Boolean)
    var
        lFinishOrder: Codeunit "Finish Sales Order";
        lJob: Record Job;
    begin
        lFinishOrder.InitEverythingInvoiced(pEverythingInvoiced);
        lFinishOrder.Run(pSalesHeader);
        if pSalesHeader."Job No." <> '' then
            if lJob.Get(pSalesHeader."Job No.") then
                lFinishOrder.FinishedJob(lJob, true);
    end;


    procedure SetInitOutStanding(pSalesHeader: Record "Sales Header"; var pSalesLine: Record "Sales Line"; var pTempSalesLine: Record "Sales Line")
    var
        lSalesPost: Codeunit "Sales-Post";
    begin
        if pSalesHeader."Document Type" = pSalesHeader."document type"::Order then
            if pSalesLine.FindSet then
                repeat
                    pTempSalesLine.Get(pSalesHeader."Document Type", pSalesLine."Document No.", pSalesLine."Line No.");
                    pTempSalesLine."Quantity Shipped" := pTempSalesLine."Quantity Shipped" + pSalesLine."Qty. to Ship";
                    pTempSalesLine."Qty. Shipped (Base)" := pTempSalesLine."Qty. Shipped (Base)" + pSalesLine."Qty. to Ship (Base)";
                    pTempSalesLine."Quantity Invoiced" := pTempSalesLine."Quantity Invoiced" + pSalesLine."Qty. to Invoice";
                    pTempSalesLine."Qty. Invoiced (Base)" := pTempSalesLine."Qty. Invoiced (Base)" + pSalesLine."Qty. to Invoice (Base)";
                    //CMDOUVERTE
                    lSalesPost.UpdateBlanketOrderLine(pSalesLine, pSalesHeader.Ship, pSalesHeader.Receive, pSalesHeader.Invoice);
                    //CMDOUVERTE//
                    pTempSalesLine.Validate("Qty. to Ship", 0);
                    pTempSalesLine.InitOutstanding;
                    pTempSalesLine.Modify;
                until pSalesLine.Next = 0;
    end;
}

