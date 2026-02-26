//GL3900 
// page 71469 "Apply Employee Entries2"
// {//GL2024  ID dans Nav 2009 : "39001469"
//     Caption = 'Apply Employee Entries';
//     DataCaptionFields = "Employee No.";
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     PageType = List;
//     SourceTable = "Employee Ledger Entry2";
//     UsageCategory = Lists;
//     ApplicationArea = all;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Posting Date"; rec."Posting Date")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;

//                 }
//                 field("Document Type"; rec."Document Type")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("External Document No."; rec."External Document No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Employee No."; rec."Employee No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Currency Code"; rec."Currency Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Original Amount"; rec."Original Amount")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field(Amount; rec.Amount)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Remaining Amount"; rec."Remaining Amount")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("CalcApplnRemainingAmount(Remaining Amount)"; CalcApplnRemainingAmount(rec."Remaining Amount"))
//                 {
//                     ApplicationArea = all;
//                     AutoFormatExpression = ApplnCurrencyCode;
//                     AutoFormatType = 1;
//                     Caption = 'Appln. Remaining Amount';
//                 }
//                 field("Due Date"; rec."Due Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pmt. Discount Date"; rec."Pmt. Discount Date")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Pmt. Disc. Possible"; rec."Pmt. Disc. Possible")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("CalcApplnRemainingAmount(Pmt. Disc. Possible)"; CalcApplnRemainingAmount(rec."Pmt. Disc. Possible"))
//                 {
//                     AutoFormatExpression = ApplnCurrencyCode;
//                     AutoFormatType = 1;
//                     Caption = 'Appln. Pmt. Disc. Possible';
//                 }
//                 field("Applies-to ID"; rec."Applies-to ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Open; rec.Open)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Positive; rec.Positive)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Global Dimension 1 Code"; rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Global Dimension 2 Code"; rec."Global Dimension 2 Code")
//                 {
//                 }
//             }
//             group(General)
//             {

//                 ShowCaption = false;
//                 field(ApplnCurrencyCode; ApplnCurrencyCode)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Appln. Currency';
//                     Editable = false;
//                     TableRelation = Currency;
//                 }
//                 field(ShowAmount; ShowAmount)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatExpression = ApplnCurrencyCode;
//                     AutoFormatType = 1;
//                     Caption = 'Amount';
//                     Editable = false;
//                 }
//                 field(AppliedAmount; AppliedAmount)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatExpression = ApplnCurrencyCode;
//                     AutoFormatType = 1;
//                     Caption = 'Applied Amount';
//                     Editable = false;
//                 }
//                 field(ApplnRounding; ApplnRounding)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatExpression = ApplnCurrencyCode;
//                     AutoFormatType = 1;
//                     Caption = 'Rounding';
//                     Editable = false;
//                 }
//                 field("AppliedAmount +ShowAmount + ApplnRounding"; AppliedAmount + ShowAmount + ApplnRounding)
//                 {
//                     ApplicationArea = all;
//                     AutoFormatExpression = ApplnCurrencyCode;
//                     AutoFormatType = 1;
//                     Caption = 'Balance';
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Ent&ry")
//             {
//                 Caption = 'Ent&ry';
//                 /* GL2024 action(Dimensions)
//                  { ApplicationArea = all;
//                      Caption = 'Dimensions';
//                      Image = Dimensions;
//                      RunObject = Page 544;
//                      RunPageLink = "Table ID"=CONST(25), "Entry No."=FIELD("Entry No.");
//                      ShortCutKey = 'Ctrl+F7';
//                  }*/
//                 action("Detailed &Ledger Entries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Detailed &Ledger Entries';
//                     RunObject = page "Detailed Employee Ledg Entries";
//                     RunPageLink = "Employee Ledger Entry No." = FIELD("Entry No.");
//                     RunPageView = SORTING("Employee Ledger Entry No.", "Posting Date");
//                     ShortCutKey = 'Ctrl+F7';
//                 }
//             }
//             group("&Application")
//             {
//                 Caption = '&Application';
//                 action("Applied E&ntries")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Applied E&ntries';
//                     RunObject = page "Employee Card Bloqued";
//                     RunPageOnRec = true;
//                 }
//                 action("Set Applies-to ID")
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Set Applies-to ID';
//                     Image = SelectLineToApply;
//                     ShortCutKey = 'F7';

//                     trigger OnAction()
//                     begin
//                         GenJnlApply.CheckAgainstApplnCurrency(
//                           ApplnCurrencyCode, REC."Currency Code", GenJnlLine."Account Type"::"IC Partner", TRUE);

