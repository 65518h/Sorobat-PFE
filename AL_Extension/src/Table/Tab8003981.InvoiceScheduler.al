Table 8003981 "Invoice Scheduler"
{
    // //PROJET_FACT GESWAY 03/07/02 Nouvelle table (créée à partir table 37)
    // //BAT_ABO CW 02/01/06 +"Subscription Starting Date", "Subscription End Date"
    // //PV ML 19/10/06 Interaction sur Invoice
    // //+WKF+CUSTOM ML 22/09/06 Launch procedure  #3703
    // //+JOB+ CLA 23/10/07 Renseignement Job Task No

    Caption = 'Invoice Scheduler';
    DataCaptionFields = "Sales Header Doc. No.";
    //  DrillDownPageID = 8003981;
    // LookupPageID = 8003981;
    PasteIsValid = false;

    fields
    {
        field(11; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            begin
                if "Job No." = '' then
                    exit;
                if "Job No." <> Job."No." then
                    Job.Get("Job No.");

                Job.TestField(Blocked, Job.Blocked::" ");
                Job.TestField(Finished, false);
                if "Sales Header Doc. Type" <> "sales header doc. type"::Quote then
                    Job.TestField(Status, Job.Status::Open);

                //+JOB+
                "Job Task No." := Job.gGetDefaultJobTask;
                //+JOB+//
            end;
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "AutoFormat Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));

            trigger OnValidate()
            var
                lJobTask: Record "Job Task";
            begin
                if lJobTask.Get("Job No.", "Job Task No.") then
                    lJobTask.TestField("Job Task Type", 0);
            end;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
        }
        field(8003979; Comment; Boolean)
        {
            CalcFormula = exist("Description Line" where("Table ID" = const(8003981),
                                                          "Document Type" = field("Sales Header Doc. Type"),
                                                          "Document No." = field("Sales Header Doc. No."),
                                                          "Document Line No." = field("Line No.")));
            Caption = 'Comment';
            FieldClass = FlowField;
        }
        field(8003980; "Forecast Date"; Date)
        {
            Caption = 'Expected Date';

            trigger OnValidate()
            begin
                Validate("Payment Terms Code");
            end;
        }
        field(8003981; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(8003982; "Amount to Emit"; Decimal)
        {
            AutoFormatExpression = "AutoFormat Currency Code";
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Amount to Emit';

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
                //#8568
                TestStatusOpen;
                //#8568//
                TestField("Amount Emitted", 0);
                if ("Amount to Emit" <> xRec."Amount to Emit") and (CurrFieldNo <> 0) then begin
                    lSalesLine.SetFilter("Document Type", '%1|%2', lSalesLine."document type"::Invoice, lSalesLine."document type"::"Credit Memo");
                    lSalesLine.SetRange("Order No.", "Sales Header Doc. No.");
                    lSalesLine.SetRange("Scheduler Line No.", "Line No.");
                    if lSalesLine.Find('-') then
                        Error(tInvoicePending, FieldCaption("Amount to Emit"), lSalesLine."Document Type", lSalesLine."Document No.");
                end;
                if ("Amount to Emit" <> xRec."Amount to Emit") and (CurrFieldNo = FieldNo("Amount to Emit")) then
                    "Document Percentage" := 0;

                /*
                IF "Sales Header Cur. Code" = '' THEN
                  "Amount to Emit (LCY)" := ROUND("Amount to Emit",Currency."Amount Rounding Precision")
                ELSE BEGIN
                  GetCurrency;
                  "Amount to Emit (LCY)" :=
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Sales Header Cur. Code",
                        "Amount to Emit",SalesHeader."Currency Factor");
                END;
                */
                lGetSalesHeader();
                if SalesHeader."Currency Code" = '' then
                    "Amount to Emit (LCY)" := "Amount to Emit"
                else
                    "Amount to Emit (LCY)" := ROUND("Amount to Emit" / SalesHeader."Currency Factor", GLSetup."Amount Rounding Precision");

            end;
        }
        field(8003983; "Amount Emitted"; Decimal)
        {
            AutoFormatExpression = "AutoFormat Currency Code";
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Amount Emitted';
            Editable = false;

            trigger OnValidate()
            begin
                /*
                IF "Sales Header Cur. Code" = '' THEN
                  "Amount Emitted (LCY)" := "Amount Emitted"
                ELSE BEGIN
                  GetCurrency;
                  "Amount Emitted (LCY)" :=
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Sales Header Cur. Code",
                        "Amount Emitted",SalesHeader."Currency Factor");
                END;
                */
                lGetSalesHeader();
                if SalesHeader."Currency Code" = '' then
                    "Amount Emitted (LCY)" := "Amount Emitted"
                else
                    "Amount Emitted (LCY)" := ROUND("Amount Emitted" / SalesHeader."Currency Factor", Currency."Amount Rounding Precision");

            end;
        }
        field(8003985; "Sales Header Doc. Type"; Option)
        {
            Caption = 'Document Type';
            InitValue = Invoice;
            OptionCaption = 'Quote,Order,Invoice,Credit Memo';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo";
        }
        field(8003986; "Sales Header Doc. No."; Code[20])
        {
            Caption = 'Scheduler Document No.';
        }
        field(8003988; "Progress Degree"; Code[10])
        {
            Caption = 'Progress Degree';
            TableRelation = "Document Progress Degree" where("Document Type" = const(Order));

            trigger OnValidate()
            var
                lProgress: Record "Document Progress Degree";
            begin
                lProgress.Get("Progress Degree", lProgress."document type"::Order);
                Description := lProgress.Description;
            end;
        }
        field(8003990; "Document Percentage"; Decimal)
        {
            //blankzero = true;
            Caption = 'Document Percentage';
            MaxValue = 100;
            MinValue = -100;

            trigger OnValidate()
            var
                lInvScheduler: Record "Invoice Scheduler";
                lTotalLCY: Decimal;
                lTotal: Decimal;
            begin
                if "Document Percentage" = 0 then
                    Validate("Amount to Emit", 0)
                else begin
                    //  IF GetSalesHeader AND (DocAmountLCY = 0) THEN
                    //    CalcDocAmount(DocAmountLCY,NoPercAmountLCY,DocAmount,NoPercAmount);
                    lGetSalesHeader();
                    lInvScheduler.SetCurrentkey("Sales Header Doc. Type", "Sales Header Doc. No.", "Line No.");
                    lInvScheduler.SetRange("Sales Header Doc. Type", "Sales Header Doc. Type");
                    lInvScheduler.SetRange("Sales Header Doc. No.", "Sales Header Doc. No.");
                    lInvScheduler.SetFilter("Line No.", '<>%1', "Line No.");
                    lInvScheduler.CalcSums("Amount to Emit (LCY)", "Document Percentage", "Amount to Emit");
                    lTotalLCY := lInvScheduler."Amount to Emit (LCY)";
                    lTotal := lInvScheduler."Amount to Emit";
                    if (lInvScheduler."Document Percentage" + "Document Percentage" - xRec."Document Percentage") = 100 then begin
                        if RoundLine = 0 then
                            RoundLine := lSearchRoundLine(Rec);
                        if ("Line No." <> RoundLine) and (RoundLine <> 0) then begin
                            Validate("Amount to Emit",
                              ROUND((DocAmount - NoPercAmount) * "Document Percentage" / 100, Currency."Amount Rounding Precision"));
                            //      VALIDATE("Amount to Emit (LCY)",
                            //        ROUND((DocAmountLCY - NoPercAmountLCY) * "Document Percentage" / 100,GLSetup."Amount Rounding Precision"));
                        end else
                            if ("Line No." = RoundLine) and (RoundLine <> 0) then begin
                                Validate("Amount to Emit", DocAmount - NoPercAmount - lTotal);
                                //      VALIDATE("Amount to Emit (LCY)",DocAmountLCY - NoPercAmountLCY - lTotalLCY);
                            end;
                    end else
                        if (lInvScheduler."Document Percentage" + "Document Percentage" - xRec."Document Percentage") < 100 then begin
                            //#7445
                            if RoundLine = 0 then
                                RoundLine := lSearchRoundLine(Rec);
                            if ("Line No." = RoundLine) and (RoundLine <> 0) then begin
                                Validate("Amount to Emit", DocAmount - NoPercAmount - lTotal);
                            end else begin
                                //#7445//

                                Validate("Amount to Emit",
                                  ROUND((DocAmount - NoPercAmount) * "Document Percentage" / 100, Currency."Amount Rounding Precision"));
                                Validate("Amount to Emit (LCY)",
                                  ROUND((DocAmountLCY - NoPercAmountLCY) * "Document Percentage" / 100, GLSetup."Amount Rounding Precision"));
                                //#7445
                            end;
                            //#7445//
                        end else begin
                            Validate("Amount to Emit", 0);
                            Validate("Amount to Emit (LCY)", 0);
                        end;
                end;
            end;
        }
        field(8003992; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";

            trigger OnValidate()
            begin
                if ("Payment Terms Code" <> '') and ("Forecast Date" <> 0D) then begin
                    PaymentTerms.Get("Payment Terms Code");
                    "Due Date" := CalcDate(PaymentTerms."Due Date Calculation", "Forecast Date");
                end else
                    Validate("Due Date", "Forecast Date");
            end;
        }
        field(8003993; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(8003994; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(8003995; Invoice; Boolean)
        {
            Caption = 'Chargeable';

            trigger OnValidate()
            var
                lWorkflowMgt: Codeunit "Workflow Management2";
                lWorkflowSetup: Record "Workflow Setup";
            begin
                TestField("Job No.");
                TestField("Job Task No.");
                TestField("Amount Emitted", 0);
                TestField("Sales Header Doc. Type", "sales header doc. type"::Order);
                //PV
                if Invoice then begin
                    wCreateInteraction;
                    //+WKF+CUSTOM
                    //IF lWorkflowSetup.GET AND lWorkflowSetup."Sales Order to Invoice" THEN BEGIN
                    //#7911
                    if lWorkflowSetup.ReadPermission then
                        //#7911//
                        if lWorkflowMgt.Exists(page::"Sales Order", '') then begin
                            Commit;
                            if lWorkflowMgt.WorkflowTypeNo(page::"Sales Order", '', "Sales Header Doc. No.", '', '') then;
                        end;
                    //+WKF+CUSTOM//
                end;
                //PV//
            end;
        }
        field(8003996; "Amount to Emit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Amount to Emit (LCY)';
            Editable = false;

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
            begin
                /* Editable = No
                TESTFIELD("Amount Emitted",0);
                
                IF ("Amount to Emit (LCY)" <> xRec."Amount to Emit (LCY)") AND (CurrFieldNo <> 0) THEN BEGIN
                  lSalesLine.SETFILTER("Document Type",'%1|%2',lSalesLine."Document Type"::Invoice,lSalesLine."Document Type"::"Credit Memo");
                  lSalesLine.SETRANGE("Invoice No.","Sales Header Doc. No.");
                  lSalesLine.SETRANGE("Scheduler Line No.","Line No.");
                  IF lSalesLine.FIND('-') THEN
                    ERROR(Text1100280004,FIELDCAPTION("Amount to Emit (LCY)"),lSalesLine."Document Type",lSalesLine."Document No.");
                END;
                
                IF ("Amount to Emit (LCY)" <> xRec."Amount to Emit (LCY)") AND (CurrFieldNo = FIELDNO("Amount to Emit (LCY)")) THEN
                  "Document Percentage" := 0;
                IF "Sales Header Cur. Code" = '' THEN
                  "Amount to Emit" := "Amount to Emit (LCY)"
                ELSE BEGIN
                  GetCurrency;
                  "Amount to Emit" :=
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        GetDate,"Sales Header Cur. Code",
                        "Amount to Emit (LCY)",SalesHeader."Currency Factor");
                END;
                */

            end;
        }
        field(8003997; "Amount Emitted (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Amount Emitted (DS)';
            Editable = false;
        }
        field(8003998; "Posted Doc. type"; Option)
        {
            Caption = 'Posted Document type';
            Editable = false;
            OptionCaption = 'Posted Sales Invoice,Posted Sales Cr. Memo';
            OptionMembers = Invoice,"Cr. Memo";
        }
        field(8003999; "Posted Doc. No."; Code[20])
        {
            Caption = 'Posted document No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Sales Header Doc. Type", "Sales Header Doc. No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = "Document Percentage", "Amount to Emit (LCY)", "Amount to Emit", "Amount Emitted (LCY)";
        }
        key(Key2; "Sales Header Doc. Type", "Sales Header Doc. No.", Invoice, "Line No.")
        {
            SumIndexFields = "Amount to Emit", "Amount to Emit (LCY)", "Amount Emitted", "Amount Emitted (LCY)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        //GL2024    DocDim: Record 357;
        CapableToPromise: Codeunit "Capable to Promise";
    begin
        TestField("Amount Emitted", 0);
    end;

    trigger OnModify()
    begin
        TestField("Amount Emitted", 0);
    end;

    trigger OnRename()
    begin
        TestField("Amount Emitted", 0);
    end;

    var
        SalesHeader: Record "Sales Header";
        Job: Record Job;
        Cust: Record Customer;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        tInvoicePending: label 'You cannot modify %1 because invoice %2 exists.\You must delete invoice %2 first.';
        tOver100: label 'The addition of the pourcentage must not be over 100.';
        Contract: Record "Contract Type";
        DocAmountLCY: Decimal;
        NoPercAmountLCY: Decimal;
        DocAmount: Decimal;
        NoPercAmount: Decimal;
        RoundLine: Integer;
        GLSetup: Record "General Ledger Setup";
        StatusCheckSuspended: Boolean;

    local procedure lGetSalesHeader() Return: Boolean
    begin
        TestField("Sales Header Doc. No.");
        if ("Sales Header Doc. Type" = SalesHeader."Document Type") and ("Sales Header Doc. No." = SalesHeader."No.") then
            exit(true);
        GLSetup.Get;
        Return := SalesHeader.Get("Sales Header Doc. Type", "Sales Header Doc. No.");
        //SalesHeader.TESTFIELD(Status,SalesHeader.Status::Released);
        lCalcDocAmount(DocAmountLCY, NoPercAmountLCY, DocAmount, NoPercAmount);

        if SalesHeader."Currency Code" <> Currency.Code then begin
            if SalesHeader."Currency Code" = '' then
                Currency.InitRoundingPrecision
            else begin
                Currency.Get(SalesHeader."Currency Code");
                Currency.TestField("Amount Rounding Precision");
            end;
        end;
    end;


    procedure InitEnreg()
    begin
        lGetSalesHeader();
        Contract.Get(SalesHeader."Contract Type");
        Validate("AutoFormat Currency Code", SalesHeader."Currency Code");
        Validate("VAT Prod. Posting Group", Contract."VAT Prod. Posting Group");
        Validate("Payment Terms Code", SalesHeader."Payment Terms Code");
        Validate("Payment Method Code", SalesHeader."Payment Method Code");
        if SalesHeader."Job No." <> '' then
            Validate("Job No.", SalesHeader."Job No.");
    end;

    local procedure lCalcDocAmount(var pAmountLCY: Decimal; var pNoPercAmountLCY: Decimal; var pAmount: Decimal; var pNoPercAmount: Decimal)
    var
        lSalesLine: Record "Sales Line";
        lInvScheduler: Record "Invoice Scheduler";
    begin
        /*
        lSalesHeader.SETRANGE("Document Type","Sales Header Doc. Type");
        lSalesHeader.SETRANGE("No.","Sales Header Doc. No.");
        IF lSalesHeader.FIND('-') THEN
          lSalesHeader.CALCFIELDS("Amount Excl. VAT (LCY)");
        */
        lSalesLine.SetCurrentkey("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type");
        lSalesLine.SetRange("Document Type", "Sales Header Doc. Type");
        lSalesLine.SetRange("Document No.", "Sales Header Doc. No.");
        lSalesLine.SetRange("Structure Line No.", 0);
        lSalesLine.SetFilter("Line Type", '>=%1', lSalesLine."line type"::Item);
        lSalesLine.CalcSums("Amount Excl. VAT (LCY)", "Line Amount");
        pAmount := lSalesLine."Line Amount";
        pAmountLCY := lSalesLine."Amount Excl. VAT (LCY)";

        pNoPercAmountLCY := 0;
        pNoPercAmount := 0;
        lInvScheduler.SetCurrentkey("Sales Header Doc. Type", "Sales Header Doc. No.", "Line No.");
        lInvScheduler.SetRange("Sales Header Doc. Type", "Sales Header Doc. Type");
        lInvScheduler.SetRange("Sales Header Doc. No.", "Sales Header Doc. No.");
        lInvScheduler.SetRange("Document Percentage", 0);
        if not lInvScheduler.IsEmpty then
            if lInvScheduler.Find('-') then
                repeat
                    NoPercAmountLCY += lInvScheduler."Amount to Emit (LCY)";
                    NoPercAmount += lInvScheduler."Amount to Emit";
                until lInvScheduler.Next = 0;
        //EXIT(lSalesHeader."Amount Excl. VAT (LCY)");

    end;


    procedure UpdateLineAmount(var pRec: Record "Invoice Scheduler")
    var
        lInvScheduler: Record "Invoice Scheduler";
        lTextDif: label 'is different from then document amount';
        lTotalLCY: Decimal;
        lTotal: Decimal;
    begin
        "Sales Header Doc. Type" := pRec."Sales Header Doc. Type";
        "Sales Header Doc. No." := pRec."Sales Header Doc. No.";
        //DocAmount := CalcDocAmount;
        lGetSalesHeader();
        lInvScheduler.SetRange("Sales Header Doc. Type", "Sales Header Doc. Type");
        lInvScheduler.SetRange("Sales Header Doc. No.", "Sales Header Doc. No.");
        lInvScheduler.SetFilter("Document Percentage", '<>0');
        lInvScheduler.SetRange("Amount Emitted", 0);
        if lInvScheduler.Find('-') then begin
            repeat
                lInvScheduler."AutoFormat Currency Code" := SalesHeader."Currency Code";
                lInvScheduler.Validate("Document Percentage");
                lInvScheduler.Modify;
                lTotal += lInvScheduler."Amount to Emit";
                lTotalLCY += lInvScheduler."Amount to Emit (LCY)";
            until lInvScheduler.Next = 0;
            //#7330
            /*DELETE
              lInvScheduler.VALIDATE("Amount to Emit",
                lInvScheduler."Amount to Emit" + (DocAmount - NoPercAmount - lTotal));



            //  lInvScheduler.VALIDATE("Amount to Emit (LCY)",
            //    lInvScheduler."Amount to Emit (LCY)" + (DocAmountLCY - NoPercAmountLCY - lTotalLCY));
              lInvScheduler.MODIFY;
            */
            //#7330//
        end else begin
            lInvScheduler.SetRange("Document Percentage");
            lInvScheduler.SetRange("Amount Emitted");
            lInvScheduler.CalcSums("Amount to Emit");
            if (lInvScheduler."Amount to Emit" <> 0) and
               (DocAmount <> lInvScheduler."Amount to Emit") then
                pRec.FieldError("Amount to Emit", lTextDif);
        end;

    end;

    local procedure lSearchRoundLine(pRec: Record "Invoice Scheduler"): Integer
    var
        lInvScheduler: Record "Invoice Scheduler";
    begin
        lInvScheduler.SetRange("Sales Header Doc. Type", pRec."Sales Header Doc. Type");
        lInvScheduler.SetRange("Sales Header Doc. No.", pRec."Sales Header Doc. No.");
        lInvScheduler.SetFilter("Document Percentage", '<>0');
        lInvScheduler.SetRange("Amount Emitted", 0);
        if not lInvScheduler.Find('+') then
            exit(0)
        else
            exit(lInvScheduler."Line No.");
    end;


    procedure UpdateInvoice(pDocNo: Code[20]; pProgress: Code[10])
    var
        lInvScheduler: Record "Invoice Scheduler";
        lLastProgressToInvoice: Code[10];
    begin
        with lInvScheduler do begin
            SetCurrentkey("Sales Header Doc. Type", "Sales Header Doc. No.", "Line No.");
            SetRange("Sales Header Doc. Type", "sales header doc. type"::Order);
            SetRange("Sales Header Doc. No.", pDocNo);
            SetRange("Amount Emitted", 0);
            if pProgress <> '' then
                SetFilter("Progress Degree", '<=%1', StrSubstNo('%1*', pProgress));
            if Find('+') then
                lLastProgressToInvoice := "Progress Degree";
            SetRange("Progress Degree");
            if Find('-') then
                repeat
                    if ("Progress Degree" <= lLastProgressToInvoice) and (pProgress <> '') then
                        Invoice := true
                    else
                        Invoice := false;
                    Modify;
                until Next = 0;
        end;
    end;


    procedure wCreateInteraction()
    var
        lInteracLogEntry: Record "Interaction Log Entry";
        lSegLine: Record "Segment Line" temporary;
        lContact: Record Contact;
        lCreateInteraction: Page "Create Interaction";
        lSalesHeader: Record "Sales Header";
        lContractType: Record "Contract Type";
    begin
        //PROJET_ACTION
        lSalesHeader.Get("Sales Header Doc. Type", "Sales Header Doc. No.");
        lSalesHeader.TestField("Sell-to Contact No.");
        lContact.Get(lSalesHeader."Sell-to Contact No.");
        lContractType.Get(lSalesHeader."Contract Type");

        if lContractType."Interaction Template" <> '' then begin

            lSegLine.DeleteAll;
            lSegLine.Init;
            if lContact.Type = lContact.Type::Person then
                lSegLine.SetRange("Contact Company No.", lContact."Company No.");
            lSegLine.SetRange("Contact No.", lContact."No.");
            lSegLine.Validate("Contact No.", lContact."No.");
            lSegLine."Salesperson Code" := lSalesHeader."Salesperson Code";
            lSegLine.Validate(Date, WorkDate);
            lSegLine.Description := lContractType."Interaction Template";
            lSegLine."Document Type" := lSegLine."document type"::"Sales Ord. Cnfrmn.";
            lSegLine."Document No." := lSalesHeader."No.";
            lSegLine."Document Line No." := "Line No.";
            lSegLine.TableID := 8003981;
            lSegLine."Send Word Doc. As Attmt." := true;
            lSegLine.Insert;
            lSegLine.Validate("Interaction Template Code", lContractType."Interaction Template");
            lSegLine.Modify;
            PAGE.RunModal(page::"Create Interaction", lSegLine, lSegLine."Interaction Template Code");
        end;
        //PROJET_ACTION//
    end;

    local procedure TestStatusOpen()
    begin
        //#8568
        if StatusCheckSuspended then
            exit;
        //#8624
        if "Sales Header Doc. Type" <> "sales header doc. type"::Quote then begin
            //#8624//
            SalesHeader.Get("Sales Header Doc. Type", "Sales Header Doc. No.");
            SalesHeader.TestField(Status, SalesHeader.Status::Open);
            //#8624
        end;
        //#8624//
        //#8568//
    end;


    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
        //#8568
        StatusCheckSuspended := Suspend;
        //#8568//
    end;
}

