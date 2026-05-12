Codeunit 8001421 "Calc Stat Sales Header"
{
    // //+REF+OPPORT AC 03/08/05 Calcul des statistique du document vente

    TableNo = "Sales Header";

    trigger OnRun()
    begin
        //UpdateStatSalesDoc(Rec);
        UpdateStatSalesBat(Rec);
    end;

    var
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        ProfitLCY: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        TotalAmount1LCY: Decimal;


    procedure UpdateStatSalesDoc(var pSalesHeader: Record "Sales Header")
    var
        TempSalesLine: Record "Sales Line" temporary;
        lSalesLines: Record "Sales Line";
        lTotalSalesLineLCY: Record "Sales Line";
        lCust: Record Customer;
        lTempVATAmountLine: Record "VAT Amount Line";
        SalesPost: Codeunit "Sales-Post";
        TotalSalesLine: Record "Sales Line";
        CurrExchRate: Record "Currency Exchange Rate";
        UseDate: Date;
    begin
        with pSalesHeader do begin
            TotalSalesLine."Inv. Discount Amount" := lTempVATAmountLine.GetTotalInvDiscAmount;
            TotalAmount1 :=
              TotalSalesLine."Line Amount" - TotalSalesLine."Inv. Discount Amount";
            VATAmount := lTempVATAmountLine.GetTotalVATAmount;
            if "Prices Including VAT" then begin
                TotalAmount1 := lTempVATAmountLine.GetTotalAmountInclVAT;
                TotalAmount2 := TotalAmount1 - VATAmount;
                TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
            end else
                TotalAmount2 := TotalAmount1 + VATAmount;

            if "Prices Including VAT" then
                lTotalSalesLineLCY.Amount := TotalAmount2
            else
                lTotalSalesLineLCY.Amount := TotalAmount1;
            if "Currency Code" <> '' then begin
                if ("Document Type" in ["document type"::"Blanket Order", "document type"::Quote]) and
                   ("Posting Date" = 0D)
                then
                    UseDate := WorkDate
                else
                    UseDate := "Posting Date";

                lTotalSalesLineLCY.Amount :=
                  CurrExchRate.ExchangeAmtFCYToLCY(
                    UseDate, "Currency Code", lTotalSalesLineLCY.Amount, "Currency Factor");
            end;
            TotalAmount1LCY := lTotalSalesLineLCY.Amount;
            ProfitLCY := lTotalSalesLineLCY.Amount - lTotalSalesLineLCY."Unit Cost (LCY)";

        end;
    end;


    procedure UpdateStatSalesBat(var SalesHeader: Record "Sales Header")
    var
        TempSalesLine: Record "Sales Line" temporary;
        lSalesLines: Record "Sales Line";
        lTotalSalesLineLCY: Record "Sales Line";
        lCust: Record Customer;
        SalesPost: Codeunit "Sales-Post";
        TotalSalesLine: Record "Sales Line";
        lProfitPct: Decimal;
        TotalAdjCostLCY: Decimal;
    begin
        Clear(TotalSalesLine);
        Clear(lTotalSalesLineLCY);
        Clear(TempSalesLine);
        TempSalesLine.DeleteAll;
        Clear(SalesPost);
        Clear(VATAmount);
        Clear(VATAmountText);
        Clear(ProfitLCY);
        Clear(lProfitPct);
        Clear(TotalAmount1LCY);

        //MIGRATION5.00 voir si la variable est utile ou si il faut la mettre en paramètre
        TotalAdjCostLCY := 0;
        //MIGRATION5.00//

        //#5062
        if SalesHeader.Status = SalesHeader.Status::Open then begin
            //#5062//
            lSalesLines.SetRange("Document Type", SalesHeader."Document Type");
            lSalesLines.SetRange("Document No.", SalesHeader."No.");
            if not lSalesLines.IsEmpty then begin
                lSalesLines.Find('-');
                Codeunit.Run(Codeunit::"Job Cost Assignment", lSalesLines);
                Commit;
            end;
            //#5062
        end;
        //#5062//


        SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);

        Clear(SalesPost);

        SalesPost.SumSalesLinesTemp(SalesHeader, TempSalesLine, 0, TotalSalesLine, lTotalSalesLineLCY,
                                    VATAmount, VATAmountText, ProfitLCY, lProfitPct, TotalAdjCostLCY);

        if SalesHeader."Prices Including VAT" then begin
            TotalAmount1LCY := lTotalSalesLineLCY.Amount;
        end
        else begin
            TotalAmount1LCY := lTotalSalesLineLCY.Amount;
        end;

        // Calcul de la marge sur cout de revient
        ProfitLCY := TotalAmount1LCY - (TotalSalesLine."Total Cost (LCY)" + TotalSalesLine."Overhead Amount (LCY)");
    end;


    procedure getTotalAmountLCY(): Decimal
    begin
        exit(TotalAmount1LCY);
    end;


    procedure getProfitLCY(): Decimal
    begin
        exit(ProfitLCY);
    end;
}

