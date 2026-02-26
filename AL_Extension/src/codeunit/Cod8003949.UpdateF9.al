Codeunit 8003949 "Update F9"
{
    // //STAT_DEVIS AC 02/05/05 Mise à jour des statistiques des documents de ventes.
    //                 17/07/05 Maj Stat document de vente plus leger à utiliser
    // 
    // //DEVIS_STAT GESWAY 13/12/05 Ajout fonction SetPresentationCodeFilter
    //                               Pose du filtre sur "Presentation Code"
    // 
    // //ANA_ACTIVITE GESWAY 15/12/05 Setrange sur "Task Code"


    trigger OnRun()
    begin
    end;

    var
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        VATAmountText: Text[30];
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        TotalAmount1LCY: Decimal;
        wBaseCalc: Integer;
        wMarginPriceCost: Decimal;
        wMarginPriceCostValue: Decimal;
        wMarginDirectCost: Decimal;
        wK: Decimal;
        wK1: Decimal;
        wK2: Decimal;
        wK3: Decimal;
        PresentationCodeFilter: Text[80];
        RelativeRate: Decimal;
        TotalAdjCostLCY: Decimal;


    procedure UpdateF9(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TotalSalesLine: Record "Sales Line"; var TotalSalesLineLCY: Record "Sales Line"; var SalesPost: Codeunit "Sales-Post"; var Cust: Record Customer; var TempVATAmountLine: Record "VAT Amount Line" temporary; BaseCalcQty: Integer)
    var
        TempSalesLine: Record "Sales Line" temporary;
        lSalesLines: Record "Sales Line";
        lSingleInstance: Codeunit "Import SingleInstance2";
        GenProdPostingGp: Record "Gen. Product Posting Group";
        Navibat: Record NavibatSetup;
        ProfitTot: Decimal;
        Currency: Record Currency;
    begin
        //#4367
        if lSingleInstance.wGetSalesOverheadCalcfrom = 0 then
            lSingleInstance.wSetSalesOverheadIsCalculated(false, 3);
        //#4367//

        SetBaseCalc(BaseCalcQty);
        Clear(SalesLine);
        Clear(TotalSalesLine);
        Clear(TotalSalesLineLCY);
        Clear(TempSalesLine);
        TempSalesLine.DeleteAll;
        Clear(SalesPost);
        Clear(VATAmount);
        Clear(VATAmountText);
        Clear(ProfitLCY);
        Clear(ProfitPct);
        Clear(TotalAmount1);
        Clear(TotalAmount2);
        Clear(TotalAmount1LCY);
        Clear(CreditLimitLCYExpendedPct);
        Clear(TempVATAmountLine);
        TempVATAmountLine.DeleteAll;

        //MIGRATION5.00 voir si la variable est utile ou si il faut la mettre en paramètre
        TotalAdjCostLCY := 0;
        //MIGRATION5.00//

        //lSalesLines.SETCURRENTKEY("Job No.","Document Type","Document No.","Gen. Prod. Posting Group",Option,Disable,"Assignment Basis",
        //                           Type,"Line Type","Presentation Code","Structure Line No.","No.");
        lSalesLines.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option);

        lSalesLines.SetRange("Document Type", SalesHeader."Document Type");
        lSalesLines.SetRange("Document No.", SalesHeader."No.");
        lSalesLines.SetFilter(Type, '<>%1', lSalesLines.Type::" ");
        //#7617 lSalesLines.SETFILTER(Quantity,'<>0');
        //DEVIS_STAT
        if PresentationCodeFilter <> '' then
            lSalesLines.SetFilter("Presentation Code", PresentationCodeFilter);
        //DEVIS_STAT//
        if not lSalesLines.IsEmpty then begin
            lSalesLines.Find('-');
            //#5162
            if SalesHeader.Status = SalesHeader.Status::Open then
                //#5162//
                Codeunit.Run(Codeunit::"Job Cost Assignment", lSalesLines);
        end;
        Commit;

        //DEVIS_STAT
        //GL2024     SalesPost.wSetPresentationCodeFilter(PresentationCodeFilter);
        //DEVIS_STAT//

        case wBaseCalc of
            0:
                SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);
            else
                SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 4);
        end;
        Clear(SalesPost);
        SalesLine.CalcVATAmountLines(0, SalesHeader, TempSalesLine, TempVATAmountLine);
        case wBaseCalc of
            0:
                SalesPost.SumSalesLinesTemp(SalesHeader, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
                                               VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);
            else
                SalesPost.SumSalesLinesTemp(SalesHeader, TempSalesLine, 4, TotalSalesLine, TotalSalesLineLCY,
                                              VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);
        end;
        if SalesHeader."Prices Including VAT" then begin
            TotalAmount2 := TotalSalesLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
            TotalAmount1LCY := TotalSalesLineLCY.Amount;
        end
        else begin
            TotalAmount1 := TotalSalesLine.Amount;
            TotalAmount2 := TotalSalesLine."Amount Including VAT";
            TotalAmount1LCY := TotalSalesLineLCY.Amount;
        end;

        if Cust.Get(SalesHeader."Bill-to Customer No.") then
            Cust.CalcFields("Balance (LCY)")
        else
            Clear(Cust);

        if Cust."Credit Limit (LCY)" = 0 then
            CreditLimitLCYExpendedPct := 0
        else
            if Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 then
                CreditLimitLCYExpendedPct := 0
            else
                if Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 then
                    CreditLimitLCYExpendedPct := 10000
                else
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        TempVATAmountLine.ModifyAll(Modified, false);

        // Calcul de la marge sur cout de revient
        if TotalAmount1LCY <> 0 then
            wMarginPriceCost := (TotalAmount1LCY -
                (TotalSalesLine."Total Cost (LCY)" + TotalSalesLine."Overhead Amount (LCY)")) / TotalAmount1LCY
        else
            wMarginPriceCost := 0;

        //Calcul de la marge sur déboursé
        if TotalAmount1LCY <> 0 then
            wMarginDirectCost := ((TotalAmount1LCY - TotalSalesLine."Total Cost (LCY)") / TotalAmount1LCY)
        else
            wMarginDirectCost := 0;

        //Calcul du K
        if (TotalSalesLine."Total Cost (LCY)" - TotalSalesLine."Job Costs (LCY)") <> 0 then
            wK := (TotalSalesLine."Total Cost (LCY)" + TotalSalesLine."Overhead Amount (LCY)")
                  / (TotalSalesLine."Total Cost (LCY)" - TotalSalesLine."Job Costs (LCY)")
        else
            wK := 0;

        if (TotalSalesLine."Total Cost (LCY)" - TotalSalesLine."Job Costs (LCY)") <> 0 then
            wK1 := TotalAmount1LCY / (TotalSalesLine."Total Cost (LCY)" - TotalSalesLine."Job Costs (LCY)")
        else
            wK1 := 0;

        if TotalSalesLine."Total Cost (LCY)" <> 0 then
            wK2 := TotalAmount1LCY / TotalSalesLine."Total Cost (LCY)"
        else
            wK2 := 0;

        if (TotalSalesLine."Total Cost (LCY)" - TotalSalesLine."Job Costs (LCY)") <> 0 then
            wK3 := TotalSalesLine."Total Cost (LCY)" / (TotalSalesLine."Total Cost (LCY)" - TotalSalesLine."Job Costs (LCY)")
        else
            wK3 := 0;

        //CalcRelativeRate(SalesHeader);
        Navibat.Get();
        lSingleInstance.wSetCurrency(Currency, SalesHeader);
        GenProdPostingGp.SetFilter("Document Type Filter", '%1', SalesHeader."Document Type");
        GenProdPostingGp.SetFilter("Document No. Filter", '%1', SalesHeader."No.");
        //#5210 GenProdPostingGp.SETFILTER("Filter Line Type",'<>%1',TotalSalesLine."Line Type"::Structure);
        GenProdPostingGp.SetRange(Code, Navibat."Tot. Gen. Prod. Posting Group");

        //#5210
        if Navibat."Profit Calculation Method" = Navibat."profit calculation method"::"Structure line" then
            GenProdPostingGp.SetFilter("Filter Line Type", '<>%1&%2..',
                                       TotalSalesLine."line type"::Structure, TotalSalesLine."line type"::Item)
        else begin
            GenProdPostingGp.SetRange("Document Line No. Filter", 0);
            GenProdPostingGp.SetFilter("Filter Line Type", '%1..', TotalSalesLine."line type"::Item);
        end;
        //#5210//

        if GenProdPostingGp.FindFirst then
            GenProdPostingGp.CalcFields("Theoretical Profit Amount");
        ProfitTot := GenProdPostingGp."Theoretical Profit Amount";
        if ProfitTot <> 0 then
            RelativeRate :=
              (TotalAmount1LCY - (TotalSalesLine."Total Cost (LCY)" + TotalSalesLine."Overhead Amount (LCY)")) / ProfitTot
        else
            if TotalSalesLine."Total Cost (LCY)" <> 0 then
                RelativeRate :=
                  (TotalAmount1LCY - (TotalSalesLine."Total Cost (LCY)" + TotalSalesLine."Overhead Amount (LCY)")) /
                  ROUND(TotalSalesLine."Total Cost (LCY)", Currency."Amount Rounding Precision")
            else
                RelativeRate := 0;
        //RelativeRate := Round(RelativeRate,Currency."Amount Rounding Precision");

        //#4367
        if lSingleInstance.wGetSalesOverheadCalcfrom = 3 then
            lSingleInstance.wSetSalesOverheadIsCalculated(false, 0);
        //#4367//
    end;


    procedure UpdateStatSalesDoc(var SalesHeader: Record "Sales Header")
    var
        TempSalesLine: Record "Sales Line" temporary;
        lSalesLines: Record "Sales Line";
        lTotalSalesLineLCY: Record "Sales Line";
        lCust: Record Customer;
        SalesPost: Codeunit "Sales-Post";
        TotalSalesLine: Record "Sales Line";
    begin
        Clear(TotalSalesLine);
        Clear(lTotalSalesLineLCY);
        Clear(TempSalesLine);
        TempSalesLine.DeleteAll;
        Clear(SalesPost);
        Clear(VATAmount);
        Clear(VATAmountText);
        Clear(ProfitLCY);
        Clear(ProfitPct);
        //CLEAR(TotalAmount1);
        //CLEAR(TotalAmount2);
        Clear(TotalAmount1LCY);
        //CLEAR(lTempVATAmountLine);
        //lTempVATAmountLine.DELETEALL;

        //#5162
        if SalesHeader.Status = SalesHeader.Status::Open then begin
            //#5162//
            lSalesLines.SetRange("Document Type", SalesHeader."Document Type");
            lSalesLines.SetRange("Document No.", SalesHeader."No.");
            if not lSalesLines.IsEmpty then begin
                lSalesLines.Find('-');
                Codeunit.Run(Codeunit::"Job Cost Assignment", lSalesLines);
                Commit;
            end;
            //#5162
        end;
        //#5162//

        SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);

        Clear(SalesPost);

        //lSalesLines.CalcVATAmountLines(0,SalesHeader,TempSalesLine,lTempVATAmountLine);

        SalesPost.SumSalesLinesTemp(SalesHeader, TempSalesLine, 0, TotalSalesLine, lTotalSalesLineLCY,
                                    VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);

        if SalesHeader."Prices Including VAT" then begin
            //  TotalAmount2 := TotalSalesLine.Amount;
            //  TotalAmount1 := TotalAmount2 + VATAmount;
            //  TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
            TotalAmount1LCY := lTotalSalesLineLCY.Amount;
        end
        else begin
            //  TotalAmount1 := TotalSalesLine.Amount;
            //  TotalAmount2 := TotalSalesLine."Amount Including VAT";
            TotalAmount1LCY := lTotalSalesLineLCY.Amount;
        end;

        // Calcul de la marge sur cout de revient
        wMarginPriceCostValue := TotalAmount1LCY - (TotalSalesLine."Total Cost (LCY)" + TotalSalesLine."Overhead Amount (LCY)");

        //lTempVATAmountLine.MODIFYALL(Modified,FALSE);
    end;


    procedure SetBaseCalc(BaseCalc: Integer)
    begin
        wBaseCalc := BaseCalc;
    end;


    procedure getMaginPriceCost(): Decimal
    begin
        exit(wMarginPriceCost)
    end;


    procedure getMaginPriceCostValue(): Decimal
    begin
        exit(wMarginPriceCostValue);
    end;


    procedure getMarginDirectCost(): Decimal
    begin
        exit(wMarginDirectCost);
    end;


    procedure getCreditLimitLCYExpendedPct(): Decimal
    begin
        exit(CreditLimitLCYExpendedPct);
    end;


    procedure getTotalAmount1(): Decimal
    begin
        exit(TotalAmount1);
    end;


    procedure getTotalAmount2(): Decimal
    begin
        exit(TotalAmount2);
    end;


    procedure getTotalAmountLCY(): Decimal
    begin
        exit(TotalAmount1LCY);
    end;


    procedure getVATAmountText(): Text[30]
    begin
        exit(VATAmountText);
    end;


    procedure getVATAmount(): Decimal
    begin
        exit(VATAmount);
    end;


    procedure getProfitLCY(): Decimal
    begin
        exit(ProfitLCY);
    end;


    procedure getProfitPct(): Decimal
    begin
        exit(ProfitPct);
    end;


    procedure getK(): Decimal
    begin
        exit(wK);
    end;


    procedure getK1(): Decimal
    begin
        exit(wK1);
    end;


    procedure getK2(): Decimal
    begin
        exit(wK2);
    end;


    procedure getK3(): Decimal
    begin
        exit(wK3);
    end;


    procedure SetPresentationCodeFilter(pPresentationCodeFilter: Text[80])
    begin
        //DEVIS_STAT
        PresentationCodeFilter := pPresentationCodeFilter;
        //DEVIS_STAT//
    end;


    procedure getRelativeRate(): Decimal
    begin
        exit(RelativeRate);
    end;
}

