Codeunit 8004164 "Job Transfer Line2"
{
    // //+ONE+JOB_GL CW 14/09/07
    // //PROJET_CESSION GESWAY 26/06/02 Suppression de '@@' mis dans JobJnlLine.Area
    // //INTERIM GESWAY 20/08/02 Renseignement du N° projet contrepartie, du N° mission
    // //RESSOURCE GESWAY 18/07/03 Alimentation de JobLedgEntry."Resource Type"


    trigger OnRun()
    begin
    end;

    var
        Text000: label '%1 %2 = %3 in %4 %5 = %6';
        CurrencyExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        LCYCurrency: Record Currency;
        CurrencyRoundingRead: Boolean;


    procedure FromJnlLineToLedgEntry(JobJnlLine2: Record "Job Journal Line"; var JobLedgEntry: Record "Job Ledger Entry")
    var
        Resource: Record Resource;
    begin
        JobLedgEntry."Job No." := JobJnlLine2."Job No.";
        JobLedgEntry."Job Task No." := JobJnlLine2."Job Task No.";
        JobLedgEntry."Job Posting Group" := JobJnlLine2."Posting Group";
        JobLedgEntry."Posting Date" := JobJnlLine2."Posting Date";
        JobLedgEntry."Document Date" := JobJnlLine2."Document Date";
        JobLedgEntry."Document No." := JobJnlLine2."Document No.";
        JobLedgEntry."External Document No." := JobJnlLine2."External Document No.";
        JobLedgEntry.Type := JobJnlLine2.Type;
        JobLedgEntry."No." := JobJnlLine2."No.";
        JobLedgEntry.Description := JobJnlLine2.Description;
        JobLedgEntry."Resource Group No." := JobJnlLine2."Resource Group No.";
        JobLedgEntry."Unit of Measure Code" := JobJnlLine2."Unit of Measure Code";
        JobLedgEntry."Location Code" := JobJnlLine2."Location Code";
        JobLedgEntry."Global Dimension 1 Code" := JobJnlLine2."Shortcut Dimension 1 Code";
        JobLedgEntry."Global Dimension 2 Code" := JobJnlLine2."Shortcut Dimension 2 Code";
        JobLedgEntry."Work Type Code" := JobJnlLine2."Work Type Code";
        JobLedgEntry."Source Code" := JobJnlLine2."Source Code";
        //+ONE+JOB
        JobLedgEntry."Job Task No." := JobJnlLine2."Job Task No.";
        //+ONE+JOB//
        JobLedgEntry."Entry Type" := JobJnlLine2."Entry Type";
        JobLedgEntry."Gen. Bus. Posting Group" := JobJnlLine2."Gen. Bus. Posting Group";
        JobLedgEntry."Gen. Prod. Posting Group" := JobJnlLine2."Gen. Prod. Posting Group";
        JobLedgEntry."Journal Batch Name" := JobJnlLine2."Journal Batch Name";
        JobLedgEntry."Reason Code" := JobJnlLine2."Reason Code";
        JobLedgEntry."Variant Code" := JobJnlLine2."Variant Code";
        JobLedgEntry."Bin Code" := JobJnlLine2."Bin Code";
        JobLedgEntry."Line Type" := JobJnlLine2."Line Type";
        JobLedgEntry."Currency Code" := JobJnlLine2."Currency Code";
        JobLedgEntry."Description 2" := JobJnlLine2."Description 2";
        if JobJnlLine2."Currency Code" = '' then
            JobLedgEntry."Currency Factor" := 1
        else
            JobLedgEntry."Currency Factor" := JobJnlLine2."Currency Factor";
        JobLedgEntry."User ID" := UserId;
        JobLedgEntry."Customer Price Group" := JobJnlLine2."Customer Price Group";

        JobLedgEntry."Transport Method" := JobJnlLine2."Transport Method";
        JobLedgEntry."Transaction Type" := JobJnlLine2."Transaction Type";
        JobLedgEntry."Transaction Specification" := JobJnlLine2."Transaction Specification";
        JobLedgEntry."Entry/Exit Point" := JobJnlLine2."Entry/Exit Point";
        JobLedgEntry.Area := JobJnlLine2.Area;
        JobLedgEntry."Country/Region Code" := JobJnlLine2."Country/Region Code";

        JobLedgEntry."Unit Price (LCY)" := JobJnlLine2."Unit Price (LCY)";
        JobLedgEntry."Additional-Currency Total Cost" :=
          -JobJnlLine2."Source Currency Total Cost";
        JobLedgEntry."Add.-Currency Total Price" :=
          -JobJnlLine2."Source Currency Total Price";
        JobLedgEntry."Add.-Currency Line Amount" :=
          -JobJnlLine2."Source Currency Line Amount";

        JobLedgEntry."Service Order No." := JobJnlLine2."Service Order No.";
        JobLedgEntry."Posted Service Shipment No." := JobJnlLine2."Posted Service Shipment No.";
        //INTERIM
        JobLedgEntry."Bal. Job No." := JobJnlLine2."Bal. Job No.";
        JobLedgEntry."Mission No." := JobJnlLine2."Mission No.";
        //INTERIM//
        //RESSOURCE
        if JobLedgEntry.Type = JobLedgEntry.Type::Resource then
            if Resource.Get(JobLedgEntry."No.") then
                JobLedgEntry."Resource Type" := Resource.Type;
        //RESSOURCE//
        //PROJET_CESSION
        JobLedgEntry."Bal. Created Entry" := JobJnlLine2."Bal. Created Entry";
        JobLedgEntry.Quantity := JobJnlLine2.Quantity;
        JobLedgEntry."Quantity (Base)" := JobJnlLine2."Quantity (Base)";
        JobLedgEntry."Total Cost (LCY)" := JobJnlLine2."Total Cost (LCY)";
        //PROJET_CESSION//

        // Amounts
        JobLedgEntry."Qty. per Unit of Measure" := JobJnlLine2."Qty. per Unit of Measure";

        JobLedgEntry."Direct Unit Cost (LCY)" := JobJnlLine2."Direct Unit Cost (LCY)";
        JobLedgEntry."Unit Cost (LCY)" := JobJnlLine2."Unit Cost (LCY)";
        JobLedgEntry."Unit Cost" := JobJnlLine2."Unit Cost";
        JobLedgEntry."Unit Price" := JobJnlLine2."Unit Price";

        JobLedgEntry."Line Discount %" := JobJnlLine2."Line Discount %";
    end;


    procedure FromJnlToPlanningLine(JobJnlLine: Record "Job Journal Line"; var JobPlanningLine: Record "Job Planning Line")
    begin
        JobPlanningLine."Job No." := JobJnlLine."Job No.";
        JobPlanningLine."Job Task No." := JobJnlLine."Job Task No.";
        JobPlanningLine."Planning Date" := JobJnlLine."Posting Date";
        JobPlanningLine."Currency Date" := JobJnlLine."Posting Date";
        JobPlanningLine.Type := JobJnlLine.Type;
        JobPlanningLine."No." := JobJnlLine."No.";
        JobPlanningLine."Document No." := JobJnlLine."Document No.";
        JobPlanningLine.Description := JobJnlLine.Description;
        JobPlanningLine."Description 2" := JobJnlLine."Description 2";
        JobPlanningLine."Unit of Measure Code" := JobJnlLine."Unit of Measure Code";
        JobPlanningLine.Validate("Line Type", JobJnlLine."Line Type" - 1);
        JobPlanningLine."Currency Code" := JobJnlLine."Currency Code";
        JobPlanningLine."Currency Factor" := JobJnlLine."Currency Factor";
        JobPlanningLine."Resource Group No." := JobJnlLine."Resource Group No.";
        JobPlanningLine."Location Code" := JobJnlLine."Location Code";
        JobPlanningLine."Work Type Code" := JobJnlLine."Work Type Code";
        JobPlanningLine."Customer Price Group" := JobJnlLine."Customer Price Group";
        JobPlanningLine."Country/Region Code" := JobJnlLine."Country/Region Code";
        JobPlanningLine."Gen. Bus. Posting Group" := JobJnlLine."Gen. Bus. Posting Group";
        JobPlanningLine."Gen. Prod. Posting Group" := JobJnlLine."Gen. Prod. Posting Group";
        JobPlanningLine."Document Date" := JobJnlLine."Document Date";
        JobPlanningLine."Variant Code" := JobJnlLine."Variant Code";
        JobPlanningLine."Bin Code" := JobJnlLine."Bin Code";
        JobPlanningLine."Serial No." := JobJnlLine."Serial No.";
        JobPlanningLine."Lot No." := JobJnlLine."Lot No.";
        JobPlanningLine."Service Order No." := JobJnlLine."Service Order No.";
        JobPlanningLine."Ledger Entry Type" := JobJnlLine."Ledger Entry Type";
        JobPlanningLine."Ledger Entry No." := JobJnlLine."Ledger Entry No.";
        JobPlanningLine."System-Created Entry" := true;

        // Amounts
        JobPlanningLine.Quantity := JobJnlLine.Quantity;
        JobPlanningLine."Quantity (Base)" := JobJnlLine."Quantity (Base)";
        JobPlanningLine."Qty. per Unit of Measure" := JobJnlLine."Qty. per Unit of Measure";

        JobPlanningLine."Direct Unit Cost (LCY)" := JobJnlLine."Direct Unit Cost (LCY)";
        JobPlanningLine."Unit Cost (LCY)" := JobJnlLine."Unit Cost (LCY)";
        JobPlanningLine."Unit Cost" := JobJnlLine."Unit Cost";

        JobPlanningLine."Total Cost (LCY)" := JobJnlLine."Total Cost (LCY)";
        JobPlanningLine."Total Cost" := JobJnlLine."Total Cost";

        JobPlanningLine."Unit Price (LCY)" := JobJnlLine."Unit Price (LCY)";
        JobPlanningLine."Unit Price" := JobJnlLine."Unit Price";

        JobPlanningLine."Total Price (LCY)" := JobJnlLine."Total Price (LCY)";
        JobPlanningLine."Total Price" := JobJnlLine."Total Price";

        JobPlanningLine."Line Amount (LCY)" := JobJnlLine."Line Amount (LCY)";
        JobPlanningLine."Line Amount" := JobJnlLine."Line Amount";

        JobPlanningLine."Line Discount %" := JobJnlLine."Line Discount %";

        JobPlanningLine."Line Discount Amount (LCY)" := JobJnlLine."Line Discount Amount (LCY)";
        JobPlanningLine."Line Discount Amount" := JobJnlLine."Line Discount Amount";
    end;


    procedure FromPlanningSalesLinetoJnlLine(JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var JobJnlLine: Record "Job Journal Line")
    var
        SourceCodeSetup: Record "Source Code Setup";
        JobTask: Record "Job Task";
    begin
        JobJnlLine."Job No." := JobPlanningLine."Job No.";
        JobJnlLine."Job Task No." := JobPlanningLine."Job Task No.";
        JobJnlLine.Type := JobPlanningLine.Type;
        IF JobTask.Get(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.") THEN;
        JobJnlLine."Posting Group" := JobTask."Job Posting Group";
        //GL2024    JobJnlLine."Posting Date" := JobPlanningLine."Invoiced Date";
        //GL2024   JobJnlLine."Document Date" := JobPlanningLine."Invoiced Date";
        JobJnlLine."Document No." := SalesLine."Document No.";
        JobJnlLine."Entry Type" := JobJnlLine."entry type"::Sale;
        JobJnlLine."Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
        JobJnlLine."Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
        JobJnlLine."Serial No." := JobPlanningLine."Serial No.";
        JobJnlLine."Lot No." := JobPlanningLine."Lot No.";
        JobJnlLine."No." := JobPlanningLine."No.";
        JobJnlLine.Description := SalesLine.Description;
        JobJnlLine."Description 2" := SalesLine."Description 2";
        JobJnlLine."Unit of Measure Code" := JobPlanningLine."Unit of Measure Code";
        JobJnlLine."Line Type" := JobPlanningLine."Line Type";
        JobJnlLine."Currency Code" := JobPlanningLine."Currency Code";
        JobJnlLine."Currency Factor" := JobPlanningLine."Currency Factor";
        JobJnlLine."Resource Group No." := JobPlanningLine."Resource Group No.";
        JobJnlLine."Location Code" := JobPlanningLine."Location Code";
        JobJnlLine."Work Type Code" := JobPlanningLine."Work Type Code";
        JobJnlLine."Customer Price Group" := JobPlanningLine."Customer Price Group";
        JobJnlLine."Variant Code" := JobPlanningLine."Variant Code";
        JobJnlLine."Bin Code" := JobPlanningLine."Bin Code";
        JobJnlLine."Service Order No." := JobPlanningLine."Service Order No.";
        SourceCodeSetup.Get;
        JobJnlLine."Source Code" := SourceCodeSetup.Sales;
        JobJnlLine."Reason Code" := SalesHeader."Reason Code";
        JobJnlLine."External Document No." := SalesHeader."External Document No.";

        JobJnlLine."Transport Method" := SalesLine."Transport Method";
        JobJnlLine."Transaction Type" := SalesLine."Transaction Type";
        JobJnlLine."Transaction Specification" := SalesLine."Transaction Specification";
        JobJnlLine."Entry/Exit Point" := SalesLine."Exit Point";
        JobJnlLine.Area := SalesLine.Area;
        JobJnlLine."Country/Region Code" := JobPlanningLine."Country/Region Code";

        JobJnlLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        JobJnlLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";

        // Amounts
        JobJnlLine.Quantity := JobPlanningLine.Quantity;
        JobJnlLine."Quantity (Base)" := JobPlanningLine."Quantity (Base)";
        JobJnlLine."Qty. per Unit of Measure" := JobPlanningLine."Qty. per Unit of Measure";

        JobJnlLine."Direct Unit Cost (LCY)" := JobPlanningLine."Direct Unit Cost (LCY)";
        JobJnlLine."Unit Cost (LCY)" := JobPlanningLine."Unit Cost (LCY)";
        JobJnlLine."Unit Cost" := JobPlanningLine."Unit Cost";

        JobJnlLine."Total Cost (LCY)" := JobPlanningLine."Total Cost (LCY)";
        JobJnlLine."Total Cost" := JobPlanningLine."Total Cost";

        JobJnlLine."Unit Price (LCY)" := JobPlanningLine."Unit Price (LCY)";
        JobJnlLine."Unit Price" := JobPlanningLine."Unit Price";

        JobJnlLine."Total Price (LCY)" := JobPlanningLine."Total Price (LCY)";
        JobJnlLine."Total Price" := JobPlanningLine."Total Price";

        JobJnlLine."Line Amount (LCY)" := JobPlanningLine."Line Amount (LCY)";
        JobJnlLine."Line Amount" := JobPlanningLine."Line Amount";

        JobJnlLine."Line Discount %" := JobPlanningLine."Line Discount %";

        JobJnlLine."Line Discount Amount (LCY)" := JobPlanningLine."Line Discount Amount (LCY)";
        JobJnlLine."Line Discount Amount" := JobPlanningLine."Line Discount Amount";
    end;


    procedure FromGenJnlLineToJnlLine(GenJnlLine: Record "Gen. Journal Line"; var JobJnlLine: Record "Job Journal Line")
    var
        Job: Record Job;
        JobTask: Record "Job Task";
        lGenJnlTemplate: Record "Gen. Journal Template";
        lSign: Integer;
    begin
        JobJnlLine."Job No." := GenJnlLine."Job No.";
        JobJnlLine."Job Task No." := GenJnlLine."Job Task No.";
        if JobTask.Get(GenJnlLine."Job No.", GenJnlLine."Job Task No.") then;

        if GenJnlLine."Account Type" = GenJnlLine."account type"::"G/L Account" then
            JobJnlLine."Posting Group" := GenJnlLine."Account No.";

        JobJnlLine."Posting Date" := GenJnlLine."Posting Date";
        JobJnlLine."Document Date" := GenJnlLine."Document Date";
        JobJnlLine."Document No." := GenJnlLine."Document No.";

        JobJnlLine."Currency Code" := GenJnlLine."Job Currency Code";
        JobJnlLine."Currency Factor" := GenJnlLine."Job Currency Factor";
        JobJnlLine."Entry Type" := JobJnlLine."entry type"::Usage;
        JobJnlLine."Line Type" := GenJnlLine."Job Line Type";
        JobJnlLine.Type := JobJnlLine.Type::"G/L Account";
        JobJnlLine."No." := GenJnlLine."Account No.";
        JobJnlLine.Description := GenJnlLine.Description;
        JobJnlLine."Unit of Measure Code" := GenJnlLine."Job Unit Of Measure Code";
        JobJnlLine."Gen. Bus. Posting Group" := GenJnlLine."Gen. Bus. Posting Group";
        JobJnlLine."Gen. Prod. Posting Group" := GenJnlLine."Gen. Prod. Posting Group";
        JobJnlLine."Source Code" := GenJnlLine."Source Code";
        JobJnlLine."Reason Code" := GenJnlLine."Reason Code";
        //#7390
        JobJnlLine."Shortcut Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        JobJnlLine."Shortcut Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";
        //#7390//
        Job.Get(JobJnlLine."Job No.");
        JobJnlLine."Customer Price Group" := Job."Customer Price Group";
        JobJnlLine."External Document No." := GenJnlLine."External Document No.";
        JobJnlLine."Journal Batch Name" := GenJnlLine."Journal Batch Name";
        JobJnlLine."Shortcut Dimension 1 Code" := GenJnlLine."Shortcut Dimension 1 Code";
        JobJnlLine."Shortcut Dimension 2 Code" := GenJnlLine."Shortcut Dimension 2 Code";

        // Amounts
        //#7771 Retour au standard
        /*
        //#7201
        fSetAmntGenJnlLineToJnlLine(GenJnlLine, JobJnlLine);
        //
        */
        //#7771

        //#7869
        lSign := 1;
        if GenJnlLine."Job Total Cost (LCY)" < 0 then
            lSign := -1;
        JobJnlLine.Quantity := lSign * Abs(GenJnlLine."Job Quantity");
        JobJnlLine."Unit Cost (LCY)" := Abs(GenJnlLine."Job Unit Cost (LCY)");
        JobJnlLine."Unit Cost" := Abs(GenJnlLine."Job Unit Cost");
        JobJnlLine."Direct Unit Cost (LCY)" := Abs(GenJnlLine."Job Unit Cost (LCY)");
        //#7869//

        //#7869 JobJnlLine.Quantity := GenJnlLine."Job Quantity";
        JobJnlLine."Quantity (Base)" := JobJnlLine.Quantity;

        JobJnlLine."Qty. per Unit of Measure" := 1; // MP ??


        //#7869 JobJnlLine."Direct Unit Cost (LCY)" := GenJnlLine."Job Unit Cost (LCY)";
        //#7869 JobJnlLine."Unit Cost (LCY)" := GenJnlLine."Job Unit Cost (LCY)";
        //#7869 JobJnlLine."Unit Cost" := GenJnlLine."Job Unit Cost";


        JobJnlLine."Total Cost (LCY)" := GenJnlLine."Job Total Cost (LCY)";
        JobJnlLine."Total Cost" := GenJnlLine."Job Total Cost";

        JobJnlLine."Unit Price (LCY)" := GenJnlLine."Job Unit Price (LCY)";
        JobJnlLine."Unit Price" := GenJnlLine."Job Unit Price";

        JobJnlLine."Total Price (LCY)" := GenJnlLine."Job Total Price (LCY)";
        JobJnlLine."Total Price" := GenJnlLine."Job Total Price";

        JobJnlLine."Line Amount (LCY)" := GenJnlLine."Job Line Amount (LCY)";
        JobJnlLine."Line Amount" := GenJnlLine."Job Line Amount";

        JobJnlLine."Line Discount Amount (LCY)" := GenJnlLine."Job Line Disc. Amount (LCY)";
        JobJnlLine."Line Discount Amount" := GenJnlLine."Job Line Discount Amount";

        JobJnlLine."Line Discount %" := GenJnlLine."Job Line Discount %";
        //#7771 Retour au standard
        //#7201//
        //#7771//
        //+ONE+JOB_GL
        //#7771
        /*
        IF GenJnlLine."Journal Template Name" <> '' THEN
          lGenJnlTemplate.GET(GenJnlLine."Journal Template Name");
        IF (GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::Sale) OR
           (lGenJnlTemplate.Type = lGenJnlTemplate.Type::Sales) THEN BEGIN
          JobJnlLine."Qty. per Unit of Measure" := 0;
          JobJnlLine."Entry Type" := JobJnlLine."Entry Type"::Sale;
        END;
        */
        if GenJnlLine."Journal Template Name" <> '' then
            lGenJnlTemplate.Get(GenJnlLine."Journal Template Name");
        //#7921
        if (GenJnlLine."Gen. Posting Type" = GenJnlLine."gen. posting type"::Sale) or
           ((GenJnlLine."Gen. Posting Type" = GenJnlLine."gen. posting type"::" ") and
        //#7921//
           (GenJnlLine."Journal Template Name" <> '') and (lGenJnlTemplate.Type = lGenJnlTemplate.Type::Sales)) then
            fSaleType(JobJnlLine);
        //#7921
        if (GenJnlLine."Gen. Posting Type" = GenJnlLine."gen. posting type"::Sale) then
            JobJnlLine."Entry Type" := JobJnlLine."entry type"::Sale;
        //#7921
        //#7771//
        //+ONE+JOB_GL//
        //PROJET_IMMO (#5444)
        JobJnlLine."Journal Template Name" := GenJnlLine."Journal Template Name";
        //PROJET_IMMO//

    end;


    procedure FromJobLedgEntryToPlanningLine(JobLedgEntry: Record "Job Ledger Entry"; var JobPlanningLine: Record "Job Planning Line")
    begin
        JobPlanningLine."Job No." := JobLedgEntry."Job No.";
        JobPlanningLine."Job Task No." := JobLedgEntry."Job Task No.";
        JobPlanningLine."Planning Date" := JobLedgEntry."Posting Date";
        JobPlanningLine."Currency Date" := JobLedgEntry."Posting Date";
        JobPlanningLine."Document Date" := JobLedgEntry."Document Date";
        JobPlanningLine."Document No." := JobLedgEntry."Document No.";
        JobPlanningLine.Description := JobLedgEntry.Description;
        JobPlanningLine.Type := JobLedgEntry.Type;
        JobPlanningLine."No." := JobLedgEntry."No.";
        JobPlanningLine."Unit of Measure Code" := JobLedgEntry."Unit of Measure Code";
        JobPlanningLine.Validate("Line Type", JobLedgEntry."Line Type" - 1);
        JobPlanningLine."Currency Code" := JobLedgEntry."Currency Code";
        if JobLedgEntry."Currency Code" = '' then
            JobPlanningLine."Currency Factor" := 0
        else
            JobPlanningLine."Currency Factor" := JobLedgEntry."Currency Factor";
        JobPlanningLine."Resource Group No." := JobLedgEntry."Resource Group No.";
        JobPlanningLine."Location Code" := JobLedgEntry."Location Code";
        JobPlanningLine."Work Type Code" := JobLedgEntry."Work Type Code";
        JobPlanningLine."Gen. Bus. Posting Group" := JobLedgEntry."Gen. Bus. Posting Group";
        JobPlanningLine."Gen. Prod. Posting Group" := JobLedgEntry."Gen. Prod. Posting Group";
        JobPlanningLine."Variant Code" := JobLedgEntry."Variant Code";
        JobPlanningLine."Bin Code" := JobLedgEntry."Bin Code";
        JobPlanningLine."Customer Price Group" := JobLedgEntry."Customer Price Group";
        JobPlanningLine."Country/Region Code" := JobLedgEntry."Country/Region Code";
        JobPlanningLine."Description 2" := JobLedgEntry."Description 2";
        JobPlanningLine."Serial No." := JobLedgEntry."Serial No.";
        JobPlanningLine."Lot No." := JobLedgEntry."Lot No.";
        JobPlanningLine."Service Order No." := JobLedgEntry."Service Order No.";
        JobPlanningLine."Job Ledger Entry No." := JobLedgEntry."Entry No.";
        JobPlanningLine."Ledger Entry Type" := JobLedgEntry."Ledger Entry Type";
        JobPlanningLine."Ledger Entry No." := JobLedgEntry."Ledger Entry No.";
        JobPlanningLine."System-Created Entry" := true;

        // Amounts
        JobPlanningLine.Quantity := JobLedgEntry.Quantity;
        JobPlanningLine."Quantity (Base)" := JobLedgEntry."Quantity (Base)";
        JobPlanningLine."Qty. per Unit of Measure" := JobLedgEntry."Qty. per Unit of Measure";

        JobPlanningLine."Direct Unit Cost (LCY)" := JobLedgEntry."Direct Unit Cost (LCY)";
        JobPlanningLine."Unit Cost (LCY)" := JobLedgEntry."Unit Cost (LCY)";
        JobPlanningLine."Unit Cost" := JobLedgEntry."Unit Cost";

        JobPlanningLine."Total Cost (LCY)" := JobLedgEntry."Total Cost (LCY)";
        JobPlanningLine."Total Cost" := JobLedgEntry."Total Cost";

        JobPlanningLine."Unit Price (LCY)" := JobLedgEntry."Unit Price (LCY)";
        JobPlanningLine."Unit Price" := JobLedgEntry."Unit Price";

        JobPlanningLine."Total Price (LCY)" := JobLedgEntry."Total Price (LCY)";
        JobPlanningLine."Total Price" := JobLedgEntry."Total Price";

        JobPlanningLine."Line Amount (LCY)" := JobLedgEntry."Line Amount (LCY)";
        JobPlanningLine."Line Amount" := JobLedgEntry."Line Amount";

        JobPlanningLine."Line Discount %" := JobLedgEntry."Line Discount %";

        JobPlanningLine."Line Discount Amount (LCY)" := JobLedgEntry."Line Discount Amount (LCY)";
        JobPlanningLine."Line Discount Amount" := JobLedgEntry."Line Discount Amount";
    end;


    procedure FromPurchaseLineToJnlLine(PurchHeader: Record "Purchase Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; PurchLine: Record "Purchase Line"; Sourcecode: Code[10]; var JobJnlLine: Record "Job Journal Line")
    var
        Item: Record Item;
        Job: Record Job;
        JobTask: Record "Job Task";
        Factor: Decimal;
        lVendor: Record Vendor;
    begin
        with PurchLine do begin
            JobJnlLine.DontCheckStdCost;
            JobJnlLine.Validate("Job No.", "Job No.");
            JobJnlLine.Validate("Job Task No.", "Job Task No.");
            IF JobTask.Get("Job No.", "Job Task No.") THEN;
            JobJnlLine."Posting Group" := JobTask."Job Posting Group";
            JobJnlLine.Validate("Posting Date", PurchHeader."Posting Date");
            //#9005
            case (Type) of
                Type::"G/L Account":
                    begin
                        JobJnlLine.Validate(Type, JobJnlLine.Type::"G/L Account");
                    end;
                Type::Item:
                    begin
                        JobJnlLine.Validate(Type, JobJnlLine.Type::Item);
                    end;
                Type::Resource:
                    begin
                        JobJnlLine.Validate(Type, JobJnlLine.Type::Resource);
                    end;
                //#5414
                Type::"Note of Expenses":
                    begin
                        JobJnlLine.Validate(Type, JobJnlLine.Type::Resource);
                        JobJnlLine."Document Date" := "Expected Receipt Date";
                        JobJnlLine."Vendor No." := "Buy-from Vendor No.";
                        if not lVendor.Get("Buy-from Vendor No.") then
                            lVendor.Init;
                        Description := CopyStr(Description + ' ' + lVendor.Name, 1, MaxStrLen(Description));
                    end;
                //#5414//
                else
                    JobJnlLine.Validate(Type, JobJnlLine.Type::Item);
            end;
            //IF Type = Type::"G/L Account" THEN
            //  JobJnlLine.VALIDATE(Type,JobJnlLine.Type::"G/L Account")
            //ELSE
            //#5414
            //IF Type = Type::"Note of Expenses" THEN BEGIN
            //  JobJnlLine.VALIDATE(Type,JobJnlLine.Type::Resource);
            //  JobJnlLine."Document Date" := "Expected Receipt Date";
            //  JobJnlLine."Vendor No." := "Buy-from Vendor No.";
            //  IF NOT lVendor.GET("Buy-from Vendor No.") THEN
            //    lVendor.INIT;
            //  Description := COPYSTR(Description + ' ' + lVendor.Name,1,MAXSTRLEN(Description));
            //END
            //ELSE
            //#5414//
            //JobJnlLine.VALIDATE(Type,JobJnlLine.Type::Item);
            //#9005//
            JobJnlLine.Validate("No.", "No.");
            JobJnlLine.Validate("Variant Code", "Variant Code");
            JobJnlLine.Validate("Unit of Measure Code", "Unit of Measure Code");
            //#5020JobJnlLine.VALIDATE(Quantity,Quantity);
            //601 JobJnlLine.VALIDATE(Quantity,"Qty. to Invoice");
            //#5020//
            if PurchHeader."Document Type" = PurchHeader."document type"::Order then
                JobJnlLine.Validate(Quantity, "Qty. to Invoice")
            else
                JobJnlLine.Validate(Quantity, Quantity);

            //#8877
            //  IF PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo" THEN BEGIN
            if (PurchHeader."Document Type" in [PurchHeader."document type"::"Credit Memo",
                                               PurchHeader."document type"::"Return Order"]) then begin
                //#8877
                JobJnlLine."Document No." := PurchCrMemoHeader."No.";
                JobJnlLine."External Document No." := PurchCrMemoHeader."Vendor Cr. Memo No.";
            end else begin
                JobJnlLine."Document No." := PurchInvHeader."No.";
                JobJnlLine."External Document No." := PurchHeader."Vendor Invoice No.";
            end;
            Job.Get(JobJnlLine."Job No.");

            if Type = Type::Item then begin
                Item.Get("No.");
                if Item."Costing Method" = Item."costing method"::Standard then
                    JobJnlLine.Validate("Unit Cost (LCY)", Item."Standard Cost")
                else
                    JobJnlLine.Validate("Unit Cost (LCY)", "Unit Cost (LCY)")
            end else begin
                JobJnlLine.Validate("Unit Cost (LCY)", "Unit Cost (LCY)");
            end;

            if "Currency Code" = '' then
                JobJnlLine."Direct Unit Cost (LCY)" := "Direct Unit Cost"
            else
                JobJnlLine."Direct Unit Cost (LCY)" :=
                  CurrencyExchRate.ExchangeAmtFCYToLCY(
                    PurchHeader."Posting Date",
                    "Currency Code",
                    "Direct Unit Cost",
                    PurchHeader."Currency Factor");

            JobJnlLine."Unit Price (LCY)" := "Job Unit Price (LCY)";
            JobJnlLine."Unit Price" := "Job Unit Price";

            JobJnlLine."Line Discount %" := "Job Line Discount %";

            if PurchHeader."Document Type" in [PurchHeader."document type"::"Credit Memo", PurchHeader."document type"::"Return Order"] then
                JobJnlLine.Validate(Quantity, -Quantity)
            else begin
                JobJnlLine."Total Price (LCY)" := "Job Total Price (LCY)";
                JobJnlLine."Total Price" := "Job Total Price";
                JobJnlLine."Line Amount (LCY)" := "Job Line Amount (LCY)";
                JobJnlLine."Line Amount" := "Job Line Amount";
                JobJnlLine."Line Discount Amount (LCY)" := "Job Line Disc. Amount (LCY)";
                JobJnlLine."Line Discount Amount" := "Job Line Discount Amount";
            end;
            if (PurchHeader."Document Type" = PurchHeader."document type"::Order) and
               (Quantity <> 0)
            then begin
                GetCurrencyRounding(PurchHeader."Currency Code");
                Factor := "Qty. to Invoice" / Quantity;
                JobJnlLine."Total Price (LCY)" :=
                  ROUND("Job Total Price (LCY)" * Factor, LCYCurrency."Amount Rounding Precision");
                JobJnlLine."Total Price" :=
                  ROUND("Job Total Price" * Factor, Currency."Amount Rounding Precision");
                JobJnlLine."Line Amount (LCY)" :=
                  ROUND("Job Line Amount (LCY)" * Factor, LCYCurrency."Amount Rounding Precision");
                JobJnlLine."Line Amount" :=
                  ROUND("Job Line Amount" * Factor, Currency."Amount Rounding Precision");
                JobJnlLine."Line Discount Amount (LCY)" :=
                  ROUND("Job Line Disc. Amount (LCY)" * Factor, LCYCurrency."Amount Rounding Precision");
                JobJnlLine."Line Discount Amount" :=
                  ROUND("Job Line Discount Amount" * Factor, Currency."Amount Rounding Precision");
            end;
            JobJnlLine."Location Code" := "Location Code";
            JobJnlLine."Line Type" := "Job Line Type";
            JobJnlLine."Entry Type" := JobJnlLine."entry type"::Usage;
            JobJnlLine.Description := Description;
            JobJnlLine."Description 2" := "Description 2";
            JobJnlLine."Gen. Bus. Posting Group" := "Gen. Bus. Posting Group";
            JobJnlLine."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
            //#6824
            JobJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            JobJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            //#6824//
            JobJnlLine."Source Code" := Sourcecode;
            JobJnlLine."Reason Code" := PurchHeader."Reason Code";
            JobJnlLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
            JobJnlLine."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
            //#8995
            if (Type <> Type::"Note of Expenses") then
                JobJnlLine."Vendor No." := PurchLine."Pay-to Vendor No.";
            //#8995//
        end;
    end;


    procedure JTName(JobNo: Code[20]; JTNo: Code[20]): Text[200]
    var
        Job: Record Job;
        JT: Record "Job Task";
    begin
        exit(
          StrSubstNo(
            Text000,
            Job.TableCaption, Job.FieldCaption("No."), JobNo,
            JT.TableCaption, JT.FieldCaption("Job Task No."), JTNo));
    end;


    procedure FromSalesHeaderToPlanningLine(SalesLine: Record "Sales Line"; CurrencyCode: Code[10]; CurrencyFactor: Decimal)
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        JobPlanningLine.SetCurrentkey("Job Contract Entry No.");
        JobPlanningLine.SetRange("Job Contract Entry No.", SalesLine."Job Contract Entry No.");
        if JobPlanningLine.FindFirst then begin
            //Update Invoice Currency
            //GL2024   JobPlanningLine."Invoice Currency Factor" := CurrencyFactor;
            //GL2024    JobPlanningLine."Invoice Currency Code" := CurrencyCode;
            //Update Prices
            if JobPlanningLine."Currency Code" <> '' then begin
                JobPlanningLine."Unit Price (LCY)" := SalesLine."Unit Price" / CurrencyFactor;
                JobPlanningLine."Total Price (LCY)" := SalesLine.Amount / CurrencyFactor;
                JobPlanningLine."Line Amount (LCY)" := JobPlanningLine."Total Price (LCY)";
                JobPlanningLine."Unit Price" := JobPlanningLine."Unit Price (LCY)";
                JobPlanningLine."Total Price" := JobPlanningLine."Total Price (LCY)";
                JobPlanningLine."Line Amount" := JobPlanningLine."Total Price (LCY)";
            end else begin
                JobPlanningLine."Unit Price (LCY)" := SalesLine."Unit Price" / CurrencyFactor;
                JobPlanningLine."Total Price (LCY)" := SalesLine.Amount / CurrencyFactor;
                JobPlanningLine."Line Amount (LCY)" := JobPlanningLine."Total Price (LCY)";
            end;
            JobPlanningLine.Modify;
        end;
    end;

    local procedure GetCurrencyRounding(CurrencyCode: Code[10])
    begin
        if CurrencyRoundingRead then
            exit;
        CurrencyRoundingRead := true;
        if CurrencyCode = '' then
            Currency.InitRoundingPrecision
        else begin
            Currency.Get(CurrencyCode);
            Currency.TestField("Amount Rounding Precision");
        end;
        LCYCurrency.InitRoundingPrecision;
    end;


    procedure fFromSalesLineToJnlLine(pSalesHeader: Record "Sales Header"; pSalesInvHeader: Record "Sales Invoice Header"; pSalesCrMemoHeader: Record "Sales Cr.Memo Header"; pSalesLine: Record "Sales Line"; pSalesLineACY: Record "Sales Line"; pCurrency: Record Currency; pSourcecode: Code[10]; var pJobJnlLine: Record "Job Journal Line")
    var
        lJob: Record Job;
        lGLAcc: Record "G/L Account";
        lCurrExchRate: Record "Currency Exchange Rate";
    begin
        lJob.Get(pSalesLine."Job No.");
        with pSalesHeader do begin
            pJobJnlLine.Init;
            pJobJnlLine.DontCheckStdCost;
            pJobJnlLine.Validate("Job No.", pSalesLine."Job No.");
            pJobJnlLine.Validate("Job Task No.", pSalesLine."Job Task No.");
            pJobJnlLine.Validate("Posting Date", "Posting Date");
            pJobJnlLine."Document Date" := "Document Date";
            pJobJnlLine."Country/Region Code" := "VAT Country/Region Code";
            pJobJnlLine."Reason Code" := "Reason Code";
            pJobJnlLine.Type := 3 - pSalesLine.Type;
            pJobJnlLine."No." := pSalesLine."No.";
            pJobJnlLine."Variant Code" := pSalesLine."Variant Code";
            pJobJnlLine.Description := pSalesLine.Description;
            pJobJnlLine."Unit of Measure Code" := pSalesLine."Unit of Measure Code";
            pJobJnlLine."Location Code" := pSalesLine."Location Code";
            pJobJnlLine."Posting Group" := pSalesLine."Posting Group";
            pJobJnlLine."Shortcut Dimension 1 Code" := pSalesLine."Shortcut Dimension 1 Code";
            pJobJnlLine."Shortcut Dimension 2 Code" := pSalesLine."Shortcut Dimension 2 Code";
            pJobJnlLine."Work Type Code" := pSalesLine."Work Type Code";
            pJobJnlLine."Gen. Bus. Posting Group" := pSalesLine."Gen. Bus. Posting Group";
            pJobJnlLine."Gen. Prod. Posting Group" := pSalesLine."Gen. Prod. Posting Group";
            pJobJnlLine."Transaction Type" := pSalesLine."Transaction Type";
            pJobJnlLine."Transport Method" := pSalesLine."Transport Method";
            pJobJnlLine."Entry/Exit Point" := pSalesLine."Exit Point";
            pJobJnlLine.Area := pSalesLine.Area;
            pJobJnlLine."Transaction Specification" := pSalesLine."Transaction Specification";
            pJobJnlLine."Entry Type" := pJobJnlLine."entry type"::Sale;
            if "Document Type" in [pSalesHeader."document type"::Invoice, pSalesHeader."document type"::Order] then begin
                pJobJnlLine."Document No." := pSalesInvHeader."No.";
                pJobJnlLine."External Document No." := pSalesInvHeader."External Document No.";
            end else begin
                pJobJnlLine."Document No." := pSalesCrMemoHeader."No.";
                pJobJnlLine."External Document No." := pSalesCrMemoHeader."External Document No.";
            end;
            pJobJnlLine.Quantity := -pSalesLine."Qty. to Invoice";
            pJobJnlLine."Quantity (Base)" := -pSalesLine."Qty. to Invoice (Base)";
            pJobJnlLine."Source Code" := pSourcecode;
            pJobJnlLine."Job Posting Only" := true;
            pJobJnlLine."Posting No. Series" := "Posting No. Series";
            pJobJnlLine."Qty. per Unit of Measure" := pSalesLine."Qty. per Unit of Measure";

            //Montants
            pJobJnlLine."Source Currency Code" := "Currency Code";
            pJobJnlLine."Source Currency Total Cost" :=
                    ROUND(pSalesLineACY."Unit Cost" * pJobJnlLine.Quantity, pCurrency."Amount Rounding Precision");
            pJobJnlLine."Source Currency Total Price" := -pSalesLineACY.Amount;
            pJobJnlLine.Validate("Unit Cost (LCY)", pSalesLine."Unit Cost (LCY)");
            pJobJnlLine."Line Discount %" := pSalesLine."Line Discount %";
            if "Currency Code" = '' then begin
                pJobJnlLine."Unit Price (LCY)" := pSalesLine."Unit Price";
                pJobJnlLine."Line Amount (LCY)" := -pSalesLine.Amount;
                pJobJnlLine."Line Discount Amount (LCY)" := -pSalesLine."Line Discount Amount";
            end else begin
                pJobJnlLine."Unit Price (LCY)" :=
                   ROUND(lCurrExchRate.ExchangeAmtFCYToLCY(
                               "Posting Date", "Currency Code", pSalesLine."Unit Price", "Currency Factor"));
                pJobJnlLine."Line Amount (LCY)" :=
                   ROUND(lCurrExchRate.ExchangeAmtFCYToLCY(
                               "Posting Date", "Currency Code", -pSalesLine.Amount, "Currency Factor"));
                pJobJnlLine."Line Discount Amount (LCY)" :=
                    ROUND(lCurrExchRate.ExchangeAmtFCYToLCY(
                               "Posting Date", "Currency Code", -pSalesLine."Line Discount Amount", "Currency Factor"));
            end;
            if lJob."Currency Code" = '' then begin
                pJobJnlLine."Unit Cost" := pSalesLine."Unit Cost (LCY)";
                pJobJnlLine."Unit Price" := pSalesLine."Unit Price";
                pJobJnlLine."Line Discount Amount" := pJobJnlLine."Line Discount Amount (LCY)";
                pJobJnlLine."Line Amount" := pJobJnlLine."Line Amount (LCY)";
                pJobJnlLine."Currency Factor" := 1;
            end;
            pJobJnlLine.Validate("Unit Cost");
            if "Prices Including VAT" then begin
                pJobJnlLine."Unit Price (LCY)" := (pJobJnlLine."Unit Price (LCY)" / (1 + pSalesLine."VAT %" / 100));
                pJobJnlLine."Unit Price" := (pJobJnlLine."Unit Price" / (1 + pSalesLine."VAT %" / 100));
                pJobJnlLine."Line Amount (LCY)" := (pJobJnlLine."Line Amount (LCY)" / (1 + pSalesLine."VAT %" / 100));
                pJobJnlLine."Line Discount Amount (LCY)" := (pJobJnlLine."Line Discount Amount (LCY)" / (1 + pSalesLine."VAT %" / 100));
            end;

            //#6389
            //  pJobJnlLine.VALIDATE("Unit Price (LCY)");
            pJobJnlLine."Total Price (LCY)" := pJobJnlLine."Line Amount (LCY)";
            pJobJnlLine."Total Price" := pJobJnlLine."Line Amount";
            //#6389//

        end;
    end;


    procedure fSetAmntGenJnlLineToJnlLine(pGenJnlLine: Record "Gen. Journal Line"; var pJobJnlLine: Record "Job Journal Line")
    var
        lGenJnlTpl: Record "Gen. Journal Template";
        lSign: Integer;
        lSignQty: Integer;
    begin
        //#7771 CW 15/02/09 Cette fonction n'est plus utilisée
        //#7201
        if (lGenJnlTpl.Get(pGenJnlLine."Journal Template Name")) then begin

            //#7350
            /*DELETE
              IF (lGenJnlTpl.Type = lGenJnlTpl.Type::Sales) AND
                (pGenJnlLine."Gen. Posting Type" = pGenJnlLine."Gen. Posting Type"::Sale)
              //#7408
              {DELETE
                 AND (pGenJnlLine."Account Type" = pGenJnlLine."Account Type"::"G/L Account") AND
                 (pGenJnlLine."Job Unit Price" < 0)) THEN BEGIN
              DELETE}
                THEN BEGIN
                lSign := -1;

                CASE pGenJnlLine."Document Type" OF
                  pGenJnlLine."Document Type"::Invoice :
                    IF (pGenJnlLine."Job Line Amount (LCY)" > 0) THEN
                       lSign := 1;
                  pGenJnlLine."Document Type"::"Credit Memo" :
                    IF (pGenJnlLine."Job Line Amount (LCY)" < 0) THEN
                       lSign := 1;
                END;
              //#7408//
            DELETE*/
            /*
              lSignQty := 1;
              IF (pGenJnlLine."Job Unit Price" > 0) THEN
                lSign := 1
              ELSE BEGIN
                lSign := -1;
                lSignQty := - 1;
              END;
              CASE pGenJnlLine."Document Type" OF
                pGenJnlLine."Document Type"::Invoice :
                    IF (pGenJnlLine."Job Line Amount (LCY)" > 0) THEN
                       lSign := 1
                    ELSE BEGIN
                       lSign := -1;
                       lSignQty := - 1;
                    END;
                pGenJnlLine."Document Type"::"Credit Memo" :
                    IF (pGenJnlLine."Job Line Amount (LCY)" < 0) THEN
                       lSign := 1
                    ELSE BEGIN
                       lSign := -1;
                       lSignQty := -1;
                    END;

                //#7604
                pGenJnlLine."Document Type"::" " :
                  IF (pGenJnlLine."Job Unit Price" * pGenJnlLine."Amount (LCY)") <= 0 THEN // (pas ds le meme sens
                    lSign := 1
                //#7604//
                END;
            //#7350//
            */

            //#7613
            lSign := 1;
            case pGenJnlLine."Document Type" of
                pGenJnlLine."document type"::Invoice:
                    lSign := 1;
                pGenJnlLine."document type"::"Credit Memo":
                    lSign := -1;
            end;
            if (pGenJnlLine."Job Unit Price" < 0) then
                lSignQty := -pGenJnlLine."Job Quantity"
            else
                lSignQty := pGenJnlLine."Job Quantity";
            lSignQty := lSign * lSignQty;
            lSign := lSign * pGenJnlLine."Job Quantity";
            //#7613

            pJobJnlLine.Quantity := lSign * pGenJnlLine."Job Quantity";
            pJobJnlLine."Quantity (Base)" := lSign * pJobJnlLine.Quantity;
            //#7350
            pJobJnlLine.Quantity := lSignQty * pJobJnlLine.Quantity;
            pJobJnlLine."Quantity (Base)" := lSignQty * pJobJnlLine.Quantity;
            //#7350//
            pJobJnlLine."Qty. per Unit of Measure" := 1; // MP ??
            pJobJnlLine."Direct Unit Cost (LCY)" := lSign * (pGenJnlLine."Job Unit Cost (LCY)");
            pJobJnlLine."Unit Cost (LCY)" := lSign * (pGenJnlLine."Job Unit Cost (LCY)");
            pJobJnlLine."Unit Cost" := lSign * (pGenJnlLine."Job Unit Cost");
            pJobJnlLine."Total Cost (LCY)" := lSign * (pGenJnlLine."Job Total Cost (LCY)");
            pJobJnlLine."Total Cost" := lSign * (pGenJnlLine."Job Total Cost");
            pJobJnlLine."Unit Price (LCY)" := lSign * (pGenJnlLine."Job Unit Price (LCY)");
            pJobJnlLine."Unit Price" := lSign * (pGenJnlLine."Job Unit Price");
            pJobJnlLine."Total Price (LCY)" := lSign * (pGenJnlLine."Job Total Price (LCY)");
            pJobJnlLine."Total Price" := lSign * (pGenJnlLine."Job Total Price");
            pJobJnlLine."Line Amount (LCY)" := lSign * (pGenJnlLine."Job Line Amount (LCY)");
            pJobJnlLine."Line Amount" := lSign * (pGenJnlLine."Job Line Amount");
            pJobJnlLine."Line Discount Amount (LCY)" := lSign * (pGenJnlLine."Job Line Disc. Amount (LCY)");
            pJobJnlLine."Line Discount Amount" := lSign * (pGenJnlLine."Job Line Discount Amount");
            pJobJnlLine."Line Discount %" := lSign * (pGenJnlLine."Job Line Discount %");
            //#7350
            /*DELETE
              END ELSE BEGIN
                pJobJnlLine.Quantity := pGenJnlLine."Job Quantity";
                pJobJnlLine."Quantity (Base)" := pJobJnlLine.Quantity;
                pJobJnlLine."Qty. per Unit of Measure" := 1; // MP ??
                pJobJnlLine."Direct Unit Cost (LCY)" := pGenJnlLine."Job Unit Cost (LCY)";
                pJobJnlLine."Unit Cost (LCY)" := pGenJnlLine."Job Unit Cost (LCY)";
                pJobJnlLine."Unit Cost" := pGenJnlLine."Job Unit Cost";
                pJobJnlLine."Total Cost (LCY)" := pGenJnlLine."Job Total Cost (LCY)";
                pJobJnlLine."Total Cost" := pGenJnlLine."Job Total Cost";
                pJobJnlLine."Unit Price (LCY)" := pGenJnlLine."Job Unit Price (LCY)";
                pJobJnlLine."Unit Price" := pGenJnlLine."Job Unit Price";
                pJobJnlLine."Total Price (LCY)" := pGenJnlLine."Job Total Price (LCY)";
                pJobJnlLine."Total Price" := pGenJnlLine."Job Total Price";
                pJobJnlLine."Line Amount (LCY)" := pGenJnlLine."Job Line Amount (LCY)";
                pJobJnlLine."Line Amount" := pGenJnlLine."Job Line Amount";
                pJobJnlLine."Line Discount Amount (LCY)" := pGenJnlLine."Job Line Disc. Amount (LCY)";
                pJobJnlLine."Line Discount Amount" := pGenJnlLine."Job Line Discount Amount";
                pJobJnlLine."Line Discount %" := pGenJnlLine."Job Line Discount %";
              END;
            */
            //#7350//
        end else begin
            pJobJnlLine.Quantity := pGenJnlLine."Job Quantity";
            pJobJnlLine."Quantity (Base)" := pJobJnlLine.Quantity;
            pJobJnlLine."Qty. per Unit of Measure" := 1; // MP ??
            pJobJnlLine."Direct Unit Cost (LCY)" := pGenJnlLine."Job Unit Cost (LCY)";
            pJobJnlLine."Unit Cost (LCY)" := pGenJnlLine."Job Unit Cost (LCY)";
            pJobJnlLine."Unit Cost" := pGenJnlLine."Job Unit Cost";
            pJobJnlLine."Total Cost (LCY)" := pGenJnlLine."Job Total Cost (LCY)";
            pJobJnlLine."Total Cost" := pGenJnlLine."Job Total Cost";
            pJobJnlLine."Unit Price (LCY)" := pGenJnlLine."Job Unit Price (LCY)";
            pJobJnlLine."Unit Price" := pGenJnlLine."Job Unit Price";
            pJobJnlLine."Total Price (LCY)" := pGenJnlLine."Job Total Price (LCY)";
            pJobJnlLine."Total Price" := pGenJnlLine."Job Total Price";
            pJobJnlLine."Line Amount (LCY)" := pGenJnlLine."Job Line Amount (LCY)";
            pJobJnlLine."Line Amount" := pGenJnlLine."Job Line Amount";
            pJobJnlLine."Line Discount Amount (LCY)" := pGenJnlLine."Job Line Disc. Amount (LCY)";
            pJobJnlLine."Line Discount Amount" := pGenJnlLine."Job Line Discount Amount";
            pJobJnlLine."Line Discount %" := pGenJnlLine."Job Line Discount %";
        end;
        //#7201//

    end;


    procedure fSaleType(var pJobJnlLine: Record "Job Journal Line")
    var
        lSign: Integer;
    begin
        //#7771
        with pJobJnlLine do begin
            "Entry Type" := "entry type"::Sale;
            "Total Price (LCY)" := -"Total Cost (LCY)";
            "Total Price" := -"Total Cost";
            //#7869
            lSign := 1;
            if -"Total Cost (LCY)" < 0 then
                lSign := -1;
            Quantity := lSign * Abs(Quantity);
            "Quantity (Base)" := lSign * Abs("Quantity (Base)");
            "Unit Price (LCY)" := Abs("Unit Price (LCY)");
            "Unit Price" := Abs("Unit Price");
            //#7869//
            "Line Amount (LCY)" := "Total Price (LCY)";
            "Line Amount" := "Total Price";
            "Line Discount Amount (LCY)" := 0;
            "Line Discount Amount" := 0;
            "Total Cost (LCY)" := 0;
            "Total Cost" := 0;
            "Unit Cost (LCY)" := 0;
            "Unit Cost" := 0;
        end;
        //#7771//
    end;
}

