Table 8004163 "Job Posting Group2"
{
    // //JOB_TO_GL CW 21/12/05 +"Transfer Source Code","Transfer From Account","Transfer To Account"

    Caption = 'Job Posting Group';
    //  DrillDownPageID = 8004166;
    //LookupPageID = 8004166;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "WIP Costs Account"; Code[20])
        {
            Caption = 'WIP Costs Account';
            TableRelation = "G/L Account";
        }
        field(3; "WIP Accrued Costs Account"; Code[20])
        {
            Caption = 'WIP Accrued Costs Account';
            TableRelation = "G/L Account";
        }
        field(4; "Job Costs Applied Account"; Code[20])
        {
            Caption = 'Job Costs Applied Account';
            TableRelation = "G/L Account";
        }
        field(5; "Job Costs Adjustment Account"; Code[20])
        {
            Caption = 'Job Costs Adjustment Account';
            TableRelation = "G/L Account";
        }
        field(6; "G/L Expense Acc. (Contract)"; Code[20])
        {
            Caption = 'G/L Expense Acc. (Contract)';
            TableRelation = "G/L Account";
        }
        field(7; "Job Sales Adjustment Account"; Code[20])
        {
            Caption = 'Job Sales Adjustment Account';
            TableRelation = "G/L Account";
        }
        field(8; "WIP Accrued Sales Account"; Code[20])
        {
            Caption = 'WIP Accrued Sales Account';
            TableRelation = "G/L Account";
        }
        field(9; "WIP Invoiced Sales Account"; Code[20])
        {
            Caption = 'WIP Invoiced Sales Account';
            TableRelation = "G/L Account";
        }
        field(10; "Job Sales Applied Account"; Code[20])
        {
            Caption = 'Job Sales Applied Account';
            TableRelation = "G/L Account";
        }
        field(11; "Recognized Costs Account"; Code[20])
        {
            Caption = 'Recognized Costs Account';
            TableRelation = "G/L Account";
        }
        field(12; "Recognized Sales Account"; Code[20])
        {
            Caption = 'Recognized Sales Account';
            TableRelation = "G/L Account";
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(8003901; "Transfer Account"; Code[20])
        {
            Caption = 'Transfer Account';
            TableRelation = "G/L Account";
        }
        field(8003902; "Transfer Bal. Account"; Code[20])
        {
            Caption = 'Transfer Bal. Account';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Synchronise)
        {
        }
    }

    fieldgroups
    {
    }
}

