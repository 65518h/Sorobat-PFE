Table 52048953 "Carière Enreg"
{
    //GL2024  ID dans Nav 2009 : "39001449"
    fields
    {
        field(1; "N° sequence"; Integer)
        {
        }
        field(2; employee; Code[20])
        {
        }
        field(3; date; Date)
        {
        }
        field(4; Type; Option)
        {
            NotBlank = true;
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
        }
        field(11; Echelon; Integer)
        {
            Caption = 'Echelon';
            TableRelation = "Baréme De Charge";
        }
        field(12; Grade; Integer)
        {
        }
        field(13; Echelle; Integer)
        {
        }
        field(14; Classe; Option)
        {
            OptionMembers = " ",A,B,C;
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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
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
        }
        field(43; "N° Document Extr."; Code[20])
        {
        }
        field(44; Utilisateur; Code[10])
        {
        }
        field(50; "Date Décesion"; Date)
        {
        }
        field(70; Name; Text[30])
        {
        }
        field(71; "First Name"; Text[30])
        {
        }
        field(80; Qualification; Code[10])
        {
        }
        field(81; "Souche N°"; Code[10])
        {
        }
        field(90; "Code Indemnité"; Code[20])
        {
            TableRelation = Indemnity;
        }
        field(91; "Default amount"; Decimal)
        {
            Caption = 'Default amount';
            DecimalPlaces = 3 : 5;
        }
        field(100; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(101; "Gross Salary"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Gross Salary';
            Editable = false;
        }
        field(102; "Date debut Contrat"; Date)
        {
            Description = '//MBY SAMI';
        }
        field(103; "Date Fin Contrat"; Date)
        {
            Description = '//MBY SAMI';
        }
        field(50000; codeAV; Code[10])
        {
        }
        field(50001; "N° Transaction"; Integer)
        {
        }
        field(50010; Direction; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = Direction.Code;
        }
        field(50011; Service; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = Service.Service where(Direction = field(Direction));
        }
        field(50012; Section; Code[10])
        {
            Description = '//MBY ENDA';
            TableRelation = "Tranche STC"."Taux STC" /* GL2024 WHERE("Plage Min" = FIELD(Direction),
                                                         "Plage Max" = FIELD(Service))*/;
        }
        field(50050; "Ancien Salaire Base"; Decimal)
        {
            AutoFormatType = 2;
        }
    }

    keys
    {
        key(Key1; "N° Document Extr.")
        {
            Clustered = true;
        }
        key(Key2; employee, "Date Décesion")
        {
        }
        key(Key3; employee, date)
        {
        }
    }

    fieldgroups
    {
    }

    var
        R286: Record Direction;
}

