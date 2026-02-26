
Table 52048968 "FOR-Formations Enregistrées"
{    //GL2024  ID dans Nav 2009 : "39001475"
     //  DrillDownPageID = "SubForm Lot Virement Salaire V";
     //  LookupPageID = "SubForm Lot Virement Salaire V";

    fields
    {
        field(1; "N° Sequence"; Integer)
        {
            Caption = 'N° Séquence';
            Editable = false;
        }
        field(2; Direction; Code[10])
        {
            TableRelation = Direction.Code;
        }
        field(3; Service; Code[10])
        {
            TableRelation = Service.Service WHERE(Direction = FIELD(Direction));
        }
        field(4; themes; Code[20])
        {
            Caption = 'Thèmes';
            TableRelation = "FOR-Themes Formations"."Topic Code" WHERE(Code = FIELD("Centre formation"));
        }
        field(5; "Description themes"; Text[50])
        {
            CalcFormula = Lookup("FOR-Themes Formations".Description WHERE(Code = FIELD("Centre formation"),
                                                                            "Topic Code" = FIELD(themes)));
            Caption = 'Description thèmes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Date debut"; Date)
        {
            Caption = 'Date début';
        }
        field(7; "date fin"; Date)
        {
            Caption = 'Date fin';
        }
        field(8; Cout; Decimal)
        {
            Caption = 'Coût';
        }
        field(9; "Centre formation"; Code[20])
        {
            TableRelation = "FOR-Centres Formations".Code;
        }
        field(10; Type; Option)
        {
            OptionMembers = Interne,Externe;
        }
        field(11; "Nombre jour"; Decimal)
        {
            Caption = 'Nombre de jours';
            Editable = false;
        }
        field(12; "Description centre"; Text[50])
        {
            CalcFormula = Lookup("FOR-Centres Formations".Description WHERE(Code = FIELD("Centre formation")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Description direction"; Text[50])
        {
            CalcFormula = Lookup(Direction.Designation WHERE(Code = FIELD(Direction)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Description service"; Text[50])
        {
            CalcFormula = Lookup(Service.Description WHERE(Direction = FIELD(Direction),
                                                            Description = FIELD(Service)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Filtre annee"; Integer)
        {
            Caption = 'Filtre année';
            FieldClass = FlowFilter;
        }
        field(16; Annee; Integer)
        {
            Caption = 'Année';
            Editable = false;
        }
        field(17; "Cout Total"; Decimal)
        {
            CalcFormula = Sum("FOR-Programme Formations".Cout);
            Caption = 'Cout Total';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Nbr personnel affectes"; Integer)
        {
            CalcFormula = Count("FOR-Personnel Formations" WHERE("N° Sequence" = FIELD("N° Sequence")));
            Caption = 'Nbre de personnels affectés';
            FieldClass = FlowField;
        }
        field(19; Status; Option)
        {
            Caption = 'Statut';
            OptionCaption = ' ,Lancée,Fermée';
            OptionMembers = ,Released,Closed;
        }
        field(20; "Realisation Rate"; Decimal)
        {
            Caption = 'Taux de réalisation';
            DecimalPlaces = 2 : 2;
        }
        field(21; "Nbre Total Programme"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Annee = FIELD("Filtre annee")));
            Caption = 'Nbre total de Programmes';
            FieldClass = FlowField;
        }
        field(22; "Nbre Programme Lance"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Annee = FIELD("Filtre annee"),
                                                                  Status = FILTER(Released)));
            Caption = 'Nbre de Programmes Lancés';
            FieldClass = FlowField;
        }
        field(23; "Nbre Programme ferme"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Annee = FIELD("Filtre annee"),
                                                                  Status = FILTER(Closed)));
            Caption = 'Nbre de Programmes fermés';
            FieldClass = FlowField;
        }
        field(24; Nature; Option)
        {
            OptionCaption = 'Prévue,Non prévue';
            OptionMembers = Prevue,"Non Prevue";
        }
        field(25; Observation; Text[250])
        {
            Caption = 'Obsérvation';
        }
        field(26; "N° Demande"; Integer)
        {
        }
        field(27; "date lancement"; Date)
        {
        }
        field(28; "date cloture"; Date)
        {
        }
        field(29; "date validation"; Date)
        {
        }
        field(30; Valideur; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                CALCFIELDS("Nom valideur");
            end;
        }
        field(31; "Nom valideur"; Text[50])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD(Valideur)));
            FieldClass = FlowField;
        }
        field(32; "Nature demande"; Option)
        {
            OptionCaption = 'Programmée,Non programmée';
            OptionMembers = Programmee,"Non programmee";
        }
        field(43; Evaluation; Text[250])
        {
        }
        field(44; Pedagogie; Text[250])
        {
            Caption = 'Pédagogie';
        }
        field(45; Comportement; Text[250])
        {
        }
        field(46; Resultat; Text[250])
        {
            Caption = 'Résultat';
        }
        field(47; "Statut evaluation"; Option)
        {
            OptionCaption = 'Non validé,Validé';
            OptionMembers = "Non valide",Valide;
        }
        field(48; section; Code[10])
        {
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                            "Plage Max" = FIELD(Service))*/;
        }
    }

    keys
    {
        key(Key1; "N° Sequence")
        {
            Clustered = true;
            SumIndexFields = Cout;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecLProgramFormation: Record "FOR-Personnel Formations";
    begin
    end;
}

