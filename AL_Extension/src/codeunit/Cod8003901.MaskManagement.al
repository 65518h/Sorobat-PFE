Codeunit 8003901 "Mask Management"
{
    // //MASK CW 16/09/04 Mask management

    Permissions = TableData "Cust. Ledger Entry" = rm,
                  TableData "Sales Header" = rm,
                  TableData "Purchase Header" = rm,
                  TableData "Sales Shipment Header" = rm,
                  TableData "Sales Invoice Header" = rm,
                  TableData "Sales Cr.Memo Header" = rm,
                  TableData "Purch. Rcpt. Header" = rm,
                  TableData "Purch. Inv. Header" = rm,
                  TableData "Purch. Cr. Memo Hdr." = rm,
                  //GL2024     TableData 168 = rm,
                  TableData "Job Ledger Entry" = rm,
                  TableData "Res. Ledger Entry" = rm,
                  //GL2024     TableData 211 = rm,
                  TableData "Job Indicator" = rm;
    //GL2024   TableData 8003902 = rm;

    trigger OnRun()
    begin
    end;

    var
        tOrEmpty: label '|''''';


    procedure UserMask() Return: Code[10]
    var
        lUserSetup: Record "User Setup";
    begin
        if lUserSetup.Get(UserId) then
            exit(lUserSetup."Mask Code");
    end;


    procedure UserMaskFilter() Return: Code[30]
    var
        lUserSetup: Record "User Setup";
    begin
        if lUserSetup.Get(UserId) and (lUserSetup."Mask Filter" <> '') then
            exit(lUserSetup."Mask Filter" + tOrEmpty);
    end;


    procedure CheckJobMask(pJobFilter: Text[250])
    var
        lTemp: Record "User Setup" temporary;
        tNotEnable: label 'You don''t have permission to view this job.';
        lJob: Record Job;
    begin
        if (pJobFilter <> '') and (StrLen(pJobFilter) <= MaxStrLen(lJob."No.")) then
            if lJob.Get(pJobFilter) then begin
                lTemp."Mask Code" := lJob."Mask Code";
                lTemp.Insert;
                lTemp.SetFilter("Mask Code", UserMaskFilter);
                if not lTemp.FindFirst then
                    Error(tNotEnable);
            end;
    end;


    procedure Job(var pRec: Record Job)
    begin
        CheckJobMask(pRec.GetFilter("No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure JobMaskValidate(var xRec: Record Job; var pRec: Record Job)
    var
        lJobTemp: Record Job temporary;
        lJobLedgerEntry: Record "Job Ledger Entry";
        lJobTask: Record "Job Task";
        lJobPlanningLine: Record "Job Planning Line";
        lSalesHeader: Record "Sales Header";
        lPurchaseHeader: Record "Purchase Header";
        lResLedgEntry: Record "Res. Ledger Entry";
        lSalesInvHeader: Record "Sales Invoice Header";
        lSalesShipHeader: Record "Sales Shipment Header";
        lSalesCMHeader: Record "Sales Cr.Memo Header";
        lPurchInvHeader: Record "Purch. Inv. Header";
        lPurchCMHeader: Record "Purch. Cr. Memo Hdr.";
        lPurchRecptHeader: Record "Purch. Rcpt. Header";
        lCustLedgEntry: Record "Cust. Ledger Entry";
        tIncompatible: label 'Filter not compatible with code';
        lJobIndicator: Record "Job Indicator";
    begin
        //IF xRec."Mask Code" <> pRec."Mask Code" THEN BEGIN
        CheckJobMask(pRec."No.");

        lJobLedgerEntry.SetCurrentkey("Job No.");
        lJobLedgerEntry.SetRange("Job No.", pRec."No.");
        lJobLedgerEntry.ModifyAll("Mask Code", pRec."Mask Code");
        lJobLedgerEntry.SetCurrentkey("Job No.");
        lJobLedgerEntry.SetRange("Job No.", pRec."No.");
        lJobLedgerEntry.ModifyAll("Mask Code", pRec."Mask Code");
        lJobTask.SetCurrentkey("Job No.");
        lJobTask.SetRange("Job No.", pRec."No.");
        lJobTask.ModifyAll("Mask Code", pRec."Mask Code");
        lJobPlanningLine.SetCurrentkey("Job No.");
        lJobPlanningLine.SetRange("Job No.", pRec."No.");
        lJobPlanningLine.ModifyAll("Mask Code", pRec."Mask Code");
        lSalesHeader.SetCurrentkey("Job No.");
        lSalesHeader.SetRange("Job No.", pRec."No.");
        lSalesHeader.ModifyAll("Mask Code", pRec."Mask Code");
        lPurchaseHeader.SetCurrentkey("Job No.");
        lPurchaseHeader.SetRange("Job No.", pRec."No.");
        lPurchaseHeader.ModifyAll("Mask Code", pRec."Mask Code");
        //  lResLedgEntry.SETCURRENTKEY("Job No.");
        lResLedgEntry.SetRange("Job No.", pRec."No.");
        lResLedgEntry.ModifyAll("Mask Code", pRec."Mask Code");
        lSalesInvHeader.SetCurrentkey("Job No.");
        lSalesInvHeader.SetRange("Job No.", pRec."No.");
        lSalesInvHeader.ModifyAll("Mask Code", pRec."Mask Code");
        //  lSalesShipHeader.SETCURRENTKEY("Job No.");
        lSalesShipHeader.SetRange("Job No.", pRec."No.");
        lSalesShipHeader.ModifyAll("Mask Code", pRec."Mask Code");
        lSalesCMHeader.SetCurrentkey("Job No.");
        lSalesCMHeader.SetRange("Job No.", pRec."No.");
        lSalesCMHeader.ModifyAll("Mask Code", pRec."Mask Code");
        //  lPurchInvHeader.SETCURRENTKEY("Job No.");
        lPurchInvHeader.SetRange("Job No.", pRec."No.");
        lPurchInvHeader.ModifyAll("Mask Code", pRec."Mask Code");
        //  lPurchCMHeader.SETCURRENTKEY("Job No.");
        lPurchCMHeader.SetRange("Job No.", pRec."No.");
        lPurchCMHeader.ModifyAll("Mask Code", pRec."Mask Code");
        //  lPurchRecptHeader.SETCURRENTKEY("Job No.");
        lPurchRecptHeader.SetRange("Job No.", pRec."No.");
        lPurchRecptHeader.ModifyAll("Mask Code", pRec."Mask Code");
        lCustLedgEntry.SetCurrentkey("Job No.");
        lCustLedgEntry.SetRange("Job No.", pRec."No.");
        lCustLedgEntry.ModifyAll("Mask Code", pRec."Mask Code");
        lJobIndicator.SetCurrentkey("Job No.");
        lJobIndicator.SetRange("Job No.", pRec."No.");
        lJobIndicator.ModifyAll("Mask Code", pRec."Mask Code");
        //END;
    end;


    procedure JobLedgEntry(var pRec: Record "Job Ledger Entry")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure JobTask(var pRec: Record "Job Task")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure JobPlanningLine(var pRec: Record "Job Planning Line")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure SalesHeader(var pRec: Record "Sales Header")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure PurchaseHeader(var pRec: Record "Purchase Header")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure ResLedgEntry(var pRec: Record "Res. Ledger Entry")
    begin
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure SalesInvHeader(var pRec: Record "Sales Invoice Header")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure SalesShipHeader(var pRec: Record "Sales Shipment Header")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure SalesCMHeader(var pRec: Record "Sales Cr.Memo Header")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure SalesHeaderArchive(var pRec: Record "Sales Header Archive")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure PurchInvHeader(var pRec: Record "Purch. Inv. Header")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure PurchRcptHeader(var pRec: Record "Purch. Rcpt. Header")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure PurchCMHeader(var pRec: Record "Purch. Cr. Memo Hdr.")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure PurchaseHeaderArchive(var pRec: Record "Purchase Header Archive")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;


    procedure CustLedgEntry(var pRec: Record "Cust. Ledger Entry")
    begin
        CheckJobMask(pRec.GetFilter("Job No."));
        pRec.FilterGroup(2);
        pRec.SetFilter("Mask Code", UserMaskFilter);
        pRec.FilterGroup(0);
    end;
}

