Codeunit 8003902 "Create Bal. Job Journal Line"
{
    // //PROJET_CESSION GESWAY 23/05/02 Génération des écritures de contrepartie projet
    //                         31/03/04 Alimentation Ecriture cession

    TableNo = "Job Journal Line";

    trigger OnRun()
    begin
        JobsInternalSaleSetup.GET2;
        //#6087
        if not JobsInternalSaleSetup."Post Balance Job Entry" then
            exit;
        //#6087//
        //TEST-FILTER
        if (rec.GetFilter("Job No.") <> '') then
            Error(Text8003901, rec.FieldCaption("Job No."));
        //TEST-FILTER//

        JobJnlLine.Copy(Rec);
        JobJnlLine.SetRange("Journal Template Name", rec."Journal Template Name");
        JobJnlLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
        Code;
        //Valider les écritures de cession indépendamment des filtres posés
        JobJnlLine.Reset;
        JobJnlLine.SetRange("Journal Template Name", rec."Journal Template Name");
        JobJnlLine.SetRange("Journal Batch Name", rec."Journal Batch Name");
        JobJnlLine.SetRange(Area, '@@');
        Rec.Copy(JobJnlLine);
    end;

    var
        tBalItem: label 'Item Balanced total / %1';
        tBalMachine: label 'Machine Balance / %1';
        JobsInternalSaleSetup: Record NavibatSetup;
        JobJnlLine: Record "Job Journal Line";
        JobJnlLine2: Record "Job Journal Line";
        JobJnlLine3: Record "Job Journal Line";
        TmpJobJnlLine: Record "Job Journal Line" temporary;
        tBalHumanResource: label 'Human Ressource Balance / %1';
        tBalAccount: label 'G/L Account Balance / %1';
        LineNo: Integer;
        FirstLineNo: Integer;
        Qty: Decimal;
        TotalCost: Decimal;
        TotalCostDirect: Decimal;
        JobFilter: Text[250];
        Text8003901: label 'Le filtre sur le champ %1 empèche le bon fonctionnement du programme, veuillez retirer ce filtre du formulaire.';
        TotalCost2: Decimal;

    local procedure "Code"()
    var
        Stop: Boolean;
    begin
        if LineNo = 0 then begin
            JobJnlLine2.SetRange("Journal Template Name", JobJnlLine."Journal Template Name");
            JobJnlLine2.SetRange("Journal Batch Name", JobJnlLine."Journal Batch Name");
            //#7459
            if JobJnlLine2.FindLast then begin
                //  JobJnlLine2.FINDLAST;
                //#7459//
                FirstLineNo := JobJnlLine2."Line No.";
                LineNo := JobJnlLine2."Line No." + 10000;
                //#7459
            end else begin
                FirstLineNo := 10000;
                LineNo := 10000;
            end;
            //#7459//
        end;

        with JobJnlLine2 do begin
            CopyFilters(JobJnlLine);
            SetCurrentkey("Journal Template Name", "Journal Batch Name", "Entry Type", "Job No.", "Posting Date", Type, "No.");
            ModifyAll(Area, '@@');
            if Find('-') then
                repeat
                    SetRange("Job No.", "Job No.");
                    SetRange("Posting Date", "Posting Date");
                    SetRange(Type, Type);
                    SetRange("No.", "No.");
                    SetRange("Job Task No.", "Job Task No.");
                    SetRange("Work Type Code", "Work Type Code");
                    JobJnlLine3.CopyFilters(JobJnlLine2);
                    TmpJobJnlLine.DeleteAll;
                    if not JobJnlLine3.IsEmpty then begin
                        JobJnlLine3.FindSet;
                        repeat
                            TmpJobJnlLine.TransferFields(JobJnlLine3);
                            TmpJobJnlLine."Bal. Job No." := TmpJobJnlLine."Job No.";
                            TmpJobJnlLine."Job No." := SearchBalJobNoFromType(JobJnlLine3);
                            if TmpJobJnlLine."Job No." = '' then
                                TmpJobJnlLine."Job No." := JobJnlLine3."Bal. Job No.";
                            if TmpJobJnlLine."Job No." <> '' then
                                TmpJobJnlLine.Insert;
                        until JobJnlLine3.Next = 0;
                    end;
                    Loop;
                    if FindLast then;
                    Reset;
                    CopyFilters(JobJnlLine);
                    SetCurrentkey("Journal Template Name", "Journal Batch Name", "Entry Type", "Job No.", "Posting Date", Type, "No.");
                    SetFilter("Line No.", '<=%1', FirstLineNo);
                    Stop := not Find('>');
                until Stop = true;
        end;
    end;

    local procedure Loop()
    var
        Stop: Boolean;
    begin
        with TmpJobJnlLine do begin
            if not IsEmpty then begin
                FindSet;
                repeat
                    SetRange("Job No.", "Job No.");
                    if not IsEmpty then begin
                        FindSet;
                        Qty := 0;
                        TotalCost := 0;
                        TotalCost2 := 0;
                        TotalCostDirect := 0;
                        repeat
                            Qty += Quantity;
                            TotalCost += "Total Cost (LCY)";
                            TotalCost2 += "Total Cost";
                            TotalCostDirect += "Direct Unit Cost (LCY)" * Quantity;
                        until Next = 0;
                        InsertJobJnlLine(TmpJobJnlLine);
                        LineNo := LineNo + 10000;
                    end;
                    if FindLast then;
                    Reset;
                until not Find('>');
            end;
        end;
    end;

    local procedure InsertJobJnlLine(FromJobJnlLine: Record "Job Journal Line")
    var
        ToJobJnlLine: Record "Job Journal Line";
        lBalJob: Record Job;
        lResource: Record Resource;
    //GL2024  lToJnllineDim: Record 356;
    //GL2024  lFromJnllineDim: Record 356;
    begin
        ToJobJnlLine.Init;
        ToJobJnlLine."Journal Template Name" := FromJobJnlLine."Journal Template Name";
        ToJobJnlLine."Journal Batch Name" := FromJobJnlLine."Journal Batch Name";
        ToJobJnlLine."Line No." := LineNo;
        ToJobJnlLine.Type := FromJobJnlLine.Type;
        ToJobJnlLine."No." := FromJobJnlLine."No.";
        ToJobJnlLine."Resource Group No." := FromJobJnlLine."Resource Group No.";
        ToJobJnlLine."Gen. Prod. Posting Group" := FromJobJnlLine."Gen. Prod. Posting Group";
        ToJobJnlLine.Validate("Job No.", FromJobJnlLine."Job No.");
        ToJobJnlLine."No." := FromJobJnlLine."No.";
        case FromJobJnlLine.Type of
            FromJobJnlLine.Type::Resource:
                begin
                    if lResource.Get(FromJobJnlLine."No.") and (lResource.Type = lResource.Type::Machine) then
                        ToJobJnlLine.Description := StrSubstNo(tBalMachine, FromJobJnlLine."Bal. Job No.")
                    else
                        ToJobJnlLine.Description := StrSubstNo(tBalHumanResource, FromJobJnlLine."Bal. Job No.");
                end;
            FromJobJnlLine.Type::Item:
                begin
                    ToJobJnlLine.Description := StrSubstNo(tBalItem, FromJobJnlLine."Bal. Job No.");
                end;
            FromJobJnlLine.Type::"G/L Account":
                begin
                    ToJobJnlLine.Description := StrSubstNo(tBalAccount, FromJobJnlLine."Bal. Job No.");
                end;
        end;
        //#3042
        ToJobJnlLine."Posting No. Series" := FromJobJnlLine."Posting No. Series";
        //#3042//
        ToJobJnlLine."Document No." := FromJobJnlLine."Document No.";
        ToJobJnlLine."Posting Date" := FromJobJnlLine."Posting Date";
        ToJobJnlLine."Document Date" := FromJobJnlLine."Posting Date";
        ToJobJnlLine."Work Type Code" := FromJobJnlLine."Work Type Code";
        lBalJob.Get(ToJobJnlLine."Job No.");
        ToJobJnlLine."Job Task No." := lBalJob.gGetDefaultJobTask;
        ToJobJnlLine.Validate("Shortcut Dimension 1 Code", lBalJob."Global Dimension 1 Code");
        ToJobJnlLine.Validate("Shortcut Dimension 2 Code", lBalJob."Global Dimension 2 Code");
        ToJobJnlLine."Bal. Job No." := '';
        ToJobJnlLine.Quantity := 0;
        //#5406 ToJobJnlLine."Quantity (Base)" := Qty;
        ToJobJnlLine."Quantity (Base)" := 0;
        ToJobJnlLine."Total Cost (LCY)" := -TotalCost;
        ToJobJnlLine."Total Cost" := -TotalCost2;
        if Qty <> 0 then begin
            ToJobJnlLine."Unit Cost (LCY)" := -ToJobJnlLine."Total Cost (LCY)" / Qty;
            ToJobJnlLine."Direct Unit Cost (LCY)" := TotalCostDirect / Qty;
            ToJobJnlLine."Unit Cost" := -ToJobJnlLine."Total Cost" / Qty;
        end;
        ToJobJnlLine."Source Currency Total Cost" := ToJobJnlLine."Total Cost (LCY)";
        ToJobJnlLine.Area := '@@';
        ToJobJnlLine."Bal. Created Entry" := true;
        //#5789
        ToJobJnlLine."Shortcut Dimension 1 Code" := FromJobJnlLine."Shortcut Dimension 1 Code";
        ToJobJnlLine."Shortcut Dimension 2 Code" := FromJobJnlLine."Shortcut Dimension 2 Code";
        //#5789//
        if ToJobJnlLine."Total Cost (LCY)" <> 0 then
            ToJobJnlLine.Insert;
        //#5902
        /*GL2024  lFromJnllineDim.SetRange("Table ID", Database::"Job Journal Line");
          lFromJnllineDim.SetRange("Journal Template Name", FromJobJnlLine."Journal Template Name");
          lFromJnllineDim.SetRange("Journal Batch Name", FromJobJnlLine."Journal Batch Name");
          lFromJnllineDim.SetRange("Journal Line No.", FromJobJnlLine."Line No.");
          if not lFromJnllineDim.IsEmpty then begin
              lFromJnllineDim.FindSet(true, true);
              repeat
                  lToJnllineDim.TransferFields(lFromJnllineDim);
                  lToJnllineDim."Journal Line No." := ToJobJnlLine."Line No.";
                  if lToJnllineDim.Insert then;
              until lFromJnllineDim.Next = 0;
          end;*/
        //#5902//
    end;


    procedure SearchBalJobNoFromType(FromJobJnlLine: Record "Job Journal Line") BalJobNo: Code[20]
    var
        Res: Record Resource;
        Location: Record Location;
        Item: Record Item;
        GLAccount: Record "G/L Account";
    begin
        case FromJobJnlLine.Type of
            FromJobJnlLine.Type::Resource:
                begin
                    Res.Get(FromJobJnlLine."No.");
                    BalJobNo := Res."Bal. Job No.";
                    if BalJobNo = '' then
                        BalJobNo := SearchBalJobNoFromProduct(Res."Gen. Prod. Posting Group");
                end;
            FromJobJnlLine.Type::Item:
                begin
                    if Location.Get(FromJobJnlLine."Location Code") then
                        BalJobNo := Location."Bal. Job No.";
                    if BalJobNo = '' then begin
                        Item.Get(FromJobJnlLine."No.");
                        BalJobNo := SearchBalJobNoFromProduct(Item."Gen. Prod. Posting Group");
                    end;
                end;
            FromJobJnlLine.Type::"G/L Account":
                begin
                    GLAccount.Get(FromJobJnlLine."No.");
                    BalJobNo := SearchBalJobNoFromProduct(GLAccount."Gen. Prod. Posting Group");
                end;
        end;
        exit(BalJobNo);
    end;

    local procedure SearchBalJobNoFromProduct(ProductGroup: Code[10]): Code[20]
    var
        GenProductPostingGp: Record "Gen. Product Posting Group";
    begin
        GenProductPostingGp.Get(ProductGroup);
        exit(GenProductPostingGp."Bal. Job No.");
    end;
}

