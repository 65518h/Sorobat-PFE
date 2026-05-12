Table 52048972 "Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004670"
    DrillDownPageID = "List Véhicules";
    LookupPageID = "List Véhicules";

    fields
    {
        field(1; "N° Vehicule"; Code[10])
        {
        }
        field(2; "Désignation"; Text[60])
        {
        }
        field(3; Immatriculation; Code[20])
        {
        }
        field(4; "Date D'immatriculation"; Date)
        {
        }
        field(5; "Code Immo"; Code[10])
        {
            TableRelation = "Fixed Asset";

            trigger OnValidate()
            begin
                //PlanAmort.SETRANGE("FA No.","Code Immo");
                //IF PlanAmort.FIND('-') THEN
                //   VALIDATE("Date d'acquisition",PlanAmort."Acquisition Date");
                IF Immo.GET("Code Immo") THEN BEGIN
                    "Code Classe Immobilisation" := Immo."FA Class Code";
                    "Code Sous-Classe Immo" := Immo."FA Subclass Code";
                    "Code Emplacement" := Immo."FA Location Code";
                END;
            end;
        }
        field(6; "Type de Carburant"; Code[20])
        {
            TableRelation = Energie;
        }
        field(7; "Date d'acquisition"; Date)
        {

            trigger OnValidate()
            begin
                ParcSetup.GET;
                Express := '+' + FORMAT(ParcSetup."Durée Garantie");
                IF "Date d'acquisition" <> 0D THEN
                    "Date Fin de Garantie" := CALCDATE(Express, "Date d'acquisition");
            end;
        }
        field(8; "Date PMC"; Date)
        {
        }
        field(9; "Date Fin de Garantie"; Date)
        {
        }
        field(10; "Type Compteur"; Option)
        {
            OptionMembers = "1","2";
        }
        field(11; Famille; Code[50])
        {
            TableRelation = "Catégorie Véhicule";
        }
        field(12; "Sous Famille"; Code[50])
        {
            TableRelation = "Sous Catégorie Véhicule"."Code Sous-Catégorie" WHERE("Code Catégorie" = FIELD(Famille));
        }
        field(13; "Consommation Max"; Decimal)
        {

            trigger OnValidate()
            begin
                "Consommation Moyen" := ("Consommation Max" + "Consommation Min") / 2;
            end;
        }
        field(14; "Consommation Min"; Decimal)
        {

            trigger OnValidate()
            begin
                "Consommation Moyen" := ("Consommation Max" + "Consommation Min") / 2
            end;
        }
        field(15; "Consommation Moyen"; Decimal)
        {
            Editable = false;
        }
        field(16; "Capacité Reservoire"; Code[10])
        {
        }
        field(17; "Num Clef de porte"; Code[20])
        {
        }
        field(18; "Num Moteur"; Code[20])
        {
        }
        field(19; "Num Châssis"; Code[20])
        {
        }
        field(20; "Date Derniére Visite"; Date)
        {
            CalcFormula = Max("Visite Technique"."Date Visite" WHERE("N° Véhicule" = FIELD("N° Vehicule"),
                                                                      Valider = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Date Derniére Reparation"; Date)
        {
            CalcFormula = Max("Réparation Véhicule Enreg."."Date Début Réparation" WHERE("N° Véhicule" = FIELD("N° Vehicule")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Kms Parcourus"; Decimal)
        {
            CalcFormula = Sum("Mission Enregistré"."Km Parcourus" WHERE("N° Véhicule" = FIELD("N° Vehicule"),
                                                                         Status = FILTER(<> Annulée)));
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "No. Series"; Code[25])
        {
        }
        field(24; "Code Classe Immobilisation"; Code[10])
        {
            Editable = false;
            TableRelation = "FA Class";
        }
        field(25; "Code Sous-Classe Immo"; Code[10])
        {
            Editable = false;
            TableRelation = "FA Subclass";
        }
        field(26; "Code Emplacement"; Code[10])
        {
            Editable = false;
            TableRelation = "FA Location";
        }
        field(27; Bloquer; Boolean)
        {
        }
        field(28; Image; BLOB)
        {
        }
        field(29; "Quantité Carburant consommé"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Prise carburant Enregistré"."Gasoil Consommé" WHERE("N° Véhicule" = FIELD("N° Vehicule"),
                                                                                    "Date de Prise" = FIELD("Filtre Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Coût Carburant consommé"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Prise carburant Enregistré"."Coût Réel Mission" WHERE("N° Véhicule" = FIELD("N° Vehicule"),
                                                                                      "Date de Prise" = FIELD("Filtre Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Index de Départ"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                IF xRec."Index de Départ" <> 0 THEN
                    ERROR('l''indexe de départ ne peut pas être modifier')
                ELSE
                    VALIDATE("Index Théorique Final");
            end;
        }
        field(32; "Index Théorique Final"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = true;

            trigger OnValidate()
            begin
                "Index Théorique Final" := "Index de Départ" + "Kms Parcourus";
            end;
        }
        field(33; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(34; "Mission réservé"; Integer)
        {
            CalcFormula = Count(Missions WHERE("N° Véhicule" = FIELD("N° Vehicule")));
            FieldClass = FlowField;
        }
        field(35; "Coût Assurance"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Assurance Véhicule".Tarif WHERE("N° Veh" = FIELD("N° Vehicule"),
                                                                "Date Document" = FIELD("Filtre Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Coût Vignette"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Vignette Véhicule".Tarif WHERE("N° Veh" = FIELD("N° Vehicule"),
                                                               "Date Document" = FIELD("Filtre Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Coût Visite Technique"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Visite Technique"."Montant Total" WHERE("N° Véhicule" = FIELD("N° Vehicule"),
                                                                        "Date Visite" = FIELD("Filtre Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Coût Taxe"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum(Taxe.Montant WHERE("N° Véhicule" = FIELD("N° Vehicule"),
                                                  "Date Document" = FIELD("Filtre Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; Emplacement; Option)
        {
            OptionCaption = 'Siége,Usine';
            OptionMembers = "Siége",Usine;
        }
        field(40; Transformation; Text[150])
        {
            TableRelation = Véhicule;
        }
        field(41; "N°GPRS"; Text[30])
        {
        }
        field(42; "Date Montage"; Date)
        {
        }
        field(43; "Date Demontage"; Date)
        {
        }
        field(44; "N°Carte Carburant"; Code[20])
        {
            TableRelation = Item."No." WHERE("No." = FIELD("N° Vehicule"),
                                            "Type Carte" = CONST("Carte Carburant"));
        }
        field(45; "Budget Carte Carburant"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(46; "Seuil Alerte Vidange"; Decimal)
        {
        }
        field(47; "Durée visite technique"; DateFormula)
        {
        }
        field(48; "N° Carte"; Code[20])
        {
        }
        field(49; "Grande Famille"; Code[50])
        {
            TableRelation = "Genre Véhicule";
        }
        field(50; Marque; Code[50])
        {
            TableRelation = "Marque Véhicule";
        }
        field(51; Type; Code[20])
        {
        }
        field(52; "Modéle"; Code[30])
        {
            TableRelation = "Modéle véhicule"."Code Modéle" WHERE("Code Marque" = FIELD(Marque));
        }
        field(53; Puissance; Code[10])
        {
        }
        field(54; "Série"; Code[30])
        {
        }
        field(55; Carrosserie; Text[30])
        {
        }
        field(56; "Poids TTCharges"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(57; "Poids à Vide"; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(58; "Seuil Alerte Visite Technique"; DateFormula)
        {
        }
        field(59; "Seuil Alerte Vignette"; DateFormula)
        {
        }
        field(60; "Libelle Categorie"; Text[100])
        {
            CalcFormula = Lookup("Catégorie Véhicule".Désignation WHERE("Code Catégorie" = FIELD(Famille)));
            FieldClass = FlowField;
        }
        field(61; "Seuil Alerte Assurance"; DateFormula)
        {
        }
        field(62; "Type Index"; Option)
        {
            OptionMembers = " ",Horaire,Kilometrage;
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'HJ SORO 19-05-2015';
        }
        field(50005; "Ancien Code"; code[10])
        {
            Description = 'HJ SORO 19-05-2015';

        }
        field(50006; "Sous Affaire"; Code[20])
        {
            TableRelation = Item."No." WHERE("Tree Code" = FILTER('A-300*'));

            trigger OnValidate()
            begin
                CALCFIELDS(marche);
            end;
        }
        field(50007; "Designation Affaire"; Text[100])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(50008; marche; Code[20])
        {
            TableRelation = Job;
        }
        field(50009; "Date Expiration Vignette"; Date)
        {
        }
        field(50010; "Date Exp Carte Grise"; Date)
        {
        }
        field(50011; "Date Expiration Visite Tech"; Date)
        {
        }
        field(50012; "Num Police Assurance"; Code[20])
        {
        }
        field(50013; "Date Expiration Assurance"; Date)
        {
        }
        field(50014; "Date Exp Carte Exploitation"; Date)
        {
        }
        field(50017; "Type Marque Location"; Code[20])
        {
            TableRelation = "Modéle véhicule"."Code Modéle";
        }
        field(50018; "Nom Chauffeur"; Text[50])
        {
        }
        field(50019; Observation; Text[100])
        {
        }
        field(50020; Fournisseurs; Code[20])
        {
            TableRelation = Vendor;
        }
        field(50021; "Nom Fournisseurs"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD(Fournisseurs)));
            FieldClass = FlowField;
        }
        field(50022; "Cout Journalier"; Decimal)
        {
        }
        field(50023; "Unité Travail"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(50024; Statut; Option)
        {
            Editable = true;
            OptionMembers = " ",Fonctionnel,Disponible,Panne,"Mauvais Temps","Accidenté","Réformé";
        }
        field(50025; "Compteur Actuel"; Integer)
        {
        }
        field(50026; "Dernier Vidange"; Integer)
        {
            Editable = true;

            trigger OnValidate()
            begin
                "Prochain Vidange" := "Dernier Vidange" + "Vidange A";
                IF "Type Index" = "Type Index"::Horaire THEN
                    "Reste Pour Alerte" := "Prochain Vidange" - "Compteur Actuel" - "Alerte Avant";
                IF "Type Index" = "Type Index"::Kilometrage THEN
                    "Reste Pour Alerte" := "Prochain Vidange" - "Compteur Actuel" - "Alerte Avant";
            end;
        }
        field(50027; "Vidange A"; Integer)
        {
        }
        field(50028; "Reste Pour Alerte"; Integer)
        {
            Editable = true;
        }
        field(50029; "Prochain Vidange"; Integer)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //  RecVehicule.MODIFY;
            end;
        }
        field(50030; "Vidange Effectué"; Boolean)
        {
        }
        field(50031; Conducteur; Code[20])
        {
            TableRelation = Salarier;
        }
        field(50032; "Alerte Avant"; Integer)
        {
        }
        field(50033; "Date Expiration AT"; Date)
        {
        }
        field(50034; "Date Expiration Derogation"; Date)
        {
        }
        field(50035; "Date Expiration Autori. Hydro"; Date)
        {
        }
        field(50036; "Date Expiration Carte Transpor"; Date)
        {
        }
        field(50037; "Date Expiration Patente"; Date)
        {
        }
        field(50038; "Date Expiration Stationnement"; Date)
        {
        }
        field(50039; "Date Expiration Carte Jaune"; Date)
        {
        }
        field(50040; "Date Expiration Certificat de"; Date)
        {
        }
        field(50041; "Compteur Actuel Vidange"; Integer)
        {
        }
        field(50043; Ordre; Integer)
        {
            AutoIncrement = false;
        }
        field(51003; "Delai Prochain"; Option)
        {
            Description = 'HJ SORO 09-12-2015';
            OptionMembers = " ","1 Année","6 Mois";
        }
        field(51004; "Alerte Papier"; Boolean)
        {
        }
        field(51005; "Cout Conducteur Journalier"; Decimal)
        {
        }
        field(51006; Location; Boolean)
        {
        }
        field(51007; "Cout Location Horaire"; Decimal)
        {
        }
        field(60000; TransporT; Boolean)
        {
        }
        field(60001; Volume; Integer)
        {
        }
        field(60002; "Motif Panne"; Code[20])
        {
            Editable = false;
        }
        field(60003; "Motif Disponibilité"; Option)
        {
            Editable = false;
            OptionMembers = " ","Non Affecté","Absence Conducteur",Autre;
        }
        field(60004; "Derniere Date Fonctionnel"; Date)
        {
            Editable = false;
        }
        field(60005; "N° Fiche Reparation"; Code[20])
        {
            Editable = false;
        }
        field(60006; "DA Lancé"; Boolean)
        {
            Editable = false;
        }
        field(60007; "N° Da"; Code[20])
        {
            Editable = false;
        }
        field(60008; "Point Chargement"; Code[50])
        {
        }
        field(60009; "Point Dechargement"; Code[50])
        {
        }
        field(60010; "Carte Grise"; Option)
        {
            OptionMembers = " ",OK,"Not OK",Provisoire;
        }
        field(60011; "Ne pas Tester Position Engin"; Boolean)
        {
        }
        field(60012; MO; Code[20])
        {
            TableRelation = Resource WHERE(Type = CONST(Person));
        }
        field(60013; "Vidange A 1"; Integer)
        {
        }
        field(60014; "Vidange A 2"; Integer)
        {
        }
        field(60015; "Vidange A 3"; Integer)
        {
        }
        field(60016; "Alerte avant 1"; Integer)
        {
        }
        field(60017; "Alerte avant 2"; Integer)
        {
        }
        field(60018; "Alerte avant 3"; Integer)
        {
        }
        field(60019; "Dernier vidange 1"; Integer)
        {

            trigger OnValidate()
            begin
                "Prochain vidange 1" := "Dernier vidange 1" + "Vidange A 1";
                IF "Type Index" = "Type Index"::Horaire THEN
                    "Reste pour alerte 1" := "Prochain vidange 1" - "Compteur Actuel" - "Alerte avant 1";
                IF "Type Index" = "Type Index"::Kilometrage THEN
                    "Reste pour alerte 1" := "Prochain vidange 1" - "Compteur Actuel" - "Alerte avant 1";
            end;
        }
        field(60020; "Dernier vidange 2"; Integer)
        {

            trigger OnValidate()
            begin
                "Prochain vidange 2" := "Dernier vidange 2" + "Vidange A 2";
                IF "Type Index" = "Type Index"::Horaire THEN
                    "Reste pour alerte 2" := "Prochain vidange 2" - "Compteur Actuel" - "Alerte avant 2";
                IF "Type Index" = "Type Index"::Kilometrage THEN
                    "Reste pour alerte 2" := "Prochain vidange 2" - "Compteur Actuel" - "Alerte avant 2";
            end;
        }
        field(60021; "Dernier vidange 3"; Integer)
        {

            trigger OnValidate()
            begin
                "Prochain vidange 3" := "Dernier vidange 3" + "Vidange A 3";
                IF "Type Index" = "Type Index"::Horaire THEN
                    "Reste pour alerte 3" := "Prochain vidange 3" - "Compteur Actuel" - "Alerte avant 3";
                IF "Type Index" = "Type Index"::Kilometrage THEN
                    "Reste pour alerte 3" := "Prochain vidange 3" - "Compteur Actuel" - "Alerte avant 3";
            end;
        }
        field(60022; "Prochain vidange 1"; Integer)
        {
        }
        field(60023; "Prochain vidange 2"; Integer)
        {
        }
        field(60024; "Prochain vidange 3"; Integer)
        {
        }
        field(60025; "Reste pour alerte 1"; Integer)
        {
        }
        field(60026; "Reste pour alerte 2"; Integer)
        {
        }
        field(60027; "Reste pour alerte 3"; Integer)
        {
        }
        field(60028; "Vidange A 1000H"; Integer)
        {
        }
        field(60029; "Alerte avant 1000H"; Integer)
        {
        }
        field(60030; "Dernier vidange 1000H"; Integer)
        {

            trigger OnValidate()
            begin
                "Prochain vidange 1000H" := "Dernier vidange 1000H" + "Vidange A 1000H";
                IF "Type Index" = "Type Index"::Horaire THEN
                    "Reste pour alerte 1000H" := "Prochain vidange 1000H" - "Compteur Actuel" - "Alerte avant 1000H";
                IF "Type Index" = "Type Index"::Kilometrage THEN
                    "Reste pour alerte 1000H" := "Prochain vidange 1000H" - "Compteur Actuel" - "Alerte avant 1000H";
            end;
        }
        field(60031; "Prochain vidange 1000H"; Integer)
        {
        }
        field(60032; "Reste pour alerte 1000H"; Integer)
        {
        }

    }

    keys
    {
        key(STG_Key1; "N° Vehicule")
        {
            Clustered = true;
        }
        key(STG_Key2; Immatriculation)
        {
        }
        key(STG_Key3; Famille)
        {
        }
        key(STG_Key4; Synchronise)
        {
        }
        key(STG_Key5; "Grande Famille", Famille, "Sous Famille")
        {
        }
        key(STG_Key6; marche, "N° Vehicule")
        {
        }
        key(STG_Key7; Ordre)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //VerifEcritureVéhicule;
    end;

    trigger OnInsert()
    begin
        IF "N° Vehicule" = '' THEN BEGIN
            ParcSetup.GET;
            ParcSetup.TESTFIELD(ParcSetup.Vehicule);
            NoSeriesMgt.InitSeries(ParcSetup.Vehicule, xRec."No. Series", 0D, "N° Vehicule", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        Synchronise := FALSE;
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PlanAmort: Record 5612;
        Immo: Record 5600;
        Express: Text[10];
        DateAcuisition: Date;
        DateFinAmort: Date;
        Resource: Record 156;


    procedure AssistEdit(OldVeh: Record "Véhicule"): Boolean
    var
        Veh: Record "Véhicule";
    begin
        WITH Rec DO BEGIN
            Veh := Rec;
            ParcSetup.GET;
            ParcSetup.TESTFIELD(Vehicule);
            IF NoSeriesMgt.SelectSeries(ParcSetup.Vehicule, OldVeh."No. Series", "No. Series") THEN BEGIN
                ParcSetup.GET;
                ParcSetup.TESTFIELD(Vehicule);
                NoSeriesMgt.SetSeries("N° Vehicule");
                Rec := Veh;
                EXIT(TRUE);
            END;
        END;
    end;


    procedure "VerifEcritureVéhicule"()
    var
        RecTaxe: Record Taxe;
        RecVisiteTechnique: Record "Visite Technique";
        "RecVignetteVéhicule": Record "Vignette Véhicule";
        "RecPneumatiqueVéhicule": Record "Pneumatique Véhicule";
        "RecAssuranceVéhicule": Record "Assurance Véhicule";
        "RecRéparationVéhicule": Record "Réparation Véhicule";
        RecAccidents: Record Accidents;
        RecMission: Record Missions;
        TXT001: Label 'Vous ne pouvez pas Supprimer une Véhicule tant qu''elle est rattachée a une ecriture !';
        "RecRéparationVéhiculeEnreg.": Record "Réparation Véhicule Enreg.";
        "RecMissionEnregistré": Record "Mission Enregistré";
    begin
        RecMission.RESET;
        RecMission.SETRANGE("N° Véhicule", "N° Vehicule");
        IF RecMission.FINDFIRST THEN
            ERROR(TXT001);
        RecRéparationVéhicule.RESET;
        RecRéparationVéhicule.SETRANGE("N° Véhicule", "N° Vehicule");
        IF RecRéparationVéhicule.FINDFIRST THEN
            ERROR(TXT001);
        RecAccidents.RESET;
        RecAccidents.SETRANGE("N° Véhicule", "N° Vehicule");
        IF RecAccidents.FINDFIRST THEN
            ERROR(TXT001);
        RecAssuranceVéhicule.RESET;
        RecAssuranceVéhicule.SETRANGE("N° Veh", "N° Vehicule");
        IF RecAssuranceVéhicule.FINDFIRST THEN
            ERROR(TXT001);
        "RecPneumatiqueVéhicule".RESET;
        "RecPneumatiqueVéhicule".SETRANGE("N° Véhicule", "N° Vehicule");
        IF "RecPneumatiqueVéhicule".FINDFIRST THEN
            ERROR(TXT001);
        RecVignetteVéhicule.RESET;
        RecVignetteVéhicule.SETRANGE("N° Veh", "N° Vehicule");
        IF RecVignetteVéhicule.FINDFIRST THEN
            ERROR(TXT001);
        RecVisiteTechnique.RESET;
        RecVisiteTechnique.SETRANGE("N° Véhicule", "N° Vehicule");
        IF RecVisiteTechnique.FINDFIRST THEN
            ERROR(TXT001);
        RecTaxe.RESET;
        RecTaxe.SETRANGE("N° Véhicule", "N° Vehicule");
        IF RecTaxe.FINDFIRST THEN
            ERROR(TXT001);
        "RecRéparationVéhiculeEnreg.".RESET;
        "RecRéparationVéhiculeEnreg.".SETRANGE("N° Véhicule", "N° Vehicule");
        IF "RecRéparationVéhiculeEnreg.".FINDFIRST THEN
            ERROR(TXT001);
        RecMissionEnregistré.RESET;
        RecMissionEnregistré.SETRANGE("N° Véhicule", "N° Vehicule");
        IF RecMissionEnregistré.FINDFIRST THEN
            ERROR(TXT001);
    end;


    procedure "GetListeFiltré"(ParaCritere: Code[20]) LetVehicule: Code[20]
    var
        RecVehicule: Record "Véhicule";
        CdeCodeVehicule: Code[20];
    begin
        RecVehicule.SETFILTER("N° Vehicule", ParaCritere + '*');
        IF page.RUNMODAL(page::"List Véhicules", RecVehicule) = ACTION::LookupOK THEN
            CdeCodeVehicule := RecVehicule."N° Vehicule";
        EXIT(CdeCodeVehicule);
    end;


    procedure CoutMateriel(ParaPeriodeDebbut: Date; ParaPeriodeFin: Date; ParaEngins: Code[20])
    begin
    end;


    procedure CoutMaterielTransport(DateDebut: Date; DateFin: Date; ParaEngins: Code[20]; ParaDistance: Integer; Paravolume: Integer; ParaCoutMateriel: Boolean) Cout: Decimal
    var
        LigneRendementVehiculeEnr: Record "Ligne Rendement Vehicule Enr";
        "ParamétreParc": Record "Paramétre Parc";
        RecVehicule: Record "Véhicule";
        LignePointageVehicule: Record "Ligne Pointage Vehicule";
        FADepreciationBook: Record 5612;
        InventorySetup: Record 313;
        Item: Record 27;
        Item2: Record 27;
        ItemLedgerEntry: Record 32;
        LigneFicheGasoil: Record 50017;
        GAffectation: Code[20];
        NbJourPanne: Decimal;
        NbrJourFonctionne: Decimal;
        NbrJourDisponible: Decimal;
        IndexDepart: Decimal;
        IndexFinal: Decimal;
        HTravaille: Decimal;
        HNormal: Decimal;
        i: Decimal;
        QteGasoil: Decimal;
        MHT: Decimal;
        TauxOccup: Decimal;
        PUGasoil: Decimal;
        CoutGasoil: Decimal;
        MQA: Decimal;
        CMOYH: Decimal;
        PrixLocation: Decimal;
        CoutLocation: Decimal;
        CPR: Decimal;
        AMMJ: Decimal;
        MSJ: Decimal;
        Divers: Decimal;
        Total: Decimal;
        Resultat: Decimal;
        "// RB SORO": Integer;
        PrintToExcel: Boolean;
        ExcelBuf: Record 370 temporary;
        "RecParamétreParc": Record "Paramétre Parc";
        JoursAmortiss: Decimal;
        NbrAnnee: Integer;
        CoutTotGasoil: Decimal;
        CoutJournalier: Decimal;
        HeureTravailTheorique: Integer;
        HeureUtilisation: Decimal;
        AMMJournalier: Decimal;
        CoutM3: Decimal;
        CoutKm: Decimal;
        VolumeTotal: Decimal;
        DistanceTotal: Decimal;
        NbrVoyage: Integer;
        CoutVoyage: Decimal;
        CoutTotalM3: Decimal;
    begin
        VolumeTotal := 0;
        DistanceTotal := 0;

        LigneRendementVehiculeEnr.SETRANGE(Journee, DateDebut, DateFin);
        LigneRendementVehiculeEnr.SETRANGE(Vehicule, ParaEngins);
        IF LigneRendementVehiculeEnr.FINDFIRST THEN
            REPEAT
                VolumeTotal += LigneRendementVehiculeEnr.Volume;
                DistanceTotal += LigneRendementVehiculeEnr."Distance Parcourus";

            UNTIL LigneRendementVehiculeEnr.NEXT = 0;

        CLEAR(FADepreciationBook);
        CLEAR(LignePointageVehicule);
        CLEAR(ItemLedgerEntry);
        AMMJournalier := 0;
        Total := 0;
        CPR := 0;
        AMMJ := 0;
        MSJ := 0;
        Divers := 0;
        CoutTotGasoil := 0;
        NbrJourFonctionne := 0;
        NbrJourDisponible := 0;
        NbJourPanne := 0;
        IF InventorySetup.GET THEN;
        IF Item.GET(InventorySetup."Article Gasoil") THEN PUGasoil := Item."Last Direct Cost";

        LignePointageVehicule.SETRANGE(Journee, DateDebut, DateFin);
        LignePointageVehicule.SETRANGE(Vehicule, ParaEngins);
        LignePointageVehicule.SETRANGE("Statut Entete", LignePointageVehicule."Statut Entete"::Validé);
        IF LignePointageVehicule.FINDFIRST THEN
            REPEAT
                IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Fonctionnel THEN NbrJourFonctionne += 1;
                IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Disponible THEN NbrJourDisponible += 1;
                IF LignePointageVehicule.Statut = LignePointageVehicule.Statut::Panne THEN NbJourPanne += 1;
            UNTIL LignePointageVehicule.NEXT = 0;
        CLEAR(RecVehicule);
        IF ParamétreParc.GET THEN;
        IF RecVehicule.GET(ParaEngins) THEN BEGIN
            IF Resource.GET(RecVehicule.MO) THEN
                CoutJournalier := Resource."Direct Unit Cost";
            PrixLocation := RecVehicule."Cout Journalier";
        END;

        IF Item.GET(ParamétreParc."Article Gasoil") THEN;
        CPR := 0;
        QteGasoil := 0;
        MHT := 0;
        TauxOccup := 0;
        MQA := 0;
        AMMJ := 0;
        MSJ := 0;
        // Debut  CAlcul index depart du mois et index fin
        LigneFicheGasoil.RESET;
        LigneFicheGasoil.SETCURRENTKEY(Materiel, Journee, Heure);
        LigneFicheGasoil.SETRANGE(Journee, DateDebut, DateFin);
        LigneFicheGasoil.SETRANGE(Materiel, ParaEngins);

        IF LigneFicheGasoil.FINDFIRST THEN BEGIN
            IndexDepart := LigneFicheGasoil."Valeur Compteur";
        END;
        //-------------------------------------------------------
        LigneFicheGasoil.RESET;
        LigneFicheGasoil.SETCURRENTKEY(Materiel, Journee, Heure);
        LigneFicheGasoil.SETRANGE(Journee, DateDebut, DateFin);
        LigneFicheGasoil.SETRANGE(Materiel, ParaEngins);

        IF LigneFicheGasoil.FINDLAST THEN BEGIN
            IndexFinal := LigneFicheGasoil."Valeur Compteur";
        END;

        // Fin CAlcul index depart du mois et index fin
        HeureTravailTheorique := ParamétreParc."Heure Travail";
        // RB SORO 31/03/2016
        RecParamétreParc.GET;
        // RB SORO 31/03/2016
        HeureUtilisation := IndexFinal - IndexDepart;
        HNormal := NbrJourFonctionne * ParamétreParc."Heure Travail";
        MQA := HNormal - HeureUtilisation;

        IF (NbrJourFonctionne <> 0) AND (HeureTravailTheorique <> 0) THEN BEGIN

            MHT := HeureUtilisation / NbrJourFonctionne;
            TauxOccup := ((HeureUtilisation / NbrJourFonctionne) / HeureTravailTheorique) * 100;
        END;
        LigneFicheGasoil.RESET;
        LigneFicheGasoil.SETRANGE(Journee, DateDebut, DateFin);
        LigneFicheGasoil.SETRANGE(Materiel, ParaEngins);

        IF LigneFicheGasoil.FINDFIRST THEN
            REPEAT
                QteGasoil += LigneFicheGasoil."Quantité Gasoil";
            UNTIL LigneFicheGasoil.NEXT = 0;
        // CPR
        ItemLedgerEntry.SETCURRENTKEY("N° Véhicule", "Item No.", "Posting Date");
        ItemLedgerEntry.SETRANGE("Posting Date", DateDebut, DateFin);
        // RB SORO 31/03/2016
        ItemLedgerEntry.SETFILTER("Item No.", '<>%1', RecParamétreParc."Article Gasoil");
        // RB SORO 31/03/2016
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
        ItemLedgerEntry.SETRANGE("N° Véhicule", ParaEngins);
        IF ItemLedgerEntry.FINDFIRST THEN
            REPEAT
                IF Item.GET(ItemLedgerEntry."Item No.") THEN;
                CPR += ABS(ItemLedgerEntry.Quantity) * Item."Last Direct Cost";

            UNTIL ItemLedgerEntry.NEXT = 0;
        // CPR
        IF HeureUtilisation <> 0 THEN CMOYH := ROUND(QteGasoil / HeureUtilisation, 1);
        CoutTotGasoil := QteGasoil * PUGasoil;
        CLEAR(FADepreciationBook);
        IF RecVehicule."Code Immo" <> '' THEN BEGIN
            FADepreciationBook.SETRANGE("FA No.", RecVehicule."Code Immo");
            IF FADepreciationBook.FINDFIRST THEN BEGIN
                DateAcuisition := FADepreciationBook."Acquisition Date";
                DateFinAmort := CALCDATE(FORMAT(ParamétreParc."Nombre année Calcul AMJ") + 'A', DateAcuisition);


                FADepreciationBook.CALCFIELDS("Acquisition Cost");
                IF FADepreciationBook."No. of Depreciation Years" <> 0 THEN
                    JoursAmortiss := 360 * FADepreciationBook."No. of Depreciation Years"
                ELSE
                    JoursAmortiss := 360 * (NbrAnnee);

                JoursAmortiss := 360 * (ParamétreParc."Nombre année Calcul AMJ");
                IF JoursAmortiss <> 0 THEN
                    AMMJournalier := ROUND(FADepreciationBook."Acquisition Cost" / JoursAmortiss, 1);
            END;
        END;
        //    message('%1 %2 %3',JoursAmortiss, FADepreciationBook."Book Value", "AMM Journalier");
        CoutLocation := (CoutJournalier);

        // AMMJ:=("AMM Journalier"/HeureTravailTheorique) *(HeureUtilisation+NbrJourDisponible*HeureTravailTheorique+
        // NbJourPanne);

        AMMJ := AMMJournalier * (NbJourPanne + NbrJourFonctionne + NbrJourDisponible);
        IF DateFinAmort < WORKDATE THEN AMMJ := 0;
        MSJ := CoutJournalier * (NbrJourFonctionne + NbrJourDisponible + NbJourPanne);
        Divers := ROUND((ABS(CPR) + AMMJ + MSJ) * 5 / 100, 1);
        Total := ABS(CPR) + AMMJ + MSJ + Divers + CoutTotGasoil;
        Resultat := CoutLocation - Total;

        // IF Volume<>0 THEN  CoutM3:=Total/VolumeTotal;
        // message('tota %1',total) ;
        IF DistanceTotal <> 0 THEN
            CoutKm := Total / DistanceTotal;
        CoutVoyage := (NbrVoyage * ParaDistance) * CoutKm;
        IF Volume <> 0 THEN
            CoutTotalM3 := CoutVoyage / (Paravolume);
        IF NbrJourFonctionne = 0 THEN NbrJourFonctionne := 1;
        IF ParaCoutMateriel THEN
            EXIT(Total / (NbrJourFonctionne + NbrJourDisponible + NbJourPanne))
        ELSE
            EXIT(CoutTotalM3);

        // RB SORO 29/03/2016
    end;
}