//                         EmplLedgEntry.COPY(Rec);
//                         CurrPage.SETSELECTIONFILTER(EmplLedgEntry);
//                         IF GenJnlLineApply THEN
//                             EmplEntrySetApplID.SetApplId(EmplLedgEntry, GenJnlLine."Applies-to ID")
//                         ELSE
//                             EmplEntrySetApplID.SetApplId(EmplLedgEntry, PurchHeader."Applies-to ID");

//                         CalcApplnAmount;
//                     end;
//                 }
//             }
//         }
//         area(processing)
//         {
//             action("&Navigate")
//             {
//                 ApplicationArea = all;
//                 Caption = '&Navigate';
//                 Image = Navigate;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     Navigate.SetDoc(rec."Posting Date", rec."Document No.");
//                     Navigate.RUN;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         CalcApplnRemainingAmountRemain(FORMAT(CalcApplnRemainingAmount(rec."Remaining Amount")));
//         CalcApplnRemainingAmountPmtDis(FORMAT(CalcApplnRemainingAmount(rec."Pmt. Disc. Possible")));
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", Rec);
//         EXIT(FALSE);
//     end;

//     trigger OnOpenPage()
//     begin
//         IF CalcType = CalcType::Direct THEN BEGIN
//             Empl.GET(rec."Employee No.");
//             ApplnCurrencyCode := Empl."Currency Code";
//         END;

//         EmplLedgEntry.COPY(Rec);
//         GLSetup.GET;

//         CalcApplnAmount;
//     end;

//     var
//         Text000: Label 'Undefined';
//         AppliedEmplLedgEntry: Record "Employee Ledger Entry2";
//         Currency: Record Currency;
//         CurrExchRate: Record "Currency Exchange Rate";
//         GenJnlLine: Record "Gen. Journal Line";
//         GenJnlLine2: Record "Gen. Journal Line";
//         PurchHeader: Record "Purchase Header";
//         Empl: Record Employee;
//         EmplLedgEntry: Record "Employee Ledger Entry2";
//         GLSetup: Record "General Ledger Setup";
//         TotalPurchLine: Record "Purchase Line";
//         TotalPurchLineLCY: Record "Purchase Line";
//         Navigate: Page Navigate;
//         EmplEntrySetApplID: Codeunit "Empl. Entry-SetAppl.ID2";
//         GenJnlApply: Codeunit "Gen. Jnl.-Apply";
//         PurchPost: Codeunit "Purch.-Post";
//         GenJnlLineApply: Boolean;
//         AppliedAmount: Decimal;
//         ShowAmount: Decimal;
//         ApplnDate: Date;
//         ApplnCurrencyCode: Code[10];
//         ApplnRoundingPrecision: Decimal;
//         ApplnRounding: Decimal;
//         ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
//         AmountRoundingPrecision: Decimal;
//         VATAmount: Decimal;
//         VATAmountText: Text[30];
//         CalcType: Option Direct,GenJnlLine,PurchHeader;
//         IsUpdated: Boolean;
//         EmplEntryApplID: Code[20];
//         ValidExchRate: Boolean;
//         DifferentCurrenciesFound: Boolean;
//         DifferentCurrenciesInAppln: Boolean;


//     procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line"; ApplnTypeSelect: Integer)
//     begin
//         GenJnlLine := NewGenJnlLine;
//         GenJnlLineApply := TRUE;

//         IF GenJnlLine."Account Type" = GenJnlLine."Account Type"::"IC Partner" THEN
//             ShowAmount := GenJnlLine.Amount;
//         IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"IC Partner" THEN
//             ShowAmount := -GenJnlLine.Amount;
//         ApplnDate := GenJnlLine."Posting Date";
//         ApplnCurrencyCode := GenJnlLine."Currency Code";
//         CalcType := CalcType::GenJnlLine;

//         CASE ApplnTypeSelect OF
//             GenJnlLine.FIELDNO("Applies-to Doc. No."):
//                 ApplnType := ApplnType::"Applies-to Doc. No.";
//             GenJnlLine.FIELDNO("Applies-to ID"):
//                 ApplnType := ApplnType::"Applies-to ID";
//         END;
//     end;


//     procedure SetPurch(NewPurchHeader: Record "Purchase Header"; var NewEmplLedgEntry: Record "Employee Ledger Entry2"; ApplnTypeSelect: Integer)
//     begin
//         PurchHeader := NewPurchHeader;
//         Rec.COPYFILTERS(NewEmplLedgEntry);

