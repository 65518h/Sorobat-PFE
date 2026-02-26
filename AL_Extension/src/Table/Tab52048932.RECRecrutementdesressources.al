Table 52048932 "REC-Recrutement des ressources"
{ //GL2024  ID dans Nav 2009 : "39001487"
    DrillDownPageID = "Bons Reglement Validé";
    LookupPageID = "Bons Reglement Validé";

    fields
    {
        field(1; "N° Sequence"; Integer)
        {
            Caption = 'N° Demande';
        }
        field(2; Date; Date)
        {
        }
        field(3; Direction; Code[10])
        {
            TableRelation = Direction.Code;

            trigger OnValidate()
            begin
                CalcFields("Nom chef", "Nom direction", "Nom service");
            end;
        }
        field(4; Service; Code[10])
        {
            TableRelation = Service.Service where(Direction = field(Direction));

            trigger OnValidate()
            begin
                CalcFields("Nom chef", "Nom direction", "Nom service");
            end;
        }
        field(5; "chef departement"; Code[20])
        {
            Caption = 'chef département';
            /*GL2024  TableRelation = Employee."No." WHERE(Field50020 = FIELD(Direction),
                                                                                       Service = FIELD(Service),
                                                                                       Section = FIELD(Section));*/

            trigger OnValidate()
            begin
                CalcFields("Nom chef", "Nom direction", "Nom service");
            end;
        }
        field(6; besoins; Text[250])
        {
        }
        field(7; Taches; Text[250])
        {
            Caption = 'Tâches';
        }
        field(8; "Formation de base"; Text[100])
        {
        }
        field(9; Qualification; Text[100])
        {
            TableRelation = Qualification;

            trigger OnValidate()
            begin
                CalcFields("Description qualification");
            end;
        }
        field(10; Experience; DateFormula)
        {
            Caption = 'Expérience';
        }
        field(11; Qualites; Text[100])
        {
            Caption = 'Qualités';
        }
        field(12; "Source du besoin"; Text[100])
        {
        }
        field(13; Objectif; Text[250])
        {
        }
        field(14; "Avis du directeur"; Text[100])
        {
        }
        field(15; "Validation DG"; Option)
        {
            Editable = false;
            OptionCaption = 'En attente,Validée,Refusée';
            OptionMembers = "En attente",Validee,Refusee;
        }
        field(16; "Nom chef"; Text[50])
        {
            CalcFormula = lookup(Employee."First Name" where("No." = field("chef departement")));
            FieldClass = FlowField;
        }
        field(17; "Nom direction"; Text[50])
        {
            CalcFormula = lookup(Direction.Designation where(Code = field(Direction)));
            FieldClass = FlowField;
        }
        field(18; "Nom service"; Text[50])
        {
            CalcFormula = lookup(Service.Description where(Direction = field(Direction),
                                                            Service = field(Service)));
            FieldClass = FlowField;
        }
        field(19; "Description qualification"; Text[50])
        {
            CalcFormula = lookup(Qualification.Description where(Code = field(Qualification)));
            FieldClass = FlowField;
        }
        field(20; Evaluateur; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                CalcFields("Nom Evaluateur");
            end;
        }
        field(21; "Nom Evaluateur"; Text[50])
        {
            CalcFormula = lookup(Employee."First Name" where("No." = field(Evaluateur)));
            FieldClass = FlowField;
        }
        field(22; "Date Entretien"; Date)
        {
        }
        field(23; Observation; Text[250])
        {
        }
        field(24; Section; Code[10])
        {
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                                                                 "Plage Max" = FIELD(Service))*/;
        }
        field(25; "Nom section"; Text[30])
        {
            CalcFormula = Lookup("Tranche STC".Decription /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                                                                      "Plage Max" = FIELD(Service),
                                                                                                      "Taux STC" = FIELD(Section))*/);
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "N° Sequence")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecLRecrut: Record "REC-Recrutement des ressources";
    begin
        if RecLRecrut.FindLast then
            "N° Sequence" := RecLRecrut."N° Sequence" + 1
        else
            "N° Sequence" := 1;
    end;

    var
        RecGDirectionService: Record Direction;
}

