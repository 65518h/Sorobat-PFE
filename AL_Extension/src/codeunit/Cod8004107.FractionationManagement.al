Codeunit 8004107 "Fractionation Management"
{
    // //+PMT+MULTI GESWAY 27/12/02 Multi-échéance, Fractionnement d'une Ligne feuille saisie.
    //                             Correction pour fractionnement "Amount (LCY)" et "Profit (LCY)"
    // //PMT_DIRECT GESWAY 01/07/03 Alimentation de Paiement direct
    // //RETENTION CLA 09/06/04 Alimentation de Retenue de garantie


    trigger OnRun()
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        DimMgt: Codeunit DimensionManagement;
        TextFract: label '%1total can''t be more than 100 for %2 parts.';


    procedure GenJnlLineFraction(var pGenJnlLine: Record "Gen. Journal Line"; var pTempJnlLineDim: Record "Dim. Value per Account"; pPaymentTermCode: Code[10]; var pGenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        Fractionation: Record Fractionation;
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        CurrencyExchRate: Record "Currency Exchange Rate";
        //GL2024  lTempJnlLineDim: Record 356 temporary;
        i: Integer;
        TotalAmount: Decimal;
        TotalAmountLCY: Decimal;
        RemainingAmount: Decimal;
        OpenAmountLCY: Decimal;
        FactionAmount: Decimal;
        FactionAmountLCY: Decimal;
        NextDueDate: Date;
        TotalPercent: Decimal;
        TotalAmountPercent: Decimal;
        CurrencyFactor: Decimal;
        InvoiceRounding: Boolean;
        InitialDescription: Text[50];
        ProfitLCY: Decimal;
        RemainingProfit: Decimal;
        lTextRG: label 'RM';
        SalesLCY: Decimal;
        RemainingSalesLCY: Decimal;
    begin
        //Le codeunit GenJnlPostLine est passé en paramètre pour préserver l'instance (CONSISTENT)
        GLSetup.Get;
        if pGenJnlLine.Amount > 0 then begin // vente
            SalesSetup.Get;
            InvoiceRounding := SalesSetup."Invoice Rounding";
        end else begin
            PurchSetup.Get;
            InvoiceRounding := PurchSetup."Invoice Rounding";
        end;
        if pGenJnlLine."Currency Code" = '' then begin
            Currency."Invoice Rounding Precision" := GLSetup."Inv. Rounding Precision (LCY)";
            Currency."Invoice Rounding Type" := GLSetup."Inv. Rounding Type (LCY)";
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            if InvoiceRounding then
                GLSetup.TestField("Inv. Rounding Precision (LCY)")
            else
                GLSetup.TestField("Amount Rounding Precision");
        end else begin
            Currency.Get(pGenJnlLine."Currency Code");
            if InvoiceRounding then
                Currency.TestField("Invoice Rounding Precision")
            else
                Currency.TestField("Amount Rounding Precision");
        end;

        if CurrencyFactor = 0 then
            CurrencyFactor := CurrencyExchRate.ExchangeRate(pGenJnlLine."Posting Date", Currency.Code);
        TotalAmount := pGenJnlLine.Amount;
        RemainingAmount := TotalAmount;
        TotalAmountLCY := pGenJnlLine."Amount (LCY)";
        OpenAmountLCY := TotalAmountLCY;
        ProfitLCY := pGenJnlLine."Profit (LCY)";
        SalesLCY := pGenJnlLine."Sales/Purch. (LCY)";
        RemainingProfit := ProfitLCY;
        RemainingSalesLCY := SalesLCY;

        Fractionation.SetRange("Payment Terms Code", pPaymentTermCode);
        if Fractionation.Find('-') then;
        NextDueDate := pGenJnlLine."Due Date";
        InitialDescription := pGenJnlLine.Description;
        for i := 1 to Fractionation.Count do begin
            pGenJnlLine.Description :=
              CopyStr(
                StrSubstNo('%1/%2 de %3', i, Fractionation.Count, InitialDescription),
                1,
                MaxStrLen(pGenJnlLine.Description));
            pGenJnlLine."Due Date" := NextDueDate;
            if i < Fractionation.Count then begin
                Fractionation.TestField("Fractionation %");
                TotalAmountPercent := Fractionation."Fractionation %";
                if i = 1 then
                    TotalPercent := Fractionation."Fractionation %"
                else begin
                    TotalPercent := TotalPercent + Fractionation."Fractionation %";
                    pGenJnlLine."Sales/Purch. (LCY)" := 0;
                    pGenJnlLine."Profit (LCY)" := 0;
                    pGenJnlLine."Sales/Purch. (LCY)" := 0;
                    pGenJnlLine."Inv. Discount (LCY)" := 0;
                end;
                if TotalPercent >= 100 then
                    Error(
                      TextFract,
                      Fractionation.FieldName("Fractionation %"),
                      pPaymentTermCode);
                pGenJnlLine.Amount := RoundingAmount(
                  TotalAmount * Fractionation."Fractionation %" / 100, InvoiceRounding);
                pGenJnlLine."Amount (LCY)" := RoundingAmountLCY(
                  TotalAmountLCY * Fractionation."Fractionation %" / 100, InvoiceRounding);
                RemainingAmount := RemainingAmount - pGenJnlLine.Amount;
                pGenJnlLine."Profit (LCY)" := RoundingAmountLCY(
                  ProfitLCY * Fractionation."Fractionation %" / 100, InvoiceRounding);
                pGenJnlLine."Sales/Purch. (LCY)" := RoundingAmountLCY(
                  SalesLCY * Fractionation."Fractionation %" / 100, InvoiceRounding);
                RemainingProfit := RemainingProfit - pGenJnlLine."Profit (LCY)";
                RemainingSalesLCY := RemainingSalesLCY - pGenJnlLine."Sales/Purch. (LCY)";
                OpenAmountLCY := OpenAmountLCY - pGenJnlLine."Amount (LCY)";
                Fractionation.TestField("Time between fractionation");
                NextDueDate := CalcDate(Fractionation."Time between fractionation", NextDueDate);
                /*
                //PMT_DIRECT
                    pGenJnlLine."Direct Payment" := Fractionation."Direct Payment";
                //PMT_DIRECT//
                */
                //RETENTION
                pGenJnlLine."Retention Code" := Fractionation."Retention Code";
                if pGenJnlLine."Retention Code" <> '' then begin
                    if ROUND(Fractionation."Fractionation %", 1) = Fractionation."Fractionation %" then
                        pGenJnlLine."On Hold" := Format(ROUND(Fractionation."Fractionation %", 1))
                    else
                        pGenJnlLine."On Hold" := CopyStr(Fractionation."Retention Code", 1, MaxStrLen(pGenJnlLine."On Hold"));
                end;
                //RETENTION//
                Fractionation.Next;
            end else begin
                TotalAmountPercent := 100;
                pGenJnlLine.Amount := RemainingAmount;
                pGenJnlLine."Amount (LCY)" := OpenAmountLCY;
                pGenJnlLine."Profit (LCY)" := RemainingProfit;
                pGenJnlLine."Sales/Purch. (LCY)" := RemainingSalesLCY;
                /*
                //PMT_DIRECT
                    pGenJnlLine."Direct Payment" := Fractionation."Direct Payment";
                //PMT_DIRECT//
                */
                //RETENTION
                pGenJnlLine."Retention Code" := Fractionation."Retention Code";
                if pGenJnlLine."Retention Code" <> '' then begin
                    if ROUND(Fractionation."Fractionation %", 1) = Fractionation."Fractionation %" then
                        pGenJnlLine."On Hold" := Format(ROUND(Fractionation."Fractionation %", 1))
                    else
                        pGenJnlLine."On Hold" := CopyStr(Fractionation."Retention Code", 1, MaxStrLen(pGenJnlLine."On Hold"));
                end;
                //RETENTION//
            end;
            //  pGenJnlLine."Sales/Purch. (LCY)" := pGenJnlLine."Amount (LCY)";

            //GL2024     pGenJnlPostLine.RunWithCheck(pGenJnlLine, pTempJnlLineDim);
            //GL2024
            pGenJnlPostLine.RunWithCheck(pGenJnlLine);
            //GL2024
        end;

    end;


    procedure RoundingAmount(Amount: Decimal; InvoiceRounding: Boolean): Decimal
    begin
        if InvoiceRounding then
            Amount := ROUND(
              Amount,
              Currency."Invoice Rounding Precision",
              SelectStr(Currency."Invoice Rounding Type" + 1, '=,>,<'))
        else
            Amount := ROUND(
              Amount,
              Currency."Amount Rounding Precision");

        exit(Amount);
    end;


    procedure RoundingAmountLCY(Amount: Decimal; InvoiceRounding: Boolean): Decimal
    begin
        if GLSetup."Amount Rounding Precision" = 0 then
            GLSetup."Amount Rounding Precision" := 0.01;
        if GLSetup."Unit-Amount Rounding Precision" = 0 then
            GLSetup."Unit-Amount Rounding Precision" := 0.00001;
        if InvoiceRounding then
            Amount := ROUND(
              Amount,
              GLSetup."Inv. Rounding Precision (LCY)",
              SelectStr(GLSetup."Inv. Rounding Type (LCY)" + 1, '=,>,<'))
        else
            Amount := ROUND(
              Amount,
              GLSetup."Amount Rounding Precision");

        exit(Amount);
    end;
}

