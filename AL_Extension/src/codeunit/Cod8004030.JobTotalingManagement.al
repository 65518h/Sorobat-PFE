Codeunit 8004030 "Job Totaling Management"
{
    // //JOB_TOTALING CW 24/10/05 Create sub-job
    //                MB 08/01/07 Modification de createsubjob, ajout du parametre pSubJobNo

    TableNo = Job;

    trigger OnRun()
    begin
    end;

    var
        tDontMatch: label 'doesn''t match sub-job mask %1';


    procedure CreateSubJob(var pRec: Record Job; pSubJobNo: Code[20])
    var
        i: Integer;
        lRec: Record Job;
        lJobsSetup: Record "Jobs Setup";
        liCpt: Integer;
        lOldpRec: Record Job;
        ltest: array[4] of Char;
        lJob: Record Job;
        lJobNo: Code[20];
        lJobStatus: Record "Job Status";
    begin
        if pSubJobNo <> '' then
            if (pSubJobNo[StrLen(pSubJobNo)] = '.') then
                repeat
                    pSubJobNo := CopyStr(pSubJobNo, 1, StrLen(pSubJobNo) - 1);
                until (pSubJobNo[StrLen(pSubJobNo)] <> '.');

        if (pRec."No." = pSubJobNo) then
            exit;

        if lJob.Get(pSubJobNo) then
            exit;

        with pRec do begin
            //#4024
            lOldpRec.Get("No.");
            //#5646
            //  lOldpRec.Summarize := TRUE;
            lOldpRec.Validate(Summarize, true);
            //#5646//
            lOldpRec.Modify;
            lJobsSetup.Get;
            //#4024
            Validate(Summarize, false);
            TestField("No.");
            //JOB_TOTALING
            if pSubJobNo = '' then begin
                //JOB_TOTALING//
                //#4024    lJobsSetup.GET;
                lJobsSetup.TestField("Sub-Job Format");
                //#3846
                if CopyStr(lJobsSetup."Sub-Job Format", 1, 1) = '*' then begin
                    i := StrLen("No.");
                    if (lJobsSetup."Sub-Job Format"[2] <> '.') then
                        FieldError("No.", StrSubstNo(tDontMatch, lJobsSetup."Sub-Job Format"));
                    lRec."No." := "No." + '.';
                    i += 1;
                    liCpt := 3;
                    while (i < MaxStrLen("No.")) and (lJobsSetup."Sub-Job Format"[liCpt] = '?') do begin
                        i += 1;
                        liCpt += 1;
                        lRec."No."[i] := '?';
                    end;
                end else begin
                    //#3846//
                    i := StrLen("No.");
                    if (i >= StrLen(lJobsSetup."Sub-Job Format")) or
                       (lJobsSetup."Sub-Job Format"[i + 1] <> '.') then
                        FieldError("No.", StrSubstNo(tDontMatch, lJobsSetup."Sub-Job Format"));
                    lRec."No." := "No." + CopyStr(lJobsSetup."Sub-Job Format", i + 1, 1);
                    i += 1;
                    while (i < MaxStrLen("No.")) and (lJobsSetup."Sub-Job Format"[i + 1] = '?') do begin
                        i += 1;
                        lRec."No."[i] := '?';
                    end;
                    //#3846
                end;
                //#3846//
                lRec.SetFilter("No.", lRec."No.");
                if not lRec.Find('+') then
                    lRec."No." := ConvertStr(lRec."No.", '?', '0');
                //#6937
                lRec."No." := fValidateJobNo(lRec."No.", lRec.GetFilter("No."));
                //#6937//
                Validate("No.", IncStr(lRec."No."));
                //JOB_TOTALING
            end else begin
                Validate("No.", pSubJobNo);
                //#3346
                for i := StrLen(pSubJobNo) downto 1 do
                    if pSubJobNo[i] = '.' then begin
                        lJobNo := CopyStr(pSubJobNo, 1, i - 1);
                        i := 1;
                    end;
                if (lJobNo <> '') and (lJobNo <> lOldpRec."No.") then begin
                    if lJob.Get(lJobNo) then begin
                        lJob.Validate(Summarize, true);
                        lJob.Modify;
                    end;
                end;
                //#3346//
            end;
            //JOB_TOTALING//
            //#4024
            Status := 0;
            "Job Status" := lJobsSetup."Default Sub-Job Status";
            if lJobStatus.Get("Job Status") then
                Status := lJobStatus.Status;
            //#4024
            //  Summarize := STRLEN("No.") < STRLEN(lJobsSetup."Sub-Job Format");
            Clear("Search Description");
            //#6937
            Validate(Description);
            //#6937//
            //#6751
            //  CLEAR(Description);
            //#6751//
            //#4026  CLEAR("Description 2");
            Clear("Last Date Modified");
            Insert(true);
            //#6751
            fCopySalesContributor(lOldpRec, pRec)
            //#6751//
        end;
    end;


    procedure SetTotaling(pNo: Code[20]): Text[50]
    var
        lNavibatSetup: Record NavibatSetup;
    begin
        if not lNavibatSetup.GET2 then
            exit;

        if (pNo = lNavibatSetup."Tot. Gen. Prod. Posting Group") or (pNo = '') then
            exit('..' + lNavibatSetup."Totalisation Character")
        else
            exit(pNo + ' ..' + pNo + lNavibatSetup."Totalisation Character");
    end;


    procedure fCopySalesContributor(pFromJob: Record Job; pToJob: Record Job)
    var
        lFromSalesContribtor: Record "Sales Contributor";
        lToSalesContributor: Record "Sales Contributor";
    begin
        //#6751
        lFromSalesContribtor.SetRange("Document Type", lFromSalesContribtor."document type"::Quote);
        lFromSalesContribtor.SetFilter("Document No.", '');
        lFromSalesContribtor.SetRange("Job No.", pFromJob."No.");
        if lFromSalesContribtor.Find('-') then begin
            repeat
                lToSalesContributor := lFromSalesContribtor;
                lToSalesContributor."Job No." := pToJob."No.";
                lToSalesContributor.Insert;
            until lFromSalesContribtor.Next = 0;
        end;
    end;


    procedure fValidateJobNo(pJobNo: Code[20]; pJobFilter: Code[20]) retour: Code[20]
    var
        lJob: Record Job;
    begin
        //#6937
        retour := pJobNo;
        if (IncStr(pJobNo) = '') then begin
            // il ya un probleme, on ne peut pas créer un sous job
            retour := ConvertStr(pJobFilter, '?', '0');
            lJob.SetFilter("No.", pJobFilter);
            if (not lJob.IsEmpty()) then begin
                lJob.Find('-');
                // ON peut parcourir et verifier s'il n'ya pas un code plus adequate
                repeat
                    if (IncStr(lJob."No.") <> '') then
                        retour := lJob."No.";
                until (lJob.Next() = 0)
            end;
        end;
        //#6937//
    end;
}

