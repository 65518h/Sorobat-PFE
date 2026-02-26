Codeunit 52048888 "Document-Print GMAO"
{
    //GL2024  ID dans Nav 2009 : "39002015"
    trigger OnRun()
    begin
    end;

    var
        Text000: label '%1 is missing for %2';
        Text001: label '%1 is missing for %2 %3';
        Text002: label '%1 for %2 is missing in %3';
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        SalesLine: Record "Sales Line";
        PurchLine: Record "Purchase Line";
        SalesCalcDisc: Codeunit "Sales-Calc. Discount";
        PurchCalcDisc: Codeunit "Purch.-Calc.Discount";
    //GL3900

    /*
        procedure PrintWorkOrder(OT: Record OT)
        var
            ReportSelection: Record "Report Selections";
            "order": Record OT;
        begin
            ReportSelection.SetRange(Usage, ReportSelection.Usage::"Invt. Period Test");
            if ReportSelection.Count = 0 then
                Error(Text000, ReportSelection.TableCaption, 'Ordre de Travail ')
            else begin
                ReportSelection.SetFilter("Report ID", '<>0');
                ReportSelection.Find('-');
                order.Reset;
                order.SetFilter("code OT", OT."code OT");
                if order.Find('-') then
                    repeat
                        Report.RunModal(ReportSelection."Report ID", true, false, order)
                    until ReportSelection.Next = 0;
            end;
        end;
    */
    //GL3900
    procedure PrintPurchHeader(PurchHeader: Record "Purchase Header")
    var
        ReportSelection: Record "Report Selections";
    begin
        PurchHeader.SetRange("No.", PurchHeader."No.");
        PurchSetup.Get;
        if PurchSetup."Calc. Inv. Discount" then begin
            PurchLine.Reset;
            PurchLine.SetRange("Document Type", PurchHeader."Document Type");
            PurchLine.SetRange("Document No.", PurchHeader."No.");
            PurchLine.Find('-');
            PurchCalcDisc.Run(PurchLine);
            PurchHeader.Get(PurchHeader."Document Type", PurchHeader."No.");
            Commit;
        end;
        case PurchHeader."Document Type" of
            PurchHeader."document type"::Quote:
                ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Quote");
            PurchHeader."document type"::"Blanket Order":
                ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Blanket");
            PurchHeader."document type"::Order:
                ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Order");
            PurchHeader."document type"::"Return Order":
                ReportSelection.SetRange(Usage, ReportSelection.Usage::"P.Return");
            else
                exit;
        end;
        ReportSelection.SetFilter("Report ID", '<>0');
        ReportSelection.Find('-');
        repeat
            Report.RunModal(ReportSelection."Report ID", true, false, PurchHeader)
        until ReportSelection.Next = 0;
    end;


    procedure PrintBankAccStmt(BankAccStmt: Record "Bank Account Statement")
    var
        ReportSelection: Record "Report Selections";
    begin
        BankAccStmt.SetRecfilter;
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"B.Stmt");
        ReportSelection.SetFilter("Report ID", '<>0');
        ReportSelection.Ascending := false;
        ReportSelection.Find('-');
        repeat
            Report.Run(ReportSelection."Report ID", true, false, BankAccStmt);
        until ReportSelection.Next = 0;
    end;


    procedure PrintCheck(var NewGenJnlLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
        ReportSelection: Record "Report Selections";
    begin
        GenJnlLine.Copy(NewGenJnlLine);
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"B.Check");
        ReportSelection.SetFilter("Report ID", '<>0');
        ReportSelection.Find('-');
        repeat
            Report.RunModal(ReportSelection."Report ID", true, false, GenJnlLine);
        until ReportSelection.Next = 0;
    end;


    procedure PrintTransferHeader(TransHeader: Record "Transfer Header")
    var
        ReportSelection: Record "Report Selections";
    begin
        TransHeader.SetRange("No.", TransHeader."No.");
        ReportSelection.SetRange(Usage, ReportSelection.Usage::Inv1);
        ReportSelection.SetFilter("Report ID", '<>0');
        ReportSelection.Find('-');
        repeat
            Report.RunModal(ReportSelection."Report ID", true, false, TransHeader)
        until ReportSelection.Next = 0;
    end;


    procedure PrintServiceContract(ServiceContract: Record "Service Contract Header")
    var
        ReportSelection: Record "Report Selections";
    begin
        ServiceContract.SetRange("Contract No.", ServiceContract."Contract No.");
        case ServiceContract."Contract Type" of
            ServiceContract."contract type"::Quote:
                ReportSelection.SetRange(Usage, ReportSelection.Usage::"SM.Contract Quote");
            ServiceContract."contract type"::Contract:
                ReportSelection.SetRange(Usage, ReportSelection.Usage::"SM.Contract");
            else
                exit;
        end;

        ReportSelection.SetFilter("Report ID", '<>0');
        if ReportSelection.Find('-') then begin
            repeat
                Report.RunModal(ReportSelection."Report ID", true, false, ServiceContract)
            until ReportSelection.Next = 0;
        end else
            Error(Text001, ReportSelection.TableCaption, Format(ServiceContract."Contract Type"), ServiceContract."Contract No.");
    end;


    procedure PrintServiceHeader(ServiceHeader: Record "Service Header")
    var
        ReportSelection: Record "Report Selections";
    begin
        ServiceHeader.SetRange("No.", ServiceHeader."No.");
        ServiceHeader.SetRange("Document Type", ServiceHeader."Document Type");
        /*GL2024  case ServiceHeader."No." of
              ServiceHeader."No."::"0":
                  ReportSelection.SetRange(Usage, ReportSelection.Usage::"SM.Quote");
              ServiceHeader."no."::"1":
                  ReportSelection.SetRange(Usage, ReportSelection.Usage::"SM.Order");
              else
                  exit;
          end;*/
        ReportSelection.SetFilter("Report ID", '<>0');
        if ReportSelection.Find('-') then begin
            repeat
                Report.RunModal(ReportSelection."Report ID", true, false, ServiceHeader);
            until ReportSelection.Next = 0;
        end else
            Error(Text002, ReportSelection.FieldCaption("Report ID"), ServiceHeader.TableCaption, ReportSelection.TableCaption);
    end;
}

