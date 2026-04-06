Table 8004001 "Working Time Setup"
{
    // //POINTAGE GESWAY 31/05/02 Paramètre pointage

    Caption = 'Working Time Setup';
    // LookupPageID = 8004001;

    fields
    {
        field(1; "Field"; Integer)
        {
            Caption = 'Field';
            MaxValue = 10;
            MinValue = 1;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account';
            OptionMembers = Resource,Item,"Account (G/L)";

            trigger OnValidate()
            begin
                if Type <> xRec.Type then
                    Validate("No.", '');
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item
            else
            if (Type = const("Account (G/L)")) "G/L Account";

            trigger OnValidate()
            begin
                if "No." <> '' then
                    "Control No." := "control no."::"Same Code"
                else
                    "Control No." := "control no."::" ";
            end;
        }
        field(5; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";

            trigger OnValidate()
            begin
                if "Work Type Code" <> '' then
                    "Control Work Type Code" := "control work type code"::"Same Code"
                else
                    "Control Work Type Code" := "control work type code"::" ";
            end;
        }
        field(6; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            begin
                if "Gen. Prod. Posting Group" <> '' then
                    "Control Gen. Prod. Posting Gr." := "control gen. prod. posting gr."::"Same Code"
                else
                    "Control Gen. Prod. Posting Gr." := "control gen. prod. posting gr."::" ";
            end;
        }
        field(9; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job where(Status = const(Open));

            trigger OnValidate()
            begin
                if "Job No." <> '' then
                    "Control Job No." := "control job no."::"Same Code"
                else
                    "Control Job No." := "control job no."::" ";
                if "Job No." <> xRec."Job No." then begin
                    "Job Task No." := '';
                    "Control Job Task No." := "control job task no."::" ";
                end;
            end;
        }
        field(10; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));

            trigger OnValidate()
            begin
                if "Job Task No." <> '' then
                    "Control Job Task No." := "control job task no."::"Same Code"
                else
                    "Control Job Task No." := "control job task no."::" ";
            end;
        }
        field(11; "Control Work Type Code"; Option)
        {
            Caption = 'Control Work Type Code';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";

            trigger OnValidate()
            begin
                if "Work Type Code" <> '' then
                    FieldError("Work Type Code", Text8003900);
                if "Control Work Type Code" = "control work type code"::"Same Code" then
                    if "Work Type Code" = '' then
                        FieldError("Work Type Code", Text8003901);
            end;
        }
        field(12; "Control Gen. Prod. Posting Gr."; Option)
        {
            Caption = 'Control Gen. Prod. Posting Group';
            OptionCaption = ' ,Same Code,No Code';
            OptionMembers = " ","Same Code","No Code";

            trigger OnValidate()
            begin
                if "Gen. Prod. Posting Group" <> '' then
                    FieldError("Gen. Prod. Posting Group", Text8003900);
                if "Control Gen. Prod. Posting Gr." = "control gen. prod. posting gr."::"Same Code" then
                    if "Gen. Prod. Posting Group" = '' then
                        FieldError("Gen. Prod. Posting Group", Text8003901);
            end;
        }
        field(15; "Control Job No."; Option)
        {
            Caption = 'Control Job No.';
            OptionCaption = ' ,Same Code';
            OptionMembers = " ","Same Code";

            trigger OnValidate()
            begin
                if "Job No." <> '' then
                    FieldError("Job No.", Text8003900);
                if "Control Job No." = "control job no."::"Same Code" then
                    if "Job No." = '' then
                        FieldError("Job No.", Text8003901);
            end;
        }
        field(16; "Control Job Task No."; Option)
        {
            Caption = 'Control Job Task No.';
            OptionCaption = ' ,Same Code';
            OptionMembers = " ","Same Code";

            trigger OnValidate()
            begin
                if "Job Task No." <> '' then
                    FieldError("Job Task No.", Text8003900);
                if "Control Job Task No." = "control job task no."::"Same Code" then
                    if "Job Task No." = '' then
                        FieldError("Job Task No.", Text8003901);
            end;
        }
        field(17; "Control Type"; Option)
        {
            Caption = 'Control Type';
            OptionCaption = ' ,Same Code';
            OptionMembers = " ","Same Code";
        }
        field(18; "Control No."; Option)
        {
            Caption = 'Control No.';
            OptionCaption = ' ,Same Code';
            OptionMembers = " ","Same Code";

            trigger OnValidate()
            begin
                if "No." <> '' then
                    FieldError("No.", Text8003900);
                if "Control No." = "control no."::"Same Code" then
                    if "No." = '' then
                        FieldError(Type, Text8003901);
            end;
        }
        field(19; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Job Journal Template";
        }
        field(20; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(21; "Week Day"; Option)
        {
            Caption = 'Week''s Day';
            OptionCaption = ' ,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = " ",Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
    }

    keys
    {
        key(STG_Key1; "Journal Template Name", "Journal Batch Name", "Field")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text8003900: label 'must be empty.';
        Text8003901: label 'must not be empty.';
}

