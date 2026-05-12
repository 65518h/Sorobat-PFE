Codeunit 8001445 "BOQ Calculate Mgt"
{
    // #7202 XPE 19/06/09
    // #7128 XPE 21/04/09
    // #6972 AC 16/02/09
    // #6592 AC-XP 16/02/09
    // #6711 XPE 24/11/08 Ajout de la validation de la formule
    // #6711 XPE 24/11/08 Ajout d'une fonction pour verifier si la formule ne commence pas par le caractere '='
    // #6591 XPE 07/11/08 Revision complete du traitement de calcul du métré

    TableNo = "BOQ Line";

    trigger OnRun()
    begin
        fInitialize();
        //#6711
        if (rec."Variable Code" <> '') then
            fValidateCellsName(rec."Variable Code");

        if (rec.Formula <> '') then
            fValidateCellsFormula(rec.Formula);
        //#6711//
    end;

    var
        wResult: Text[250];
        wErrorMessage: Text[250];
        wXlsMgt: Codeunit "Excel Management";
        Text001: label 'The process is not initialized';
        wProgressBar: Codeunit "Progress Dialog2";
        wSingleInstance: Codeunit "Import SingleInstance2";
        wBOQLINE: Record "BOQ Line" temporary;
        wParentBoqLine: Record "BOQ Line" temporary;
        wNaviBatSetup: Record NavibatSetup;
        wRowA: Integer;
        wRowB: Integer;
        wRowC: Integer;
        tErrCalculate: label 'Impossible Calculate : circular reference in formula';
        tErrCyclique: label 'circular reference in variable "%1"';
        wEntryNo: Integer;
        wLastLevel: Integer;
        tTextLoadingData: label 'Loading Data ...';
        tTextCalculateData: label 'Evaluation in process ...';
        wParentLoaded: Boolean;
        tResult: label '=SOMME(B1:B%1)';
        wInit: Boolean;
        wDebug: Boolean;


    procedure fInitialize()
    begin
        wInit := false;
        wSingleInstance.GetXlsMgt(wXlsMgt);
        /* //GL2024 if not wXlsMgt.fExcelIsActive then
             wXlsMgt.CreateBook('')
         else
             fClear();*/
        //wXlsMgt.fClearSheets;
        wResult := '';
        wRowA := 1;
        wRowB := 1;
        wRowC := 1;
        wInit := true;
        wDebug := false;
        //#7202
        //GL2024 wXlsMgt.fSetInconsistentFormula(false);
        //#7202//
        fShowExcelDebug;
        // RAZ Liste boq parent
        wParentBoqLine.DeleteAll();
        wParentLoaded := false;
        //GL2024  wXlsMgt.fDisplayAlerts(false);
        wSingleInstance.SetXlsMgt(wXlsMgt);
        //BAT
        wSingleInstance.wGetNaviBatSetup(wNaviBatSetup);
        //BAT//
    end;


    procedure fFinalize()
    begin
        //#7128
        wSingleInstance.GetXlsMgt(wXlsMgt);
        //#7128//
        //GL2024 wXlsMgt.Quit();
        wSingleInstance.ClearXlsMgt;
        wInit := false;
    end;


    procedure fCalculateBOQ(var pParentVar: Record "BOQ Line"; var pCurrentVar: Record "BOQ Line") Retour: Boolean
    begin
        wSingleInstance.GetXlsMgt(wXlsMgt);
        Retour := true;
        //#6591
        // il faut ajouter les variables contenues dans la liste des variables parentes SSI la liste des parents est vide
        if (not wParentLoaded) then begin
            fSetParent(pParentVar);
        end;

        // Nous devons, nous assurer que les resultats soient à nulle
        fResetResult();

        if pCurrentVar.IsEmpty then
            exit(false);

        if (pCurrentVar.Level <= wLastLevel) then begin
            fUnMergeAndUnsubstitute(pCurrentVar.Level);
        end;
        wLastLevel := pCurrentVar.Level;

        // il faut ajouter les variables contenues dans les variables courantes
        if (pCurrentVar.Find('-')) then begin
            repeat
                // On merge puis on ajoute dans XLS
                fMerge(wParentBoqLine, pCurrentVar, wEntryNo);
                Retour := fAddBOQCells(pCurrentVar, false);
                if wParentBoqLine.FindLast then;
            until (pCurrentVar.Next() = 0);
        end;

        Retour := fEvaluateVariable(pCurrentVar);

        wSingleInstance.SetXlsMgt(wXlsMgt);
    end;


    procedure fGetResult() Retour: Text[250]
    begin
        Retour := wResult;
    end;


    procedure fGetErrorMessage() retour: Text[250]
    begin
        retour := wErrorMessage;
    end;


    procedure fAddBOQCells(var pBOQLine: Record "BOQ Line" temporary; pParent: Boolean) Retour: Boolean
    var
        lCR: Char;
        lLF: Char;
    begin
        wSingleInstance.GetXlsMgt(wXlsMgt);
        lCR := 13;
        lLF := 10;
        Retour := true;
        // Les cellules A Contiennent les constantes et la var Calc
        // Les cellules B Contiennent les resultats
        // La Cellule C Contient uniquement la somme de tous les resultats
        // attention pour chacune des variable, il faut s'assurer qu'elle nexiste pas.
        // Dans le cas contraire, il faut la supprimer puis l'ajouter dans dans la colonne adequate
        /* //GL2024    if (pBOQLine."Variable Code" = '') then begin
                if ((not pParent) and (pBOQLine.Formula <> '')) then begin
                    wXlsMgt.fSetRangeName('B' + Format(wRowB), 'RESULT' + Format(pBOQLine."Entry No."));
                    if wDebug then
                        wXlsMgt.fAddComments('B' + Format(wRowB), Format(pBOQLine.RecordID) + Format(lCR) + Format(lLF) + pBOQLine.Description);
                    wXlsMgt.EnterCell('B' + Format(wRowB), '=' + pBOQLine.Formula, true);
                    wRowB := wRowB + 1;
                end;
            end else begin
                if (pBOQLine.Formula <> '') then begin
                    wXlsMgt.fSetRangeName('A' + Format(wRowA), pBOQLine."Variable Code");
                    if wDebug then
                        wXlsMgt.fAddComments('A' + Format(wRowA), Format(pBOQLine.RecordID) + Format(lCR) + Format(lLF) + pBOQLine.Description);
                    wXlsMgt.EnterCell('A' + Format(wRowA), '=' + pBOQLine.Formula, true);
                    wRowA := wRowA + 1;
                end else begin
                    wXlsMgt.fSetRangeName('A' + Format(wRowA), pBOQLine."Variable Code");
                    if wDebug then
                        wXlsMgt.fAddComments('A' + Format(wRowA), Format(pBOQLine.RecordID) + Format(lCR) + Format(lLF) + pBOQLine.Description);
                    wXlsMgt.EnterCell('A' + Format(wRowA), fFormatString(pBOQLine.fExtractRecordValue), false);
                    wRowA := wRowA + 1;
                end;
            end;*/
        pBOQLine.Modify;
        wSingleInstance.SetXlsMgt(wXlsMgt);
    end;


    procedure fClear()
    var
        lIndex: Integer;
    begin
        /********************************************
        *                 fClear                   *
        ********************************************
        * Entrée : Néant                           *
        * Sortie : Néant                           *
        ********************************************
        * Vide le feuillet en cours                *
        ********************************************/
        wSingleInstance.GetXlsMgt(wXlsMgt);
        //GL2024   wXlsMgt.fClearSheets;
        wRowA := 1;
        wRowB := 1;
        wRowC := 1;

        wSingleInstance.SetXlsMgt(wXlsMgt);

    end;


    procedure fShowExcelDebug()
    begin
        /********************************************
        *             fShowExcelDebug              *
        ********************************************
        * Entrée : Néant                           *
        * Sortie : Néant                           *
        ********************************************
        * Affiche l'instance d'Excel               *
        ********************************************/
        //GL2024       wXlsMgt.fSetVisible(wDebug);

    end;


    procedure fEvaluateBOQ(var pCurrentVar: Record "BOQ Line") Retour: Boolean
    var
        lOldValue: Decimal;
        lResult: Decimal;
    begin
        wSingleInstance.GetXlsMgt(wXlsMgt);
        Retour := true;
        Retour := wXlsMgt.fEvaluateFormula('C1');
        if (not Retour) then begin
            wErrorMessage := wXlsMgt.fGetErrorMessage('C1');
        end;/* else begin
            if Format(wXlsMgt.fGetValue('C1')) <> '' then
                Evaluate(lOldValue, wXlsMgt.fGetValue('C1'));
        end;*/
        // il faut ajouter les variables contenues dans les des variables courantes
        if (pCurrentVar.Find('-')) then begin
            repeat
                Retour := fVerifyBOQCells(pCurrentVar);
            until (pCurrentVar.Next() = 0);
        end;
        Retour := wXlsMgt.fEvaluateFormula('C1');
        if (not Retour) then begin
            wErrorMessage := wXlsMgt.fGetErrorMessage('C1');
        end;/* //GL2024 else begin
            if not Evaluate(lResult, wXlsMgt.fGetValue('C1')) then
                lResult := 0;
            wResult := Format(lResult);
            if (lResult <> lOldValue) then begin
                Retour := false;
                wErrorMessage := tErrCalculate;
                pCurrentVar.SetRange("Variable Code", '');
                pCurrentVar.SetFilter(Formula, '<>%1', '');
                pCurrentVar.ModifyAll(Problem, true);
                pCurrentVar.Reset;
            end;
        end;*/
    end;


    procedure fVerifyBOQCells(var pBOQLine: Record "BOQ Line") Retour: Boolean
    var
        lVarValue: Decimal;
    begin
        wSingleInstance.GetXlsMgt(wXlsMgt);
        Retour := true;
        // Les cellules A Contiennent les constantes
        // Les Cellules B Contiennent les Var Calc
        // Les cellules C Contiennent les resultats
        // La Cellule D Contient uniquement la somme de tous les resultats
        // attention pour chacune des variable, il faut s'assurer qu'elle nexiste pas.
        // Dans le cas contraire, il faut la supprimer puis l'ajouter dans dans la colonne adequate
        if (pBOQLine."Variable Code" <> '') then begin
            if (pBOQLine.Formula <> '') then begin
                Retour := wXlsMgt.fEvaluateFormula(pBOQLine."Variable Code");
                if (not Retour) then begin
                    wErrorMessage := pBOQLine."Variable Code" + wXlsMgt.fGetErrorMessage(pBOQLine."Variable Code");
                    pBOQLine.Problem := true;
                end else begin
                    // on recupere le resultat intermediare
                    //GL2024 if not Evaluate(lVarValue, wXlsMgt.fGetValue(pBOQLine."Variable Code")) then
                    //GL2024    lVarValue := 0;
                    // il faut le tester pour verifier que celui-ci n'esty pas cyclique
                    if (lVarValue <> pBOQLine.Value) then begin
                        pBOQLine.Problem := true;
                        wErrorMessage := StrSubstNo(tErrCyclique, pBOQLine."Variable Code");
                        Retour := false;
                    end else begin
                        pBOQLine.Value := lVarValue;
                    end;
                end;
            end;/* //GL2024 else begin
                wXlsMgt.EnterCell(pBOQLine."Variable Code", fFormatString(pBOQLine.fExtractRecordValue), false);
            end;*/
        end;
        pBOQLine.Modify;
        wSingleInstance.SetXlsMgt(wXlsMgt);
    end;


    procedure fValidateCellsName(pVarID: Code[20]) return: Boolean
    var
        indexerror: Integer;
    begin
        return := true;
        //GL2024  wXlsMgt.fSetRangeName('Z1', pVarID);
        wErrorMessage := wXlsMgt.fGetErrorMessage('Z1');
        return := not wXlsMgt.fRangeError('Z1');
    end;


    procedure fSetBOQLINE(pBoqLine: Record "BOQ Line")
    begin
        wBOQLINE := pBoqLine;
    end;


    procedure fCalcXlsBoq(var pBoqLine: Record "BOQ Line"; pEntry: Integer) Retour: Boolean
    begin
        //#6591
        pBoqLine.SetFilter(pBoqLine."Entry No.", '>%1', pEntry);
        if (not pBoqLine.IsEmpty()) then begin
            pBoqLine.Find('-');
            repeat
                if (pBoqLine."Variable Code" = '') then begin
                    Retour := wXlsMgt.fEvaluateFormula('RESULT' + Format(pBoqLine."Entry No."));
                    if (not Retour) then begin
                        wErrorMessage := 'RESULT' + Format(pBoqLine."Entry No.") +
                                         wXlsMgt.fGetErrorMessage('RESULT' + Format(pBoqLine."Entry No."));
                        pBoqLine.Problem := true;
                    end;/* //GL2024 else begin
                        // on recupere le resultat intermediare
                        Evaluate(pBoqLine.Value, wXlsMgt.fGetValue('RESULT' + Format(pBoqLine."Entry No.")));
                    end;*/
                end else begin
                    if (pBoqLine.Formula <> '') then begin
                        Retour := wXlsMgt.fEvaluateFormula(pBoqLine."Variable Code");
                        if (not Retour) then begin
                            wErrorMessage := pBoqLine."Variable Code" + wXlsMgt.fGetErrorMessage(pBoqLine."Variable Code");
                            pBoqLine.Problem := true;
                        end;/* //GL2024 else begin
                            // on recupere le resultat intermediare
                            Evaluate(pBoqLine.Value, wXlsMgt.fGetValue(pBoqLine."Variable Code"));
                        end;*/
                    end;
                end;
                pBoqLine.Modify;
            until (pBoqLine.Next() = 0);
        end;
        //#6591//
    end;


    procedure fValidateFormula(pFormula: Text[250]) retour: Text[250]
    begin
        //#6711
        // On supprime le egale si la formule commence par ce caractère
        retour := pFormula;
        if (pFormula[1] = '=') then begin
            retour := CopyStr(pFormula, 2);
        end;
        //#6711//
    end;


    procedure fValidateCellsFormula(pFormula: Text[250]) return: Boolean
    begin
        //#6711
        return := true;
        //GL2024 wXlsMgt.EnterCell('Z1', '=' + pFormula, true);
        wErrorMessage := wXlsMgt.fGetErrorMessage('Z1');
        return := not wXlsMgt.fRangeError('Z1');
        //#6711//
    end;


    procedure fMerge(var pOwnerBOQ: Record "BOQ Line"; pLocalBOQ: Record "BOQ Line"; var pEntryNo: Integer)
    begin
        pOwnerBOQ.SetRange("Variable Code", pLocalBOQ."Variable Code");
        pOwnerBOQ.SetRange(Substituted, false);
        pOwnerBOQ.SetFilter(Level, '<%1', pLocalBOQ.Level);
        if pOwnerBOQ.FindLast then begin
            fSubstitute(pOwnerBOQ);
        end;
        pOwnerBOQ.Reset;

        // On ajoute uniquement si variable, sinon pas necessaire
        if (pLocalBOQ."Variable Code" <> '') then begin
            pEntryNo += 10000;
            pOwnerBOQ.Init;
            pOwnerBOQ.TransferFields(pLocalBOQ, false);
            pOwnerBOQ."Entry No." := pEntryNo;
            pOwnerBOQ.Insert;
            pOwnerBOQ.FindLast;
        end;
    end;


    procedure fUnMerge(var pOwnerBOQ: Record "BOQ Line"; var pLocalBOQ: Record "BOQ Line")
    begin
        pOwnerBOQ.SetFilter(Level, '>=%1', pLocalBOQ.Level);
        if not pOwnerBOQ.IsEmpty then
            fPurge(pOwnerBOQ);
        pOwnerBOQ.Reset;
    end;


    procedure fSubstitute(var pBOQ: Record "BOQ Line")
    begin
        //GL2024 wXlsMgt.fSetRangeName(pBOQ."Variable Code", StrSubstNo('%1_DEEP%2', pBOQ."Variable Code", pBOQ.Level));
        pBOQ.Substituted := true;
        pBOQ.Modify;
    end;


    procedure fUnSubstitute(var pBOQ: Record "BOQ Line")
    begin
        //GL2024  wXlsMgt.fSetRangeName(StrSubstNo('%1_DEEP%2', pBOQ."Variable Code", pBOQ.Level), pBOQ."Variable Code");
        pBOQ.Substituted := false;
        pBOQ.Modify;
    end;


    procedure fPurge(var pBOQLine: Record "BOQ Line")
    var
        lVar: Text[50];
        lCountRecord: Integer;
        lRangeName: Text[1024];
    begin
        /*  //GL2024 if (not pBOQLine.IsEmpty()) then begin
              //wXlsMgt.fDeleteRange('B:B');
              wXlsMgt.fClearRange('B:B');
              lRangeName := '';
              lCountRecord := pBOQLine.Count;
              if (lCountRecord = 1) then begin
                  if pBOQLine.Substituted then
                      lRangeName := StrSubstNo('%1_DEEP%2', pBOQLine."Variable Code", pBOQLine.Level)
                  else
                      lRangeName := 'A' + Format(wXlsMgt.fGetLine(pBOQLine."Variable Code"));
                  //lRangeName := pBOQLine."Variable Code";
              end else begin
                  if (pBOQLine.FindFirst) then begin
                      if pBOQLine.Substituted then
                          lRangeName := StrSubstNo('%1_DEEP%2', pBOQLine."Variable Code", pBOQLine.Level) + ':'
                      else
                          lRangeName := 'A' + Format(wXlsMgt.fGetLine(pBOQLine."Variable Code")) + ':';
                      //lRangeName := pBOQLine."Variable Code" + ':';
                  end;
                  if (pBOQLine.FindLast) then begin
                      if pBOQLine.Substituted then
                          lRangeName += StrSubstNo('%1_DEEP%2', pBOQLine."Variable Code", pBOQLine.Level)
                      else
                          lRangeName += 'A' + Format(wXlsMgt.fGetLine(pBOQLine."Variable Code"));
                      //lRangeName += pBOQLine."Variable Code";
                  end;
              end;
              wXlsMgt.fClearRange(lRangeName);
              wXlsMgt.fDeleteRange(lRangeName);
              wRowA -= lCountRecord;*/

        /*Optimize
        pBOQLine.FINDSET;
        REPEAT
          IF pBOQLine."Variable Code" <> '' THEN BEGIN
            IF pBOQLine.Substituted THEN
              lVar := STRSUBSTNO('%1_DEEP%2',pBOQLine."Variable Code",pBOQLine.Level)
            ELSE
              lVar := pBOQLine."Variable Code";
            wXlsMgt.fClearRange(lVar);
            wXlsMgt.fDeleteRange(lVar);
            // We decrement the RowA Variable
            wRowA := wRowA - 1;
          END;
        UNTIL pBOQLine.NEXT = 0;
        Optimize*/
        pBOQLine.DeleteAll;
        //GL2024  end;

    end;


    procedure fSetParent(var pVarParent: Record "BOQ Line")
    begin
        wParentBoqLine.DeleteAll;
        wEntryNo := 0;
        if (not pVarParent.IsEmpty()) then begin
            pVarParent.Find('-');
            repeat
                // On merge avant d'ajouter pour eviter toutes collisions avec des variables déjà existantes
                fMerge(wParentBoqLine, pVarParent, wEntryNo);
                fAddBOQCells(pVarParent, true);
                wLastLevel := pVarParent.Level;
            until (pVarParent.Next() = 0)
        end;
        wParentLoaded := true;
    end;


    procedure fResetResult()
    var
        lIndex: Integer;
    begin
        //wXlsMgt.fDeleteRange('C1');
        //GL2024  wXlsMgt.fClearRange('C1');

        /* //GL2024  if wRowB > 1 then
              wXlsMgt.fClearRange(StrSubstNo('B1:B%1', wRowB - 1));*/
        //wXlsMgt.fDeleteRange(STRSUBSTNO('B1:B%1',wRowB-1));
        //ELSE
        //  wXlsMgt.fDeleteRange('B:B');
        wRowB := 1;
    end;


    procedure fUnMergeAndUnsubstitute(pNewLevel: Integer)
    var
        lDeleteVariable: Record "BOQ Line" temporary;
    begin
        // Il faut tout d'abord de-substituter les elements dans Excel
        wParentBoqLine.Reset();
        wParentBoqLine.SetFilter(Level, '>=%1', pNewLevel);
        if (not wParentBoqLine.IsEmpty()) then begin
            lDeleteVariable.DeleteAll();
            wParentBoqLine.FindSet(true, true);
            repeat
                lDeleteVariable := wParentBoqLine;
                lDeleteVariable.Insert;
            until wParentBoqLine.Next = 0;
            lDeleteVariable.Copy(wParentBoqLine);
            fPurge(wParentBoqLine);
            //  wParentBoqLine.DELETEALL();
            wParentBoqLine.Reset();
            lDeleteVariable.Find('-');
            //  wXlsMgt.fDeleteRange('B:B');
            /* //GL2024    if wRowB > 1 then
                    wXlsMgt.fClearRange(StrSubstNo('B1:B%1', wRowB - 1));*/
            //wXlsMgt.fDeleteRange(STRSUBSTNO('B1:B%1',wRowB-1));
            repeat
                wParentBoqLine.Reset();
                wParentBoqLine.SetRange(Substituted, true);
                wParentBoqLine.SetRange("Variable Code", lDeleteVariable."Variable Code");
                wParentBoqLine.SetFilter(Level, '<%1', pNewLevel);
                if (not wParentBoqLine.IsEmpty()) then begin
                    // On se place sur le dernier
                    wParentBoqLine.FindLast;
                    fUnSubstitute(wParentBoqLine);
                end;
            until (lDeleteVariable.Next() = 0);
            //BAT
            if wNaviBatSetup."Number lines before commit" <> 0 then
                wSingleInstance.wGetFrequencyCommit;
            //BAT//
        end;
        Clear(lDeleteVariable);
    end;


    procedure fEvaluateVariable(var pBOQLine: Record "BOQ Line") Retour: Boolean
    var
        lCellName: Text[80];
        lRetCalc: Boolean;
    begin
        // On evalue uniquement les elements de métrés possédant une formule
        Retour := true;
        pBOQLine.SetFilter(pBOQLine.Formula, '<>%1', '');
        if (not pBOQLine.IsEmpty()) then begin
            pBOQLine.Find('-');
            repeat
                if (pBOQLine."Variable Code" <> '') then begin
                    // Evaluation des variables calculées
                    lCellName := pBOQLine."Variable Code";
                end else begin
                    //Evaluation des resultats
                    lCellName := StrSubstNo('RESULT%1', pBOQLine."Entry No.");
                end;
                lRetCalc := wXlsMgt.fEvaluateFormula(lCellName);
                Retour := Retour and lRetCalc;
                /*  //GL2024 if (not lRetCalc) then begin
                      wErrorMessage := lCellName + wXlsMgt.fGetErrorMessage(lCellName);
                      pBOQLine.Problem := true;
                  end else begin
                      // on recupere le resultat intermediare
                      if not Evaluate(pBOQLine.Value, wXlsMgt.fGetValue(lCellName)) then;
                  end;*/
                pBOQLine.Modify;
            until (pBOQLine.Next() = 0);
            //Maintenant on evalue la somme des resultats
            pBOQLine.SetFilter("Variable Code", '%1', '');
            if (Retour) and not pBOQLine.IsEmpty then begin
                /*  //GL2024 if wRowB > 1 then
                      wXlsMgt.EnterCell('C1', StrSubstNo(tResult, wRowB - 1), true)
                  else
                      wXlsMgt.EnterCell('C1', 'B1', true);*/
                Retour := wXlsMgt.fEvaluateFormula('C1');
                /*  //GL2024 if (not Retour) then begin
                      wErrorMessage := wXlsMgt.fGetErrorMessage('C1');
                  end else begin
                      wResult := wXlsMgt.fGetValue('C1');
                  end;*/
            end else
                Retour := false;
        end;
        pBOQLine.Reset;
    end;


    procedure fAsParentVariable() retour: Boolean
    begin
        /********************************************
        *             fAsParentVariable            *
        ********************************************
        * Input : Nothing                          *
        * Output : Boolean                         *
        ********************************************
        * Get True, if the calculate management    *
        * has the ascendant variables from the     *
        * XML tree                                 *
        ********************************************/
        retour := wParentLoaded;

    end;


    procedure fIsInitialize() retour: Boolean
    begin
        /********************************************
        *             fIsInitialize                *
        ********************************************
        * Input : Nothing                          *
        * Output : Boolean                         *
        ********************************************
        * Get True, if the calculate management    *
        * has been initialize, False otherize      *
        ********************************************/
        retour := wInit;

    end;


    procedure fFormatString(pDecimalValue: Decimal) retour: Text[30]
    var
        lTxtValue: Text[30];
        lIndex: Integer;
    begin
        lTxtValue := Format(pDecimalValue);
        for lIndex := 1 to StrLen(lTxtValue) do begin
            if (((lTxtValue[lIndex] >= '0') and (lTxtValue[lIndex] <= '9')) or (lTxtValue[lIndex] = ',') or (lTxtValue[lIndex] = '.')) then
                retour += Format(lTxtValue[lIndex]);
        end;
    end;


    procedure fClearResult()
    begin
        wResult := '';
    end;
}

