Codeunit 8001429 "Replace VAT Identifier"
{
    // #5324 CW 26/05/08
    // //+REF+VAT CW 04/12/07 Replace VAT Identifier


    trigger OnRun()
    var
        lSalesLine: Record "Sales Line";
    begin
        if not Confirm(tConfirm, false) then
            exit;
        fReplaceVATIdentifier(Database::"Sales Line", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Sales Line", 'Prepayment VAT Identifier');
        fReplaceVATIdentifier(Database::"Purchase Line", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Purchase Line", 'Prepayment VAT Identifier');
        fReplaceVATIdentifier(Database::"Sales Invoice Line", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Sales Cr.Memo Line", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Purch. Inv. Line", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Purch. Cr. Memo Line", 'VAT Identifier');
        //fReplaceVATIdentifier(DATABASE::"VAT Amount Line",'VAT Identifier');
        //fReplaceVATIdentifier(DATABASE::"Reminder Line",'VAT Identifier');
        //fReplaceVATIdentifier(DATABASE::"Issued Reminder Line",'VAT Identifier');
        //fReplaceVATIdentifier(DATABASE::"Finance Charge Memo Line",'VAT Identifier');
        //fReplaceVATIdentifier(DATABASE::"Issued Fin. Charge Memo Line",'VAT Identifier');
        //fReplaceVATIdentifier(DATABASE::"Prepayment Inv. Line Buffer",'VAT Identifier');
        fReplaceVATIdentifier(Database::"Sales Line Archive", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Purchase Line Archive", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Service Line", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Service Invoice Line", 'VAT Identifier');
        fReplaceVATIdentifier(Database::"Service Cr.Memo Line", 'VAT Identifier');
    end;

    var
        gVATPostingSetup: Record "VAT Posting Setup";
        gOK: Boolean;
        tConfirm: label 'Do you want to replace "VAT Identifier" on sales lines and purchase lines';


    procedure fReplaceVATIdentifier(pTableID: Integer; pVATIdentifierFieldName: Text[30])
    var
        lRecordRef: RecordRef;
        lVATBusPostGrp: FieldRef;
        lVATProdPostGrp: FieldRef;
        lVATIdentifier: FieldRef;
        tFieldNotFound: label 'Table %1 doesn''t have required fields. ';
        lVATPostingSetup: Record "VAT Posting Setup";
        lWindows: Codeunit "Progress Dialog2";
    begin
        lRecordRef.Open(pTableID);
        if not fFindFields(lRecordRef, pVATIdentifierFieldName, lVATBusPostGrp, lVATProdPostGrp, lVATIdentifier) then
            Error(tFieldNotFound, lRecordRef.Number)
        else
            if lRecordRef.FindSet(true, false) then begin
                lWindows.Open(lRecordRef.Caption, lRecordRef.COUNTAPPROX);
                repeat
                    lWindows.Update();
                    lVATPostingSetup."VAT Bus. Posting Group" := lVATBusPostGrp.Value;
                    lVATPostingSetup."VAT Prod. Posting Group" := lVATProdPostGrp.Value;
                    lVATPostingSetup."VAT Identifier" := lVATIdentifier.Value;
                    if (lVATPostingSetup."VAT Bus. Posting Group" <> gVATPostingSetup."VAT Bus. Posting Group") or
                       (lVATPostingSetup."VAT Prod. Posting Group" <> gVATPostingSetup."VAT Prod. Posting Group") then
                        gOK := gVATPostingSetup.Get(lVATPostingSetup."VAT Bus. Posting Group", lVATPostingSetup."VAT Prod. Posting Group");
                    if not gOK then
                        gVATPostingSetup := lVATPostingSetup
                    else
                        if (lVATPostingSetup."VAT Identifier" <> gVATPostingSetup."VAT Identifier") then begin
                            lVATIdentifier.Value := gVATPostingSetup."VAT Identifier";
                            lRecordRef.Modify;
                        end;
                until lRecordRef.Next = 0;
                lWindows.Close();
            end;
    end;

    local procedure fFindFields(var pRecordRef: RecordRef; pVATIdentifierFieldName: Text[30]; var pVATBusPostGrp: FieldRef; var pVATProdPostGrp: FieldRef; var pVATIdentifier: FieldRef): Boolean
    var
        lFieldRef: FieldRef;
        i: Integer;
    begin
        Clear(pVATBusPostGrp);
        Clear(pVATProdPostGrp);
        Clear(pVATIdentifier);
        for i := 1 to pRecordRef.FieldCount do begin
            lFieldRef := pRecordRef.FieldIndex(i);

            case lFieldRef.Name of
                'VAT Bus. Posting Group':
                    pVATBusPostGrp := pRecordRef.FieldIndex(i);
                'VAT Prod. Posting Group':
                    pVATProdPostGrp := pRecordRef.FieldIndex(i);
                pVATIdentifierFieldName:
                    pVATIdentifier := pRecordRef.FieldIndex(i);
            end;
        end;
        //MESSAGE('%1 %2 %3 %4',pRecordRef.NAME,pVATBusPostGrp.NUMBER,pVATProdPostGrp.NUMBER,pVATIdentifier.NUMBER);
        exit((pVATBusPostGrp.Number <> 0) and (pVATProdPostGrp.Number <> 0) and (pVATIdentifier.Number <> 0));
    end;
}

