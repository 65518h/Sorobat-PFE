table 52048929 "FOR-Liste demande Formation"
{

    //GL2024  ID dans Nav 2009 : "39001480"
    // DrillDownPageID = 70098;
    //LookupPageID = 70098;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'N° Salarié';
            TableRelation = Employee;
        }
        field(2; Direction; Code[10])
        {
            TableRelation = Direction.Code;
        }
        field(3; Service; Code[10])
        {
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
        field(8; Evaluation; Text[250])
        {
            Caption = 'Evaluation';
        }
        field(9; section; Code[10])
        {
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                            "Plage Max" = FIELD(Service))*/;
        }
    }

    keys
    {
        key(Key1; "N° Sequence", "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecLPF: Record "FOR-Formations Enregistrées";
    begin
    end;
}

