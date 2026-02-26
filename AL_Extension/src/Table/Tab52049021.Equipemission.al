table 52049021 "Equipe mission"
{ //GL2024  ID dans Nav 2009 : "39001499"
  //GL2024DrillDownPageID = 70147;
  //GL2024 LookupPageID = 70147;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'N° Salarié';
            TableRelation = Employee;
        }
        field(2; Direction; Code[20])
        {
            //  CalcFormula = Lookup(Employee.Field50020 WHERE("No."=FIELD("Employee No.")));
            // FieldClass = FlowField;
            TableRelation = Direction.Code;
        }
        field(3; Service; Code[20])
        {
            CalcFormula = Lookup(Employee.Service WHERE("No." = FIELD("Employee No.")));
            FieldClass = FlowField;
            TableRelation = Service.Service WHERE(Direction = FIELD(Direction));
        }
        field(4; Nom; Text[30])
        {
        }
        field(5; Nom2; Text[30])
        {
            Caption = 'Prénom';
        }
        field(6; Fonction; Text[30])
        {
        }
        field(7; "N° Sequence"; Integer)
        {
            Caption = 'N° Séquence';
        }
        field(8; Observation; Text[250])
        {
            Caption = 'Evaluation';
        }
        field(10; "N° Demande"; Code[20])
        {
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; Section; Code[10])
        {
            TableRelation = "Tranche STC"."Taux STC" /*GL2024 WHERE ("Plage Min"=FIELD(Direction),
                                                            "Plage Max"=FIELD(Service))*/;
        }
    }

    keys
    {
        key(Key1; "N° Demande", "Employee No.")
        {
            Clustered = true;
        }
        key(Key2; "N° Sequence", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecLPF: Record "FOR-Personnel Formations";
    begin
    end;
}

