Codeunit 8003950 "Job Cost Specific Calculation"
{
    // //FRAIS CLA 11/02/05 Calculs spécifiques de répartition des frais directs
    //   Ce codeunit est dédié aux règles de gestion spécifiques
    //   Il peut être personalisé dans chaque base de données client


    trigger OnRun()
    begin
    end;


    procedure SpecificBasis(var pSalesLine: Record "Sales Line"): Decimal
    var
        lNumber: array[2] of Decimal;
    begin
        //CUSTOM
        //IF pSalesLine."Value 1" <> 0 THEN
        //  lNumber[1] := pSalesLine."Value 1"
        //ELSE
        //  lNumber[1] := pSalesLine.Quantity;
        lNumber[1] := pSalesLine."Quantity (Base)";

        if pSalesLine."Value 2" <> 0 then
            exit(lNumber[1] * pSalesLine."Value 2")
        else
            exit(pSalesLine."Total Cost (LCY)" + pSalesLine."Overhead Amount (LCY)" + pSalesLine."Theoretical Profit Amount(LCY)");
        //CUSTOM//
    end;


    procedure CalcSpecificValue(var pSalesLine: Record "Sales Line")
    var
        lNumber: array[10] of Decimal;
        lStructure: Record "Sales Line";
    begin
        /*
        //CUSTOM
        IF pSalesLine."Value 1" <> 0 THEN
          lNumber[1] := pSalesLine."Value 1"
        ELSE BEGIN
          lNumber[1] := pSalesLine.Quantity;
          pSalesLine."Value 1" := pSalesLine.Quantity;
        END;
        IF pSalesLine."Value 2" <> 0 THEN
          lNumber[2] := pSalesLine."Value 2"
        ELSE BEGIN
          lNumber[2] := pSalesLine."Unit Price";
          pSalesLine."Value 2" := pSalesLine."Unit Price";
        END;
        pSalesLine."Value 3" := lNumber[1] * lNumber[2];
        //CUSTOM//
        */

    end;
}

