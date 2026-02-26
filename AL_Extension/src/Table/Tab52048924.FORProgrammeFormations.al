table 52048924 "FOR-Programme Formations"
{
    //GL2024  ID dans Nav 2009 : "39001473"

    //DrillDownPageID = "FOR-Liste Programme Formations";
    //LookupPageID = "FOR-Liste Programme Formations";

    fields
    {
        field(1; "N° Sequence"; Integer)
        {
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

            trigger OnValidate()
            var
                RecLThemes: Record "FOR-Themes Formations";
            begin
                CALCFIELDS("Description themes");
                IF RecLThemes.GET("Centre formation", themes) THEN BEGIN
                    Cout := RecLThemes.Cost;
                    VALIDATE("Nombre jour", RecLThemes."Day number");
                END;
            end;
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

            trigger OnValidate()
            begin
                Annee := DATE2DMY("Date debut", 3);
                IF "date fin" = 0D THEN
                    IF "Nombre jour" > 0 THEN
                        "date fin" := CALCDATE(FORMAT("Nombre jour" DIV 1) + 'J', "Date debut");
                IF "date fin" >= "Date debut" THEN
                    "Nombre jour" := "date fin" - "Date debut" + 1;
                Mois := DATE2DMY("Date debut", 2);
            end;
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
            OptionCaption = ' ,Interne,Externe';
            OptionMembers = ,Interne,Externe;
        }
        field(11; "Nombre jour"; Decimal)
        {
            Caption = 'Nombre de jours';

            trigger OnValidate()
            begin
                IF "Date debut" <> 0D THEN
                    "date fin" := CALCDATE(FORMAT("Nombre jour" DIV 1) + 'J', "Date debut");
            end;
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
                                                            Service = FIELD(Service)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Filtre annee"; Integer)
        {
            BlankZero = true;
            Caption = 'Filtre année';
            FieldClass = FlowFilter;
        }
        field(16; Annee; Integer)
        {
            BlankZero = true;
            Caption = 'Année';
            Editable = false;
        }
        field(17; "Cout Total"; Decimal)
        {
            CalcFormula = Lookup("FOR-Programme Formations".Cout WHERE(Annee = FIELD("Filtre annee")));
            Caption = 'Coût Total';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Nbr personnel affectes"; Integer)
        {
            CalcFormula = Count("FOR-Personnel Formations" WHERE("N° Sequence" = FIELD("N° Sequence")));
            Caption = 'Nbre de personnels affectés';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; Status; Option)
        {
            Caption = 'Statut';
            OptionCaption = ' ,Lancée,Fermée';
            OptionMembers = ,Released,Closed;
        }
        field(20; "Filtre Centre Formation"; Code[20])
        {
            Caption = 'Filtre Centre de Formations';
            FieldClass = FlowFilter;
        }
        field(21; "Filtre Direction"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(22; section; Code[10])
        {
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                            "Plage Max" = FIELD(Service))*/;
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
            OptionCaption = 'Non programmée,Programmée';
            OptionMembers = "Non programmee",Programmee;
        }
        field(33; "Nbr. formations total"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Annee = FIELD("Filtre annee"),
                                                                  Mois = FIELD("Filtre Mois"),
                                                                  Direction = FIELD("Filtre Direction"),
                                                                  Service = FIELD("Filtre Service"),
                                                                  "Centre formation" = FIELD("Filtre Centre Formation"),
                                                                  themes = FIELD("Filtre Theme")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Nbr. formations lancees"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Status = FILTER(Released),
                                                                  Direction = FIELD("Filtre Direction"),
                                                                  Service = FIELD("Filtre Service"),
                                                                  Annee = FIELD("Filtre annee"),
                                                                  Mois = FIELD("Filtre Mois"),
                                                                  "Centre formation" = FIELD("Filtre Centre Formation"),
                                                                  themes = FIELD("Filtre Theme")));
            Caption = 'Nbr. formations lancées';
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Nbr. formations fermee"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Status = FILTER(Closed),
                                                                  Direction = FIELD("Filtre Direction"),
                                                                  Service = FIELD("Filtre Service"),
                                                                  Annee = FIELD("Filtre annee"),
                                                                  Mois = FIELD("Filtre Mois"),
                                                                  "Centre formation" = FIELD("Filtre Centre Formation"),
                                                                  themes = FIELD("Filtre Theme")));
            Caption = 'Nbr. formations fermées';
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Nbr. formations non antamees"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Status = FILTER(0),
                                                                  Direction = FIELD("Filtre Direction"),
                                                                  Service = FIELD("Filtre Service"),
                                                                  Annee = FIELD("Filtre annee"),
                                                                  Mois = FIELD("Filtre Mois"),
                                                                  "Centre formation" = FIELD("Filtre Centre Formation"),
                                                                  themes = FIELD("Filtre Theme")));
            Caption = 'Nbr. formations non antamées';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Filtre Mois"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowFilter;
        }
        field(38; "Filtre Service"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(39; "Filtre Theme"; Code[20])
        {
            Caption = 'Filtre Thème';
            FieldClass = FlowFilter;
        }
        field(40; Mois; Integer)
        {
            BlankZero = true;
        }
        field(41; "Nbr. formations non planifiees"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Direction = FIELD("Filtre Direction"),
                                                                  Service = FIELD("Filtre Service"),
                                                                  Annee = FIELD("Filtre annee"),
                                                                  Mois = FIELD("Filtre Mois"),
                                                                  "Centre formation" = FIELD("Filtre Centre Formation"),
                                                                  themes = FIELD("Filtre Theme"),
                                                                  Nature = FILTER("Non Prevue")));
            Caption = 'Nbr. formations non planifiées';
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Nbr. formations planifiees"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Direction = FIELD("Filtre Direction"),
                                                                  Service = FIELD("Filtre Service"),
                                                                  Annee = FIELD("Filtre annee"),
                                                                  Mois = FIELD("Filtre Mois"),
                                                                  "Centre formation" = FIELD("Filtre Centre Formation"),
                                                                  themes = FIELD("Filtre Theme"),
                                                                  Nature = FILTER(Prevue)));
            Caption = 'Nbr. formations planifiées';
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; Evaluation; Text[250])
        {
        }
        field(44; "Nbr. formations plan. fermees"; Integer)
        {
            CalcFormula = Count("FOR-Programme Formations" WHERE(Direction = FIELD("Filtre Direction"),
                                                                  Service = FIELD("Filtre Service"),
                                                                  Annee = FIELD("Filtre annee"),
                                                                  Mois = FIELD("Filtre Mois"),
                                                                  "Centre formation" = FIELD("Filtre Centre Formation"),
                                                                  themes = FIELD("Filtre Theme"),
                                                                  Nature = FILTER(Prevue),
                                                                  Status = FILTER(Closed)));
            Caption = 'Nbr. formations planifiées fermées';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50103; "Facture generee"; Boolean)
        {
        }
        field(50104; "N° facture"; Code[20])
        {
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FILTER(Invoice),
                                                         "No." = FIELD("N° facture"));
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
        RecLProgramFormation: Record 52048924;
    begin
        IF RecLProgramFormation.FINDLAST THEN
            "N° Sequence" := RecLProgramFormation."N° Sequence" + 1
        ELSE
            "N° Sequence" := 1;
    end;


    procedure TotalCost(): Decimal
    var
        RecLPrgFormation: Record 52048924;
        DecLCost: Decimal;
    begin
        RecLPrgFormation.COPYFILTERS(Rec);
        IF RecLPrgFormation.FINDFIRST THEN
            REPEAT
                DecLCost := DecLCost + RecLPrgFormation.Cout;
            UNTIL RecLPrgFormation.NEXT = 0;
        EXIT(DecLCost);
    end;
}

