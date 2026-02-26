Table 8001563 "Workflow RecordLink Setup"
{
    //GL2024  ID dans Nav 2009 : "8004219"
    // //OFE 23/02/10 +Description

    Caption = 'Workflow RecordLink Setup';

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'ID table';
            NotBlank = true;

            //GL2024 License TableRelation = Object.ID where(Type = filter(Table));
            //GL2024 License
            TableRelation = AllObj."Object ID" where("Object Type" = filter(Table));
            //GL2024 License

            trigger OnValidate()
            var
                //GL2024 License   lObject: Record "Object";
                //GL2024 License
                lObject: Record AllObj;
            //GL2024 License
            begin
                lObject.SetRange("Object Type", lObject."Object Type"::Table);
                lObject.SetRange("Object id", "Table ID");
                if lObject.FindSet then begin
                    //GL2024 License  lObject.CalcFields(Caption);
                    //GL2024 License Description := lObject.Caption;
                end;
            end;
        }
        field(2; Path; Text[250])
        {
            Caption = 'Path';
        }
        field(3; Description; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(TableData),
                                                                           "Object ID" = field("Table ID")));
            Caption = 'Désignation';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

