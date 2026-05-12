Codeunit 8004004 "Prepay Extract Entries"
{
    // //PREPAIE ETP 14/08/99 Batch de calcul (intégre semaine à cheval)
    //           CLA 21/03/02 Vérification que la ressource est un salarié


    trigger OnRun()
    begin
        PrepayBuffer.DeleteAll;
        PrepayResult.DeleteAll;
        Clear(Employee);

        // On calcule la date de début de la semaine à cheval
        // Par défaut, on lit de StartJumpDate à EndDate, et on analyse la date à chaque loi
        StartJumpDate := CalcDate('-JS1', StartDate + 1);
        EndJumpDate := CalcDate('-JS7', EndDate + 1);

        //New calcdate
        StartJumpDate := CalcDate('-FS', StartDate);
        EndJumpDate := CalcDate('+FS', EndDate);

        JobEntry.Reset;
        JobEntry.SetCurrentkey(Type, "No.", "Posting Date", "Job No.", "Work Type Code");
        JobEntry.SetRange(Type, JobEntry.Type::Resource);
        JobEntry.SetRange("Entry Type", JobEntry."entry type"::Usage);
        JobEntry.SetRange("Posting Date", StartJumpDate, EndJumpDate);

        // Si filtre ressource précisé, on l'ajoute
        if ResFilter <> '' then
            JobEntry.SetFilter("No.", ResFilter);

        Window.Open(tWindows1 + tWindows2 + '@2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

        NbrRec := JobEntry.Count;
        if JobEntry.Find('-') then begin
            repeat
                NbrLine += 1;
                Window.Update(2, ROUND(NbrLine / NbrRec * 10000, 1));

                // Vérifie si la ressource est un salarié
                if Employee."Resource No." <> JobEntry."No." then begin
                    Employee.SetRange("Resource No.", JobEntry."No.");
                    isEmployee := Employee.Find('-');
                end;
                //    isEmployee := Employee.GET(JobEntry."No.");

                // Recherche des lois correspondantes
                // On balaie la table des paramétres, en filtrant sur l'écriture projet en cours
                // Si la ligne répond aux filtres de la loi, on la prend et on passe à la loi suivante

                if isEmployee then begin
                    PrepayRule.Reset;
                    PrepayRule.SetCurrentkey("Rule Code", "Line No.");
                    PrepayRule.Ascending(false);
                    PrepayRule.SetRange(Active, true);

                    if PrepayRule.Find('-') then begin
                        repeat
                            JobEntry2.Reset;
                            JobEntry2.SetRange("Entry No.", JobEntry."Entry No.");
                            JobEntry2.SetFilter("Work Type Code", PrepayRule."Work Type Filter");
                            JobEntry2.SetFilter("Job No.", PrepayRule."Job Filter");
                            JobEntry2.SetFilter("Resource Group No.", PrepayRule."Resource Group Filter");
                            JobEntry2.SetFilter("No.", PrepayRule."Resource Filter");

                            if PrepayRule.Frequency = PrepayRule.Frequency::"Jumping Week" then begin
                                if EndJumpDate - 2 > EndDate then begin
                                    JobEntry2.SetRange("Posting Date", StartJumpDate, CalcDate('-FS-1J', EndJumpDate));
                                    if CalcDate('FS', StartJumpDate) - 2 < StartDate then
                                        JobEntry2.SetRange("Posting Date", CalcDate('FS+1J', StartJumpDate), CalcDate('-FS-1J', EndJumpDate))
                                end
                                else begin
                                    JobEntry2.SetRange("Posting Date", StartJumpDate, EndJumpDate);
                                    if CalcDate('FS', StartJumpDate) - 2 < StartDate then
                                        JobEntry2.SetRange("Posting Date", CalcDate('FS+1J', StartJumpDate), EndJumpDate);
                                end;
                            end
                            else
                                JobEntry2.SetRange("Posting Date", StartDate, EndDate);

                            if JobEntry2.Find('-') then begin
                                CreateTmpRec;
                                //PrepayRule.SETRANGE("Rule Code",PrepayRule."Rule Code");
                                //PrepayRule.FIND('+');
                                //PrepayRule.SETRANGE("Rule Code");
                            end;
                        until PrepayRule.Next = 0;
                    end;
                end;
            until JobEntry.Next = 0;
        end;
        Window.Close;
    end;

    var
        PrepayRule: Record "Prepay Rule";
        JobEntry: Record "Job Ledger Entry";
        JobEntry2: Record "Job Ledger Entry";
        PrepayBuffer: Record "Prepay Buffer";
        PrepayResult: Record "Prepay Results";
        Employee: Record Employee;
        Window: Dialog;
        StartDate: Date;
        EndDate: Date;
        StartJumpDate: Date;
        EndJumpDate: Date;
        ResFilter: Text[80];
        NbrExtract: Integer;
        Exception: Boolean;
        isEmployee: Boolean;
        EntryNo: Integer;
        NbrLine: Integer;
        NbrRec: Integer;
        tWindows1: label 'ledger extract in progress';
        tWindows2: label 'Number of extract ledger #1##########\';


    procedure CreateTmpRec()
    begin
        with PrepayBuffer do begin
            Init;
            EntryNo += 10000;
            "Entry No." := EntryNo;
            "Resource No." := JobEntry."No.";
            Quantity := JobEntry.Quantity;
            "Unit Direct Cost" := JobEntry."Direct Unit Cost (LCY)";
            Amount := Quantity * "Unit Direct Cost";
            "Group Resource No." := JobEntry."Resource Group No.";
            "Unit Code" := JobEntry."Unit of Measure Code";
            "Shortcut Dimension 1 Code" := JobEntry."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := JobEntry."Global Dimension 2 Code";
            "Absence Cause Code" := PrepayRule."Cause of prepay code";
            Frequency := PrepayRule.Frequency;
            "Min Value" := PrepayRule."Min Value";
            "Max Value" := PrepayRule."Max Value";
            "Quantity Calculation" := PrepayRule."Quantity Calculation";
            "Rate Calculation" := PrepayRule."Rate Calculation";
            "Amount Calculation" := PrepayRule."Amount Calculation";
            "Quantity Setup" := PrepayRule.Quantity;
            "Rate Setup" := PrepayRule.Rate;
            "Amount Setup" := PrepayRule.Amount;
            Comment := PrepayRule.Comment;
            Regrouping := PrepayRule.Regrouping;
            "Lowest Value" := PrepayRule."Lowest Value";
            "Highest value" := PrepayRule."Highest value";
            "Exclusive Min and Max" := PrepayRule."Exclusive Minima & Maxima";
            "Rule Code" := PrepayRule."Rule Code";
            "Line No." := PrepayRule."Line No.";

            case PrepayRule.Frequency of
                PrepayRule.Frequency::Detail:
                    begin
                        "Starting Date" := JobEntry."Posting Date";
                        "End Date" := JobEntry."Posting Date";
                        "Detail Key" := JobEntry."Entry No.";
                        "Document No." := JobEntry."Document No.";
                        Description := JobEntry.Description;
                    end;
                PrepayRule.Frequency::Day:
                    begin
                        "Starting Date" := JobEntry."Posting Date";
                        "End Date" := JobEntry."Posting Date";
                    end;
                PrepayRule.Frequency::Week:
                    begin
                        //"Starting Date" := CALCDATE('-JS1',JobEntry."Posting Date"+1);
                        //"End Date" := "Starting Date" + 6;
                        "Starting Date" := CalcDate('-FS', JobEntry."Posting Date");
                        //#4141      "End Date" := CALCDATE('+FS',JobEntry."Posting Date");
                        if CalcDate('+FS', JobEntry."Posting Date") <= CalcDate('+FM', JobEntry."Posting Date") then
                            "End Date" := CalcDate('+FS', JobEntry."Posting Date")
                        else
                            "End Date" := CalcDate('+FM', JobEntry."Posting Date");
                    end;
                PrepayRule.Frequency::Month:
                    begin
                        "Starting Date" := CalcDate('-FM', JobEntry."Posting Date");
                        "End Date" := CalcDate('+FM', JobEntry."Posting Date");
                    end;
                PrepayRule.Frequency::"Jumping Week":
                    begin
                        //"Starting Date" := CALCDATE('-JS1',JobEntry."Posting Date"+1);
                        //"End Date" := "Starting Date" + 6;
                        "Starting Date" := CalcDate('-FS', JobEntry."Posting Date");
                        "End Date" := CalcDate('+FS', JobEntry."Posting Date");
                    end;
            end;

            Insert;
            NbrExtract += 1;
            Window.Update(1, NbrExtract);
        end;
    end;


    procedure InitRequest(pStartDate: Date; pEndDate: Date; pResFilter: Text[80])
    begin
        StartDate := pStartDate;
        EndDate := pEndDate;
        ResFilter := pResFilter;
    end;
}

