Codeunit 8003983 "NaviBat SingleInstance"
{
    // //SUBCONTRACTOR CLA 15/06/04 SingleInstance : garder le l'option du libellé des lignes achat
    // //OUVRAGE CLA 07/09/05 Garder une ligne vente (pour présentation)

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        PurchDesc: Option Item,Structure,Both;
        SalesLine: Record "Sales Line";
        SalesOverheadTmp: Record "Sales Overhead-Margin" temporary;


    procedure Set(var pPurchDesc: Option Structure,Item,Both)
    begin
        PurchDesc := pPurchDesc;
    end;


    procedure Get(): Integer
    begin
        exit(PurchDesc);
    end;


    procedure SetSalesLine(var pSalesLine: Record "Sales Line")
    begin
        SalesLine := pSalesLine;
    end;


    procedure GetSalesLine(var pSalesLine: Record "Sales Line")
    begin
        pSalesLine := SalesLine;
    end;


    procedure SetSalesOverhead(pDocType: Option; pDocNo: Code[20])
    var
        lSalesOverhead: Record "Sales Overhead-Margin";
    begin
        SalesOverheadTmp.DeleteAll;
        lSalesOverhead.SetRange("Document Type", pDocType);
        lSalesOverhead.SetRange("Document No.", pDocNo);
        if not lSalesOverhead.IsEmpty then begin
            repeat
                SalesOverheadTmp.TransferFields(lSalesOverhead);
                SalesOverheadTmp.Insert;
            until lSalesOverhead.Next = 0;
        end;
    end;


    procedure GetSalesOverhead(var pOverhead: Record "Sales Overhead-Margin"; pDocType: Option; pDocNo: Code[20]; pGenBusPostGp: Code[20]) Return: Boolean
    begin
        if (SalesOverheadTmp."Document Type" <> pDocType) or
          (SalesOverheadTmp."Document No." <> pDocNo) then
            SetSalesOverhead(pDocType, pDocNo);
        Return := SalesOverheadTmp.Get(pDocType, pDocNo, pGenBusPostGp);
        pOverhead := SalesOverheadTmp;
        if not Return then begin
            SetSalesOverhead(pDocType, pDocNo);
            Return := SalesOverheadTmp.Get(pDocType, pDocNo, pGenBusPostGp);
            pOverhead := SalesOverheadTmp;
        end;
        exit(Return);
    end;
}

