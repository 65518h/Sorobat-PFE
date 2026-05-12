Codeunit 8004168 "Job Jnl.-Check Line2"
{
    // //RES_USAGE\\
    // //USEREXIT MB 21/09/06 Lancement du codeunit "Job User Exit" dans RunCheck
    // //+ONE+JOB GESWAY 01/11/01 CheckJobJnlLine
    //                   14/12/07

    TableNo = "Job Journal Line";

    trigger OnRun()
    var
    //GL2024    TempJnlLineDim: Record 356 temporary;
    begin
        //RES_USAGE
        /* GL2024     gPlanningSetup.Get;
              //RES_USAGE//
              GLSetup.Get;
              if rec."Shortcut Dimension 1 Code" <> '' then begin
                  TempJnlLineDim."Table ID" := Database::"Job Journal Line";
                  TempJnlLineDim."Journal Template Name" := rec."Journal Template Name";
                  TempJnlLineDim."Journal Batch Name" := rec."Journal Batch Name";
                  TempJnlLineDim."Journal Line No." := rec."Line No.";
                  TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
                  TempJnlLineDim."Dimension Value Code" := rec."Shortcut Dimension 1 Code";
                  TempJnlLineDim.Insert;
              end;
              if rec."Shortcut Dimension 2 Code" <> '' then begin
                  TempJnlLineDim."Table ID" := Database::"Job Journal Line";
                  TempJnlLineDim."Journal Template Name" := rec."Journal Template Name";
                  TempJnlLineDim."Journal Batch Name" := rec."Journal Batch Name";
                  TempJnlLineDim."Journal Line No." := rec."Line No.";
                  TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
                  TempJnlLineDim."Dimension Value Code" := rec."Shortcut Dimension 2 Code";
                  TempJnlLineDim.Insert;
              end;
              RunCheck(Rec, TempJnlLineDim);*/
    end;

    var
        Text000: label 'cannot be a closing date.';
        Text001: label 'is not within your range of allowed posting dates.';
        Text002: label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        Text003: label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        Location: Record Location;
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        Text004: label 'You must post more usage or credit the sale of %1 %2 in %3 %4 before you can post job journal %5 %6 = %7.';
        gPlanningSetup: Record "Planning Setup";


    procedure RunCheck(var JobJnlLine: Record "Job Journal Line"; var JnlLineDim: Record "Dim. Value per Account")
    var
        Job: Record Job;
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    //GL2024   gCheckJobJnlLine: Codeunit ApplicationManagement;
    begin
        with JobJnlLine do begin
            if EmptyLine then
                exit;
            //RES_USAGE
            if (Type <> Type::Resource) and ("Entry Type" = "entry type"::Usage) then
                //RES_USAGE//
                TestField("Job No.");
            // TESTFIELD("Job Task No.");
            TestField("No.");
            TestField("Posting Date");
            //#7722
            if ((not fHasTransfertJournal("Journal Template Name", "Journal Batch Name")) and (not "Bal. Created Entry")) then begin
                //#4751
                //IF NOT "Bal. Created Entry" THEN
                //#4751//
                TestField(Quantity);
                //RES_USAGE
                if "Job No." <> '' then begin
                    //RES_USAGE//
                    Job.Get("Job No.");
                    Job.TestField(Status, Job.Status::Open);
                    //RES_USAGE
                end;
            end;
            //RES_USAGE//
            //#7722//
            //+ONE+JOB
            if "Job No." <> '' then
                Codeunit.Run(Codeunit::"Job Jnl.-Check Line NaviOne", JobJnlLine);
            //+ONE+JOB//

            if NormalDate("Posting Date") <> "Posting Date" then
                FieldError("Posting Date", Text000);

            if ("Document Date" <> 0D) and ("Document Date" <> NormalDate("Document Date")) then
                FieldError("Document Date", Text000);

            if DateNotAllowed("Posting Date") then
                FieldError("Posting Date", Text001);

            /*  //GL2024  if not DimMgt.CheckJnlLineDimComb(JnlLineDim) then
                   Error(
                     Text002,
                     TableCaption, "Journal Template Name", "Journal Batch Name", "Line No.",
                     DimMgt.GetDimCombErr);*/

            TableID[1] := Database::Job;
            No[1] := "Job No.";
            TableID[2] := DimMgt.TypeToTableID2(Type);
            No[2] := "No.";
            TableID[3] := Database::"Resource Group";
            No[3] := "Resource Group No.";
            /*  //GL2024if not DimMgt.CheckJnlLineDimValuePosting(JnlLineDim, TableID, No) then begin
                 if "Line No." <> 0 then
                     Error(
                       Text003,
                       TableCaption, "Journal Template Name", "Journal Batch Name", "Line No.",
                       DimMgt.GetDimValuePostingErr);
                 Error(DimMgt.GetDimValuePostingErr);
             end;*/

            if Type = Type::Item then begin
                if ("Quantity (Base)" < 0) and ("Entry Type" = "entry type"::Usage) then
                    CheckItemQuantityJobJnl(JobJnlLine);
                GetLocation("Location Code");
                if Location."Directed Put-away and Pick" then
                    TestField("Bin Code", '')
                else
                    if Location."Bin Mandatory" then
                        TestField("Bin Code");
            end;
            if "Line Type" in ["line type"::Billable, "line type"::"Both Budget and Billable"] then
                TestField(Chargeable, true);
            //RES_USAGE
            gPlanningSetup.Get;
            if gPlanningSetup."Work Type Code Required" and (Type = Type::Resource) and ("Entry Type" = "entry type"::Usage) then
                TestField("Work Type Code");
            //RES_USAGE//
            //USEREXIT
            if "Job No." <> '' then
                Codeunit.Run(Codeunit::"WorkTime User Exit");
            //USEREXIT//
        end;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;


    procedure DateNotAllowed(PostingDate: Date): Boolean
    begin
        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if UserId <> '' then
                if UserSetup.Get(UserId) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;
            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                GLSetup.Get;
                AllowPostingFrom := GLSetup."Allow Posting From";
                AllowPostingTo := GLSetup."Allow Posting To";
            end;
            if AllowPostingTo = 0D then
                AllowPostingTo := 99991231D;
        end;
        exit((PostingDate < AllowPostingFrom) or (PostingDate > AllowPostingTo));
    end;

    local procedure CheckItemQuantityJobJnl(var JobJnlline: Record "Job Journal Line")
    var
        Item: Record Item;
        Job: Record Job;
        JobLedgEntry: Record "Job Ledger Entry";
        QtyBase: Decimal;
        NoLedgerEntries: Boolean;
    begin
        //+ONE+JOB (#5362)
        /*Supprimé
        Job.GET(JobJnlline."Job No.");
        IF (Job.GetQuantityAvailable(JobJnlline."No.",JobJnlline."Location Code",JobJnlline."Variant Code",0,2) +
            JobJnlline."Quantity (Base)") < 0 THEN
          ERROR(
            Text004,Item.TABLECAPTION,JobJnlline."No.",Job.TABLECAPTION,
            JobJnlline."Job No.",JobJnlline."Journal Batch Name",
            JobJnlline.FIELDCAPTION("Line No."),JobJnlline."Line No.");
        */
        //+ONE+JOB//

    end;


    procedure fHasTransfertJournal(pTemplateName: Code[10]; pFSName: Code[10]) Retour: Boolean
    var
        lJobJnlBatch: Record "Job Journal Batch";
    begin
        //#7722
        /***
         * Return true, if the Job Journal Batch which the name in parameter
         * and the template name
         * have a Transfert Job Journal Batch
         *
         * @param pTemplateName Template Name of the Job Journal Batch
         * @param pFSName       Name of the Job Journal Batch
         * @return              True, if the the Job Journal Batch have
         *                      a transfert Job Journal Batch
         *                      False otherwise
        **/
        Retour := false;
        if (lJobJnlBatch.Get(pTemplateName, pFSName)) then begin
            Retour := lJobJnlBatch."Transfer Journal Name" <> ''
        end;
        //#7722//

    end;
}

