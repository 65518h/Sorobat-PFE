Table 8001460 "Job Scheduler Filter"
{
    // //+REF+SCHEDULER ML 01/11/01 Tâche de fond

    Caption = 'Job scheduler Filter';

    fields
    {
        field(1; "Scheduler Code"; Code[10])
        {
            Caption = 'N° traitement';
        }
        field(2; "Table No."; Integer)
        {
            //blankzero = true;
            Caption = 'N° table';
            TableRelation = AllObj."Object ID" where("Object Type" = const(TableData));

            trigger OnValidate()
            var
                tTableList: label 'The only allowed tables are : %1.';
                lTableList: Text[250];
            begin
                lTableList := '14,15,17,18,21,23,25,27,32,37,38,39,81,110,111,112,113,114,115,121,122,123,124';
                if StrPos(',' + lTableList + ',', ',' + Format("Table No.") + ',') = 0 then
                    Error(tTableList, lTableList);
            end;
        }
        field(3; "Field No."; Integer)
        {
            //blankzero = true;
            Caption = 'N° champ';
            TableRelation = Field."No." where(TableNo = field("Table No."));

            trigger OnValidate()
            begin
                if not Field.Get("Table No.", "Field No.") then
                    Field.Init
                else
                    case Field.Type of
                        Field.Type::Text:
                            "Field Type" := "field type"::Text;
                        Field.Type::Date:
                            "Field Type" := "field type"::Date;
                        Field.Type::Time:
                            "Field Type" := "field type"::Time;
                        Field.Type::DateFormula:
                            "Field Type" := "field type"::Dateformula;
                        Field.Type::Decimal:
                            "Field Type" := "field type"::Decimal;
                        Field.Type::Binary:
                            "Field Type" := "field type"::Binary;
                        Field.Type::Blob:
                            "Field Type" := "field type"::Blob;
                        Field.Type::Boolean:
                            "Field Type" := "field type"::Boolean;
                        Field.Type::Integer:
                            "Field Type" := "field type"::Integer;
                        Field.Type::Code:
                            "Field Type" := "field type"::Code;
                        Field.Type::Option:
                            "Field Type" := "field type"::Option;
                        else
                            ;
                    end;
            end;
        }
        field(4; Value; Text[80])
        {
            Caption = 'Valeur';

            trigger OnValidate()
            var
                lBoolean: Boolean;
            begin
                if "Field Type" = "field type"::Boolean then
                    if not Evaluate(lBoolean, Value) then
                        Error(tBoolean)
                    else
                        Value := Format(lBoolean);
            end;
        }
        field(5; "Table Caption"; Text[250])
        {
            /*
             CalcFormula = lookup(Object.Caption where(Type = const(TableData),
                                                         ID = field("Table No.")));  GL2024 License*/



            //GL2024 License        CalcFormula = lookup(AllObj.Caption where("Object Type" = const(TableData),
            //GL2024 License   "Object id" = field("Table No.")));
            Caption = 'Nom table';
            //FieldClass = FlowField;
        }
        field(6; "Field Caption"; Text[250])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."),
                                                              "No." = field("Field No.")));
            Caption = 'Nom champ';
            FieldClass = FlowField;
        }
        field(7; "Field Type"; Option)
        {
            Caption = 'Field Type';
            OptionMembers = Text,Date,Time,Dateformula,Decimal,Binary,Blob,Boolean,"Integer","Code",Option;
        }
    }

    keys
    {
        key(STG_Key1; "Scheduler Code", "Table No.", "Field No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        "Field": Record "Field";
        tBoolean: label 'This filter must be Yes or No';
}

