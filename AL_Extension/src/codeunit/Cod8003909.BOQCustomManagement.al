Codeunit 8003909 "BOQ Custom Management"
{
    // //#6592 Gestion
    // //#6592 Ajout
    // //#6592 L'autre


    trigger OnRun()
    var
        lRec: Record "Sales Header";
    begin
        /***********************************************
        *                  OnRun                      *
        ***********************************************
        * Entrée : Néant                              *
        * Sortie : Néant                              *
        ***********************************************
        * méthode de test de génération du fichier XML*
        ***********************************************/
        lRec.Get(lRec."document type"::Quote, '1119');
        gLoadSalesBOQ(lRec);

    end;

    var
        TErrorImplement: label 'The fonctionnality doesn''t yet implement';
        tRound: label 'ARRONDI';
        wBOQCalcMgt: Codeunit "BOQ Calculate Mgt";
        tDescendantCalc: label 'Descendant Calculation ...';
        wBOQMgt: Codeunit "BOQ Management";
        tErrCalculate: label 'This function is''nt use by %1';


    procedure gLoadSalesBOQ(pSalesHeader: Record "Sales Header")
    var
        lRecordRef: RecordRef;
        lSingleaNav: Codeunit "NaviBat SingleInstance";
    begin
        /***********************************************
        *             gLoadSalesBOQ                   *
        ***********************************************
        * Entrée : Record Sales Header                *
        * Sortie : Néant                              *
        ***********************************************
        * génération du fichier XML à partir          *
        * de la table 36                              *
        ***********************************************/
        lRecordRef.GetTable(pSalesHeader);
        wBOQMgt.Finalize;
        wBOQMgt.Initialize;
        lLoadDocBOQ(lRecordRef, true, wBOQMgt);
        lRecordRef.Close;
        wBOQMgt.Save('');

    end;


    procedure gVerifySalesBOQ(pSalesHeader: Record "Sales Header")
    var
        lRecordRef: RecordRef;
        lSingleaNav: Codeunit "NaviBat SingleInstance";
    begin
        /***********************************************
        *             gLoadSalesBOQ                   *
        ***********************************************
        * Entrée : Record Sales Header                *
        * Sortie : Néant                              *
        ***********************************************
        * génération du fichier XML à partir          *
        * de la table 36                              *
        ***********************************************/
        lRecordRef.GetTable(pSalesHeader);
        if not wBOQMgt.Load(lRecordRef.RecordId) then begin
            wBOQMgt.Finalize;
            wBOQMgt.Initialize;
        end;
        lVerifyDocBOQ(lRecordRef, true, wBOQMgt);
        lRecordRef.Close;
        //wBOQMgt.Save('C:\Test.xml');
        wBOQMgt.Save('');

    end;


    procedure gLoadSalesArchBOQ(pSalesHeaderArch: Record "Sales Header Archive")
    var
        lRecordRef: RecordRef;
        lSingleaNav: Codeunit "NaviBat SingleInstance";
    begin
        /***********************************************
        *             gLoadSalesBOQ                   *
        ***********************************************
        * Entrée : Record Sales Header                *
        * Sortie : Néant                              *
        ***********************************************
        * génération du fichier XML à partir          *
        * de la table 36                              *
        ***********************************************/
        lRecordRef.GetTable(pSalesHeaderArch);
        wBOQMgt.Finalize;
        wBOQMgt.Initialize;
        lLoadDocBOQ(lRecordRef, true, wBOQMgt);
        lRecordRef.Close;
        wBOQMgt.Save('');

    end;


    procedure gLoadResourceBOQ(pResource: Record Resource)
    var
        lRecordRef: RecordRef;
    begin
        /***********************************************
        *            gLoadResourceBOQ                 *
        ***********************************************
        * Entrée : Record Sales Header                *
        * Sortie : Néant                              *
        ***********************************************
        * génération du fichier XML à partir          *
        * de la table 36                              *
        ***********************************************/
        lRecordRef.GetTable(pResource);
        wBOQMgt.Initialize;
        lLoadDocBOQ(lRecordRef, true, wBOQMgt);
        lRecordRef.Close;
        wBOQMgt.Save('');

    end;


    procedure gLoadTemplateBOQ(pTemplateBOQ: Record "BOQ Template")
    var
        lRecordRef: RecordRef;
    begin
        /***********************************************
        *            gLoadTemplateBOQ                 *
        ***********************************************
        * Entrée : Record Template BOQ                *
        * Sortie : Néant                              *
        ***********************************************
        * génération du fichier XML à partir          *
        * de la table Template BOQ                    *
        ***********************************************/
        lRecordRef.GetTable(pTemplateBOQ);
        wBOQMgt.Finalize;
        wBOQMgt.Initialize;
        lLoadDocBOQ(lRecordRef, true, wBOQMgt);
        lRecordRef.Close;
        wBOQMgt.Save('');

    end;


    procedure gGetFatherNode(pRecRef: RecordRef; var pFatherRef: RecordRef): Boolean
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
        lT5107: Record "Sales Header Archive";
        lT5108: Record "Sales Line Archive";
    begin
        /***********************************************
        *            gGetFatherNode                   *
        ***********************************************
        * Entrée : pRecRef élémént fils               *
        *          pFatherRef élément retouorné       *
        *          correspondant au père dans         *
        *          l'abrorescence                     *
        * Sortie : Boolean                            *
        ***********************************************
        * fonction qui permet de retrouver un élément *
        * père à partir d'un élément fils.            *
        ***********************************************/
        case pRecRef.Number of
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lT37);
                    if lT37."Attached to Line No." <> 0 then begin
                        lT37.Get(lT37."Document Type", lT37."Document No.", lT37."Attached to Line No.");
                        pFatherRef.GetTable(lT37);
                    end else
                        if lT37."Structure Line No." <> 0 then begin
                            lT37.Get(lT37."Document Type", lT37."Document No.", lT37."Structure Line No.");
                            pFatherRef.GetTable(lT37);
                        end else begin
                            lT36.Get(lT37."Document Type", lT37."Document No.");
                            pFatherRef.GetTable(lT36);
                        end;
                end;
            Database::"Structure Component":
                begin
                    pRecRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    pFatherRef.GetTable(lT156);
                end;
            Database::"Sales Line Archive":
                begin
                    pRecRef.SetTable(lT5108);
                    if lT5108."Attached to Line No." <> 0 then begin
                        lT5108.Get(lT5108."Document Type", lT5108."Document No.", lT5108."Doc. No. Occurrence",
                                   lT5108."Version No.", lT5108."Attached to Line No.");
                        pFatherRef.GetTable(lT5108);
                    end else
                        if lT5108."Structure Line No." <> 0 then begin
                            lT5108.Get(lT5108."Document Type", lT5108."Document No.", lT5108."Doc. No. Occurrence",
                                           lT5108."Version No.", lT5108."Structure Line No.");
                            pFatherRef.GetTable(lT5108);
                        end else begin
                            lT5107.Get(lT5108."Document Type", lT5108."Document No.", lT5108."Doc. No. Occurrence", lT5108."Version No.");
                            pFatherRef.GetTable(lT5107);
                        end;
                end;
            else
                exit(false);
        end;
        exit(true);

    end;


    procedure gAssignValueToOwnerRef(var pRecRef: RecordRef; pLocal: Boolean; pValue: Decimal)
    var
        lStructure: Record "Structure Component";
        lSalesLine: Record "Sales Line";
        lStrucSalesLine: Record "Sales Line";
        lStructureMgt: Codeunit "Structure Management";
        lValidate: Boolean;
        lxRec: Record "Sales Line";
        lStructQty: Decimal;
    begin
        /***********************************************
        *         gAssignValueToOwnerField            *
        ***********************************************
        * Entrée : pRecRef élémént en cours de modif  *
        * pLocal : Modification de l'enregistrement   *
        *          selectionné dans le formulaire     *
        * pValue : Valeur d'entrée                    *
        * Sortie : NEANT                              *
        ***********************************************
        * fonction d'application des valeurs calculés *
        * dans la base de données                     *
        ***********************************************/
        lValidate := true;
        case pRecRef.Number of
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lSalesLine);
                    with lSalesLine do begin
                        lxRec := lSalesLine;
                        if "Line Type" >= "line type"::Item then begin
                            if ("Structure Line No." = 0) then begin
                                if Option then
                                    gAssignValueToOwnerField(pRecRef, pValue, FieldNo("Optionnal Quantity"), lValidate)
                                else
                                    if Disable then
                                        gAssignValueToOwnerField(pRecRef, pValue, FieldNo("Disable Quantity"), lValidate)
                                    else
                                        gAssignValueToOwnerField(pRecRef, pValue, FieldNo(Quantity), lValidate);
                            end else begin
                                //#6071
                                if (lSalesLine."Attached to Line No." <> 0) then begin
                                    if lStrucSalesLine.Get("Document Type", "Document No.", "Attached to Line No.") then begin
                                        //#6592
                                        if (lStrucSalesLine."Quantity per" + lStrucSalesLine."Quantity Fixed") <> 0 then
                                            gAssignValueToOwnerField(pRecRef, pValue *
                                               (lStrucSalesLine."Quantity per" + lStrucSalesLine."Quantity Fixed"), FieldNo("Quantity per"), pLocal)
                                        else begin
                                            gAssignValueToOwnerField(pRecRef, 0, FieldNo("Quantity per"), lValidate);
                                            gAssignValueToOwnerField(pRecRef, pValue, FieldNo("Optionnal Quantity"), pLocal);
                                        end;
                                        //#6592
                                    end else
                                        gAssignValueToOwnerField(pRecRef, pValue, FieldNo("Quantity per"), pLocal);
                                end else
                                    gAssignValueToOwnerField(pRecRef, pValue, FieldNo("Quantity per"), pLocal);
                                //#6071//
                                if pLocal then begin
                                    pRecRef.SetTable(lSalesLine);
                                    lStructureMgt.wSumDiffStructure(lSalesLine, lxRec);
                                end
                            end;
                        end;
                    end;
                end;
            Database::"Structure Component":
                gAssignValueToOwnerField(pRecRef, pValue, lStructure.FieldNo("Quantity per"), lValidate);
        end;

    end;


    procedure gAssignSelfToOwnerRef(var pRecRef: RecordRef; pLocal: Boolean)
    var
        lStructure: Record "Structure Component";
        lSalesLine: Record "Sales Line";
        lStrucSalesLine: Record "Sales Line";
        lStructureMgt: Codeunit "Structure Management";
        lxRec: Record "Sales Line";
    begin
        /***********************************************
        *         gAssignValueToOwnerField            *
        ***********************************************
        * Entrée : pRecRef élémént en cours de modif  *
        * pLocal : Modification de l'enregistrement   *
        *          selectionné dans le formulaire     *
        * pValue : Valeur d'entrée                    *
        * Sortie : NEANT                              *
        ***********************************************
        * fonction d'application des valeurs calculés *
        * dans la base de données                     *
        ***********************************************/

        case pRecRef.Number of
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lSalesLine);
                    with lSalesLine do begin
                        lxRec := lSalesLine;
                        if "Line Type" >= "line type"::Item then begin
                            if ("Structure Line No." = 0) then begin
                                if Option then
                                    Validate("Optionnal Quantity")
                                else
                                    if Disable then
                                        Validate("Disable Quantity")
                                    else
                                        Validate(Quantity);
                            end else begin
                                if not pLocal then
                                    exit;
                                Validate("Quantity per");
                            end;
                            Modify;
                        end;
                    end;
                end;
            Database::"Structure Component":
                begin
                    pRecRef.SetTable(lStructure);
                    lStructure.Validate("Quantity per");
                    lStructure.Modify;
                end;
        end;

    end;


    procedure gAssignValueToOwnerField(var pRecRef: RecordRef; pValue: Decimal; pFieldID: Integer; var pValidate: Boolean)
    var
        lFieldRef: FieldRef;
        lValue: Decimal;
        lFieldvalue: Decimal;
    begin
        /***********************************************
        *         gAssignValueToOwnerField            *
        ***********************************************
        * Entrée : pRecRef élémént en cours de modif  *
        * pValue : Valeur d'entrée                    *
        * pFieldID : N° du champ auquel on va affecter*
                    une la valuer d'entrée            *
        * pValidate : détermine l'appel à un validate *
        * Sortie : NEANT                              *
        ***********************************************
        * fonction d'applcaition des valeurs calculés *
        * au niveau de l'enregistrement               *
        ***********************************************/
        lFieldRef := pRecRef.Field(pFieldID);
        //IF FORMAT(lFieldRef.VALUE) = FORMAT(pValue) THEN
        //  EXIT;
        //#6872
        lFieldvalue := lFieldRef.Value;
        //??EVALUATE(lFieldvalue,FORMAT(lFieldRef.VALUE));
        //#6872//
        lValue := ROUND(pValue, 0.00001);

        pValidate := (lFieldvalue <> lValue) and pValidate;
        //#6872
        if lFieldvalue = lValue then
            exit;
        //#6872//
        if pValidate then
            lFieldRef.Validate(pValue)
        else
            lFieldRef.Value := pValue;
        pRecRef.Modify;

    end;

    local procedure lLoadDocBOQ(pRecRef: RecordRef; pHeader: Boolean; var pBOQMgt: Codeunit "BOQ Management")
    var
        lSonRefs: RecordRef;
        lBOQTmp: Record "BOQ Line" temporary;
        lBOQExist: Boolean;
        lDuplicate: RecordRef;
        lPostMerge: Boolean;
    begin
        /***********************************************
        *               gCalculateDesc                *
        ***********************************************
        * Entrée : RecordRef                          *
        *          Boolean                            *
        *          Codeuit BQ management              *
        * pValue : Néant                              *
        ***********************************************
        * Fonction de chargement d'un métré et de     *
        * construction de l'arborescence du fichier   *
        * xml                                         *
        ***********************************************/
        if pHeader then begin
            pBOQMgt.AddHeader(pRecRef.RecordId);
            pBOQMgt.SetCurrentNode(pRecRef.RecordId);
        end;

        lBOQTmp.DeleteAll;
        //#6834
        //lPostMerge := lMergeBOQ(lBOQTmp,pRecRef);
        //#6834//
        if not lBOQTmp.IsEmpty then begin
            lBOQTmp.FindSet(false, false);
            repeat
                //#6834
                if (lPostMerge) then
                    fPostMerge(lBOQTmp);
                //#6834//
                pBOQMgt.AddBoqLine(lBOQTmp);
            until lBOQTmp.Next = 0;
        end;

        if lGetSonsNode(pRecRef, lSonRefs) then begin
            lSonRefs.FindSet(false, false);
            repeat
                pBOQMgt.SetCurrentNode(pRecRef.RecordId);
                pBOQMgt.AddLine(lSonRefs.RecordId);
                lDuplicate := lSonRefs.Duplicate;
                lLoadDocBOQ(lDuplicate, false, pBOQMgt);
            until lSonRefs.Next = 0;
        end;

    end;

    local procedure lVerifyDocBOQ(pRecRef: RecordRef; pHeader: Boolean; var pBOQMgt: Codeunit "BOQ Management")
    var
        lSonRefs: RecordRef;
        lDuplicate: RecordRef;
    begin
        /***********************************************
        *               gCalculateDesc                *
        ***********************************************
        * Entrée : RecordRef                          *
        *          Boolean                            *
        *          Codeuit BQ management              *
        * pValue : Néant                              *
        ***********************************************
        * Fonction de vérification d'un métré et de   *
        * réparation de l'arborescence du fichier     *
        * xml                                         *
        ***********************************************/
        if pHeader then begin
            if not pBOQMgt.SetCurrentNode(pRecRef.RecordId) then
                pBOQMgt.AddHeader(pRecRef.RecordId);
        end;

        pBOQMgt.SetCurrentNode(pRecRef.RecordId);

        if lGetSonsNode(pRecRef, lSonRefs) then begin
            lSonRefs.FindSet(false, false);
            repeat
                if not pBOQMgt.gNodeExist(lSonRefs.RecordId) then
                    pBOQMgt.AddLine(lSonRefs.RecordId);
                pBOQMgt.gPurgeNodes(lSonRefs.RecordId);
                lDuplicate := lSonRefs.Duplicate;
                lVerifyDocBOQ(lDuplicate, false, pBOQMgt);
            until lSonRefs.Next = 0;
        end;

    end;

    local procedure lGetSonsNode(pRecRef: RecordRef; var pSonRef: RecordRef): Boolean
    var
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
        lStructSalesLine: Record "Sales Line";
        lResource: Record Resource;
        lStructureLine: Record "Structure Component";
        lSalesHeaderArch: Record "Sales Header Archive";
        lSalesLineArch: Record "Sales Line Archive";
        lStcSalesLineArc: Record "Sales Line Archive";
    begin
        /***********************************************
        *                 lGetSonsNode                *
        ***********************************************
        * Entrée : pRecRef : recordref this variable  *
        *                    define the father record *
        *          pSonRef : recordref this variable  *
        *                    define the son records   *
        * pValue : Néant                              *
        ***********************************************
        * Fonction de recherche métier de             *
        * l'arborescence                              *
        ***********************************************/
        case pRecRef.Number of
            Database::"Sales Header":
                begin
                    pRecRef.SetTable(lSalesHeader);
                    lSalesLine.Reset;
                    lSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                    lSalesLine.SetRange("Document Type", lSalesHeader."Document Type");
                    lSalesLine.SetRange("Document No.", lSalesHeader."No.");
                    lSalesLine.SetRange("Attached to Line No.", 0);
                    lSalesLine.SetRange("Structure Line No.", 0);
                    lSalesLine.SetFilter("Line Type", '<>%1', lSalesLine."line type"::" ");
                    pSonRef.GetTable(lSalesLine);
                end;
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lSalesLine);
                    lStructSalesLine.Reset;
                    if lSalesLine."Attached to Line No." = lSalesLine."Line No." then
                        Error('référence cyclique sur le %1 N° %2', lSalesLine."Document Type", lSalesLine."Document No.");
                    case lSalesLine."Line Type" of
                        lSalesLine."line type"::Totaling:
                            begin
                                lStructSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                                lStructSalesLine.SetRange("Document Type", lSalesLine."Document Type");
                                lStructSalesLine.SetRange("Document No.", lSalesLine."Document No.");
                                lStructSalesLine.SetRange("Attached to Line No.", lSalesLine."Line No.");
                                lStructSalesLine.SetRange("Structure Line No.", 0);
                            end;
                        lSalesLine."line type"::Structure:
                            begin
                                lStructSalesLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
                                lStructSalesLine.SetRange("Document Type", lSalesLine."Document Type");
                                lStructSalesLine.SetRange("Document No.", lSalesLine."Document No.");
                                if lSalesLine."Structure Line No." <> 0 then begin
                                    lStructSalesLine.SetRange("Attached to Line No.", lSalesLine."Line No.");
                                    lStructSalesLine.SetRange("Structure Line No.", lSalesLine."Structure Line No.");
                                end else begin
                                    lStructSalesLine.SetRange("Attached to Line No.", 0);
                                    lStructSalesLine.SetRange("Structure Line No.", lSalesLine."Line No.");
                                end;
                            end;
                        else
                            exit(false);
                    end;
                    lStructSalesLine.SetFilter("Line Type", '<>%1', lSalesLine."line type"::" ");
                    pSonRef.GetTable(lStructSalesLine);
                end;
            Database::"Sales Header Archive":
                begin
                    pRecRef.SetTable(lSalesHeaderArch);
                    lSalesLineArch.Reset;
                    lSalesLineArch.SetRange("Document Type", lSalesHeaderArch."Document Type");
                    lSalesLineArch.SetRange("Document No.", lSalesHeaderArch."No.");
                    lSalesLineArch.SetRange("Doc. No. Occurrence", lSalesHeaderArch."Doc. No. Occurrence");
                    lSalesLineArch.SetRange("Version No.", lSalesHeaderArch."Version No.");
                    lSalesLineArch.SetRange("Attached to Line No.", 0);
                    lSalesLineArch.SetRange("Structure Line No.", 0);
                    lSalesLineArch.SetFilter("Line Type", '<>%1', lSalesLineArch."line type"::" ");
                    pSonRef.GetTable(lSalesLineArch);
                end;
            Database::"Sales Line Archive":
                begin
                    pRecRef.SetTable(lSalesLineArch);
                    lStcSalesLineArc.Reset;
                    if lSalesLineArch."Attached to Line No." = lSalesLineArch."Line No." then
                        Error('référence cyclique sur le %1 N° %2', lSalesLineArch."Document Type", lSalesLineArch."Document No.");
                    case lSalesLineArch."Line Type" of
                        lSalesLineArch."line type"::Totaling:
                            begin
                                lStcSalesLineArc.SetCurrentkey("Document Type", "Document No.", "Doc. No. Occurrence",
                                "Version No.", "Gen. Prod. Posting Group", "Line Type", "Structure Line No.", Quantity);
                                //lStructSalesLine.SETCURRENTKEY("Document Type","Document No.","Attached to Line No.","Structure Line No.");
                                lStcSalesLineArc.SetRange("Document Type", lSalesLineArch."Document Type");
                                lStcSalesLineArc.SetRange("Document No.", lSalesLineArch."Document No.");
                                lStcSalesLineArc.SetRange("Doc. No. Occurrence", lSalesLineArch."Doc. No. Occurrence");
                                lStcSalesLineArc.SetRange("Version No.", lSalesLineArch."Version No.");
                                lStcSalesLineArc.SetRange("Attached to Line No.", lSalesLineArch."Line No.");
                                lStcSalesLineArc.SetRange("Structure Line No.", 0);
                            end;
                        lSalesLineArch."line type"::Structure:
                            begin
                                lStcSalesLineArc.SetCurrentkey("Document Type", "Document No.", "Doc. No. Occurrence",
                                "Version No.", "Gen. Prod. Posting Group", "Line Type", "Structure Line No.", Quantity);
                                //lStructSalesLine.SETCURRENTKEY("Document Type","Document No.","Attached to Line No.","Structure Line No.");
                                lStcSalesLineArc.SetRange("Document Type", lSalesLineArch."Document Type");
                                lStcSalesLineArc.SetRange("Document No.", lSalesLineArch."Document No.");
                                lStcSalesLineArc.SetRange("Doc. No. Occurrence", lSalesLineArch."Doc. No. Occurrence");
                                lStcSalesLineArc.SetRange("Version No.", lSalesLineArch."Version No.");
                                if lSalesLineArch."Structure Line No." <> 0 then begin
                                    lStcSalesLineArc.SetRange("Attached to Line No.", lSalesLineArch."Line No.");
                                    lStcSalesLineArc.SetRange("Structure Line No.", lSalesLineArch."Structure Line No.");
                                end else begin
                                    lStcSalesLineArc.SetRange("Attached to Line No.", 0);
                                    lStcSalesLineArc.SetRange("Structure Line No.", lSalesLineArch."Line No.");
                                end;
                            end;
                        else
                            exit(false);
                    end;
                    lStcSalesLineArc.SetFilter("Line Type", '<>%1', lSalesLineArch."line type"::" ");
                    pSonRef.GetTable(lStcSalesLineArc);
                end;
            Database::Resource:
                begin
                    pRecRef.SetTable(lResource);
                    lStructureLine.SetRange("Parent Structure No.", lResource."No.");
                    lStructureLine.SetFilter(Type, '<>%1', lStructureLine.Type::" ");
                    pSonRef.GetTable(lStructureLine);
                end;
            else
                exit(false);
        end;
        exit(not pSonRef.IsEmpty);

    end;


    procedure fShowBOQLine(pRecRef: RecordRef) Return: Boolean
    var
        lT37: Record "Sales Line";
        lT36: Record "Sales Header";
        lT5107: Record "Sales Header Archive";
        lT5108: Record "Sales Line Archive";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
        lRecRef: RecordRef;
        //GL2024 NAVIBAT   lBOQForm: Page 8001449;
        lSalesHeader: Record "Sales Header";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lFormReadOnly: Boolean;
        lT8001436: Record "BOQ Template";
        //GL2024 NAVIBAT   lRepRestoreDocTot: Report 8004005;
        lEvaluation: Boolean;
    //GL2024 NAVIBAT   lBOQPage: Page 8001449;
    begin
        /***********************************************
        *               fShowBOQLine                  *
        ***********************************************
        * Entrée : pRecRef                            *
        * Sortie : Néant                              *
        ***********************************************
        * Fonction d'affichage d'un métré             *
        ***********************************************/
        lFormReadOnly := pRecRef.Number in [Database::"Sales Header Archive", Database::"Sales Line Archive"];
        //#8626
        lEvaluation := false;
        //#8626//
        case pRecRef.Number of
            Database::"Sales Header":
                begin
                    pRecRef.SetTable(lT36);
                    if not wBOQMgt.Load(pRecRef.RecordId) then
                        gLoadSalesBOQ(lT36);
                    //#7142
                    //lBOQForm.fSetEvaluate(TRUE);
                    //#7142//
                    //#8626
                    lEvaluation := true;
                    //#8626//
                    //#7202
                    // uniquement sur table 36 et Rider toOrder No. <> '' et document type = devis
                    lFormReadOnly := ((lT36."Document Type" = lT36."document type"::Quote) and (lT36."Rider to Order No." <> ''));
                    //#7202//
                end;
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lT37);
                    lT36.Get(lT37."Document Type", lT37."Document No.");
                    lRecRef.GetTable(lT36);
                    if not wBOQMgt.Load(lRecRef.RecordId) then
                        gLoadSalesBOQ(lT36);
                    //#7142
                    //lBOQForm.fSetEvaluate(TRUE);
                    //#7142//
                    //#8626
                    lEvaluation := true;
                    //#8626//
                end;
            Database::"Sales Header Archive":
                begin
                    pRecRef.SetTable(lT5107);
                    if not wBOQMgt.Load(pRecRef.RecordId) then
                        gLoadSalesArchBOQ(lT5107);
                    //#7142
                    //lBOQForm.fSetEvaluate(TRUE);
                    //#7142//
                    //#8626
                    lEvaluation := true;
                    //#8626//
                end;
            Database::"Sales Line Archive":
                begin
                    pRecRef.SetTable(lT5108);
                    lT5107.Get(lT5108."Document Type", lT5108."Document No.", lT5108."Doc. No. Occurrence", lT5108."Version No.");
                    lRecRef.GetTable(lT5107);
                    if not wBOQMgt.Load(lRecRef.RecordId) then
                        gLoadSalesArchBOQ(lT5107);
                    //#7142
                    //lBOQForm.fSetEvaluate(TRUE);
                    //#7142//
                    //#8626
                    lEvaluation := true;
                    //#8626//
                end;
            Database::Resource:
                begin
                    pRecRef.SetTable(lT156);
                    if not wBOQMgt.Load(pRecRef.RecordId) then
                        gLoadResourceBOQ(lT156);
                    //#7142
                    //lBOQForm.fSetEvaluate(FALSE);
                    //#7142//
                    //#8626
                    lEvaluation := false;
                    //#8626//
                end;
            Database::"Structure Component":
                begin
                    pRecRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    lRecRef.GetTable(lT156);
                    if not wBOQMgt.Load(lRecRef.RecordId) then
                        gLoadResourceBOQ(lT156);
                    //#7142
                    //lBOQForm.fSetEvaluate(FALSE);
                    //#7142//
                    //#8626
                    lEvaluation := false;
                    //#8626//
                end;
            //#7005
            Database::"BOQ Template":
                begin
                    pRecRef.SetTable(lT8001436);
                    if (not wBOQMgt.Load(pRecRef.RecordId)) then
                        gLoadTemplateBOQ(lT8001436);
                    //#7142
                    //lBOQForm.fSetEvaluate(FALSE);
                    //#7142//
                    //#8626
                    lEvaluation := false;
                    //#8626//
                end;
            //#7005//
            else
                Error(TErrorImplement);
        end;
        //#8626
        /* //GL2024 NAVIBAT  if (not ISSERVICETIER) then begin
             lBOQForm.fSetEvaluate(lEvaluation);
             lBOQForm.gSetRecID(pRecRef, lFormReadOnly);
             lBOQForm.LookupMode(true);
             Return := (lBOQForm.RunModal = Action::LookupOK);
         end else begin
             lBOQPage.fSetEvaluate(lEvaluation);
             lBOQPage.gSetRecID(pRecRef, lFormReadOnly);
             lBOQPage.LookupMode(true);
             Return := (lBOQPage.RunModal = Action::LookupOK);
         end;*/

        //#8626//
        if Return then begin
            case pRecRef.Number of
                Database::"Sales Header":
                    begin
                        lT36.SetRange("Document Type", lT36."Document Type");
                        lT36.SetRange("No.", lT36."No.");
                        //#6834
                        /*  //GL2024 NAVIBAT  lRepRestoreDocTot.USEREQUESTFORM(false);
                          lRepRestoreDocTot.SetTableview(lT36);
                          lRepRestoreDocTot.fSetCalculateStructure(true);
                          lRepRestoreDocTot.Run;*/
                        //REPORT.RUN(REPORT::"Restore doc. Totaling",FALSE,FALSE,lT36);
                        //#6834//
                    end;
                Database::"Sales Line":
                    begin
                        lT37.wUpdateLine(lT37, lT37, true);
                    end;
            end;
            wBOQMgt.Save('');
        end;

    end;


    procedure fEvaluate(var pRec: Record "BOQ Line"; precID: RecordID; var pVariant: Variant) return: Boolean
    var
        lBOQCalcMgt: Codeunit "BOQ Calculate Mgt";
        lBOQCustomMgt: Codeunit "BOQ Custom Management";
        lRecTmp: Record "BOQ Line" temporary;
        lDec: Decimal;
        lRecRef: RecordRef;
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lBOQProb: Boolean;
    begin
        /***********************************************
        *               fEvaluate                     *
        ***********************************************
        * Entrée : Record BOQ Line                    *
        *          RecordID                           *
        *          Variant défini la avleur de retour *
        * pValue : Boolean validation du BOQ          *
        ***********************************************
        * Evaluation d'un métré correspondant à un    *
        * ensemble de ligne de métré, un boolean      *
        * retourne si le BOQ a été évalué avec succés *
        ***********************************************/
        //#7142
        fCanCalculate(precID);
        //#7142//
        with pRec do begin
            Reset;
            SetRange(Problem, false);
            lBOQProb := IsEmpty;
            Reset;
            ModifyAll(Problem, false);
            //MODIFYALL(Undefined,FALSE);
            //#6872
            if ((not wBOQCalcMgt.fAsParentVariable()) and (not wBOQCalcMgt.fIsInitialize())) then begin
                lRecTmp.DeleteAll;
                wBOQMgt.GetParentsBillOfQuantity(precID, lRecTmp);
                wBOQCalcMgt.fInitialize;
            end;
            return := wBOQCalcMgt.fCalculateBOQ(lRecTmp, pRec);
            //#6872//
            if not return then
                //#6872
                pVariant := wBOQCalcMgt.fGetErrorMessage
            //#6872//
            else begin
                //#6872
                pVariant := wBOQCalcMgt.fGetResult;
                if (not Evaluate(lDec, Format(pVariant))) then
                    lDec := 0;
                //#6872//
                wBOQMgt.SetValueNode(precID, lDec);
            end;
            Reset;
            SetRange(Problem, false);
            if not lBOQProb = IsEmpty then begin
                wBOQMgt.SaveBoqLines(precID, pRec);
                wBOQMgt.Save('');
            end;
            Reset;
        end;

    end;


    procedure fCalculate(var pRec: Record "BOQ Line" temporary; var pRecRef: RecordRef; pLocal: Boolean; pWithDesc: Boolean)
    var
        lVar: Variant;
        lDec: Decimal;
        lRecRef: RecordRef;
        lEvaluateOK: Boolean;
        lBOQCalcMgt: Codeunit "BOQ Calculate Mgt";
    begin
        /***********************************************
        *               fCalculate                    *
        ***********************************************
        * Entrée : Record BOQ Line                    *
                   RecordID                           *
        *          boolean défini le niveau           *
        *                   local du métré            *
        *          boolean calcul de la descendance   *
        * pValue : Néant                              *
        ***********************************************
        * calcul d'un métré correspondant à un        *
        * ensemble de ligne de métré                  *
        ***********************************************/
        lEvaluateOK := fEvaluate(pRec, pRecRef.RecordId, lVar);
        //#6872
        lEvaluateOK := lEvaluateOK and Evaluate(lDec, Format(lVar));
        pRec.Reset;
        //#6872//
        if lEvaluateOK then begin
            gAssignValueToOwnerRef(pRecRef, pLocal, lDec);
            //#6872
            if not wBOQCalcMgt.fEvaluateBOQ(pRec) and lEvaluateOK then begin
                wBOQMgt.SaveBoqLines(pRecRef.RecordId, pRec);
                Message(wBOQCalcMgt.fGetErrorMessage());
                //#6872//
            end;
            // RAZ du resultat
            wBOQCalcMgt.fClearResult;
            //#9170
            Clear(wBOQCalcMgt);
            //#9170//
        end else begin
            wBOQMgt.SaveBoqLines(pRecRef.RecordId, pRec);
            wBOQMgt.Save('');
        end;

        if pWithDesc then begin
            if not lEvaluateOK then begin
                //#6872
                pRec.Reset;
                //    wBOQMgt.SaveBoqLines(pRecRef.RECORDID,pRec);
                //#6872//
            end;
            //#6872
            gCalculateDesc(pRecRef);
            //#6872//
            wBOQMgt.SaveBoqLines(pRecRef.RecordId, pRec);
            wBOQMgt.Save('');
        end;

    end;


    procedure gCalculateDesc(pRecRef: RecordRef)
    var
        //GL2024 Automation non compatible   lXmlNode: Automation;
        //GL2024 Automation non compatible   lListXmlNode: Automation;
        lIndex: Integer;
        lRecTmp: Record "BOQ Line" temporary;
        lRecID: RecordID;
        lProgressBar: Codeunit "Progress Dialog2";
        lRecRef: RecordRef;
    begin
        /***********************************************
        *               gCalculateDesc                *
        ***********************************************
        * Entrée : RecordID                           *
        * pValue : Néant                              *
        ***********************************************
        * fonction de calcul de la descendance        *
        ***********************************************/
        //GL2024 Automation non compatible wBOQMgt.GetChildNodes(pRecRef.RecordId, lListXmlNode);
        //#6872
        //GL2024 Automation non compatible   lProgressBar.Open(tDescendantCalc, lListXmlNode.length());
        //#6872//

        /* //GL2024 Automation non compatible  for lIndex := lListXmlNode.length() - 1 downto 0 do begin
              lXmlNode := lListXmlNode.nextNode();
           //GL2024 Automation non compatible    wBOQMgt.fgetRecordID(lXmlNode, lRecID);
              Clear(lRecTmp);
              lRecTmp.Reset;
              lRecTmp.DeleteAll;
              wBOQMgt.GetBillOfQuantity(lRecID, lRecTmp);
              if not lRecTmp.IsEmpty then begin
                  if lRecRef.Get(lRecID) then;
                  fCalculate(lRecTmp, lRecRef, true, false);
                  //    wBOQMgt.SaveBoqLines(lRecID,lRecTmp);
              end;
              //#6872
              lProgressBar.Update();
              //#6872//
          end;*/
        //#6872
        lProgressBar.Close();
        //#6872//

    end;


    procedure fCalcBOQRef(var pRecRef: RecordRef; pLocal: Boolean; pWithDesc: Boolean)
    var
        lRecTmp: Record "BOQ Line" temporary;
        lRecRef: RecordRef;
    begin
        /***********************************************
        *               fCalcBOQRef                   *
        ***********************************************
        * Entrée : RecordRef                          *
        *          boolean défini le niveau           *
        *                   local du métré            *
        *          boolean calcul de la descendance   *
        * pValue : Néant                              *
        ***********************************************
        * calcul d'un métré correspondant à un        *
        *  recordref                                  *
        ***********************************************/
        fGetOwnerRef(pRecRef, lRecRef);
        if not wBOQMgt.Load(lRecRef.RecordId) then
            exit;
        //#6872
        lRecTmp.DeleteAll;
        //#6872//
        wBOQMgt.GetBillOfQuantity(pRecRef.RecordId, lRecTmp);
        fCalculate(lRecTmp, pRecRef, pLocal, pWithDesc);
        pRecRef.Get(pRecRef.RecordId);

    end;


    procedure gOnInsert(pRecRef: RecordRef)
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
        lT5107: Record "Sales Header Archive";
        lT5108: Record "Sales Line Archive";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lFatherRef: RecordRef;
    begin
        /***********************************************
        *               gOnInsert                     *
        ***********************************************
        * Entrée : RecordRef                          *
        * pValue : Néant                              *
        ***********************************************
        * Trigger d'insertion d'un BOQ                *
        ***********************************************/

        case pRecRef.Number of
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lT37);
                    lSingleInstance.wGetSalesHeader(lT36, lT37."Document Type", lT37."Document No.");
                    lFatherRef.GetTable(lT36);
                    if not wBOQMgt.Load(lFatherRef.RecordId) then
                        gLoadSalesBOQ(lT36);
                    //EXIT;
                    gGetFatherNode(pRecRef, lFatherRef);
                    wBOQMgt.AppendNodeAt(lFatherRef.RecordId, pRecRef.RecordId);
                end;
            Database::"Structure Component":
                begin
                    pRecRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    lFatherRef.GetTable(lT156);
                    if not wBOQMgt.Load(lFatherRef.RecordId) then
                        gLoadResourceBOQ(lT156);
                    //EXIT;
                    wBOQMgt.AppendNodeAt(lFatherRef.RecordId, pRecRef.RecordId);
                end;
            Database::"Sales Line Archive":
                begin
                    pRecRef.SetTable(lT5108);
                    lT5107.Get(lT5108."Document Type", lT5108."Document No.", lT5108."Doc. No. Occurrence", lT5108."Version No.");
                    lFatherRef.GetTable(lT5107);
                    if not wBOQMgt.Load(lFatherRef.RecordId) then
                        gLoadSalesArchBOQ(lT5107);
                    //EXIT;

                    gGetFatherNode(pRecRef, lFatherRef);
                    wBOQMgt.AppendNodeAt(lFatherRef.RecordId, pRecRef.RecordId);
                end;

            else
                Error(TErrorImplement);
        end;
        wBOQMgt.Save('');

    end;


    procedure gOndelete(pRecRef: RecordRef; pDeleteContain: Boolean)
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lFatherRef: RecordRef;
        lTBOQ: Record "BOQ Doc Xml Format";
        lRecID: RecordID;
    begin
        /***********************************************
        *               gOnDelete                     *
        ***********************************************
        * Entrée : RecordRef                          *
        *          Boolean                            *
        * pValue : Néant                              *
        ***********************************************
        * Trigger d'insertion d'un BOQ                *
        ***********************************************/
        case pRecRef.Number of
            //#7005 --- #7777
            Database::"Sales Header", Database::Resource, Database::"BOQ Template", Database::"Sales Header Archive":
                begin
                    //#7005 --- #7777//
                    lTBOQ.SetCurrentkey(RecordID);
                    lRecID := pRecRef.RecordId;
                    lTBOQ.SetFilter(RecordID, Format(lRecID));
                    if not lTBOQ.IsEmpty then
                        lTBOQ.DeleteAll;
                    wBOQMgt.Finalize();
                end;
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lT37);
                    lSingleInstance.wGetSalesHeader(lT36, lT37."Document Type", lT37."Document No.");
                    lFatherRef.GetTable(lT36);
                    if wBOQMgt.Load(lFatherRef.RecordId) then begin
                        wBOQMgt.DeleteNode(pRecRef.RecordId, pDeleteContain);
                        wBOQMgt.Save('');
                    end;
                end;
            Database::"Structure Component":
                begin
                    pRecRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    lFatherRef.GetTable(lT156);
                    if wBOQMgt.Load(lFatherRef.RecordId) then begin
                        wBOQMgt.DeleteNode(pRecRef.RecordId, pDeleteContain);
                        wBOQMgt.Save('');
                    end;
                end;
            else
                Error(TErrorImplement);
        end;

    end;


    procedure gOnValidateField(pToRecRef: RecordRef; pFromRecRef: RecordRef)
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lFatherRef: RecordRef;
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
    begin
        /***********************************************
        *             gOnValidateField                *
        ***********************************************
        * Entrée : RecordRef source                   *
        *          RecordRef Destination              *
        * pValue : Néant                              *
        ***********************************************
        * fonction de copy de BOQ                     *
        ***********************************************/
        case pToRecRef.Number of
            Database::"Sales Line":
                begin
                    pToRecRef.SetTable(lT37);
                    lT36.Get(lT37."Document Type", lT37."Document No.");
                    lFatherRef.GetTable(lT36);
                    if wBOQMgt.CopyBOQFrom(lFatherRef.RecordId, pFromRecRef.RecordId, lFatherRef.RecordId, pToRecRef.RecordId, false) then
                        wBOQMgt.Save('');
                end;
            Database::"Structure Component":
                begin
                    pToRecRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    lFatherRef.GetTable(lT156);
                    if wBOQMgt.CopyBOQFrom(lFatherRef.RecordId, pFromRecRef.RecordId, lFatherRef.RecordId, pToRecRef.RecordId, false) then
                        wBOQMgt.Save('');
                end;
            else
                Error(TErrorImplement);
        end;

    end;


    procedure gMoveChid(pRec: Record "Sales Line")
    var
        lChildLine: Record "Sales Line";
        lChildRef: RecordRef;
        lFatherRef: RecordRef;
    begin
        /***********************************************
        *                gMoveChild                   *
        ***********************************************
        * Entrée : Record SalesLine                   *
        * pValue : Néant                              *
        ***********************************************
        * fonction de réorganisation del'arbre XML    *
        * à partir deu déplacement des lignes dans le *
        * document de vente                           *
        ***********************************************/
        if pRec."Line Type" <> pRec."line type"::Totaling then
            exit;

        lFatherRef.GetTable(pRec);

        lChildLine.SetCurrentkey("Document Type", "Document No.", "Attached to Line No.", "Structure Line No.");
        lChildLine.SetRange("Document Type", pRec."Document Type");
        lChildLine.SetRange("Document No.", pRec."Document No.");
        lChildLine.SetRange("Structure Line No.", 0);
        lChildLine.SetRange("Attached to Line No.", pRec."Line No.");
        lChildLine.SetFilter("Line Type", '<>%1', pRec."line type"::" ");
        if lChildLine.IsEmpty then
            exit;

        lChildLine.FindSet(false, false);
        repeat
            lChildRef.GetTable(lChildLine);
            wBOQMgt.AssignFatherNode(lFatherRef.RecordId, lChildRef.RecordId);
        until lChildLine.Next = 0;
        wBOQMgt.Save('');

    end;


    procedure gDuplicateBOQXMLDoc(pFromRecRef: RecordRef; pToRecRef: RecordRef) return: Boolean
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT5107: Record "Sales Header Archive";
        lT5108: Record "Sales Line Archive";
        lRecRef5108: RecordRef;
        lRecRef37: RecordRef;
        lBOQXMLDoc: Record "BOQ Doc Xml Format";
        lToBOQXMLDoc: Record "BOQ Doc Xml Format";
        lBasic: Codeunit Basic;
    begin
        lBOQXMLDoc.SetCurrentkey(RecordID);
        lBOQXMLDoc.SetFilter(RecordID, Format(pToRecRef.RecordId));
        if lBOQXMLDoc.FindFirst then
            lBOQXMLDoc.Delete;
        lBOQXMLDoc.Reset;
        lBOQXMLDoc.SetCurrentkey(RecordID);
        lBOQXMLDoc.SetFilter(RecordID, Format(pFromRecRef.RecordId));
        if not lBOQXMLDoc.IsEmpty then begin
            lBOQXMLDoc.FindFirst;
            lBOQXMLDoc.CalcFields(lBOQXMLDoc.BOQXML);
            lToBOQXMLDoc.TransferFields(lBOQXMLDoc, true);
            lToBOQXMLDoc.RecordID := pToRecRef.RecordId;
            return := lToBOQXMLDoc.Insert(true);
        end;
        exit(return);
    end;


    procedure gArchiveBOQMgt(pFromRecRef: RecordRef; pToRecRef: RecordRef)
    var
        lToRecRef: RecordRef;
        lFromRecRef: RecordRef;
        lFromFieldRef: FieldRef;
        lToFieldRef: FieldRef;
        lBasic: Codeunit Basic;
        lBOQMgt: Codeunit "BOQ Management";
    begin
        if gDuplicateBOQXMLDoc(pFromRecRef, pToRecRef) then
            if lBOQMgt.Load(pToRecRef.RecordId) then begin
                lBOQMgt.fSearchReplaceAttValue(Format(pFromRecRef.RecordId), Format(pToRecRef.RecordId), 'Node', 'RecordID');
                lGetSonsNode(pFromRecRef, lFromRecRef);
                if lFromRecRef.FindFirst then begin
                    lFromFieldRef := lFromRecRef.Field(4);
                    lGetSonsNode(pToRecRef, lToRecRef);
                    lToRecRef.FindFirst;
                    lToFieldRef := lToRecRef.Field(4);
                    lBOQMgt.fSearchReplaceAttValue(
                        lBasic.StrReplace(Format(lFromRecRef.RecordId), Format(lFromFieldRef.Value), '*', true, false),
                        lBasic.StrReplace(Format(lToRecRef.RecordId), Format(lToFieldRef.Value), '*', true, false),
                        'Node', 'RecordID');
                end;
                lBOQMgt.Save('');
                lBOQMgt.Load(pFromRecRef.RecordId);
            end;
    end;


    procedure gQuickCopyBOQMgt(pFromRecRef: RecordRef; pToRecRef: RecordRef)
    var
        lToRecRef: RecordRef;
        lFromRecRef: RecordRef;
        lFromFieldRef: FieldRef;
        lToFieldRef: FieldRef;
        lBasic: Codeunit Basic;
        lBOQMgt: Codeunit "BOQ Management";
    begin
        if gDuplicateBOQXMLDoc(pFromRecRef, pToRecRef) then
            if lBOQMgt.Load(pToRecRef.RecordId) then begin
                lBOQMgt.fSearchReplaceAttValue(Format(pFromRecRef.RecordId), Format(pToRecRef.RecordId), 'Node', 'RecordID');
                lGetSonsNode(pFromRecRef, lFromRecRef);
                if lFromRecRef.FindFirst then begin
                    case lFromRecRef.Number of
                        Database::"Sales Line":
                            lFromFieldRef := lFromRecRef.Field(4);
                        Database::"Structure Component":
                            lFromFieldRef := lFromRecRef.Field(2);
                    end;
                    lGetSonsNode(pToRecRef, lToRecRef);
                    lToRecRef.FindFirst;
                    case lToRecRef.Number of
                        Database::"Sales Line":
                            lToFieldRef := lToRecRef.Field(4);
                        Database::"Structure Component":
                            lToFieldRef := lToRecRef.Field(2);
                    end;
                    lBOQMgt.fSearchReplaceAttValue(
                        lBasic.StrReplace(Format(lFromRecRef.RecordId), Format(lFromFieldRef.Value), '*', true, false),
                        lBasic.StrReplace(Format(lToRecRef.RecordId), Format(lToFieldRef.Value), '*', true, false),
                        'Node', 'RecordID');
                end;
                lBOQMgt.Save('');
                lBOQMgt.Load(pFromRecRef.RecordId);
            end;
    end;


    procedure fGetOwnerRef(FromRef: RecordRef; var OwnerRef: RecordRef)
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
    begin
        /***********************************************
        *                fGetOwnerRef                 *
        ***********************************************
        * Entrée : Recordref Source                   *
        *          Recordref Entête                   *
        * pValue : Néant                              *
        ***********************************************
        * Fonction qui détermine l'entête d'un        *
        * document                                    *
        ***********************************************/
        case FromRef.Number of
            Database::"Sales Header":
                OwnerRef := FromRef.Duplicate;
            Database::"Sales Line":
                begin
                    FromRef.SetTable(lT37);
                    lT36.Get(lT37."Document Type", lT37."Document No.");
                    OwnerRef.GetTable(lT36);
                end;
            Database::Resource:
                OwnerRef := FromRef.Duplicate;
            Database::"Structure Component":
                begin
                    FromRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    OwnerRef.GetTable(lT156);
                end;
            //#7005
            Database::"BOQ Template":
                OwnerRef := FromRef.Duplicate;
        //#7005//
        end

    end;


    procedure fGetFieldNo(pFromRecID: RecordID; pFromField: Integer; pToRecID: RecordID) pToField: Integer
    var
        lT8004070: Record "Structure Component";
        lT37: Record "Sales Line";
    begin
        /***********************************************
        *                fGetFieldNo                  *
        ***********************************************
        * Entrée : RecordID  Source                   *
        *          Integer N° champ source            *
        *          RecordID Destination               *
        * pValue : Integer N° champ destination       *
        ***********************************************
        * Fonction retourne le n° de champ de         *
        * destination à partir d'un champ défini      *
        * dans une table source                       *
        ***********************************************/
        case pFromRecID.TableNo of
            Database::"Sales Line":
                if (pToRecID.TableNo = Database::"Structure Component") then begin
                    with lT37 do
                        case pFromField of
                            FieldNo("Number of Resources"):
                                pToField := lT8004070.FieldNo("Number of Resources");
                            FieldNo("Rate Quantity"):
                                pToField := lT8004070.FieldNo("Rate Quantity");
                            FieldNo("Quantity Fixed"):
                                pToField := lT8004070.FieldNo("Fixed Quantity");
                            FieldNo("Quantity per"):
                                pToField := lT8004070.FieldNo("Quantity per");
                            FieldNo("Value 1"):
                                pToField := lT8004070.FieldNo("Value 1");
                            FieldNo("Value 2"):
                                pToField := lT8004070.FieldNo("Value 2");
                            FieldNo("Value 3"):
                                pToField := lT8004070.FieldNo("Value 3");
                            FieldNo("Value 4"):
                                pToField := lT8004070.FieldNo("Value 4");
                            FieldNo("Value 5"):
                                pToField := lT8004070.FieldNo("Value 5");
                            FieldNo("Value 6"):
                                pToField := lT8004070.FieldNo("Value 6");
                            FieldNo("Value 7"):
                                pToField := lT8004070.FieldNo("Value 7");
                            FieldNo("Value 8"):
                                pToField := lT8004070.FieldNo("Value 8");
                            FieldNo("Value 9"):
                                pToField := lT8004070.FieldNo("Value 9");
                            FieldNo("Value 10"):
                                pToField := lT8004070.FieldNo("Value 10");
                            else
                                exit(pFromField);
                        end;
                end else
                    exit(pFromField);
            Database::"Structure Component":
                if (pToRecID.TableNo = Database::"Sales Line") then begin
                    with lT8004070 do
                        case pFromField of
                            FieldNo("Number of Resources"):
                                pToField := lT37.FieldNo("Number of Resources");
                            FieldNo("Rate Quantity"):
                                pToField := lT37.FieldNo("Rate Quantity");
                            FieldNo("Fixed Quantity"):
                                pToField := lT37.FieldNo("Quantity Fixed");
                            FieldNo("Quantity per"):
                                pToField := lT37.FieldNo("Quantity per");
                            FieldNo("Value 1"):
                                pToField := lT37.FieldNo("Value 1");
                            FieldNo("Value 2"):
                                pToField := lT37.FieldNo("Value 2");
                            FieldNo("Value 3"):
                                pToField := lT37.FieldNo("Value 3");
                            FieldNo("Value 4"):
                                pToField := lT37.FieldNo("Value 4");
                            FieldNo("Value 5"):
                                pToField := lT37.FieldNo("Value 5");
                            FieldNo("Value 6"):
                                pToField := lT37.FieldNo("Value 6");
                            FieldNo("Value 7"):
                                pToField := lT37.FieldNo("Value 7");
                            FieldNo("Value 8"):
                                pToField := lT37.FieldNo("Value 8");
                            FieldNo("Value 9"):
                                pToField := lT37.FieldNo("Value 9");
                            FieldNo("Value 10"):
                                pToField := lT37.FieldNo("Value 10");
                            else
                                exit(pFromField);
                        end;
                end else
                    exit(pFromField);
            else
                exit(pFromField);
        end;

    end;


    procedure fChangeVarformula(pText: Text[255]; pVariable: Boolean) return: Text[255]
    var
        lChar: Char;
        lNextChar: Char;
        i: Integer;
        "max": Integer;
        lIntegerValue: Integer;
    begin
        //#7752 Ajout du parametre pVariable
        return := '';
        if pText = '' then
            exit('');
        max := StrLen(pText);
        //#7115
        if (max = 1) then begin
            //#7752
            if (pText = '"') then
                exit('GUILLEMET');
            if (pText = ':') then
                exit('DEUXPOINTS');
            if (pText = '-') then
                exit('MOINS');
            if (pText = '''') then
                exit('FORMULE');
            if (pText = '.') or (pText = ',') then
                exit('POINT');
            //#7752//
            if (pText = '=') then
                exit('')
            else begin
                // You attention please, if you have just one caracter, you must to test, if this one is not a integer
                if (Evaluate(lIntegerValue, pText)) then begin
                    //EXIT(pText)
                    if (pVariable) then
                        exit('VARIABLE_' + pText)
                    else
                        exit(pText);
                end else
                    //#7839
                    exit(pText + '_' + pText);
                //#7839//
            end;
        end;
        //#7115//
        for i := 1 to max do begin
            if i = max then begin
                return += fTransformCharacter(pText[i]);
                //#7839
                if (pText[i - 1] in ['*', '/', '-', '+', ':', '{', '(', '[', ']', ')', '}', ' ']) and
                   ((pText[i] in ['A' .. 'Z']) or (pText[i] in ['a' .. 'z'])) then
                    return += '_' + fTransformCharacter(pText[i]);
                //#7839//
            end else begin
                return += fTransformCharacter(pText[i]);
                if (pText[i + 1] in ['0' .. '9']) and
                   ((pText[i] in ['A' .. 'Z']) or (pText[i] in ['a' .. 'z'])) then
                    return += '_';
                if (pText[i] = '=') and (StrPos('IF', return) = 0) then
                    return := '';
                //#7839
                if (pText[i + 1] in ['*', '/', '-', '+', ':', '{', '(', '[', ']', ')', '}']) and
                   ((pText[i] in ['A' .. 'Z']) or (pText[i] in ['a' .. 'z'])) then begin
                    if (i = 1) then begin
                        return += '_' + fTransformCharacter(pText[i]);
                    end else begin
                        if (not (pText[i - 1] in ['A' .. 'Z']) and not (pText[i - 1] in ['a' .. 'z']) and not (pText[i - 1] in ['0' .. '9'])) then
                            return += '_' + fTransformCharacter(pText[i]);
                    end;
                end;
                //#7839//
            end;
        end;
    end;


    procedure fChangeRoundFonct(pText: Text[255]; var pReturn: Text[255]): Boolean
    var
        lxChar: Char;
        lChar: Char;
        i: Integer;
        pos: Integer;
        "max": Integer;
        nbPar: Integer;
        nbPreviousPar: Integer;
        lInt: Integer;
        lxInt: Integer;
        lOK: Boolean;
    begin
        if pText = '' then
            exit(false);
        pos := StrPos(pText, tRound);
        if pos = 0 then begin
            pReturn += pText;
            exit(false);
        end;
        max := StrLen(pText);
        for i := 1 to pos + StrLen(tRound) do begin
            if i < pos then begin
                if pText[i] = '(' then nbPreviousPar += 1;
                if pText[i] = ')' then nbPreviousPar -= 1;
            end;
            if pText[i] = '(' then nbPar += 1;
            if pText[i] = ')' then nbPar -= 1;
            pReturn += Format(pText[i]);
        end;
        i := pos + StrLen(tRound) + 1;
        lOK := (i <= max);
        lxChar := pText[i];
        while lOK do begin
            lChar := pText[i];
            if lChar = '(' then nbPar += 1;
            if lChar = ')' then nbPar -= 1;

            if (lChar = ';') and (nbPar - nbPreviousPar = 1) then begin
                while (pText[i] <> ')') and (i < max) do begin
                    if pText[i] = '(' then nbPar += 1;
                    if pText[i] = ')' then nbPar -= 1;
                    pReturn += Format(pText[i]);
                    i += 1;
                end;
                exit(fChangeRoundFonct(CopyStr(pText, i), pReturn));
            end;

            if (lxChar <> lChar) and
               (nbPar = 0) and
               (lChar = ')') then begin
                //#6872
                pReturn += ';2' + Format(lChar);
                //#6872//
                exit(fChangeRoundFonct(CopyStr(pText, i + 1), pReturn));
            end else
                pReturn += Format(lChar);
            lxChar := lChar;
            i += 1;
            lOK := (i <= max);
        end;
    end;


    procedure fShowUseVariable(var pRec: Record "BOQ Line"; pRecordID: RecordID) return: Text[150]
    var
        //GL2024 NAVIBAT   lBoqFrmVar: Page 8001465;
        lCloseForm: Boolean;
    begin
        //#6592
        /***********************************************
        *               fShowUseVariable              *
        ***********************************************
        * Entrée : Record BOQ Line                    *
        *          RecordID                           *
        * Sortie : Néant                              *
        ***********************************************
        * Affiche la fenetre des variables disponibles*
        * pour la formule en cours                    *
        ***********************************************/
        return := '';
        /* //GL2024 NAVIBAT    Clear(lBoqFrmVar);
           lBoqFrmVar.fSetVariable(pRecordID, pRec);
           lCloseForm := (lBoqFrmVar.RunModal = Action::LookupOK);
           if lCloseForm then
               return := lBoqFrmVar.fGetVariableCode();*/
        //#6592//

    end;


    procedure fGetTypeLineBoq(pRecRef: RecordRef; var pTypeLine: Option General,Totaling,Line,Detail)
    var
        lT37: Record "Sales Line";
        lT5108: Record "Sales Line Archive";
    begin
        //#6592
        /***********************************************
        *               fGetTypeLineBoq               *
        ***********************************************
        * Entrée : pRecRef                            *
        *        : Type de ligne du boq               *
        * Sortie : Néant                              *
        ***********************************************
        * Détermine le type de ligne du BOQ           *
        ***********************************************/
        case pRecRef.Number of
            Database::"Sales Header":
                begin
                    pTypeLine := Ptypeline::General;
                end;
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lT37);
                    if (lT37."Line Type" = lT37."line type"::Totaling) then begin
                        pTypeLine := Ptypeline::Totaling;
                    end else begin
                        if (lT37."Structure Line No." <> 0) then begin
                            pTypeLine := Ptypeline::Detail;
                        end else begin
                            pTypeLine := Ptypeline::Line;
                        end;
                    end;
                end;
            Database::"Sales Header Archive":
                begin
                    pTypeLine := Ptypeline::General
                end;
            Database::"Sales Line Archive":
                begin
                    pRecRef.SetTable(lT5108);
                    if (lT5108."Line Type" = lT5108."line type"::Totaling) then begin
                        pTypeLine := Ptypeline::Totaling;
                    end else begin
                        if (lT5108."Structure Line No." <> 0) then begin
                            pTypeLine := Ptypeline::Detail;
                        end else begin
                            pTypeLine := Ptypeline::Line;
                        end;
                    end;

                end;
            Database::Resource:
                begin
                    pTypeLine := Ptypeline::General
                end;
            Database::"Structure Component":
                begin
                    pTypeLine := Ptypeline::Line
                end;
            //#7005
            Database::"BOQ Template":
                begin
                    pTypeLine := Ptypeline::General
                end;
            //#7005//
            else
                Error(TErrorImplement);
        end;
        //#6592//

    end;


    procedure fTransformCharacter(pCharacter: Char) return: Text[30]
    begin
        return := '';
        if ((pCharacter in ['0' .. '9']) or (pCharacter in ['A' .. 'Z']) or (pCharacter in ['a' .. 'z'])) then begin
            return := Format(pCharacter);
        end else begin
            // In function of the substitute character
            case (pCharacter) of
                '²':
                    return := '2';
                '%':
                    return := 'PCT';
                //#7752
                ' ':
                    return := '_';
                '''':
                    return := '_';
                '"':
                    return := '_';
                //#7752//
                else
                    return := Format(pCharacter);
            end;
        end;
    end;


    procedure gOnRenameWithChild(pRecRef: RecordRef; pxRecRef: RecordRef)
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
        lT5107: Record "Sales Header Archive";
        lT5108: Record "Sales Line Archive";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lFatherRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
    begin
        /***********************************************
        *               gOnRenameWithChild            *
        ***********************************************
        * Entrée : RecordRef                          *
        * pValue : Néant                              *
        ***********************************************
        * Trigger de renommage d'un BOQ               *
        ***********************************************/

        case pRecRef.Number of
            Database::Resource:
                begin
                    pxRecRef.SetTable(lT156);
                    if not lBOQMgt.Load(pxRecRef.RecordId) then
                        gLoadResourceBOQ(lT156);
                    //lBOQMgt.AppendNodeAt(pRecRef.RECORDID,pxRecRef.RECORDID);
                    lBOQMgt.RenameNodeAt(pRecRef.RecordId, pxRecRef.RecordId);
                    lBOQMgt.RenameChildFrom(pRecRef.RecordId, pxRecRef.RecordId);
                end;
            Database::"Structure Component":
                begin
                    pxRecRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    lFatherRef.GetTable(lT156);
                    if not lBOQMgt.Load(lFatherRef.RecordId) then
                        gLoadResourceBOQ(lT156);
                    lBOQMgt.RenameNodeAt(pRecRef.RecordId, pxRecRef.RecordId);
                    lBOQMgt.RenameChildFrom(pRecRef.RecordId, pxRecRef.RecordId);
                end;
            else
                Error(TErrorImplement);
        end;
        lBOQMgt.Save('');

    end;


    procedure gOnRename(pRecRef: RecordRef; pxRecRef: RecordRef)
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
        lT5107: Record "Sales Header Archive";
        lT5108: Record "Sales Line Archive";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lFatherRef: RecordRef;
        lBOQMgt: Codeunit "BOQ Management";
    begin
        /***********************************************
        *               gOnRename                     *
        ***********************************************
        * Entrée : RecordRef                          *
        * pValue : Néant                              *
        ***********************************************
        * Trigger de renommage d'un BOQ               *
        ***********************************************/

        case pRecRef.Number of
            Database::Resource:
                begin
                    if not lBOQMgt.Load(pxRecRef.RecordId) then
                        exit;
                    pxRecRef.SetTable(lT156);
                    gLoadResourceBOQ(lT156);
                    lBOQMgt.RenameNodeAt(pRecRef.RecordId, pxRecRef.RecordId);
                end;
            Database::"Structure Component":
                begin
                    pxRecRef.SetTable(lT8004070);
                    lT156.Get(lT8004070."Parent Structure No.");
                    lFatherRef.GetTable(lT156);
                    if not lBOQMgt.Load(lFatherRef.RecordId) then
                        gLoadResourceBOQ(lT156);
                    lBOQMgt.RenameNodeAt(pRecRef.RecordId, pxRecRef.RecordId);
                end;
            else
                Error(TErrorImplement);
        end;
        lBOQMgt.Save('');

    end;


    procedure fTransformRound(pFormula: Text[255]) return: Text[255]
    var
        lPosRound: Integer;
        lCountBracket: Integer;
        lBeginFormula: Text[250];
        lEndFormula: Text[250];
        lInternalFormula: Text[250];
        lFormulaIndex: Integer;
        lPosSeparator: Integer;
        lSubInternalFormula: Text[250];
    begin
        //#6834
        lPosRound := StrPos(pFormula, tRound);
        if (lPosRound = 0) then begin
            return := pFormula;
        end else begin
            // Cut the formula string, because, we have need a begin formula, the internal Round and the end formula
            lBeginFormula := CopyStr(pFormula, 1, lPosRound - 1);
            // Now, initialize the bracket number and the internal round
            lCountBracket := 0;
            lInternalFormula := '';
            lFormulaIndex := lPosRound + StrLen(tRound);
            repeat
                // Now, we will find the internal round function
                // It's very simple, because the contain, it was between the '(' and the ')' caracters
                if (pFormula[lFormulaIndex] = '(') then
                    lCountBracket += 1;
                if (pFormula[lFormulaIndex] = ')') then
                    lCountBracket -= 1;
                lInternalFormula += Format(pFormula[lFormulaIndex]);
                lFormulaIndex += 1;
            until (lCountBracket = 0);
            // The InternalRound Contain the '(' and the ')' of the first Round Function
            // We can remove the '(' at the first of this string and the ')' at the end of this string
            lInternalFormula := CopyStr(lInternalFormula, 2, StrLen(lInternalFormula) - 2);
            // Where is the ';' caracter in this internal formula
            lPosSeparator := StrPos(lInternalFormula, ';');
            if (lPosSeparator = 0) then begin
                // Not Exist --> Ok we add the ';0' string at the end of the internalformula
                lInternalFormula += ';0';
            end else begin
                // Exist --> there are a end braket after
                lSubInternalFormula := CopyStr(lInternalFormula, lPosSeparator);
                lPosSeparator := StrPos(lSubInternalFormula, ')');
                if (lPosSeparator = 0) then begin
                    // NON OK, the primitive round function has not the precision parameter
                    // we can add the ';0' at the end of the internal formula
                    lInternalFormula += ';0';
                end;
            end;
            // Now, we can find the end formula
            lEndFormula := CopyStr(pFormula, lFormulaIndex);
            // the return value est the beginformula + tRound + '(' + fTransformRound(lInternalRound) + ')' + fTransformRound(lEndFormula)
            // Because the end formula and the internal round must have a "Round" Function
            return := lBeginFormula + tRound + '(' + fTransformRound(lInternalFormula) + ')' + fTransformRound(lEndFormula);
        end;
        //#6834//
    end;


    procedure fFinalise()
    begin
        //#7128
        wBOQCalcMgt.fFinalize();
        //#7128//
    end;


    procedure fVerifyFormula(var pBOQRec: Record "BOQ Line")
    var
        lText: Text[250];
    begin
        //#6834
        if (pBOQRec.Formula = '') then
            exit;
        if not Codeunit.Run(Codeunit::"BOQ Calculate Mgt", pBOQRec) then begin
            lText := GetLastErrorText;
            pBOQRec.Problem := true;
            pBOQRec.Formula := '"' + pBOQRec.Formula + '"';
            ClearLastError;
        end;
        //#6834//
    end;


    procedure fVerifyUndefined(var pBOQRec: Record "BOQ Line")
    begin
        //#6834
        pBOQRec.Undefined := ((pBOQRec."Variable Code" <> '') and (pBOQRec.Formula = '') and
                               (pBOQRec."Field No." = 0) and (pBOQRec.Value = 0));
        //#6834//
    end;


    procedure fPostMerge(var pBOQ: Record "BOQ Line")
    begin
        //#6834
        fVerifyFormula(pBOQ);
        fVerifyUndefined(pBOQ);
        pBOQ.Modify;
        //#6834//
    end;


    procedure fValidateDocument(pRecRef: RecordRef)
    var
        lT36: Record "Sales Header";
        lT37: Record "Sales Line";
        lT5107: Record "Sales Header Archive";
        lT5108: Record "Sales Line Archive";
        lT156: Record Resource;
        lT8004070: Record "Structure Component";
        lT8001436: Record "BOQ Template";
    //GL2024 NAVIBAT    lRepRestoreDocTot: Report 8004005;
    begin
        //#6834
        /***********************************************
        *               fValidateDocument             *
        ***********************************************
        * Entrée : pRecRef                            *
        * Sortie : Néant                              *
        ***********************************************
        * Fonction permettant d'effectuer un post     *
        * traitement suite à un calcul                *
        ***********************************************/
        case pRecRef.Number of
            Database::"Sales Header":
                begin
                    pRecRef.SetTable(lT36);

                    lT36.SetRange("Document Type", lT36."Document Type");
                    lT36.SetRange("No.", lT36."No.");

                    /*  //GL2024 NAVIBAT   lRepRestoreDocTot.USEREQUESTFORM(false);
                       lRepRestoreDocTot.SetTableview(lT36);
                       lRepRestoreDocTot.fSetCalculateStructure(true);
                       lRepRestoreDocTot.Run;*/
                    //REPORT.RUN(REPORT::"Restore doc. Totaling",FALSE,FALSE,lT36);
                    //#6834//
                end;
            Database::"Sales Line":
                begin
                    pRecRef.SetTable(lT37);
                    lT37.wUpdateLine(lT37, lT37, true);
                end;
            Database::"Sales Header Archive":
                begin
                    pRecRef.SetTable(lT5107);
                end;
            Database::"Sales Line Archive":
                begin
                    pRecRef.SetTable(lT5108);
                end;
            Database::Resource:
                begin
                    pRecRef.SetTable(lT156);
                end;
            Database::"Structure Component":
                begin
                    pRecRef.SetTable(lT8004070);
                end;
            //#7005
            Database::"BOQ Template":
                begin
                    pRecRef.SetTable(lT8001436);
                end;
            //#7005//
            else
                Error(TErrorImplement);
        end;
        //#6834//

    end;


    procedure fCanCalculate(var pRecID: RecordID)
    var
        lRecRef: RecordRef;
    begin
        //#7142
        lRecRef := pRecID.GetRecord;
        case lRecRef.Number of
            Database::"Sales Header":
                begin
                end;
            Database::"Sales Line":
                begin
                end;
            Database::"Sales Header Archive":
                begin
                end;
            Database::"Sales Line Archive":
                begin
                end;
            Database::Resource:
                begin
                    Error(StrSubstNo(tErrCalculate, lRecRef.Caption));
                end;
            Database::"Structure Component":
                begin
                    Error(StrSubstNo(tErrCalculate, lRecRef.Caption));
                end;
            //#7005
            Database::"BOQ Template":
                begin
                    Error(StrSubstNo(tErrCalculate, lRecRef.Caption));
                end;
            //#7005//
            else
                Error(TErrorImplement);
        end;
        //#7142//
    end;


    procedure gManageSalesBOQ(pSalesHeader: Record "Sales Header")
    var
        //GL2024 Automation non compatible  lSrcXmlDoc: Automation;
        lRecordRef: RecordRef;
    begin
        //#7337
        lRecordRef.GetTable(pSalesHeader);
        if not wBOQMgt.Load(lRecordRef.RecordId) then begin
            wBOQMgt.Finalize;
            wBOQMgt.Initialize;
        end;
        // recuperation de l'ancien document avant de la reinitialiser
        //GL2024 Automation non compatible   wBOQMgt.fGetXmlDocument(lSrcXmlDoc);
        // reinit du boqmgt
        wBOQMgt.Finalize;
        wBOQMgt.Initialize;
        //GL2024 Automation non compatible   lManagedDocBOQ(lRecordRef, true, wBOQMgt, lSrcXmlDoc, 0);
        //wBOQMgt.fSaveFile('C:\TEST-TRS.XML');
        lRecordRef.Close;
        //wBOQMgt.Save('C:\Test.xml');
        wBOQMgt.Save('');
        //#7337//
    end;


    /*
     //GL2024 Automation non compatible
       procedure lManagedDocBOQ(pRecRef: RecordRef; pHeader: Boolean; var pBOQMgt: Codeunit "BOQ Management"; var pSrcXmlDoc: Automation; pLevel: Integer)
       var
           lSonRefs: RecordRef;
           lDuplicate: RecordRef;
       begin
           //#7337

           if pHeader then begin
               if not pBOQMgt.SetCurrentNode(pRecRef.RecordId) then
                   pBOQMgt.AddHeader(pRecRef.RecordId);
           end;

           pBOQMgt.SetCurrentNode(pRecRef.RecordId);
           pBOQMgt.fManagedNode(pRecRef.RecordId, pSrcXmlDoc, pLevel);

           if lGetSonsNode(pRecRef, lSonRefs) then begin
               lSonRefs.FindSet(false, false);
               repeat
                   pBOQMgt.SetCurrentNode(pRecRef.RecordId);
                   if not pBOQMgt.gNodeExist(lSonRefs.RecordId) then
                       pBOQMgt.AddLine(lSonRefs.RecordId);
                   //pBOQMgt.fManagedNode(lSonRefs.RECORDID, pSrcXmlDoc, pLevel + 1);
                   lDuplicate := lSonRefs.Duplicate;
                   lManagedDocBOQ(lDuplicate, false, pBOQMgt, pSrcXmlDoc, pLevel + 1);
               until lSonRefs.Next = 0;
           end;
           //#7337//

       end;*/


    procedure gManageSalesArchiveBOQ(var pSalesHeader: Record "Sales Header Archive")
    var
        lRecordRef: RecordRef;
    //GL2024 Automation non compatible lSrcXmlDoc: Automation;
    begin
        //#7337//
        lRecordRef.GetTable(pSalesHeader);
        if not wBOQMgt.Load(lRecordRef.RecordId) then begin
            wBOQMgt.Finalize;
            wBOQMgt.Initialize;
        end;
        // recuperation de l'ancien document avant de la reinitialiser
        //GL2024 Automation non compatible    wBOQMgt.fGetXmlDocument(lSrcXmlDoc);
        // reinit du boqmgt
        wBOQMgt.Finalize;
        wBOQMgt.Initialize;
        //GL2024 Automation non compatible  lManagedDocBOQ(lRecordRef, true, wBOQMgt, lSrcXmlDoc, 0);
        //wBOQMgt.fSaveFile('C:\TEST-TRS.XML');
        lRecordRef.Close;
        //wBOQMgt.Save('C:\Test.xml');
        wBOQMgt.Save('');
        //#7337//
    end;


    procedure gManageStructureBOQ(var pStructure: Record Resource)
    var
        lRecordRef: RecordRef;
    //GL2024 Automation non compatible
    //GL2024 Automation non compatible lSrcXmlDoc: Automation;
    begin
        //#7337
        lRecordRef.GetTable(pStructure);
        if not wBOQMgt.Load(lRecordRef.RecordId) then begin
            wBOQMgt.Finalize;
            wBOQMgt.Initialize;
        end;
        // recuperation de l'ancien document avant de la reinitialiser
        //GL2024 Automation non compatible
        //GL2024 Automation non compatible wBOQMgt.fGetXmlDocument(lSrcXmlDoc);
        // reinit du boqmgt
        wBOQMgt.Finalize;
        wBOQMgt.Initialize;
        //GL2024 Automation non compatible   lManagedDocBOQ(lRecordRef, true, wBOQMgt, lSrcXmlDoc, 0);
        //wBOQMgt.fSaveFile('C:\TEST-TRS.XML');
        lRecordRef.Close;
        //wBOQMgt.Save('C:\Test.xml');
        wBOQMgt.Save('');
        //#7337//
    end;


    procedure fBOQExist(pRecordID: RecordID) Return: Boolean
    var
        lBOQXmlDoc: Record "BOQ Doc Xml Format";
    begin
        //#7645
        /***********************************************
        *                 fBOQExist                   *
        ***********************************************
        * Entrée : RecordID                           *
        * pValue : Booleen                            *
        ***********************************************
        * Renvoie Vrai si un boq existe pour le       *
        * document dont le RecordID est passé en      *
        * parametre                                   *
        ***********************************************/
        Return := false;
        lBOQXmlDoc.SetRange(lBOQXmlDoc.RecordID, pRecordID);
        Return := not lBOQXmlDoc.IsEmpty;
        //#7645//

    end;
}