//         PurchPost.SumPurchLines(
//           PurchHeader, 0, TotalPurchLine, TotalPurchLineLCY,
//           VATAmount, VATAmountText);

//         CASE PurchHeader."Document Type" OF
//             PurchHeader."Document Type"::"Return Order",
//           PurchHeader."Document Type"::"Credit Memo":
//                 ShowAmount := TotalPurchLine."Amount Including VAT"
//             ELSE
//                 ShowAmount := -TotalPurchLine."Amount Including VAT";
//         END;

//         ApplnDate := PurchHeader."Posting Date";
//         ApplnCurrencyCode := PurchHeader."Currency Code";
//         CalcType := CalcType::PurchHeader;

//         CASE ApplnTypeSelect OF
//             PurchHeader.FIELDNO("Applies-to Doc. No."):
//                 ApplnType := ApplnType::"Applies-to Doc. No.";
//             PurchHeader.FIELDNO("Applies-to ID"):
//                 ApplnType := ApplnType::"Applies-to ID";
//         END;
//     end;


//     procedure CalcApplnAmount()
//     var
//         ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
//         I: Integer;
//     begin
//         AppliedAmount := 0;
//         DifferentCurrenciesInAppln := FALSE;

//         CASE CalcType OF
//             CalcType::Direct:
//                 BEGIN
//                     ShowAmount := 0;
//                     ApplnDate := REC."Posting Date";
//                     ApplnCurrencyCode := REC."Currency Code";
//                     EmplLedgEntry := Rec;
//                     FindAmountRounding;
//                     EmplEntryApplID := USERID;
//                     IF EmplEntryApplID = '' THEN
//                         EmplEntryApplID := '***';

//                     AppliedEmplLedgEntry.SETCURRENTKEY("Employee No.", Open, Positive);
//                     AppliedEmplLedgEntry.SETRANGE("Employee No.", REC."Employee No.");
//                     AppliedEmplLedgEntry.SETRANGE(Open, TRUE);
//                     AppliedEmplLedgEntry.SETRANGE("Applies-to ID", EmplEntryApplID);

//                     WITH AppliedEmplLedgEntry DO BEGIN
//                         IF FIND('-') THEN BEGIN
//                             // Management of no "Applies-to ID" on the current record
//                             IF EmplLedgEntry."Applies-to ID" <> EmplEntryApplID THEN BEGIN
//                                 ApplnDate := "Posting Date";
//                                 ApplnCurrencyCode := "Currency Code";
//                             END;

//                             REPEAT
//                                 CALCFIELDS("Remaining Amount");
//                                 // Management of multiple currencies
//                                 IF "Currency Code" <> ApplnCurrencyCode THEN BEGIN
//                                     "Remaining Amount" :=
//                                       CurrExchRate.ExchangeAmtFCYToFCY(
//                                         ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");
//                                     "Pmt. Disc. Possible" :=
//                                       CurrExchRate.ExchangeAmtFCYToFCY(
//                                         ApplnDate, "Currency Code", ApplnCurrencyCode, "Pmt. Disc. Possible");
//                                 END;

//                                 // Check for Payment Discount
//                                 EmplLedgEntry.CALCFIELDS("Remaining Amount");
//                                 IF (EmplLedgEntry."Document Type" = EmplLedgEntry."Document Type"::Payment) AND
//                                    ("Document Type" = "Document Type"::Invoice) AND
//                                    (EmplLedgEntry."Posting Date" <= "Pmt. Discount Date") AND
//                                    (ABS(EmplLedgEntry."Remaining Amount") + ApplnRoundingPrecision >=
//                                     ABS("Remaining Amount" - "Pmt. Disc. Possible"))
//                                 THEN
//                                     "Remaining Amount" := "Remaining Amount" - "Pmt. Disc. Possible";

//                                 IF EmplLedgEntry."Entry No." <> "Entry No." THEN BEGIN
//                                     AppliedAmount := AppliedAmount + ROUND("Remaining Amount", AmountRoundingPrecision);
//                                     IF EmplLedgEntry."Remaining Amount" > 0 THEN BEGIN
//                                         EmplLedgEntry."Remaining Amount" :=
//                                           EmplLedgEntry."Remaining Amount" + "Remaining Amount";
//                                         IF EmplLedgEntry."Remaining Amount" < 0 THEN
//                                             EmplLedgEntry."Remaining Amount" := 0;
//                                     END;
//                                     IF EmplLedgEntry."Remaining Amount" < 0 THEN BEGIN
//                                         EmplLedgEntry."Remaining Amount" :=
//                                           EmplLedgEntry."Remaining Amount" + "Remaining Amount";
//                                         IF EmplLedgEntry."Remaining Amount" > 0 THEN
//                                             EmplLedgEntry."Remaining Amount" := 0;
//                                     END;
//                                 END ELSE
//                                     ShowAmount := "Remaining Amount";

