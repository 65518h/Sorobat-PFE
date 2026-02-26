Codeunit 8004033 "Calc. Amount Management"
{
    // #7421 XPE 27/07/09 Modification de la fonction CalcAmount
    // //NAVIBAT AC 28/08/06 Gestion des montants libres


    trigger OnRun()
    begin
    end;

    var
        tFreeAmount: label 'Not Used';


    procedure SalesLineCalcAmount(var pSalesLine: Record "Sales Line"; var pAmount: array[10] of Decimal)
    var
        lSetupFormula: Record "Setup Formula Amount";
        lAmt: Decimal;
        lRecRef: RecordRef;
    begin
        lRecRef.GetTable(pSalesLine);
        CalcAmount(lRecRef, pAmount);
    end;


    procedure JobCalcAmount(var pJob: Record Job; var pAmount: array[10] of Decimal)
    var
        lSetupFormula: Record "Setup Formula Amount";
        lAmt: Decimal;
        lRecRef: RecordRef;
    begin
        lRecRef.GetTable(pJob);
        CalcAmount(lRecRef, pAmount);
    end;


    procedure ProdPostGrpCalcAmount(var pProdPostGrp: Record "Gen. Product Posting Group"; var pAmount: array[10] of Decimal)
    var
        lSetupFormula: Record "Setup Formula Amount";
        lAmt: Decimal;
        lRecRef: RecordRef;
    begin
        lRecRef.GetTable(pProdPostGrp);
        CalcAmount(lRecRef, pAmount);
    end;


    procedure EvaluateFormula(pFormula: Text[250]; pRecordRef: RecordRef; pRoundingPrecision: Decimal): Decimal
    var
        lPos: Integer;
        lFieldNo: Integer;
        lBasic: Codeunit Basic;
        lCalcQty: Codeunit "Calculate Quantity";
    begin
        Clear(lBasic);
        lBasic.SetRoundingPrecision(pRoundingPrecision);
        lBasic.SubstituteValues(pFormula, pRecordRef, '%', GlobalLanguage);
        lCalcQty.ConvertDefaultDecExpr(pFormula);
        exit(ROUND(lCalcQty.EvalExpression(pFormula, pFormula), pRoundingPrecision));
    end;


    procedure AmountGetCaptionClass(FieldNumber: Integer; TableNo: Integer): Text[80]
    var
        lSetupFormula: Record "Setup Formula Amount";
    begin
        if not lSetupFormula.Get(TableNo, FieldNumber) then
            lSetupFormula.Init;
        if lSetupFormula.Description = '' then
            lSetupFormula.Description := tFreeAmount;
        exit('8004050,' + lSetupFormula.Description);
    end;


    procedure CalcAmount(var pRecRef: RecordRef; var pAmount: array[10] of Decimal)
    var
        lSetupFormula: Record "Setup Formula Amount";
        lAmt: Decimal;
        lRecRef: RecordRef;
        lFormula: Text[250];
    begin
        Clear(pAmount);
        with lSetupFormula do begin
            SetRange("Table No.", pRecRef.Number);
            if not IsEmpty then
                Find('-');
            repeat
                lRecRef := pRecRef.Duplicate;
                if Formula <> '' then begin
                    //#7421
                    //pAmount["Column No."] := EvaluateFormula(Formula,lRecRef,"Rounding Precision");
                    lFormula := Formula;
                    pAmount["Column No."] := EvaluateFormula(lFormula, lRecRef, "Rounding Precision");
                    //#7421//
                end;
            until Next = 0;
        end;
    end;
}

