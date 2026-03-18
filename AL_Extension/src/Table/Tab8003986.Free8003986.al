Table 8003986 Free8003986
{
    // //PROJET_FACT GESWAY 04/04/03 Nouvelle table de suivi de l'avancement de facturation
    //  Calcul du coef de révision :
    //       ((100 - % soumis à révision) + (% soumis à révision * Nouvel indice / Indice de base de la commande)) / 100,
    //  Montant de la révision :
    //       (différence de montant * coef révision) - différence de montant

    DataCaptionFields = "Order No.", "Closing No.";
    // LookupPageID = 8003986;

    fields
    {
        field(1; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(2; "Closing No."; Integer)
        {
            Caption = 'Closing No.';
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(4; "Previous Completion %"; Decimal)
        {
            Caption = 'Previous Completion %';
        }
        field(5; "New Completion %"; Decimal)
        {
            Caption = 'New Completion %';

            trigger OnValidate()
            begin
                CalculateCompletion;
            end;
        }
        field(6; "Completion Difference (%)"; Decimal)
        {
            Caption = 'Completion Difference (%)';
        }
        field(7; "Previous Amount (LCY)"; Decimal)
        {
            Caption = 'Previous Amount (LCY)';
        }
        field(8; "New Amount (LCY)"; Decimal)
        {
            Caption = 'New Amount (LCY)';

            trigger OnValidate()
            begin
                CalculateCompletion;
            end;
        }
        field(9; "Amount Difference (LCY)"; Decimal)
        {
            Caption = 'Amount Difference (LCY)';
        }
        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Posted Sales Invoice,Posted Sales Cr. Memo';
            OptionMembers = "Posted Sales Invoice","Posted Sales Cr. Memo";
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
        }
        field(14; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                CalcCompletionFromDoc;
            end;
        }
        field(15; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(16; "Payment on Account"; Decimal)
        {
            Caption = 'Payment on Account';
        }
        field(17; "Revision Coeficient"; Decimal)
        {
            Caption = 'Index Coefficient';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                GetSalesHeader(SalesHeader."document type"::Order, "Order No.");
                if "Revision Coeficient" = 0 then
                    "Revision Amount (LCY)" := 0
                else
                    "Revision Amount (LCY)" := ("Amount Difference (LCY)" * "Revision Coeficient") - "Amount Difference (LCY)";
            end;
        }
        field(18; Estimation; Boolean)
        {
            Caption = 'Forecast';
        }
        field(19; "Revision Amount (LCY)"; Decimal)
        {
            Caption = 'Audit Amount LCY';
        }
        field(20; "Invoiced Revision Amt (LCY)"; Decimal)
        {
            Caption = 'Invoiced Indexed Amount LCY';
        }
        field(21; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
        }
        field(22; "Invoice Line No. (Revision)"; Integer)
        {
            Caption = 'Invoice Line No. (Revision)';
        }
    }

    keys
    {
        key(STG_Key1; "Order No.", "Closing No.", "Document Type", "Document No.", "Invoice No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Invoice No.", "Invoice Line No. (Revision)")
        {
        }
        key(STG_Key3; "Closing No.", "Order No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        SalesHeader: Record "Sales Header";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PriceIndexValue: Record Free8003985;


    procedure CalculateCompletion()
    var
        lCompletion: Record Free8003986;
    begin
        if ("New Completion %" = 0) and ("Completion Difference (%)" = 0) then
            exit;

        lCompletion.SetRange("Order No.", "Order No.");
        if "Document Type" = "document type"::"Posted Sales Invoice" then
            lCompletion.SetFilter("Closing No.", '<%1', "Closing No.")
        else begin
            lCompletion.SetRange("Document Type", lCompletion."document type"::"Posted Sales Invoice");
            lCompletion.SetRange("Closing No.", "Closing No.");
        end;

        if not lCompletion.Find('+') then
            lCompletion.Init;

        GetSalesHeader(SalesHeader."document type"::Order, "Order No.");
        SalesHeader.CalcFields(Amount);

        "Previous Completion %" := lCompletion."New Completion %";
        "Previous Amount (LCY)" := lCompletion."New Amount (LCY)";

        if "Document Type" = "document type"::"Posted Sales Cr. Memo" then
            "New Completion %" := lCompletion."Previous Completion %";
        if ("New Completion %" <> 0) and ("Completion Difference (%)" = 0) then
            "Completion Difference (%)" := "New Completion %" - "Previous Completion %"
        else
            "New Completion %" := "Previous Completion %" + "Completion Difference (%)";

        if "New Completion %" = 100 then
            "New Amount (LCY)" := SalesHeader.Amount
        else
            "New Amount (LCY)" := SalesHeader.Amount * "New Completion %" / 100;

        if SalesHeader."Currency Code" <> '' then
            "New Amount (LCY)" :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  "Posting Date", SalesHeader."Currency Code",
                  "New Amount (LCY)", SalesHeader."Currency Factor"),
                Currency."Amount Rounding Precision");

        "Amount Difference (LCY)" := "New Amount (LCY)" - "Previous Amount (LCY)";
    end;


    procedure CalcCompletionFromDoc()
    var
        lTotalAmount: Decimal;
    begin
        GetSalesHeader(SalesHeader."document type"::Order, "Order No.");
        SalesHeader.CalcFields(Amount);
        if "Currency Code" = SalesHeader."Currency Code" then
            lTotalAmount := SalesHeader.Amount
        else
            lTotalAmount :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToFCY(
                  "Posting Date", SalesHeader."Currency Code",
                  "Currency Code", SalesHeader.Amount),
                Currency."Amount Rounding Precision");
        if lTotalAmount <> 0 then begin
            "Completion Difference (%)" := Amount / lTotalAmount * 100;
            CalculateCompletion;
        end;
    end;


    procedure CalculateRevision(pOrderNo: Code[20]; pDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo"; pDocNo: Code[20])
    var
        lSalesHeader: Record "Sales Header";
        lSalesInvHeader: Record "Sales Invoice Header";
        lPostingDate: Date;
    begin
        SalesHeader.Get(SalesHeader."document type"::Order, pOrderNo);
        if (SalesHeader."Review Formula Code" = '') then
            exit;

        if not lSalesHeader.Get(pDocType, pDocNo) then
            lSalesHeader.Init;
        if pDocType = 7 then begin
            if not lSalesInvHeader.Get(pDocNo) then
                lSalesInvHeader.Init;
            lPostingDate := lSalesInvHeader."Posting Date";
        end else
            lPostingDate := lSalesHeader."Posting Date";

        //#2714
        /*
        "Revision Coeficient" :=
           CalcCoef(
             SalesHeader."Revision % Submitted",
             PriceIndexValue.GetValue(SalesHeader."Review Formula Code",SalesHeader."Review Base Date"),
             PriceIndexValue.GetValue(SalesHeader."Review Formula Code",lPostingDate));
        
        PriceIndexValue.SETRANGE("Index Code",SalesHeader."Review Formula Code");
        PriceIndexValue.SETRANGE("Starting Date",0D,lPostingDate);
        IF PriceIndexValue.FIND('+') THEN;
          Estimation :=
          ((DATE2DMY(lPostingDate,2) <> DATE2DMY(PriceIndexValue."Starting Date",2)) OR
           (DATE2DMY(lPostingDate,3) <> DATE2DMY(PriceIndexValue."Starting Date",3)));
        */
        //#2714//

    end;


    procedure CalcCoef(pSubmitted: Integer; pBasisIndex: Decimal; pNewIndex: Decimal): Decimal
    begin
        if pBasisIndex <> 0 then
            exit(
              ROUND(
                ((100 - pSubmitted) + (pSubmitted * pNewIndex / pBasisIndex)) / 100,
                0.001))
        else
            exit(0);
    end;


    procedure CalcPreviousRevision(pOrderNo: Code[20]; pJobNo: Code[20])
    var
        lCompl: Record Free8003986;
        lDocType: Integer;
    begin
        //MAJ des révisions précédentes
        lCompl.SetRange("Order No.", pOrderNo);
        lCompl.SetRange("Job No.", pJobNo);
        lCompl.SetRange(Estimation, true);
        lCompl.SetFilter("Document No.", '<>''''');
        if lCompl.Find('-') then
            repeat
                if lCompl."Document Type" = lCompl."document type"::"Posted Sales Invoice" then
                    lDocType := 7;
                if lCompl."Document Type" = lCompl."document type"::"Posted Sales Cr. Memo" then
                    lDocType := 9;
                lCompl.CalculateRevision(pOrderNo, lDocType, lCompl."Document No.");
                lCompl.Validate("Revision Coeficient");
                lCompl.Modify;
            until lCompl.Next = 0;
    end;

    local procedure GetSalesHeader(pDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; pDocNo: Code[20])
    begin
        if (pDocNo <> SalesHeader."No.") or (pDocType <> SalesHeader."Document Type") then begin
            SalesHeader.Get(pDocType, pDocNo);
            if SalesHeader."Currency Code" = '' then
                Currency.InitRoundingPrecision
            else begin
                SalesHeader.TestField("Currency Factor");
                Currency.Get(SalesHeader."Currency Code");
                Currency.TestField("Amount Rounding Precision");
            end;
        end;
    end;
}

