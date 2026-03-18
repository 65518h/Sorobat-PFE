Table 52048905 "Line grid"
{
    //GL2024  ID dans Nav 2009 : "39001434"
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            Editable = false;
            TableRelation = "Salary grid header";
        }
        field(3; "Catégorie"; Code[20])
        {
            Caption = 'Catégorie';
            Editable = true;
            NotBlank = true;
            TableRelation = CATEGORIES;
        }
        field(4; Echelons; Code[10])
        {
            Caption = 'Grade';
            TableRelation = Echelle.Echelle WHERE(Catégorie = FIELD(Catégorie));

            trigger OnValidate()
            begin
                //CLEAR(Col);
                /*IF NOT Col.GET (Collège) THEN
                   ERROR('Collège inexistant !!!');
                IF (Grade>Col."Borne Supérieure") OR (Grade<Col."Borne inférieure") THEN
                   ERROR('Grade Doit être entre %1 et %2, Merci',Col."Borne Supérieure",Col."Borne inférieure");
                */

            end;
        }
        field(5; Echelle; Integer)
        {
            Caption = 'Echelle';
            TableRelation = "Baréme De Charge"."Nombre De Charge";
        }
        field(6; Classe; Option)
        {
            Caption = 'Classe';
            OptionMembers = " ",A,B,C;
        }
        field(8; "Filter Echelon"; Integer)
        {
            Caption = 'Filter Echelon';
            FieldClass = FlowFilter;
        }
        field(10; "Salaire de base"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Salaire de base';
            DecimalPlaces = 3 : 3;
            trigger OnValidate()
            begin
                IF HumanResourcesSetup.GET THEN;
                IF HumanResourcesSetup."Nombre Heure Travail Par Mois" <> 0 THEN
                    VALIDATE("Taux Horaire", ROUND("Salaire de base" / HumanResourcesSetup."Nombre Heure Travail Par Mois", 1));
            end;
        }
        /*  field(11; "Mensuelle / Horraire"; Option)
          {
              OptionMembers = Mensuel,Horraire;
          }*/
        field(50000; "Bareme Abattement"; Decimal)
        {
        }
        field(50001; "Taux Horaire"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Taux Horaire 15%" := ROUND("Taux Horaire" * 115 / 100, 1);
                "Taux Horaire 35%" := ROUND("Taux Horaire" * 135 / 100, 1);
                "Taux Horaire 50%" := ROUND("Taux Horaire" * 150 / 100, 1);
                "Taux Horaire 60%" := ROUND("Taux Horaire" * 160 / 100, 1);
                "Taux Horaire 120%" := ROUND("Taux Horaire" * 220 / 100, 1);
            end;
        }
        field(50002; "Taux Horaire 15%"; Decimal)
        {
            Editable = false;
        }
        field(50003; "Taux Horaire 35%"; Decimal)
        {
            Editable = false;
        }
        field(50004; "Taux Horaire 50%"; Decimal)
        {
            Editable = false;
        }
        field(50005; "Taux Horaire 60%"; Decimal)
        {
            Editable = false;
        }
        field(50006; "Taux Horaire 120%"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "Code", "Catégorie", Echelons, Echelle, Classe)
        {
            Clustered = true;
        }
        key(STG_Key2; "Code", "Catégorie", Echelle)
        {
        }
    }
    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        Detailgrille.RESET;
        Detailgrille.SETCURRENTKEY(Code, Collège, Grade, Echelle, Classe, Echelon);
        Detailgrille.SETFILTER(Code, Code);
        Detailgrille.SETFILTER(Collège, Catégorie);
        // Detailgrille.SETFILTER(Grade,'%1',Echelons);
        Detailgrille.SETFILTER(Echelle, '%1', Echelle);
        Detailgrille.SETFILTER(Classe, '%1', Classe);
        Detailgrille.DELETEALL;
    end;

    trigger OnRename()
    begin
        //ERROR('Vous Devez supprimer la Ligne !!!');
    end;

    var
        Col: Record "CATEGORIES";
        HumanResourcesSetup: Record 5218;
        Detailgrille: Record "Salary grid lines";
}

