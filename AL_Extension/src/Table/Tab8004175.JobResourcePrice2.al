Table 8004175 "Job Resource Price2"
{
    Caption = 'Job Resource Price';
    // DrillDownPageID = 8004188;
    // LookupPageID = 8004188;

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
                LockTable;
                if "Job Task No." <> '' then begin
                    JT.Get("Job No.", "Job Task No.");
                    JT.TestField("Job Task Type", JT."job task type"::Posting);
                end;
            end;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Group(Resource),All';
            OptionMembers = Resource,"Group(Resource)",All;

            trigger OnValidate()
            begin
                if Type <> xRec.Type then begin
                    Code := '';
                    Description := '';
                end;
            end;
        }
        field(4; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const("Group(Resource)")) "Resource Group";

            trigger OnValidate()
            var
                Res: Record Resource;
                ResGrp: Record "Resource Group";
            begin
                if (Code <> '') and (Type = Type::All) then
                    Error(Text000, FieldCaption(Code), FieldCaption(Type), Type);
                case Type of
                    Type::Resource:
                        begin
                            Res.Get(Code);
                            Description := Res.Name;
                        end;
                    Type::"Group(Resource)":
                        begin
                            ResGrp.Get(Code);
                            "Work Type Code" := '';
                            Description := ResGrp.Name;
                        end;
                    Type::All:
                        begin
                            "Work Type Code" := '';
                            Description := '';
                        end;
                end;
            end;
        }
        field(5; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
        }
        field(6; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                "Unit Cost Factor" := 0;
            end;
        }
        field(7; "Currency Code"; Code[10])
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
        field(8; "Unit Cost Factor"; Decimal)
        {
            Caption = 'Unit Cost Factor';

            trigger OnValidate()
            begin
                "Unit Price" := 0;
            end;
        }
        field(9; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
        }
        field(10; Description; Text[30])
        {
            Caption = 'Description';
            Editable = false;
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
        key(Key1; "Job No.", "Job Task No.", Type, "Code", "Work Type Code", "Currency Code")
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
        if (Type = Type::Resource) and (Code = '') then
            FieldError(Code);
    end;

    trigger OnModify()
    begin
        if (Type = Type::Resource) and (Code = '') then
            FieldError(Code);
    end;

    var
        Text000: label '%1 cannot be specified when %2 is %3.';
        Job: Record Job2;
        JT: Record "Job Task2";


    procedure GetJob()
    begin
        TestField("Job No.");
        Job.Get("Job No.");
    end;
}

