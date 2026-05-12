Codeunit 8003911 "Job Jnl.-Check Line NaviOne"
{
    // //PROJET     GESWAY 01/11/01 Call from codeunit 1011 "Job Jnl-Check Line"
    // //PROJET_IMMO CLA 21/01/08 Pas de test type = externe pour une immo
    // //POINTAGE   GESWAY 28/05/02 Pas de testfield sur "Job No.", Contrôle sur "Work Type"
    // //STOCK      CLA    10/09/04 Pas de pointage sur une affaire de type stock
    // //JOB_STATUS CW     24/10/05 Check JobStatus

    TableNo = "Job Journal Line";

    trigger OnRun()
    var
        lJobSetup: Record "Jobs Setup";
        lWorkType: Record "Work Type";
        lSetup: Record "Company Information";
        lJob: Record Job;
        lResource: Record Resource;
        lGenJnlTemplate: Record "Gen. Journal Template";
        lJobStatusMgt: Codeunit "Job Status Management";
        lCalendar: Codeunit "Calendar Management";
        lDescription: Text[80];
        lRecordID: RecordID;
        Err001: label '%1 must not be empty in %2 %3 %4 %5 %6 %7.';
    begin
        lJobSetup.Get;
        lJob.Get(rec."Job No.");

        //JOB_STATUS
        lJobStatusMgt.CheckJobJnlLine(Rec);
        //JOB_STATUS//

        //STOCK
        if (rec.Type = rec.Type::Resource) and
           (lJob."Job Type" = lJob."job type"::Stock) then
            Error(lErrorStock);
        //STOCK//

        //#5414
        if rec.Type = rec.Type::Resource then begin
            lResource.Get(rec."No.");
            if (lResource.Type = lResource.Type::"Note of Expenses") then
                exit;
        end;
        //#5414//
        //#8921
        if rec.Type = rec.Type::Resource then begin
            lResource.Get(rec."No.");
            if (lResource.Type = lResource.Type::Service) then
                exit;
        end;
        //#8921//

        //PROJET_IMMO (#5444) : permettre affaire interne ou externe pour immo
        if (rec."Journal Template Name" <> '') and (rec."Entry Type" = rec."entry type"::Sale) and
           (lJob."Job Type" = lJob."job type"::Internal)
        then begin
            lGenJnlTemplate.SetRange(Type, lGenJnlTemplate.Type::Assets);
            lGenJnlTemplate.SetRange(Name, rec."Journal Template Name");
            if lGenJnlTemplate.IsEmpty then
                lJob.TestField("Job Type", lJob."job type"::External)       //Vérifier affaire externe
            else
                rec."Journal Template Name" := '';
        end else
            //PROJET_IMMO//
            if rec."Entry Type" = rec."entry type"::Sale then
                lJob.TestField("Job Type", lJob."job type"::External);       //Vérifier affaire externe

        // Check Work Type Code
        if rec."Entry Type" = rec."entry type"::Sale then begin
            case rec.Type of
                rec.Type::Item:
                    if lJobSetup."Check sale work type code" in [
                         lJobSetup."check sale work type code"::Item,
                         lJobSetup."check sale work type code"::"Item and resource",
                         lJobSetup."check sale work type code"::"Item and Account (G/L)",
                         lJobSetup."check sale work type code"::"Item resource and Account (G/L)"] then
                        rec.TestField("Work Type Code");
                rec.Type::Resource:
                    if lJobSetup."Check sale work type code" in [
                         lJobSetup."check sale work type code"::Resource,
                         lJobSetup."check sale work type code"::"Item and resource",
                         lJobSetup."check sale work type code"::"Resource and Account (G/L)",
                         lJobSetup."check sale work type code"::"Item resource and Account (G/L)"] then
                        rec.TestField("Work Type Code");
                rec.Type::"G/L Account":
                    if lJobSetup."Check sale work type code" in [
                         lJobSetup."check sale work type code"::"Account (G/L)",
                         lJobSetup."check sale work type code"::"Resource and Account (G/L)",
                         lJobSetup."check sale work type code"::"Item and Account (G/L)",
                         lJobSetup."check sale work type code"::"Item resource and Account (G/L)"] then
                        rec.TestField("Work Type Code");
            end;
        end else begin //Type activité
            case rec.Type of
                rec.Type::Item:
                    if lJobSetup."Check usage work type code" in [
                         lJobSetup."check usage work type code"::Item,
                         lJobSetup."check usage work type code"::"Item and resource",
                         lJobSetup."check usage work type code"::"Item and Account (G/L)",
                         lJobSetup."check usage work type code"::"Item resource and Account (G/L)"] then
                        rec.TestField("Work Type Code");
                rec.Type::Resource:
                    if lJobSetup."Check usage work type code" in [
                         lJobSetup."check usage work type code"::Resource,
                         lJobSetup."check usage work type code"::"Item and resource",
                         lJobSetup."check usage work type code"::"Resource and Account (G/L)",
                         lJobSetup."check usage work type code"::"Item resource and Account (G/L)"] then
                        rec.TestField("Work Type Code");
                rec.Type::"G/L Account":
                    if lJobSetup."Check usage work type code" in [
                         lJobSetup."check usage work type code"::"Account (G/L)",
                         lJobSetup."check usage work type code"::"Resource and Account (G/L)",
                         lJobSetup."check usage work type code"::"Item and Account (G/L)",
                         lJobSetup."check usage work type code"::"Item resource and Account (G/L)"] then
                        rec.TestField("Work Type Code");
            end;
        end;

        // Check Gen. Prod. posting Gr.
        if rec."Entry Type" = rec."entry type"::Sale then begin
            case rec.Type of
                rec.Type::Item:
                    if lJobSetup."Check sale prod. posting Gr." in [
                         lJobSetup."check sale prod. posting gr."::Item,
                         lJobSetup."check sale prod. posting gr."::"Item and resource",
                         lJobSetup."check sale prod. posting gr."::"Item and Account (G/L)",
                         lJobSetup."check sale prod. posting gr."::"Item resource and Account (G/L)"] then
                        rec.TestField("Gen. Prod. Posting Group");
                rec.Type::Resource:
                    if lJobSetup."Check sale prod. posting Gr." in [
                         lJobSetup."check sale prod. posting gr."::Resource,
                         lJobSetup."check sale prod. posting gr."::"Item and resource",
                         lJobSetup."check sale prod. posting gr."::"Resource and Account (G/L)",
                         lJobSetup."check sale prod. posting gr."::"Item resource and Account (G/L)"] then
                        rec.TestField("Gen. Prod. Posting Group");
                rec.Type::"G/L Account":
                    if lJobSetup."Check sale prod. posting Gr." in [
                         lJobSetup."check sale prod. posting gr."::"Account (G/L)",
                         lJobSetup."check sale prod. posting gr."::"Resource and Account (G/L)",
                         lJobSetup."check sale prod. posting gr."::"Item and Account (G/L)",
                         lJobSetup."check sale prod. posting gr."::"Item resource and Account (G/L)"] then
                        rec.TestField("Gen. Prod. Posting Group");
            end;
        end else begin //Type activité
            case rec.Type of
                rec.Type::Item:
                    if lJobSetup."Check usage prod. posting Gr." in [
                         lJobSetup."check usage prod. posting gr."::Item,
                         lJobSetup."check usage prod. posting gr."::"Item and resource",
                         lJobSetup."check usage prod. posting gr."::"Item and Account (G/L)",
                         lJobSetup."check usage prod. posting gr."::"Item resource and Account (G/L)"] then
                        rec.TestField("Gen. Prod. Posting Group");
                rec.Type::Resource:
                    if lJobSetup."Check usage prod. posting Gr." in [
                         lJobSetup."check usage prod. posting gr."::Resource,
                         lJobSetup."check usage prod. posting gr."::"Item and resource",
                         lJobSetup."check usage prod. posting gr."::"Resource and Account (G/L)",
                         lJobSetup."check usage prod. posting gr."::"Item resource and Account (G/L)"] then
                        rec.TestField("Gen. Prod. Posting Group");
                rec.Type::"G/L Account":
                    if lJobSetup."Check usage prod. posting Gr." in [
                         lJobSetup."check usage prod. posting gr."::"Account (G/L)",
                         lJobSetup."check usage prod. posting gr."::"Resource and Account (G/L)",
                         lJobSetup."check usage prod. posting gr."::"Item and Account (G/L)",
                         lJobSetup."check usage prod. posting gr."::"Item resource and Account (G/L)"] then
                        rec.TestField("Gen. Prod. Posting Group");
            end;
        end;

        //POINTAGE
        if (rec."Entry Type" = rec."entry type"::Usage) and not rec."Bal. Created Entry" and (rec."Work Type Code" <> '') then begin
            lWorkType.Get(rec."Work Type Code");
            if (lJob."Working Time Mode" <> 0) and (lWorkType."Working Time On Order") then begin
                //MIGR
                //    TESTFIELD("Sales Document No.");
                //    TESTFIELD("Sales Line No.");
                rec.TestField("Job Task No.");
                //#8593
                lRecordID := rec."Source Record ID";
                if lRecordID.TableNo = 0 then
                    Error(Err001,
                      rec.FieldCaption("Source Record ID"),
                      rec.FieldCaption("Journal Template Name"), rec."Journal Template Name",
                      rec.FieldCaption("Journal Batch Name"), rec."Journal Batch Name",
                     rec.FieldCaption("Line No."), rec."Line No.");
                rec.TestField("Source Line No.");
                //#8593//
                //MIGR//
            end;

            if lWorkType."Job Absence No." <> '' then
                rec.TestField("Job No.", lWorkType."Job Absence No.");
            if lWorkType.Holiday then begin
                lSetup.Get;
                lSetup.TestField("Base Calendar Code");
                /* //GL2024  if not lCalendar.CheckDateStatus(lSetup."Base Calendar Code", rec."Posting Date", lDescription) then
                      case Date2dwy(rec."Posting Date", 1) of
                          1:
                              lWorkType.TestField(Monday, true);
                          2:
                              lWorkType.TestField(Tuesday, true);
                          3:
                              lWorkType.TestField(Wednesday, true);
                          4:
                              lWorkType.TestField(Thursday, true);
                          5:
                              lWorkType.TestField(Friday, true);
                          6:
                              lWorkType.TestField(Saturday, true);
                          7:
                              lWorkType.TestField(Sunday, true);
                      end;*/
            end else begin
                case Date2dwy(rec."Posting Date", 1) of
                    1:
                        lWorkType.TestField(Monday, true);
                    2:
                        lWorkType.TestField(Tuesday, true);
                    3:
                        lWorkType.TestField(Wednesday, true);
                    4:
                        lWorkType.TestField(Thursday, true);
                    5:
                        lWorkType.TestField(Friday, true);
                    6:
                        lWorkType.TestField(Saturday, true);
                    7:
                        lWorkType.TestField(Sunday, true);
                end; // CASE
            end;

            if lWorkType."Work Time Type" <> lWorkType."work time type"::" " then begin
                rec.TestField(Type, rec.Type::Resource);
                lResource.Get(rec."No.");
                case lWorkType."Work Time Type" of
                    lWorkType."work time type"::"Producted Hours":
                        ;
                    lWorkType."work time type"::"Absence Hours":
                        begin
                            lJob.TestField("Job Type", lJob."job type"::Internal);
                            lResource.TestField(Type, lResource.Type::Person);
                        end;
                    lWorkType."work time type"::"Unproduced Hours":
                        ;
                    //#5220        lJob.TESTFIELD("Job Type",lJob."Job Type"::Internal);
                    lWorkType."work time type"::Transport,
                  lWorkType."work time type"::Meal:
                        lResource.TestField(Type, lResource.Type::Person);
                end; // CASE
            end;
        end;
        //POINTAGE//

        if (rec.Type = rec.Type::Resource) and (rec."Entry Type" = rec."entry type"::Usage) then
            rec.TestField("Resource Group No.");
    end;

    var
        lErrorStock: label 'You cannot enter a Working time when the Job type is Stock.';
}

