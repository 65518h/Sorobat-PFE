Codeunit 8001518 "Aggregate, Real Time Update"
{
    //GL2024  ID dans Nav 2009 : "8001318"
    // #8046 SD 01/06/10
    // //STATSEXPLORER STATSEXPLORER 23/11/01 Update StatsExplorer Aggregates


    trigger OnRun()
    begin
    end;

    var
        StatsExplorerSetup: Record "Statistics setup";


    procedure ValueEntry(ValueEntry: Record "Value Entry")
    var
        CodeUnitAggregate: Codeunit "Aggr., Item Ledger Entries";
    begin
        // CodeUnit 22
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            CodeUnitAggregate.InitRequest(ValueEntry."Posting Date", ValueEntry."Posting Date", 0, ValueEntry."Entry No.");
            CodeUnitAggregate.Run;
        end;
    end;


    procedure SalesInvoice(SalesInvHeader: Record "Sales Invoice Header"; SalesInvLine: Record "Sales Invoice Line")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Res. and G/L";
    begin
        // CodeUnit 80
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            if (SalesInvLine.Type = SalesInvLine.Type::"G/L Account") or (SalesInvLine.Type = SalesInvLine.Type::Resource) then begin
                CodeUnitAggregate.InitRequest(SalesInvHeader."Posting Date", SalesInvHeader."Posting Date", 0, 1,
                                           SalesInvLine."Document No.", SalesInvLine."Line No.");
                CodeUnitAggregate.Run;
            end;
        end;
    end;


    procedure SalesCreditMemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Res. and G/L";
    begin
        // CodeUnit 80
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            if (SalesCrMemoLine.Type = SalesCrMemoLine.Type::"G/L Account") or
               (SalesCrMemoLine.Type = SalesCrMemoLine.Type::Resource) then begin
                CodeUnitAggregate.InitRequest(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Posting Date", 0, 2,
                                           SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.");
                CodeUnitAggregate.Run;
            end;
        end;
    end;


    procedure PurchaseInvoice(PurchaseInvHeader: Record "Purch. Inv. Header"; PurchaseInvLine: Record "Purch. Inv. Line")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Res. and G/L";
    begin
        // CodeUnit 90
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            if (PurchaseInvLine.Type = PurchaseInvLine.Type::"G/L Account") then begin
                CodeUnitAggregate.InitRequest(PurchaseInvHeader."Posting Date", PurchaseInvHeader."Posting Date", 0, 3,
                                              PurchaseInvLine."Document No.", PurchaseInvLine."Line No.");
                CodeUnitAggregate.Run;
            end;
        end;
    end;


    procedure PurchaseCreditMemo(PurchaseCrMemoHeader: Record "Purch. Cr. Memo Hdr."; PurchaseCrMemoLine: Record "Purch. Cr. Memo Line")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Res. and G/L";
    begin
        // CodeUnit 90
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            if (PurchaseCrMemoLine.Type = PurchaseCrMemoLine.Type::"G/L Account") then begin
                CodeUnitAggregate.InitRequest(PurchaseCrMemoHeader."Posting Date", PurchaseCrMemoHeader."Posting Date", 0, 4,
                                              PurchaseCrMemoLine."Document No.", PurchaseCrMemoLine."Line No.");
                CodeUnitAggregate.Run;
            end;
        end;
    end;


    procedure JobLedgerEntry(JobLedgEntry: Record "Job Ledger Entry")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Job Ledger Entries";
    begin
        // CodeUnit 202
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            CodeUnitAggregate.InitRequest(JobLedgEntry."Posting Date", JobLedgEntry."Posting Date", 0, JobLedgEntry."Entry No.");
            CodeUnitAggregate.Run;
        end;
    end;


    procedure ResLedgerEntry(ResLedgEntry: Record "Res. Ledger Entry")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Res. Ledger Entries";
    begin
        // CodeUnit 212
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            CodeUnitAggregate.InitRequest(ResLedgEntry."Posting Date", ResLedgEntry."Posting Date", 0, ResLedgEntry."Entry No.");
            CodeUnitAggregate.Run;
        end;
    end;


    procedure GLEntry(GLEntry: Record "G/L Entry")
    var
        CodeUnitAggregate: Codeunit "Aggregate, G/L Entry";
    begin
        // CodeUnit 12
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            CodeUnitAggregate.InitRequest(GLEntry."Posting Date", GLEntry."Posting Date", 0, GLEntry."Entry No.");
            CodeUnitAggregate.Run;
        end;
    end;


    procedure CustomerEntry(CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Cust. Ledger Entry";
    begin
        // CodeUnit 12
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            CodeUnitAggregate.InitRequest(CustLedgerEntry."Posting Date", CustLedgerEntry."Posting Date", 0, true, CustLedgerEntry."Entry No.");
            CodeUnitAggregate.Run;
        end;
    end;


    procedure VendorEntry(VendLedgerEntry: Record "Vendor Ledger Entry")
    var
        CodeUnitAggregate: Codeunit "Aggregate, Vendor Ledger Entry";
    begin
        // CodeUnit 12
        if (StatsExplorerSetup.Get) and (StatsExplorerSetup."Aggregate, real time update") then begin
            CodeUnitAggregate.InitRequest(VendLedgerEntry."Posting Date", VendLedgerEntry."Posting Date", 0, true, VendLedgerEntry."Entry No.");
            CodeUnitAggregate.Run;
        end;
    end;
}

