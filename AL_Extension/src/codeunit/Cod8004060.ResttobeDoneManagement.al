Codeunit 8004060 "Rest to be Done Management"
{
    // //UPD_COST CW 14/11/05 Customized code unit


    trigger OnRun()
    begin
    end;

    var
        tTextFilterError: label 'You must specify a Job Task No. Filter';
        tTextIsemptyError: label 'Job Task No. is not valid./ Can you verify the filter';


    procedure CalcNewBudget(var pJob: Record Job; var pGenProdPostGrp: Record "Gen. Product Posting Group")
    var
        lRestToBeDone: Record "Rest To Be Done";
    begin
        with pGenProdPostGrp do begin
            lRestToBeDone.SetRange("Job No.", pJob."No.");
            if Totaling = '' then
                lRestToBeDone.SetRange("Gen. Prod. Posting Group", Code)
            else
                lRestToBeDone.SetFilter("Gen. Prod. Posting Group", Totaling);
            if lRestToBeDone.Find('-') then begin
                lRestToBeDone.CalcSums("New Budget Amount");
                "New Cost Forecast" := lRestToBeDone."New Budget Amount";
                "New Rest To Be Engaged" := "New Cost Forecast" - pGenProdPostGrp."Posted at Date" - pGenProdPostGrp.Engaged;
                "New Budget Difference" := "New Cost Forecast" - "Cost Forecast";
            end else begin
                "New Cost Forecast" := 0;
                "New Rest To Be Engaged" := 0;
                "New Budget Difference" := 0;
            end;
        end;
    end;


    procedure SetNewBudget(pFieldNo: Integer; pJob: Record Job; var pRec: Record "Gen. Product Posting Group")
    var
        lJobTaskNo: Code[20];
        lJob: Record Job;
        lRestToBeDone: Record "Rest To Be Done";
        lExists: Boolean;
        lJobTask: Record "Job Task";
    begin
        with pRec do begin
            TestField(Summarize, false);
            pJob.TestField(Summarize, false);
            //#6105
            lJobTask.SetRange("Job No.", pJob."No.");
            if pRec.GetFilter("Job Task Filter") <> '' then
                lJobTask.SetRange("Job Task No.", pRec.GetFilter("Job Task Filter"));
            if lJobTask.IsEmpty then
                Error(tTextIsemptyError)
            else
                if lJobTask.Count > 1 then
                    Error(tTextFilterError)
                else begin
                    lJobTask.FindFirst;
                    lJobTaskNo := lJobTask."Job Task No.";
                end;

            //#6105//
            CalcFields("Posted Net Change", Engaged, "Cost Forecast");

            case pFieldNo of
                pRec.FieldNo("New Cost Forecast"):
                    ;
                pRec.FieldNo("New Rest To Be Engaged"):
                    "New Cost Forecast" := "Posted Net Change" + Engaged + "New Rest To Be Engaged";
                pRec.FieldNo("New Budget Difference"):
                    "New Cost Forecast" := "Cost Forecast" + "New Budget Difference";
            end;
        end;

        with lRestToBeDone do begin
            "Job No." := pJob."No.";
            "Job Task No." := lJobTaskNo;
            "Gen. Prod. Posting Group" := pRec.Code;
            lExists := Get("Job No.", "Job Task No.", "Gen. Prod. Posting Group");
            lRestToBeDone."New Budget Amount" := pRec."New Cost Forecast";
            if not lExists then
                Insert
            //  ELSE IF lRestToBeDone."New Budget Amount" = 0 THEN
            //    DELETE
            else
                Modify;
        end;
        with pRec do begin
            "New Rest To Be Engaged" := "New Cost Forecast" - "Posted Net Change" - Engaged;
            "New Budget Difference" := "New Cost Forecast" - "Cost Forecast";
        end;
    end;


    procedure fSetNewBudget(pFieldNo: Integer; var pJobTask: Record "Job Task"; var pxRec: Record "Gen. Product Posting Group"; var pRec: Record "Gen. Product Posting Group")
    var
        lPhaseCode: Code[10];
        lJob: Record Job;
        lRestToBeDone: Record "Rest To Be Done";
        lExists: Boolean;
        lJobTaskCode: Code[20];
        lDefJobTaskCode: Code[20];
    begin
        //#6601
        lDefJobTaskCode := fGetDefaultJobTask();
        with pRec do begin
            TestField(Summarize, false);
            if pJobTask."Job Task Type" <> pJobTask."job task type"::Total then
                lJobTaskCode := pJobTask."Job Task No."
            else
                if lJob.Get(pJobTask."Job No.") and (lDefJobTaskCode <> '') then
                    lJobTaskCode := lDefJobTaskCode
                else
                    pJobTask.TestField("Job Task Type", pJobTask."job task type"::Posting);

            //#4696
            //  CALCFIELDS("Posted Net Change",Engaged,"Cost Forecast");
            //#4696//
            CalcFields("Posted at Date", Engaged, "Cost Forecast");

            case pFieldNo of
                pRec.FieldNo("New Cost Forecast"):
                    ;
                pRec.FieldNo("New Rest To Be Engaged"):
                    //#4696
                    //      "New Cost Forecast" := "Posted Net Change" + Engaged + "New Rest To Be Done";
                    //#4696//
                    "New Cost Forecast" := "Posted at Date" + Engaged + "New Rest To Be Engaged";
                pRec.FieldNo("New Budget Difference"):
                    "New Cost Forecast" := "Cost Forecast" + "New Budget Difference";
            end;
        end;

        with lRestToBeDone do begin
            "Job No." := pJobTask."Job No.";
            "Job Task No." := lJobTaskCode;
            "Gen. Prod. Posting Group" := pRec.Code;
            lExists := Get("Job No.", "Job Task No.", "Gen. Prod. Posting Group");
            lRestToBeDone."New Budget Amount" := pRec."New Cost Forecast";
            if not lExists then
                Insert
            //  ELSE IF lRestToBeDone."New Budget Amount" = 0 THEN
            //    DELETE
            else
                Modify;
        end;
        with pRec do begin
            "New Rest To Be Engaged" := "New Cost Forecast" - "Posted Net Change" - Engaged;
            "New Budget Difference" := "New Cost Forecast" - "Cost Forecast";
        end;
        //#6601//
    end;


    procedure fGetDefaultJobTask() Return: Code[20]
    var
        lNavibatSetup: Record NavibatSetup;
        lDataTemplateLine: Record "Config. Template Line";
        lTemplateCode: Code[20];
    begin
        //#6601
        Return := '';
        if (lNavibatSetup.Get()) then begin
            lTemplateCode := lNavibatSetup."Job Task Creation Model";
            lDataTemplateLine.SetRange("Data Template Code", lTemplateCode);
            lDataTemplateLine.SetRange("Field Name", 'Job Task No.');
            if (not lDataTemplateLine.IsEmpty()) then begin
                lDataTemplateLine.Find('-');
                Return := lDataTemplateLine."Default Value";
            end;
        end;
        //#6601//
    end;


    procedure fCalcNewBudget(var pJobTask: Record "Job Task"; var pGenProdPostGrp: Record "Gen. Product Posting Group")
    var
        lRestToBeDone: Record "Rest To Be Done";
    begin
        //#6601
        with pGenProdPostGrp do begin
            lRestToBeDone.SetRange("Job No.", pJobTask."Job No.");
            if pJobTask.Totaling = '' then
                lRestToBeDone.SetRange("Job Task No.", pJobTask."Job Task No.")
            else
                lRestToBeDone.SetFilter("Job Task No.", pJobTask.Totaling);
            if Totaling = '' then
                lRestToBeDone.SetRange("Gen. Prod. Posting Group", Code)
            else
                lRestToBeDone.SetFilter("Gen. Prod. Posting Group", Totaling);
            if lRestToBeDone.Find('-') then begin
                lRestToBeDone.CalcSums("New Budget Amount");
                "New Cost Forecast" := lRestToBeDone."New Budget Amount";
                //#4696
                //    "New Rest To Be Done" := "New Cost Forecast" - pGenProdPostGrp."Posted at Date" - pGenProdPostGrp.Engaged;
                CalcFields("Posted at Date", Engaged, "Cost Forecast");
                "New Rest To Be Engaged" := "New Cost Forecast" - "Posted at Date" - Engaged;
                //#4696//
                "New Budget Difference" := "New Cost Forecast" - "Cost Forecast";
            end else begin
                "New Cost Forecast" := 0;
                "New Rest To Be Engaged" := 0;
                "New Budget Difference" := 0;
            end;
        end;
        //#6601//
    end;
}

