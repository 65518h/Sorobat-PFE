Table 8003914 "Vocabulary Translation"
{
    // //VOCABULAIRE GESWAY 15/11/02 Traduction

    Caption = 'Vocabulary Translation';

    fields
    {
        field(1; "Caption No."; Integer)
        {
            Caption = 'Caption No.';
            NotBlank = true;
        }
        field(2; "Language ID"; Integer)
        {
            Caption = 'Language ID';
            NotBlank = true;
            TableRelation = "Windows Language";

            trigger OnValidate()
            begin
                CalcFields("Language Name");
            end;
        }
        field(3; "Name Caption"; Text[30])
        {
            Caption = 'Name Caption';

            trigger OnValidate()
            begin
                if "Code Caption" = '' then
                    "Code Caption" := CopyStr(StrSubstNo(Text8003900, "Name Caption"), 1, MaxStrLen("Code Caption"));
                if "Filter Caption" = '' then
                    "Filter Caption" := CopyStr(StrSubstNo(Text8003901, "Name Caption"), 1, MaxStrLen("Filter Caption"));
            end;
        }
        field(4; "Code Caption"; Text[30])
        {
            Caption = 'Code Caption';
        }
        field(5; "Filter Caption"; Text[30])
        {
            Caption = 'Filter Caption';
        }
        field(6; "Language Name"; Text[30])
        {
            CalcFormula = lookup("Windows Language".Name where("Language ID" = field("Language ID")));
            Caption = 'Language Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Caption No.", "Language ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text8003900: label '%1 Code';
        Text8003901: label '%1 Filter';
}

