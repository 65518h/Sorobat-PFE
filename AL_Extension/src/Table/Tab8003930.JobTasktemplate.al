Table 8003930 "Job Task template"
{
    Caption = 'Job Task template';
    //DrillDownPageID = 8004183;
    //LookupPageID = 8004183;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = Code.Code where("Table No" = const(8003930),
                                             "Field No" = const(1));
        }
        field(2; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            NotBlank = true;

            trigger OnValidate()
            var
                Job: Record Job;
                Cust: Record Customer;
            begin
            end;
        }
        field(3; Description; Text[50])
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
            TableRelation = "Job Posting Group";

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
        field(21; Totaling; Text[250])
        {
            Caption = 'Totaling';
            TableRelation = "Job Task"."Job Task No." where("Job Task No." = field("Job Task No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
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
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
    }

    keys
    {
        key(STG_Key1; "Code", "Job Task No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
    end;

    trigger OnInsert()
    var
        Job: Record Job;
        Cust: Record Customer;
    begin
        LockTable;
        InitWIPFields;
    end;

    var
        Text000: label 'You cannot delete %1 because one or more entries are associated.';


    procedure InitWIPFields()
    begin
        "WIP Posting Date" := 0D;
        "WIP Account" := '';
        "WIP Balance Account" := '';
        "Invoiced Sales Account" := '';
        "Invoiced Sales Bal. Account" := '';
        "WIP Posting Date Filter" := '';
        "WIP Planning Date Filter" := '';
        "Recognized Sales Account" := '';
        "Recognized Sales Bal. Account" := '';
        "Recognized Costs Account" := '';
        "Recognized Costs Bal. Account" := '';
        "WIP Sales Account" := '';
        "WIP Sales Balance Account" := '';
        "WIP Costs Account" := '';
        "WIP Costs Balance Account" := '';
    end;
}

