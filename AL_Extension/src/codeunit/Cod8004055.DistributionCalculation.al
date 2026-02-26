Codeunit 8004055 "Distribution Calculation"
{
    // //PLANIFICATION GESWAY 27/05/05 Moteur de calcul de la planification Affaire


    trigger OnRun()
    begin
    end;

    var
        TestRepartition: label 'Distribution in Progress...';
        Fenetre: Dialog;
        Sumcoef: Decimal;


    procedure CalcAmount(pJob: Record Job; pTypeDoc: Integer; pDocNo: Code[20])
    var
        lJobBudgetEntry: Record "Job Planning Line";
        lJobBudgetEntryTemp: Record "Job Planning Line" temporary;
    begin
        if pJob."Distribution Type (Planning)" = 0 then
            exit;


        lJobBudgetEntry.SetCurrentkey("Document Type", "Document No.");
        lJobBudgetEntry.SetRange("Job No.", pJob."No.");
        lJobBudgetEntry.SetRange("Document Type", pTypeDoc);
        lJobBudgetEntry.SetRange("Document No.", pDocNo);
        lJobBudgetEntry.SetFilter("Total Price", '<>0');
        if not lJobBudgetEntry.IsEmpty then begin
            lJobBudgetEntry.Find('-');
            repeat
                lJobBudgetEntryTemp.SetCurrentkey("Job No.", "Job Task No.", "Gen. Prod. Posting Group");
                lJobBudgetEntryTemp.SetRange("Job No.", lJobBudgetEntry."Job No.");
                lJobBudgetEntryTemp.SetRange("Gen. Prod. Posting Group", lJobBudgetEntry."Gen. Prod. Posting Group");
                lJobBudgetEntryTemp.SetRange("Planning Date", lJobBudgetEntry."Planning Date");
                if lJobBudgetEntryTemp.Find('-') then begin
                    lJobBudgetEntryTemp."Total Price" += lJobBudgetEntry."Total Price";
                    lJobBudgetEntryTemp.Modify;
                end
                else begin
                    lJobBudgetEntryTemp := lJobBudgetEntry;
                    lJobBudgetEntryTemp.Insert;
                end
            until lJobBudgetEntry.Next = 0;
        end;

        lJobBudgetEntryTemp.SetRange("Gen. Prod. Posting Group");
        lJobBudgetEntryTemp.SetRange("Planning Date");
        if lJobBudgetEntryTemp.Find('-') then
            repeat
                if lJobBudgetEntryTemp."Total Price" <> 0 then
                    CalcDistribution(pJob, lJobBudgetEntryTemp);
            until lJobBudgetEntryTemp.Next = 0;
    end;


    procedure CalcDistribution(pJob: Record Job; pJobBudgetEntry: Record "Job Planning Line")
    var
        lEstInv: Record "Estimated invoicing";
        lEstInv2: Record "Estimated invoicing";
        lDate: Date;
        lAmount: Decimal;
        lTotAmount: Decimal;
        lDiffDeb: Integer;
        lDiffFin: Integer;
        lAnneeMoisDeb: Integer;
        lAnneeMoisFin: Integer;
        lNbMois: Integer;
        i: Integer;
        lDateDeb: Date;
        lDateFin: Date;
        lDateDeb2: Date;
        lAnneeDeb: Integer;
        lAnneeFin: Integer;
    begin
        if pJobBudgetEntry."Document Type" <> pJobBudgetEntry."document type"::"Credit Memo" then
            case pJob."Distribution Type (Planning)" of
                pJob."distribution type (planning)"::Manual:
                    ;
                pJob."distribution type (planning)"::"Prorata temporis":
                    if (pJob."Ending Date" <> 0D) then begin
                        Fenetre.Open(TestRepartition);
                        lEstInv."Job No." := pJobBudgetEntry."Job No.";
                        lEstInv."Doc. Type" := pJobBudgetEntry."Document Type";
                        lEstInv."Doc. No." := pJobBudgetEntry."Document No.";
                        lEstInv."Gen. Prod. Posting Group" := pJobBudgetEntry."Gen. Prod. Posting Group";
                        lDiffDeb := 0;
                        lDiffFin := 0;
                        if pJobBudgetEntry."Planning Date" < pJob."Starting Date" then
                            lDateDeb := pJob."Starting Date"
                        else
                            lDateDeb := pJobBudgetEntry."Planning Date";
                        lDateDeb2 := lDateDeb;
                        lDateFin := pJob."Ending Date";

                        lAnneeMoisDeb := Date2dmy(lDateDeb, 3) * 100;
                        lAnneeMoisDeb += Date2dmy(lDateDeb, 2);
                        lAnneeMoisFin := Date2dmy(lDateFin, 3) * 100;
                        lAnneeMoisFin += Date2dmy(lDateFin, 2);
                        lAnneeDeb := Date2dmy(lDateDeb, 3);
                        lAnneeFin := Date2dmy(lDateFin, 3);
                        lNbMois := (lAnneeFin - lAnneeDeb) * 12;
                        lNbMois += (lAnneeMoisFin - (lAnneeFin * 100)) - (lAnneeMoisDeb - (lAnneeDeb * 100)) + 1;

                        if lNbMois > 1 then begin
                            if lDateDeb <> CalcDate('<-CM>', lDateDeb) then begin
                                lDiffDeb := CalcDate('<CM>', lDateDeb) - lDateDeb + 1;
                                lDateDeb := CalcDate('<CM + 1D>', lDateDeb2);
                            end;
                            if pJob."Ending Date" <> CalcDate('<CM>', pJob."Ending Date") then begin
                                lDiffFin := pJob."Ending Date" - CalcDate('<-CM>', pJob."Ending Date") + 1;
                                lDateFin := CalcDate('<-CM - 1D>', pJob."Ending Date");
                            end;
                        end;

                        lAnneeMoisDeb := Date2dmy(lDateDeb, 3) * 100;
                        lAnneeMoisDeb += Date2dmy(lDateDeb, 2);
                        lAnneeMoisFin := Date2dmy(lDateFin, 3) * 100;
                        lAnneeMoisFin += Date2dmy(lDateFin, 2);

                        lNbMois := (lAnneeFin - lAnneeDeb) * 12;
                        lNbMois += (lAnneeMoisFin - (lAnneeFin * 100)) - (lAnneeMoisDeb - (lAnneeDeb * 100)) + 1;
                        lAmount := pJobBudgetEntry."Total Price";
                        if lNbMois = 0 then
                            lNbMois := 1;

                        if lDiffDeb <> 0 then begin
                            lEstInv."Entry No." := 0;
                            lEstInv."Posting Date" := CalcDate('<CM>', lDateDeb2);
                            lEstInv.Amount := ROUND(lAmount / ((pJob."Ending Date" - lDateDeb2 + 1)) * lDiffDeb, 0.01);
                            lAmount -= lEstInv.Amount;
                            if (lDiffFin = 0) and (lAmount <> (ROUND(lAmount / lNbMois, 0.01) * lNbMois)) then
                                lEstInv.Amount -= (ROUND(lAmount / lNbMois, 0.01) * lNbMois) - lAmount;
                            lEstInv2.SetCurrentkey("Job No.");
                            lEstInv2.SetRange("Job No.", lEstInv."Job No.");
                            lEstInv2.SetRange("Doc. Type", lEstInv."Doc. Type");
                            lEstInv2.SetRange("Doc. No.", lEstInv."Doc. No.");
                            lEstInv2.SetRange("Gen. Prod. Posting Group", lEstInv."Gen. Prod. Posting Group");
                            lEstInv2.SetRange("Posting Date", lEstInv."Posting Date");
                            lEstInv2.CalcSums(Amount);
                            if lEstInv2.Amount <> 0 then
                                lEstInv.Amount -= lEstInv2.Amount;
                            if lEstInv.Amount <> 0 then
                                lEstInv.Insert(true);
                        end;
                        if lDiffFin <> 0 then begin
                            lEstInv."Entry No." := 0;
                            lEstInv."Posting Date" := CalcDate('<CM>', pJob."Ending Date");
                            lEstInv.Amount := ROUND(pJobBudgetEntry."Total Price" /
                                                    ((pJob."Ending Date" - lDateDeb2 + 1)) * lDiffFin, 0.01);
                            lAmount -= lEstInv.Amount;
                            if (lAmount <> (ROUND(lAmount / lNbMois, 0.01) * lNbMois)) then
                                lEstInv.Amount -= (ROUND(lAmount / lNbMois, 0.01) * lNbMois) - lAmount;
                            lEstInv2.SetCurrentkey("Job No.");
                            lEstInv2.SetRange("Job No.", lEstInv."Job No.");
                            lEstInv2.SetRange("Doc. Type", lEstInv."Doc. Type");
                            lEstInv2.SetRange("Doc. No.", lEstInv."Doc. No.");
                            lEstInv2.SetRange("Gen. Prod. Posting Group", lEstInv."Gen. Prod. Posting Group");
                            lEstInv2.SetRange("Posting Date", lEstInv."Posting Date");
                            lEstInv2.CalcSums(Amount);
                            if lEstInv2.Amount <> 0 then
                                lEstInv.Amount -= lEstInv2.Amount;
                            if lEstInv.Amount <> 0 then
                                lEstInv.Insert(true);
                        end;
                        lTotAmount := ROUND(lAmount / lNbMois, 0.01);

                        for i := lAnneeMoisDeb to lAnneeMoisFin do begin
                            lEstInv."Entry No." := 0;
                            lEstInv."Posting Date" := CalcDate('<CM>', Dmy2date(1, i - (ROUND(i / 100, 1) * 100), ROUND(i / 100, 1)));
                            lEstInv.Amount := lTotAmount;
                            lEstInv2.SetCurrentkey("Job No.");
                            lEstInv2.SetRange("Job No.", lEstInv."Job No.");
                            lEstInv2.SetRange("Doc. Type", lEstInv."Doc. Type");
                            lEstInv2.SetRange("Doc. No.", lEstInv."Doc. No.");
                            lEstInv2.SetRange("Gen. Prod. Posting Group", lEstInv."Gen. Prod. Posting Group");
                            lEstInv2.SetRange("Posting Date", lEstInv."Posting Date");
                            lEstInv2.CalcSums(Amount);
                            if lEstInv2.Amount <> 0 then
                                lEstInv.Amount -= lEstInv2.Amount;
                            if lEstInv.Amount <> 0 then
                                lEstInv.Insert(true);
                            lAmount := 0;
                            if i - (lAnneeDeb * 100) = 12 then begin
                                lAnneeDeb += 1;
                                i := (lAnneeDeb * 100);
                            end;
                        end;
                        Fenetre.Close;
                    end;
                pJob."distribution type (planning)"::"Normal Curve":
                    if (pJob."Ending Date" <> 0D) then begin
                        Fenetre.Open(TestRepartition);
                        lTotAmount := 0;
                        lEstInv."Job No." := pJobBudgetEntry."Job No.";
                        lEstInv."Doc. Type" := pJobBudgetEntry."Document Type";
                        lEstInv."Doc. No." := pJobBudgetEntry."Document No.";
                        if (pJobBudgetEntry."Planning Date" < pJob."Starting Date") or (pJobBudgetEntry."Planning Date" > pJob."Ending Date") then
                            lDateDeb := pJob."Starting Date"
                        else
                            lDateDeb := pJobBudgetEntry."Planning Date";
                        lEstInv."Gen. Prod. Posting Group" := pJobBudgetEntry."Gen. Prod. Posting Group";
                        SumLoiNormale((pJob."Ending Date" - lDateDeb + 1), (pJob."Ending Date" - lDateDeb + 1) * 0.5);
                        for lDate := lDateDeb to pJob."Ending Date" do begin
                            lAmount += ROUND(pJobBudgetEntry."Total Price" *
                               CoefLoiNormale((pJob."Ending Date" - lDateDeb + 1), (pJob."Ending Date" - lDateDeb + 1) * 0.5,
                                               (lDate - lDateDeb + 1)), 0.01);
                            if CalcDate('<CM>', lDate) = lDate then begin
                                lEstInv."Entry No." := 0;
                                lEstInv."Posting Date" := lDate;
                                lEstInv.Amount := lAmount;
                                lEstInv2.SetCurrentkey("Job No.");
                                lEstInv2.SetRange("Job No.", lEstInv."Job No.");
                                lEstInv2.SetRange("Doc. Type", lEstInv."Doc. Type");
                                lEstInv2.SetRange("Doc. No.", lEstInv."Doc. No.");
                                lEstInv2.SetRange("Gen. Prod. Posting Group", lEstInv."Gen. Prod. Posting Group");
                                lEstInv2.SetRange("Posting Date", lEstInv."Posting Date");
                                lEstInv2.CalcSums(Amount);
                                if lEstInv2.Amount <> 0 then
                                    lEstInv.Amount -= lEstInv2.Amount;
                                if lEstInv.Amount <> 0 then
                                    lEstInv.Insert(true);
                                lTotAmount += lAmount;
                                lAmount := 0;
                            end;
                        end;
                        if lAmount <> 0 then begin
                            lEstInv."Entry No." := 0;
                            lEstInv."Posting Date" := lDate;
                            lEstInv.Amount := lAmount;
                            lEstInv2.SetCurrentkey("Job No.");
                            lEstInv2.SetRange("Job No.", lEstInv."Job No.");
                            lEstInv2.SetRange("Doc. Type", lEstInv."Doc. Type");
                            lEstInv2.SetRange("Doc. No.", lEstInv."Doc. No.");
                            lEstInv2.SetRange("Gen. Prod. Posting Group", lEstInv."Gen. Prod. Posting Group");
                            lEstInv2.SetRange("Posting Date", lEstInv."Posting Date");
                            lEstInv2.CalcSums(Amount);
                            if lEstInv2.Amount <> 0 then
                                lEstInv.Amount -= lEstInv2.Amount;
                            if lEstInv.Amount <> 0 then
                                lEstInv.Insert(true);
                            lTotAmount += lAmount;
                            lAmount := 0;
                        end;
                        if lTotAmount - pJobBudgetEntry."Total Price" <> 0 then begin
                            lEstInv.Amount += pJobBudgetEntry."Total Price" - lTotAmount;
                            if not lEstInv.Modify then
                                //#7636
                                lEstInv.Insert(true);
                            //#7636//
                        end;
                        Fenetre.Close;
                    end;
                else
                    ;
            end
        else begin
            Fenetre.Open(TestRepartition);
            lEstInv."Job No." := pJobBudgetEntry."Job No.";
            lEstInv."Doc. Type" := pJobBudgetEntry."Document Type";
            lEstInv."Doc. No." := pJobBudgetEntry."Document No.";
            lEstInv."Gen. Prod. Posting Group" := pJobBudgetEntry."Gen. Prod. Posting Group";
            lEstInv."Entry No." := 0;
            lEstInv."Posting Date" := pJobBudgetEntry."Planning Date";
            lEstInv.Amount := pJobBudgetEntry."Total Price";
            lEstInv2.SetCurrentkey("Job No.");
            lEstInv2.SetRange("Job No.", lEstInv."Job No.");
            lEstInv2.SetRange("Doc. Type", lEstInv."Doc. Type");
            lEstInv2.SetRange("Doc. No.", lEstInv."Doc. No.");
            lEstInv2.SetRange("Gen. Prod. Posting Group", lEstInv."Gen. Prod. Posting Group");
            lEstInv2.SetRange("Posting Date", lEstInv."Posting Date");
            lEstInv2.CalcSums(Amount);
            if lEstInv2.Amount <> 0 then
                lEstInv.Amount -= lEstInv2.Amount;
            if lEstInv.Amount <> 0 then
                lEstInv.Insert(true);
            Fenetre.Close;
        end;
    end;


    procedure RePostDiff(pJob: Record Job)
    var
        lJobLedgerEntry: Record "Job Ledger Entry";
        lDate: Date;
        lEst: Record "Estimated invoicing";
        lEst2: Record "Estimated invoicing";
        lDateDeb: Date;
        lDateFin: Date;
        lJobTask: Record "Job Task";
    begin
        lJobLedgerEntry.SetCurrentkey("Job No.", "Posting Date");
        lJobLedgerEntry.SetRange("Job No.", pJob."No.");
        lJobLedgerEntry.SetRange("Entry Type", lJobLedgerEntry."entry type"::Sale);
        if not lJobLedgerEntry.Find('+') then
            exit;

        lDate := CalcDate('<CM>', lJobLedgerEntry."Posting Date");
        lEst.SetCurrentkey("Job No.");
        lEst.SetRange("Job No.", pJob."No.");
        lEst.SetFilter("Posting Date", '<=%1', lDate);
        if lEst.Find('-') then
            repeat
                lDateDeb := CalcDate('<-CM>', lEst."Posting Date");
                lDateFin := CalcDate('<CM>', lEst."Posting Date");
                pJob.SetRange("Posting Date Filter", lDateDeb, lDateFin);
                pJob.SetRange("Gen. Prod Posting Group Filter", lEst."Gen. Prod. Posting Group");
                //MIGRATION5.00
                //    pJob.CALCFIELDS("Invoiced Price","Estimated invoicing");
                pJob.CalcFields("Estimated invoicing");
                lJobTask.Init;
                lJobTask.SetFilter("Posting Date Filter", '%1..%2', lDateDeb, lDateFin);
                lJobTask.Totaling := '0..~';
                lJobTask.CalcFields("Contract (Invoiced Price)");
                //    IF pJob."Estimated invoicing" - pJob."Invoiced Price" <> 0 THEN BEGIN
                if pJob."Estimated invoicing" - lJobTask."Contract (Invoiced Price)" <> 0 then begin
                    //MIGRATION5.00//
                    lEst2 := lEst;
                    lEst2."Entry No." := 0;
                    //MIGRATION5.00
                    //      lEst2.Amount := - (pJob."Estimated invoicing" - pJob."Invoiced Price");
                    lEst2.Amount := -(pJob."Estimated invoicing" - lJobTask."Contract (Invoiced Price)");
                    //MIGRATION5.00//
                    lEst2.Insert(true);
                    lEst2."Entry No." := 0;
                    lEst2."Posting Date" := CalcDate('<1M>', lDate);
                    //MIGRATION5.00
                    //      lEst2.Amount := pJob."Estimated invoicing" - pJob."Invoiced Price";
                    lEst2.Amount := pJob."Estimated invoicing" - lJobTask."Contract (Invoiced Price)";
                    //MIGRATION5.00//
                    lEst2.Insert(true);
                end;
                lEst.SetRange("Posting Date", lDateFin + 1, lDate);
            until lEst.Next = 0;
    end;


    procedure LoiNormale(T: Integer; Ecart: Decimal; X: Integer): Decimal
    var
        PI: Decimal;
        EXP: Decimal;
    begin
        //T = Nombre de jours total de la répartition
        //X = Nombre de jours depuis le  début
        //Ecart = permet de d'écraser ou d'agrandir le sommet de la courbe
        EXP := 2.718281828;
        PI := 3.141592654;
        exit((1 / (Ecart * Power(2 * PI, 0.5))) * Power(EXP, -0.5 * Power(((X - (T / 2)) / Ecart), 2)));
    end;


    procedure SumLoiNormale(T: Integer; Ecart: Decimal)
    var
        I: Integer;
    begin
        Sumcoef := 0;
        for I := 0 to T do begin
            Sumcoef += LoiNormale(T, Ecart, I);
        end;
    end;


    procedure CoefLoiNormale(T: Integer; Ecart: Decimal; X: Integer): Decimal
    begin
        if Sumcoef <> 0 then
            exit(LoiNormale(T, Ecart, X) / Sumcoef)
        else
            exit(LoiNormale(T, Ecart, X));
    end;
}

