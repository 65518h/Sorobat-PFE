table 50017 "Ligne Fiche Gasoil"
{

    fields
    {
        field(1; Journee; Date)
        {
        }
        field(2; Cuve; Code[20])
        {
            TableRelation = Location;
        }
        field(3; Heure; Time)
        {
        }
        field(4; Materiel; Code[20])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                IF RecVehicule.GET(Materiel) THEN BEGIN
                    IF RecVehicule.Bloquer THEN ERROR(Text003);
                    "Immatricule Vehicule" := RecVehicule.Immatriculation;
                    IF RecVehicule."Type Index" = 0 THEN "Type Index" := "Type Index"::Kilometrage ELSE "Type Index" := RecVehicule."Type Index";
                    //GL2024  Affaire := RecVehicule.marche;
                    "Consommation Max" := RecVehicule."Consommation Max";

                END;
                Utilisateur := UPPERCASE(USERID);
                "Index Horaire" := 0;
                "Index Kilometrique" := 0;
                "Valeur Compteur" := 0;
                IF EnteteFicheGasoil.GET("Document No.") THEN
                    Journee := EnteteFicheGasoil.Journee;

                GetLastIndex;



            end;
        }
        field(5; "Immatricule Vehicule"; Text[20])
        {
            Editable = false;
        }
        field(6; "Quantité Gasoil"; Decimal)
        {

            trigger OnValidate()
            begin
                IF EnteteFicheGasoil.GET("Document No.") THEN BEGIN
                    Journee := EnteteFicheGasoil.Journee;
                    Cuve := EnteteFicheGasoil.Cuve;
                END;
                LigneFicheGasoil.SETCURRENTKEY(Materiel, Journee, Heure);
                LigneFicheGasoil.SETRANGE(Materiel, Materiel);
                LigneFicheGasoil.SETFILTER(Journee, '<=%1', Journee);
                IF (LigneFicheGasoil.FINDLAST) THEN "Index depart" := LigneFicheGasoil."Valeur Compteur";
                IF "Type Index" = "Type Index"::Horaire THEN
                    IF ("Valeur Compteur" - "Dernier Index") <> 0 THEN Consommation := ROUND("Quantité Gasoil" / ("Valeur Compteur" - "Dernier Index"), 0.01);

                IF "Type Index" = "Type Index"::Kilometrage THEN
                    IF ("Valeur Compteur" - "Dernier Index") <> 0 THEN Consommation := ROUND("Quantité Gasoil" / ("Valeur Compteur" - "Dernier Index") * 100, 0.01);
                IF RecVehicule.GET(Materiel) THEN
                    IF RecVehicule."Consommation Max" <> 0 THEN BEGIN
                        IF Consommation > RecVehicule."Consommation Max" THEN
                            "Alerte Consommation Gasoil" := TRUE
                        ELSE
                            "Alerte Consommation Gasoil" := FALSE;
                    END;
                //IF "Alerte Consommation Gasoil" THEN MESSAGE(Text002);
            end;
        }
        field(7; Utilisateur; Code[20])
        {
        }
        field(8; Chauffeur; Code[10])
        {
            TableRelation = "Shipping Agent";
        }
        field(9; Destination; Code[10])
        {
            TableRelation = "Post Code";
        }
        field(10; "Type Index"; Option)
        {
            OptionMembers = " ",Horaire,Kilometrage;
        }
        field(11; "Index Horaire"; Decimal)
        {

            trigger OnValidate()
            begin
                VerifIndex()
            end;
        }
        field(12; "Index Kilometrique"; Decimal)
        {

            trigger OnValidate()
            begin
                VerifIndex()
            end;
        }
        field(13; Article; Code[20])
        {
        }
        field(14; Magasin; Code[20])
        {
        }
        field(15; "Numero Ligne"; Integer)
        {
            AutoIncrement = true;
        }
        field(16; Affaire; Code[20])
        {
            TableRelation = Job;
        }
        field(17; "Valeur Compteur"; Decimal)
        {

            trigger OnValidate()
            begin
                "Index Horaire" := 0;
                "Index Kilometrique" := 0;
                IF "Type Index" = "Type Index"::Horaire THEN "Index Horaire" := "Valeur Compteur";
                IF "Type Index" = "Type Index"::Kilometrage THEN "Index Kilometrique" := "Valeur Compteur";
                IF "Valeur Compteur" < "Dernier Index" THEN MESSAGE(Text001);
                IF RecVehicule.GET(Materiel) THEN BEGIN
                    RecVehicule."Compteur Actuel" := "Valeur Compteur";
                    IF RecVehicule."Type Index" = RecVehicule."Type Index"::Horaire THEN
                        RecVehicule."Reste Pour Alerte" := RecVehicule."Prochain Vidange" - "Valeur Compteur" - 20;
                    IF RecVehicule."Type Index" = RecVehicule."Type Index"::Kilometrage THEN
                        RecVehicule."Reste Pour Alerte" := RecVehicule."Prochain Vidange" - "Valeur Compteur" - 500;
                    RecVehicule.MODIFY;
                END;
            end;
        }
        field(18; "Document No."; Code[20])
        {
        }
        field(19; "Filtre Materiel"; Code[20])
        {

            trigger OnValidate()
            begin
                "Filtre Materiel" := RecVehicule.GetListeFiltré("Filtre Materiel");
                Materiel := "Filtre Materiel";
                "Filtre Materiel" := '';
            end;
        }
        field(20; Synchronise; Boolean)
        {
        }
        field(21; Statut; Option)
        {
            Editable = true;
            OptionMembers = "En Cours",Valider;
        }
        field(22; "Nom Engin"; Text[100])
        {
            CalcFormula = Lookup(Véhicule.Désignation WHERE("N° Vehicule" = FIELD(Materiel)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Filtre Immatriculation"; Code[20])
        {

            trigger OnValidate()
            begin
                //"Filtre Immatriculation":=RecVehicule.GetListeFiltréImmatriculation("Filtre Immatriculation");
                Materiel := "Filtre Immatriculation";
                "Filtre Immatriculation" := '';
            end;
        }
        field(24; "Index de la Citerne"; Decimal)
        {
        }
        field(25; "Index depart"; Decimal)
        {
        }
        field(26; Index2; Decimal)
        {
        }
        field(27; Index3; Decimal)
        {
        }
        field(28; Index4; Decimal)
        {
        }
        field(29; Consommation; Decimal)
        {
            Editable = false;
        }
        field(30; "Dernier Index"; Decimal)
        {
            Editable = false;
        }
        field(31; "Index 01"; Decimal)
        {
        }
        field(32; "Index 02"; Decimal)
        {
        }
        field(33; "Index 03"; Decimal)
        {
        }
        field(34; "Index 04"; Decimal)
        {
        }
        field(35; "Alerte Consommation Gasoil"; Boolean)
        {
        }
        field(36; "Consommation Max"; Decimal)
        {
        }
        field(37; "Compteur En Panne"; Boolean)
        {
        }
        field(50999; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(51000; Observation; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Numero Ligne")
        {
            Clustered = true;
        }
        key(Key2; "Index Horaire")
        {
        }
        key(Key3; "Index Kilometrique")
        {
        }
        key(Key4; Journee, Cuve, "Numero Ligne")
        {
        }
        key(Key5; Materiel, "Numero Ligne")
        {
        }
        key(Key6; Materiel, Journee, Heure)
        {
        }
    }

    fieldgroups
    {
    }

    var
        RecVehicule: Record Véhicule;
        EnteteFicheGasoil: Record 50016;
        Text001: Label 'Valeur Compteur Saisie Inférieure au Dernier Index';
        LigneFicheGasoil: Record 50017;
        RecLigneFicheGasoil: Integer;
        Text002: Label 'Attention Consommation Anormal !!! Veuillez Verifier ';
        Text003: Label 'Materiel Bloqué';


    procedure VerifIndex()
    var
        RecLigneFicheGasoil: Record 50017;
        TextL001: Label 'Index Horaire Erroné Pour Le Vehicule N° %1 Ancien Index %2';
        TextL002: Label 'Index Kilometrique Erroné Pour Le Vehicule N° %1 Ancien Index %2';
    begin
        IF ("Type Index" = 0) OR (Materiel = '') THEN EXIT;
        IF "Type Index" = "Type Index"::Horaire THEN BEGIN
            RecLigneFicheGasoil.SETCURRENTKEY(Journee);
            RecLigneFicheGasoil.SETRANGE(Materiel, Materiel);
            RecLigneFicheGasoil.SETRANGE(Materiel, Materiel);

            IF (RecLigneFicheGasoil.FINDLAST) AND (RecLigneFicheGasoil."Index Horaire" <> 0) THEN
                IF RecLigneFicheGasoil."Index Horaire" >= "Index Horaire" THEN ERROR(TextL001, Materiel, RecLigneFicheGasoil."Index Horaire")
        END;
        IF "Type Index" = "Type Index"::Kilometrage THEN BEGIN
            RecLigneFicheGasoil.SETCURRENTKEY(Journee);
            RecLigneFicheGasoil.SETRANGE(Materiel, Materiel);
            IF (RecLigneFicheGasoil.FINDLAST) AND (RecLigneFicheGasoil."Index Kilometrique" <> 0) THEN
                IF RecLigneFicheGasoil."Index Kilometrique" >= "Index Kilometrique" THEN
                    ERROR(TextL002, Materiel, RecLigneFicheGasoil."Index Kilometrique")

        END;
    end;

    trigger OnInsert()
    var
        Header: Record "Entete Fiche Gasoil";
        LocationRec: Record Location;
    begin
        if Header.Get("Document No.") then
            if LocationRec.Get(Header.Cuve) then
                "Affaire" := LocationRec.Affaire;
    end;

    procedure GetLastIndex()
    var
        RecLigneFicheGasoil: Record 50017;
    begin
        RecLigneFicheGasoil.SETCURRENTKEY(Journee);
        RecLigneFicheGasoil.SETRANGE(Materiel, Materiel);
        RecLigneFicheGasoil.SETFILTER(Journee, '<=%1', Journee);
        IF RecLigneFicheGasoil.FINDLAST THEN "Dernier Index" := RecLigneFicheGasoil."Valeur Compteur";
    end;


}

