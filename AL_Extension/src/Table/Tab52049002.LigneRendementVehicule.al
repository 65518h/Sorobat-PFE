Table 52049002 "Ligne Rendement Vehicule"
{
    //GL2024  ID dans Nav 2009 : "39004723"

    // {RecVehicule.SETFILTER("Code Catégorie",'%1|%2','CAMION BENNE','CAMION TRACTEUR');
    // RecVehicule.SETFILTER(Statut,'%1|%2',RecVehicule.Statut::Disponible,RecVehicule.Statut::Fonctionnel);
    // IF PAGE.RunModal(page::"List Véhicules",RecVehicule) = ACTION::LookupOK THEN
    //    BEGIN
    //      Vehicule:=RecVehicule."N° Vehicule";
    //      Chauffeur:=RecVehicule.Conducteur;
    //      Volume:=RecVehicule.Volume;
    //      CALCFIELDS("Nom Vehicule");
    //   END;}

    fields
    {
        field(1; Mission; Integer)
        {
            AutoIncrement = false;
        }
        field(2; Vehicule; Code[20])
        {
            TableRelation = Véhicule."N° Vehicule";
        }
        field(3; Chauffeur; Code[20])
        {
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                CALCFIELDS("Nom Chauffeur");
                IF RecVehicule.GET(Vehicule) THEN BEGIN
                    // RecVehicule.CALCFIELDS(Bloqué,Affectation);
                    Vehicule := RecVehicule."N° Vehicule";
                    "Cout Location Journaliere" := RecVehicule."Cout Journalier";
                    "Taux Journée" := 1;
                    RecVehicule.Conducteur := Chauffeur;
                    RecVehicule.MODIFY;
                END;
            end;
        }
        field(4; Marche; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                CALCFIELDS("Designation Affaire");
            end;
        }
        field(5; "Designation Affaire"; Text[50])
        {
            CalcFormula = Lookup(Job.Description WHERE("No." = FIELD(Marche)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Provenance; Text[20])
        {
        }
        field(7; Destination; Text[20])
        {
        }
        field(8; "Distance Parcourus"; Decimal)
        {

            trigger OnValidate()
            begin
                UpDateCout;
            end;
        }
        field(9; "Nombre Voyage"; Decimal)
        {

            trigger OnValidate()
            begin
                UpDateCout;
            end;
        }
        field(10; Volume; Decimal)
        {

            trigger OnValidate()
            begin
                UpDateCout;
            end;
        }
        field(11; Tonnage; Decimal)
        {

            trigger OnValidate()
            begin
                UpDateCout;
            end;
        }
        field(12; Densite; Decimal)
        {

            trigger OnValidate()
            begin
                UpDateCout;
            end;
        }
        field(13; "Cout Energie Mission"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(14; Journee; Date)
        {
        }
        field(15; "Validé"; Boolean)
        {
        }
        field(16; "Cout Voyage"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(17; "Cout M Cube / KM"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(18; "Cout La Tonne"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(19; "Cout Location Journaliere"; Decimal)
        {
            Editable = false;
        }
        field(20; "Taux Journée"; Decimal)
        {

            trigger OnValidate()
            begin
                UpDateCout;
            end;
        }
        field(50001; Produit; Code[20])
        {
            TableRelation = Item."No." WHERE("Tree Code" = FILTER('A-300*' | 'A-PC*' | 'A-200*'));

            trigger OnValidate()
            begin
                CALCFIELDS("Nom Produit");
            end;
        }
        field(50002; "Nom Chauffeur"; Text[100])
        {
            CalcFormula = Lookup("Shipping Agent".Name WHERE(Code = FIELD(Chauffeur)));
            FieldClass = FlowField;
        }
        field(50003; "Nom Vehicule"; Text[100])
        {
            CalcFormula = Lookup(Véhicule.Désignation WHERE("N° Vehicule" = FIELD(Vehicule)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Nom Produit"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD(Produit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; Client; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CALCFIELDS("Nom Client");
            end;
        }
        field(50006; "Nom Client"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD(Client)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Cout Journee"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(50008; Observation; Text[200])
        {
        }
        field(50009; "N° Document"; Code[20])
        {
        }
        field(50010; "N° Ligne"; Integer)
        {
            AutoIncrement = false;
        }
        field(50011; Heure; Time)
        {

            trigger OnValidate()
            begin
                //"Duree Reel (Minute)":=((Heure-"Heure Depart")/3600000)*60;
                //"Ecart (Minute)":="Duree Reel (Minute)"-"Durée Theorique (Minute)";
                "Date Saisie" := CURRENTDATETIME;
            end;
        }
        field(50012; "Quantité"; Decimal)
        {
        }
        field(50013; "Durée Intervention (Minute)"; Decimal)
        {
        }
        field(50014; "Durée Theorique (Minute)"; Decimal)
        {
        }
        field(50015; "Type Provenance"; Option)
        {
            OptionMembers = Soroubat,Fournisseur;
        }
        field(50016; "Duree Reel (Minute)"; Decimal)
        {
        }
        field(50017; "Ecart (Minute)"; Decimal)
        {
        }
        field(50018; "Heure Depart"; Time)
        {
        }
        field(50019; Pause; Boolean)
        {
        }
        field(50020; "Date Saisie"; DateTime)
        {
        }
        field(50021; "Numero Voyage"; Integer)
        {
        }
        field(50022; "Reprise Heure Pause"; Time)
        {
        }
        field(50023; "Provenance 2"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; Journee, Marche, Heure, "Provenance 2", Destination, Vehicule, Produit)
        {
            Clustered = true;
        }
        key(STG_Key2; Journee, Vehicule, "Numero Voyage")
        {
        }
        key(STG_Key3; Journee, "Numero Voyage", "Provenance 2", Destination, Vehicule, Produit)
        {
        }
        key(STG_Key4; Journee, Vehicule, Heure)
        {
        }
        key(STG_Key5; Vehicule, "Provenance 2", Destination, Produit)
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecVehicule: Record Véhicule;


    procedure UpDateCout()
    begin
        "Cout Energie Mission" := "Distance Parcourus" * 0.55;
        IF Densite <> 0 THEN Tonnage := Volume / Densite;
        IF "Nombre Voyage" = 0 THEN "Nombre Voyage" := 1;
        "Cout Journee" := ("Cout Energie Mission" + 350 * "Taux Journée");
        IF "Nombre Voyage" <> 0 THEN "Cout Voyage" := "Cout Journee" / "Nombre Voyage";
        IF (Volume <> 0) AND ("Distance Parcourus" <> 0) THEN "Cout M Cube / KM" := ("Cout Journee" / Volume) / "Distance Parcourus";
        IF (Tonnage <> 0) AND ("Distance Parcourus" <> 0) THEN "Cout La Tonne" := ("Cout Journee" / Tonnage) / "Distance Parcourus";
    end;
}

