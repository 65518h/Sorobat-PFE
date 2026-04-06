
Table 52049019 "Equipe demande  mission"
{//GL2024  ID dans Nav 2009 : "39001497"
    // LookupPageID = 70145;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'N° Salarié';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                RecGEmp.Reset;
                RecGEmp.Get("Employee No.");
                Nom := RecGEmp.FullName;

                Fonction := RecGEmp."Job Title";
                "Global Dimension 1" := RecGEmp."Global Dimension 1 Code";
                "Global Dimension 2" := RecGEmp."Global Dimension 2 Code";
            end;
        }
        field(2; Direction; Code[20])
        {
            /*GL2024  CalcFormula = Lookup(Employee.Field50020 WHERE("No." = FIELD("Employee No.")));
              FieldClass = FlowField;
              TableRelation = Direction.Code;*/
        }
        field(3; Service; Code[20])
        {
            CalcFormula = Lookup(Employee.Service WHERE("No." = FIELD("Employee No.")));
            FieldClass = FlowField;
            TableRelation = Service.Service where(Direction = field(Direction));
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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; Section; Code[10])
        {
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                                                                 "Plage Max" = FIELD(Service))*/;
        }
    }

    keys
    {
        key(STG_Key1; "N° Demande", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
    //    RecLPF: Record "Rappel Enregistre";
    begin
    end;

    var
        RecGEmp: Record Employee;
}