//                                 DifferentCurrenciesInAppln :=
//                                   DifferentCurrenciesInAppln OR (ApplnCurrencyCode <> "Currency Code");
//                             UNTIL NEXT = 0;
//                         END;
//                     END;
//                     CheckRounding;
//                 END;

//             CalcType::GenJnlLine:
//                 BEGIN
//                     FindAmountRounding;
//                     IF GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"IC Partner" THEN
//                         ExchAccGLJnlLine.RUN(GenJnlLine);

//                     CASE ApplnType OF
//                         ApplnType::"Applies-to Doc. No.":
//                             BEGIN
//                                 AppliedEmplLedgEntry := Rec;
//                                 WITH AppliedEmplLedgEntry DO BEGIN
//                                     CALCFIELDS("Remaining Amount");
//                                     IF "Currency Code" <> ApplnCurrencyCode THEN BEGIN
//                                         "Remaining Amount" :=
//                                           CurrExchRate.ExchangeAmtFCYToFCY(
//                                             ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");
//                                         "Pmt. Disc. Possible" :=
//                                           CurrExchRate.ExchangeAmtFCYToFCY(
//                                             ApplnDate, "Currency Code", ApplnCurrencyCode, "Pmt. Disc. Possible");
//                                     END;

//                                     IF (GenJnlLine."Document Type" = GenJnlLine."Document Type"::Payment) AND
//                                        (AppliedEmplLedgEntry."Document Type" = AppliedEmplLedgEntry."Document Type"::Invoice) AND
//                                        (GenJnlLine."Posting Date" <= "Pmt. Discount Date") AND
//                                        ((ABS(GenJnlLine.Amount) + ApplnRoundingPrecision >=
//                                         ABS("Remaining Amount" - "Pmt. Disc. Possible")) OR
//                                         (GenJnlLine.Amount = 0))
//                                     THEN
//                                         "Remaining Amount" := "Remaining Amount" - "Pmt. Disc. Possible";

//                                     AppliedAmount := AppliedAmount + ROUND("Remaining Amount", AmountRoundingPrecision);
//                                     DifferentCurrenciesInAppln :=
//                                       DifferentCurrenciesInAppln OR (ApplnCurrencyCode <> "Currency Code");
//                                 END;
//                                 CheckRounding;
//                             END;

//                         ApplnType::"Applies-to ID":
//                             BEGIN
//                                 GenJnlLine2 := GenJnlLine;
//                                 WITH EmplLedgEntry DO BEGIN
//                                     AppliedEmplLedgEntry.SETCURRENTKEY("Employee No.", Open, Positive);
//                                     AppliedEmplLedgEntry.SETRANGE("Employee No.", GenJnlLine."Account No.");
//                                     AppliedEmplLedgEntry.SETRANGE(Open, TRUE);

//                                     IF GenJnlLine."Applies-to ID" <> '' THEN
//                                         AppliedEmplLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID")
//                                     ELSE
//                                         AppliedEmplLedgEntry.SETRANGE("Applies-to ID", PurchHeader."No.");

//                                     FOR I := 1 TO 2 DO BEGIN
//                                         IF GenJnlLine.Amount <> 0 THEN BEGIN
//                                             IF I = 1 THEN
//                                                 AppliedEmplLedgEntry.SETRANGE(Positive, GenJnlLine.Amount > 0)
//                                             ELSE
//                                                 AppliedEmplLedgEntry.SETRANGE(Positive, GenJnlLine.Amount < 0);
//                                         END
//                                         ELSE
//                                             I := 2;

