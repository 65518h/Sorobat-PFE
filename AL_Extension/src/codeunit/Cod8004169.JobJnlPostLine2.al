Codeunit 8004169 "Job Jnl.-Post Line2"
{
    // //RES_USAGE\\
    // //ABSENCE\\
    // //PLANNING AC 08/06/10 Suppression des écritures plannings validées.
    // //+REP+ GESWAY 01/12/01 Marquer les écritures provenant d'une répartition analytique
    //                         Le groupe compta projet est le groupe compta projet du projet
    //                         Ajout READPERMISSION sur "Analytical Distribution Setup"
    // //BAT_REP FL 17/11/06 pas de frais généraux si écriture issue d'une répartition analytique
    // //PLANNING GESWAY 26/09/02 Maj du planning
    // //STOCK GESWAY 02/09/03 Ne pas créer d'écritures article si "Inventory Entry" = TRUE
    // //PROJET GESWAY 15/03/04 Alimentation du coût et prix unitaire pour les écritures de type vente
    // //PROJET_FG CW 13/04/04 Calcul de "Overhead Amount" si type = "Activité"
    // //DESCRIPTION GESWAY 08/12/04 Gestion des commentaires sur les écritures chantier
    // //REVERSE GESWAY 13/05/05 Renseignement champ JobLedgEntry."G/L Entry No."
    // //MASK CW 13/03/06 +set "Mask Code"
    // //IC ML 21/06/06 MAJ du champ "To Company"
    //                  MAJ du champ "IC Job Ledg. Entry No."

    Permissions = TableData "Job Ledger Entry" = imd,
                  TableData "Job Register" = imd,
                  TableData "Value Entry" = imd,
                  TableData "Analytical Distribution Setup" = r;
    TableNo = "Job Journal Line";

    trigger OnRun()
    var
        TempJnlLineDim2: Record "Dim. Value per Account" temporary;
    begin
        /*GL2024   GetGLSetup;
           TempJnlLineDim2.Reset;
           TempJnlLineDim2.DeleteAll;
           if "Shortcut Dimension 1 Code" <> '' then begin
               TempJnlLineDim2."Table ID" := Database::"Job Journal Line";
               TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
               TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
               TempJnlLineDim2."Journal Line No." := "Line No.";
               TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 1 Code";
               TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 1 Code";
               TempJnlLineDim2.Insert;
           end;
           if "Shortcut Dimension 2 Code" <> '' then begin
               TempJnlLineDim2."Table ID" := Database::"Job Journal Line";
               TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
               TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
               TempJnlLineDim2."Journal Line No." := "Line No.";
               TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 2 Code";
               TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 2 Code";
               TempJnlLineDim2.Insert;
           end;

        RunWithCheck(Rec, TempJnlLineDim2);*/
    end;

    var
        Cust: Record Customer;
        Job: Record Job;
        JT: Record "Job Task";
        JobLedgEntry: Record "Job Ledger Entry";
        JobJnlLine: Record "Job Journal Line";
        JobJnlLine2: Record "Job Journal Line";
        ResJnlLine: Record "Res. Journal Line";
        ItemJnlLine: Record "Item Journal Line";
        JobReg: Record "Job Register";
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        //GL2024   TempJnlLineDim: Record 356 temporary;
        JobJnlCheckLine: Codeunit "Job Jnl.-Check Line2";
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        JobPostLine: Codeunit "Job Post-Line2";
        JobJnlLineReserve: Codeunit "Job Jnl. Line-Reserve2";
        DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;
        NextEntryNo: Integer;
        GLEntryNo: Integer;
        wAnalyticalSetup: Record "Analytical Distribution Setup";
        wDistributedEntriesBuffer: Record "Distributed Entries Buffer";
        Text8003900: label 'You cannot post the lines for the job %1.';
        wOverhead: Codeunit "Overhead Calculation";
        ErrIC: label 'You cannot validate the line %1 from Job %2, because it was already validated.';
        tEmployeeAbs: label 'Absences ledger exist for resource %1 in date of %2. Do you want to continue ?';
        GenPostingSetup: Record "General Posting Setup";
        gAddOnLicencePermission: Codeunit IntegrManagement;


    procedure GetJobReg(var NewJobReg: Record "Job Register")
    begin
        NewJobReg := JobReg;
    end;


    /*  procedure RunWithoutCheck(var JobJnlLine2: record 210; var TempJnlLineDim2: Record 356)
          begin
              JobJnlLine.Copy(JobJnlLine2);
              TempJnlLineDim.Reset;
              TempJnlLineDim.DeleteAll;
              DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2, TempJnlLineDim);
              Code(false);
              JobJnlLine2 := JobJnlLine;
          end;


          procedure RunWithCheck(var JobJnlLine2: record 210; var TempJnlLineDim2: Record 356)
          begin
              JobJnlLine.Copy(JobJnlLine2);
              TempJnlLineDim.Reset;
              TempJnlLineDim.DeleteAll;
              DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2, TempJnlLineDim);
              Code(true);
              JobJnlLine2 := JobJnlLine;
          end;*/

    local procedure "Code"(CheckLine: Boolean)
    var
        Item: Record Item;
        Resource: Record Resource;
        ItemLedgEntry: Record "Item Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        ValueEntry: Record "Value Entry";
        JobLedgEntry2: Record "Job Ledger Entry";
        LastLedgerEntryNo: Integer;
        JobLedgEntryNo: Integer;
        SkipJobLedgerEntry: Boolean;
        lJobJnlLineLoc: Record "Job Journal Line";
        lDescriptionLine: Record "Description Line";
        lJobLedgEntry: Record "Job Ledger Entry";
        tAbs: Text[30];
        lPlanningIntegr: Codeunit "Planning Integration";
        lAdjustNeg: Boolean;
        lItemEntryNo: Integer;
    begin
        GetGLSetup;

        with JobJnlLine do begin
            if EmptyLine then
                exit;

            /*  GL2024 if CheckLine then
                    JobJnlCheckLine.RunCheck(JobJnlLine, TempJnlLineDim);*/

            if JobLedgEntry."Entry No." = 0 then begin
                JobLedgEntry.LockTable;
                if JobLedgEntry.Find('+') then
                    NextEntryNo := JobLedgEntry."Entry No.";
                NextEntryNo := NextEntryNo + 1;
            end;

            //PROJET_CESSION
            if Area = '@@' then
                Area := '';
            //PROJET_CESSION//

            if "Document Date" = 0D then
                "Document Date" := "Posting Date";

            if JobReg."No." = 0 then begin
                JobReg.LockTable;
                if (not JobReg.Find('+')) or (JobReg."To Entry No." <> 0) then begin
                    JobReg.Init;
                    JobReg."No." := JobReg."No." + 1;
                    JobReg."From Entry No." := NextEntryNo;
                    JobReg."To Entry No." := NextEntryNo;
                    JobReg."Creation Date" := Today;
                    JobReg."Source Code" := "Source Code";
                    JobReg."Journal Batch Name" := "Journal Batch Name";
                    JobReg."User ID" := UserId;
                    JobReg.Insert;
                end;
            end;
            //RES_USAGE
            if "Job No." <> '' then begin
                //RES_USAGE//
                Job.Get("Job No.");
                Job.TestBlocked;
                //#4718
                //Job.TESTFIELD("Bill-to Customer No.");
                //Cust.GET(Job."Bill-to Customer No.");

                //#5829
                //  IF (Job."Job Type" <> Job."Job Type"::Internal) AND (Job."IC Partner Code" = '') THEN BEGIN
                if (Job."Job Type" = Job."job type"::External) and (Job."IC Partner Code" = '') then begin
                    //#5829//
                    Job.TestField("Bill-to Customer No.");
                    Cust.Get(Job."Bill-to Customer No.");
                end;
                //#4718//
                TestField("Currency Code", Job."Currency Code");
                //#5118 reprendre le code tâche par défaut pour les affaires de contrepartie (interne)
                if ("Job Task No." = '') and
                   (Job."Job Type" in [Job."job type"::Internal, Job."job type"::Stock]) then begin
                    "Job Task No." := Job.gGetDefaultJobTask;
                end;
                //#5118//
                //RES_USAGE
            end;
            //RES_USAGE//
            if JT.Get("Job No.", "Job Task No.") then;
            JT.TestField("Job Task Type", JT."job task type"::Posting);
            JobJnlLine2 := JobJnlLine;

            GetGLSetup;
            if GLSetup."Additional Reporting Currency" <> '' then begin
                if JobJnlLine2."Source Currency Code" <> GLSetup."Additional Reporting Currency" then begin
                    Currency.Get(GLSetup."Additional Reporting Currency");
                    Currency.TestField("Amount Rounding Precision");
                    JobJnlLine2."Source Currency Total Cost" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          JobJnlLine2."Posting Date",
                          GLSetup."Additional Reporting Currency", JobJnlLine2."Total Cost (LCY)",
                          CurrExchRate.ExchangeRate(
                            JobJnlLine2."Posting Date", GLSetup."Additional Reporting Currency")),
                        Currency."Amount Rounding Precision");
                    JobJnlLine2."Source Currency Total Price" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          JobJnlLine2."Posting Date",
                          GLSetup."Additional Reporting Currency", JobJnlLine2."Total Price (LCY)",
                          CurrExchRate.ExchangeRate(
                            JobJnlLine2."Posting Date", GLSetup."Additional Reporting Currency")),
                        Currency."Amount Rounding Precision");
                    JobJnlLine2."Source Currency Line Amount" :=
                      ROUND(
                        CurrExchRate.ExchangeAmtLCYToFCY(
                          JobJnlLine2."Posting Date",
                          GLSetup."Additional Reporting Currency", JobJnlLine2."Line Amount (LCY)",
                          CurrExchRate.ExchangeRate(
                            JobJnlLine2."Posting Date", GLSetup."Additional Reporting Currency")),
                        Currency."Amount Rounding Precision");
                end;
            end else begin
                JobJnlLine2."Source Currency Total Cost" := 0;
                JobJnlLine2."Source Currency Total Price" := 0;
                JobJnlLine2."Source Currency Line Amount" := 0;
            end;

            if JobJnlLine2."Entry Type" = JobJnlLine2."entry type"::Usage then begin
                case Type of
                    Type::Resource:
                        begin
                            ResJnlLine.Init;
                            ResJnlLine."Entry Type" := JobJnlLine2."Entry Type";
                            ResJnlLine."Document No." := JobJnlLine2."Document No.";
                            ResJnlLine."External Document No." := JobJnlLine2."External Document No.";
                            ResJnlLine."Posting Date" := JobJnlLine2."Posting Date";
                            ResJnlLine."Document Date" := JobJnlLine2."Document Date";
                            ResJnlLine."Resource No." := JobJnlLine2."No.";
                            ResJnlLine.Description := JobJnlLine2.Description;
                            ResJnlLine."Work Type Code" := JobJnlLine2."Work Type Code";
                            ResJnlLine."Job No." := JobJnlLine2."Job No.";
                            ResJnlLine."Shortcut Dimension 1 Code" := JobJnlLine2."Shortcut Dimension 1 Code";
                            ResJnlLine."Shortcut Dimension 2 Code" := JobJnlLine2."Shortcut Dimension 2 Code";
                            ResJnlLine."Unit of Measure Code" := JobJnlLine2."Unit of Measure Code";
                            ResJnlLine."Source Code" := JobJnlLine2."Source Code";
                            ResJnlLine."Gen. Bus. Posting Group" := JobJnlLine2."Gen. Bus. Posting Group";
                            ResJnlLine."Gen. Prod. Posting Group" := JobJnlLine2."Gen. Prod. Posting Group";
                            ResJnlLine."Posting No. Series" := JobJnlLine2."Posting No. Series";
                            ResJnlLine."Reason Code" := JobJnlLine2."Reason Code";
                            ResJnlLine."Resource Group No." := JobJnlLine2."Resource Group No.";
                            ResJnlLine."Recurring Method" := JobJnlLine2."Recurring Method";
                            ResJnlLine."Expiration Date" := JobJnlLine2."Expiration Date";
                            ResJnlLine."Recurring Frequency" := JobJnlLine2."Recurring Frequency";
                            //GL2024 ResJnlLine.Chargeable := JobJnlLine2.Chargeable;
                            ResJnlLine.Quantity := JobJnlLine2.Quantity;
                            ResJnlLine."Qty. per Unit of Measure" := JobJnlLine2."Qty. per Unit of Measure";
                            ResJnlLine."Direct Unit Cost" := JobJnlLine2."Direct Unit Cost (LCY)";
                            ResJnlLine."Unit Cost" := JobJnlLine2."Unit Cost (LCY)";
                            ResJnlLine."Total Cost" := JobJnlLine2."Total Cost (LCY)";
                            ResJnlLine."Unit Price" := JobJnlLine2."Unit Price (LCY)";
                            ResJnlLine."Total Price" := JobJnlLine2."Line Amount (LCY)";
                            //PLANNING
                            lPlanningIntegr.SetResJnlLine(ResJnlLine, JobJnlLine2);
                            //PLANNING//
                            ResLedgEntry.LockTable;
                            //GL2024 ResJnlPostLine.RunWithCheck(ResJnlLine, TempJnlLineDim);
                            JobJnlLine2."Resource Group No." := ResJnlLine."Resource Group No.";
                            CreateJobLedgEntry(JobJnlLine2);
                            //PLANNING
                            lPlanningIntegr.DeletePlanningEntry(JobJnlLine2)
                            //PLANNING//
                        end;
                    Type::Item:
                        begin
                            if not "Job Posting Only" then begin
                                ItemJnlLine.Init;
                                ItemJnlLine."Item No." := JobJnlLine2."No.";
                                Item.Get(JobJnlLine2."No.");
                                ItemJnlLine."Inventory Posting Group" := Item."Inventory Posting Group";
                                ItemJnlLine."Posting Date" := JobJnlLine2."Posting Date";
                                ItemJnlLine."Document Date" := JobJnlLine2."Document Date";
                                ItemJnlLine."Source Type" := ItemJnlLine."source type"::Customer;
                                ItemJnlLine."Source No." := Job."Bill-to Customer No.";
                                ItemJnlLine."Document No." := JobJnlLine2."Document No.";

                                ItemJnlLine."External Document No." := JobJnlLine2."External Document No.";
                                ItemJnlLine.Description := JobJnlLine2.Description;
                                ItemJnlLine."Location Code" := JobJnlLine2."Location Code";
                                ItemJnlLine."Applies-to Entry" := JobJnlLine2."Applies-to Entry";
                                ItemJnlLine."Applies-from Entry" := JobJnlLine2."Applies-from Entry";
                                ItemJnlLine."Shortcut Dimension 1 Code" := JobJnlLine2."Shortcut Dimension 1 Code";
                                ItemJnlLine."Shortcut Dimension 2 Code" := JobJnlLine2."Shortcut Dimension 2 Code";
                                ItemJnlLine."Country/Region Code" := JobJnlLine2."Country/Region Code";
                                ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Negative Adjmt.";
                                ItemJnlLine."Source Code" := JobJnlLine2."Source Code";
                                ItemJnlLine."Gen. Bus. Posting Group" := JobJnlLine2."Gen. Bus. Posting Group";
                                ItemJnlLine."Gen. Prod. Posting Group" := JobJnlLine2."Gen. Prod. Posting Group";
                                ItemJnlLine."Posting No. Series" := JobJnlLine2."Posting No. Series";
                                ItemJnlLine."Variant Code" := JobJnlLine2."Variant Code";
                                ItemJnlLine."Bin Code" := JobJnlLine2."Bin Code";
                                ItemJnlLine."Unit of Measure Code" := JobJnlLine2."Unit of Measure Code";
                                ItemJnlLine."Reason Code" := JobJnlLine2."Reason Code";

                                ItemJnlLine."Transaction Type" := JobJnlLine2."Transaction Type";
                                ItemJnlLine."Transport Method" := JobJnlLine2."Transport Method";
                                ItemJnlLine."Entry/Exit Point" := JobJnlLine2."Entry/Exit Point";
                                ItemJnlLine.Area := JobJnlLine2.Area;
                                ItemJnlLine."Transaction Specification" := JobJnlLine2."Transaction Specification";
                                ItemJnlLine."Invoiced Quantity" := JobJnlLine2.Quantity;
                                ItemJnlLine."Invoiced Qty. (Base)" := JobJnlLine2."Quantity (Base)";
                                ItemJnlLine."Source Currency Code" := JobJnlLine2."Source Currency Code";

                                Item.Get(ItemJnlLine."Item No.");
                                ItemJnlLine."Item Category Code" := Item."Item Category Code";
                                //GL2024 ItemJnlLine."Product Group Code" := Item."Product Group Code";

                                ItemJnlLine.Quantity := JobJnlLine2.Quantity;
                                ItemJnlLine."Quantity (Base)" := JobJnlLine2."Quantity (Base)";
                                ItemJnlLine."Qty. per Unit of Measure" := JobJnlLine2."Qty. per Unit of Measure";
                                ItemJnlLine."Unit Cost" := JobJnlLine2."Unit Cost (LCY)";
                                ItemJnlLine."Unit Cost (ACY)" := JobJnlLine2."Unit Cost";
                                ItemJnlLine.Amount := JobJnlLine2."Total Cost (LCY)";
                                ItemJnlLine."Amount (ACY)" := JobJnlLine2."Total Cost";
                                ItemJnlLine."Value Entry Type" := ItemJnlLine."value entry type"::"Direct Cost";

                                ItemJnlLine."Job No." := JobJnlLine2."Job No.";
                                ItemJnlLine."Job Task No." := JobJnlLine2."Job Task No.";
                                JobJnlLineReserve.TransJobJnlLineToItemJnlLine(JobJnlLine2, ItemJnlLine, ItemJnlLine."Quantity (Base)");

                                ItemLedgEntry.LockTable;
                                //STOCK
                                //IF NOT "Job Posting Only" THEN
                                /* GL2024 if not "Job Posting Only" and not "Phys. Inventory" and not JobJnlLine2."Bal. Created Entry" then
                                      //STOCK//
                                      ItemJnlPostLine.RunWithCheck(ItemJnlLine, TempJnlLineDim);*/
                            end;

                            ValueEntry.SetCurrentkey("Job No.", "Job Task No.", "Document No.");
                            ValueEntry.SetRange("Job No.", "Job No.");
                            ValueEntry.SetRange("Job Task No.", "Job Task No.");
                            ValueEntry.SetRange("Document No.", "Document No.");
                            //#8222
                            if Job."Job Type" <> Job."job type"::Stock then begin
                                //#8222
                                ValueEntry.SetRange("Item Ledger Entry Type", ValueEntry."item ledger entry type"::"Negative Adjmt.");
                                //#8877
                                /*
                                          IF NOT lAdjustNeg THEN BEGIN
                                            ValueEntry.SETRANGE("Item Ledger Entry Type");
                                            ValueEntry.SETFILTER("Job Ledger Entry No.",'= 0');
                                            IF ValueEntry.FINDFIRST THEN BEGIN
                                              IF ValueEntry."Item Ledger Entry Type" = ValueEntry."Item Ledger Entry Type"::Sale THEN
                                                ItemLedgEntry.SETRANGE("Entry No.",ValueEntry."Item Ledger Entry No.")
                                              ELSE
                                                ItemLedgEntry.SETRANGE("Applies-to Entry",ValueEntry."Item Ledger Entry No.");
                                              IF ItemLedgEntry.FINDFIRST THEN
                                                ValueEntry.SETRANGE("Document No.",ItemLedgEntry."Document No.");
                                                ValueEntry.SETRANGE("Item Ledger Entry Type",ValueEntry."Item Ledger Entry Type"::Sale);
                                                lItemEntryNo := ItemLedgEntry."Entry No.";
                                            END;
                                          END;
                                */
                                //#8877//
                                ValueEntry.SetFilter("Job Ledger Entry No.", '= 0');
                                //#8877
                                lAdjustNeg := not ValueEntry.IsEmpty;
                                if not lAdjustNeg then
                                    ValueEntry.SetRange("Item Ledger Entry Type");
                                //#8877//
                                if ValueEntry.FindSet then begin
                                    repeat
                                        //#8877
                                        if not lAdjustNeg then
                                            gSetJobItemOnSalesLink(ValueEntry, JobJnlLine, JobJnlLine2)
                                        else begin
                                            //#8877//
                                            SkipJobLedgerEntry := false;


                                            if ItemLedgEntry.Get(ValueEntry."Item Ledger Entry No.") then begin
                                                JobLedgEntry2.SetRange("Ledger Entry Type", JobLedgEntry2."ledger entry type"::Item);
                                                JobLedgEntry2.SetRange("Ledger Entry No.", ItemLedgEntry."Entry No.");
                                                // The following code is only to secure that JLEs created at receipt in version 6.0 or earlier,
                                                // are not created again at point of invoice (6.0 SP1 and newer).
                                                if JobLedgEntry2.FindFirst and (JobLedgEntry2.Quantity = -ItemLedgEntry.Quantity) then
                                                    SkipJobLedgerEntry := true
                                                else begin
                                                    JobJnlLine2."Serial No." := ItemLedgEntry."Serial No.";
                                                    JobJnlLine2."Lot No." := ItemLedgEntry."Lot No.";
                                                end;
                                            end;
                                            if not SkipJobLedgerEntry then begin
                                                //7956
                                                JobJnlLine2.Validate(Quantity, -ValueEntry."Invoiced Quantity" / JobJnlLine."Qty. per Unit of Measure");

                                                //7956//
                                                JobJnlLine2."Ledger Entry Type" := JobJnlLine."ledger entry type"::Item;
                                                JobJnlLine2."Ledger Entry No." := ValueEntry."Item Ledger Entry No.";
                                                JobLedgEntryNo := CreateJobLedgEntry(JobJnlLine2);
                                                ValueEntry."Job Ledger Entry No." := JobLedgEntryNo;
                                                ValueEntry.Modify(true);
                                            end;
                                            //#8877
                                        end;
                                    //#8877//
                                    until ValueEntry.Next = 0;
                                end;
                                //#8222
                            end;
                            //#8222//

                            //#8790
                            if (JobJnlLine2."Bal. Created Entry") and (Job."Job Type" = Job."job type"::Stock) then
                                CreateJobLedgEntry(JobJnlLine2)
                            //#8790//
                        end;
                    Type::"G/L Account":
                        CreateJobLedgEntry(JobJnlLine2);
                end;
            end else begin
                CreateJobLedgEntry(JobJnlLine2);
            end;

        end;

    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GLSetup.Get;
        GLSetupRead := true;
    end;

    local procedure CreateJobLedgEntry(JobJnlLine2: Record "Job Journal Line"): Integer
    var
        ResLedgEntry: Record "Res. Ledger Entry";
        JobTransferLine: Codeunit "Job Transfer Line2";
        lPlanningEntry: Record "Planning Entry";
        lJobLedgEntry: Record "Job Ledger Entry";
        lDescriptionLine: Record "Description Line";
        lAnalDistribMgt: Codeunit "Analytical Distrib.Integr.";
    begin
        SetCurrency(JobJnlLine2);
        /*
        //#4481
        IF (JobJnlLine2.Type = JobJnlLine2.Type::"G/L Account") AND (JobJnlLine2."Direct Unit Cost (LCY)" = 0) AND
           (JobJnlLine2."Unit Cost" = 0) AND (JobJnlLine2."Total Cost" = 0) AND
           (JobJnlLine2."Unit Price" = 0) AND (JobJnlLine2."Total Price" = 0) THEN
          EXIT;
        //#4481//
        */
        JobLedgEntry.Init;
        JobTransferLine.FromJnlLineToLedgEntry(JobJnlLine2, JobLedgEntry);
        //MASK
        JobLedgEntry."Mask Code" := Job."Mask Code";
        //MASK//
        if JobLedgEntry."Entry Type" = JobLedgEntry."entry type"::Sale then begin
            JobLedgEntry.Quantity := -JobJnlLine2.Quantity;
            JobLedgEntry."Quantity (Base)" := -JobJnlLine2."Quantity (Base)";

            JobLedgEntry."Total Cost (LCY)" := -JobJnlLine2."Total Cost (LCY)";
            JobLedgEntry."Total Cost" := -JobJnlLine2."Total Cost";

            JobLedgEntry."Total Price (LCY)" := -JobJnlLine2."Total Price (LCY)";
            JobLedgEntry."Total Price" := -JobJnlLine2."Total Price";

            JobLedgEntry."Line Amount (LCY)" := -JobJnlLine2."Line Amount (LCY)";
            JobLedgEntry."Line Amount" := -JobJnlLine2."Line Amount";

            JobLedgEntry."Line Discount Amount (LCY)" := -JobJnlLine2."Line Discount Amount (LCY)";
            JobLedgEntry."Line Discount Amount" := -JobJnlLine2."Line Discount Amount";
        end else begin

            //PROJET
            if (JobLedgEntry.Quantity <> 0) then begin
                JobLedgEntry."Unit Cost" := ROUND(JobJnlLine2."Total Cost" / JobJnlLine2.Quantity, 0.00001);
                JobLedgEntry."Unit Price" := ROUND(JobJnlLine2."Total Price" / JobJnlLine2.Quantity, 0.00001);
            end;
            //PROJET//
            JobLedgEntry.Quantity := JobJnlLine2.Quantity;
            JobLedgEntry."Quantity (Base)" := JobJnlLine2."Quantity (Base)";

            JobLedgEntry."Total Cost (LCY)" := JobJnlLine2."Total Cost (LCY)";
            JobLedgEntry."Total Cost" := JobJnlLine2."Total Cost";

            JobLedgEntry."Total Price (LCY)" := JobJnlLine2."Total Price (LCY)";
            JobLedgEntry."Total Price" := JobJnlLine2."Total Price";

            JobLedgEntry."Line Amount (LCY)" := JobJnlLine2."Line Amount (LCY)";
            JobLedgEntry."Line Amount" := JobJnlLine2."Line Amount";

            JobLedgEntry."Line Discount Amount (LCY)" := JobJnlLine2."Line Discount Amount (LCY)";
            JobLedgEntry."Line Discount Amount" := JobJnlLine2."Line Discount Amount";
        end;

        JobLedgEntry."Additional-Currency Total Cost" := -JobLedgEntry."Additional-Currency Total Cost";
        JobLedgEntry."Add.-Currency Total Price" := -JobLedgEntry."Add.-Currency Total Price";
        JobLedgEntry."Add.-Currency Line Amount" := -JobLedgEntry."Add.-Currency Line Amount";

        JobLedgEntry."Entry No." := NextEntryNo;
        JobLedgEntry."No. Series" := JobJnlLine2."Posting No. Series";
        JobLedgEntry."Original Unit Cost (LCY)" := JobLedgEntry."Unit Cost (LCY)";
        JobLedgEntry."Original Total Cost (LCY)" := JobLedgEntry."Total Cost (LCY)";
        JobLedgEntry."Original Unit Cost" := JobLedgEntry."Unit Cost";
        JobLedgEntry."Original Total Cost" := JobLedgEntry."Total Cost";
        JobLedgEntry."Original Total Cost (ACY)" := JobLedgEntry."Additional-Currency Total Cost";

        //POINTAGE
        JobLedgEntry."Attached to Ledger Entry No." := JobJnlLine2."Attached to Line No.";
        if JobLedgEntry."Attached to Ledger Entry No." <> 0 then
            JobJnlLine."Attached to Ledger Entry No." := JobLedgEntry."Entry No.";
        JobLedgEntry."Vendor No." := JobJnlLine."Vendor No.";
        JobLedgEntry."Work Time Type" := JobJnlLine."Work Time Type";
        //MIGR
        //  JobLedgEntry."Sales Document No." := JobJnlLine2."Sales Document No.";
        //  JobLedgEntry."Sales Line No." := JobJnlLine2."Sales Line No.";
        //MIGR//
        //#4752
        JobLedgEntry."Job Task No." := JT."Job Task No.";
        //#4752//
        //POINTAGE//
        //+REP+
        if gAddOnLicencePermission.HasPermissionREP then
            JobLedgEntry."Analytical Distribution" := lAnalDistribMgt.GetDistribEntriesBufFromJob(JobJnlLine);
        //#8781
        JobLedgEntry."Job Posting Group" := Job."Job Posting Group";
        //#8781//
        //+REP+//

        //PROJET_FG
        if (JobLedgEntry."Entry Type" = JobLedgEntry."entry type"::Usage)
          and not JobLedgEntry."Analytical Distribution" then
            wOverhead.JobLedgerEntry(JobLedgEntry);
        //PROJET_FG//

        //REVERSE
        JobLedgEntry."G/L Entry No." := JobJnlLine2."G/L Entry No.";
        //REVERSE//
        //IC
        JobLedgEntry."To Company" := '';
        if JobJnlLine2."IC Job Ledg. Entry No." <> 0 then begin
            lJobLedgEntry.ChangeCompany(JobJnlLine2."From Company");
            if lJobLedgEntry.Get(JobJnlLine2."IC Job Ledg. Entry No.") then begin
                if lJobLedgEntry."IC Job Ledg. Entry No." <> 0 then
                    Error(ErrIC, JobJnlLine2."Line No.", JobJnlLine2."Job No.");
                lJobLedgEntry."IC Job Ledg. Entry No." := JobLedgEntry."Entry No.";
                lJobLedgEntry.Modify;
            end;
        end
        else
            JobLedgEntry."To Company" := JobJnlLine2."From Company";
        //IC//

        //#4549
        //ABSENCE
        JobLedgEntry."Employee Absence Entry No." := JobJnlLine2."Employee Absence Entry No.";
        if (JobLedgEntry.Type = JobLedgEntry.Type::Resource) and (JobLedgEntry."Employee Absence Entry No." = 0) then begin
            lPlanningEntry.SetCurrentkey(Type, "No.", Date);
            lPlanningEntry.SetRange(Type, lPlanningEntry.Type::Person);
            lPlanningEntry.SetRange("No.", JobLedgEntry."No.");
            lPlanningEntry.SetRange(Date, JobLedgEntry."Posting Date");
            lPlanningEntry.SetFilter("Employee Absence Entry No.", '<>%1&<>%2', 0, JobJnlLine2."Employee Absence Entry No.");
            if not lPlanningEntry.IsEmpty then begin
                if not Confirm(StrSubstNo(tEmployeeAbs, JobLedgEntry."No.", JobLedgEntry."Posting Date"), true) then
                    Error('');
            end;
        end;
        //ABSENCE//
        //#4549//
        //DESCRIPTION
        lDescriptionLine.CopyLines(Database::"Job Journal Line", 0, JobJnlLine."Journal Template Name" + JobJnlLine."Journal Batch Name",
                                   JobJnlLine."Line No.", Database::"Job Ledger Entry", 0, '', JobLedgEntry."Entry No.");
        //DESCRIPTION//

        with JobJnlLine2 do
            case Type of
                Type::Resource:
                    begin
                        if "Entry Type" = "entry type"::Usage then begin
                            if ResLedgEntry.FindLast then begin
                                JobLedgEntry."Ledger Entry Type" := JobLedgEntry."ledger entry type"::Resource;
                                JobLedgEntry."Ledger Entry No." := ResLedgEntry."Entry No.";
                            end;
                        end;
                    end;
                Type::Item:
                    begin
                        JobLedgEntry."Ledger Entry Type" := JobJnlLine2."ledger entry type"::Item;
                        JobLedgEntry."Ledger Entry No." := JobJnlLine2."Ledger Entry No.";
                        JobLedgEntry."Serial No." := JobJnlLine2."Serial No.";
                        JobLedgEntry."Lot No." := JobJnlLine2."Lot No.";
                    end;
                Type::"G/L Account":
                    begin
                        JobLedgEntry."Ledger Entry Type" := JobLedgEntry."ledger entry type"::" ";
                        if GLEntryNo > 0 then begin
                            JobLedgEntry."Ledger Entry Type" := JobLedgEntry."ledger entry type"::"G/L Account";
                            JobLedgEntry."Ledger Entry No." := GLEntryNo;
                        end;
                    end;
            end;
        if JobLedgEntry."Entry Type" = JobLedgEntry."entry type"::Sale then begin
            JobLedgEntry."Serial No." := JobJnlLine2."Serial No.";
            JobLedgEntry."Lot No." := JobJnlLine2."Lot No.";
        end;

        //PLANNING
        //#8225
        JobLedgEntry."Project Header No." := JobJnlLine2."Project Header No.";
        //#8225//
        JobLedgEntry."Planning Task No." := JobJnlLine2."Planning Task No.";
        //PLANNING//

        JobLedgEntry.Insert;

        JobReg."To Entry No." := NextEntryNo;
        JobReg.Modify;

        if not (JobLedgEntry."Entry Type" = JobLedgEntry."entry type"::Sale) then
            JobPostLine.InsertPlLineFromLedgEntry(JobLedgEntry);

        /* GL2024  DimMgt.MoveJnlLineDimToLedgEntryDim(
            TempJnlLineDim, Database::"Job Ledger Entry", JobLedgEntry."Entry No.");
          NextEntryNo := NextEntryNo + 1;*/

        exit(JobLedgEntry."Entry No.");

    end;

    local procedure SetCurrency(JobJnlLine: Record "Job Journal Line")
    begin
        if JobJnlLine."Currency Code" = '' then begin
            Clear(Currency);
            Currency.InitRoundingPrecision
        end else begin
            Currency.Get(JobJnlLine."Currency Code");
            Currency.TestField("Amount Rounding Precision");
            Currency.TestField("Unit-Amount Rounding Precision");
        end;
    end;


    procedure SetGLEntryNo(GLEntryNo2: Integer)
    begin
        GLEntryNo := GLEntryNo2;
    end;


    procedure gSetJobItemOnSalesLink(var pInvValueEntry: Record "Value Entry"; pJobJnlLine: Record "Job Journal Line"; var pJobJnlLine2: Record "Job Journal Line")
    var
        lShipValueEntry: Record "Value Entry";
        lFromItemLedgEntry: Record "Item Ledger Entry";
        lJobLedgEntry2: Record "Job Ledger Entry";
    begin
        with pJobJnlLine do begin
            lShipValueEntry.SetCurrentkey("Job No.", "Job Task No.", "Document No.");
            if pInvValueEntry."Item Ledger Entry Type" = pInvValueEntry."item ledger entry type"::Sale then
                lFromItemLedgEntry.SetRange("Entry No.", pInvValueEntry."Item Ledger Entry No.")
            else
                lFromItemLedgEntry.SetRange("Applies-to Entry", pInvValueEntry."Item Ledger Entry No.");

            lShipValueEntry.SetRange("Job No.", "Job No.");
            lShipValueEntry.SetRange("Job Task No.", "Job Task No.");
            lShipValueEntry.SetRange("Document No.", "Document No.");
            lShipValueEntry.SetFilter("Job Ledger Entry No.", '= 0');

            if lFromItemLedgEntry.FindFirst and (lFromItemLedgEntry."Entry Type" = lFromItemLedgEntry."entry type"::Sale) then begin
                lShipValueEntry.SetRange("Document No.", lFromItemLedgEntry."Document No.");
                lShipValueEntry.SetRange("Item Ledger Entry Type", lShipValueEntry."item ledger entry type"::Sale);
                lShipValueEntry.SetRange("Item Ledger Entry No.", lFromItemLedgEntry."Entry No.");
                //    lItemEntryNo := lFromItemLedgEntry."Entry No.";
                if lShipValueEntry.FindFirst then begin
                    //      IF lFromItemLedgEntry.GET(lShipValueEntry."Item Ledger Entry No.") THEN BEGIN
                    //      lJobLedgEntry2.SETRANGE("Ledger Entry Type",lJobLedgEntry2."Ledger Entry Type"::Item);
                    //      lJobLedgEntry2.SETRANGE("Ledger Entry No.",lFromItemLedgEntry."Entry No.");
                    // The following code is only to secure that JLEs created at receipt in version 6.0 or earlier,
                    // are not created again at point of invoice (6.0 SP1 and newer).
                    //      IF NOT(lJobLedgEntry2.FINDFIRST) OR NOT (lJobLedgEntry2.Quantity = -lFromItemLedgEntry.Quantity) THEN BEGIN
                    pJobJnlLine2."Serial No." := lFromItemLedgEntry."Serial No.";
                    pJobJnlLine2."Lot No." := lFromItemLedgEntry."Lot No.";
                    if pInvValueEntry."Item Ledger Entry Type" = pInvValueEntry."item ledger entry type"::Sale then
                        pJobJnlLine2.Validate(Quantity, -pInvValueEntry."Valued Quantity" / "Qty. per Unit of Measure")
                    else
                        pJobJnlLine2.Validate(Quantity, pInvValueEntry."Invoiced Quantity" / "Qty. per Unit of Measure");
                    pJobJnlLine2."Ledger Entry Type" := pJobJnlLine2."ledger entry type"::Item;
                    pJobJnlLine2."Ledger Entry No." := lShipValueEntry."Item Ledger Entry No.";
                    pInvValueEntry."Job Ledger Entry No." := CreateJobLedgEntry(pJobJnlLine2);
                    pInvValueEntry.Modify(true);
                    //      END;
                    //      END;
                end;
            end;
        end;
    end;
}

