TableExtension 50128 OpportunityEXT extends Opportunity
{
    fields
    {
        modify("Sales Document No.")
        {
            Description = 'TableRelation Modification';
            TableRelation = if (Closed = const(true),
                                "Sales Document Type" = filter(Quote)) "Sales Header Archive"."No." where("Document Type" = const(Quote),
                                                                                                         "No." = field("Sales Document No."))
            else
            if ("Sales Document Type" = const(Quote),
                                                                                                                  Closed = const(false)) "Sales Header"."No." where("Document Type" = const(Quote),
                                                                                                                                                                   "Sell-to Contact No." = field("Contact No."))
            else
            if ("Sales Document Type" = const(Order)) "Sales Header"."No." where("Document Type" = const(Order),
                                                                                                                                                                                                                                            "Sell-to Contact No." = field("Contact No."))
            else
            if ("Sales Document Type" = const("Posted Invoice")) "Sales Invoice Header"."No." where("Sell-to Contact No." = field("Contact No."));


        }



        field(8001400; "Margin Value (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Opportunity Entry"."Estimated Margin Var(LCY)" where("Opportunity No." = field("No."),
                                                                                     "Date of Change" = field("Date Filter"),
                                                                                     "Quote Register" = field("Quote register Filter")));
            Caption = 'Margin Value (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8001401; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(8001402; Variation; Decimal)
        {
            CalcFormula = sum("Opportunity Entry".Variation where("Opportunity No." = field("No."),
                                                                   "Date of Change" = field("Date Filter")));
            Caption = 'Variation';
            FieldClass = FlowField;
        }
        field(8001403; "Close Opportunity Code"; Code[10])
        {
            CalcFormula = lookup("Opportunity Entry"."Close Opportunity Code" where("Opportunity No." = field("No."),
                                                                                     Active = const(true)));
            Caption = 'Close Opportunity Code';
            FieldClass = FlowField;
        }
        field(8001404; "Close Opportunity Desc."; Text[30])
        {
            CalcFormula = lookup("Close Opportunity Code".Description where(Code = field("Close Opportunity Code")));
            Caption = 'Close Opportunity Description';
            FieldClass = FlowField;
        }
        field(8001405; "Quote register Filter"; Boolean)
        {
            FieldClass = FlowFilter;
        }
        field(8001406; "Revision Number"; Integer)
        {
            CalcFormula = count("Opportunity Entry" where("Opportunity No." = field("No."),
                                                           "Date of Change" = field("Date Filter"),
                                                           Variation = filter(<> 0)));
            Caption = 'Revision Number';
            FieldClass = FlowField;
        }
        field(8001407; "Shortcut Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                fValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(8001408; "Shortcut Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                fValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(8001409; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                lUserMgt: Codeunit "User Setup Management";
                lText027: label 'Your identification is set up to process from %1 %2 only.';
                lRespCenter: Record "Responsibility Center";
            begin
                //+REF+OPPORT
                TestField(Status, Status::"Not Started");
                if not lUserMgt.CheckRespCenter(0, "Responsibility Center") then
                    Error(
                      lText027,
                       lRespCenter.TableCaption, lUserMgt.GetSalesFilter());
                fCreateDim(
                  Database::"Responsibility Center", REC.fieldno("Responsibility Center"),
                //  DATABASE::Customer,"Bill-to Customer No.",
                //  DATABASE::Job,"Job No.",
                  Database::"Salesperson/Purchaser", "Salesperson Code",
                  Database::Campaign, "Campaign No.",
                  0, '',
                  0, '',
                  0, '');
                //+REF+OPPORT//
            end;
        }
    }


    trigger OnBeforeInsert()
    var
        lUserMgt: Codeunit "User Setup Management";
        lRespCenter: Record "Responsibility Center";
        lNoRespCenterSeriesMgt: Codeunit NoSeriesRespCenterManagement;
    begin
        if "No." = '' then begin
            RMSetup.Get();
            IF (lUserMgt.GetSalesFilter() = '') AND lRespCenter.READPERMISSION AND lRespCenter.FIND('-') AND
                           ("Responsibility Center" = '') THEN BEGIN
                COMMIT;
                IF page.RUNMODAL(0, lRespCenter) = ACTION::LookupOK THEN
                    "Responsibility Center" := lRespCenter.Code;
            END;
            //+REF+RESPCENTER//
            //#7795
            //  lNoRespCenterSeriesMgt.InitSeries(RMSetup."Opportunity Nos.",xRec."No. Series",0D,"No.","No. Series","Responsibility Center");
            NoSeriesMgt.fSetRespCenter("Responsibility Center");
            //#7795//

        end;
    end;

    trigger OnAfterInsert()
    begin
        //+REF+CRM
        IF GETFILTER("Contact No.") <> '' THEN BEGIN
            IF GETRANGEMIN("Contact No.") = GETRANGEMAX("Contact No.") THEN
                VALIDATE("Contact No.", GETRANGEMIN("Contact No."));
        END ELSE
            IF GETFILTER("Contact Company No.") <> '' THEN
                IF GETRANGEMIN("Contact Company No.") = GETRANGEMAX("Contact Company No.") THEN
                    VALIDATE("Contact No.", GETRANGEMIN("Contact Company No."));
        //+REF+CRM//
        //+REF+TEMPLATE
        DimMgm.fSetDocDim(DATABASE::Opportunity, 0, "No.", 0, 1, "Shortcut Dimension 1 Code");
        DimMgm.fSetDocDim(DATABASE::Opportunity, 0, "No.", 0, 2, "Shortcut Dimension 2 Code");
        //+REF+TEMPLATE//
    end;


    procedure wUpdateOpportunity(var pRec: Record "Sales Header"; pInsertQuote: Boolean)
    begin
        //+REF+OPPORT
        if Get(pRec."Opportunity No.") then begin
            xRec.Get(pRec."Opportunity No.");
            if xRec."Campaign No." <> pRec."Campaign No." then
                Validate("Campaign No.", pRec."Campaign No.");
            //DEVIS
            //  IF Description <> pRec."Posting Description" THEN
            //    Description := pRec."Posting Description";
            if Description <> pRec.Subject then
                Description := pRec.Subject;
            //DEVIS//
            Modify;
            wUpdOppEntry(pRec, pInsertQuote);
        end else begin
            if wCreateOpp(pRec) then begin
                pRec."Opportunity No." := "No.";
                pRec.Modify;
                wUpdOppEntry(pRec, pInsertQuote);
            end;
        end;
    end;

    procedure wUpdOppEntry(pRec: Record "Sales Header"; pInsertQuote: Boolean)
    var
        lOpportEntry: Record "Opportunity Entry";
        lSalesCycleStage: Record "Sales Cycle Stage";
        lCreateToDo: Boolean;
    begin
        //+REF+OPPORT
        lOpportEntry.SetCurrentkey("Opportunity No.");
        lOpportEntry.SetRange("Opportunity No.", pRec."Opportunity No.");
        lCreateToDo := lOpportEntry.IsEmpty;
        lOpportEntry.SetRange(Active, true);
        if lOpportEntry.Find('-') then begin
            lOpportEntry."Action Taken" := lOpportEntry."action taken"::Updated;
            lOpportEntry."Quote Register" := pInsertQuote;
            lOpportEntry."Date of Change" := WorkDate;
            lOpportEntry."Estimated Close Date" := pRec."Order Date";
        end else begin
            TestField(Closed, false);
            lSalesCycleStage.SetRange("Sales Cycle Code", "Sales Cycle Code");
            lSalesCycleStage.Find('-');
            lOpportEntry."Sales Cycle Code" := "Sales Cycle Code";
            lOpportEntry."Sales Cycle Stage" := lSalesCycleStage.Stage;
            lOpportEntry.Validate("Completed %", lSalesCycleStage."Completed %");
            lOpportEntry.Validate("Opportunity No.", "No.");
            lOpportEntry."Action Taken" := lOpportEntry."action taken"::" ";
            lOpportEntry."Contact No." := "Contact No.";
            lOpportEntry."Contact Company No." := "Contact Company No.";
            lOpportEntry."Salesperson Code" := "Salesperson Code";
            lOpportEntry."Campaign No." := "Campaign No.";
            lOpportEntry."Estimated Close Date" := pRec."Order Date";
            lOpportEntry."Chances of Success %" := 100;
        end;
        lOpportEntry.InsertEntry(lOpportEntry, false, lCreateToDo);
        lOpportEntry.UpdateEstimates;
    end;

    procedure wCreateOpp(pSalesHeader: Record "Sales Header"): Boolean
    var
        lOppTemp: Record Opportunity temporary;
        lCont: Record Contact;
        lSalesCycle: Record "Sales Cycle";
        lSalesPurchPerson: Record "Salesperson/Purchaser";
        lCampaign: Record Campaign;
    begin
        lOppTemp.DeleteAll;
        lOppTemp.Init;
        lOppTemp."Creation Date" := WorkDate;
        RMSetup.Get;
        if RMSetup."Default Sales Cycle Code" <> '' then begin
            if lSalesCycle.Get(RMSetup."Default Sales Cycle Code") then
                if not lSalesCycle.Blocked then
                    lOppTemp."Sales Cycle Code" := RMSetup."Default Sales Cycle Code";
        end else
            exit(false);

        if lCont.Get(pSalesHeader."Sell-to Contact No.") then begin
            lOppTemp.Validate("Contact No.", lCont."No.");
            lOppTemp."Salesperson Code" := lCont."Salesperson Code";
            if lCont.Type = lCont.Type::Company then
                lOppTemp.SetRange("Contact Company No.", lOppTemp."Contact No.")
            else
                lOppTemp.SetRange("Contact No.", lOppTemp."Contact No.");
        end else
            exit(false);

        if lSalesPurchPerson.Get(pSalesHeader."Salesperson Code") then begin
            lOppTemp."Salesperson Code" := lSalesPurchPerson.Code;
            lOppTemp.SetRange("Salesperson Code", lOppTemp."Salesperson Code");
        end else
            Error(Text8001400);

        lOppTemp."Creation Date" := pSalesHeader."Document Date";
        if lCampaign.Get(pSalesHeader."Campaign No.") then begin
            lOppTemp."Campaign No." := lCampaign."No.";
            lOppTemp."Salesperson Code" := lCampaign."Salesperson Code";
            lOppTemp.SetRange("Campaign No.", lOppTemp."Campaign No.");
        end;
        //DEVIS
        //lOppTemp.Description := pSalesHeader."Posting Description";
        lOppTemp.Description := pSalesHeader.Subject;
        //DEVIS//
        //#5492
        lOppTemp."Responsibility Center" := pSalesHeader."Responsibility Center";
        //#5492//
        lOppTemp."Sales Document Type" := "sales document type"::Quote;
        lOppTemp.Validate("Sales Document No.", pSalesHeader."No.");
        lOppTemp."Estimated Closing Date" := pSalesHeader."Order Date";
        lOppTemp.Insert;
        Rec := lOppTemp;
        Rec.Insert(true);
        exit(true);
    end;

    procedure wSetHideMessages(pHideMessgs: Boolean)
    begin
        wHideMessages := pHideMessgs;
    end;

    procedure gShowCard()
    begin
        page.RunModal(page::"Opportunity Card", Rec);
    end;

    procedure gShowOppStatistics()
    begin
        page.RunModal(page::"Opportunity Statistics", Rec);
    end;

    procedure gShowIntLogEntries()
    var
        lInteractionlogEntry: Record "Interaction Log Entry";
    begin
        lInteractionlogEntry.SetRange("Opportunity No.", "No.");
        lInteractionlogEntry.SetRange(Postponed, false);
        page.RunModal(page::"Interaction Log Entries", lInteractionlogEntry);
    end;

    procedure gShowPostponedInt()
    var
        lInteractionlogEntry: Record "Interaction Log Entry";
    begin
        lInteractionlogEntry.SetRange("Opportunity No.", "No.");
        lInteractionlogEntry.SetRange(Postponed, true);
        page.RunModal(page::"Postponed Interactions", lInteractionlogEntry);
    end;

    procedure gShowToDoList()
    var
        lToDo: Record "To-do";
    begin
        lToDo.SetRange("Opportunity No.", "No.");
        page.RunModal(page::"Task List", lToDo);
    end;

    procedure gShowComment()
    var
        lRlshpMgtCommentLine: Record "Rlshp. Mgt. Comment Line";
    begin
        lRlshpMgtCommentLine.SetRange("Table Name", lRlshpMgtCommentLine."table name"::Opportunity);
        lRlshpMgtCommentLine.SetRange("No.", "No.");
        page.RunModal(page::"Rlshp. Mgt. Comment Sheet", lRlshpMgtCommentLine);
    end;

    procedure gShowDocument()
    var
        lSalesHeader: Record "Sales Header";
    begin
        lSalesHeader.SetRange("No.", "Sales Document No.");
        if "Sales Document Type" = "sales document type"::Quote then
            page.RunModal(page::"Sales Quote", lSalesHeader)
        else
            page.RunModal(page::"Sales Order", lSalesHeader)
    end;

    procedure fValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        //+REF+CRM
        gDimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        if not IsTemporary then begin
            gDimMgt.SaveDefaultDim(DATABASE::Opportunity, "No.", FieldNumber, ShortcutDimCode);
            Modify();
        end;
        // if "No." <> '' then begin
        //     gDimMgt.SaveDocDim(
        //       Database::Opportunity, 0, "No.", 0, FieldNumber, ShortcutDimCode);
        //     Modify;
        // end else
        //     gDimMgt.SaveTempDim(FieldNumber, ShortcutDimCode);
        //+REF+CRM//
    end;

    procedure fShowDocDim()
    var
        //GL2024 lDocDim: Record 357;
        lDocDim: Record "IC Document Dimension";
        lDocDims: page "Dim. Allowed Values per Acc.";
    begin
        //+REF+CRM
        lDocDim.SetRange("Table ID", Database::Opportunity);
        //DocDim.SETRANGE("Document Type","Document Type");
        //GL2024   lDocDim.SetRange("Document No.", "No.");
        lDocDim.SetRange("Line No.", 0);
        lDocDims.SetTableview(lDocDim);
        lDocDims.RunModal;
        Get("No.");
        //+REF+CRM//
    end;

    procedure fCreateDim(Type1: Integer; No1: Integer; Type2: Integer; No2: code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20]; Type6: Integer; No6: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        DimSource: List of [Dictionary of [Integer, Code[20]]];
        DimDictionary: Dictionary of [Integer, Code[20]];
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        // No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        TableID[4] := Type4;
        No[4] := No4;
        TableID[5] := Type5;
        No[5] := No5;
        TableID[6] := Type6;
        No[6] := No6;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';

        // gDimMgt.GetDefaultDim(
        //   TableID, No, SourceCodeSetup.Sales,
        //   "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        gDimMgt.GetRecDefaultDimID(Rec, No1, DimSource, SourceCodeSetup.Sales,
        "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0)
    end;



    var
        Text8001400: label 'You must specify a salesperson.';
        Text020: label '(Multiple)';
        wHideMessages: Boolean;
        Text021: label 'untitled';

        gDimMgt: Codeunit DimensionManagement;
        DimMgm: Codeunit DimensionManagementEvent;
        RMSetup: Record "Marketing Setup";
        NoSeriesMgt: Codeunit SoroubatFucntion;
}

