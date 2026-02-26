Codeunit 8003503 "Analytical Distrib.Integr."
{
    // //+REP+ GESWAY 01/12/01
    //     *DeleteAnaDistribFromGen* Suppression des Tables Tampon répartition sur une ligne journal comptable
    //     *DeleteAnaDistribLinesFromGen* Suppression des écritures dans les tables tampon sur plusieurs ligne journal comptable
    //     *DeleteAnaDistribFromJob* Suppression des Tables Tampon répartition sur une ligne journal Affaire
    //     *DeleteAnaDistribLinesFromJob* Suppression des écritures dans les tables tampon sur plusieurs ligne journal Affaire

    Permissions = TableData "G/L Entry" = rm;

    trigger OnRun()
    begin
    end;


    procedure DeleteAnaDistribFromGen(var pRec: Record "Gen. Journal Line"; pPosting: Boolean)
    var
        lReparties: Record "Distributed Entries Buffer";
        lGLEntry: Record "G/L Entry";
        lDistributionSetup: Record "Analytical Distribution Setup";
    //GL2024 NAVIBAT    lDistribution: Report 8003500;
    begin
        if lDistributionSetup.Get then
            if (pRec."Journal Template Name" = lDistributionSetup."Gen Ledger Jnl Template Name") and
               (pRec."Journal Batch Name" = lDistributionSetup."Gen Ledger Journal Batch Name") then begin
                lReparties.SetRange(Type, lReparties.Type::"G/L Journal");
                lReparties.SetRange("Entry no.", pRec."Line No.");
                lReparties.SetRange("Journal Template Name", pRec."Journal Template Name");
                lReparties.SetRange("Journal Batch Name", pRec."Journal Batch Name");
                lReparties.DeleteAll;
                if not pPosting then begin   //Suppression à partir de la feuille de saisie
                    lReparties.SetRange("Entry no.");
                    lReparties.SetRange(Type, lReparties.Type::"General Ledger");
                    lReparties.SetRange("Document No.", pRec."Document No.");
                    if not lReparties.IsEmpty then
                        lReparties.DeleteAll(true);
                end else begin               //Suppression suite à la validation de la feuille de saisie
                    lReparties.SetRange("Entry no.");
                    lReparties.SetRange(Type, lReparties.Type::"General Ledger");
                    if not lReparties.IsEmpty then begin
                        lReparties.FindSet(true, false);
                        repeat
                            lGLEntry.Get(lReparties."Entry no.");
                            lGLEntry."Analytical Distribution" := true;
                            lGLEntry.Modify;
                        until lReparties.Next = 0;
                        lReparties.DeleteAll(true);
                    end;
                end;
            end;
    end;


    procedure DeleteAnaDistribLinesFromGen(var pRec: Record "Gen. Journal Line"; pPosting: Boolean)
    begin
        if not pRec.IsEmpty then begin
            pRec.FindSet(true, false);
            repeat
                DeleteAnaDistribFromGen(pRec, pPosting);
            until pRec.Next = 0;
        end;
    end;


    procedure DeleteAnaDistribFromJob(var pRec: Record "Job Journal Line"; pPosting: Boolean)
    var
        lReparties: Record "Distributed Entries Buffer";
        lGLEntry: Record "G/L Entry";
        lDistributionSetup: Record "Analytical Distribution Setup";
        //GL2024 NAVIBAT   lDistribution: Report 8003500;
        lJobEntry: Record "Job Ledger Entry";
    begin
        lReparties.SetRange(Type, lReparties.Type::"Job Journal");
        lReparties.SetRange("Entry no.", pRec."Line No.");
        lReparties.SetRange("Journal Template Name", pRec."Journal Template Name");
        lReparties.SetRange("Journal Batch Name", pRec."Journal Batch Name");
        if not lReparties.IsEmpty then
            lReparties.DeleteAll;
        if not pPosting then begin   //Suppression à partir de la feuille de saisie
            lReparties.SetRange("Entry no.");
            lReparties.SetRange(Type, lReparties.Type::Job);
            lReparties.SetRange("Document No.", pRec."Document No.");
            if not lReparties.IsEmpty then
                lReparties.DeleteAll(true);
        end else begin               //Suppression suite à la validation de la feuille de saisie
            lReparties.SetRange("Entry no.");
            lReparties.SetRange(Type, lReparties.Type::Job);
            lReparties.SetFilter("Document No.", '%1|%2', pRec."Document No.", '');
            if not lReparties.IsEmpty then begin
                lReparties.FindSet(true, false);
                repeat
                    lJobEntry.Get(lReparties."Entry no.");
                    lJobEntry."Analytical Distribution" := true;
                    lJobEntry.Modify;
                until lReparties.Next = 0;
                lReparties.DeleteAll(true);
            end;
            lReparties.SetRange(Type, lReparties.Type::"General Ledger");
            if not lReparties.IsEmpty then begin
                lReparties.FindSet(true, false);
                repeat
                    lGLEntry.Get(lReparties."Entry no.");
                    lGLEntry."Analytical Distribution" := true;
                    lGLEntry.Modify;
                until lReparties.Next = 0;
                lReparties.DeleteAll(true);
            end;
        end;
    end;


    procedure DeleteAnaDistribLinesFromJob(var pRec: Record "Job Journal Line"; pPosting: Boolean)
    begin
        if not pRec.IsEmpty then begin
            pRec.FindSet(true, false);
            repeat
                DeleteAnaDistribFromJob(pRec, pPosting);
            until pRec.Next = 0;
        end;
    end;


    procedure GetDistribEntriesBufFromGen(var pRec: Record "Gen. Journal Line") Return: Boolean
    var
        lAnalyticalSetup: Record "Analytical Distribution Setup";
        lDistributedEntriesBuffer: Record "Distributed Entries Buffer";
        lAnalytical: Boolean;
    begin
        if lAnalyticalSetup.Get then begin
            if (pRec."Journal Template Name" = lAnalyticalSetup."Gen Ledger Jnl Template Name") and
               (pRec."Journal Batch Name" = lAnalyticalSetup."Gen Ledger Journal Batch Name") then begin
                lDistributedEntriesBuffer.SetRange(Type, lDistributedEntriesBuffer.Type::"G/L Journal");
                lDistributedEntriesBuffer.SetRange("Entry no.", pRec."Line No.");
                lDistributedEntriesBuffer.SetRange("Journal Template Name", pRec."Journal Template Name");
                lDistributedEntriesBuffer.SetRange("Journal Batch Name", pRec."Journal Batch Name");
                Return := not lDistributedEntriesBuffer.IsEmpty;
            end else
                Return := false;
        end else
            Return := false;
    end;


    procedure GetDistribEntriesBufFromJob(var pRec: Record "Job Journal Line") Return: Boolean
    var
        lAnalyticalSetup: Record "Analytical Distribution Setup";
        lDistributedEntriesBuffer: Record "Distributed Entries Buffer";
        lAnalytical: Boolean;
    begin
        if lAnalyticalSetup.Get then begin
            if (pRec."Journal Template Name" = lAnalyticalSetup."Job Jnl Template Name") and
               (pRec."Journal Batch Name" = lAnalyticalSetup."Job Journal Batch Name") then begin
                lDistributedEntriesBuffer.SetRange(Type, lDistributedEntriesBuffer.Type::"Job Journal");
                lDistributedEntriesBuffer.SetRange("Entry no.", pRec."Line No.");
                lDistributedEntriesBuffer.SetRange("Journal Template Name", pRec."Journal Template Name");
                lDistributedEntriesBuffer.SetRange("Journal Batch Name", pRec."Journal Batch Name");
                Return := (not lDistributedEntriesBuffer.IsEmpty);
            end else
                Return := false;
        end else
            Return := false
    end;
}

