Table 8001583 "Planning Filter Header"
{
    //GL2024  ID dans Nav 2009 : "8035013"
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Job Filter"; Code[20])
        {
            Caption = 'Job No.';
            FieldClass = FlowFilter;
            TableRelation = Job;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                "Job Filter" := OnFieldClick(FieldNo("Job Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Job Filter");
                if "Job Filter" <> '' then
                    SetFilter("Job Filter", "Job Filter");
            end;
        }
        field(4; "Type Filter"; Option)
        {
            Caption = 'Resource Type';
            FieldClass = FlowFilter;
            OptionCaption = 'Person,Machine';
            OptionMembers = Person,Machine;

            trigger OnValidate()
            begin
                SetFilter("Resource Filter", Format("Resource Filter"));
            end;
        }
        field(5; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                "Resource Filter" := OnFieldClick(FieldNo("Resource Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Resource Filter");
                if "Resource Filter" <> '' then
                    SetFilter("Resource Filter", "Resource Filter");
            end;
        }
        field(9; "Date Filter"; Date)
        {
            Caption = 'Date';
            FieldClass = FlowFilter;

            trigger OnValidate()
            begin
                SetRange("Date Filter");
                if "Date Filter" <> 0D then
                    SetFilter("Date Filter", Format("Date Filter"));
            end;
        }
        field(10; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group No.';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                "Resource Group Filter" := OnFieldClick(FieldNo("Resource Group Filter"));
            end;

            trigger OnValidate()
            var
                lResourceGroup: Record "Resource Group";
            begin
                SetRange("Resource Group Filter");
                if "Resource Group Filter" <> '' then
                    SetFilter("Resource Group Filter", "Resource Group Filter");
            end;
        }
        field(100; "Source Record ID Filter"; RecordID)
        {
            Caption = 'Source Record ID';
            FieldClass = FlowFilter;

            trigger OnLookup()
            var
                lRecID: RecordID;
            //  lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
            begin
                OnFieldClick(FieldNo("Source Record ID Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Source Record ID Filter");
                if Format("Source Record ID Filter") <> '' then
                    SetFilter("Source Record ID Filter", Format("Source Record ID Filter"));
            end;
        }
        field(101; "Source Line Filter"; Integer)
        {
            Caption = 'N° ligne document origine';
            FieldClass = FlowFilter;

            trigger OnLookup()
            var
            //   lPlanningRecIDMgt: Codeunit "Planning RecordID Mgt";
            begin
                OnFieldClick(FieldNo("Source Line Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Source Line Filter");
                if Format("Source Line Filter") <> '' then
                    SetFilter("Source Line Filter", Format("Source Line Filter"));
            end;
        }
        field(1001; "Job Task Filter"; Code[20])
        {
            Caption = 'Job Task No.';
            FieldClass = FlowFilter;
            TableRelation = "Job Task";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Job Task Filter"));
            end;

            trigger OnValidate()
            var
                lJobTask: Record "Job Task";
                lxJobTask: Record "Job Task";
            begin
                SetRange("Job Task Filter");
                if Format("Job Task Filter") <> '' then
                    SetFilter("Job Task Filter", Format("Job Task Filter"));
            end;
        }
        field(8003902; "Responsibility Center Filter"; Code[10])
        {
            Caption = 'Responsibility Center';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Responsibility Center Filter"));
            end;

            trigger OnValidate()
            var
                Text010: label 'Do you want to continue?';
                Text027: label 'Your identification is set up to process from %1 %2 only.';
                lRespCenter: Record "Responsibility Center";
                tRespCenter: label '%1 modification can change the numbering.';
                lUserMgt: Codeunit "User Setup Management";
            begin
                SetRange("Responsibility Center Filter");
                if Format("Responsibility Center Filter") <> '' then
                    SetFilter("Responsibility Center Filter", Format("Responsibility Center Filter"));
            end;
        }
        field(8003907; "Prod. Posting Group Filter"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            FieldClass = FlowFilter;
            TableRelation = "Gen. Product Posting Group";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Prod. Posting Group Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Prod. Posting Group Filter");
                if Format("Prod. Posting Group Filter") <> '' then
                    SetFilter("Prod. Posting Group Filter", Format("Prod. Posting Group Filter"));
            end;
        }
        field(8004130; "Description Filter"; Text[50])
        {
            Caption = 'Description';
            FieldClass = FlowFilter;

            trigger OnValidate()
            begin
                SetRange("Description Filter");
                if Format("Description Filter") <> '' then
                    SetFilter("Description Filter", Format("Description Filter"));
            end;
        }
        field(8004131; "Start Time Filter"; Time)
        {
            Caption = 'Starting Time';
            FieldClass = FlowFilter;

            trigger OnValidate()
            begin
                SetRange("Start Time Filter");
                if Format("Start Time Filter") <> '' then
                    SetFilter("Start Time Filter", Format("Start Time Filter"));
            end;
        }
        field(8004132; "Status Filter"; Option)
        {
            Caption = 'Status';
            FieldClass = FlowFilter;
            OptionCaption = 'Confirm,Suggested,Deleted,Posted';
            OptionMembers = Confirm,Suggested,Deleted,Posted;

            trigger OnValidate()
            begin
                SetRange("Status Filter");
                if Format("Status Filter") <> '' then
                    SetFilter("Status Filter", Format("Status Filter"));
            end;
        }
        field(8004136; "Chargeable Filter"; Boolean)
        {
            Caption = 'Chargeable';
            FieldClass = FlowFilter;
            InitValue = true;

            trigger OnValidate()
            begin
                SetRange("Chargeable Filter");
                if Format("Chargeable Filter") <> '' then
                    SetFilter("Chargeable Filter", Format("Chargeable Filter"));
            end;
        }
        field(8004138; "Contact Filter"; Code[20])
        {
            Caption = 'Contact No.';
            FieldClass = FlowFilter;
            TableRelation = Contact;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Contact Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Contact Filter");
                if Format("Contact Filter") <> '' then
                    SetFilter("Contact Filter", Format("Contact Filter"));
            end;
        }
        field(8004139; "Work Type Filter"; Code[10])
        {
            Caption = 'Work Type Filter';
            FieldClass = FlowFilter;
            TableRelation = "Work Type";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Work Type Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Work Type Filter");
                if Format("Work Type Filter") <> '' then
                    SetFilter("Work Type Filter", Format("Work Type Filter"));
            end;
        }
        field(8004142; "Action Filter"; Code[10])
        {
            Caption = 'Action Code';
            FieldClass = FlowFilter;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Action Filter"));
            end;

            trigger OnValidate()
            var
                lCode: Record "Code";
            begin
                SetRange("Action Filter");
                if Format("Action Filter") <> '' then
                    SetFilter("Action Filter", Format("Action Filter"));
            end;
        }
        field(8035001; "Project Header Filter"; Code[20])
        {
            Caption = 'Project Header No.';
            FieldClass = FlowFilter;
            TableRelation = "Planning Header";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Project Header Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Project Header Filter");
                if Format("Project Header Filter") <> '' then
                    SetFilter("Project Header Filter", Format("Project Header Filter"));
            end;
        }
        field(8035003; "Planning Task Filter"; Text[20])
        {
            Caption = 'Planning Task No.';
            FieldClass = FlowFilter;
            TableRelation = "Planning Line";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Planning Task Filter"));
            end;

            trigger OnValidate()
            var
            //   lPlanningLineMgt: Codeunit "Planning Task Management";
            begin
                SetRange("Planning Task Filter");
                if Format("Planning Task Filter") <> '' then
                    SetFilter("Planning Task Filter", Format("Planning Task Filter"));
            end;
        }
        field(8035006; "Responsible Filter"; Code[20])
        {
            Caption = 'Person Responsible';
            Editable = false;
            FieldClass = FlowFilter;

            trigger OnLookup()
            begin
                OnFieldClick(FieldNo("Responsible Filter"));
            end;

            trigger OnValidate()
            begin
                SetRange("Responsible Filter");
                if Format("Responsible Filter") <> '' then
                    SetFilter("Responsible Filter", Format("Responsible Filter"));
            end;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure OnFieldClick(pFieldNo: Integer) return: Text[1024]
    var
        lJob: Record Job;
        lJobTask: Record "Job Task";
        lRespCenter: Record "Responsibility Center";
        lUserMgt: Codeunit "User Setup Management";
        Text002: label 'Your identification is set up to process from %1 %2 only.';
        lResource: Record Resource;
        lResGp: Record "Resource Group";
        lProdPostGp: Record "Gen. Product Posting Group";
        lContact: Record Contact;
        lWorkType: Record "Work Type";
        lAction: Record "Action Message Entry";
        lPlanningHeader: Record "Planning Header";
        lPlanningLine: Record "Planning Line";
        lCode: Record "Code";
    begin
        case pFieldNo of
            FieldNo("Job Filter"):
                begin
                    if PAGE.RunModal(0, lJob) = Action::LookupOK then begin
                        return := GetFilterText("Job Filter", lJob."No.");
                    end;
                end;
            FieldNo("Resource Filter"):
                begin
                    if Format("Type Filter") <> '' then
                        lResource.SetFilter(Type, Format("Type Filter"));
                    if PAGE.RunModal(0, lResource) = Action::LookupOK then begin
                        return := GetFilterText("Resource Filter", lResource."No.");
                    end;

                end;
            FieldNo("Date Filter"):
                begin
                end;
            FieldNo("Resource Group Filter"):
                begin
                    if PAGE.RunModal(0, lResGp) = Action::LookupOK then begin
                        return := GetFilterText("Resource Group Filter", lResGp."No.");
                    end;
                end;
            FieldNo("Source Record ID Filter"):
                begin
                end;
            FieldNo("Source Line Filter"):
                begin
                end;
            FieldNo("Job Task Filter"):
                begin
                    if "Job Filter" <> '' then
                        lJobTask.SetFilter("Job No.", "Job Filter");
                    if PAGE.RunModal(0, lJobTask) = Action::LookupOK then begin
                        return := GetFilterText("Job Task Filter", lJobTask."Job Task No.");
                    end;
                end;
            FieldNo("Responsibility Center Filter"):
                begin
                    if PAGE.RunModal(0, lRespCenter) = Action::LookupOK then begin
                        if not lUserMgt.CheckRespCenter(0, lRespCenter.Code) then
                            Error(
                              Text002,
                              lRespCenter.TableCaption, lUserMgt.GetSalesFilter);

                        return := GetFilterText("Responsibility Center Filter", lRespCenter.Code);
                    end;
                end;
            FieldNo("Prod. Posting Group Filter"):
                begin
                    if PAGE.RunModal(0, lProdPostGp) = Action::LookupOK then begin
                        return := GetFilterText("Prod. Posting Group Filter", lProdPostGp.Code);
                    end;
                end;
            FieldNo("Contact Filter"):
                begin
                    if PAGE.RunModal(0, lContact) = Action::LookupOK then begin
                        return := GetFilterText("Contact Filter", lContact."No.");
                    end;
                end;
            FieldNo("Work Type Filter"):
                begin
                    if PAGE.RunModal(0, lWorkType) = Action::LookupOK then begin
                        return := GetFilterText("Work Type Filter", lWorkType.Code);
                    end;
                end;
            FieldNo("Action Filter"):
                begin
                    lCode.SetRange("Table No", 8004130);
                    lCode.SetRange("Field No", 8004142);
                    if PAGE.RunModal(0, lCode) = Action::LookupOK then begin
                        return := GetFilterText("Action Filter", lCode.Code);
                    end;
                end;
            FieldNo("Project Header Filter"):
                begin
                    if PAGE.RunModal(0, lPlanningHeader) = Action::LookupOK then begin
                        return := GetFilterText("Project Header Filter", lPlanningHeader."No.");
                    end;
                end;
            FieldNo("Planning Task Filter"):
                begin
                    if PAGE.RunModal(0, lPlanningLine) = Action::LookupOK then begin
                        return := GetFilterText("Planning Task Filter", lPlanningLine."Task No.");
                    end;
                end;
            FieldNo("Responsible Filter"):
                begin
                end;
        end;
    end;


    procedure InitFromPlanningEntry(var pRec: Record "Planning Entry")
    var
        lFromRef: RecordRef;
        lToRef: RecordRef;
        lFromFieldRef: FieldRef;
        lToFieldRef: FieldRef;
        i: Integer;
    begin
        lFromRef.GetTable(pRec);
        lToRef.GetTable(Rec);
        lToRef.Reset;
        for i := 2 to lToRef.FieldCount do begin
            lToFieldRef := lToRef.FieldIndex(i);
            if lFromRef.FieldExist(lToFieldRef.Number) then begin
                lFromFieldRef := lFromRef.Field(lToFieldRef.Number);
                if Format(lFromFieldRef.GetFilter) <> '' then begin
                    lToFieldRef.SetFilter(Format(lFromFieldRef.GetFilter));
                end else begin
                    lToFieldRef.SetRange();
                end;
            end;
        end;
        Rec.SetView(lToRef.GetView);
    end;


    procedure SetPLanningEntryFilter(var pRec: Record "Planning Entry")
    var
        lFromRef: RecordRef;
        lToRef: RecordRef;
        lFromFieldRef: FieldRef;
        lToFieldRef: FieldRef;
        i: Integer;
    begin
        lFromRef.GetTable(Rec);
        lToRef.GetTable(pRec);
        lToRef.Reset;
        for i := 2 to lFromRef.FieldCount do begin
            lFromFieldRef := lFromRef.FieldIndex(i);
            if lToRef.FieldExist(lFromFieldRef.Number) then begin
                lToFieldRef := lToRef.Field(lFromFieldRef.Number);
                if Format(lFromFieldRef.GetFilter) <> '' then
                    lToFieldRef.SetFilter(Format(lFromFieldRef.GetFilter))
                else
                    lToFieldRef.SetRange();
            end;
        end;
        pRec.SetView(lToRef.GetView);
    end;


    procedure SetResLedgerEntryFilter(var pRec: Record "Res. Ledger Entry")
    begin
        pRec.Reset;
        if GetFilter("Job Filter") <> '' then
            pRec.SetFilter("Job No.", GetFilter("Job Filter"));
        if GetFilter("Resource Filter") <> '' then
            pRec.SetFilter(pRec."Resource No.", GetFilter("Resource Filter"));
        if GetFilter("Date Filter") <> '' then
            pRec.SetFilter(pRec."Posting Date", GetFilter("Date Filter"));
        if GetFilter("Resource Group Filter") <> '' then
            pRec.SetFilter(pRec."Resource Group No.", GetFilter("Resource Group Filter"));
        if Format("Source Record ID Filter") <> '' then
            pRec.SetFilter(pRec."Source Record ID", Format("Source Record ID Filter"));
        if GetFilter("Source Line Filter") <> '' then
            pRec.SetFilter(pRec."Source Line No.", Format("Source Line Filter"));
        if GetFilter("Prod. Posting Group Filter") <> '' then
            pRec.SetFilter(pRec."Gen. Prod. Posting Group", GetFilter("Prod. Posting Group Filter"));
        if GetFilter("Description Filter") <> '' then
            pRec.SetFilter(pRec.Description, GetFilter("Description Filter"));
        if GetFilter("Start Time Filter") <> '' then
            pRec.SetFilter(pRec."Start Time", Format("Start Time Filter"));
        if Format("Chargeable Filter") <> '' then
            pRec.SetFilter(pRec.Chargeable, Format("Chargeable Filter"));
        //IF "Contact Filter") <> '' THEN
        //  pRec.SETFILTER(pRec."Contact No.",GETFILTER("Contact Filter"));
        if GetFilter("Work Type Filter") <> '' then
            pRec.SetFilter(pRec."Work Type Code", GetFilter("Work Type Filter"));
        //IF "Action Filter") <> '' THEN
        //  pRec.SETFILTER(pRec."Action Code",GETFILTER("Action Filter"));
        if GetFilter("Project Header Filter") <> '' then
            pRec.SetFilter(pRec."Project Header No.", GetFilter("Project Header Filter"));
        if GetFilter("Planning Task Filter") <> '' then
            pRec.SetFilter(pRec."Planning Task No.", GetFilter("Planning Task Filter"));
        if GetFilter("Responsible Filter") <> '' then
            pRec.SetFilter(pRec."Responsable Person", GetFilter("Responsible Filter"));
    end;


    procedure GetFilterText(pFilter: Text[1024]; pValue: Text[255]) return: Text[1024]
    begin
        if pFilter <> '' then
            return := pFilter + '|' + pValue
        else
            return := pValue;
    end;


    procedure GetFieldNoFromFilterToRes(pFieldNo: Integer)
    var
        lRes: Record "Res. Ledger Entry";
    begin
        /*
        CASE pFieldNo OF
          FIELDNO("Job Filter")
          FIELDNO("Type Filter")
          FIELDNO("Resource Filter")
          FIELDNO("Date Filter")
          FIELDNO("Resource Group Filter")
          FIELDNO("Source Record ID Filter")
          FIELDNO("Source Line Filter")
          FIELDNO("Job Task Filter")
          FIELDNO("Responsibility Center Filter")
          FIELDNO("Prod. Posting Group Filter")
          FIELDNO("Description Filter")
          FIELDNO("Start Time Filter")
          FIELDNO("Status Filter")
          FIELDNO("Chargeable Filter")
          FIELDNO("Contact Filter")
          FIELDNO("Work Type Filter")
          FIELDNO("Action Filter")
          FIELDNO("Project Header Filter")
          FIELDNO("Planning Task Filter")
          FIELDNO("Responsible Filter")
          ELSE Return := 0;
        END
        */

    end;
}

