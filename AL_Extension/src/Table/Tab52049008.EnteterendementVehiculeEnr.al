Table 52049008 "Entete rendement Vehicule Enr"
{
    //GL2024  ID dans Nav 2009 : "39004731"
    DrillDownPageID = "Liste Rendement enregistré";
    LookupPageID = "Liste Rendement enregistré";

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
        field(50000; Provenance; Text[20])
        {
            TableRelation = "Chargement - Dechargement";
        }
        field(50001; Destination; Text[20])
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
            TableRelation = "Chauffeur Location";
        }
        field(50010; Volume; Integer)
        {
        }
        field(50014; "Durée Theorique (Minute)"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; Journee, Provenance, Destination, Vehicule, Produit, Marche)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
}

