Codeunit 8004130 "Planning Management"
{
    // 
    // //PLANNING CW 16/02/04 Mise à jour du "Presentation code" des "Planning entry" d'un document
    // //USER MB 18/09/06 gestion du User ID

    TableNo = "Sales Line";

    trigger OnRun()
    var
        lPlanning: Record "Planning Entry";
        lPlanning2: Record "Planning Entry";
    begin
    end;

    var
        tMandatory: label '%1 is mandatory';
        tErrorCapacity: label 'You cannot affect a load on this resource because you exceeded his capacity.';
        gPlanningSetup: Record "Planning Setup";
        gTimeOption: Option Suffix,Prefix;
        Text8035000: label 'Vous ne pouvez pas utiliser cette tâche car le projet auquel il appartient est terminé';
        Text8035001: label 'Vous ne pouvez pas planifier ce type de tâche';
        Text8035002: label 'La date de l''écriture planning est postérieure à la date de fin de la tâche planning';
        Text8035003: label 'La date de l''écriture planning est antérieure à la date de début de la tâche planning';


    procedure Setup()
    begin
        gPlanningSetup.Get;
    end;


    procedure Description(var pPlanning: Record "Planning Entry"; var pResLedg: Record "Res. Ledger Entry"; pShowOption: Option Quantity,Description,"Resource Name","Resource No.","Job Name","Job No.","Count",Capacity,Availability,"Load %"; var pForeColor: Integer; var pFontBold: Boolean; pShowHistory: Boolean) Return: Text[1024]
    var
        lJob: Record Job;
        lResource: Record Resource;
        lFirst: Boolean;
        lMax: Integer;
        lUserID: Code[20];
        lName: Text[50];
        lJobTask: Record "Job Task";
        lPlanningTemp: Record "Planning Entry" temporary;
    begin
        lMax := MaxStrLen(Return);
        gLoadPlanningEntry(lPlanningTemp, pPlanning, pResLedg, pShowHistory);

        if lPlanningTemp.Find('-') then begin
            if (lPlanningTemp.Count > 1) and (gTimeOption = Gtimeoption::Suffix) then
                Return := Format(lPlanningTemp.Count) + ':';
            lFirst := true;
            repeat
                if lFirst then
                    lFirst := false
                else
                    if gTimeOption = Gtimeoption::Prefix then
                        Return := CopyStr(Return + '\', 1, lMax)
                    else
                        Return := CopyStr(Return + ';', 1, lMax);
                if (lPlanningTemp."Start Time" <> 0T) and (gTimeOption = Gtimeoption::Prefix) then
                    Return := CopyStr(Return + Format(lPlanningTemp."Start Time", 0, '<Hours24,2>:<Minutes,2> '), 1, lMax);
                //USER
                if lResource.Get(lPlanningTemp."No.") then begin
                    if lResource."User ID" <> '' then
                        lUserID := lResource."User ID"
                    else
                        lUserID := lPlanningTemp."No.";
                    lName := lResource.Name;
                end else begin
                    lUserID := lPlanningTemp."No.";
                    lName := '?';
                end;

                if lPlanningTemp.Private and (UpperCase(lUserID) <> UpperCase(UserId)) then
                    Return := CopyStr(Return + lPlanningTemp.FieldCaption(Private), 1, lMax)
                else
                    case pShowOption of
                        Pshowoption::Description:
                            Return := CopyStr(Return + lPlanningTemp.Description, 1, lMax);
                        Pshowoption::"Resource No.":
                            Return := CopyStr(Return + lPlanningTemp."No.", 1, lMax);
                        Pshowoption::"Resource Name":
                            Return := CopyStr(Return + lName, 1, lMax);
                        Pshowoption::"Job No.":
                            Return := CopyStr(Return + lPlanningTemp."Job No." + ' ' + lPlanningTemp.Description, 1, lMax);
                        Pshowoption::"Job Name":
                            if lPlanningTemp."Job No." = '' then
                                Return := CopyStr(Return + lPlanningTemp.Description, 1, lMax)
                            else
                                if lJob.Get(lPlanningTemp."Job No.") then
                                    Return := CopyStr(Return + lJob.Description + ' ' + lPlanningTemp.Description, 1, lMax)
                                else
                                    Return := CopyStr(Return + '?', 1, lMax);
                    end;
                if (lPlanningTemp."Start Time" <> 0T) and (gTimeOption = Gtimeoption::Suffix) then
                    Return := CopyStr(Return + ' (' + Format(lPlanningTemp."Start Time", 0, '<Hours24,2>:<Minutes,2> ') + ') ', 1, lMax);
                if lPlanningTemp."Job No." = '' then
                    pForeColor := 0 //??
                else
                    if lPlanningTemp."Job Task No." = '' then
                        pForeColor := 0 //??
                    else
                        if not lJobTask.Get(lPlanningTemp."Job No.", lPlanningTemp."Job Task No.") then
                            pForeColor := 0 //??
                        else
                            ;

                if (lPlanningTemp."Job No." = '') and (lPlanningTemp."Job Task No." = '') or
                   not lPlanningTemp.Private and (lPlanningTemp."Resource Group No." = '') then
                    pFontBold := true;

                SetForeColorBold(lPlanningTemp, pForeColor, pFontBold);
            until lPlanningTemp.Next = 0;
            if pForeColor < 0 then
                pForeColor := 0;
        end;
    end;


    procedure DateTitle(var pDate: Record Date; var pText: Text[30]; var pForeColor: Integer)
    var
        lCalendarMgt: Codeunit "Calendar Management";
        lDateFormula: DateFormula;
        lCalendarDescription: Text[30];
    begin
        pForeColor := 0;
        if (pDate."Period No." = 1) then begin
            Evaluate(lDateFormula, '<1W>');
            pText := CopyStr(Format(lDateFormula), 2, 1) + Format(Date2dwy(pDate."Period Start" + 1, 2));
        end;
        //#8398
        //IF gPlanningSetup."Base Calendar Code" <> '' THEN
        if gPlanningSetup."Base Calendar Code" = '' then begin
            if (pDate."Period Type" = pDate."period type"::Date) and (Date2dwy(pDate."Period Start", 1) in [6, 7]) then
                pForeColor := gPlanningSetup."NonWorking Color";
        end  //GL2024else
             //#8398//
             /*  //GL2024 if lCalendarMgt.CheckDateStatus(gPlanningSetup."Base Calendar Code", pDate."Period Start", lCalendarDescription) then begin
                   pForeColor := gPlanningSetup."NonWorking Color";
                   if lCalendarDescription <> '' then
                       pText := lCalendarDescription;
               end;*/
    end;


    procedure DateTitle2(var pDate: Record Date; var pText: Text[30]; var pForeColor: Integer)
    var
        lCalendarMgt: Codeunit "Calendar Management";
        lDateFormula: DateFormula;
        lCalendarDescription: Text[30];
    begin
        pForeColor := 0;
        if pDate."Period No." = 1 then begin
            Evaluate(lDateFormula, '<1W>');
            pText := CopyStr(Format(lDateFormula), 2, 1) + Format(Date2dwy(pDate."Period Start" + 1, 2));
        end;
        pText := pDate."Period Name" + ' ' + pText;
        //#8398
        //IF gPlanningSetup."Base Calendar Code" <> '' THEN
        if gPlanningSetup."Base Calendar Code" = '' then begin
            if (pDate."Period Type" = pDate."period type"::Date) and (Date2dwy(pDate."Period Start", 1) in [6, 7]) then
                pForeColor := gPlanningSetup."NonWorking Color";
        end; //GL2024 else
             //#8398//
             //GL2024  if lCalendarMgt.CheckDateStatus(gPlanningSetup."Base Calendar Code", pDate."Period Start", lCalendarDescription) then begin
             //GL2024  pForeColor := gPlanningSetup."NonWorking Color";
             //GL2024    if lCalendarDescription <> '' then
             //GL2024      pText := lCalendarDescription;
             //GL2024end;
    end;


    procedure CheckInsert(var pPlanning: Record "Planning Entry"; pDate: Date; pDefault: Record "Planning Entry")
    var
        lSalesLine: Record "Sales Line";
        lResource: Record Resource;
    begin
        with pPlanning do begin
            "Entry No." := 0;
            CheckAssignDefault(pPlanning, pDate, pDefault);


            if Quantity = 0 then
                Error(tMandatory, FieldCaption(Quantity));
            if "Resource Group No." = '' then
                Error(tMandatory, FieldCaption("Resource Group No."));
            if Description = '' then
                Error(tMandatory, FieldCaption(Description));
            if "Prod. Posting Group" = '' then
                Error(tMandatory, FieldCaption("Prod. Posting Group"));

            if ("No." = '') and ("Job Task No." = '') then
                Error(tMandatory, FieldCaption("No."));
            if ("Job No." = '') and not Private then
                Error(tMandatory, FieldCaption("Job No."));

            Insert(true);
        end;
    end;


    procedure CheckAssignDefault(var pPlanning: Record "Planning Entry"; pDate: Date; pDefault: Record "Planning Entry")
    var
        lSalesLine: Record "Sales Line";
        lResource: Record Resource;
    begin
        with pPlanning do begin
            "Entry No." := 0;
            Date := pDate;

            if ("Project Header No." = '') then
                Validate("Project Header No.", pDefault."Project Header No.");

            if ("Planning Task No." = '') then
                Validate("Planning Task No.", pDefault."Planning Task No.");

            if "Resource Group No." = '' then
                "Resource Group No." := pDefault."Resource Group No.";

            if "Prod. Posting Group" = '' then
                Validate("Prod. Posting Group", pDefault."Prod. Posting Group");

            if Quantity = 0 then
                Quantity := GetDefaultQty(pPlanning);

            if Description = '' then
                Description := pDefault.Description;

            if "No." = '' then
                "No." := pDefault."No.";

            if ("Job No." = '') then
                Validate("Job No.", pDefault."Job No.");
        end;
    end;


    procedure GetDefaultQty(pPlanning: Record "Planning Entry"): Decimal
    var
        lRes: Record Resource;
        lResCapacity: Record "Res. Capacity Entry";
        lResourceGroup: Record "Resource Group";
        lPlanningEntry: Record "Planning Entry";
    begin
        if (pPlanning.Quantity <> 0) then
            exit(pPlanning.Quantity);
        if lResCapacity.ReadPermission then begin
            lResCapacity.SetRange("Resource No.", pPlanning."No.");
            lResCapacity.SetRange(Date, pPlanning.Date);
            if lResCapacity.FindFirst then begin
                lPlanningEntry.SetCurrentkey(Type, "No.", Date, "Start Time", Private);
                if pPlanning.Type = pPlanning.Type::Person then
                    lPlanningEntry.SetRange(Type, pPlanning.Type::Person)
                else
                    lPlanningEntry.SetRange(Type, pPlanning.Type::Machine);
                lPlanningEntry.SetRange("No.", pPlanning."No.");
                lPlanningEntry.SetRange(Date, pPlanning.Date);
                lPlanningEntry.CalcSums(Quantity);
                if lResCapacity.Capacity - lPlanningEntry.Quantity > 0 then
                    exit(lResCapacity.Capacity - lPlanningEntry.Quantity)
                else
                    Error(tErrorCapacity);
            end;
        end;
        if lResourceGroup.Get then
            exit(lResourceGroup."Default Time per Day (h)");
        exit(0);
    end;


    procedure SetForeColorBold(var pPlanning: Record "Planning Entry"; var pForeColor: Integer; var pFontBold: Boolean)
    var
        lWorkType: Record "Work Type";
    begin
        if pPlanning.Private or (pPlanning.Quantity = 0) then
            exit;

        if lWorkType.Get(pPlanning."Work Type Code") and (lWorkType."Planning Color" <> 0) then begin
            if pForeColor = 0 then
                pForeColor := lWorkType."Planning Color"
            else
                if pForeColor <> lWorkType."Planning Color" then
                    pForeColor := -1;
        end;

        if (pPlanning."Job No." = '') or
           not pPlanning.Private and (pPlanning."Prod. Posting Group" = '') or
           (pPlanning.Status = pPlanning.Status::Suggested) then
            pFontBold := true;
    end;


    procedure CalcBalance(var pRec: Record "Planning Entry"; pxRec: Record "Planning Entry"; var pTotalBalance: Decimal; var pShowTotalBalance: Boolean)
    var
        lRec: Record "Planning Entry";
    begin
        lRec.CopyFilters(pRec);
        lRec.FilterGroup(2);
        lRec.SetRange("Responsibility Center");
        lRec.FilterGroup(0);
        pShowTotalBalance := lRec.CalcSums(Quantity);

        if not pShowTotalBalance then begin
            lRec.SetCurrentkey(
                        "Job No.", "Project Header No.", "Job Task No.", Status, "Resource Group No.", Type, "No.", Date,
                        Private, "Prod. Posting Group", "Employee Absence Entry No.");
            pShowTotalBalance := lRec.CalcSums(Quantity);
        end;

        if pShowTotalBalance then begin
            pTotalBalance := lRec.Quantity;
            if pRec."Entry No." = 0 then
                pTotalBalance := pTotalBalance + pxRec.Quantity;
        end;
    end;


    procedure SetTimeOption(pTimeOption: Option)
    begin
        gTimeOption := pTimeOption;
    end;


    procedure InitTempTable(var pRec: Record "Planning Task Buffer")
    var
        lProjectHeader: Record "Planning Header";
    begin
        pRec.DeleteAll;
        lProjectHeader.SetFilter("Version No.", '<>0');
        if pRec.GetFilter("Job No.") <> '' then
            lProjectHeader.SetFilter("Job No.", pRec.GetFilter("Job No."))
        else
            lProjectHeader.SetRange("Job No.");
        if lProjectHeader.FindSet then
            repeat
                pRec."Project Header No." := lProjectHeader."No.";
                pRec."WBS Code" := '  0';
                pRec."Task No." := '';
                pRec.Type := pRec.Type::"Group Task";
                pRec.Description := lProjectHeader.Description;
                pRec."Responsibility Center" := lProjectHeader."Responsibility Center";
                pRec."Job No." := lProjectHeader."Job No.";
                pRec."Person Responsible" := lProjectHeader."Person Responsible";
                lProjectHeader.CalcFields("Version No.");
                pRec."Version No." := lProjectHeader."Version No.";
                pRec.Insert;
            until lProjectHeader.Next = 0;
    end;


    procedure IsCollapsed(var pRec: Record "Planning Task Buffer") Return: Boolean
    var
        lRec: Record "Planning Line";
        lCurrRec: Record "Planning Task Buffer";
    begin
        if pRec.Type <> pRec.Type::"Group Task" then
            exit(false);
        lCurrRec := pRec;
        lRec.SetCurrentkey("Project Header No.", "WBS Code");
        lRec.TransferFields(pRec, true);
        if lCurrRec."Task No." = '' then begin
            lRec.SetRange("Project Header No.", pRec."Project Header No.");
            if lRec.IsEmpty then
                exit(false);
            if (pRec.Next = 0) or (pRec."Project Header No." <> lCurrRec."Project Header No.") then
                Return := true
            else
                Return := (pRec.Indentation <= lCurrRec.Indentation); // Children not in TEMPORARY
        end else begin
            if ((lRec.Next = 0) or (lRec."Project Header No." <> lCurrRec."Project Header No.")
               or (lRec.Indentation <= lCurrRec.Indentation)) then // Has no children
                Return := false
            else
                if (pRec.Next = 0) or (pRec."Project Header No." <> lCurrRec."Project Header No.") then
                    Return := true
                else
                    Return := (pRec.Indentation <= lCurrRec.Indentation); // Children not in TEMPORARY
        end;
        pRec := lCurrRec; // Restore TEMPORARY
    end;


    procedure IsExpanded(var pRec: Record "Planning Task Buffer") Return: Boolean
    var
        lCurrRec: Record "Planning Task Buffer";
    begin
        if pRec.Type <> pRec.Type::"Group Task" then
            exit(false);
        lCurrRec := pRec;
        if (pRec.Next = 0) or (pRec."Project Header No." <> lCurrRec."Project Header No.") then
            Return := false
        else
            Return := (pRec.Indentation > lCurrRec.Indentation);
        pRec := lCurrRec;
    end;


    procedure ToggleExpandCollapse(var pRec: Record "Planning Task Buffer"; pExpandAll: Boolean; ExpansionStatus: Option ,Expand,Collapse)
    var
        lRec: Record "Planning Line";
        lxRec: Record "Planning Task Buffer";
        lWBSManagement: Codeunit "WBS Management";
        PlanningLine: Record "Planning Line";
    begin
        //IF ExpansionStatus = 0 THEN
        //  EXIT;
        lxRec := pRec;
        if (ExpansionStatus = Expansionstatus::Expand) /*OR pExpandAll*/ then begin
            lRec.SetCurrentkey("Project Header No.", "WBS Code");
            lRec.SetRange("Project Header No.", pRec."Project Header No.");
            PlanningLine.TransferFields(pRec, true);
            if pExpandAll then begin
                lRec.SetRange(Indentation, pRec.Indentation, 9999);
                lRec.Find('-');
            end else begin
                lRec.SetRange(Indentation, pRec.Indentation + 1);
                lRec.SetFilter("WBS Code", lWBSManagement.gGetFilter(PlanningLine));
            end;
            while lRec.Next <> 0 do begin
                pRec.TransferFields(lRec, true);
                if pRec.Insert then;
            end;
        end else
            if ExpansionStatus = Expansionstatus::Collapse then begin
                while (pRec.Next <> 0) and (pRec.Indentation > lxRec.Indentation) do
                    pRec.Delete;
            end;
        pRec := lxRec;

    end;


    procedure ExpandAll(var pRec: Record "Planning Task Buffer"; pExpand: Boolean)
    var
        lRec: Record "Planning Line";
        lxRec: Record "Planning Task Buffer";
    begin
        lxRec := pRec;
        //IF pRec.GETVIEW <> '' THEN
        //  lRec.SETVIEW(pRec.GETVIEW);
        //pRec.RESET;
        //pRec.DELETEALL;
        //pRec.SETVIEW(lRec.GETVIEW);
        if not pExpand then
            lRec.SetRange("Task No.", '');
        lRec.SetCurrentkey("Project Header No.", "WBS Code");
        if lRec.FindSet then
            repeat
                pRec.TransferFields(lRec, true);
                if not pRec.Insert then
                    pRec.Modify;
            until lRec.Next = 0;
        pRec := lxRec;
    end;


    procedure gUpdatePlanningEntry(var pRec: Record "Planning Entry"; pxRec: Record "Planning Entry")
    var
        lPlanningLine: Record "Planning Line";
    begin
        with pRec do begin
            if "Planning Task No." <> '' then begin
                lPlanningLine.Get("Planning Task No.");
                if lPlanningLine.Type in [lPlanningLine.Type::"Group Task", lPlanningLine.Type::" "] then
                    Error(Text8035001);

                lProjectHeaderHerited(pRec, lPlanningLine);

                gSetDescription(pRec, pxRec);
                pRec.Validate("Job No.", lPlanningLine."Job No.");
                pRec.Validate("Job Task No.", lPlanningLine."Job Task No.");
                pRec.Validate("Prod. Posting Group", lPlanningLine."Gen. Prod. Posting Group");
                pRec.Validate("Work Type Code", lPlanningLine."Work Type Code");

                pRec."Source Record ID" := lPlanningLine."Source Record ID";
                lPlanningLine.CalcFields("Source Line No.");
                pRec."Source Line No." := lPlanningLine."Source Line No.";
            end;
        end;
    end;

    local procedure lProjectHeaderHerited(var pRec: Record "Planning Entry"; pPlanningLine: Record "Planning Line")
    var
        lProjectHeader: Record "Planning Header";
    begin
        lProjectHeader.Get(pPlanningLine."Project Header No.");
        //lProjectHeader.TESTFIELD(Status,lProjectHeader.Status::Release);
        if lProjectHeader.Type = lProjectHeader.Type::Finished then
            Error(Text8035000);
        pRec."Project Header No." := pPlanningLine."Project Header No.";
        pRec."Responsibility Center" := lProjectHeader."Responsibility Center";
        case lProjectHeader.Type of
            lProjectHeader.Type::Simulation:
                pRec.Status := pRec.Status::Suggested;
            lProjectHeader.Type::Scheduled:
                pRec.Status := pRec.Status::Confirm;
        end;
    end;


    procedure gDateVerify(var pRec: Record "Planning Entry"; pDisplay: Boolean)
    var
        lPlanningLine: Record "Planning Line";
    begin
        if not pDisplay then
            exit;
        if lPlanningLine.Get(pRec."Planning Task No.") then begin
            if ((pRec.Date < lPlanningLine."Starting Date") and (lPlanningLine."Starting Date" <> 0D)) or
               ((pRec.Date < lPlanningLine."Early Starting Date") and (lPlanningLine."Early Starting Date" <> 0D)) then
                pRec.FieldError(Date, Text8035003);
            if ((pRec.Date > lPlanningLine."Ending Date") and (lPlanningLine."Ending Date" <> 0D)) or
               ((pRec.Date > lPlanningLine."Early Ending Date") and (lPlanningLine."Early Ending Date" <> 0D)) then
                pRec.FieldError(Date, Text8035002);
        end;
    end;


    procedure gSetDescription(var pRec: Record "Planning Entry"; pxRec: Record "Planning Entry")
    var
        lPlanningLine: Record "Planning Line";
    begin
        if not lPlanningLine.Get(pxRec."Planning Task No.") then
            lPlanningLine.Init;
        if (pxRec.Description = lPlanningLine.Description) or (pRec.Description = '') then begin
            lPlanningLine.Get(pRec."Planning Task No.");
            pRec.Description := lPlanningLine.Description;
        end;
    end;


    procedure gGetResourceAssign(var pResources: Record "Resource / Resource Group" temporary; pTaskNos: Record "Planning Line")
    var
        lPlanningLineAssign: Record "Planning Task Assignment";
        lResource: Record Resource;
        lText: Text[255];
        lResourceGp: Record "Resource / Resource Group";
    begin
        with pResources do begin
            FilterGroup(4);
            lText := GetFilter("Date Filter");
            FilterGroup(0);
            SetFilter("Date Filter", lText);
            SetRange("Task No. Filter", pTaskNos."Task No.");
            lPlanningLineAssign.SetRange("Project Header No.", pTaskNos."Project Header No.");
            lPlanningLineAssign.SetRange("Task No.", pTaskNos."Task No.");
            DeleteAll;
            if pTaskNos.Type = pTaskNos.Type::"Group Task" then
                exit;
            if lPlanningLineAssign.FindSet(false, false) then begin
                repeat
                    case lPlanningLineAssign.Type of
                        lPlanningLineAssign.Type::Resource:
                            begin
                                if lResource.Get(lPlanningLineAssign."No.") then begin
                                    "Resource No." := lResource."No.";
                                    "Resource Group No." := lResource."Resource Group No.";
                                    if Insert then;
                                    pResources.Mark(true);
                                end;
                            end;
                        lPlanningLineAssign.Type::"Resource Group":
                            begin
                                lResourceGp.SetRange("Resource Group No.", lPlanningLineAssign."No.");
                                if lResourceGp.FindSet(false, false) then begin
                                    "Resource Group No." := lResourceGp."Resource Group No.";
                                    "Resource No." := '';
                                    Insert;
                                    Mark(true);
                                    repeat
                                        pResources.TransferFields(lResourceGp, true);
                                        if pResources.Insert then;
                                        pResources.Mark(true);
                                    until lResourceGp.Next = 0;
                                end;
                            end;
                    end;
                until lPlanningLineAssign.Next = 0;
            end;
        end;
    end;


    procedure gLoadPlanningEntry(var pPlanningTemp: Record "Planning Entry" temporary; var pPlanning: Record "Planning Entry"; var pResLedgEntry: Record "Res. Ledger Entry"; pShowHistory: Boolean)
    var
        lFilter: Text[1024];
        lProgress: Codeunit "Progress Dialog2";
    begin
        lFilter := pPlanningTemp.GetView();
        pPlanningTemp.Reset;
        pPlanningTemp.DeleteAll;
        if not pPlanning.IsEmpty then begin
            pPlanning.FindSet;
            repeat
                pPlanningTemp := pPlanning;
                pPlanningTemp.Insert;
            until pPlanning.Next = 0
        end;
        if pShowHistory then begin
            pResLedgEntry.SetRange("Planning Source", true);
            if not pResLedgEntry.IsEmpty then begin
                pResLedgEntry.SetCurrentkey("Entry Type", "Planning Source", Chargeable, "Unit of Measure Code", "Resource Group No.",
                                            "Resource No.", "Planning Task No.", "Posting Date");
                pResLedgEntry.FindSet;
                repeat
                    if Evaluate(pPlanningTemp."Entry No.", pResLedgEntry."External Document No.") then begin
                        pPlanningTemp."Entry No." := pPlanningTemp."Entry No." * -1;
                        pPlanningTemp.Date := pResLedgEntry."Posting Date";
                        pPlanningTemp."No." := pResLedgEntry."Resource No.";
                        pPlanningTemp."Resource Group No." := pResLedgEntry."Resource Group No.";
                        pPlanningTemp.Description := pResLedgEntry.Description;
                        pPlanningTemp."Work Type Code" := pResLedgEntry."Work Type Code";
                        pPlanningTemp."Job No." := pResLedgEntry."Job No.";
                        pPlanningTemp.Validate(Quantity, pResLedgEntry."Quantity (Base)");
                        pPlanningTemp."Start Time" := pResLedgEntry."Start Time";
                        pPlanningTemp."Employee Absence Entry No." := pResLedgEntry."Employee Absence Entry No.";
                        pPlanningTemp."Project Header No." := pResLedgEntry."Project Header No.";
                        pPlanningTemp."Planning Task No." := pResLedgEntry."Planning Task No.";
                        pPlanningTemp."Person Responsible" := pResLedgEntry."Responsable Person";
                        pPlanningTemp."Prod. Posting Group" := pResLedgEntry."Gen. Prod. Posting Group";
                        pPlanningTemp.Status := pPlanningTemp.Status::Posted;
                        if pPlanningTemp.Insert then;
                    end;
                until pResLedgEntry.Next = 0;
            end;
        end;
        pPlanningTemp.SetView(lFilter);
    end;
}

