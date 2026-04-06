Table 8001431 "Replication Exception"
{
    // //+REF+REPLIC CW 02/05/05 Réplication table setup, exception column

    // DrillDownPageID = 8001414;

    fields
    {
        field(1; "Table No."; Integer)
        {
            Caption = 'N° table';
            //GL2024 License TableRelation = Object.ID where(Type = const(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = const(Table));
            //GL2024 License

        }
        field(2; "Field No."; Integer)
        {
            //blankzero = true;
            Caption = 'Field No.';
            NotBlank = true;
            TableRelation = Field."No." where(TableNo = field("Table No."),
                                               Class = const(Normal));
        }
        field(3; Name; Text[30])
        {
            CalcFormula = lookup(Field.FieldName where(TableNo = field("Table No."),
                                                        "No." = field("Field No.")));
            Caption = 'Table Name';
            FieldClass = FlowField;
        }
        field(4; Caption; Text[250])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Field No.")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Table No.", "Field No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

