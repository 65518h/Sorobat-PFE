Table 52049003 "Linge Programmation"
{//GL2024  ID dans Nav 2009 : "39004724"

    fields
    {
        field(1; Journee; Date)
        {
        }
        field(2; Vehicule; Code[20])
        {

            trigger OnLookup()
            begin
                RecVehicule.SetFilter("N° Vehicule", '%1|%2', 'CM*', 'TR*');
                if PAGE.RunModal(page::"List Véhicules", RecVehicule) = Action::LookupOK then begin
                    Vehicule := RecVehicule."N° Vehicule";
                    CalcFields("Nom Vehicule");
                end;
                if RecVehicule.Get(Vehicule) then begin
                    //RecVehicule.marche:=Chantier;
                    if Chauffeur <> '' then RecVehicule.Observation := Observation;
                    RecVehicule.Modify;
                end;
            end;

            trigger OnValidate()
            begin
                CalcFields("Nom Vehicule");
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
            CalcFormula = lookup(Job.Description where("No." = field(Chantier)));
            Editable = true;
            FieldClass = FlowField;
        }
        field(50002; "Designation Sous Affaire"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Code Sous Affaire")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; Chantier; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50004; "Code Sous Affaire"; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300*' | 'SM'));

            trigger OnValidate()
            begin
                CalcFields("Designation Sous Affaire");
                //IF RecItem.GET("Code Sous Affaire") THEN
                //  IF Volume<>0 THEN IF RecItem."Relation Volume / Tonnage"<>0 THEN Tonnage:=RecItem."Relation Volume / Tonnage"*Volume;
            end;
        }
        field(50005; "Nom Chauffeur"; Text[100])
        {
            CalcFormula = lookup("Chauffeur Location".Nom where(Code = field(Chauffeur)));
            FieldClass = FlowField;
        }
        field(50006; "Nom Vehicule"; Text[100])
        {
            CalcFormula = lookup(Véhicule.Désignation where("N° Vehicule" = field(Vehicule)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; Chauffeur; Code[20])
        {
            TableRelation = "Chauffeur Location";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50008; Observation; Text[100])
        {
        }
        field(50009; "N° Document"; Code[20])
        {
        }
        field(50010; "Point Chargement 1"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50011; "Point Dechargement 1"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50012; "Nombre Voyage"; Decimal)
        {
        }
        field(50013; "Code Sous Affaire 2"; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300*' | 'SM' | 'QUI-01 05'));

            trigger OnValidate()
            begin
                CalcFields("Designation Sous Affaire");
            end;
        }
        field(50014; "Designation Sous Affaire 2"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Code Sous Affaire 2")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Code Sous Affaire 3"; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300*' | 'SM'));

            trigger OnValidate()
            begin
                CalcFields("Designation Sous Affaire");
            end;
        }
        field(50016; "Designation Sous Affaire 3"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Code Sous Affaire 3")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Code Sous Affaire 4"; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300*' | 'SM'));

            trigger OnValidate()
            begin
                CalcFields("Designation Sous Affaire");
            end;
        }
        field(50018; "Designation Sous Affaire 4"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Code Sous Affaire 2")));
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

            trigger OnValidate()
            begin
                "Nombre Voyage" := 1;
            end;
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
        field(50026; Affectation; Code[20])
        {
            //GL3900  TableRelation = Payéage;

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50027; "Sous Affectation"; Code[20])
        {
            TableRelation = "Sous Affectation Marche";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50028; "Point Chargement 2"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50029; "Point Dechargement 2"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50030; "Point Chargement 3"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50031; "Point Dechargement 3"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50032; "Point Chargement 4"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
        field(50033; "Point Dechargement 4"; Text[20])
        {
            TableRelation = "Chargement - Dechargement";

            trigger OnValidate()
            begin
                UpdateVehicule;
            end;
        }
    }

    keys
    {
        key(Key1; "N° Document", Vehicule)
        {
            Clustered = true;
        }
        key(Key2; Chantier, Vehicule)
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecVehicule: Record "Véhicule";
        Text001: label 'BL Déja Saise';
        RecItem: Record Item;


    procedure UpdateVehicule()
    begin
        IF RecVehicule.GET(Vehicule) THEN BEGIN
            //  RecVehicule.marche:=Chantier;
            RecVehicule.Conducteur := Chauffeur;
            RecVehicule."Point Chargement" := "Point Chargement 1";
            RecVehicule."Point Dechargement" := "Point Dechargement 1";
            RecVehicule.MODIFY;
        end;
    end;
}

