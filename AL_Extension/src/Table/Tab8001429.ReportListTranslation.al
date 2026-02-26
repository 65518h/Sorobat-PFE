Table 8001429 "ReportList Translation"
{
    // //+BGW+REPORT_LIST CW 30/06/08

    Caption = 'Report List Translation';
    DataPerCompany = false;

    fields
    {
        field(1; "Menu ID"; Integer)
        {
            Caption = 'Menu ID';
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(3; "Language ID"; Integer)
        {
            //blankzero = true;
            Caption = 'Language ID';
            NotBlank = true;
            TableRelation = "Windows Language";

            trigger OnValidate()
            begin
                CalcFields("Language Name");
            end;
        }
        field(4; "Language Name"; Text[50])
        {
            CalcFormula = lookup("Windows Language".Name where("Language ID" = field("Language ID")));
            Caption = 'Language Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Menu ID", "Line No.", "Language ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

