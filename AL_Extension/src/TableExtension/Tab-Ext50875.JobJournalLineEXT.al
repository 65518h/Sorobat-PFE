TableExtension 50875 "Job Journal LineEXT" extends "Job Journal Line"
{
    fields
    {
        modify("Gen. Prod. Posting Group")
        {
            trigger OnafterValidate()
            VAR
                lGenProdPostingGrp: Record 251;
            BEGIN
                //POINTAGE
                IF lGenProdPostingGrp.GET("Gen. Prod. Posting Group") THEN
                    lGenProdPostingGrp.TESTFIELD(Summarize, FALSE);
                //POINTAGE//
            end;
        }
        modify("Resource Group No.")
        {
            trigger OnbeforeValidate()
            VAR
                lResourceGroup: Record 152;
                lResResGroup: Record 8004031;
            BEGIN
                //RES_GROUP
                TESTFIELD(Type, Type::Resource);
                TESTFIELD("Entry Type", "Entry Type"::Usage);
                IF ("No." <> '') AND ("Resource Group No." <> '') AND (Rec."No." = xRec."No.") THEN
                    lResResGroup.GET("No.", "Resource Group No.");
                IF lResourceGroup.GET("Resource Group No.") AND ("Gen. Prod. Posting Group" <> '') THEN
                    "Gen. Prod. Posting Group" := lResourceGroup."Gen. Prod. Posting Group";
                //RES_GROUP//
            end;
        }
        modify("Total Price (LCY)")
        {
            trigger OnbeforeValidate()
            VAR
                Currency: Record Currency;
            BEGIN
                TESTFIELD(Quantity);
                //GL2024 GetCurrency;
                InitRoundingPrecisions;
                Currency.Get("Currency Code");
                VALIDATE("Unit Price (LCY)", ROUND("Total Price (LCY)" / Quantity, Currency."Unit-Amount Rounding Precision"));
            END;
        }

        modify(Quantity)
        {
            trigger OnafterValidate()

            BEGIN
                // >> HJ DSFT 27-06-2012
                Ecart := "Quantité Theorique" - Quantity;
                IF "Quantité Theorique" <> 0 THEN "% Ecart" := Quantity / "Quantité Theorique";
                // >> HJ DSFT 27-06-2012
            END;
        }

        modify(Description)
        {
            trigger OnafterValidate()

            BEGIN
                //POINTAGE
                IF Description <> '' THEN
                    "Description setup" := Description
                ELSE
                    wMajDescription;

                //POINTAGE//
            END;

        }

        modify("Posting Date")
        {
            trigger OnbeforeValidate()

            BEGIN
                //INTERIM
                wReachVendor;
                //INTERIM//
            END;

        }
        modify("Job No.")
        {
            TableRelation = IF (Type = FILTER(Resource),
                                                                     "Entry Type" = CONST(Usage)) Job WHERE(Status = CONST(Open),
                                                                                                         Blocked = CONST(" "))
            ELSE IF (Type = FILTER(<> Resource)) Job WHERE(Status = CONST(Open), Blocked = CONST(" "), "IC Partner Code" = CONST()) ELSE IF (Type = FILTER(Resource), "Entry Type" = CONST(Sale)) Job WHERE(Status = CONST(Open), Blocked = CONST(" "), "IC Partner Code" = CONST());
            trigger OnafterValidate()

            BEGIN
                //#8108
                IF xRec."Job No." <> "Job No." THEN BEGIN
                    CLEAR("Source Record ID");
                    CLEAR("Source Line No.");
                END;
                //#8108//
            END;

        }


        field(50000; "Quantité Theorique"; Decimal)
        {
            Description = 'HJ DSFT 27-06-2012';
            Editable = false;
        }
        field(50001; Ecart; Decimal)
        {
            Description = 'HJ DSFT 27-06-2012';
            Editable = false;
        }
        field(50002; "% Ecart"; Decimal)
        {
            Description = 'HJ DSFT 27-06-2012';
        }
        field(50144; "From WIP"; Boolean)
        {
            Caption = 'From WIP';

        }
        field(50105; "Executed measurement"; Decimal)
        {
            Caption = 'Qté éxécutées';
            DataClassification = ToBeClassified;
        }
        field(8003900; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor where("External Work Force" = const(true));

            trigger OnValidate()
            begin
                //POINTAGE
                wMajDescription;
                //POINTAGE//
            end;
        }
        field(8003901; "Machine No."; Code[20])
        {
            Caption = 'Machine No.';
            TableRelation = Resource."No." where(Type = const(Machine));

            trigger OnValidate()
            begin
                //POINTAGE
                wMajDescription;
                //POINTAGE//
            end;
        }
        field(8003902; "Purch. Order No."; Code[20])
        {
            Caption = 'Purch. Order No.';
            TableRelation = "Purchase Line"."Document No." where("Document Type" = const(Order),
                                                                  "Buy-from Vendor No." = field("Vendor No."),
                                                                  "Job No." = field("Job No."),
                                                                  "Outstanding Quantity" = filter(> 0));
        }
        field(8003903; "Job Description"; Text[50])
        {
            CalcFormula = lookup(Job.Description where("No." = field("Job No.")));
            Caption = 'Job Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003906; "Quantity 1"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(1);
            Caption = 'Quantiy 1';
        }
        field(8003907; "Quantity 2"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(2);
            Caption = 'Quantiy 2';
        }
        field(8003908; "Quantity 3"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(3);
            Caption = 'Quantiy 3';
        }
        field(8003909; "Quantity 4"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(4);
            Caption = 'Quantiy 4';
        }
        field(8003910; "Quantity 5"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(5);
            Caption = 'Quantiy 5';
        }
        field(8003911; "Quantity 6"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(6);
            Caption = 'Quantiy 6';
        }
        field(8003912; "Quantity 7"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(7);
            Caption = 'Quantiy 7';
        }
        field(8003913; "Quantity 8"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(8);
            Caption = 'Quantiy 8';
        }
        field(8003914; "Quantity 9"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(9);
            Caption = 'Quantiy 9';
        }
        field(8003915; "Quantity 10"; Decimal)
        {
            //blankzero = true;
            //CaptionClass = wGetCaptionClass(10);
            Caption = 'Quantiy 10';
        }
        field(8003916; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
        }
        field(8003917; "Attached to Ledger Entry No."; Integer)
        {
            Caption = 'Attached to Ledger Entry No.';
        }
        field(8003918; "Bal. Job No."; Code[20])
        {
            Caption = 'Bal. Job No.';
            TableRelation = Job;
        }
        field(8003919; "Intervention Zone Code"; Code[10])
        {
            Caption = 'Intervention Zone Code';
            TableRelation = "Work Type".Code where("Work Time Type" = const(Transport));
        }
        field(8003920; "Intervention Zone Qty"; Decimal)
        {
            //blankzero = true;
            Caption = 'Intervention Zone Qty';
        }
        field(8003921; "Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            TableRelation = "Work Type".Code where("Work Time Type" = const(Transport));
        }
        field(8003922; "Driver Quantity"; Decimal)
        {
            //blankzero = true;
            Caption = 'Driver Quantity';
        }
        field(8003923; "Mission No."; Code[20])
        {
            Caption = 'Mission No.';
        }
        field(8003924; "Work Time Type"; Option)
        {
            Caption = 'Work Time Type';
            OptionCaption = ' ,Producted Hours,Unproduced Hours,Absence Hours,Premium,Transport,Meal';
            OptionMembers = " ","Producted Hours","Unproduced Hours","Absence Hours",Premium,Transport,Meal;
        }
        field(8003925; "Mission Code"; Code[10])
        {
            Caption = 'Mission Code';
            TableRelation = Mission;
        }
        field(8003926; "Calculated Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry".Quantity where("Job No." = field("Job No."),
                                                                 Type = filter(Item),
                                                                 "No." = field("No."),
                                                                 "Entry Type" = filter(Usage),
                                                                 "Posting Date" = field("Date Filter")));
            Caption = 'Calculated Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8003927; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(8003928; "Phys. Inventory"; Boolean)
        {
            Caption = 'Phys. Inventory';
            Editable = false;
        }
        field(8003929; "Description setup"; Text[50])
        {
            Caption = 'Description Setup';
            InitValue = '***';
        }
        field(8003930; "G/L Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'G/L Entry No.';
            TableRelation = "G/L Entry";
        }
        field(8003931; "From Company"; Text[30])
        {
            Caption = 'From Company';
            TableRelation = Company;
        }
        field(8003932; "IC Job Ledg. Entry No."; Integer)
        {
            Caption = 'IC Job Ledg. Entry No.';
        }
        field(8003933; "Receipt not Invoiced Quantity"; Decimal)
        {
            //blankzero = true;
            CalcFormula = sum("Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced" where("Job No." = field("Job No."),
                                                                                  Type = const(Item),
                                                                                  "No." = field("No."),
                                                                                  "Posting Date" = field("Date Filter")));
            Caption = 'Calculated Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004009; "Bal. Created Entry"; Boolean)
        {
            Caption = 'Bal. Created Entry';
        }
        field(8004030; "Planning Entry No."; Integer)
        {
            //blankzero = true;
            Caption = 'Planning Entry No.';
        }
        field(8004141; "Employee Absence Entry No."; Integer)
        {
            Caption = 'Employee Absence Entry No.';
        }
        field(8035001; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = if ("Job No." = filter(<> '')) "Planning Header Archive"."No." where("Job No." = field("Job No."))
            else
            if ("Job No." = const('')) "Planning Header Archive"."No.";
        }
        field(8035003; "Planning Task No."; Text[20])
        {
            Caption = 'Planning Task No.';
            TableRelation = if ("Project Header No." = filter(<> '')) "Planning Line Archive"."Task No." where("Project Header No." = field("Project Header No."))
            else
            if ("Job No." = filter(<> '')) "Planning Line Archive"."Task No." where("Job No." = field("Job No."),
                                                                                                       "Project Header No." = field("Project Header No."));

            trigger OnValidate()
            var
                lPlanningLineMgt: Codeunit "Planning Task Management";
            begin
                lPlanningLineMgt.gOnValidateJobJnlLine(Rec, CurrFieldNo);
            end;
        }
        field(8035100; "Source Record ID"; RecordID)
        {
            Caption = 'Source Record ID';

            trigger OnLookup()
            var
                lRecID: RecordID;
                lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
            begin
                if ("Planning Task No." = '') then begin
                    lPlanningRecIDMgt.gJournalRecIDLookUp(Rec);
                end;
            end;
        }
        field(8035101; "Source Line No."; Integer)
        {
            Caption = 'N° ligne document origine';

            trigger OnLookup()
            var
                lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
            begin
                lPlanningRecIDMgt.gJournalSourceLineLookUp(Rec);
            end;
        }

    }
    keys
    {

        /*GL2024  key(STG_Key3; "Journal Template Name", "Journal Batch Name", "Attached to Line No.")
          {
          }
          key(STG_Key4; Type, "No.", "Job No.", "Work Type Code", "Posting Date")
          {
          }
          key(STG_Key5; Type, "No.", "Work Type Code", "Posting Date", "Work Time Type", "Job No.")
          {
              SumIndexFields = "Quantity (Base)";
          }
          key(STG_Key6; "Journal Template Name", "Journal Batch Name", "Entry Type", "Job No.", "Posting Date", Type, "No.")
          {
          }*/
    }
    trigger OnAfterDelete()
    VAR
        lDescriptionLine: Record 8004075;
        lAnaDistribIntegr: Codeunit 8003503;
    begin
        //+REP+
        IF gAddOnLicencePermission.HasPermissionREP THEN
            lAnaDistribIntegr.DeleteAnaDistribFromJob(Rec, FALSE);
        //+REP+//
        //DESCRIPTION
        lDescriptionLine.DeleteLines(DATABASE::"Job Journal Line", 0, "Journal Template Name" + "Journal Batch Name", "Line No.");
        //DESCRIPTION//
    end;

    trigger OnBeforeModify()
    begin
        //IC
        TESTFIELD("IC Job Ledg. Entry No.", 0);
        //IC//
    end;

    trigger OnAfterInsert()
    VAR
        lIC: Record 413;
    begin
        //POINTAGE
        IF ("No." <> '') AND NOT wAnalyticalDistribution THEN BEGIN
            VALIDATE("No.");
        END;
        //#8272
        IF ("Work Type Code" <> '') THEN
            VALIDATE("Work Type Code");
        //#8272//
        //POINTAGE//
        //IC
        IF ("Job No." <> '') AND ("From Company" = '') THEN BEGIN
            Job.GET("Job No.");
            IF Job."IC Partner Code" <> '' THEN BEGIN
                lIC.GET(Job."IC Partner Code");
                "From Company" := lIC."Inbox Details";
            END;
        END;
        //IC//

    end;


    procedure wMajDescription()
    var
        lDescription: Text[1000];
    begin
        //#6670 : Remplace description par ldescription ds appel fonction

        //POINTAGE
        wNavibatSetup.GET;
        if ("Description setup" <> Description) or (Description = '') then begin
            case Type of
                Type::Resource:
                    "Description setup" := wNavibatSetup."Job Journal Line Res. Descr.";
                Type::Item:
                    "Description setup" := wNavibatSetup."Job Journal Line Item Descr.";
                Type::"G/L Account":
                    "Description setup" := wNavibatSetup."Job Journal Line G/L Descr.";
                else
                    ;
            end;

            //#6670
            //  Description := "Description setup";
            lDescription := "Description setup";
            //#6670//
            if Type = Type::"G/L Account" then
                if StrPos(lDescription, '%' + Format(Database::"G/L Account") + '.') > 0 then begin
                    if GLAcc.Get("No.") then;
                    wRecordRef.GetTable(GLAcc);
                    wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"G/L Account") + '.', GlobalLanguage);
                end;
            if Type = Type::Item then
                if StrPos(lDescription, '%' + Format(Database::Item) + '.') > 0 then begin
                    if Item.Get("No.") then;
                    wRecordRef.GetTable(Item);
                    wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Item) + '.', GlobalLanguage);
                end;
            if StrPos(lDescription, '%' + Format(Database::Vendor) + '.') > 0 then begin
                if wVendor.Get("Vendor No.") then;
                wRecordRef.GetTable(wVendor);
                wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Vendor) + '.', GlobalLanguage);
            end;
            if StrPos(lDescription, '%' + Format(Database::Job) + '.') > 0 then begin
                if Job.Get("Job No.") then;
                wRecordRef.GetTable(Job);
                wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Job) + '.', GlobalLanguage);
            end;
            if Type = Type::Resource then
                if StrPos(lDescription, '%' + Format(Database::Resource) + '.') > 0 then begin
                    if Res.Get("No.") then;
                    wRecordRef.GetTable(Res);
                    wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::Resource) + '.', GlobalLanguage);
                end;
            if StrPos(lDescription, '%' + Format(Database::"Work Type") + '.') > 0 then begin
                if WorkType.Get("Work Type Code") then;
                wRecordRef.GetTable(WorkType);
                wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"Work Type") + '.', GlobalLanguage);
            end;
            if StrPos(lDescription, '%' + Format(Database::"Resource Group") + '.') > 0 then begin
                if wResGroup.Get("Resource Group No.") then;
                wRecordRef.GetTable(wResGroup);
                wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"Resource Group") + '.', GlobalLanguage);
            end;
            if StrPos(lDescription, '%' + Format(Database::"Job Journal Line") + '.') > 0 then
                wBasic.SubstituteValues(lDescription, wRecordRef, '%' + Format(Database::"Job Journal Line") + '.', GlobalLanguage);
        end;
        //POINTAGE//

        //#6670
        Description := CopyStr(lDescription, 1, 50);
        //#6670//

        //#5957
        DeleteTruncVariable(Description);
        //#5957//
    end;


    procedure wReachVendor()
    var
        lMission: Record Mission;
    begin
        //INTERIM
        if Res.Get("No.") then begin
            if (Res.Status = Res.Status::External) and (Res.Type = Res.Type::Person) and ("Posting Date" <> 0D) then begin
                wInterim.Reset;
                wInterim.SetRange("Resource No.", "No.");
                wInterim.SetRange("Starting Date", 0D, "Posting Date");
                wInterim.SetFilter("Ending Date", '>=%1', "Posting Date");
                if wInterim.Count > 1 then begin
                    Error(Text1100280008, "No.", "Posting Date")
                end else begin
                    if not wInterim.Find('-') then
                        Error(Text1100280007, "No.", "Posting Date")
                    else begin
                        "Vendor No." := wInterim."Vendor No.";
                        "Mission No." := wInterim."Mission No.";
                        "Mission Code" := wInterim."Mission Code";
                        if lMission.Get(wInterim."Mission Code") and (lMission."Bal. Job No." <> '') then
                            "Bal. Job No." := lMission."Bal. Job No.";
                    end;
                end;
            end;
        end;
        //INTERIM//
    end;


    procedure wGetCaptionClass(pInt: Integer): Text[80]
    begin
        exit(CopyStr('8004000,' + Format(pInt) + ',' + "Journal Template Name" + ',' + "Journal Batch Name", 1, 80));
    end;


    procedure wLookUpNo(var rec: Record "Job Journal Line"; var pMultiple: Boolean): Boolean
    var
        lGLAccount: Record "G/L Account";
        lItem: Record Item;
        lRes: Record Resource;
        lInterim: Record "Interim Mission";
        lOK: Boolean;
        lFormRes: Page "Resource List";
        lFormItem: Page "Item List";
        lFormGL: Page "G/L Account List";
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lNbre: Integer;
    begin
        //MULTIPLE
        lOK := false;
        case Type of
            Type::"G/L Account":
                begin
                    Commit;
                    if "No." <> '' then begin
                        lGLAccount.Get("No.");
                        lFormGL.SetRecord(lGLAccount);
                    end;
                    lFormGL.SetTableview(lGLAccount);
                    lFormGL.LookupMode(true);
                    if lFormGL.RunModal = Action::LookupOK then begin
                        lFormGL.GetRecord(lGLAccount);
                        lOK := true;
                        Validate("No.", lGLAccount."No.");
                    end;
                end;
            Type::Item:
                begin
                    Commit;
                    if "No." <> '' then begin
                        lItem.Get("No.");
                        lFormItem.SetRecord(lItem);
                    end;
                    lFormItem.SetTableview(lItem);
                    lFormItem.LookupMode(true);
                    if lFormItem.RunModal = Action::LookupOK then begin
                        lFormItem.wSetSelectionFilter(lItem);
                        lNbre := lItem.Count;
                        if lNbre = 1 then begin
                            lFormItem.GetRecord(lItem);
                            Validate("No.", lItem."No.");
                        end else begin
                            if lNbre > 100 then
                                if not Confirm(TextToMuch, false, lNbre, lItem.TableCaption) then
                                    exit(false);
                            lFenetre.Open(TextMultiple);
                            lGetRecord.SetJobJnlLine(rec);
                            lGetRecord.CreateJobJnlLineFromItem(lItem);
                            pMultiple := true;
                            lFenetre.Close;
                        end;
                        lOK := true;
                    end;
                end;
            Type::Resource:
                begin
                    if ("Vendor No." <> '') or ("Mission No." <> '') then begin
                        if ("Vendor No." <> '') then
                            lInterim.SetRange("Vendor No.", "Vendor No.");
                        if ("Mission No." <> '') then
                            lInterim.SetRange("Mission No.", "Mission No.");
                        lInterim.SetRange("Starting Date", 0D, "Posting Date");
                        lInterim.SetFilter("Ending Date", '>=%1', "Posting Date");
                        wLookupInterim(rec, pMultiple, lOK, lInterim);
                    end else begin
                        if ("Resource Group No." <> '') then
                            lRes.SetRange("Res. Group Filter", "Resource Group No.");
                        lRes.SetFilter(Status, '%1..%2', lRes.Status::Internal, lRes.Status::External);
                        lRes.SetFilter(Type, '%1..%2', lRes.Type::Person, lRes.Type::Machine);
                        if not JobJnlTemplate.Get("Journal Template Name") then
                            JobJnlTemplate.Init;
                        //#6138
                        //        IF JobJnlTemplate.Type = JobJnlTemplate.Type::"1" THEN
                        //#6138//
                        lRes.SetRange("WT Allowed", true);
                        wLookupResource(rec, pMultiple, lOK, lRes);
                    end
                end;
        end;
        exit(lOK);
        //MULTIPLE//
    end;


    procedure wLookupResource(var rec: Record "Job Journal Line"; var pMultiple: Boolean; var pOK: Boolean; var pRes: Record Resource)
    var
        //DYS PAGE ADDON NON MIGRER
        //  lFormRes: Page 8004036;
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lNbre: Integer;
    begin
        //MULTIPLE
        if not pRes.Find('-') then
            if "No." <> '' then begin
                pRes.Get("No.");
                //lFormRes.SetRecord(pRes);
            end;
        //DYS PAGE ADDON NON MIGRER
        // lFormRes.SetTableview(pRes);
        // lFormRes.LookupMode(true);
        // //#5457
        // lFormRes.wSetSelectionNo("No.");
        // //#5457//
        // if lFormRes.RunModal = Action::LookupOK then begin
        //     lFormRes.wSetSelectionFilter(pRes);
        //     lNbre := pRes.Count;
        //     if lNbre = 1 then begin
        //         lFormRes.GetRecord(pRes);
        //         Validate("No.", pRes."No.");
        //     end
        //     else begin
        //         if lNbre > 100 then
        //             if not Confirm(TextToMuch, false, lNbre, pRes.TableCaption) then
        //                 exit;
        //         lFenetre.Open(TextMultiple);
        //         lGetRecord.SetJobJnlLine(rec);
        //         lGetRecord.CreateJobJnlLineFromRes(pRes);
        //         pMultiple := true;
        //         lFenetre.Close;
        //     end;
        pOK := true;
        //  end;
        //MULTIPLE//
    end;


    procedure wLookupInterim(var rec: Record "Job Journal Line"; var pMultiple: Boolean; var pOK: Boolean; var pInterim: Record "Interim Mission")
    var
        //DYS PAGE ADDON NON MIGRER
        //lFormInterim: Page 8004020;
        lGetRecord: Codeunit "Get Structure Item Resource";
        lFenetre: Dialog;
        lRes: Record Resource;
        lNbre: Integer;
    begin
        //MULTIPLE
        if not pInterim.Find('-') then
            if "No." <> '' then begin
                pInterim.Get("No.", "Mission No.");
                // lFormInterim.SetRecord(pInterim);
            end;
        //#5457
        pInterim.Get("No.", "Mission No.");
        //#5457//
        //DYS PAGE ADDON NON MIGRER
        // lFormInterim.SetTableview(pInterim);
        // lFormInterim.LookupMode(true);
        // if lFormInterim.RunModal = Action::LookupOK then begin
        //     lFormInterim.wSetSelectionFilter(pInterim);
        //     lNbre := pInterim.Count;
        //     if lNbre = 1 then begin
        //         lFormInterim.GetRecord(pInterim);
        //         Validate("No.", pInterim."Resource No.");
        //     end
        //     else begin
        //         if lNbre > 100 then
        //             if not Confirm(TextToMuch, false, lNbre, lRes.Type) then
        //                 exit;
        //         lFenetre.Open(TextMultiple);
        //         lGetRecord.SetJobJnlLine(rec);
        //         lGetRecord.CreateJobJnlLineFromInterim(pInterim);
        //         pMultiple := true;
        //         lFenetre.Close;
        //     end;
        //     pOK := true;
        // end;
        //MULTIPLE//
    end;


    procedure wDistribution(pAnalyticalDistribution: Boolean)
    begin
        wAnalyticalDistribution := pAnalyticalDistribution;
    end;


    procedure wCheckAnalyticalDistribution(): Boolean
    var
        lDistributionBuffer: Record "Distributed Entries Buffer";
    begin
        lDistributionBuffer.SetCurrentkey(Type);
        lDistributionBuffer.SetRange(Type, lDistributionBuffer.Type::"Job Journal");
        lDistributionBuffer.SetRange("Entry no.", "Line No.");
        lDistributionBuffer.SetRange("Journal Template Name", "Journal Template Name");
        lDistributionBuffer.SetRange("Journal Batch Name", "Journal Batch Name");
        exit(lDistributionBuffer.Find('-'));
    end;


    procedure fTravel(pResource: Record Resource; pJob: Record Job)
    var
        lTravelRelation: Record "Travel Relation";
    begin
        //+ONE+TRAVEL
        if (pResource."Travel Code" <> '') and (pJob."Travel Code" <> '') then begin
            lTravelRelation.Get(Res."Travel Code", Job."Travel Code");
            "Intervention Zone Qty" := lTravelRelation."Travel Quantity";
            "Intervention Zone Code" := lTravelRelation."Travel Work Type Code";
            "Driver Code" := lTravelRelation."Driver Work Type Code";
            "Driver Quantity" := lTravelRelation."Driver Quantity";
        end;
        //+ONE+TRAVEL//
    end;


    procedure DeleteTruncVariable(var pDescription: Text[50])
    var
        i: Integer;
        lModif: Boolean;
    begin
        //#5957
        if StrPos(pDescription, '%') = 0 then
            exit;

        lModif := false;
        i := MaxStrLen(pDescription);
        repeat
            if CopyStr(pDescription, i, 1) = '%' then begin
                pDescription := CopyStr(pDescription, 1, i - 3);
                lModif := true;
            end;
            i -= 1;
        until (i = 1) or lModif;
        //#5957//
    end;

    var
        Job: Record job;
        wResGroup: Record "Resource Group";
        wVendor: Record Vendor;
        wInterim: Record "Interim Mission";
        Text8004031: label 'Le Groupe de Ressource %1 n''est pas lié à la ressource %2';
        Text1100280008: label 'You must define one an only one mission for %1 on %2.';
        Text1100280007: label 'You must define one mission for %1 on %2.';
        wUserMgt: Codeunit "User Setup Management";
        wRecordRef: RecordRef;
        wBasic: Codeunit Basic;
        wNavibatSetup: Record NavibatSetup;
        TextMultiple: label 'Insert in progress.';
        TextToMuch: label 'Do you want to insert the %1 %2s?';
        wAnalyticalDistribution: Boolean;
        TextPointage: label 'You have to select line type Totaling, Structure,Person or Machine.';
        gPlanEntryMgt: Codeunit "Planning Management";
        gAddOnLicencePermission: Codeunit IntegrManagement;
        Res: Record 156;
        WorkType: Record 200;
        GLAcc: Record 15;
        Item: record 27;

}