//                                         WITH AppliedEmplLedgEntry DO BEGIN
//                                             IF FIND('-') THEN
//                                                 REPEAT
//                                                     CALCFIELDS("Remaining Amount");
//                                                     IF "Currency Code" <> ApplnCurrencyCode THEN BEGIN
//                                                         "Remaining Amount" :=
//                                                           CurrExchRate.ExchangeAmtFCYToFCY(
//                                                             ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");
//                                                         "Remaining Amount" := ROUND("Remaining Amount", AmountRoundingPrecision);
//                                                         "Pmt. Disc. Possible" :=
//                                                           CurrExchRate.ExchangeAmtFCYToFCY(
//                                                             ApplnDate, "Currency Code", ApplnCurrencyCode, "Pmt. Disc. Possible");
//                                                         "Pmt. Disc. Possible" := ROUND("Pmt. Disc. Possible", AmountRoundingPrecision);
//                                                     END;
//                                                     IF (GenJnlLine2."Document Type" = GenJnlLine2."Document Type"::Payment) AND
//                                                        (AppliedEmplLedgEntry."Document Type" = AppliedEmplLedgEntry."Document Type"::Invoice) AND
//                                                        (GenJnlLine2."Posting Date" <= "Pmt. Discount Date") AND
//                                                        ((ABS(GenJnlLine2.Amount) + ApplnRoundingPrecision >=
//                                                         ABS("Remaining Amount" - "Pmt. Disc. Possible")) OR
//                                                         (GenJnlLine.Amount = 0))
//                                                     THEN
//                                                         "Remaining Amount" := "Remaining Amount" - "Pmt. Disc. Possible";

//                                                     AppliedAmount := AppliedAmount + ROUND("Remaining Amount", AmountRoundingPrecision);
//                                                     IF GenJnlLine2.Amount > 0 THEN BEGIN
//                                                         GenJnlLine2.Amount :=
//                                                           GenJnlLine2.Amount + "Remaining Amount";
//                                                         IF GenJnlLine2.Amount < 0 THEN
//                                                             GenJnlLine2.Amount := 0;
//                                                     END;
//                                                     IF GenJnlLine2.Amount < 0 THEN BEGIN
//                                                         GenJnlLine2.Amount :=
//                                                           GenJnlLine2.Amount + "Remaining Amount";
//                                                         IF GenJnlLine2.Amount > 0 THEN
//                                                             GenJnlLine2.Amount := 0;
//                                                     END;
//                                                     DifferentCurrenciesInAppln :=
//                                                       DifferentCurrenciesInAppln OR (ApplnCurrencyCode <> "Currency Code");
//                                                 UNTIL NEXT = 0;
//                                         END;
//                                         CheckRounding;
//                                     END;
//                                 END;
//                             END;
//                     END;
//                 END;

//             CalcType::PurchHeader:
//                 BEGIN
//                     FindAmountRounding;

//                     CASE ApplnType OF
//                         ApplnType::"Applies-to Doc. No.":
//                             BEGIN
//                                 AppliedEmplLedgEntry := Rec;
//                                 WITH AppliedEmplLedgEntry DO BEGIN
//                                     CALCFIELDS("Remaining Amount");
//                                     IF "Currency Code" <> ApplnCurrencyCode THEN
//                                         "Remaining Amount" :=
//                                           CurrExchRate.ExchangeAmtFCYToFCY(
//                                             ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");
//                                     AppliedAmount := AppliedAmount + ROUND("Remaining Amount", AmountRoundingPrecision);
//                                     DifferentCurrenciesInAppln :=
//                                       DifferentCurrenciesInAppln OR (ApplnCurrencyCode <> "Currency Code");
//                                 END;
//                                 CheckRounding;
//                             END;

//                         ApplnType::"Applies-to ID":
//                             BEGIN
//                                 WITH EmplLedgEntry DO BEGIN
//                                     AppliedEmplLedgEntry.SETCURRENTKEY("Employee No.", Open, Positive);
//                                     AppliedEmplLedgEntry.SETRANGE("Employee No.", PurchHeader."Pay-to Vendor No.");
//                                     AppliedEmplLedgEntry.SETRANGE(Open, TRUE);

//                                     IF PurchHeader."Applies-to ID" <> '' THEN
//                                         AppliedEmplLedgEntry.SETRANGE("Applies-to ID", PurchHeader."Applies-to ID")
//                                     ELSE
//                                         AppliedEmplLedgEntry.SETRANGE("Applies-to ID", PurchHeader."No.");

//                                     FOR I := 1 TO 2 DO BEGIN
//                                         IF GenJnlLine.Amount <> 0 THEN BEGIN
//                                             IF I = 1 THEN
//                                                 AppliedEmplLedgEntry.SETRANGE(Positive, GenJnlLine.Amount > 0)
//                                             ELSE
//                                                 AppliedEmplLedgEntry.SETRANGE(Positive, GenJnlLine.Amount < 0);
//                                         END
//                                         ELSE
//                                             I := 2;

