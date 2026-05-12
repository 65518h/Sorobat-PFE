Codeunit 8001526 "Stock-Post"
{
    //GL2024  ID dans Nav 2009 : "8001605"
    // //+RAP+VMP GESWAY 01/08/02 CodeUnit "Stock-Post"


    trigger OnRun()
    begin
    end;

    var
        StockHeader: Record "Stock Header";
        StockLine: Record "Stock Line";
        StockLineTmp: Record "Stock Line";
        StockSetup: Record "Stock Setup";
        StockPostGroup: Record "Stock Posting Group";
        Text001: label 'There is nothing to post.';
        Text002: label 'There is nothing to post.';
        StockPurchLine: Record "Stock Line";
        StockPriceRegister: Record "Stock Price Register";
        Bank: Record "Bank Account";
        CurrencyExchange: Record "Currency Exchange Rate";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NoSeriesMngt: Codeunit NoSeriesManagement;
        Text003: label 'You must certified the transaction before posting to G/L';
        Text004: label 'Do you want to post current line to G/L ?';
        Text005: label 'The current transaction has been already posted.';
        AppliToID: Code[20];
        Text006: label 'Transaction has been successfully posted.';
        Text007: label 'All previous transactions must be posted before current.';
        BalAmount: Decimal;
        Text008: label 'Do you want to certify current transaction ?\\Caution : You will not be able to change this transaction after this treatement.';
        Text009: label 'The current transaction has already been certified.';
        Text010: label 'Transaction has been successfully certified.';
        Text011: label 'All previous transactions must be certified.';
        ValueAmount: Decimal;
        AssignAmount: Decimal;
        AssignQty: Decimal;
        JnlLineNo: Integer;
        Text012: label 'There is nothing to canceled';
        Text013: label 'All posterior transactions must be certified.';
        Text014: label 'The current transaction has not been certified.';
        Text015: label 'You can''t cancel a posting Line';
        wRoundEcart: Decimal;
        Text016: label 'Round %1';


    procedure TransactionValue(pStockLine: Record "Stock Line"; OnlyOne: Boolean)
    var
        ExitTrigger: Boolean;
        NextPurchRec: Integer;
    begin
        StockLine.Copy(pStockLine);
        StockSetup.Get;
        with StockLine do begin
            if "Line No." = 0 then
                Error(Text001);
            if Certified then
                if OnlyOne then
                    Error(Text009)
                else
                    exit;

            StockLineTmp.Reset;
            StockLineTmp.SetRange("Stock Code", "Stock Code");
            StockLineTmp.SetFilter("Line No.", '<%1', "Line No.");
            StockLineTmp.SetRange(Certified, false);
            if StockLineTmp.Find('-') then
                Error(Text011);

            StockLine.TestField("Posting Date");
            if StockSetup."Costing Method" <> StockSetup."costing method"::Average then
                if (Type = Type::Purchase) or (Type = Type::Charge) then begin
                    Certified := true;
                    Modify;
                    exit;
                end;

            StockPurchLine.Reset;
            StockPurchLine.SetRange("Stock Code", "Stock Code");
            StockPurchLine.SetRange(Open, true);
            StockPurchLine.SetRange(Type, Type::Purchase);
            StockPurchLine.SetRange("Line No.", 0, "Line No." - 1);

            AssignQty := 0;
            AssignAmount := 0;
            ExitTrigger := false;
            NextPurchRec := 1;

            case StockSetup."Costing Method" of
                StockSetup."costing method"::Average:
                    begin
                        CalcAverageCost(StockLine, false);
                        AssignAmount := 0;
                        if StockPurchLine.Find('-') and (Type = Type::Sale) then
                            repeat
                                if (StockPurchLine.Quantity - StockPurchLine."Assigned Quantity") <
                                   (Quantity - "Assigned Quantity")
                                then
                                    AssignQty := StockPurchLine.Quantity - StockPurchLine."Assigned Quantity"
                                else
                                    AssignQty := Quantity - "Assigned Quantity";
                                AssignAmount +=
                                  (AssignQty * "Unit Price") - (AssignQty * "Average Cost");
                                "Assigned Quantity" += AssignQty;
                                ExitTrigger := ("Assigned Quantity" = Quantity);

                                StockPurchLine."Assigned Quantity" += AssignQty;
                                if StockPurchLine."Assigned Quantity" = StockPurchLine.Quantity then begin
                                    UpdatePurchaseLine;
                                    NextPurchRec := StockPurchLine.Next;
                                end else
                                    if ExitTrigger and (NextPurchRec <> 0) then
                                        StockPurchLine.Modify;
                            until ExitTrigger or (NextPurchRec = 0);
                        UpdateSaleLine;
                    end;
                StockSetup."costing method"::FIFO:
                    if StockPurchLine.Find('-') then
                        repeat
                            if (StockPurchLine.Quantity - StockPurchLine."Assigned Quantity") <
                               (Quantity - "Assigned Quantity")
                            then
                                AssignQty := StockPurchLine.Quantity - StockPurchLine."Assigned Quantity"
                            else
                                AssignQty := Quantity - "Assigned Quantity";

                            AssignAmount +=
                              (AssignQty * "Unit Price") - (AssignQty * StockPurchLine."Unit Price");
                            "Assigned Quantity" += AssignQty;
                            if "Assigned Quantity" = Quantity then begin
                                UpdateSaleLine;
                                ExitTrigger := true;
                            end;

                            StockPurchLine."Assigned Quantity" += AssignQty;
                            if StockPurchLine."Assigned Quantity" = StockPurchLine.Quantity then begin
                                UpdatePurchaseLine;
                                NextPurchRec := StockPurchLine.Next;
                            end else
                                if ExitTrigger and (NextPurchRec <> 0) then
                                    StockPurchLine.Modify;
                        until ExitTrigger or (NextPurchRec = 0);

                StockSetup."costing method"::LIFO:
                    if StockPurchLine.Find('+') then
                        repeat
                            if (StockPurchLine.Quantity - StockPurchLine."Assigned Quantity") <
                               (Quantity - "Assigned Quantity")
                            then
                                AssignQty := StockPurchLine.Quantity - StockPurchLine."Assigned Quantity"
                            else
                                AssignQty := Quantity - "Assigned Quantity";

                            AssignAmount +=
                              ((AssignQty * "Unit Price") - (AssignQty * StockPurchLine."Unit Price"));
                            "Assigned Quantity" += AssignQty;
                            if "Assigned Quantity" = Quantity then begin
                                UpdateSaleLine;
                                ExitTrigger := true;
                            end;

                            StockPurchLine."Assigned Quantity" += AssignQty;
                            if StockPurchLine."Assigned Quantity" = StockPurchLine.Quantity then begin
                                UpdatePurchaseLine;
                                NextPurchRec := StockPurchLine.Next(-1);
                            end else
                                if ExitTrigger and (NextPurchRec <> 0) then
                                    StockPurchLine.Modify;
                        until ExitTrigger or (NextPurchRec = 0);
            end;
        end;
    end;


    procedure UndoTransac(pStockLine: Record "Stock Line")
    var
        ExitTrigger: Boolean;
        NextPurchRec: Integer;
    begin
        StockLine.Copy(pStockLine);
        StockSetup.Get;
        with StockLine do begin
            if "Line No." = 0 then
                Error(Text012);
            if not Certified then
                Error(Text014);
            if Posted then
                Error(Text015);

            StockLineTmp.Reset;
            StockLineTmp.SetRange("Stock Code", "Stock Code");
            StockLineTmp.SetRange(Certified, true);
            if StockLineTmp.Find('+') then
                if "Line No." <> StockLineTmp."Line No." then
                    Error(Text013);

            if StockSetup."Costing Method" <> StockSetup."costing method"::Average then
                if (Type = Type::Purchase) or (Type = Type::Charge) then begin
                    Certified := false;
                    Modify;
                    exit;
                end;

            StockPurchLine.Reset;
            StockPurchLine.SetRange("Stock Code", "Stock Code");
            StockPurchLine.SetRange(Type, Type::Purchase);
            StockPurchLine.SetRange("Line No.", 0, "Line No." - 1);
            StockPurchLine.SetFilter("Assigned Quantity", '<>%1', 0);

            AssignQty := 0;
            AssignAmount := 0;
            ExitTrigger := false;
            NextPurchRec := 1;
            "Average Cost" := 0;
            "Average Cost (LCY)" := 0;
            Certified := false;
            Modify;


            case StockSetup."Costing Method" of
                StockSetup."costing method"::Average:
                    begin
                        CalcAverageCost(StockLine, true);
                        "Average Cost" := 0;
                        "Average Cost (LCY)" := 0;
                        Certified := false;
                        Modify;
                        AssignAmount := 0;
                        if StockPurchLine.Find('+') then
                            repeat
                                if (StockPurchLine."Assigned Quantity") > ("Assigned Quantity")
                                then
                                    AssignQty := "Assigned Quantity"
                                else
                                    AssignQty := StockPurchLine."Assigned Quantity";
                                "Assigned Quantity" -= AssignQty;
                                ExitTrigger := ("Assigned Quantity" = 0);

                                StockPurchLine."Assigned Quantity" -= AssignQty;
                                StockPurchLine.Open := not (StockPurchLine."Assigned Quantity" = StockPurchLine.Quantity);
                                if StockPurchLine."Assigned Quantity" = 0 then begin
                                    StockPurchLine.Modify;
                                    NextPurchRec := StockPurchLine.Next(-1);
                                end else
                                    if ExitTrigger and (NextPurchRec <> 0) then
                                        StockPurchLine.Modify;
                            until ExitTrigger or (NextPurchRec = 0);
                    end;
                StockSetup."costing method"::FIFO:
                    if StockPurchLine.Find('+') then
                        repeat
                            if (StockPurchLine."Assigned Quantity") > ("Assigned Quantity")
                            then
                                AssignQty := "Assigned Quantity"
                            else
                                AssignQty := StockPurchLine."Assigned Quantity";

                            "Assigned Quantity" -= AssignQty;
                            if "Assigned Quantity" = 0 then begin
                                ExitTrigger := true;
                            end;

                            StockPurchLine."Assigned Quantity" -= AssignQty;
                            StockPurchLine.Open := not (StockPurchLine."Assigned Quantity" = StockPurchLine.Quantity);
                            if StockPurchLine."Assigned Quantity" = 0 then begin
                                StockPurchLine.Modify;
                                NextPurchRec := StockPurchLine.Next(-1)
                            end else
                                if ExitTrigger and (NextPurchRec <> 0) then
                                    StockPurchLine.Modify;
                        until ExitTrigger or (NextPurchRec = 0);

                StockSetup."costing method"::LIFO:
                    if StockPurchLine.Find('-') then
                        repeat
                            if (StockPurchLine."Assigned Quantity") > ("Assigned Quantity")
                            then
                                AssignQty := "Assigned Quantity"
                            else
                                AssignQty := StockPurchLine."Assigned Quantity";

                            "Assigned Quantity" -= AssignQty;
                            if "Assigned Quantity" = Quantity then begin
                                ExitTrigger := true;
                            end;

                            StockPurchLine."Assigned Quantity" -= AssignQty;
                            StockPurchLine.Open := not (StockPurchLine."Assigned Quantity" = StockPurchLine.Quantity);
                            if StockPurchLine."Assigned Quantity" = 0 then begin
                                StockPurchLine.Modify;
                                NextPurchRec := StockPurchLine.Next;
                            end else
                                if ExitTrigger and (NextPurchRec <> 0) then
                                    StockPurchLine.Modify;
                        until ExitTrigger or (NextPurchRec = 0);
            end;
            "Capital Gain Amount" := 0;
            "Loss In Value Amount" := 0;
            "Average Cost" := 0;
            "Capital Gain Amount (LCY)" := 0;
            "Loss In Value Amount (LCY)" := 0;
            "Average Cost (LCY)" := 0;
            "Assigned Quantity" := 0;
            Certified := false;
            Open := true;
            Modify;
        end;
    end;


    procedure UpdatePurchaseLine()
    begin
        StockPurchLine.Open := not (StockPurchLine."Assigned Quantity" = StockPurchLine.Quantity);
        StockPurchLine.Modify;
    end;


    procedure UpdateSaleLine()
    begin
        if StockLine.Type <> StockLine.Type::Sale then
            exit;

        with StockLine do begin
            if AssignAmount < 0 then begin
                "Loss In Value Amount" := Abs(AssignAmount);
                "Capital Gain Amount" := 0;
            end else begin
                "Loss In Value Amount" := 0;
                "Capital Gain Amount" := AssignAmount;
            end;

            "Capital Gain Amount (LCY)" := UpdateLCY("Capital Gain Amount");
            "Loss In Value Amount (LCY)" := UpdateLCY("Loss In Value Amount");
            "Average Cost (LCY)" := UpdateLCY("Average Cost");

            Certified := true;
            "Assigned Quantity" := Quantity;
            Open := false;
            Modify;
        end;
    end;


    procedure UpdateLCY(pAmount: Decimal): Decimal
    begin
        with StockLine do
            if "Currency Code" = '' then
                exit(pAmount)
            else
                exit(
                  ROUND(
                    CurrencyExchange.ExchangeAmtFCYToLCY(
                      "Posting Date", "Currency Code", pAmount, "Currency Factor")));
    end;


    procedure PostGLEntry(pStockLine: Record "Stock Line"; OnlyOne: Boolean)
    begin
        Clear(wRoundEcart);
        StockSetup.Get;
        if StockSetup."Use Journal Template" then begin
            GenJnlLine.SetRange("Journal Template Name", StockSetup."Journal Template Name");
            GenJnlLine.SetRange("Journal Batch Name", StockSetup."Journal Batch Name");
            if GenJnlLine.Find('+') then begin
                JnlLineNo := GenJnlLine."Line No.";
                AppliToID := GenJnlLine."Document No.";
            end;
            GenJnlBatch.Get(StockSetup."Journal Template Name", StockSetup."Journal Batch Name");
            GenJnlBatch.TestField("No. Series");
        end else begin
            StockSetup.TestField("Source Code");
            StockSetup.TestField("Posting No. Series");
        end;

        StockLine.Copy(pStockLine);
        with StockLine do begin
            if "Line No." = 0 then
                Error(Text002);
            if Posted = true then
                if OnlyOne then
                    Error(Text005)
                else
                    exit;
            if (Type <> Type::Charge) and
               (not Certified = true)
            then
                if OnlyOne then
                    Error(Text003)
                else
                    exit;

            StockHeader.Get(StockLine."Stock Code");
            StockPostGroup.Get(StockHeader."Stock Posting Group");

            TestField("Bal. Account No.");
            TestField("Posting Date");
            if Type <> Type::Charge then begin
                StockPostGroup.TestField("Stock Account");
                TestField(Amount);
            end;

            if "VAT Amount" <> 0 then
                StockPostGroup.TestField("VAT Account");
            if "Charges Amount" <> 0 then
                StockPostGroup.TestField("Bank Charges Account");

            //IF StockSetup."Reason Code Mandatory" THEN
            //  TESTFIELD("Reason Code");
            case StockSetup."Reason Value Posting" of
                StockSetup."reason value posting"::"Code Mandatory":
                    TestField("Reason Code");
                StockSetup."reason value posting"::"Same Code":
                    TestField("Reason Code", StockSetup."Reason Code");
                StockSetup."reason value posting"::"No Code":
                    TestField("Reason Code", '');
            end;

            if "Bal. Account Type" = "bal. account type"::Bank then
                Bank.Get("Bal. Account No.");

            //Transaction
            if Amount <> 0 then begin
                GetApplyToID;
                InitGLEntry;
                GenJnlLine.Validate("Account No.", StockPostGroup."Stock Account");
                GenJnlLine.Description := Description;
                GenJnlLine.Validate("Currency Code", "Currency Code");

                if Type = Type::Sale then begin
                    ValueAmount := "Loss In Value Amount" - "Capital Gain Amount";
                    GenJnlLine.Validate(Amount, -(Amount + ValueAmount));
                end else
                    GenJnlLine.Validate(Amount, Amount);
                wRoundEcart += GenJnlLine.Amount;
                InsertGLEntry;

                if (ValueAmount <> 0) and (Type = Type::Sale) then begin
                    InitGLEntry;
                    if ValueAmount < 0 then
                        GenJnlLine.Validate("Account No.", StockPostGroup."Capital Gain Account")
                    else
                        GenJnlLine.Validate("Account No.", StockPostGroup."Loss In Value Account");
                    GenJnlLine.Description := Description;
                    GenJnlLine.Validate("Currency Code", "Currency Code");
                    GenJnlLine.Validate(Amount, ValueAmount);
                    wRoundEcart += GenJnlLine.Amount;
                    InsertGLEntry;
                end;

                InitGLEntry;
                if Type = Type::Sale then
                    InsertBalEntry(Amount, "Currency Code")
                else
                    InsertBalEntry(-Amount, "Currency Code");
            end;

            //Frais bancaires
            if StockLine."Charges Amount" <> 0 then begin
                if Type = Type::Charge then
                    GetApplyToID;

                InitGLEntry;
                GenJnlLine.Validate("Account No.", StockPostGroup."Bank Charges Account");
                GenJnlLine.Description := Description;
                GenJnlLine.Validate("Currency Code", GetChargeCurrency);
                GenJnlLine.Validate(Amount, "Charges Amount");
                wRoundEcart += GenJnlLine.Amount;
                InsertGLEntry;

                if "VAT Amount" <> 0 then begin
                    InitGLEntry;
                    GenJnlLine.Validate("Account No.", StockPostGroup."VAT Account");
                    GenJnlLine.Description := Description;
                    GenJnlLine.Validate("Currency Code", GetChargeCurrency);
                    GenJnlLine.Validate(Amount, "VAT Amount");
                    wRoundEcart += GenJnlLine.Amount;
                    InsertGLEntry;
                end;
                InitGLEntry;
                InsertBalEntry(-("Charges Amount" + "VAT Amount"), GetChargeCurrency);
            end;

            //#4697
            //gestion des éventuels écarts d'arrondi
            if (wRoundEcart <> 0) and (Type = Type::Sale) then begin
                InitGLEntry;
                if wRoundEcart < 0 then
                    GenJnlLine.Validate("Account No.", StockPostGroup."Capital Gain Account")
                else
                    GenJnlLine.Validate("Account No.", StockPostGroup."Loss In Value Account");
                GenJnlLine.Description := StrSubstNo(Text016, Description);
                GenJnlLine.Validate("Currency Code", "Currency Code");
                GenJnlLine.Validate(Amount, -wRoundEcart);
                InsertGLEntry;
            end;
            //#4697//

            "Applies-to ID" := AppliToID;
            Certified := true;
            Posted := true;
            Modify;
            Commit;
        end;
    end;


    procedure InitGLEntry()
    begin
        with GenJnlLine do begin
            Init;
            if StockSetup."Use Journal Template" then begin
                "Journal Template Name" := StockSetup."Journal Template Name";
                "Journal Batch Name" := StockSetup."Journal Batch Name";
                JnlLineNo += 10000;
                "Line No." := JnlLineNo;
            end;

            "Source Code" := StockSetup."Source Code";
            "Posting Date" := StockLine."Posting Date";
            "Due Date" := StockLine."Value Date";
            "Document No." := AppliToID;
            "Account Type" := "account type"::"G/L Account";
            "Currency Code" := StockLine."Currency Code";
            "Reason Code" := StockLine."Reason Code";
            "Job No." := StockLine."Job No.";
            "Shortcut Dimension 1 Code" := StockLine."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := StockLine."Global Dimension 2 Code";
            "System-Created Entry" := true; //NOT StockSetup."Use Journal Template";
        end;
    end;


    procedure InsertGLEntry()
    begin
        if StockSetup."Use Journal Template" then
            GenJnlLine.Insert
        else
            GenJnlPostLine.Run(GenJnlLine);
    end;


    procedure InsertBalEntry(pAmount: Decimal; pCurrencyCode: Code[10])
    begin
        if StockLine."Bal. Account Type" = StockLine."bal. account type"::Bank then
            GenJnlLine."Account Type" := GenJnlLine."account type"::"Bank Account"
        else
            GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";

        GenJnlLine.Validate("Account No.", StockLine."Bal. Account No.");
        GenJnlLine.Description := StockLine.Description;
        GenJnlLine.Validate("Currency Code", pCurrencyCode);
        GenJnlLine.Validate(Amount, pAmount);
        wRoundEcart += GenJnlLine.Amount;
        InsertGLEntry;
    end;


    procedure GetApplyToID()
    begin
        if StockSetup."Use Journal Template" then
            if AppliToID = '' then
                AppliToID := NoSeriesMngt.TryGetNextNo(GenJnlBatch."No. Series", StockLine."Posting Date")
            else
                AppliToID := IncStr(AppliToID)
        else
            AppliToID := NoSeriesMngt.GetNextNo(
              StockSetup."Posting No. Series", StockLine."Posting Date", true);
    end;


    procedure GetChargeCurrency(): Code[10]
    begin
        if StockLine."Bal. Account Type" = StockLine."bal. account type"::Bank then
            exit(Bank."Currency Code")
        else
            exit('');
    end;


    procedure CalcAverageCost(var pStockLine: Record "Stock Line"; pCancel: Boolean)
    var
        lAverageCost: Decimal;
        lAverageCostLCY: Decimal;
        lStockLine: Record "Stock Line";
        lIsNullStatus: Boolean;
    begin
        AssignQty := 0;
        AssignAmount := 0;
        lStockLine.Reset;
        with lStockLine do begin
            SetRange("Stock Code", pStockLine."Stock Code");
            SetRange(Certified, true);
            SetRange(Open, true);
            SetFilter(Type, '%1|%2', Type::Purchase, Type::Sale);
            if Find('-') then
                repeat
                    if Type = Type::Purchase then begin
                        AssignQty += Quantity;
                        AssignAmount += Amount;
                    end else begin
                        lAverageCost := AssignAmount / AssignQty;
                        AssignQty -= Quantity;
                        AssignAmount -= (Quantity * lAverageCost);
                    end;
                    if AssignAmount <> 0 then
                        lAverageCost := AssignAmount / AssignQty;

                    if AssignQty = 0 then begin
                        AssignQty := 1;
                        AssignAmount := lAverageCost;
                    end;
                until Next = 0;
        end;

        with pStockLine do begin
            if Type = Type::Purchase then begin
                if not pCancel then begin
                    AssignQty += Quantity;
                    AssignAmount += Amount;
                end;
                if AssignAmount <> 0 then
                    lAverageCost := AssignAmount / AssignQty;
            end else
                AssignAmount := ("Unit Price" - lAverageCost) * Quantity;

            lAverageCostLCY := UpdateLCY(lAverageCost);
            "Average Cost" := lAverageCost;
            "Average Cost (LCY)" := UpdateLCY(lAverageCostLCY);
            Certified := true;
            Modify;
        end;

        lStockLine.ModifyAll("Average Cost", lAverageCost);
        lStockLine.ModifyAll("Average Cost (LCY)", lAverageCostLCY);
    end;
}

