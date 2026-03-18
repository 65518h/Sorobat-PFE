Table 8004176 "Job Item Price2"
{
    Caption = 'Job Item Price';
    //  DrillDownPageID = 8004189;
    //LookupPageID = 8004189;

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            NotBlank = true;
            TableRelation = Job2;

            trigger OnValidate()
            begin
                GetJob;
                "Currency Code" := Job."Currency Code";
            end;
        }
        field(2; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task2"."Job Task No." where("Job No." = field("Job No."));

            trigger OnValidate()
            begin
                if "Job Task No." <> '' then begin
                    JT.Get("Job No.", "Job Task No.");
                    JT.TestField("Job Task Type", JT."job task type"::Posting);
                end;
            end;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            begin
                Item.Get("Item No.");
                Validate("Unit of Measure Code", Item."Sales Unit of Measure");
            end;
        }
        field(4; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(5; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                "Unit Cost Factor" := 0;
            end;
        }
        field(6; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if "Currency Code" <> xRec."Currency Code" then begin
                    "Unit Cost Factor" := 0;
                    "Line Discount %" := 0;
                    "Unit Price" := 0;
                end;
            end;
        }
        field(7; "Unit Cost Factor"; Decimal)
        {
            Caption = 'Unit Cost Factor';

            trigger OnValidate()
            begin
                "Unit Price" := 0;
            end;
        }
        field(8; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
        }
        field(9; Description; Text[30])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(11; "Apply Job Price"; Boolean)
        {
            Caption = 'Apply Job Price';
            InitValue = true;
        }
        field(12; "Apply Job Discount"; Boolean)
        {
            Caption = 'Apply Job Discount';
            InitValue = true;
        }
    }

    keys
    {
        key(STG_Key1; "Job No.", "Job Task No.", "Item No.", "Variant Code", "Unit of Measure Code", "Currency Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        LockTable;
        Job.Get("Job No.");
        TestField("Item No.");
    end;

    var
        Item: Record Item;
        Job: Record Job2;
        JT: Record "Job Task2";


    procedure Caption(): Text[250]
    var
        Job: Record Job2;
    begin
        Clear(Job);
        if Job.Get("Job No.") then;
        exit("Job No." + ' ' + Job.Description);
    end;


    procedure GetJob()
    begin
        TestField("Job No.");
        Job.Get("Job No.");
    end;
}

