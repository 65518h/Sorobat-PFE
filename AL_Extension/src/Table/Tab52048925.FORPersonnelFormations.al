table 52048925 "FOR-Personnel Formations"
{

    //GL2024  ID dans Nav 2009 : "39001474"
    //DrillDownPageID = "FOR-Personnels Formations";
    //LookupPageID = "FOR-Personnels Formations";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'N° Salarié';
            TableRelation = Employee;
        }
        field(2; Direction; Code[10])
        {
            FieldClass = Normal;
            TableRelation = Direction.Code;
        }
        field(3; Service; Code[10])
        {
            FieldClass = Normal;
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
            TableRelation = "FOR-Programme Formations"."N° Sequence";
        }
        field(8; Evaluation; Text[250])
        {
            Caption = 'Evaluation';
        }
        field(9; themes; Code[20])
        {
            CalcFormula = Lookup("FOR-Programme Formations".themes WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                          Status = FILTER(Closed)));
            Caption = 'Thèmes';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "FOR-Themes Formations"."Topic Code" WHERE(Code = FIELD("Centre formation"));

            trigger OnValidate()
            var
                RecLThemes: Record 52048923;
            begin
            end;
        }
        field(10; "Description themes"; Text[50])
        {
            CalcFormula = Lookup("FOR-Themes Formations".Description WHERE(Code = FIELD("Centre formation"),
                                                                            "Topic Code" = FIELD(themes)));
            Caption = 'Description thèmes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Date debut"; Date)
        {
            CalcFormula = Lookup("FOR-Programme Formations"."Date debut" WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                                Status = FILTER(Closed)));
            Caption = 'Date début';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "date fin"; Date)
        {
            CalcFormula = Lookup("FOR-Programme Formations"."date fin" WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                              Status = FILTER(Closed)));
            Caption = 'Date fin';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Cout; Decimal)
        {
            CalcFormula = Lookup("FOR-Programme Formations".Cout WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                        Status = FILTER(Closed)));
            Caption = 'Coût';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Centre formation"; Code[20])
        {
            CalcFormula = Lookup("FOR-Programme Formations"."Centre formation" WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                                      Status = FILTER(Closed)));
            Editable = false;
            FieldClass = FlowField;
            // TableRelation = Table70039.Field1;
        }
        field(15; Type; Option)
        {
            CalcFormula = Lookup("FOR-Programme Formations".Type WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                        Status = FILTER(Closed)));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Interne,Externe';
            OptionMembers = ,Interne,Externe;
        }
        field(16; "Nombre jour"; Decimal)
        {
            CalcFormula = Lookup("FOR-Programme Formations"."Nombre jour" WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                                 Status = FILTER(Closed)));
            Caption = 'Nombre de jours';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Description centre"; Text[50])
        {
            CalcFormula = Lookup("FOR-Centres Formations".Description WHERE(Code = FIELD("Centre formation")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; Status; Option)
        {
            CalcFormula = Lookup("FOR-Programme Formations".Status WHERE("N° Sequence" = FIELD("N° Sequence"),
                                                                          Status = FILTER(Closed)));
            Caption = 'Statut';
            FieldClass = FlowField;
            OptionCaption = ' ,Lancée,Fermée';
            OptionMembers = ,Released,Closed;
        }
        field(19; "Prise en compte attentes"; Option)
        {
            OptionCaption = ' ,Pas satisfait,Peu satisfait,Assez satisfait,Très satisfait';
            OptionMembers = ,"Pas satisfait","Peu satisfait","Assez satisfait","Tres satisfait";
        }
        field(20; "Alternance theori/pratique"; Option)
        {
            OptionCaption = ' ,Pas satisfait,Peu satisfait,Assez satisfait,Très satisfait';
            OptionMembers = ,"Pas satisfait","Peu satisfait","Assez satisfait","Tres satisfait";
        }
        field(21; "Maitise contenu formateur"; Option)
        {
            OptionCaption = ' ,Pas satisfait,Peu satisfait,Assez satisfait,Très satisfait';
            OptionMembers = ,"Pas satisfait","Peu satisfait","Assez satisfait","Tres satisfait";
        }
        field(22; "Maitise pedagogique formateur"; Option)
        {
            OptionCaption = ' ,Pas satisfait,Peu satisfait,Assez satisfait,Très satisfait';
            OptionMembers = ,"Pas satisfait","Peu satisfait","Assez satisfait","Tres satisfait";
        }
        field(23; "Qualite documentation"; Option)
        {
            OptionCaption = ' ,Pas satisfait,Peu satisfait,Assez satisfait,Très satisfait';
            OptionMembers = ,"Pas satisfait","Peu satisfait","Assez satisfait","Tres satisfait";
        }
        field(24; "Duree Formation"; Option)
        {
            OptionCaption = ' ,Pas satisfait,Peu satisfait,Assez satisfait,Très satisfait';
            OptionMembers = ,"Pas satisfait","Peu satisfait","Assez satisfait","Tres satisfait";
        }
        field(25; Accueil; Option)
        {
            OptionCaption = ' ,Pas satisfait,Peu satisfait,Assez satisfait,Très satisfait';
            OptionMembers = ,"Pas satisfait","Peu satisfait","Assez satisfait","Tres satisfait";
        }
        field(26; "Nouvelle formation"; Boolean)
        {
        }
        field(27; formation; Text[250])
        {
        }
        field(28; section; Code[10])
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