//                                         WITH AppliedEmplLedgEntry DO BEGIN
//                                             IF FIND('-') THEN
//                                                 REPEAT
//                                                     CALCFIELDS("Remaining Amount");
//                                                     IF "Currency Code" <> ApplnCurrencyCode THEN
//                                                         "Remaining Amount" :=
//                                                           CurrExchRate.ExchangeAmtFCYToFCY(
//                                                             ApplnDate, "Currency Code", ApplnCurrencyCode, "Remaining Amount");
//                                                     AppliedAmount := AppliedAmount + ROUND("Remaining Amount", AmountRoundingPrecision);
//                                                     DifferentCurrenciesInAppln :=
//                                                       DifferentCurrenciesInAppln OR (ApplnCurrencyCode <> "Currency Code");
//                                                 UNTIL NEXT = 0;
//                                         END;
//                                         CheckRounding;
//                                     END;
//                                 END;
//                             END;
//                     END;
//                 END;
//         END;
//     end;


//     procedure CalcApplnRemainingAmount(Amount: Decimal): Decimal
//     var
//         ApplnRemainingAmount: Decimal;
//     begin
//         ValidExchRate := TRUE;
//         IF ApplnCurrencyCode = REC."Currency Code" THEN
//             EXIT(Amount)
//         ELSE BEGIN
//             IF ApplnDate = 0D THEN
//                 ApplnDate := REC."Posting Date";
//             ApplnRemainingAmount :=
//               CurrExchRate.ApplnExchangeAmtFCYToFCY(
//                 ApplnDate, REC."Currency Code", ApplnCurrencyCode, Amount, ValidExchRate);
//             EXIT(ApplnRemainingAmount);
//         END;
//     end;


//     procedure FindAmountRounding()
//     begin
//         IF ApplnCurrencyCode = '' THEN BEGIN
//             Currency.INIT;
//             Currency.Code := '';
//             Currency.InitRoundingPrecision;
//         END ELSE
//             IF ApplnCurrencyCode <> Currency.Code THEN
//                 Currency.GET(ApplnCurrencyCode);

//         AmountRoundingPrecision := Currency."Amount Rounding Precision";
//     end;


//     procedure CheckRounding()
//     begin
//         ApplnRounding := 0;

//         CASE CalcType OF
//             CalcType::PurchHeader:
//                 EXIT;
//             CalcType::GenJnlLine:
//                 IF GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment THEN
//                     EXIT;
//             CalcType::Direct:
//                 IF REC."Document Type" <> REC."Document Type"::Payment THEN
//                     EXIT;
//         END;

//         IF ApplnCurrencyCode = '' THEN
//             ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision"
//         ELSE BEGIN
//             IF ApplnCurrencyCode <> REC."Currency Code" THEN
//                 Currency.GET(ApplnCurrencyCode);
//             ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
//         END;

//         IF (ABS(AppliedAmount + ShowAmount) <= ApplnRoundingPrecision) AND DifferentCurrenciesInAppln THEN
//             ApplnRounding := -(AppliedAmount + ShowAmount);
//     end;


//     procedure GetVendLedgEntry(var VendLedgEntry: Record "Vendor Ledger Entry")
//     begin
//         EmplLedgEntry := Rec;
//     end;


//     procedure DifferentCurrenciesInFilter(var EmplLedgEntry: Record "Employee Ledger Entry2"): Boolean
//     var
//         EmplLedgEntry2: Record "Employee Ledger Entry2";
//     begin
//         IF DifferentCurrenciesFound THEN
//             EXIT(TRUE);
//         EmplLedgEntry2.COPYFILTERS(EmplLedgEntry);
//         EmplLedgEntry2.SETFILTER("Currency Code", '<>%1', EmplLedgEntry."Currency Code");
//         DifferentCurrenciesFound := EmplLedgEntry2.FIND('-');
//         EXIT(DifferentCurrenciesFound);
//     end;

//     local procedure CalcApplnRemainingAmountRemain(Text: Text[1024])
//     begin
//         IF NOT ValidExchRate THEN
//             Text := Text000;
//         ValidExchRate := TRUE;
//     end;

//     local procedure CalcApplnRemainingAmountPmtDis(Text: Text[1024])
//     begin
//         IF NOT ValidExchRate THEN
//             Text := Text000;
//         ValidExchRate := TRUE;
//     end;
// }

