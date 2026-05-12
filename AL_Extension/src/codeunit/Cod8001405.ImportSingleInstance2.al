Codeunit 8001405 "Import SingleInstance2"
{
    // 
    // //IMPORT MB 19/03/07 +wGetIESetupExcelStartLineNo +wSetIESetup
    // //+REF+LOGIN AC 18/07/06 Ajout +SetUserID() +GetUserID()
    // //+REF+IMPORT CW 01/08/03 Import SingleInstance
    // //+REF+COTFRN GESWAY 08/08/05 +Set(), +GetCompletePurchOrder()
    // //+REF+OPPORT GESWAY 27/03/06 +SetOpportunityNo() +GetOpportunityNo()

    SingleInstance = true;

    trigger OnRun()
    begin
        wInitSetup;
    end;

    var

        ImportLog: Record "Import Log";
        ImportTrigger: Integer;
        ImportLine: Text[1000];
        ImportSkip: Boolean;
        ImportInit: Boolean;
        Called: Boolean;
        BoolArray: array[20] of Boolean;
        CompletePurchOrder: Boolean;
        OppNo: Code[20];
        //GL2024 Automation non compatible wXmlDoc: Automation;
        wXlsMgt: Codeunit "Excel Management";
        GLSetup: Record "General Ledger Setup";
        wNaviBatSetup: Record NavibatSetup;
        wSalesHeader: Record "Sales Header";
        wNaviBatSetupOK: Boolean;
        wGLSetupOK: Boolean;
        Text8003900: label 'This setup update require to close each session.';
        wCurrencyOK: Boolean;
        wCurrency: Record Currency;
        wInitSalesHeader: Boolean;
        wUSERID: Code[20];
        wIntegrityVerify: Boolean;
        wContact: Record Contact;
        wSalesOverheadIsCalculated: Boolean;
        wFrom: Integer;
        wNumber: Integer;
        wMax: Integer;
        wBOQRecordID: RecordID;
        wBOQDocXml: Record "BOQ Doc Xml Format";
        wDatabaseType: Option CSIDE,SQL;


    procedure Set(var pImportLog: Record "Import Log"; pImportTrigger: Integer)
    begin
        ImportLog := pImportLog;
        ImportTrigger := pImportTrigger;
        Called := false;
    end;


    procedure "Trigger"(): Integer
    begin
        exit(ImportTrigger)
    end;


    procedure Warning(pLevel: Integer; pDescription: Text[1000])
    begin
        ImportLog.Level := pLevel;
        ImportLog.Description := DelStr(pDescription, MaxStrLen(ImportLog.Description));
        Called := true;
    end;


    procedure Get(var pImportLog: Record "Import Log"): Boolean
    begin
        pImportLog := ImportLog;
        exit(Called);
    end;


    procedure SetArray(pIndex: Integer; pBoolean: Boolean)
    begin
        BoolArray[pIndex] := pBoolean;
    end;


    procedure GetArray(pIndex: Integer): Boolean
    begin
        exit(BoolArray[pIndex]);
    end;


    procedure SetLine(var pLine: Text[1000])
    begin
        ImportLine := pLine;
    end;


    procedure GetLine(): Text[1000]
    begin
        exit(ImportLine);
    end;


    procedure SetSkip(pSkip: Boolean)
    begin
        ImportSkip := pSkip;
    end;


    procedure GetSkip(): Boolean
    begin
        exit(ImportSkip);
    end;


    procedure SetInit(pInit: Boolean)
    begin
        ImportInit := pInit;
    end;


    procedure GetInit(): Boolean
    begin
        exit(ImportInit);
    end;


    procedure SetCompletePurchOrder(pCompletePurchOrder: Boolean)
    begin
        //+REF+COTFRN
        CompletePurchOrder := pCompletePurchOrder;
        //+REF+COTFRN//
    end;


    procedure GetCompletePurchOrder(var pCompletePurchOrder: Boolean)
    begin
        //+REF+COTFRN
        pCompletePurchOrder := CompletePurchOrder;
        //+REF+COTFRN//
    end;


    procedure wGetNaviBatSetup(var pNaviBatSetup: Record NavibatSetup)
    begin
        if not wNaviBatSetupOK then
            wNaviBatSetupOK := wNaviBatSetup.Get('');

        //#4797
        wMax := wNaviBatSetup."Number lines before commit";
        if wMax = 0 then
            wMax := 100;
        //#4797//

        pNaviBatSetup := wNaviBatSetup;
    end;


    procedure wGetGLAccount(var pGLSetup: Record "General Ledger Setup")
    begin
        if not wGLSetupOK then
            wGLSetupOK := GLSetup.Get('');
        pGLSetup := GLSetup;
    end;


    procedure wSetNaviBatSetup(pNaviBatSetup: Record NavibatSetup)
    begin
        wNaviBatSetup := pNaviBatSetup;
        Message(Text8003900);
    end;


    procedure wSetGLAccount(pGLSetup: Record "General Ledger Setup")
    begin
        GLSetup := pGLSetup;
        wCurrencyOK := false;
        Message(Text8003900);
    end;


    procedure wInitSetup()
    var
    //GL2024    lDatabaseFile: Record 2000000010;
    begin
        if not wGLSetupOK then
            wGLSetupOK := GLSetup.Get('');
        if not wNaviBatSetupOK then
            wNaviBatSetupOK := wNaviBatSetup.Get('');
        //#8984
        /* //GL2024  if (lDatabaseFile.ReadPermission) then begin
             if (lDatabaseFile.Count() > 1) then
                 wDatabaseType := Wdatabasetype::SQL
             else
                 wDatabaseType := Wdatabasetype::CSIDE;

             lDatabaseFile.FindFirst();
             //lDatabaseFile.CALCFIELDS("File Name");
             if (StrPos(UpperCase(lDatabaseFile."File Name"), '.FDB') <> 0) then begin
                 wDatabaseType := Wdatabasetype::CSIDE;
             end else begin
                 wDatabaseType := Wdatabasetype::SQL;
             end;
             //#8984//
             //#6769
             fCheckTotalingDatabase();
             //#6769//
         end;*/
    end;


    procedure wGetSalesHeader(var pSalesHeader: Record "Sales Header"; pDocType: Option; pDocNo: Code[20])
    var
        lRollBackLog: Record "RollBack Log";
        lBOQCustMgt: Codeunit "BOQ Custom Management";
    begin
        if pDocNo = '' then
            exit;

        if (wSalesHeader."No." <> pDocNo) /*OR wInitSalesHeader*/ then begin
            if not wSalesHeader.Get(pDocType, pDocNo) then
                wSalesHeader.Init;
            pSalesHeader := wSalesHeader;
        end else
            pSalesHeader := wSalesHeader;

        wCurrencyOK := (wCurrency.Code = wSalesHeader."Currency Code");
        if (wCurrency.Code <> pSalesHeader."Currency Code") then
            wSetCurrency(wCurrency, pSalesHeader);

    end;


    procedure wSetSalesHeader(pSalesHeader: Record "Sales Header")
    begin
        wSalesHeader := pSalesHeader;
        wInitSalesHeader := true;
        wCurrencyOK := false;
        //wIntegrityVerify := FALSE;
    end;


    procedure wSetCurrency(var pCurrency: Record Currency; SalesHeader: Record "Sales Header")
    begin
        if not wCurrencyOK or (wCurrency.Code <> SalesHeader."Currency Code")
           or (SalesHeader."Currency Code" <> '') then begin
            if SalesHeader."Currency Code" = '' then begin
                Clear(wCurrency);
                wCurrency.Init;
                wCurrency.InitRoundingPrecision
            end else begin
                SalesHeader.TestField("Currency Factor");
                wCurrency.Get(SalesHeader."Currency Code");
                wCurrency.TestField("Amount Rounding Precision");
            end;
            wCurrencyOK := true;
        end;
        pCurrency := wCurrency;
    end;


    procedure wInitCurrency()
    begin
        wCurrencyOK := false;
    end;


    procedure wSetIntegrityVerify(pInit: Boolean)
    begin
        wIntegrityVerify := pInit;
    end;


    procedure wGetIntegrityVerify(): Boolean
    begin
        exit(wIntegrityVerify);
    end;


    procedure SetOpportunityNo(pOppNo: Code[20])
    begin
        //+REF+OPPORT
        OppNo := pOppNo;
        //+REF+OPPORT//
    end;


    procedure GetOpportunityNo(var pOppNo: Code[20]): Code[20]
    begin
        //+REF+OPPORT
        pOppNo := OppNo;
        //+REF+OPPORT//
    end;


    procedure SetUserID()
    var
        lLoginMng: Codeunit "User Management";
    begin
        //+REF+LOGIN
        wUSERID := UserId;
        //+REF+LOGIN//
    end;


    procedure GetUserID(): Code[20]
    begin
        //+REF+LOGIN
        exit(wUSERID);
        //+REF+LOGIN//
    end;


    /* //GL2024 Automation non compatible procedure SetXmlDoc(pXmlDoc: Automation)
     begin
         wXmlDoc := pXmlDoc;
     end;


     procedure GetXmlDoc(var pXmlDoc: Automation)
     begin
         pXmlDoc := wXmlDoc;
     end;


    procedure ClearXmlDoc()
    begin
        Clear(wXmlDoc);
    end;

 */
    procedure SetXlsMgt(pXlsMgt: Codeunit "Excel Management")
    begin
        wXlsMgt := pXlsMgt;
    end;


    procedure GetXlsMgt(var pXlsMgt: Codeunit "Excel Management")
    begin
        pXlsMgt := wXlsMgt;
    end;


    procedure ClearXlsMgt()
    begin
        Clear(wXlsMgt);
    end;


    procedure SetContact(var pContact: Record Contact)
    begin
        wContact := pContact;
    end;


    procedure GetContact(var pContact: Record Contact)
    begin
        pContact := wContact;
    end;


    procedure wSetSalesOverheadIsCalculated(pSalesOverheadIsCalculated: Boolean; pFrom: Integer)
    begin
        wSalesOverheadIsCalculated := pSalesOverheadIsCalculated;
        if not pSalesOverheadIsCalculated then
            wFrom := pFrom;

        //wForm = 0 => ' '
        //wForm = 1 => Order
        //wForm = 2 => Release
        //wForm = 3 => F9
        //wForm = 4 => Print
    end;


    procedure wGetSalesOverheadIsCalculated(): Boolean
    begin
        exit(wSalesOverheadIsCalculated);
    end;


    procedure wGetSalesOverheadCalcfrom(): Integer
    begin
        exit(wFrom);
    end;


    procedure wGetFrequencyCommit(): Integer
    var
        lMax: Integer;
    begin
        wNumber += 1;
        if wNumber >= wMax then
            wNumber := 0;
        exit(wNumber);
    end;


    procedure wGetBOQRecID(pRecIDText: Text[250]; var pRecID: RecordID)
    begin
        if pRecIDText <> Format(wBOQRecordID) then
            Evaluate(wBOQRecordID, pRecIDText);
        pRecID := wBOQRecordID
    end;


    procedure fGetBOQDocXML(pRecID: RecordID; var pBOQDocXML: Record "BOQ Doc Xml Format") return: Boolean
    begin
        if not ((Format(pRecID) = Format(wBOQDocXml.RecordID)) and (wBOQDocXml.EntryNo <> 0)) then begin
            wBOQDocXml.SetCurrentkey(RecordID);
            wBOQDocXml.SetRange(RecordID, pRecID);
            return := not wBOQDocXml.IsEmpty;
            if return then begin
                wBOQDocXml.FindFirst;
                wBOQDocXml.CalcFields(BOQXML);
            end;
        end else
            return := true;
        if return then
            pBOQDocXML := wBOQDocXml;
    end;


    procedure fSetBOQDocXML(pBOQDocXML: Record "BOQ Doc Xml Format")
    begin
        wBOQDocXml := pBOQDocXML;
    end;


    procedure fGetDatabaseType() retour: Text[150]
    begin
        //#8984
        retour := Format(wDatabaseType);
        //#8984//
    end;


    procedure fCheckTotalingDatabase()
    var
        lTotalingCharacter: Code[10];
        lTotalingPostingGroup: Code[10];
        lNavibatSetup: Record NavibatSetup;
        lGenProdPostingGroup: Record "Gen. Product Posting Group";
        lOldPostGrpChar: Code[10];
        lJob: Record Job;
        lJobTask: Record "Job Task";
        lDialog: Dialog;
        lTTitle: label 'Update of Totaling Characters\';
        lTProcess: label '#1#################################\';
        lTNaviSetup: label 'Update of Solution Settings';
        lTGenProdPostGrp: label 'Update of Gen. Product Posting Group Code';
        lTJob: label 'Update of the Job %1';
        lTJobTask: label 'Update of Job Task %2 from Job %2';
    begin
        //#6769
        if (fGetDatabaseType() = 'SQL') then begin
            lTotalingCharacter := 'Z';
            lTotalingPostingGroup := 'Z';
            lOldPostGrpChar := '.';
        end else begin
            lTotalingCharacter := '~';
            lTotalingPostingGroup := '.';
            lOldPostGrpChar := 'Z';
        end;
        lNavibatSetup.Get();
        if ((lNavibatSetup."Totalisation Character" <> lTotalingCharacter) or
            (lNavibatSetup."Tot. Gen. Prod. Posting Group" <> lTotalingPostingGroup)) then begin
            lDialog.Open(lTTitle + lTProcess);
            // mise à jour de Totalisation Character de navibatsetup
            lDialog.Update(1, lTNaviSetup);
            lNavibatSetup.Validate("Totalisation Character", lTotalingCharacter);
            lNavibatSetup.Modify(false);
            // Renommage du code natures de totalisation total
            if (lGenProdPostingGroup.Get(lOldPostGrpChar)) then begin
                lDialog.Update(1, lTGenProdPostGrp);
                lGenProdPostingGroup.Rename(lTotalingPostingGroup);
                lGenProdPostingGroup.Totaling := '..' + lTotalingCharacter;
                ;
                lGenProdPostingGroup.Modify(false);
                lNavibatSetup.Validate("Tot. Gen. Prod. Posting Group", lTotalingPostingGroup);
                lNavibatSetup.Modify(false);
            end;
            //Miseà jour des affaires de totalisation
            lJob.SetRange(Summarize, true);
            if (not lJob.IsEmpty()) then begin
                lJob.FindSet(true, false);
                repeat
                    lDialog.Update(1, StrSubstNo(lTJob, lJob."No."));
                    lJob."Job Totaling" := lJob."No." + '..' + lJob."No." + '.' + lTotalingCharacter;
                    lJob.Modify(false);
                until (lJob.Next() = 0);
            end;
            // Mise à jour des jobtask de totalisation
            lJobTask.SetFilter("Job Task Type", '%1|%2', lJobTask."job task type"::Total, lJobTask."job task type"::"End-Total");
            if (not lJobTask.IsEmpty()) then begin
                lJobTask.FindSet(true, false);
                repeat
                    lDialog.Update(1, StrSubstNo(lTJobTask, lJobTask."Job Task No.", lJobTask."Job No."));
                    lJobTask.Totaling := '..' + lTotalingCharacter;
                    lJobTask.Modify(false);
                until (lJobTask.Next() = 0);

            end;
            lDialog.Close();
        end;
        //#6769//
    end;
}

