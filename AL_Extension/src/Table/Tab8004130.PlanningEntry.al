Table 8004130 "Planning Entry"
{
    // //PLANNING_TASK CW 12/07/09 +"Link To RecordID" + key + "Job Task No." + SIFT key
    // +Duration for OutlookIntegration
    // //+JOB+ MB 11/07/07 MAJ job task no avec default job task sur validate Job No.
    // //PLANNING CW 16/02/00 Inspirée de Ecriture budget
    //                        OnInsert attribue N° séquence
    // //PERF MB 22/08/06 MAJ SIFT Index
    // //USER MB 18/09/06 gestion du User ID

    Caption = 'Planning Entry';
    // DrillDownPageID = 8004130;
    //LookupPageID = 8004130;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            begin
                if not Job.Get("Job No.") then begin
                    Job.Init;
                    "Job Task No." := '';
                end else
                    Validate("Job Task No.", Job.gGetDefaultJobTask);

                Job.TestField(Blocked, Job.Blocked::" ");

                "Responsibility Center" := Job."Responsibility Center";
                //#8971
                Private := "Job No." = '';
                //#8971//
            end;
        }
        field(4; Type; Option)
        {
            Caption = 'Resource Type';
            OptionCaption = 'Person,Machine';
            OptionMembers = Person,Machine;

            trigger OnValidate()
            begin
                if (xRec.Type <> Type) then begin
                    "No." := '';
                    "Resource Group No." := '';
                end;
            end;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Resource."No." where(Type = field(Type),
                                                  Blocked = const(False));

            trigger OnValidate()
            begin
                if "No." = '' then
                    exit;

                Resource.Get("No.");
                Resource.TestField(Blocked, false);
                if "Resource Group No." = '' then
                    "Resource Group No." := Resource."Resource Group No.";
                if "Prod. Posting Group" = '' then
                    "Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
            end;
        }
        field(9; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                gPlanEntryMgt.gDateVerify(Rec, CurrFieldNo = FieldNo(Date));
            end;
        }
        field(10; "Resource Group No."; Code[20])
        {
            Caption = 'Resource Group No.';
            TableRelation = "Resource Group";

            trigger OnValidate()
            var
                lResourceGroup: Record "Resource Group";
            begin
                //"No." := "Resource Group No.";
                if "Prod. Posting Group" = '' then begin
                    lResourceGroup.Get("Resource Group No.");
                    if lResourceGroup."Gen. Prod. Posting Group" <> '' then
                        "Prod. Posting Group" := lResourceGroup."Gen. Prod. Posting Group";
                end;
            end;
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Duration := Quantity * 3600000; // Hours > Milliseconds
            end;
        }
        field(12; Duration; Duration)
        {
            Caption = 'Duration';

            trigger OnValidate()
            var
                ltNegative: label 'Information that you have entered in this field will cause the duration to be negative which is not allowed. Please modify the ending date/time value.';
                ltLessThanOneMinute: label 'Information that you have entered in this field will cause the duration to be less than 1 minute, which is not allowed. Please modify the ending date/time value.';
                ltMoreThanTenYears: label 'Information that you have entered in this field will cause the duration to be more than 10 years, which is not allowed. Please modify the ending date/time value.';
            begin
                if Duration < 0 then
                    Error(ltNegative);

                if Duration < (60 * 1000) then
                    Error(ltLessThanOneMinute);

                if Duration > (CreateDatetime(Today + 3650, 0T) - CreateDatetime(Today, 0T)) then
                    Error(ltMoreThanTenYears);
                Quantity := ROUND(Duration / 3600000, 0.01); // Hours > Milliseconds
            end;
        }
        field(14; "User ID"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(21; "Quantity Deleted"; Decimal)
        {
            Caption = 'Quantity Deleted';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Duration := Quantity * 3600000; // Hours > Milliseconds
            end;
        }
        field(100; "Source Record ID"; RecordID)
        {
            Caption = 'Source Record ID';

            trigger OnLookup()
            begin
                //#9082
                fSourceIDLookup();
                //#9082//
            end;
        }
        field(101; "Source Line No."; Integer)
        {
            Caption = 'N° ligne document origine';
            FieldClass = Normal;

            trigger OnLookup()
            var
                lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
            begin
                lPlanningRecIDMgt.gPlanningSourceLineLookUp(Rec);
            end;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));

            trigger OnValidate()
            var
                lJobTask: Record "Job Task";
                lxJobTask: Record "Job Task";
            begin
                if "Job Task No." <> '' then begin
                    lJobTask.Get("Job No.", "Job Task No.");
                    lJobTask.TestField("Job Task Type", lJobTask."job task type"::Posting);
                end;
            end;
        }
        field(8003902; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                Text010: label 'Do you want to continue?';
                Text027: label 'Your identification is set up to process from %1 %2 only.';
                lRespCenter: Record "Responsibility Center";
                tRespCenter: label '%1 modification can change the numbering.';
                lUserMgt: Codeunit "User Setup Management";
            begin
                if not lUserMgt.CheckRespCenter(0, "Responsibility Center") then
                    Error(
                      Text027,
                      lRespCenter.TableCaption, lUserMgt.GetServiceFilter());
            end;
        }
        field(8003907; "Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(8004130; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8004131; "Start Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(8004132; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Confirm,Suggested,Deleted,Posted';
            OptionMembers = Confirm,Suggested,Deleted,Posted;

            trigger OnValidate()
            begin
                if (xRec.Status <> Status) then begin
                    if Status = Status::Deleted then begin
                        if (xRec.Status <> Status::Deleted) then begin
                            "Quantity Deleted" := Quantity;
                            Quantity := 0;
                        end;
                    end else
                        if xRec.Status = xRec.Status::Deleted then
                            FieldError(Status, tStatus);
                end;
            end;
        }
        field(8004136; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            InitValue = true;
        }
        field(8004137; Private; Boolean)
        {
            Caption = 'Private';

            trigger OnValidate()
            var
                lResource: Record Resource;
            begin
                if (Private <> xRec.Private) then
                    //USER
                    if lResource.Get("No.") then begin
                        if (lResource."User ID" <> UpperCase(UserId)) then
                            FieldError(Private, tOnlyUserID);
                    end else
                        if ("No." <> UpperCase(UserId)) then
                            FieldError(Private, tOnlyUserID);
                //USER//
            end;
        }
        field(8004138; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;
        }
        field(8004139; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Filter';
            FieldClass = Normal;
            TableRelation = "Work Type";
        }
        field(8004141; "Employee Absence Entry No."; Integer)
        {
            Caption = 'Employee Absence Entry No.';
        }
        field(8004142; "Action Code"; Code[10])
        {
            Caption = 'Action Code';
            TableRelation = Code.Code where("Table No" = const(8004130),
                                             "Field No" = const(8004142));

            trigger OnValidate()
            var
                lCode: Record "Code";
            begin
                if Description <> '' then
                    if lCode.Get(Database::"Planning Entry", FieldNo("Action Code"), xRec."Action Code") and
                       (Description <> lCode.Description) then
                        exit;
                if lCode.Get(Database::"Planning Entry", FieldNo("Action Code"), "Action Code") then
                    Description := lCode.Description;
            end;
        }
        field(8035001; "Project Header No."; Code[20])
        {
            Caption = 'Project Header No.';
            TableRelation = if ("Job No." = const('')) "Planning Header Archive"."No." where("No." = field("Project Header No."),
                                                                                            Active = const(true))
            else
            if ("Job No." = filter(<> '')) "Planning Header Archive"."No." where("No." = field("Project Header No."),
                                                                                                                                                                    Active = const(true),
                                                                                                                                                                    "Job No." = field("Job No."));
        }
        field(8035002; "Last Version Project Header"; Integer)
        {
            CalcFormula = max("Planning Header Archive"."Version No." where("No." = field("Project Header No.")));
            Caption = 'Last Version Project Header';
            FieldClass = FlowField;
        }
        field(8035003; "Planning Task No."; Text[20])
        {
            Caption = 'Planning Task No.';
            TableRelation = if ("Job No." = const(''),
                                "Project Header No." = filter(<> '')) "Planning Line Archive"."Task No." where("Project Header No." = field("Project Header No."),
                                                                                                             "Deleted Date" = const())
            else
            if ("Job No." = filter(<> ''),
                                                                                                                      "Project Header No." = filter(<> '')) "Planning Line Archive"."Task No." where("Project Header No." = field("Project Header No."),
                                                                                                                                                                                                   "Job No." = field("Job No."),
                                                                                                                                                                                                   "Deleted Date" = const())
            else
            if ("Job No." = filter(<> '')) "Planning Line Archive"."Task No." where("Job No." = field("Job No."),
                                                                                                                                                                                                                                                                              "Deleted Date" = const());
            ValidateTableRelation = false;

            trigger OnValidate()
            var
            //  lPlanningLineMgt: Codeunit "Planning Task Management";
            begin
                //#8225
                gPlanEntryMgt.gDateVerify(Rec, CurrFieldNo = FieldNo("Planning Task No."));
                //#8225//
                gPlanEntryMgt.gUpdatePlanningEntry(Rec, xRec);
            end;
        }
        field(8035004; "To Notify"; Boolean)
        {
            Caption = 'To Notify';
        }
        field(8035005; "Attached to Entry No."; Integer)
        {
            Caption = 'Attached to Entry No.';
        }
        field(8035006; "Person Responsible"; Code[20])
        {
            CalcFormula = lookup("Planning Line"."Person Responsible" where("Task No." = field("Planning Task No.")));
            Caption = 'Person Responsible';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Job No.", "Project Header No.", "Job Task No.", Status, "Resource Group No.", Type, "No.", Date, Private, "Prod. Posting Group", "Employee Absence Entry No.", "Planning Task No.")
        {
            //GL2024 Clustered = true;
            MaintainSQLIndex = false;
            SumIndexFields = Quantity;
        }
        key(STG_Key3; "Job No.", Type, "No.", Date)
        {
            MaintainSIFTIndex = false;
        }
        key(STG_Key4; Type, "No.", Date, "Start Time", Private)
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Quantity;
        }
        key(STG_Key5; "Job No.", Date)
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
        key(STG_Key6; "Resource Group No.", Date)
        {
            MaintainSIFTIndex = false;
        }
        key(STG_Key7; "Job No.", "Job Task No.", Date)
        {
            MaintainSIFTIndex = false;
        }
        key(STG_Key8; "Planning Task No.", Date)
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        lRes: Record Resource;
    begin
        if Status = Status::Posted then
            Error(tPostingError);
        //#8225
        /*
        IF (Status <> Status::Deleted) AND GetNotify(Rec) THEN BEGIN
          "To Notify"  := TRUE;
          VALIDATE(Status,Status::Deleted);
          MODIFY(TRUE);
          COMMIT;
          ERROR('');
        END;
        */
        //#8225//

    end;

    trigger OnInsert()
    var
        lPlanning: Record "Planning Entry";
        lPlanningSetup: Record "Planning Setup";
        //  lPlanningMgt: Codeunit "Planning Management";
        i: Integer;
    begin
        "User ID" := UserId;

        if ("Planning Task No." <> '') and ("Project Header No." = '') then
            Validate("Planning Task No.");

        CheckEmployeeAbsenceLedger;
        /*delete
        IF ("Planning Task No." <> '') AND (CurrFieldNo = 0) AND NOT wDisableCheckCRUD THEN BEGIN
          lPlanning.SETRANGE("Planning Task No.","Planning Task No.");
          lPlanning.SETRANGE(Date,Date);
          lPlanning.SETRANGE("Resource Group No.","Resource Group No.");
          lPlanning.SETRANGE("No.","No.");
          lPlanning.SETRANGE("Job No.","Job No.");
          lPlanning.SETRANGE("Job Task No.","Job Task No.");
          lPlanning.SETRANGE("Prod. Posting Group","Prod. Posting Group");
          lPlanning.SETRANGE("Work Type Code","Work Type Code");
          IF NOT lPlanning.ISEMPTY THEN BEGIN
            lPlanning.FINDFIRST;
            lPlanning.Quantity += Quantity;
            IF lPlanning.Quantity = 0 THEN
              lPlanning.DELETE(TRUE)
            ELSE
              lPlanning.MODIFY(TRUE);
            COMMIT;
            ERROR('');
          END;
        END;
        delete*/
        lPlanningSetup.Get;
        lPlanningSetup."Planning Entry" += 1;
        lPlanningSetup.Modify;
        "Entry No." := lPlanningSetup."Planning Entry";

    end;

    trigger OnModify()
    var
        lPlanningEntry: Record "Planning Entry";
    begin
        if Status = Status::Posted then
            Error(tPostingError);
        //#8225
        /*
        "To Notify"  := GetNotify(Rec);
        IF "To Notify" THEN BEGIN
          IF (Date <> xRec.Date) OR ("Start Time" <> xRec."Start Time") THEN BEGIN
            lPlanningEntry.TRANSFERFIELDS(Rec);
            lPlanningEntry.INSERT(TRUE);
            "Attached to Entry No." := lPlanningEntry."Entry No.";
            Date := xRec.Date;
            "Start Time" := xRec."Start Time";
            VALIDATE(Status,Status::Deleted);
            MODIFY;
          END;
        END;
        */
        //#8225//
        //#8971
        if ("Job No." <> '') or ("Job Task No." <> '') or ("Prod. Posting Group" <> '') then
            Private := false;
        //#8971//

    end;

    var
        Job: Record Job;
        Resource: Record Resource;
        ResourceGroup: Record "Resource Group";
        tOnlyUserID: label 'can be modified by UserID only';
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        TextPointage: label 'You have to select line type Totaling or Structure.';
        tAbsEmployeeLedgerExist: label 'Employee Absence Ledger exist for this date.';
        tStatus: label 'will be Posted after posting';
        gPlanEntryMgt: Codeunit "Planning Management";
        NotCheckNotify: Boolean;
        tPostingError: label 'Vous ne pouvez pas modifier une écriture planning en cours de validation';
        wDisableCheckCRUD: Boolean;


    procedure CheckEmployeeAbsenceLedger()
    var
        lPlanningEntry: Record "Planning Entry";
    begin
        //Recherche d'écritures planning pour message d'info
        if "Employee Absence Entry No." <> 0 then
            exit;
        lPlanningEntry.SetRange("No.", "No.");
        lPlanningEntry.SetRange(Type, lPlanningEntry.Type::Person);
        lPlanningEntry.SetRange(Date, Date);
        lPlanningEntry.SetRange("Employee Absence Entry No.", 1, 99999999);
        if lPlanningEntry.FindFirst then
            Message(tAbsEmployeeLedgerExist);
    end;


    procedure IsEmptyEntry(): Boolean
    begin
        exit((Status in [Status::Deleted, Status::Suggested, Status::Posted]))
    end;


    procedure GetNotify(pRec: Record "Planning Entry") return: Boolean
    var
        lResource: Record Resource;
    begin
        if Status in [Status::Suggested, Status::Deleted] then
            exit(false);

        DisableCheckNotify(NotCheckNotify);
        if NotCheckNotify then
            exit(false);

        lResource.Get("No.");
        if UpperCase(UserId) <> UpperCase(lResource."User ID") then
            exit(true);
        exit(false);
    end;


    procedure DisableCheckNotify(pDisable: Boolean): Boolean
    var
        lPlanningSetup: Record "Planning Setup";
    begin
        lPlanningSetup.Get;
        NotCheckNotify := pDisable and not (lPlanningSetup."Planning Change Notify");
        exit(NotCheckNotify);
    end;


    procedure SetCRUD(pDisable: Boolean)
    begin
        wDisableCheckCRUD := pDisable;
    end;


    procedure fSourceIDLookup()
    var
        lRecID: RecordID;
        lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
    begin
        //#9082
        if (Status <> Status::Posted) and ("Planning Task No." = '') then begin
            lPlanningRecIDMgt.gPlanningRecIDLookUp(Rec);
        end;
        //#9082//
    end;
}

