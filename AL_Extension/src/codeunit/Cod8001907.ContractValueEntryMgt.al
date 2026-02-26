Codeunit 8001907 ContractValueEntryMgt
{
    // #9153 CW 25/10/11 +lLine.SETFILTER(Type,'<>0');
    // #8970 CW 28/07/11 +"SalesPerson Code" -Quantity, "Quantity (base)", "UoM code", "No.", "Work Type Code"
    // //+ABO+VALUE CW 02/06/11
    // Principe : dans une table buffer
    //    Retrancher les écritures pour le document
    //    Ajouter les écritures  du document
    //    Regrouper sur l'ensemble des critères pour obtenir par la variation à ajouter aux écritures existantes
    // Attention : seuls les axes 1 et 2 sont pris en compte

    TableNo = "Sales Header";

    trigger OnRun()
    var
        lDialog: Dialog;
        lLine: Record "Sales Line";
        ltDialog: label 'Update %1 in  progress...';
        lBuffer: Record "Sales Contract Gain/Loss Buff." temporary;
    begin
        rec.TestField("Document Type", rec."document type"::Subscription);

        lDialog.Open(ltDialog);
        ReverseToBuffer(Rec, lBuffer);

        lLine.SetRange("Document Type", rec."Document Type");
        lLine.SetRange("Document No.", rec."No.");
        lLine.SetFilter(Type, '<>0');

        if lLine.FindSet then
            repeat
                LineToBuffer(Rec, lLine, lBuffer);
                lBuffer.Insert;
                if lLine."Subscription End Date" <> 0D then begin
                    lBuffer."Change Date" := lLine."Subscription End Date";
                    Weight(lBuffer, -1);
                    //        lBuffer.Quantity *= -1;
                    //        lBuffer."Quantity (Base)" *= -1;
                    lBuffer."Entry No." *= -1;
                    lBuffer.Insert;
                end;
            until lLine.Next = 0;

        Update(Rec, lBuffer, false);
        lDialog.Close();
    end;

    var
        UnitOfMeasure: Record "Unit of Measure";
        MaxEntryNo: Integer;


    procedure ReverseToBuffer(pHeader: Record "Sales Header"; var pBuffer: Record "Sales Contract Gain/Loss Buff.")
    var
        lEntry: Record "Sales Contract Gain/Loss Entry";
    begin
        pBuffer.DeleteAll;
        lEntry.SetCurrentkey("Document Type", "Document No.");
        lEntry.SetRange("Document Type", pHeader."Document Type");
        lEntry.SetRange("Document No.", pHeader."No.");
        if lEntry.FindSet then
            repeat
                if lEntry."Entry No." > MaxEntryNo then
                    MaxEntryNo := lEntry."Entry No.";
                pBuffer.TransferFields(lEntry);
                Weight(pBuffer, -1);
                //    pBuffer.Quantity *= -1;
                //    pBuffer."Quantity (Base)" *= -1;
                if (pHeader."Posting Date" <> 0D) and (pBuffer."Change Date" <= pHeader."Posting Date") then
                    pBuffer."Change Date" := pHeader."Posting Date" + 1;
                pBuffer.Insert;
            until lEntry.Next = 0;
    end;


    procedure LineToBuffer(var pHeader: Record "Sales Header"; var pLine: Record "Sales Line"; var pBuffer: Record "Sales Contract Gain/Loss Buff.")
    begin
        pBuffer.TransferFields(pLine);
        pBuffer."Salesperson Code" := pHeader."Salesperson Code";
        if pLine."Subscription Starting Date" > pLine."Subscription Posting Date" then
            pBuffer."Change Date" := pLine."Subscription Starting Date"
        else
            if (pLine."Subscription End Date" <> 0D) and (pLine."Subscription End Date" <= pLine."Subscription Posting Date") then
                pBuffer."Change Date" := pLine."Subscription End Date"
            else
                pBuffer."Change Date" := pLine."Subscription Posting Date" + 1;

        if pHeader."Document Type" = pHeader."document type"::Subscription then begin
            if pLine."Unit of Measure Code" <> UnitOfMeasure.Code then begin
                UnitOfMeasure.Get(pLine."Unit of Measure Code");
                UnitOfMeasure.TestField(Weight);
            end;
            Weight(pBuffer, UnitOfMeasure.Weight);
        end;
    end;


    procedure Update(pHeader: Record "Sales Header"; var pBuffer: Record "Sales Contract Gain/Loss Buff."; pCancel: Boolean)
    var
        lToEntry: Record "Sales Contract Gain/Loss Entry";
    begin
        if pBuffer.IsEmpty then
            exit;

        CompressBuffer(pBuffer);
        if pBuffer.FindSet then
            repeat
                if not Null(pBuffer) then begin

                    lToEntry.TransferFields(pBuffer);
                    lToEntry."Document Type" := pHeader."Document Type";
                    lToEntry."Document No." := pHeader."No.";
                    MaxEntryNo += 1;
                    lToEntry."Entry No." := MaxEntryNo;

                    if pCancel then begin
                        lToEntry."Type of Change" := lToEntry."type of change"::Canceled;
                        if pHeader."Subscription End Date" <> 0D then
                            lToEntry."Change Date" := pHeader."Subscription End Date"
                        else
                            lToEntry."Change Date" := WorkDate;
                    end else
                        if pHeader."Posting Date" = 0D then
                            lToEntry."Type of Change" := lToEntry."type of change"::Released
                        else
                            if pHeader."Posting Date" = pHeader."Subscription End Date" then
                                lToEntry."Type of Change" := lToEntry."type of change"::Canceled
                            else
                                lToEntry."Type of Change" := lToEntry."type of change"::"Manual Update";

                    lToEntry."User ID" := UserId;

                    lToEntry.Insert;
                end;
            until pBuffer.Next = 0;
    end;

    local procedure CompressBuffer(var pBuffer: Record "Sales Contract Gain/Loss Buff.")
    var
        lBuffer: Record "Sales Contract Gain/Loss Buff." temporary;
    begin
        pBuffer.FindSet;
        repeat
            lBuffer := pBuffer;
            lBuffer."Entry No." := 0;
            if lBuffer.Find then begin
                Increment(pBuffer, lBuffer);
                lBuffer.Modify;
            end else
                lBuffer.Insert;
        until pBuffer.Next = 0;

        pBuffer.DeleteAll;

        lBuffer.FindSet;
        repeat
            pBuffer := lBuffer;
            pBuffer.Insert;
        until lBuffer.Next = 0;
    end;


    procedure Weight(var pBuffer: Record "Sales Contract Gain/Loss Buff."; pWeight: Decimal)
    begin
        with pBuffer do begin
            "Line Discount Amount" := ROUND("Line Discount Amount" * pWeight, 0.01);
            Amount := ROUND(Amount * pWeight, 0.01);
            "Amount Including VAT" := ROUND("Amount Including VAT" * pWeight, 0.01);
            "Inv. Discount Amount" := ROUND("Inv. Discount Amount" * pWeight, 0.01);
            "VAT Base Amount" := ROUND("VAT Base Amount" * pWeight, 0.01);
            "Line Amount" := ROUND("Line Amount" * pWeight, 0.01);
        end;
    end;

    local procedure Increment(pBuffer: Record "Sales Contract Gain/Loss Buff."; var pTotal: Record "Sales Contract Gain/Loss Buff.")
    begin
        with pTotal do begin
            //  Quantity += pBuffer.Quantity;
            //  "Quantity (Base)" += pBuffer."Quantity (Base)";
            "Line Discount Amount" += pBuffer."Line Discount Amount";
            Amount += pBuffer.Amount;
            "Amount Including VAT" += pBuffer."Amount Including VAT";
            "Inv. Discount Amount" += pBuffer."Inv. Discount Amount";
            "Line Amount" += pBuffer."Line Amount";
        end;
    end;


    procedure Null(var pRec: Record "Sales Contract Gain/Loss Buff."): Boolean
    begin
        with pRec do
            exit(
              //    (Quantity = 0) AND
              //    ("Quantity (Base)" = 0) AND
              ("Line Discount Amount" = 0) and
              (Amount = 0) and
              ("Amount Including VAT" = 0) and
              ("Inv. Discount Amount" = 0) and
              ("Line Amount" = 0));
    end;


    procedure Cancel(pHeader: Record "Sales Header")
    var
        lBuffer: Record "Sales Contract Gain/Loss Buff." temporary;
    begin
        ReverseToBuffer(pHeader, lBuffer);
        Update(pHeader, lBuffer, true);
    end;
}

