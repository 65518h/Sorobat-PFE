Table 50004 "PV Reception"
{
    DrillDownPageID = "Liste PV Reception";
    LookupPageID = "Liste PV Reception";

    fields
    {
        field(1; "N° Commande"; Code[20])
        {
            Editable = false;
        }
        field(2; "N° Article"; Code[20])
        {
            Editable = false;
        }
        field(3; "Date Commande"; Date)
        {
            Editable = false;
        }
        field(4; "Lieu De Chargement"; Text[100])
        {
            Editable = false;
        }
        field(5; "N° BL Fournisseur"; Code[20])
        {
            Editable = true;
        }
        field(6; "N° Camion"; Code[20])
        {
            Editable = true;
            TableRelation = Véhicule;
        }
        field(7; "Date Heure depart Chatier"; DateTime)
        {
        }
        field(8; "Date Heure Chargement Frs"; DateTime)
        {
        }
        field(9; "Date Heure Retour Chantier"; DateTime)
        {
        }
        field(10; "Tare Chez Fournisseur"; Decimal)
        {

            trigger OnValidate()
            begin
                if ("Tare Chez Fournisseur" <> 0) and ("Poids Brut Fournisseur" <> 0) then
                    "Poids Net Fournisseur" := "Poids Brut Fournisseur" - "Tare Chez Fournisseur";
            end;
        }
        field(11; "Poids Brut Fournisseur"; Decimal)
        {

            trigger OnValidate()
            begin
                "Poids Net Fournisseur" := 0;
                if ("Tare Chez Fournisseur" <> 0) and ("Poids Brut Fournisseur" <> 0) then
                    "Poids Net Fournisseur" := "Poids Brut Fournisseur" - "Tare Chez Fournisseur";
            end;
        }
        field(12; "Poids Net Fournisseur"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Ecart Poids Net Chantier" := 0;
                if ("Poids Net Chantier" <> 0) and ("Poids Net Fournisseur" <> 0) then
                    "Ecart Poids Net Chantier" := "Poids Net Chantier" - "Poids Net Fournisseur";
            end;
        }
        field(13; "Tare Chantier"; Decimal)
        {
        }
        field(14; "Poids Brut Chantier"; Decimal)
        {

            trigger OnValidate()
            begin
                "Poids Net Chantier" := 0;
                "Quantité SC" := 0;
                if ("Tare Chantier" <> 0) and ("Poids Brut Chantier" <> 0) then
                    "Poids Net Chantier" := "Poids Brut Chantier" - "Tare Chantier";

                if ("Poids Net Fournisseur" <> 0) and ("Poids Brut Chantier" <> 0) then
                    "Ecart Poids Net Chantier" := "Poids Net Chantier" - "Poids Net Fournisseur";
                if ("Poids Apres SC" <> 0) and ("Poids Brut Chantier" <> 0) then
                    "Quantité SC" := "Poids Brut Chantier" - "Poids Apres SC";
            end;
        }
        field(15; "Poids Net Chantier"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Ecart Poids Net Chantier" := 0;
                "Ecart Final" := 0;
                if ("Poids Net Chantier" <> 0) and ("Poids Net Fournisseur" <> 0) then
                    "Ecart Poids Net Chantier" := "Poids Net Chantier" - "Poids Net Fournisseur";
                if ("Poids Net Chantier" <> 0) and ("Quantité SC" <> 0) then
                    "Ecart Final" := ("Quantité SC" + "Quantité CB") - "Poids Net Chantier";
            end;
        }
        field(16; "Ecart Poids Net Chantier"; Decimal)
        {
            Editable = false;
        }
        field(17; "Poids Apres SC"; Decimal)
        {
            Description = 'SC: Sol Ciment';

            trigger OnValidate()
            begin
                "Ecart Final" := 0;
                "Quantité SC" := 0;
                "Quantité CB" := 0;
                "Poids Aprés CB" := 0;
                if ("Poids Apres SC" <> 0) and ("Poids Brut Chantier" <> 0) then
                    "Quantité SC" := "Poids Brut Chantier" - "Poids Apres SC";
                if ("Poids Apres SC" <> 0) and ("Poids Aprés CB" <> 0) then
                    "Quantité CB" := "Poids Apres SC" - "Poids Aprés CB";
                if ("Poids Net Chantier" <> 0) and ("Quantité SC" <> 0) then
                    "Ecart Final" := ("Quantité SC" + "Quantité CB") - "Poids Net Chantier";
            end;
        }
        field(18; "Quantité SC"; Decimal)
        {
            Editable = false;
        }
        field(19; "Poids Aprés CB"; Decimal)
        {
            Description = 'CB : Central Beton';

            trigger OnValidate()
            begin
                "Ecart Final" := 0;
                "Quantité CB" := 0;

                if ("Poids Apres SC" <> 0) and ("Poids Aprés CB" <> 0) then
                    "Quantité CB" := "Poids Apres SC" - "Poids Aprés CB";
                if ("Poids Net Chantier" <> 0) and ("Quantité SC" <> 0) then
                    "Ecart Final" := ("Quantité SC" + "Quantité CB") - "Poids Net Chantier";
            end;
        }
        field(20; "Quantité CB"; Decimal)
        {
            Editable = false;
        }
        field(21; "N° Ligne"; Decimal)
        {
        }
        field(22; "N° Sequence"; Integer)
        {
            AutoIncrement = true;
        }
        field(23; "N° Affaire"; Code[20])
        {
            Editable = false;
        }
        field(24; "N° Receptipon"; Code[20])
        {
            Editable = false;
        }
        field(25; "Ecart Final"; Decimal)
        {
            Editable = false;
        }
        field(26; Remarque; Text[250])
        {
        }
        field(27; "N° Reception Enregistré"; Code[20])
        {
            Editable = false;
        }
        field(28; "Code Fournisseur"; Code[20])
        {
        }
        field(29; "Designation Article"; Text[250])
        {
            CalcFormula = lookup(Item.Description where("No." = field("N° Article")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Code Magasin"; Code[20])
        {
            TableRelation = Location;
        }
    }

    keys
    {
        key(STG_Key1; "N° Sequence", "N° Commande", "N° Article")
        {
            Clustered = true;
        }
        key(STG_Key2; "Code Magasin")
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecPurchaseLine: Record "Purchase Line";
}

