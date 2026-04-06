Table 52049004 "Ligne Pointage Chauffeur Enr"
{
    //GL2024  ID dans Nav 2009 : "39004726"
    DrillDownPageID = "Ligne Rendement Vehicule Enreg";
    LookupPageID = "Ligne Rendement Vehicule Enreg";

    fields
    {
        field(1; Journee; Date)
        {
        }
        field(2; Chauffeur; Code[20])
        {
            TableRelation = "Chauffeur Location";

            /*GL2024 trigger OnValidate()
             begin
                 CalcFields("Nom Chauffeur");
                 RecVehicule.SetRange(Chauffeur, Chauffeur);
                 if RecVehicule.FindFirst then begin
                     RecVehicule.CalcFields("Designation Affaire", marche);
                     Vehicule := RecVehicule."N° Vehicule";
                     "Designation Affaire" := RecVehicule.Affaire;
                     "Designation Sous Affaire" := RecVehicule."Sous Affaire";
                 end;
             end;*/
        }
        field(3; Vehicule; Code[20])
        {
            TableRelation = Véhicule;
        }
        field(4; "Nombre Heure"; Decimal)
        {
        }
        field(5; "Quantité"; Decimal)
        {
        }
        field(6; "Designation Affaire"; Text[100])
        {
            CalcFormula = lookup(Job.Description where("No." = field("Code Affaire")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(7; "Designation Sous Affaire"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Code Sous Affaire")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; "Code Affaire"; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                CalcFields("Designation Affaire");
            end;
        }
        field(50001; "Code Sous Affaire"; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300 11*'));

            trigger OnValidate()
            begin
                CalcFields("Designation Sous Affaire");
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
        field(50004; "Point Chargement"; Text[20])
        {
        }
        field(50005; "Point Dechargement"; Text[20])
        {
        }
        field(50006; Deplacement; Boolean)
        {
        }
        field(50007; "N° Document"; Code[20])
        {
        }
        field(50009; Mission; Integer)
        {
            AutoIncrement = false;
        }
    }

    keys
    {
        key(STG_Key1; "N° Document", Journee, Vehicule, Chauffeur, "Code Sous Affaire", "Point Chargement", "Point Dechargement", "Code Affaire", Mission)
        {
            Clustered = true;
        }
        key(STG_Key2; Journee)
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecVehicule: Record "Véhicule";
}

