Codeunit 8004113 "Bank Acc. Rec. Post Pmt Integr"
{
    // #9044 XPE 05/08/2011 Creation dela fonction fPostBillsLinePostingDate
    // //+PMT+PAYMENT CW 28/08/07 Receivable and Payable bank account reconciliation
    //     *PostBillsStat* Ouverture du formulaire de sélection de la banque de remise dans le cadre de la gestion des remises d'effet
    //     *SetEtebac* Lancement du traitement de génération du fichier ETEBAC


    trigger OnRun()
    begin
    end;


    procedure PostBillsStatement(var pRec: Record "Bank Acc. Reconciliation") Return: Boolean
    var
        lBankAcc: Record "Bank Account";
    //GL2024 NAVIBAT  lPostHandingOver: Report 8004102;
    begin
        Return := false;
        pRec.TestField("Statement Date");
        lBankAcc.Get(pRec."Bank Account No.");
        if lBankAcc."Bank Type" in [lBankAcc."bank type"::Receivable, lBankAcc."bank type"::Payable] then begin
            //GL2024 NAVIBAT   lPostHandingOver.SetBankAccountReconciliation(pRec);
            //GL2024 NAVIBAT   lPostHandingOver.SetTableview(pRec);
            //GL2024 NAVIBAT   lPostHandingOver.RunModal;
            pRec.Find('=');
            Return := (pRec."Handing-over Bank Code" = '');
        end;
    end;


    procedure SetEtebac(var pRec: Record "Bank Acc. Reconciliation"; pBankAcc: Record "Bank Account")
    var
        lBankAccountStatement: Record "Bank Account Statement";
    //GL2024 NAVIBAT    lEtebac: Report 8004101;
    begin
        if pBankAcc."Bank Type" = pBankAcc."bank type"::Receivable then begin
            Commit;
            lBankAccountStatement.SetRange("Bank Account No.", pRec."Bank Account No.");
            lBankAccountStatement.SetRange("Statement No.", pRec."Statement No.");
            lBankAccountStatement.Get(pRec."Bank Account No.", pRec."Statement No.");
            //GL2024 NAVIBAT      lEtebac.InitRequest(lBankAccountStatement, pRec."LCR File Name");
            //GL2024 NAVIBAT     lEtebac.SetTableview(lBankAccountStatement);
            //GL2024 NAVIBAT     lEtebac.RunModal;
        end;
    end;


    procedure fPostBillsLinePostingDate(pRecBankAccRecon: Record "Bank Acc. Reconciliation"; pRecBankAccReconLine: Record "Bank Acc. Reconciliation Line")
    begin
        //#9044
        if ((pRecBankAccRecon."Bank Type" = pRecBankAccRecon."bank type"::"Bill To Receive") and
           (pRecBankAccRecon."Handing-over Type" = pRecBankAccRecon."handing-over type"::Cash)) then begin
            pRecBankAccReconLine.TestField("Due Date");
        end;
        //#9044/
    end;
}

