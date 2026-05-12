Codeunit 8004150 "Note of Expenses integr."
{

    trigger OnRun()
    begin
    end;


    procedure SetNoSeries(var pRec: Record "Purchase Header"; pPurchSetup: Record "Purchases & Payables Setup"; var pNoSeriesMgt: Codeunit NoSeriesManagement)
    begin
        if (pRec."No. Series" <> '') and
           (pPurchSetup."Note of Expenses Nos." = pPurchSetup."Posted Note of Expenses Nos.")
        then
            pRec."Posting No. Series" := pRec."No. Series"
        else
            pNoSeriesMgt.SetDefaultSeries(pRec."Posting No. Series", pPurchSetup."Posted Note of Expenses Nos.");
    end;


    procedure SetPurchLineExpectReceiptDate(var pRec: Record "Purchase Line"; pxRec: Record "Purchase Line")
    begin
        if pRec."Document Type" = pRec."document type"::"Note of Expenses" then
            pRec."Expected Receipt Date" := pxRec."Expected Receipt Date";
    end;


    procedure SetPurchLineRes(var pRec: Record "Purchase Line")
    var
        lResource: Record Resource;
    begin
        if pRec.Type = pRec.Type::"Note of Expenses" then begin
            lResource.Get(pRec."No.");
            lResource.TestField(Blocked, false);
            pRec.Description := lResource.Name;
            pRec."Unit of Measure Code" := lResource."Base Unit of Measure";
            pRec."Description 2" := lResource."Name 2";
            pRec."Gen. Prod. Posting Group" := lResource."Gen. Prod. Posting Group";
            pRec."VAT Prod. Posting Group" := lResource."VAT Prod. Posting Group";
            pRec."Direct Unit Cost" := lResource."Unit Cost";
            pRec."Allow Invoice Disc." := false;
            pRec."Allow Item Charge Assignment" := false;
        end;
    end;


    procedure SetPurchLineTmpJobJnlLine(var pRec: Record "Purchase Line"; var pJobJnlLine: Record "Job Journal Line")
    var
        lNDF: Record Resource;
    begin
        lNDF.Get(pRec."No.");
        lNDF.TestField("Note of Expenses Account");
        pRec."No." := lNDF."Note of Expenses Account";
        pJobJnlLine.Validate(Type, pJobJnlLine.Type::"G/L Account");
    end;
}

