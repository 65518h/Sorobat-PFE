Table 8004170 "Job Task2"
{
    // //#5464 FL 28/01/08 "job task No" on validate et On Insert de la table
    // //JOB FL 26/06/07 +"Default Job Task"
    // //MASK CW 24/05/07 +"Mask Code"

    Caption = 'Job Task';
    //DrillDownPageID = 8004183;
    // LookupPageID = 8004183;

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Description = 'RES_USAGE';
            Editable = false;
            NotBlank = false;
            TableRelation = Job2;
        }
        field(2; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Description = 'NotBlank=No';
            NotBlank = false;

            trigger OnValidate()
            var
                Job: Record Job2;
                Cust: Record Customer;
            begin
                if "Job Task No." = '' then
                    exit;
                Job.Get("Job No.");
                //#4718
                //Job.TESTFIELD("Bill-to Customer No.");
                //Cust.GET(Job."Bill-to Customer No.");
                //#5464
                //IF Job."Job Type" <> Job."Job Type"::Internal THEN BEGIN
                if Job."Job Type" = Job."job type"::External then begin
                    //#5464//
                    Job.TestField("Bill-to Customer No.");
                    Cust.Get(Job."Bill-to Customer No.");
                end;
                //#4718//
                "Job Posting Group" := Job."Job Posting Group";
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Job Task Type"; Option)
        {
            Caption = 'Job Task Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting,Heading,Total,"Begin-Total","End-Total";

            trigger OnValidate()
            begin
                if (xRec."Job Task Type" = "job task type"::Posting) and
                   ("Job Task Type" <> "job task type"::Posting)
                then
                    if JobLedgEntriesExist or JobPlanningLinesExist then
                        Error(Text001, FieldCaption("Job Task Type"), TableCaption);

                if "Job Task Type" <> "job task type"::Posting then
                    "Job Posting Group" := '';

                Totaling := '';
            end;
        }
        field(6; "WIP-Total"; Option)
        {
            Caption = 'WIP-Total';
            OptionCaption = ' ,Total,Closed';
            OptionMembers = " ",Total,Closed;
        }
        field(7; "Job Posting Group"; Code[10])
        {
            Caption = 'Job Posting Group';
            TableRelation = "Job Posting Group2";

            trigger OnValidate()
            begin
                if "Job Posting Group" <> '' then
                    TestField("Job Task Type", "job task type"::Posting);
            end;
        }
        field(8; "WIP Method Used"; Option)
        {
            Caption = 'WIP Method Used';
            Editable = false;
            OptionCaption = ' ,Cost Value,Sales Value,Cost of Sales,Percentage of Completion,Completed Contract';
            OptionMembers = " ","Cost Value","Sales Value","Cost of Sales","Percentage of Completion","Completed Contract";
        }
        field(10; "Schedule (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Schedule Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Schedule (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Schedule (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Line Amount (LCY)" where("Job No." = field("Job No."),
                                                                             "Job Task No." = field("Job Task No."),
                                                                             "Job Task No." = field(filter(Totaling)),
                                                                             "Schedule Line" = const(true),
                                                                             "Planning Date" = field("Planning Date Filter")));
            Caption = 'Schedule (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Usage (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("Job No."),
                                                                           "Job Task No." = field("Job Task No."),
                                                                           "Job Task No." = field(filter(Totaling)),
                                                                           "Entry Type" = const(Usage),
                                                                           "Posting Date" = field("Posting Date Filter")));
            Caption = 'Usage (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Usage (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Ledger Entry2"."Line Amount (LCY)" where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Entry Type" = const(Usage),
                                                                            "Posting Date" = field("Posting Date Filter")));
            Caption = 'Usage (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Contract (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Total Cost (LCY)" where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Contract Line" = const(true),
                                                                            "Planning Date" = field("Planning Date Filter")));
            Caption = 'Contract (Total Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Contract (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = sum("Job Planning Line2"."Line Amount (LCY)" where("Job No." = field("Job No."),
                                                                             "Job Task No." = field("Job Task No."),
                                                                             "Job Task No." = field(filter(Totaling)),
                                                                             "Contract Line" = const(true),
                                                                             "Planning Date" = field("Planning Date Filter")));
            Caption = 'Contract (Total Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Contract (Invoiced Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = - sum("Job Ledger Entry2"."Line Amount (LCY)" where("Job No." = field("Job No."),
                                                                             "Job Task No." = field("Job Task No."),
                                                                             "Job Task No." = field(filter(Totaling)),
                                                                             "Entry Type" = const(Sale),
                                                                             "Posting Date" = field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Price)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Contract (Invoiced Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            CalcFormula = - sum("Job Ledger Entry2"."Total Cost (LCY)" where("Job No." = field("Job No."),
                                                                            "Job Task No." = field("Job Task No."),
                                                                            "Job Task No." = field(filter(Totaling)),
                                                                            "Entry Type" = const(Sale),
                                                                            "Posting Date" = field("Posting Date Filter")));
            Caption = 'Contract (Invoiced Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Posting Date Filter"; Date)
        {
            Caption = 'Posting Date Filter';
            FieldClass = FlowFilter;
        }
        field(20; "Planning Date Filter"; Date)
        {
            Caption = 'Planning Date Filter';
            FieldClass = FlowFilter;
        }
        field(21; Totaling; Text[250])
        {
            Caption = 'Totaling';
            TableRelation = "Job Task2"."Job Task No." where("Job No." = field("Job No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if not ("Job Task Type" in ["job task type"::Total, "job task type"::"End-Total"]) then
                    FieldError("Job Task Type");
                CalcFields(
                  "Schedule (Total Cost)",
                  "Schedule (Total Price)",
                  "Usage (Total Cost)",
                  "Usage (Total Price)",
                  "Contract (Total Cost)",
                  "Contract (Total Price)",
                  "Contract (Invoiced Price)",
                  "Contract (Invoiced Cost)");
            end;
        }
        field(22; "New Page"; Boolean)
        {
            Caption = 'New Page';
        }
        field(23; "No. of Blank Lines"; Integer)
        {
            //blankzero = true;
            Caption = 'No. of Blank Lines';
            MinValue = 0;
        }
        field(24; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
        }
        field(25; "WIP Posting Date"; Date)
        {
            Caption = 'WIP Posting Date';
            Editable = false;
        }
        field(26; "WIP %"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'WIP %';
            Editable = false;
        }
        field(27; "WIP Account"; Code[20])
        {
            Caption = 'WIP Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(28; "WIP Balance Account"; Code[20])
        {
            Caption = 'WIP Balance Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(29; "WIP Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Amount';
            Editable = false;
        }
        field(31; "Invoiced Sales Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Invoiced Sales Amount';
            Editable = false;
        }
        field(32; "Invoiced Sales Account"; Code[20])
        {
            Caption = 'Invoiced Sales Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(33; "Invoiced Sales Bal. Account"; Code[20])
        {
            Caption = 'Invoiced Sales Bal. Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(34; "Recognized Sales Amount"; Decimal)
        {
            //blankzero = true;
            Caption = 'Recognized Sales Amount';
            Editable = false;
        }
        field(35; "Recognized Sales Account"; Code[20])
        {
            Caption = 'Recognized Sales Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(36; "Recognized Sales Bal. Account"; Code[20])
        {
            Caption = 'Recognized Sales Bal. Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(37; "Recognized Costs Amount"; Decimal)
        {
            //blankzero = true;
            Caption = 'Recognized Costs Amount';
            Editable = false;
        }
        field(38; "Recognized Costs Account"; Code[20])
        {
            Caption = 'Recognized Costs Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(39; "Recognized Costs Bal. Account"; Code[20])
        {
            Caption = 'Recognized Costs Bal. Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(40; "WIP Schedule (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Schedule (Total Cost)';
            Editable = false;
        }
        field(41; "WIP Schedule (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Schedule (Total Price)';
            Editable = false;
        }
        field(42; "WIP Usage (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Usage (Total Cost)';
            Editable = false;
        }
        field(43; "WIP Usage (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Usage (Total Price)';
            Editable = false;
        }
        field(44; "WIP Contract (Total Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Contract (Total Cost)';
            Editable = false;
        }
        field(45; "WIP Contract (Total Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Contract (Total Price)';
            Editable = false;
        }
        field(46; "WIP (Invoiced Price)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP (Invoiced Price)';
            Editable = false;
        }
        field(47; "WIP (Invoiced Cost)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP (Invoiced Cost)';
            Editable = false;
        }
        field(48; "WIP Posting Date Filter"; Text[250])
        {
            Caption = 'WIP Posting Date Filter';
            Editable = false;
        }
        field(49; "WIP Planning Date Filter"; Text[250])
        {
            Caption = 'WIP Planning Date Filter';
            Editable = false;
        }
        field(50; "WIP Sales Account"; Code[20])
        {
            Caption = 'WIP Sales Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(51; "WIP Sales Balance Account"; Code[20])
        {
            Caption = 'WIP Sales Balance Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(52; "WIP Costs Account"; Code[20])
        {
            Caption = 'WIP Costs Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(53; "WIP Costs Balance Account"; Code[20])
        {
            Caption = 'WIP Costs Balance Account';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(54; "Cost Completion %"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'Cost Completion %';
            Editable = false;
        }
        field(55; "Invoiced %"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'Invoiced %';
            Editable = false;
        }
        field(60; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(61; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(62; "Outstanding Orders"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Amount (LCY)" where("Document Type" = const(Order),
                                                                                "Job No." = field("Job No."),
                                                                                "Job Task No." = field("Job Task No."),
                                                                                "Job Task No." = field(filter(Totaling))));
            Caption = 'Outstanding Orders';
            FieldClass = FlowField;
        }
        field(63; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Amt. Rcd. Not Invoiced (LCY)" where("Document Type" = const(Order),
                                                                                    "Job No." = field("Job No."),
                                                                                    "Job Task No." = field("Job Task No."),
                                                                                    "Job Task No." = field(filter(Totaling))));
            Caption = 'Amt. Rcd. Not Invoiced';
            FieldClass = FlowField;
        }
        field(50000; "Date Debut"; Date)
        {
            Description = 'HJ DSFT 01 06 2012';
        }
        field(50001; "Date Fin"; Date)
        {
            Description = 'HJ DSFT 01 06 2012';
        }
        field(50010; Predecesseur; Code[10])
        {
            Description = 'HJ DSFT 01 06 2012';
        }
        field(51000; "Importance %"; Decimal)
        {
        }
        field(51001; "Quantité Contractuelle"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Job No." = field("Job No."),
                                                           "Job Task No." = field("Job Task No."),
                                                           "Line Type" = const(Structure)));
            Caption = 'Budget Date';
            FieldClass = FlowField;
        }
        field(51002; "% Avancement"; Decimal)
        {
        }
        field(51003; "% Avancement Tâche"; Decimal)
        {
        }
        field(51004; "Quantité Restante"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Job No." = field("Job No."),
                                                                         "Job Task No." = field("Job Task No."),
                                                                         "Line Type" = const(Structure)));
            FieldClass = FlowField;
        }
        field(51005; "Quantité Réalisée"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Quantity Shipped" where("Job No." = field("Job No."),
                                                                     "Job Task No." = field("Job Task No."),
                                                                     "Line Type" = const(Structure)));
            FieldClass = FlowField;
        }
        field(51006; "Ind Début"; Code[10])
        {
        }
        field(51007; "Ind Fin"; Code[10])
        {
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8003900; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
    }

    keys
    {
        key(STG_Key1; "Job No.", "Job Task No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Job Task No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Job Task No.", Description, "Job Task Type")
        {
        }
    }

    trigger OnDelete()
    var
        JobPlanningLine: Record "Job Planning Line2";
        JobTaskDim: Record "Job Task Dimension2";
    begin
        if JobLedgEntriesExist then
            Error(Text000, TableCaption);

        JobPlanningLine.SetCurrentkey("Job No.", "Job Task No.");
        JobPlanningLine.SetRange("Job No.", "Job No.");
        JobPlanningLine.SetRange("Job Task No.", "Job Task No.");
        JobPlanningLine.DeleteAll(true);

        JobTaskDim.SetRange("Job No.", "Job No.");
        JobTaskDim.SetRange("Job Task No.", "Job Task No.");
        if not JobTaskDim.IsEmpty then
            JobTaskDim.DeleteAll;
    end;

    trigger OnInsert()
    var
        Job: Record Job2;
        Cust: Record Customer;
    begin
        LockTable;
        Job.Get("Job No.");
        if Job.Blocked = Job.Blocked::All then
            Job.TestBlocked;
        //#4718
        //#5464
        //IF Job."Job Type" <> Job."Job Type"::Internal THEN BEGIN
        if Job."Job Type" = Job."job type"::External then begin
            //#5464//
            Job.TestField("Bill-to Customer No.");
            Cust.Get(Job."Bill-to Customer No.");
        end;
        //#4718//
        InitWIPFields;
        "Schedule (Total Cost)" := 0;
        "Schedule (Total Price)" := 0;
        "Usage (Total Cost)" := 0;
        "Usage (Total Price)" := 0;
        "Contract (Total Cost)" := 0;
        "Contract (Total Price)" := 0;
        "Contract (Invoiced Price)" := 0;
        "Contract (Invoiced Cost)" := 0;

        DimMgt.InsertJobTaskDim("Job No.", "Job Task No.", "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;

    var
        Text000: label 'You cannot delete %1 because one or more entries are associated.';
        Text001: label 'You cannot change %1 because one or more entries are associated with this %2.';
        DimMgt: Codeunit DimensionManagement;
        //   gJobTaskMgt: Codeunit "Job Task Management";
        gLicensePermission: Record "License Permission";

    local procedure JobLedgEntriesExist(): Boolean
    var
        JobLedgEntry: Record "Job Ledger Entry2";
    begin
        JobLedgEntry.SetCurrentkey("Job No.", "Job Task No.");
        JobLedgEntry.SetRange("Job No.", "Job No.");
        JobLedgEntry.SetRange("Job Task No.", "Job Task No.");
        exit(JobLedgEntry.Find('-'))
    end;


    procedure JobPlanningLinesExist(): Boolean
    var
        JobPlanningLine: Record "Job Planning Line2";
    begin
        JobPlanningLine.SetCurrentkey("Job No.", "Job Task No.");
        JobPlanningLine.SetRange("Job No.", "Job No.");
        JobPlanningLine.SetRange("Job Task No.", "Job Task No.");
        exit(JobPlanningLine.Find('-'))
    end;


    procedure Caption(): Text[250]
    var
        Job: Record Job2;
    begin
        if not Job.Get("Job No.") then
            exit('');
        exit(StrSubstNo('%1 %2 %3 %4',
            Job."No.",
            Job.Description,
            "Job Task No.",
            Description));
    end;


    procedure Caption2(): Text[250]
    var
        Job: Record Job2;
    begin
        if not Job.Get("Job No.") then
            exit('');
        exit(StrSubstNo('%1 %2',
            Job."No.",
            Job.Description))
    end;


    procedure InitWIPFields()
    begin
        "WIP Posting Date" := 0D;
        "WIP %" := 0;
        "WIP Account" := '';
        "WIP Balance Account" := '';
        "Invoiced Sales Account" := '';
        "Invoiced Sales Bal. Account" := '';
        "WIP Amount" := 0;
        "Invoiced Sales Amount" := 0;
        "WIP Method Used" := 0;
        "WIP Schedule (Total Cost)" := 0;
        "WIP Schedule (Total Price)" := 0;
        "WIP Usage (Total Cost)" := 0;
        "WIP Usage (Total Price)" := 0;
        "WIP Contract (Total Cost)" := 0;
        "WIP Contract (Total Price)" := 0;
        "WIP (Invoiced Price)" := 0;
        "WIP (Invoiced Cost)" := 0;
        "WIP Posting Date Filter" := '';
        "WIP Planning Date Filter" := '';
        "Recognized Sales Amount" := 0;
        "Recognized Sales Account" := '';
        "Recognized Sales Bal. Account" := '';
        "Recognized Costs Amount" := 0;
        "Recognized Costs Account" := '';
        "Recognized Costs Bal. Account" := '';
        "WIP Sales Account" := '';
        "WIP Sales Balance Account" := '';
        "WIP Costs Account" := '';
        "WIP Costs Balance Account" := '';
        "Cost Completion %" := 0;
        "Invoiced %" := 0;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; ShortcutDimCode: Code[20])
    var
        JobTask2: Record "Job Task2";
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        if JobTask2.Get("Job No.", "Job Task No.") then begin
            DimMgt.SaveJobTaskDim("Job No.", "Job Task No.", FieldNumber, ShortcutDimCode);
            Modify;
        end else
            DimMgt.SaveJobTaskTempDim(FieldNumber, ShortcutDimCode);
    end;


    procedure ClearTempDim()
    begin
        DimMgt.DeleteJobTaskTempDim;
    end;
}

