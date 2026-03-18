TableExtension 50129 "Opportunity EntryEXT" extends "Opportunity Entry"
{
    fields
    {
        field(8001400; "Quote Register"; Boolean)
        {
            Caption = 'Quote Register';
        }
        field(8001401; "Estimated Margin Var(LCY)"; Decimal)
        {
            Caption = 'Estimated Margin (LCY)';
            DecimalPlaces = 2 : 2;
        }
        field(8001402; Variation; Decimal)
        {
            Caption = 'Variation';
            DecimalPlaces = 2 : 2;
        }
    }
    keys
    {

        /* GL2024 key(STG_Key9;"Opportunity No.","Date of Change","Quote Register")
          {
          SumIndexFields = "Estimated Margin Var(LCY)",Variation;
          }*/
    }






    trigger OnAfterInsert()
    var
        Opp: Record Opportunity;
        lOppEntry: Record "Opportunity Entry";
        lSalesHeader: Record "Sales Header";
        lCalcStatSalesHeader: Codeunit "Calc Stat Sales Header";
        lSalesLine: Record "Sales Line";
    begin
        //GL2024
        IF lSalesHeader.GET(lSalesHeader."Document Type"::Quote, Opp."Sales Document No.") THEN BEGIN

            lSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Structure Line No.", "Line No.", "Line Type", "Assignment Basis", Option,
                       Disable, "Gen. Prod. Posting Group", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            lSalesLine.SETRANGE("Document Type", lSalesHeader."Document Type");
            lSalesLine.SETRANGE("Document No.", lSalesHeader."No.");

            lSalesLine.SETRANGE("Structure Line No.", 0);
            lSalesLine.SETFILTER("Line Type", '%1..', lSalesLine."Line Type"::Item);
            lSalesLine.SETRANGE(Option, FALSE);
            //    lSalesLine.CALCSUMS("Overhead Amount (LCY)", "Total Cost (LCY)", "Job Costs (LCY)", "Amount Excl. VAT (LCY)");
            //wMargin := lUpdateF9.getMaginPriceCostValue;
            //#6228
            wMargin := lSalesLine."Amount Excl. VAT (LCY)" -
                       (lSalesLine."Overhead Amount (LCY)" + lSalesLine."Total Cost (LCY)");
        end;
        //GL2024 FIN



        Opp.Get("Opportunity No.");
        case "Action Taken" of
            "Action Taken"::Jumped:
                begin
                    //+REF+OPPORT
                    IF Opp."Sales Document No." <> '' THEN BEGIN
                        lOppEntry.SETCURRENTKEY("Opportunity No.");
                        lOppEntry.SETRANGE("Opportunity No.", "Opportunity No.");
                        lOppEntry.SETRANGE("Quote Register", TRUE);
                        "Quote Register" := lOppEntry.ISEMPTY;
                        IF lSalesHeader.GET(lSalesHeader."Document Type"::Quote, Opp."Sales Document No.") THEN BEGIN
                            lCalcStatSalesHeader.RUN(lSalesHeader);
                            "Estimated Value (LCY)" := lCalcStatSalesHeader.getTotalAmountLCY;
                            VALIDATE("Campaign No.", lSalesHeader."Campaign No.");
                        END;

                        "Estimated Value (LCY)" := GetSalesDocValue(lSalesHeader);
                        "Estimated Margin Var(LCY)" := wMargin;
                        IF NOT "Quote Register" THEN BEGIN
                            lOppEntry.SETRANGE("Quote Register");
                            lOppEntry.SETRANGE(Active, FALSE);
                            IF NOT lOppEntry.ISEMPTY THEN BEGIN
                                lOppEntry.FIND('+');
                                Variation := "Estimated Value (LCY)" - lOppEntry."Estimated Value (LCY)";
                                Opp.CALCFIELDS("Margin Value (LCY)");
                                "Estimated Margin Var(LCY)" -= Opp."Margin Value (LCY)";
                            END;
                        END;
                    END;
                    //+REF+OPPORT//
                end;

        end;
    end;


    procedure fCreateMultiActions(pOppNo: Code[20])
    var
        lOpport: Record Opportunity;
        lSalesCycleStage: Record "Sales Cycle Stage";
        lInterLogEntry: Record "Interaction Log Entry";
        lToDo: Record "To-do";
        lOppEntry: Record "Opportunity Entry";
        lTemp: Integer;
    begin
        //#8918\\
        //+REF+OPPORT
        if not lOpport.Get(pOppNo) then
            exit;
        lOppEntry.SetRange("Opportunity No.", pOppNo);
        if (not lOppEntry.Find('+')) then
            exit;
        if (not lOppEntry.Active) or ((lOppEntry."Action Taken" <> lOppEntry."action taken"::Next)
              and (lOppEntry."Action Taken" <> lOppEntry."action taken"::" ")) then
            exit;
        lOpport."Current Sales Cycle Stage" := lOppEntry."Sales Cycle Stage";
        if lSalesCycleStage.Get(lOpport."Sales Cycle Code", lOpport."Current Sales Cycle Stage") then
            case lSalesCycleStage.Create of
                lSalesCycleStage.Create::Quote:
                    if lOpport."Sales Document No." = '' then
                        //GL2024 lOpport.AssignQuote;
                        //GL2024
                        lOpport.CreateQuote;
                //GL2024
                lSalesCycleStage.Create::Interaction:
                    begin
                        lInterLogEntry.SetRange("Contact Company No.", lOpport."Contact Company No.");
                        lInterLogEntry.SetRange("Contact No.", lOpport."Contact No.");
                        lInterLogEntry.SetRange("Campaign No.", lOpport."Campaign No.");
                        lInterLogEntry.SetRange("Opportunity No.", lOpport."No.");
                        lInterLogEntry.SetRange("Interaction Template Code", lSalesCycleStage."Interaction Template");
                        lInterLogEntry.SetRange("Segment No.", lOpport."Segment No.");
                        lInterLogEntry.CreateInteraction;
                    end;
                lSalesCycleStage.Create::"To-Do":
                    begin
                        lToDo.SetRange("Opportunity No.", lOpport."No.");
                        lToDo.CreateTaskFromTask(lToDo);
                    end;
            end;
        //+REF+OPPORT//
    end;

    var

        Text002: label 'Sales (LCY) must be greater than 0.';

        wMargin: Decimal;

        Text010: label 'untitled';
}

