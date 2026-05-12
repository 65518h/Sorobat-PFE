Table 8003957 "RollBack Log"
{
    // DrillDownPageID = 8003963;
    // LookupPageID = 8003963;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." where("Document Type" = field("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(STG_Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text8003900: label 'Error on copy document and copy lines.\ Do you want restore initial document?';
        wSalesLine: Record "Sales Line";
        wProgress: Dialog;
        Text8003901: label 'RollBack in Progress...';
        Text8003902: label 'Presentation Code Updating';
        Text8003903: label 'Totaling Updating';
        TextTittre: label 'RollBack Data Copied... \';
        TextCaption: label 'Step                #1################ \';
        "Text Progress": label 'Progress            @2@@@@@@@@@@@@@@@@ \';


    procedure CopyIntegrityVerify(pSalesheader: Record "Sales Header"): Boolean
    var
        "lRollBackLog.": Record "RollBack Log";
    begin
        SetRange("Document Type", pSalesheader."Document Type");
        SetRange("Document No.", pSalesheader."No.");
        if IsEmpty then
            exit(true);
        SetRollBack(pSalesheader);
        exit(false);
    end;


    procedure SetRollBack(pSalesHeader: Record "Sales Header")
    var
        lRollBackLog: Record "RollBack Log";
        lSingleInstance: Codeunit "Import SingleInstance2";
        lSalesLine: Record "Sales Line";
        lPresentation: Codeunit "Presentation Management";
        i: Integer;
        lMax: Integer;
    begin
        lSingleInstance.wSetIntegrityVerify(true);
        if not Confirm(Text8003900, true) then
            Error('');

        wProgress.Open(TextTittre + TextCaption + "Text Progress");

        lRollBackLog.SetRange("Document Type", pSalesHeader."Document Type");
        lRollBackLog.SetRange("Document No.", pSalesHeader."No.");
        lMax := lRollBackLog.Count;
        wProgress.Update(1, Text8003901);
        i := 1;
        if lRollBackLog.Find('-') then begin
            repeat
                wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
                //#7826  wSalesLine.SETPOSITION(lRollBackLog.GETPOSITION);
                //  lSalesLine := wSalesLine;
                //  IF lSalesLine.FIND('=') THEN BEGIN
                if wSalesLine.Get(lRollBackLog."Document Type", lRollBackLog."Document No.", lRollBackLog."Line No.") then begin
                    lSalesLine.Get(lRollBackLog."Document Type", lRollBackLog."Document No.", lRollBackLog."Line No.");
                    //7826
                    wSalesLine.Dummy := '@@';
                    wSalesLine.Delete(true);
                    Commit;
                end;
                i += 1;
            until lRollBackLog.Next = 0;
        end;
        Commit;

        wProgress.Update(1, Text8003902);
        lPresentation.ReFreshPresentation(pSalesHeader, wProgress);
        Commit;
        wProgress.Update(1, Text8003903);
        lUpdateTotalingAmount(pSalesHeader);

        lRollBackLog.DeleteAll;
        wProgress.Close;
        Commit;
    end;


    procedure lUpdateTotalingAmount(pSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        lSalesLineMgt: Codeunit "SalesLine Management";
        lMax: Integer;
        i: Integer;
    begin
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option);
        lSalesLine.SetRange("Document Type", pSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", pSalesHeader."No.");
        if lSalesLine.IsEmpty then
            exit;
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetRange("Line Type", lSalesLine."line type"::Totaling);
        if lSalesLine.IsEmpty then
            exit;
        lMax := lSalesLine.Count;
        lSalesLine.Find('-');
        i := 1;
        repeat
            wProgress.Update(2, ROUND((i / lMax) * 10000, 1));
            lSalesLineMgt.wUpdateTotalLine(lSalesLine);
            lSalesLine.Modify;
            i += 1;
        until lSalesLine.Next = 0;
    end;


    procedure CommitLine(pSalesLine: Record "Sales Line"; pCommit: Boolean)
    var
        lSalesHeader: Record "Sales Header";
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        if not pCommit then
            exit;
        lSingleInstance.wSetIntegrityVerify(true);
        TransferFields(pSalesLine);
        if not Insert then begin
            lSalesHeader.SetRange("Document Type", pSalesLine."Document Type");
            lSalesHeader.SetRange("No.", pSalesLine."Document No.");
            lSalesHeader.FindFirst;
            SetRollBack(lSalesHeader);
            Error('');
        end;

        if lSingleInstance.wGetFrequencyCommit = 0 then
            Commit;
    end;


    procedure CopyFinish(pSalesHeader: Record "Sales Header")
    var
        lSingleInstance: Codeunit "Import SingleInstance2";
    begin
        SetRange("Document Type", pSalesHeader."Document Type");
        SetRange("Document No.", pSalesHeader."No.");
        if not IsEmpty then
            DeleteAll;
        lSingleInstance.wSetIntegrityVerify(false);
    end;
}

