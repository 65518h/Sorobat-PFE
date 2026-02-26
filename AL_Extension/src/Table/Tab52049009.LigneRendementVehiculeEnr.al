Table 52049009 "Ligne Rendement Vehicule Enr"
{
    //GL2024  ID dans Nav 2009 : "39004733"
    fields
    {
        field(1; Mission; Integer)
        {
            AutoIncrement = false;
        }
        field(2; Vehicule; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(3; Chauffeur; Code[20])
        {
            TableRelation = "Chauffeur Location";
        }
        field(4; Marche; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                CalcFields("Designation Affaire");
            end;
        }
        field(5; "Designation Affaire"; Text[50])
        {
            CalcFormula = lookup(Job.Description where("No." = field(Marche)));
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
            TableRelation = Item."No." where("Tree Code" = filter('A-300*' | 'A-PC*' | 'A-200*'));

            trigger OnValidate()
            begin
                CalcFields("Nom Produit");
            end;
        }
        field(50002; "Nom Chauffeur"; Text[100])
        {
            CalcFormula = lookup("Chauffeur Location".Nom where(Code = field(Chauffeur)));
            FieldClass = FlowField;
        }
        field(50003; "Nom Vehicule"; Text[100])
        {
            CalcFormula = lookup(Véhicule.Désignation where("N° Vehicule" = field(Vehicule)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Nom Produit"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field(Produit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; Client; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                CalcFields("Nom Client");
            end;
        }
        field(50006; "Nom Client"; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field(Client)));
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
        field(50023; "Provenance 2"; text[20])
        {
        }
        /*  field(50044; Societe; Option)
          {
              OptionMembers = SOROUBAT,SETT,SOTAM;
          }
          field(50045; "Societe Flowfield"; Option)
          {
              //  CalcFormula = lookup(Véhicule.Societe where("N° Vehicule" = field(Vehicule)));
              // FieldClass = FlowField;
              OptionMembers = SOROUBAT,SETT,SOTAM;
          }*/
    }

    keys
    {
        key(Key1; Journee, Heure, "Provenance 2", Destination, Vehicule, Produit, Marche)
        {
            Clustered = true;
        }
        key(Key2; Journee, "Numero Voyage", Provenance, Destination, Vehicule, Produit)
        {
        }
        key(Key3; Journee, Vehicule, "Numero Voyage")
        {
        }
        key(Key4; Journee, Vehicule, Provenance, Destination, Produit)
        {
        }

        key(Key5; Journee, Journee, Produit)
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecVehicule: Record "Véhicule";


    procedure UpDateCout()
    begin
        "Cout Energie Mission" := "Distance Parcourus" * 0.55;
        if Densite <> 0 then Tonnage := Volume * Densite;
        if "Nombre Voyage" = 0 then "Nombre Voyage" := 1;
        "Cout Journee" := ("Cout Energie Mission" + 350 * "Taux Journée");
        if "Nombre Voyage" <> 0 then "Cout Voyage" := "Cout Journee" / "Nombre Voyage";
    end;
}

