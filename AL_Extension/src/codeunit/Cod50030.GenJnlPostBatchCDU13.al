codeunit 50030 "Gen. Jnl.-Post Batch_CDU13"
{
    //GL2024 Procédure spécifique de la codeunit standard "Gen. Jnl.-Post Batch" 13


    PROCEDURE wCheckGLAccount(pGenJnlLine: Record "Gen. Journal Line");
    VAR
        lGLAccount: Record "G/L Account";
    BEGIN
        IF ((pGenJnlLine."Account Type" = pGenJnlLine."Account Type"::"G/L Account") AND (pGenJnlLine."Account No." <> ''))
            //#6648
            AND (pGenJnlLine."Posting Date" <> CLOSINGDATE(pGenJnlLine."Posting Date")) THEN BEGIN
            //#6648//
            lGLAccount.SETCURRENTKEY("No.");
            lGLAccount.GET(pGenJnlLine."Account No.");
            // on verifie les choses suivantes :
            //- Le compte doit ˆtre de type gestion
            //- Il doit egalement avoir de cocher l'option "comptabiliser ecr affaire
            //- enfin la valeur du champs "Job No." doit ˆtre Vide
            // si toutes ces conditions sont rempli alors on a une erreur
            IF ((lGLAccount."Income/Balance" = lGLAccount."Income/Balance"::"Income Statement") AND
                (lGLAccount."Post Job Entry") AND
                (pGenJnlLine."Job No." = '')) THEN BEGIN
                ERROR(Text032);
            END;
        END;
    END;
    //HS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnProcessBalanceOfLinesOnAfterCalcShouldCheckDocNoBasedOnNoSeries', '', true, true)]

    local procedure OnProcessBalanceOfLinesOnAfterCalcShouldCheckDocNoBasedOnNoSeries(var GenJournalLine: Record "Gen. Journal Line"; var GenJournalBatch: Record "Gen. Journal Batch"; var ShouldCheckDocNoBasedOnNoSeries: Boolean; var SkipCheckingPostingNoSeries: Boolean)
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        if ShouldCheckDocNoBasedOnNoSeries then
            GenJournalLine.TESTFIELD("Document No.", NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", GenJournalLine."Posting Date", FALSE));
    end;
    //Hs
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnCheckLineOnAfterCheckAllocations', '', true, true)]
    local procedure OnCheckLineOnAfterCheckAllocations(GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlPostBatch_CDU13: Codeunit "Gen. Jnl.-Post Batch_CDU13";
    begin
        //#5045
        GenJnlPostBatch_CDU13.wCheckGLAccount(GenJournalLine);
        //#5045//
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforeIfCheckBalance', '', true, true)]
    local procedure OnBeforeIfCheckBalance(GenJnlTemplate: Record "Gen. Journal Template"; GenJnlLine: Record "Gen. Journal Line"; var LastDocType: Option; var LastDocNo: Code[20]; var LastDate: Date; var CheckIfBalance: Boolean; CommitIsSuppressed: Boolean; var IsHandled: Boolean)
    begin
        if GenJnlLine.Amount <> 0 then begin
            //BE_FINJNL
            IF GenJnlTemplate.Type = GenJnlTemplate.Type::Financial THEN BEGIN
                GenJnlLine.TESTFIELD("Bal. Account No.", GenJnlTemplate."Bal. Account No.");
                GenJnlLine."Balance (LCY)" := 0;
            END;
            //BE_FINJNL//
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnPostAllocationsOnBeforeCopyFromGenJnlAlloc', '', true, true)]
    local procedure OnPostAllocationsOnBeforeCopyFromGenJnlAlloc(var GenJournalLine: Record "Gen. Journal Line"; var AllocateGenJournalLine: Record "Gen. Journal Line"; var Reversing: Boolean)
    begin
        //PROJET
        GenJournalLine."Job No." := AllocateGenJournalLine."Job No.";
        GenJournalLine."Job Task No." := AllocateGenJournalLine."Job Task No.";
        GenJournalLine."Job Quantity" := 1;
        GenJournalLine.VALIDATE("Job Total Cost (LCY)", GenJournalLine."Amount (LCY)");
        //PROJET//
    end;


    var

        Text032: Label 'Please fill in the case number of lines for which the option of the general account "Post Job Entry" is checked.';
        gAddOnLicencePermission: Codeunit IntegrManagement;
}