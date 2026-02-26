Table 52048993 "PR Réparation"
{
    //GL2024  ID dans Nav 2009 : "39004702"
    fields
    {
        field(1; "N° Reparation"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(7; "No."; Code[20])
        {
            TableRelation = if (Type = const(Article)) Item."No."
            else
            if (Type = const(MO)) Resource."No." where(Type = const(Person))
            else
            if (Type = const("Frais Annexe")) "Item Charge"."No.";

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    if Type = Type::Article then begin
                        It.Reset;
                        if It.Get("No.") then begin
                            Description := It.Description;
                            Validate("Coût Unitaire", It."Unit Cost");
                            if "N° Ligne" > 0 then
                                Modify;
                        end;
                    end
                    else
                        if Type = Type::MO then begin
                            Demandeur.Reset;
                            if Demandeur.Get("No.") then begin
                                //DYS ERREUR DANS NAV
                                // Validate("Coût Unitaire", Demandeur."Num Sequence Syncro");
                                if "N° Ligne" > 0 then
                                    Modify;
                            end;
                        end;
                end;
                if RecRéparationVéhicule.Get("N° Reparation") then begin
                    "N° Véhicule" := RecRéparationVéhicule."N° Véhicule";
                    Affectation := RecRéparationVéhicule.Affectation;
                end;
            end;
        }
        field(8; "Quantité"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if Type <> Type::Article then exit;
                TestField(Magasin);
                if RecParamétreParc.Get then;
                RecItem.SetFilter("No.", "No.");
                RecItem.SetFilter("Location Filter", Magasin);
                if RecItem.FindFirst then begin
                    RecItem.CalcFields(Inventory);
                    if RecItem.Inventory = 0 then Message(Text002, RecParamétreParc."Code Magasin");
                    if RecItem.Inventory < Quantité then Message(Text003, Quantité, RecItem.Inventory, Magasin);
                end;

                Validate("Coût Total", Quantité * "Coût Unitaire");
            end;
        }
        field(10; "Coût Unitaire"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                Validate("Coût Total", Quantité * "Coût Unitaire");
            end;
        }
        field(11; "Coût Total"; Decimal)
        {
            AutoFormatType = 1;
            Editable = false;
        }
        field(12; Description; Text[100])
        {
        }
        field(13; Type; Option)
        {
            OptionMembers = " ",Article,MO,"Frais Annexe";
        }
        field(14; "N° Véhicule"; Code[20])
        {
        }
        field(15; Affectation; Code[20])
        {
        }
        field(50000; Magasin; Code[20])
        {
            TableRelation = Location;

            trigger OnValidate()
            begin
                SetFilter("Filtre Magasin", Magasin);
                CalcFields("Quantité Stock");
            end;
        }
        field(50001; "Quantité Stock"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Location Code" = field("Filtre Magasin")));
            Description = 'HJ SORO 13-08-2014';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "Filtre Magasin"; Code[20])
        {
            Description = 'HJ SORO 13-08-2014';
            FieldClass = FlowFilter;
        }
        field(50003; Synchronise; Boolean)
        {
        }
        field(50010; Statut; Option)
        {
            OptionMembers = Ouvert,"En Attente","En Cours","Clôturé";
        }
        field(50011; DA; Boolean)
        {

            trigger OnValidate()
            begin
                if "Bon Sortie" then Error(Text001)
            end;
        }
        field(50012; "Bon Sortie"; Boolean)
        {

            trigger OnValidate()
            begin
                if DA then Error(Text001)
            end;
        }
        field(50013; Valider; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "N° Reparation", "N° Ligne")
        {
            Clustered = true;
            SumIndexFields = "Coût Total";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        PR.Reset;
        PR.SetRange("N° Reparation", "N° Reparation");
        if PR.Find('+') then
            "N° Ligne" := PR."N° Ligne" + 10000
        else
            "N° Ligne" := 10000;
    end;

    var
        PR: Record "PR Réparation";
        It: Record Item;
        RecFrais: Record "Item Charge";
        "RecRéparationVéhicule": Record "Réparation Véhicule";
        Text002: label 'Stock Zero dans Le Magasin %1';
        Text003: label 'Quantité Consommé ( %1 ) Supérieure à Quantité En Stock ( %2 ) Pour Le Magasin %3';
        RecItem: Record Item;
        "RecParamétreParc": Record "Paramétre Parc";
        Demandeur: Record Demandeur;
        Text001: label 'Une Seule Case a Cocher';
}

