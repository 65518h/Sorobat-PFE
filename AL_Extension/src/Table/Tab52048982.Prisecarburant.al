Table 52048982 "Prise carburant"
{
    //GL2024  ID dans Nav 2009 : "39004683"
    fields
    {
        field(1; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin

                if Veh.Get("N° Véhicule") then begin
                    Energie := Veh."Type de Carburant";
                    "Cons. Min" := Veh."Consommation Min";
                    "Cons.Max" := Veh."Consommation Max";
                    "N° Carte Carburant" := Veh."N°Carte Carburant";

                end;
                //IBK DSFT 15 04 2012
                if RecEnergie.Get(Energie) then begin
                    "Côut unitaire" := RecEnergie."Côut unitaire";
                    "Article Associé" := RecEnergie."Article Associé";
                end;
                //IBK DSFT 15 04 2012
            end;
        }
        field(2; "N° Mission"; Code[20])
        {
            TableRelation = Missions;

            trigger OnValidate()
            begin
                if Miss.Get("N° Mission") then
                    "Date de Prise" := Miss."Date Mission";
            end;
        }
        field(3; "N° Bon Gasoil"; Code[20])
        {
        }
        field(4; "Coût Réel Mission"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                //IF RecArticle.GET("Article Associé")THEN;
                //RecArticle.CALCFIELDS(Inventory);
                //IF ("Montant Carburant">RecArticle.Inventory) THEN ERROR(Text001);
                if "Côut unitaire" <> 0 then "Gasoil Consommé" := "Coût Réel Mission" / "Côut unitaire";
                Validate("Consommation Moyenne");
            end;
        }
        field(5; "Gasoil Consommé"; Decimal)
        {

            trigger OnValidate()
            begin
                TestField("Date de Prise");
                if RecParamétreParc.Get then "Côut unitaire" := RecParamétreParc."Coût Gasoil";
                if RecMissions.Get("N° Mission") then;
                "N° Véhicule" := RecMissions."N° Véhicule";
                "Article Associé" := RecParamétreParc."Article Gasoil";
                "N° Affaire" := RecMissions."N° Affaire";
                RecItem.SetFilter("No.", RecParamétreParc."Article Gasoil");
                RecItem.SetFilter("Location Filter", RecParamétreParc."Code Magasin");
                if RecItem.FindFirst then begin
                    RecItem.CalcFields(Inventory);
                    if RecItem.Inventory = 0 then Error(Text002, RecParamétreParc."Code Magasin");
                    if RecItem.Inventory < "Gasoil Consommé" then
                        Error(Text003, "Gasoil Consommé", RecItem.Inventory,
                              RecParamétreParc."Code Magasin");
                end;
                if RecVéhicule.Get(RecMissions."N° Véhicule") then begin
                    "Cons. Min" := RecVéhicule."Consommation Max";
                    "Cons.Max" := RecVéhicule."Consommation Min";
                    "Consommation Moyenne" := RecVéhicule."Consommation Moyen";
                end;

                "Coût Réel Mission" := "Gasoil Consommé" * "Côut unitaire";
                Validate("Coût Réel Mission");
                Validate("Consommation Moyenne");
                if "Coût Prevu Mission" <> 0 then "% Indicateur Réel/Prevu" := "Coût Réel Mission" / "Coût Prevu Mission" * 100;
            end;
        }
        field(6; Energie; Code[20])
        {
            Editable = false;
        }
        field(7; "Cons. Min"; Decimal)
        {
        }
        field(8; "Cons.Max"; Decimal)
        {
        }
        field(9; "Date de Prise"; Date)
        {

            trigger OnValidate()
            begin
                if RecParamétreParc.Get then "Côut unitaire" := RecParamétreParc."Coût Gasoil";
                if RecMissions.Get("N° Mission") then;
                "N° Véhicule" := RecMissions."N° Véhicule";
                if RecVéhicule.Get(RecMissions."N° Véhicule") then begin
                    "Cons. Min" := RecVéhicule."Consommation Max";
                    "Cons.Max" := RecVéhicule."Consommation Min";
                    "Consommation Moyenne" := RecVéhicule."Consommation Moyen";
                end;
                "Article Associé" := RecParamétreParc."Article Gasoil";
                "N° Affaire" := RecMissions."N° Affaire";
                "Coût Réel Mission" := "Gasoil Consommé" * "Côut unitaire";
                Validate("Coût Réel Mission");
                Validate("Consommation Moyenne");
                if "Coût Prevu Mission" <> 0 then "% Indicateur Réel/Prevu" := "Coût Réel Mission" / "Coût Prevu Mission" * 100;
            end;
        }
        field(10; "Consommation Moyenne"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //IBK DSFT 15 04 2012
                if Miss.Get("N° Mission") then;
                "Gasoil Consommé Prevu" := ((Miss."Km Parcourus" / 100) * "Consommation Moyenne");
                "Coût Prevu Mission" := "Gasoil Consommé Prevu" * "Côut unitaire";
                //IBK DSFT 15 04 2012
            end;
        }
        field(11; "Côut unitaire"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Editable = false;
        }
        field(12; Sequence; Integer)
        {
            AutoIncrement = true;
        }
        field(13; "Gasoil Consommé Prevu"; Decimal)
        {
            Editable = false;
        }
        field(14; "N° Carte Carburant"; Code[20])
        {
            TableRelation = Item."No." where("Type Carte" = const("Carte Carburant"));
        }
        field(15; "Sans Carte"; Boolean)
        {
        }
        field(16; "Coût Prevu Mission"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(17; "N° Affaire"; Code[20])
        {
        }
        field(18; "Article Associé"; Code[20])
        {
        }
        field(19; "% Indicateur Réel/Prevu"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Editable = false;
        }
        field(50001; "Designation Affaire"; Text[100])
        {
            CalcFormula = lookup(Job.Description where("No." = field("Code Affaire")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(50002; "Designation Sous Affaire"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Code Sous Affaire")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Code Affaire"; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                CalcFields("Designation Affaire");
            end;
        }
        field(50004; "Code Sous Affaire"; Code[20])
        {
            TableRelation = Item."No." where("Tree Code" = filter('A-300*' | 'SM'));

            trigger OnValidate()
            begin
                CalcFields("Designation Sous Affaire");
            end;
        }
        field(50005; "Nom Chauffeur"; Text[100])
        {
            CalcFormula = lookup("Chauffeur Location".Nom where(Code = field(Chauffeur)));
            FieldClass = FlowField;
        }
        field(50007; Chauffeur; Code[20])
        {
            TableRelation = "Chauffeur Location";

            trigger OnValidate()
            begin
                CalcFields("Nom Chauffeur");
            end;
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
    }

    keys
    {
        key(Key1; Sequence, "N° Véhicule", "N° Mission", "N° Affaire")
        {
        }
        key(Key2; "N° Véhicule", "N° Mission", "N° Bon Gasoil")
        {
            Clustered = true;
            SumIndexFields = "Gasoil Consommé", "Coût Réel Mission";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //MBY 11/02/2011

        //MBY 11/02/2011
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        Veh: Record "Véhicule";
        Miss: Record Missions;
        RecEnergie: Record Energie;
        RecArticle: Record Item;
        Text001: label 'Vous devez avoir un stock suffissant pour cette carte';
        "RecParamétreParc": Record "Paramétre Parc";
        "RecVéhicule": Record "Véhicule";
        RecMissions: Record Missions;
        RecItem: Record Item;
        Text002: label 'Stock Zero dans Le Magasin %1';
        Text003: label 'Quantité Consommé ( %1 ) Supérieure à Quantité En Stock ( %2 ) Pour Le Magasin %3';
}

