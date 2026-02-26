
Table 52048952 "Saisie Carière"
{
    //GL2024  ID dans Nav 2009 : "39001448"
    fields
    {
        field(2; employee; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                CLEAR(T1);
                T1.GET(employee);
                "Salaire Base" := T1."Basis salary";
                Name := T1."Last Name";
                "First Name" := T1."First Name";
                "Catégorie soc." := T1."Catégorie soc.";
                Collège := T1.Catégorie;
                Echelon := T1.Echelons;
                Grade := T1.Grade;
                Echelon := T1.Echelle;
                Classe := T1.Classe;
                Fonction := T1."Job Title";
                Status := T1.Status;
                "Global Dimension 1 Code" := T1."Global Dimension 1 Code";
                "Global Dimension 2 Code" := T1."Global Dimension 2 Code";
                "Relation de travail" := T1."Relation de travail";
                "Date Entrée" := T1."Employment Date";
                "Site de travail" := T1.Direction;
                "Désignation Site de travail" := T1."Description Direction";
                "Date Debut Contrat" := T1."date debut contrat";
                "Date Fin Contrat" := T1."Termination Date";
            end;
        }
        field(3; date; Date)
        {
        }
        field(4; Type; Option)
        {
            OptionMembers = " ",Recrutement,"Passage Horizontal","Passage Vertical","Relation Travail","Site Travail",Fonction,"Renouvellement Contrat",Dossier,Statuts,Bonification,Promotion;
        }
        field(5; "Salaire Base"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(6; "Nbre Mois Bonification"; Decimal)
        {
        }
        field(7; "Date Entrée"; Date)
        {
        }
        field(9; "Catégorie soc."; Option)
        {
            OptionMembers = "Hors catégorie","Catégorie société";
        }
        field(10; "Collège"; Code[10])
        {
            Caption = 'Collège';
            TableRelation = CATEGORIES;

            trigger OnValidate()
            begin
                CalcSalBase;
            end;
        }
        field(11; Echelon; Code[10])
        {
            Caption = 'Echelon';
            TableRelation = "Baréme De Charge";

            trigger OnLookup()
            begin
                CalcSalBase;
            end;

            trigger OnValidate()
            begin
                CalcSalBase;
            end;
        }
        field(12; Grade; Integer)
        {

            trigger OnValidate()
            begin
                CalcSalBase;
            end;
        }
        field(13; Echelle; Integer)
        {

            trigger OnValidate()
            begin
                CalcSalBase;
            end;
        }
        field(14; Classe; Option)
        {
            OptionMembers = " ",A,B,C;

            trigger OnValidate()
            begin
                CalcSalBase;
            end;
        }
        field(15; Fonction; Text[50])
        {
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(40; "Relation de travail"; Option)
        {
            OptionMembers = " ",Stagiaire,Contractuel,Titulaire;
        }
        field(41; "Site de travail"; Code[10])
        {
            TableRelation = Direction;
        }
        field(42; "Désignation Site de travail"; Text[30])
        {
            Editable = false;
        }
        field(43; "N° Document Extr."; Code[20])
        {
        }
        field(50; "Date Décesion"; Date)
        {
        }
        field(70; Name; Text[30])
        {
            Editable = false;
        }
        field(71; "First Name"; Text[30])
        {
            Editable = false;
        }
        field(80; Qualification; Code[10])
        {
            TableRelation = Qualification;

            trigger OnValidate()
            begin
                CLEAR(T2);
                CLEAR(T1);
                IF T1.GET(employee) THEN;
                IF T2.GET(Qualification) THEN BEGIN
                    Collège := T2.Collège;
                    // Echelle:=T1.Echelle+1;
                    CalcSalBase;
                END;
            end;
        }
        field(81; "Souche N°"; Code[10])
        {
        }
        field(100; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(101; "Gross Salary"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Gross Salary';
            Editable = false;
        }
        field(102; "Date Debut Contrat"; Date)
        {
            Description = '//MBY SAMI';
        }
        field(103; "Date Fin Contrat"; Date)
        {
            Description = '//MBY SAMI';
        }
        field(50010; Direction; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = Direction.Code;
        }
        field(50011; Service; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = Service.Service WHERE(Direction = FIELD(Direction));
        }
        field(50012; Section; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                            "Plage Max" = FIELD(Service))*/;
        }
    }

    keys
    {
        key(Key1; "N° Document Extr.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        date := WORKDATE;
        ParmRSH.GET;
        IF "N° Document Extr." = '' THEN BEGIN
            "Souche N°" := ParmRSH."N° Document Decision";
            NoSeriesMgt.InitSeries(ParmRSH."N° Document Decision", ParmRSH."N° Document Decision", "Date Décesion",
              "N° Document Extr.", "Souche N°");
        END;
    end;

    var
        T1: Record 5200;
        T2: Record 5202;
        Grille: Record "Salary grid header";
        LigGrille: Record "Line grid";
        NoSeriesMgt: Codeunit 396;
        ParmRSH: Record 5218;
        Contrat: Record 5211;


    procedure CalcSalBase()
    var
        Sbase: Decimal;
    begin
        Sbase := 0;
        Grille.RESET;
        Grille.SETFILTER("Date Debut", '..%1', "Date Décesion");
        Grille.FIND('+');
        LigGrille.RESET;
        IF Contrat.GET(employee) THEN
            LigGrille.SETFILTER(Code, '%1', Contrat."Salary grid");
        LigGrille.SETFILTER(Catégorie, '%1', Collège);
        LigGrille.SETRANGE(Echelons, Echelon);
        IF LigGrille.FIND('-') THEN BEGIN
            Sbase := LigGrille."Salaire de base";
            // MESSAGE(FORMAT(Sbase));
            IF Sbase <> 0 THEN
                "Salaire Base" := Sbase;
        END
        //MEHDI
    end;
}

