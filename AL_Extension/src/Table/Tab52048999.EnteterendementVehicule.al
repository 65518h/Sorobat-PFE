Table 52048999 "Entete rendement Vehicule"
{
    //GL2024  ID dans Nav 2009 : "39004719"
    DrillDownPageID = "Liste Rendement";
    LookupPageID = "Liste Rendement";

    fields
    {
        field(1; "N° Document"; Code[20])
        {
        }
        field(2; Journee; Date)
        {
        }
        field(3; Marche; Code[20])
        {
            TableRelation = Job;
        }
        field(4; "Designation Affectation"; Text[100])
        {
            CalcFormula = lookup(Job.Description where("No." = field(Marche)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; Provenance; Text[30])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50001; Destination; Text[30])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50002; "Distance Parcourus"; Decimal)
        {
        }
        field(50003; "Nombre Voyage"; Decimal)
        {
        }
        field(50004; Produit; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300*' | 'A-PC*' | 'A-200*'));

            trigger OnValidate()
            begin
                CalcFields("Nom Produit");
            end;
        }
        field(50005; "Nom Produit"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Produit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Duree Rotation"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Duree Rotation" <> 0 then "Nombre Voyage" := 600 / "Duree Rotation";
            end;
        }
        field(50007; "Heure Depart"; Time)
        {
        }
        field(50008; Vehicule; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(50009; Chauffeur; Code[20])
        {
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                if RecVehicule.Get(Vehicule) then begin
                    RecVehicule.Observation := Chauffeur;
                    // if RecVehicule.Volume = 0 then
                    //     RecVehicule.Volume := 20;

                    RecVehicule.Modify;
                end;
            end;
        }
        field(50010; Volume; Integer)
        {

            trigger OnValidate()
            begin
                if RecVehicule.Get(Vehicule) then begin
                    RecVehicule.Volume := Volume;
                    RecVehicule.Modify;
                end;
            end;
        }
        field(50014; "Durée Theorique (Minute)"; Decimal)
        {
        }
        field(50015; "Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 11-10-2016';
            TableRelation = "Affectation Marche" where(Marche = field(Marche));
        }
        field(50016; "Sous Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 24-11-2015';
            TableRelation = "Sous Affectation Marche" where(Marche = field(Marche));
        }
        field(50017; Ordre; Integer)
        {

        }
    }

    keys
    {
        key(Key1; Journee, Provenance, Destination, Vehicule, Produit, Marche)
        {
            Clustered = true;
        }
        key(Key2; Ordre)
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LignerendementVehicule.SetRange(Journee, Journee);
        LignerendementVehicule.SetRange(Vehicule, Vehicule);
        LignerendementVehicule.SetRange(Provenance, Provenance);
        LignerendementVehicule.SetRange(Destination, Destination);
        LignerendementVehicule.SetRange(Produit, Produit);
        if LignerendementVehicule.FindFirst then LignerendementVehicule.Delete;
    end;

    trigger OnInsert()
    begin
        if "N° Document" = '' then begin
            //  IF ParametreParc.GET THEN;
            // "N° Document":=NoSeriesMgt.GetNextNo(ParametreParc."Rendement Serine N°",0D,TRUE);
            // Journee:=TODAY;
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
        RecVehicule: Record "Véhicule";
        LignerendementVehicule: Record "Ligne Rendement Vehicule";
}

