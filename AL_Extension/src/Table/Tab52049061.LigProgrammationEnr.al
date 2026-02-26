table 52049061 "Lig Programmation Enr"
{

    //GL2024  ID dans Nav 2009 : "39004725"

    fields
    {
        field(1; Journee; Date)
        {
        }
        field(2; Vehicule; Code[20])
        {

            trigger OnLookup()
            begin
                RecVehicule.SETFILTER("N° Vehicule", '%1|%2', 'CM*', 'TR*');
                IF page.RUNMODAL(page::"List Véhicules", RecVehicule) = ACTION::LookupOK THEN BEGIN
                    Vehicule := RecVehicule."N° Vehicule";
                    CALCFIELDS("Nom Vehicule");
                END;
            end;

            trigger OnValidate()
            begin
                CALCFIELDS("Nom Vehicule");
            end;
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Statut; Option)
        {
            OptionMembers = Disponible,Fonctionnel,Panne,Conge,"En Reparation","Mauvais Temps","Hors Service";
        }
        field(50001; "Designation Affaire"; Text[100])
        {
            CalcFormula = Lookup(Job.Description WHERE("No." = FIELD("Code Affaire")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(50002; "Designation Sous Affaire"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Code Sous Affaire")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Code Affaire"; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                CALCFIELDS("Designation Affaire");
            end;
        }
        field(50004; "Code Sous Affaire"; Code[20])
        {
            TableRelation = Item."No." WHERE("Tree Code" = FILTER('A-300*'));

            trigger OnValidate()
            begin
                CALCFIELDS("Designation Sous Affaire");
            end;
        }
        field(50005; "Nom Chauffeur"; Text[100])
        {
            CalcFormula = Lookup("Chauffeur Location".Nom WHERE(Code = FIELD(Chauffeur)));
            FieldClass = FlowField;
        }
        field(50006; "Nom Vehicule"; Text[100])
        {
            CalcFormula = Lookup(Véhicule.Désignation WHERE("N° Vehicule" = FIELD(Vehicule)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; Chauffeur; Code[20])
        {
            TableRelation = "Chauffeur Location";

            trigger OnValidate()
            begin
                CALCFIELDS("Nom Chauffeur");
            end;
        }
        field(50008; Observation; Text[100])
        {
        }
        field(50009; "N° Document"; Code[20])
        {
        }
        field(50010; "Point Chargement"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50011; "Point Dechargement"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50012; "Nombre Voyage"; Decimal)
        {
        }
        field(50013; "Code Sous Affaire 2"; Code[20])
        {
            TableRelation = Item."No." WHERE("Tree Code" = FILTER('A-300*'));

            trigger OnValidate()
            begin
                CALCFIELDS("Designation Sous Affaire");
            end;
        }
        field(50014; "Designation Sous Affaire 2"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Code Sous Affaire 2")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Code Sous Affaire 3"; Code[20])
        {
            TableRelation = Item."No." WHERE("Tree Code" = FILTER('A-300*'));

            trigger OnValidate()
            begin
                CALCFIELDS("Designation Sous Affaire");
            end;
        }
        field(50016; "Designation Sous Affaire 3"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Code Sous Affaire 3")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Code Sous Affaire 4"; Code[20])
        {
            TableRelation = Item."No." WHERE("Tree Code" = FILTER('A-300*'));

            trigger OnValidate()
            begin
                CALCFIELDS("Designation Sous Affaire");
            end;
        }
        field(50018; "Designation Sous Affaire 4"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Code Sous Affaire 2")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50019; "Index Depart"; Integer)
        {
        }
        field(50020; "Index Final"; Integer)
        {
        }
        field(50021; Synchronise; Boolean)
        {
        }
        field(50022; Tonnage; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50023; "N° BL"; Code[20])
        {
        }
        field(50024; Volume; Decimal)
        {
        }
        field(50025; Fournisseur; Code[20])
        {
        }
        field(50026; Compteur; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; Compteur)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecVehicule: Record Véhicule;
}

