Codeunit 8004051 "Calculate Quantity"
{
    // //DEVIS GESWAY 10/01/03 Calcul de la quantité du devis
    // //FRAIS CLA 17/02/05 Calculer l'assiette
    // //PERF AC 03/04/06


    trigger OnRun()
    var
        lRec: Record "Sales Line";
        lSetupFormula: Record "Setup Formula Amount";
    begin
    end;

    var
        NiveauAppel: Integer;
        ErrorFormule2: label 'Circular reference, Navision Fiancial can  t compute this formula : %1';
        Col_Resultat: array[250] of Decimal;
        ErrorFormule1: label 'Bad value or column number not defined : %1';
        Basic: Codeunit Basic;
        SetupFormula: Record "Setup Formula Amount";
        tFilterSubstitution: label '#FILTERFILTER#';


    procedure EvalExpression(Expression: Text[250]; Formule: Text[250]): Decimal
    var
        ResultatFormule: Decimal;
        Parentheses: Integer;
        Operateur: Char;
        OperateurGauche: Text[80];
        OperateurDroit: Text[80];
        ResultatGauche: Decimal;
        ResultatDroit: Decimal;
        i: Integer;
        EstExpression: Boolean;
        EstFiltre: Boolean;
        Operateurs: Text[8];
        NumeroOperateur: Integer;
        Trouveformule: Boolean;
        TexteErreurFormule: Text[250];
        ErreurDivision: Boolean;
        j: Integer;
    begin
        ResultatFormule := 0;

        NiveauAppel := NiveauAppel + 1;
        if NiveauAppel > 25 then
            TexteErreurFormule := StrSubstNo(ErrorFormule2, Formule);

        while (StrLen(Expression) > 1) and (Expression[1] = ' ') do
            Expression := CopyStr(Expression, 2);
        if Expression <> '' then
            while (StrLen(Expression) > 1) and (Expression[StrLen(Expression)] = ' ') do
                Expression := CopyStr(Expression, 1, StrLen(Expression) - 1);
        if StrLen(Expression) > 0 then begin
            Parentheses := 0;
            EstExpression := false;
            Operateurs := '+-*/^';
            NumeroOperateur := 1;
            repeat
                i := StrLen(Expression);
                repeat
                    if Expression[i] = '(' then
                        Parentheses := Parentheses + 1
                    else
                        if Expression[i] = ')' then
                            Parentheses := Parentheses - 1;
                    if (Parentheses = 0) and (Expression[i] = Operateurs[NumeroOperateur]) then
                        EstExpression := true
                    else
                        i := i - 1;
                until EstExpression or (i <= 0);
                if not EstExpression then
                    NumeroOperateur := NumeroOperateur + 1;
            until (NumeroOperateur > StrLen(Operateurs)) or EstExpression;
            if EstExpression then begin
                if i > 1 then
                    OperateurGauche := CopyStr(Expression, 1, i - 1)
                else
                    OperateurGauche := '';
                if i < StrLen(Expression) then
                    OperateurDroit := CopyStr(Expression, i + 1)
                else
                    OperateurDroit := '';
                Operateur := Expression[i];
                ResultatGauche := EvalExpression(OperateurGauche, Formule);
                ResultatDroit := EvalExpression(OperateurDroit, Formule);
                /*CW 21/02/06
                    ResultatGauche := ROUND(ResultatGauche,SetupFormula."Rounding Precision");
                    ResultatDroit := ROUND(ResultatDroit,SetupFormula."Rounding Precision");
                */
                case Operateur of
                    '^':
                        ResultatFormule := Power(ResultatGauche, ResultatDroit);
                    '*':
                        ResultatFormule := ResultatGauche * ResultatDroit;
                    '/':
                        if ResultatDroit = 0 then begin
                            ResultatFormule := 0;
                            ErreurDivision := true;
                        end else
                            ResultatFormule := ResultatGauche / ResultatDroit;
                    '+':
                        ResultatFormule := ResultatGauche + ResultatDroit;
                    '-':
                        ResultatFormule := ResultatGauche - ResultatDroit;
                end;
            end else
                if (Expression[1] = '(') and (Expression[StrLen(Expression)] = ')') then
                    ResultatFormule := EvalExpression(CopyStr(Expression, 2, StrLen(Expression) - 2), Formule)
                else begin
                    EstFiltre :=
                      (StrPos(Expression, '..') +
                       StrPos(Expression, '|') +
                       StrPos(Expression, '<') +
                       StrPos(Expression, '>') +
                       StrPos(Expression, '=') > 0);
                    if (StrLen(Expression) > 10) and (not EstFiltre) then
                        Evaluate(ResultatFormule, Expression)
                    else begin
                        j := 0;
                        Trouveformule := false;
                        repeat
                            j := j + 1;
                            if ('%' + Format(j) = Expression) then begin
                                ResultatFormule := ResultatFormule + Col_Resultat[j];
                                Trouveformule := true;
                            end;
                        until (j = 10);
                        if not Trouveformule then
                            if EstFiltre or (not Evaluate(ResultatFormule, Expression)) then
                                TexteErreurFormule := StrSubstNo(ErrorFormule1, Expression);
                    end;
                end;
        end;
        /*CW 21/02/06
        ResultatFormule := ROUND(ResultatFormule,SetupFormula."Rounding Precision");
        */
        NiveauAppel := NiveauAppel - 1;
        if TexteErreurFormule <> '' then
            Error(TexteErreurFormule);
        exit(ResultatFormule);

    end;


    procedure wCalcQty(var pSalesLine: Record "Sales Line"; pFieldNo: Integer)
    var
        lCalcQty: Codeunit "Calculate Quantity";
        lQty: Decimal;
        lQtySetup: Record "Quantity Setup";
        lStructureMgt: Codeunit "Structure Management";
        lRec: Record "Sales Line";
        lRecRef: RecordRef;
        lBOQCustMgt: Codeunit "BOQ Custom Management";
        lNaviBatSetup: Record NavibatSetup;
    begin
        if lQtySetup.Get then begin
            //#7357
            lNaviBatSetup.GET2;
            //#7357//
            //#4946
            //#6098  IF (pSalesLine."Line Type" = pSalesLine."Line Type"::" ") THEN
            if (pSalesLine.Type = pSalesLine.Type::" ") then
                //#6098//
                exit;
            if not lQtySetup."Formula desactivated / Sales" or (pSalesLine."Order Type" = pSalesLine."order type"::"Supply Order") then begin
                if (pSalesLine."Order Type" <> pSalesLine."order type"::"Supply Order") and
                    (pSalesLine."Rate Quantity" <> 0) and (pSalesLine.Rate <> 0) then begin
                    //      pSalesLine.CALCFIELDS("Bill of Quantities");

                    pSalesLine.TestField("Rate Quantity", 0);
                end;
            end
            else begin
                //#7357
                if not lRec.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Line No.") then
                    exit;
                if pSalesLine.Modify then;
                if not lNaviBatSetup."Disable BOQ Calculation" then begin
                    lRecRef.GetTable(pSalesLine);
                    //#7918 lBOQCustMgt.fCalcBOQRef(lRecRef,TRUE,TRUE);
                    if (pSalesLine."Structure Line No." <> 0) and
                      lRec.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Structure Line No.") then begin
                        if fGetTotalisation(lQtySetup, pFieldNo) then begin
                            lStructureMgt.SumStructureLines(lRec);
                            lRec.Modify;
                        end;
                        lRecRef.GetTable(lRec);
                        lBOQCustMgt.fCalcBOQRef(lRecRef, true, true);
                        lRecRef.SetTable(lRec);
                    end else begin
                        //#8281
                        lBOQCustMgt.fCalcBOQRef(lRecRef, true, true);
                        //#8281//
                    end;
                end else
                    if (pSalesLine."Structure Line No." <> 0) and
               lRec.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Structure Line No.") then begin
                        lStructureMgt.SumStructureLines(lRec);
                    end;
                //#7357//
                if pSalesLine.Get(pSalesLine."Document Type", pSalesLine."Document No.", pSalesLine."Line No.") then;
                exit;
            end;
            if not (pFieldNo in [8004066 .. 8004075]) then
                exit;
            //#4946//
            if (lQtySetup."Value 1 Name" = '') or (lQtySetup."Used in 1" = lQtySetup."used in 1"::Purchases) then
                pSalesLine."Value 1" := 0;
            if (lQtySetup."Value 2 Name" = '') or (lQtySetup."Used in 2" = lQtySetup."used in 2"::Purchases) then
                pSalesLine."Value 2" := 0;
            if (lQtySetup."Value 3 Name" = '') or (lQtySetup."Used in 3" = lQtySetup."used in 3"::Purchases) then
                pSalesLine."Value 3" := 0;
            if (lQtySetup."Value 4 Name" = '') or (lQtySetup."Used in 4" = lQtySetup."used in 4"::Purchases) then
                pSalesLine."Value 4" := 0;
            if (lQtySetup."Value 5 Name" = '') or (lQtySetup."Used in 5" = lQtySetup."used in 5"::Purchases) then
                pSalesLine."Value 5" := 0;
            if (lQtySetup."Value 6 Name" = '') or (lQtySetup."Used in 6" = lQtySetup."used in 6"::Purchases) then
                pSalesLine."Value 6" := 0;
            if (lQtySetup."Value 7 Name" = '') or (lQtySetup."Used in 7" = lQtySetup."used in 7"::Purchases) then
                pSalesLine."Value 7" := 0;
            if (lQtySetup."Value 8 Name" = '') or (lQtySetup."Used in 8" = lQtySetup."used in 8"::Purchases) then
                pSalesLine."Value 8" := 0;
            if (lQtySetup."Value 9 Name" = '') or (lQtySetup."Used in 9" = lQtySetup."used in 9"::Purchases) then
                pSalesLine."Value 9" := 0;
            if (lQtySetup."Value 10 Name" = '') or (lQtySetup."Used in 10" = lQtySetup."used in 10"::Purchases) then
                pSalesLine."Value 10" := 0;

            lQty := pSalesLine.Quantity;
            if (lQtySetup."Value Formula" <> '') then begin
                lCalcQty.CreerTableauColonnesSales(pSalesLine, lQtySetup);
                if pSalesLine."Structure Line No." = 0 then begin
                    if not pSalesLine.Option then begin
                        //IF pSalesLine.Quantity = pSalesLine."Quantity (Base)" THEN
                        //  pSalesLine."Quantity (Base)" := 0;
                        pSalesLine.Validate(Quantity,
                              lRoundingFormula(lCalcQty.EvalExpression(lQtySetup."Value Formula",
                              lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule"));
                    end
                    else begin
                        //IF pSalesLine."Optionnal Quantity" = pSalesLine."Quantity (Base)" THEN
                        //  pSalesLine."Quantity (Base)" := 0;
                        pSalesLine."Optionnal Quantity" := 0;
                        pSalesLine.Validate(Quantity,
                              lRoundingFormula(lCalcQty.EvalExpression(lQtySetup."Value Formula",
                              lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule"));
                        pSalesLine."Optionnal Quantity" := pSalesLine.Quantity;
                        pSalesLine.Quantity := 0;
                    end;
                end
                else
                    pSalesLine.Validate("Quantity per",
                          lRoundingFormula(lCalcQty.EvalExpression(lQtySetup."Value Formula",
                          lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule"));

            end
            //FRAIS
            else
                pSalesLine.Validate("Quantity (Base)");
            //FRAIS//
            //#6780
            /*IF pSalesLine.Quantity = 0 THEN
              pSalesLine.Quantity := lQty
            ELSE
              pSalesLine.VALIDATE(Quantity, lQty);
            */
            //#6780//
        end else begin
            pSalesLine."Value 1" := 0;
            pSalesLine."Value 2" := 0;
            pSalesLine."Value 3" := 0;
            pSalesLine."Value 4" := 0;
            pSalesLine."Value 5" := 0;
            pSalesLine."Value 6" := 0;
            pSalesLine."Value 7" := 0;
            pSalesLine."Value 8" := 0;
            pSalesLine."Value 9" := 0;
            pSalesLine."Value 10" := 0;
        end;

    end;


    procedure wCalcQtyBOMItem(var pBOM: Record "BOM Component")
    var
        lCalcQty: Codeunit "Calculate Quantity";
        lQty: Decimal;
        lQtySetup: Record "Quantity Setup";
    begin
        if lQtySetup.Get then begin
            if (lQtySetup."Value 1 Name" = '') or (lQtySetup."Used in 1" = lQtySetup."used in 1"::Purchases) then
                pBOM."Value 1" := 0;
            if (lQtySetup."Value 2 Name" = '') or (lQtySetup."Used in 2" = lQtySetup."used in 2"::Purchases) then
                pBOM."Value 2" := 0;
            if (lQtySetup."Value 3 Name" = '') or (lQtySetup."Used in 3" = lQtySetup."used in 3"::Purchases) then
                pBOM."Value 3" := 0;
            if (lQtySetup."Value 4 Name" = '') or (lQtySetup."Used in 4" = lQtySetup."used in 4"::Purchases) then
                pBOM."Value 4" := 0;
            if (lQtySetup."Value 5 Name" = '') or (lQtySetup."Used in 5" = lQtySetup."used in 5"::Purchases) then
                pBOM."Value 5" := 0;
            if (lQtySetup."Value 6 Name" = '') or (lQtySetup."Used in 6" = lQtySetup."used in 6"::Purchases) then
                pBOM."Value 6" := 0;
            if (lQtySetup."Value 7 Name" = '') or (lQtySetup."Used in 7" = lQtySetup."used in 7"::Purchases) then
                pBOM."Value 7" := 0;
            if (lQtySetup."Value 8 Name" = '') or (lQtySetup."Used in 8" = lQtySetup."used in 8"::Purchases) then
                pBOM."Value 8" := 0;
            if (lQtySetup."Value 9 Name" = '') or (lQtySetup."Used in 9" = lQtySetup."used in 9"::Purchases) then
                pBOM."Value 9" := 0;
            if (lQtySetup."Value 10 Name" = '') or (lQtySetup."Used in 10" = lQtySetup."used in 10"::Purchases) then
                pBOM."Value 10" := 0;

            lQty := pBOM."Quantity per";
            if lQtySetup."Value Formula" <> '' then begin
                lCalcQty.wCreerTableauColonnesBOMItem(pBOM, lQtySetup);
                pBOM.Validate("Quantity per",
                    lRoundingFormula(lCalcQty.EvalExpression(lQtySetup."Value Formula",
                    lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule"));
            end;
            if (pBOM."Quantity per" = 0) and (lQty <> 0) then
                pBOM.Validate("Quantity per", lQty);
        end else begin
            pBOM."Value 1" := 0;
            pBOM."Value 2" := 0;
            pBOM."Value 3" := 0;
            pBOM."Value 4" := 0;
            pBOM."Value 5" := 0;
            pBOM."Value 6" := 0;
            pBOM."Value 7" := 0;
            pBOM."Value 8" := 0;
            pBOM."Value 9" := 0;
            pBOM."Value 10" := 0;
        end;
    end;


    procedure CreerTableauColonnesBOM2(BOM: Record "BOM Component"; var pQtySetup: Record "Quantity Setup")
    begin
        // Création d'un tableau de 250 postes avec présentation des colonnes
        with BOM do begin
            Clear(Col_Resultat);
            if ("Value 1" = 0) and ("Value 2" = 0) and ("Value 3" = 0) and ("Value 4" = 0) and ("Value 5" = 0) and
               ("Value 6" = 0) and ("Value 7" = 0) and ("Value 8" = 0) and ("Value 9" = 0) and ("Value 10" = 0) then
                exit;
            if ("Value 1" = 0) and (pQtySetup."Value 1 Default" <> 0) then
                Col_Resultat[1] := pQtySetup."Value 1 Default"
            else
                Col_Resultat[1] := "Value 1";
            if ("Value 2" = 0) and (pQtySetup."Value 2 Default" <> 0) then
                Col_Resultat[2] := pQtySetup."Value 2 Default"
            else
                Col_Resultat[2] := "Value 2";
            if ("Value 3" = 0) and (pQtySetup."Value 3 Default" <> 0) then
                Col_Resultat[3] := pQtySetup."Value 3 Default"
            else
                Col_Resultat[3] := "Value 3";
            if ("Value 4" = 0) and (pQtySetup."Value 4 Default" <> 0) then
                Col_Resultat[4] := pQtySetup."Value 4 Default"
            else
                Col_Resultat[4] := "Value 4";
            if ("Value 5" = 0) and (pQtySetup."Value 5 Default" <> 0) then
                Col_Resultat[5] := pQtySetup."Value 5 Default"
            else
                Col_Resultat[5] := "Value 5";
            if ("Value 6" = 0) and (pQtySetup."Value 6 Default" <> 0) then
                Col_Resultat[6] := pQtySetup."Value 6 Default"
            else
                Col_Resultat[6] := "Value 6";
            if ("Value 7" = 0) and (pQtySetup."Value 7 Default" <> 0) then
                Col_Resultat[7] := pQtySetup."Value 7 Default"
            else
                Col_Resultat[7] := "Value 7";
            if ("Value 8" = 0) and (pQtySetup."Value 8 Default" <> 0) then
                Col_Resultat[8] := pQtySetup."Value 8 Default"
            else
                Col_Resultat[8] := "Value 8";
            if ("Value 9" = 0) and (pQtySetup."Value 9 Default" <> 0) then
                Col_Resultat[9] := pQtySetup."Value 9 Default"
            else
                Col_Resultat[9] := "Value 9";
            if ("Value 10" = 0) and (pQtySetup."Value 10 Default" <> 0) then
                Col_Resultat[10] := pQtySetup."Value 10 Default"
            else
                Col_Resultat[10] := "Value 10";
        end;
    end;


    procedure wCreerTableauColonnesBOMItem(BOM: Record "BOM Component"; var pQtySetup: Record "Quantity Setup")
    begin
        with BOM do begin
            Clear(Col_Resultat);
            if ("Value 1" = 0) and ("Value 2" = 0) and ("Value 3" = 0) and ("Value 4" = 0) and ("Value 5" = 0) and
               ("Value 6" = 0) and ("Value 7" = 0) and ("Value 8" = 0) and ("Value 9" = 0) and ("Value 10" = 0) then
                exit;
            if ("Value 1" = 0) and (pQtySetup."Value 1 Default" <> 0) then
                Col_Resultat[1] := pQtySetup."Value 1 Default"
            else
                Col_Resultat[1] := "Value 1";
            if ("Value 2" = 0) and (pQtySetup."Value 2 Default" <> 0) then
                Col_Resultat[2] := pQtySetup."Value 2 Default"
            else
                Col_Resultat[2] := "Value 2";
            if ("Value 3" = 0) and (pQtySetup."Value 3 Default" <> 0) then
                Col_Resultat[3] := pQtySetup."Value 3 Default"
            else
                Col_Resultat[3] := "Value 3";
            if ("Value 4" = 0) and (pQtySetup."Value 4 Default" <> 0) then
                Col_Resultat[4] := pQtySetup."Value 4 Default"
            else
                Col_Resultat[4] := "Value 4";
            if ("Value 5" = 0) and (pQtySetup."Value 5 Default" <> 0) then
                Col_Resultat[5] := pQtySetup."Value 5 Default"
            else
                Col_Resultat[5] := "Value 5";
            if ("Value 6" = 0) and (pQtySetup."Value 6 Default" <> 0) then
                Col_Resultat[6] := pQtySetup."Value 6 Default"
            else
                Col_Resultat[6] := "Value 6";
            if ("Value 7" = 0) and (pQtySetup."Value 7 Default" <> 0) then
                Col_Resultat[7] := pQtySetup."Value 7 Default"
            else
                Col_Resultat[7] := "Value 7";
            if ("Value 8" = 0) and (pQtySetup."Value 8 Default" <> 0) then
                Col_Resultat[8] := pQtySetup."Value 8 Default"
            else
                Col_Resultat[8] := "Value 8";
            if ("Value 9" = 0) and (pQtySetup."Value 9 Default" <> 0) then
                Col_Resultat[9] := pQtySetup."Value 9 Default"
            else
                Col_Resultat[9] := "Value 9";
            if ("Value 10" = 0) and (pQtySetup."Value 10 Default" <> 0) then
                Col_Resultat[10] := pQtySetup."Value 10 Default"
            else
                Col_Resultat[10] := "Value 10";
        end;
    end;


    procedure wCalcQtyStructure(var pBOM: Record "Structure Component")
    var
        lCalcQty: Codeunit "Calculate Quantity";
        lQty: Decimal;
        lQtySetup: Record "Quantity Setup";
    begin
        //OUVRAGE
        if lQtySetup.Get then begin
            //#4946
            if not lQtySetup."Formula desactivated / Sales" then begin
                //      pBOM.CALCFIELDS("Bill of quantities");
                //      pBOM.TESTFIELD("Bill of quantities",FALSE);

            end
            else
                exit;
            //#4946//
            if (lQtySetup."Value 1 Name" = '') or (lQtySetup."Used in 1" = lQtySetup."used in 1"::Purchases) then
                pBOM."Value 1" := 0;
            if (lQtySetup."Value 2 Name" = '') or (lQtySetup."Used in 2" = lQtySetup."used in 2"::Purchases) then
                pBOM."Value 2" := 0;
            if (lQtySetup."Value 3 Name" = '') or (lQtySetup."Used in 3" = lQtySetup."used in 3"::Purchases) then
                pBOM."Value 3" := 0;
            if (lQtySetup."Value 4 Name" = '') or (lQtySetup."Used in 4" = lQtySetup."used in 4"::Purchases) then
                pBOM."Value 4" := 0;
            if (lQtySetup."Value 5 Name" = '') or (lQtySetup."Used in 5" = lQtySetup."used in 5"::Purchases) then
                pBOM."Value 5" := 0;
            if (lQtySetup."Value 6 Name" = '') or (lQtySetup."Used in 6" = lQtySetup."used in 6"::Purchases) then
                pBOM."Value 6" := 0;
            if (lQtySetup."Value 7 Name" = '') or (lQtySetup."Used in 7" = lQtySetup."used in 7"::Purchases) then
                pBOM."Value 7" := 0;
            if (lQtySetup."Value 8 Name" = '') or (lQtySetup."Used in 8" = lQtySetup."used in 8"::Purchases) then
                pBOM."Value 8" := 0;
            if (lQtySetup."Value 9 Name" = '') or (lQtySetup."Used in 9" = lQtySetup."used in 9"::Purchases) then
                pBOM."Value 9" := 0;
            if (lQtySetup."Value 10 Name" = '') or (lQtySetup."Used in 10" = lQtySetup."used in 10"::Purchases) then
                pBOM."Value 10" := 0;

            lQty := pBOM."Quantity per";
            if lQtySetup."Value Formula" <> '' then begin
                lCalcQty.wCreerTableauColonnesStructure(pBOM, lQtySetup);
                pBOM.Validate("Quantity per",
                    lRoundingFormula(lCalcQty.EvalExpression(lQtySetup."Value Formula",
                    lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule"));
            end;
            //  IF pBOM."Quantity per" = 0 THEN
            //    pBOM.VALIDATE("Quantity per",lQty);
        end else begin
            pBOM."Value 1" := 0;
            pBOM."Value 2" := 0;
            pBOM."Value 3" := 0;
            pBOM."Value 4" := 0;
            pBOM."Value 5" := 0;
            pBOM."Value 6" := 0;
            pBOM."Value 7" := 0;
            pBOM."Value 8" := 0;
            pBOM."Value 9" := 0;
            pBOM."Value 10" := 0;
        end;
        //OUVRAGE//
    end;


    procedure wCreerTableauColonnesStructure(BOM: Record "Structure Component"; var pQtySetup: Record "Quantity Setup")
    begin
        //OUVRAGE
        with BOM do begin
            Clear(Col_Resultat);
            if ("Value 1" = 0) and ("Value 2" = 0) and ("Value 3" = 0) and ("Value 4" = 0) and ("Value 5" = 0) and
               ("Value 6" = 0) and ("Value 7" = 0) and ("Value 8" = 0) and ("Value 9" = 0) and ("Value 10" = 0) then
                exit;
            if ("Value 1" = 0) and (pQtySetup."Value 1 Default" <> 0) then
                Col_Resultat[1] := pQtySetup."Value 1 Default"
            else
                Col_Resultat[1] := "Value 1";
            if ("Value 2" = 0) and (pQtySetup."Value 2 Default" <> 0) then
                Col_Resultat[2] := pQtySetup."Value 2 Default"
            else
                Col_Resultat[2] := "Value 2";
            if ("Value 3" = 0) and (pQtySetup."Value 3 Default" <> 0) then
                Col_Resultat[3] := pQtySetup."Value 3 Default"
            else
                Col_Resultat[3] := "Value 3";
            if ("Value 4" = 0) and (pQtySetup."Value 4 Default" <> 0) then
                Col_Resultat[4] := pQtySetup."Value 4 Default"
            else
                Col_Resultat[4] := "Value 4";
            if ("Value 5" = 0) and (pQtySetup."Value 5 Default" <> 0) then
                Col_Resultat[5] := pQtySetup."Value 5 Default"
            else
                Col_Resultat[5] := "Value 5";
            if ("Value 6" = 0) and (pQtySetup."Value 6 Default" <> 0) then
                Col_Resultat[6] := pQtySetup."Value 6 Default"
            else
                Col_Resultat[6] := "Value 6";
            if ("Value 7" = 0) and (pQtySetup."Value 7 Default" <> 0) then
                Col_Resultat[7] := pQtySetup."Value 7 Default"
            else
                Col_Resultat[7] := "Value 7";
            if ("Value 8" = 0) and (pQtySetup."Value 8 Default" <> 0) then
                Col_Resultat[8] := pQtySetup."Value 8 Default"
            else
                Col_Resultat[8] := "Value 8";
            if ("Value 9" = 0) and (pQtySetup."Value 9 Default" <> 0) then
                Col_Resultat[9] := pQtySetup."Value 9 Default"
            else
                Col_Resultat[9] := "Value 9";
            if ("Value 10" = 0) and (pQtySetup."Value 10 Default" <> 0) then
                Col_Resultat[10] := pQtySetup."Value 10 Default"
            else
                Col_Resultat[10] := "Value 10";
        end;
        //OUVRAGE//
    end;


    procedure EvaluateFormula(pFormula: Text[250]; pRecordRef: RecordRef; pRoundingPrecision: Decimal): Decimal
    var
        lPos: Integer;
        lFieldNo: Integer;
    begin
        if pRoundingPrecision = 0 then begin
            Clear(Basic);
            Basic.SetRoundingPrecision(pRoundingPrecision);
        end;
        Basic.SubstituteValues(pFormula, pRecordRef, '%', GlobalLanguage);
        exit(ROUND(EvalExpression(pFormula, pFormula), pRoundingPrecision));
    end;


    procedure wCalcPurchQty(var pPurchLine: Record "Purchase Line")
    var
        lCalcQty: Codeunit "Calculate Quantity";
        lQtySetup: Record "Quantity Setup";
        lQty: Decimal;
    begin
        if lQtySetup.Get then begin
            if (lQtySetup."Value 1 Name" = '') or (lQtySetup."Used in 1" = lQtySetup."used in 1"::Sales) then
                pPurchLine."Value 1" := 0;
            if (lQtySetup."Value 2 Name" = '') or (lQtySetup."Used in 2" = lQtySetup."used in 2"::Sales) then
                pPurchLine."Value 2" := 0;
            if (lQtySetup."Value 3 Name" = '') or (lQtySetup."Used in 3" = lQtySetup."used in 3"::Sales) then
                pPurchLine."Value 3" := 0;
            if (lQtySetup."Value 4 Name" = '') or (lQtySetup."Used in 4" = lQtySetup."used in 4"::Sales) then
                pPurchLine."Value 4" := 0;
            if (lQtySetup."Value 5 Name" = '') or (lQtySetup."Used in 5" = lQtySetup."used in 5"::Sales) then
                pPurchLine."Value 5" := 0;
            if (lQtySetup."Value 6 Name" = '') or (lQtySetup."Used in 6" = lQtySetup."used in 6"::Sales) then
                pPurchLine."Value 6" := 0;
            if (lQtySetup."Value 7 Name" = '') or (lQtySetup."Used in 7" = lQtySetup."used in 7"::Sales) then
                pPurchLine."Value 7" := 0;
            if (lQtySetup."Value 8 Name" = '') or (lQtySetup."Used in 8" = lQtySetup."used in 8"::Sales) then
                pPurchLine."Value 8" := 0;
            if (lQtySetup."Value 9 Name" = '') or (lQtySetup."Used in 9" = lQtySetup."used in 9"::Sales) then
                pPurchLine."Value 9" := 0;
            if (lQtySetup."Value 10 Name" = '') or (lQtySetup."Used in 10" = lQtySetup."used in 10"::Sales) then
                pPurchLine."Value 10" := 0;

            lQty := pPurchLine.Quantity;
            if lQtySetup."Value Formula" <> '' then begin
                lCalcQty.CreerTableauColonnesPurch(pPurchLine, lQtySetup);
                pPurchLine.Validate(Quantity,
                       lRoundingFormula(lCalcQty.EvalExpression(lQtySetup."Value Formula",
                       lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule"))
            end;
            if pPurchLine.Quantity = 0 then
                pPurchLine.Quantity := lQty;
        end else begin
            pPurchLine."Value 1" := 0;
            pPurchLine."Value 2" := 0;
            pPurchLine."Value 3" := 0;
            pPurchLine."Value 4" := 0;
            pPurchLine."Value 5" := 0;
            pPurchLine."Value 6" := 0;
            pPurchLine."Value 7" := 0;
            pPurchLine."Value 8" := 0;
            pPurchLine."Value 9" := 0;
            pPurchLine."Value 10" := 0;
        end;
    end;


    procedure CreerTableauColonnesPurch(PurchLine: Record "Purchase Line"; var pQtySetup: Record "Quantity Setup")
    begin
        with PurchLine do begin
            Clear(Col_Resultat);
            if ("Value 1" = 0) and ("Value 2" = 0) and ("Value 3" = 0) and ("Value 4" = 0) and ("Value 5" = 0) and
               ("Value 6" = 0) and ("Value 7" = 0) and ("Value 8" = 0) and ("Value 9" = 0) and ("Value 10" = 0) then
                exit;
            if ("Value 1" = 0) and (pQtySetup."Value 1 Default" <> 0) then
                Col_Resultat[1] := pQtySetup."Value 1 Default"
            else
                Col_Resultat[1] := "Value 1";
            if ("Value 2" = 0) and (pQtySetup."Value 2 Default" <> 0) then
                Col_Resultat[2] := pQtySetup."Value 2 Default"
            else
                Col_Resultat[2] := "Value 2";
            if ("Value 3" = 0) and (pQtySetup."Value 3 Default" <> 0) then
                Col_Resultat[3] := pQtySetup."Value 3 Default"
            else
                Col_Resultat[3] := "Value 3";
            if ("Value 4" = 0) and (pQtySetup."Value 4 Default" <> 0) then
                Col_Resultat[4] := pQtySetup."Value 4 Default"
            else
                Col_Resultat[4] := "Value 4";
            if ("Value 5" = 0) and (pQtySetup."Value 5 Default" <> 0) then
                Col_Resultat[5] := pQtySetup."Value 5 Default"
            else
                Col_Resultat[5] := "Value 5";
            if ("Value 6" = 0) and (pQtySetup."Value 6 Default" <> 0) then
                Col_Resultat[6] := pQtySetup."Value 6 Default"
            else
                Col_Resultat[6] := "Value 6";
            if ("Value 7" = 0) and (pQtySetup."Value 7 Default" <> 0) then
                Col_Resultat[7] := pQtySetup."Value 7 Default"
            else
                Col_Resultat[7] := "Value 7";
            if ("Value 8" = 0) and (pQtySetup."Value 8 Default" <> 0) then
                Col_Resultat[8] := pQtySetup."Value 8 Default"
            else
                Col_Resultat[8] := "Value 8";
            if ("Value 9" = 0) and (pQtySetup."Value 9 Default" <> 0) then
                Col_Resultat[9] := pQtySetup."Value 9 Default"
            else
                Col_Resultat[9] := "Value 9";
            if ("Value 10" = 0) and (pQtySetup."Value 10 Default" <> 0) then
                Col_Resultat[10] := pQtySetup."Value 10 Default"
            else
                Col_Resultat[10] := "Value 10";
        end;
    end;


    procedure CreerTableauColonnesSales(SalesLine: Record "Sales Line"; var pQtySetup: Record "Quantity Setup")
    begin
        with SalesLine do begin
            Clear(Col_Resultat);
            if ("Value 1" = 0) and ("Value 2" = 0) and ("Value 3" = 0) and ("Value 4" = 0) and ("Value 5" = 0) and
               ("Value 6" = 0) and ("Value 7" = 0) and ("Value 8" = 0) and ("Value 9" = 0) and ("Value 10" = 0) then
                exit;
            if ("Value 1" = 0) and (pQtySetup."Value 1 Default" <> 0) then
                Col_Resultat[1] := pQtySetup."Value 1 Default"
            else
                Col_Resultat[1] := "Value 1";
            if ("Value 2" = 0) and (pQtySetup."Value 2 Default" <> 0) then
                Col_Resultat[2] := pQtySetup."Value 2 Default"
            else
                Col_Resultat[2] := "Value 2";
            if ("Value 3" = 0) and (pQtySetup."Value 3 Default" <> 0) then
                Col_Resultat[3] := pQtySetup."Value 3 Default"
            else
                Col_Resultat[3] := "Value 3";
            if ("Value 4" = 0) and (pQtySetup."Value 4 Default" <> 0) then
                Col_Resultat[4] := pQtySetup."Value 4 Default"
            else
                Col_Resultat[4] := "Value 4";
            if ("Value 5" = 0) and (pQtySetup."Value 5 Default" <> 0) then
                Col_Resultat[5] := pQtySetup."Value 5 Default"
            else
                Col_Resultat[5] := "Value 5";
            if ("Value 6" = 0) and (pQtySetup."Value 6 Default" <> 0) then
                Col_Resultat[6] := pQtySetup."Value 6 Default"
            else
                Col_Resultat[6] := "Value 6";
            if ("Value 7" = 0) and (pQtySetup."Value 7 Default" <> 0) then
                Col_Resultat[7] := pQtySetup."Value 7 Default"
            else
                Col_Resultat[7] := "Value 7";
            if ("Value 8" = 0) and (pQtySetup."Value 8 Default" <> 0) then
                Col_Resultat[8] := pQtySetup."Value 8 Default"
            else
                Col_Resultat[8] := "Value 8";
            if ("Value 9" = 0) and (pQtySetup."Value 9 Default" <> 0) then
                Col_Resultat[9] := pQtySetup."Value 9 Default"
            else
                Col_Resultat[9] := "Value 9";
            if ("Value 10" = 0) and (pQtySetup."Value 10 Default" <> 0) then
                Col_Resultat[10] := pQtySetup."Value 10 Default"
            else
                Col_Resultat[10] := "Value 10";
        end;
    end;


    procedure GetDefaultSeparator(): Char
    var
        lDec: Decimal;
    begin
        lDec := 0.01;
        if StrPos(Format(lDec), '.') > 0 then
            exit('.');
        exit(',');
    end;


    procedure ConvertDefaultDecExpr(var pExpression: Text[1024])
    begin
        case GetDefaultSeparator of
            '.':
                pExpression := ConvertStr(pExpression, ',', '.');
            ',':
                begin
                    pExpression := Basic.StrReplace(pExpression, '..', tFilterSubstitution, true, true);
                    pExpression := ConvertStr(pExpression, '.', ',');
                    pExpression := Basic.StrReplace(pExpression, tFilterSubstitution, '..', true, true);
                end;
        end;
    end;

    local procedure lRoundingFormula(pValue: Decimal; pRoundingPrecision: Decimal): Decimal
    var
        lPos: Integer;
        lFieldNo: Integer;
        lGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if pRoundingPrecision = 0 then begin
            lGeneralLedgerSetup.Get;
            pRoundingPrecision := lGeneralLedgerSetup."Amount Rounding Precision";
        end;
        exit(ROUND(pValue, pRoundingPrecision));
    end;


    procedure fGetSalesCalcQty(pSalesLine: Record "Sales Line") return: Decimal
    var
        lQtySetup: Record "Quantity Setup";
    begin
        //#6767
        return := 0;
        if lQtySetup.Get then begin
            if (pSalesLine.Type = pSalesLine.Type::" ") then
                exit(0);
            return := pSalesLine.Quantity;
            if (lQtySetup."Value Formula" <> '') then begin
                CreerTableauColonnesSales(pSalesLine, lQtySetup);
                if pSalesLine."Structure Line No." = 0 then begin
                    if not pSalesLine.Option then begin
                        return := lRoundingFormula(EvalExpression(lQtySetup."Value Formula",
                                  lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule");
                    end
                    else begin
                        return := lRoundingFormula(EvalExpression(lQtySetup."Value Formula",
                                  lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule");
                    end;
                end else
                    return := lRoundingFormula(EvalExpression(lQtySetup."Value Formula",
                              lQtySetup."Value Formula"), lQtySetup."Rounding Precision Formule");
            end;
        end;
        //#6767//
    end;


    procedure fSalesReset(var pSalesLine: Record "Sales Line")
    begin
        //#6767
        pSalesLine."Value 1" := 0;
        pSalesLine."Value 2" := 0;
        pSalesLine."Value 3" := 0;
        pSalesLine."Value 4" := 0;
        pSalesLine."Value 5" := 0;
        pSalesLine."Value 6" := 0;
        pSalesLine."Value 7" := 0;
        pSalesLine."Value 8" := 0;
        pSalesLine."Value 9" := 0;
        pSalesLine."Value 10" := 0;
        //#6767//
    end;


    procedure fPurchReset(var pPurchLine: Record "Purchase Line")
    begin
        //#6767
        pPurchLine."Value 1" := 0;
        pPurchLine."Value 2" := 0;
        pPurchLine."Value 3" := 0;
        pPurchLine."Value 4" := 0;
        pPurchLine."Value 5" := 0;
        pPurchLine."Value 6" := 0;
        pPurchLine."Value 7" := 0;
        pPurchLine."Value 8" := 0;
        pPurchLine."Value 9" := 0;
        pPurchLine."Value 10" := 0;
        //#6767//
    end;


    procedure fGetTotalisation(pQtySetup: Record "Quantity Setup"; pFieldNo: Integer): Boolean
    begin
        with pQtySetup do
            case pFieldNo of
                8004066:
                    exit("Value 1 Total");
                8004067:
                    exit("Value 2 Total");
                8004068:
                    exit("Value 3 Total");
                8004069:
                    exit("Value 4 Total");
                8004070:
                    exit("Value 5 Total");
                8004071:
                    exit("Value 6 Total");
                8004072:
                    exit("Value 7 Total");
                8004073:
                    exit("Value 8 Total");
                8004074:
                    exit("Value 9 Total");
                8004075:
                    exit("Value 10 Total");
                //#7918
                8004053, 8004055, 8004094:
                    exit(true);
            //#7918//

            end;
    end;
}

