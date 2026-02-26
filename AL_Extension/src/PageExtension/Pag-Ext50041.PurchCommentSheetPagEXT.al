PageExtension 50041 "Purch. Comment Sheet_PagEXT" extends "Purch. Comment Sheet"
{
    layout
    {



    }
    actions
    {

    }
    trigger OnOpenPage()
    VAR
        lMemoPad: Codeunit "MemoPad Management";
        lRecordRef: RecordRef;
        lPurchaseHeader: Record "Sales Header";
    BEGIN

        //+REF+MEMOPAD
        lRecordRef.GETTABLE(Rec);
        lPurchaseHeader."Document Type" := rec."Document Type";
        IF lMemoPad.Edit(lRecordRef, FORMAT(lPurchaseHeader."Document Type")) THEN
            CurrPage.CLOSE;
        //+REF+MEMOPAD//

    end;
}

