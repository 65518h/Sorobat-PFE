Table 8001481 "Filter Line"
{
    // //+BGW+FILTER CW 11/07/09

    Caption = 'Filter Line';

    fields
    {
        field(1; TableNo; Integer)
        {
            Caption = 'TableNo';
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License
        }
        field(2; FilterCode; Code[20])
        {
            Caption = 'Filter Code';
            TableRelation = "Filter Header".Code where("Table ID" = field(TableNo));
        }
        field(3; FieldNo; Integer)
        {
            //blankzero = true;
            Caption = 'FieldNo';
            TableRelation = Field."No." where(TableNo = field(TableNo));

            trigger OnLookup()
            var
                lField: Record "Field";
            begin
                lField.SetRange(TableNo, TableNo);
                //DYS page addon non migrer
                // if Action::LookupOK = PAGE.RunModal(page::"Filter Field List", lField) then
                //     FieldNo := lField."No.";
                CalcFields("Field Caption", "Field Type Name");
            end;

            trigger OnValidate()
            begin
                CalcFields("Field Caption", "Field Type Name");
            end;
        }
        field(19; "Filter"; Text[250])
        {
            Caption = 'Filter';

            trigger OnLookup()
            var
                lTableRelation: Codeunit TableRelation;
                lCode: Code[20];
            begin
                lTableRelation.LookUp(TableNo, FieldNo, lCode);
                if lCode <> '' then
                    Filter := lCode;
            end;
        }
        field(100; "Field Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field(TableNo),
                                                              "No." = field(FieldNo)));
            Caption = 'Field Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Field Type Name"; Text[30])
        {
            CalcFormula = lookup(Field."Type Name" where(TableNo = field(TableNo),
                                                          "No." = field(FieldNo)));
            Caption = 'Type';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; TableNo, FilterCode, FieldNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

