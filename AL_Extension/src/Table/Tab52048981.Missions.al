Table 52048981 Missions
{
    //GL2024  ID dans Nav 2009 : "39004682"
    DrillDownPageID = "Liste Missions";
    LookupPageID = "Liste Missions";

    fields
    {
        field(1; "N° Mission"; Code[30])
        {
        }
        field(2; "Date document"; Date)
        {
        }
        field(3; "Date Mission"; Date)
        {

            trigger OnValidate()
            begin
                "Date Départ" := "Date Mission";
            end;
        }
        field(4; "Code Demandeur"; Code[10])
        {
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                if employer.Get("Code Demandeur") then begin
                    "Nom Demandeur" := employer."First Name";
                    "Fonction Demandeur" := employer."Job Title";
                end;
            end;
        }
        field(5; "Nom Demandeur"; Text[30])
        {
            Editable = false;
        }
        field(6; "Fonction Demandeur"; Text[30])
        {
            Editable = false;
        }
        field(7; "Objet mission"; Text[100])
        {
        }
        field(8; "Date Départ"; Date)
        {
        }
        field(9; "Date Arrivée"; Date)
        {
        }
        field(10; "Lieu départ"; Code[50])
        {
            TableRelation = "Post Code";
        }
        field(11; "Lieu Arrivé"; Code[50])
        {
            TableRelation = "Post Code";
        }
        field(12; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;
            //GL3900 

            trigger OnValidate()
            begin
                if RecParamparc.Get() then;
                //**Vérifier si la véhicule est bloquer
                if Veh.Get("N° Véhicule") then begin
                    if Veh.Bloquer then
                        Message('Véhicule Bloquer')
                    else begin
                        "No. Immatriculation" := Veh.Immatriculation;
                    end;
                end;
                "Alerte Vidange" := '';
                "Alerte Assurance" := '';
                "Alerte Vignette" := '';
                "Alerte Visite Technique" := '';
                //**Vérifier la visite technique de la véhicule
                Visite.Reset;
                Visite.SetRange("N° Véhicule", "N° Véhicule");
                if (Visite.FindLast) and (Format(Veh."Seuil Alerte Visite Technique") <> '') then begin
                    Express := '+' + Format(Veh."Seuil Alerte Visite Technique");
                    if "Date document" <> 0D then
                        if (Visite."Date Fin Validité" <= (CalcDate(Express, "Date document"))) then begin
                            "Alerte Visite Technique" := Text003;
                            //  IF NOT "Prix En Charge"  THEN
                            //   MESSAGE('Vérifier la visite technique de la voiture');
                        end;
                end;
                //Vérifier les vignettes de la véhicule
                vigne.Reset;
                vigne.SetRange("N° Veh", "N° Véhicule");
                if (vigne.FindLast) and (Format(Veh."Seuil Alerte Vignette") <> '') then begin
                    Express1 := '+' + Format(Veh."Seuil Alerte Vignette");
                    if "Date document" <> 0D then
                        if (vigne."Date Fin de Validité" <= (CalcDate(Express1, "Date document"))) then begin
                            "Alerte Vignette" := Text004;
                            // IF NOT "Prix En Charge"  THEN
                            // MESSAGE('Vérifier la vignette de la voiture');
                        end;
                end;
                //Vérifier les assurance de la véhicule
                Assurance.Reset;
                Assurance.SetRange("N° Veh", "N° Véhicule");
                if (Assurance.FindLast) and (Format(Veh."Seuil Alerte Assurance") <> '') then begin
                    Express2 := '+' + Format(Veh."Seuil Alerte Assurance");
                    if "Date document" <> 0D then
                        if (Assurance."Date fin valdite" <= (CalcDate(Express2, "Date document"))) then begin
                            "Alerte Assurance" := Text005;
                            //  IF NOT "Prix En Charge"  THEN
                            //  MESSAGE('Vérifier assurance de la voiture');
                        end;
                end;
                //
                CartGrise.Reset;
                CartGrise.SetRange("N° Veh", "N° Véhicule");
                if CartGrise.Find('-') then begin
                    "Type Véhicule" := CartGrise.Type;
                    "Puissance Véhicule" := CartGrise.Puissance;
                    //MODIFY;
                end;

                "Index Cpt. Depart" := Veh."Index Théorique Final";
                //IBK DSFT 15 04 2012


                if RecParamparc.Get() then;
                RecRép.Reset;
                RecRép.SetRange("N° Véhicule", "N° Véhicule");
                RecRép.SetRange("Code Reparation", RecParamparc."Param Répar Vidange");
                if RecRép.FindFirst then
                    "Index Fréquence" := RecRép."Fréquence (Index)";

                RecLigRep.Reset;
                RecLigRep.SetRange("N° Véhicule", "N° Véhicule");
                RecLigRep.SetRange("Code Réparation", RecParamparc."Param Répar Vidange");
                if RecLigRep.FindLast then begin
                    RecEntRép.Reset;
                    if RecEntRép.Get(RecLigRep."N° Reparation") then begin
                        if (RecEntRép.Type = 1) then begin
                            "Index Dérnier Rép" := RecEntRép.Index;
                            "Index Rép Prévu" := RecEntRép.Index + RecRép."Fréquence (Index)";
                            "Index Cumul" := "Index Cpt. Depart" - "Index Dérnier Rép";
                        end
                        else begin
                            "Index Dérnier Rép" := 0;
                            "Index Rép Prévu" := 0;
                            Veh.CalcFields("Kms Parcourus");
                            "Index Cumul" := Veh."Kms Parcourus";
                        end;
                    end;

                end
                else begin
                    "Index Dérnier Rép" := 0;
                    "Index Rép Prévu" := 0;
                end;
                RecMissionEnregisré.SetCurrentkey("N° Véhicule", "Index Cpt. Depart");
                RecMissionEnregisré.SetRange("N° Véhicule", "N° Véhicule");
                if RecMissionEnregisré.FindLast then "Index Cpt. Depart" := RecMissionEnregisré."Index Cpt. Retour";
                Veh.CalcFields("Kms Parcourus");
                "Index Cumul" := Veh."Kms Parcourus";

                //"Index Cumul" :=0;

                if (Veh."Seuil Alerte Vidange" > 0) and ("Index Fréquence" - "Index Cumul" > 0) then
                    if (("Index Fréquence" - "Index Cumul") <= Veh."Seuil Alerte Vidange") then "Alerte Vidange" := TEXT001;


                //IBK DSFT 15 04 2012
            end;

        }
        field(13; "Type Véhicule"; Code[20])
        {
            Editable = false;
        }
        field(14; "Puissance Véhicule"; Code[10])
        {
            Editable = false;
        }
        field(15; "Km Parcourus"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(16; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(17; "Index Cpt. Depart"; Decimal)
        {
            DecimalPlaces = 0 : 3;

            trigger OnValidate()
            begin
                "Km Parcourus" := "Index Cpt. Retour" - "Index Cpt. Depart";
            end;
        }
        field(18; "Index Cpt. Retour"; Decimal)
        {
            DecimalPlaces = 0 : 3;

            trigger OnValidate()
            begin
                if ParcSetup.Get then;
                "Km Parcourus" := "Index Cpt. Retour" - "Index Cpt. Depart";
                "Coût de kilometrage" := "Km Parcourus" * ParcSetup."Coût kilometrage";
                if "Index Cpt. Retour" <= "Index Cpt. Depart" then
                    Error(Text002);
            end;
        }
        field(19; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = Date;
        }
        field(21; "Heure Départ"; Time)
        {
        }
        field(22; "Heure Arrivée"; Time)
        {

            trigger OnValidate()
            begin
                //IBK DSFT 15 04 2012
                NbreJour := 0;
                "Nbre heure" := 0;
                if "Date Départ" = "Date Arrivée" then begin
                    "Nbre heure" := ROUND(("Heure Arrivée" - "Heure Départ") / 3600000, 0.01);
                end
                else
                    if "Date Arrivée" > "Date Départ" then begin
                        NbreJour := "Date Arrivée" - "Date Départ";
                        "Nbre heure" := 24 * NbreJour + ROUND(("Heure Arrivée" - "Heure Départ") / 3600000, 0.01);
                    end;
                if ParcSetup.Get then;
                "Coût de livraison" := ParcSetup."Coût heure livraison" * "Nbre heure";
                //IBK DSFT 15 04 2012
            end;
        }
        field(110; "Type Vehicule Mission"; Option)
        {
            OptionCaption = 'Voiture de la Société,Voiture Personnel';
            OptionMembers = "Voiture de la Société","Voiture Personnel";

            trigger OnValidate()
            begin
                if (xRec."Type Vehicule Mission" <> 2) and ("Type Vehicule Mission" = 2) then begin
                    "N° Véhicule" := '';
                    "Type Véhicule" := '';
                    "Puissance Véhicule" := '';
                    "Index Cpt. Depart" := 0;
                    "Index Cpt. Retour" := 0;
                end;
            end;
        }
        field(111; "N° Demande Mission RH"; Code[10])
        {
        }
        field(112; "No. Immatriculation"; Code[20])
        {
        }
        field(114; "Code Utilisateur"; Code[20])
        {
        }
        field(115; "Code Convoyeur"; Code[10])
        {
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                /*
                IF transporteur.GET("Code Convoyeur") THEN
                   "Nom Convoyeur" := transporteur.Name;
                 */

            end;
        }
        field(116; "Nom Convoyeur"; Text[60])
        {
        }
        field(120; "Code Client"; Code[20])
        {
            TableRelation = Customer;
        }
        field(121; "Nbre Heure Prepara marchandise"; Decimal)
        {

            trigger OnValidate()
            begin
                if ParcSetup.Get then;
                "Coût  Marchandise" := "Nbre Heure Prepara marchandise" * ParcSetup."Coût heure marchandise";
                "Total Frais deplacement" := "Coût  Marchandise" + "Coût de kilometrage" + "Coût de livraison";
            end;
        }
        field(122; "Total Frais deplacement"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(123; "Coût  Marchandise"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(124; "Coût de kilometrage"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            // Enabled = false;
        }
        field(125; "Coût de livraison"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(126; "Nbre heure"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
        field(127; "Index Dérnier Rép"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(128; "Index Rép Prévu"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(129; "Index Fréquence"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(130; "Index Cumul"; Decimal)
        {
            Description = 'IMS 11 02 2011';
        }
        field(131; "Alerte Vidange"; Text[250])
        {
            Description = 'IMS 11 02 2011';
        }
        field(132; "Prix En Charge"; Boolean)
        {
            Description = 'HJ DSFT';
        }
        field(133; "N° Affaire"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = Job;
        }
        field(134; "N° Tache Affaire"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("N° Affaire"));
        }
        field(135; "Centre de Gestion"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'HJ DSFT 29-06-2012';
            Editable = false;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
            //  lSingleinstance: Codeunit "Import SingleInstance2";
            begin
            end;
        }
        field(136; "Alerte Assurance"; Text[250])
        {
            Description = 'IMS 11 02 2011';
        }
        field(137; "Alerte Vignette"; Text[250])
        {
            Description = 'IMS 11 02 2011';
        }
        field(138; "Alerte Visite Technique"; Text[250])
        {
            Description = 'IMS 11 02 2011';
        }
        /*  field(139; "Engin Transporté"; Code[20])
          {
              Description = 'HJ SORO 21-04-2015';
              TableRelation = Véhicule;
          }*/
    }

    keys
    {
        key(STG_Key1; "N° Mission")
        {
            Clustered = true;
        }
        key(STG_Key2; "N° Véhicule")
        {
            SumIndexFields = "Km Parcourus";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NoSeries: Codeunit "No. Series";
        IsHandled: Boolean;
    begin
        /*   //GL2024 if RecUserSetup.Get(UserId) then;
          if "N° Mission" = '' then begin
              ParcSetup.Get;
              "Centre de Gestion" := RecUserSetup."Car Pool Resp. Ctr. Filter";
              ParcSetup.TestField("N° Mission");
              CduNoSeriesRespCentManagement.InitSeries(ParcSetup."N° Mission", xRec."No. Series", 0D, "N° Mission", "No. Series",
              RecUserSetup."Car Pool Resp. Ctr. Filter");

          end
          "Date document" := Today;
          "Code Utilisateur" := UserId;

  */  //GL2024
        //GL2024
        if RecUserSetup.Get(UserId) then;
        if "N° Mission" = '' then begin
            ParcSetup.Get;
            "Centre de Gestion" := RecUserSetup."Car Pool Resp. Ctr. Filter";
            ParcSetup.TestField("N° Mission");
            NoSeriesManagement.RaiseObsoleteOnBeforeInitSeries(ParcSetup."N° Mission", xRec."No. Series", 0D, "N° Mission", "No. Series", IsHandled);
            if not IsHandled then begin

                "No. Series" := ParcSetup."N° Mission";
                if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                    "No. Series" := xRec."No. Series";
                "N° Mission" := NoSeries.GetNextNo("No. Series");

                NoSeriesManagement.RaiseObsoleteOnAfterInitSeries("No. Series", ParcSetup."N° Mission", 0D, "N° Mission");
            end;
            "Date document" := Today;
            "Code Utilisateur" := UserId;


        end;
        //GL2024
    end;

    var
        RecUserSetup: Record "User Setup";
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        employer: Record Employee;
        CartGrise: Record "Carte Grise Vehicule";
        Veh: Record "Véhicule";
        Miss: Record Missions;
        Visite: Record "Visite Technique";
        vigne: Record "Vignette Véhicule";
        transporteur: Record "Shipping Agent";
        NbreJour: Decimal;
        "-- IMS": Integer;
        RecLigRep: Record "Détail Reparation Enreg.";
        RecParamparc: Record "Paramétre Parc";
        "RecEntRép": Record "Réparation Véhicule Enreg.";
        "RecRép": Record "Veh. Reparation Préventive";
        //GL3900    DetailMission: Record "Détail Mission";
        "RecMissionEnregisré": Record "Mission Enregistré";
        TEXT001: label 'Alerte Vidange !!! ';
        Text002: label 'L''index de retour doit être superieur à l''index de départ';
        Express: Text[10];
        Express1: Text[10];
        Assurance: Record "Assurance Véhicule";
        Express2: Text[10];
        Text003: label 'Alerte  visite technique';
        Text004: label 'Alerte  vignette';
        Text005: label 'Alerte  assurance';
    // CduNoSeriesRespCentManagement: Codeunit NoSeriesRespCenterManagement;


    procedure AssistEdit(OldMiss: Record Missions): Boolean
    var
        Miss: Record Missions;
    begin
        with Rec do begin
            Miss := Rec;
            ParcSetup.Get;
            ParcSetup.TestField("N° Mission");
            if NoSeriesMgt.SelectSeries(ParcSetup."N° Mission", OldMiss."No. Series", "No. Series") then begin
                ParcSetup.Get;
                ParcSetup.TestField("N° Mission");
                NoSeriesMgt.SetSeries("N° Mission");
                Rec := Miss;
                exit(true);
            end;
        end;
    end;






}

