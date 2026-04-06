Table 52049012 "Entete Pointage Vehicule"
{
    //GL2024  ID dans Nav 2009 : "39004736"
    DrillDownPageID = "Liste Entete Pointage";
    LookupPageID = "Liste Entete Pointage";

    fields
    {
        field(1; "N° Document"; Code[20])
        {
        }
        field(2; Mois; Option)
        {
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        }
        field(3; Annee; Integer)
        {
        }
        field(4; Vehicule; Code[20])
        {
            Editable = true;
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                TestField(Marche);
                if ParametreParc.Get then;
                if RecVehicule.Get(Vehicule) then begin
                    "Description Vehicule" := RecVehicule.Désignation;
                    Matricule := RecVehicule.Immatriculation;
                    Type := RecVehicule.Famille;
                    "Date Mise En Service" := RecVehicule."Date PMC";
                    "Cout Horaire" := RecVehicule."Cout Location Horaire";
                    "Gasoil Mensulle" := RecVehicule."Quantité Carburant consommé";
                    Annee := Date2dmy(Today, 3);
                    "Heure Travail Theorique" := ParametreParc."Heure Travail";
                    //"Unité Travail":=RecVehicule."Unité Travail" ;
                    "Cout Journalier" := RecVehicule."Cout Location Horaire";
                end;
            end;
        }
        field(5; "Description Vehicule"; Text[100])
        {
            Editable = false;
        }
        field(6; Matricule; Text[50])
        {
            Editable = false;
        }
        field(7; Type; Code[20])
        {
            Editable = false;
        }
        field(8; "Date Mise En Service"; Date)
        {
            Editable = false;
        }
        field(9; "Cout Horaire"; Decimal)
        {
            Editable = false;
        }
        field(10; "Gasoil Mensulle"; Decimal)
        {
            Editable = false;
        }
        field(11; Statut; Option)
        {
            Editable = false;
            OptionMembers = Ouvert,"Validé";
        }
        field(12; "Heure Travail Theorique"; Integer)
        {
            Editable = false;
        }
        field(13; "Total Heure reel Mois"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule"."Heure Travailler" where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Total Heure Utilsation Mois"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule"."Heure Utilisation" where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Total Heure Immob Mois"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule"."Heure Immobilisation" where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Cout Total Utilisation"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule"."Cout Heure Reel" where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Cout Total Immobilisation"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule"."Cout Heure Immobilisation" where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Cout Total"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule"."Cout Total Journee" where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; Ajustement; Decimal)
        {

            trigger OnValidate()
            begin
                CalcFields("Total Heure Utilsation Mois", "Total Heure Immob Mois");
                "Cout Total Ajusté" := ("Total Heure Utilsation Mois" + Ajustement) * "Cout Horaire" + "Total Heure Immob Mois" * "Cout Horaire" * 0.4;
            end;
        }
        field(20; "Cout Total Ajusté"; Decimal)
        {
        }
        field(21; "Unité Travail"; Code[20])
        {
        }
        field(22; "Cout Journalier"; Decimal)
        {
        }
        field(24; Marche; Code[20])
        {
            TableRelation = Job;
        }
        field(25; "Cout Total gasoil"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule"."Cout Gasoil" where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Total Gasoil"; Decimal)
        {
            CalcFormula = sum("Ligne Pointage Vehicule".Gasoil where("Document N°" = field("N° Document")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; Journee; Date)
        {

            trigger OnValidate()
            begin
                TESTFIELD(Marche);
                IF xRec.Journee <> 0D THEN IF xRec.Journee <> Journee THEN ERROR(Text004);
                IF ParametreParc.GET THEN;
                IF Item.GET(ParametreParc."Article Gasoil") THEN;
                LignePointageVehicule.SETRANGE("Document N°", "N° Document");
                LignePointageVehicule.DELETEALL;
                EntetePointageVehicule.RESET;
                EntetePointageVehicule.SETRANGE(Journee, Journee);
                EntetePointageVehicule.SETRANGE(Marche, Marche);
                EntetePointageVehicule.SETRANGE(Statut, EntetePointageVehicule.Statut::Validé);
                IF EntetePointageVehicule.FINDFIRST THEN ERROR(Text002, Journee);

                EntetePointageVehicule.RESET;
                EntetePointageVehicule.SETRANGE(Statut, EntetePointageVehicule.Statut::Validé);
                IF EntetePointageVehicule.FINDLAST THEN BEGIN
                    LastDocument := EntetePointageVehicule."N° Document";
                    LastJournee := EntetePointageVehicule.Journee;
                END;
                RecVehicule.SETRANGE(Bloquer, FALSE);
                RecVehicule.SETFILTER(Statut, '>%1', 0);
                IF ParamétreParc.GET THEN
                    IF ParametreParc."Filtre Chantier" <> '' THEN
                        RecVehicule.SETRANGE(marche, ParametreParc."Filtre Chantier");
                IF RecVehicule.FINDFIRST THEN
                    REPEAT
                        GasoilConsomméJour := 0;
                        LignePointageVehicule."Document N°" := "N° Document";
                        LignePointageVehicule.Vehicule := RecVehicule."N° Vehicule";
                        LignePointageVehicule.Description := RecVehicule.Désignation;
                        LignePointageVehicule.Marche := RecVehicule.marche;
                        LignePointageVehicule.Chauffeur := RecVehicule.Conducteur;
                        LignePointageVehicule.Statut := RecVehicule.Statut;
                        IF "Dimanche / Ferié" THEN
                            IF RecVehicule.Statut = RecVehicule.Statut::Fonctionnel
                            //  THEN LignePointageVehicule.Statut := LignePointageVehicule.Statut::"Wrong Expr";
                            THEN
                                LignePointageVehicule.Statut := LignePointageVehicule.Statut::"Disponible";
                        LignePointageVehicule.Journee := Journee;
                        LignePointageVehicule.Mois := DATE2DMY(Journee, 2);
                        LignePointageVehicule.Annee := DATE2DMY(Journee, 3);
                        LignePointageVehicule."Heure Travail Theorique" := ParametreParc."Heure Travail";
                        LignePointageVehicule."Cout Horaire" := RecVehicule."Cout Location Horaire";
                        LignePointageVehicule."Cout Journalier" := RecVehicule."Cout Journalier";
                        LignePointageVehicule."Unite Travail" := "Unité Travail";
                        LignePointageVehicule."N° Serie" := RecVehicule.Immatriculation;
                        IF CatégorieVéhicule.GET(RecVehicule.Famille) THEN
                            LignePointageVehicule."Type Vehicule" := CatégorieVéhicule.Désignation;
                        LigneGasoil.RESET;
                        KilometrageJour := 0;
                        LigneGasoil.RESET;
                        LigneGasoil.SETCURRENTKEY(Journee);
                        LigneGasoil.SETRANGE(Materiel, RecVehicule."N° Vehicule");
                        IF LigneGasoil.FINDLAST THEN BEGIN
                            LignePointageVehicule."Index Final" := LigneGasoil."Valeur Compteur";
                        END;

                        IF LignePointageVehicule3.GET(LastDocument, RecVehicule."N° Vehicule", LastJournee) THEN BEGIN
                            LignePointageVehicule."Motif Indispensalité" := LignePointageVehicule3."Motif Indispensalité";
                            LignePointageVehicule."Motif Panne" := LignePointageVehicule3."Motif Panne";
                            LignePointageVehicule."N° Reparation" := LignePointageVehicule3."N° Reparation";
                            LignePointageVehicule.Observation := LignePointageVehicule3.Observation;
                            LignePointageVehicule.Chauffeur := LignePointageVehicule3.Chauffeur;
                            LignePointageVehicule."Chauffeur 2" := LignePointageVehicule3."Chauffeur 2";
                            LignePointageVehicule."Chauffeur 3" := LignePointageVehicule3."Chauffeur 3";
                            LignePointageVehicule."DA Lancé" := LignePointageVehicule3."DA Lancé";
                            LignePointageVehicule."N° DA" := LignePointageVehicule3."N° DA";
                            LignePointageVehicule."Affectation Marche" := LignePointageVehicule3."Affectation Marche";
                            LignePointageVehicule."Sous Affectation Marche" := LignePointageVehicule3."Sous Affectation Marche";
                            LignePointageVehicule.Marche := LignePointageVehicule3.Marche;
                            LignePointageVehicule."N° Reparation" := LignePointageVehicule3."N° Reparation";
                            LignePointageVehicule."Index Depart" := LignePointageVehicule3."Index Final";
                        END;
                        IF NOT LignePointageVehicule.INSERT THEN LignePointageVehicule.MODIFY;

                    UNTIL RecVehicule.NEXT = 0;
            end;
        }
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Dimanche / Ferié"; Boolean)
        {
        }
        /*  field(50002; Utilisateur; Code[20])
          {
              Description = 'MH soro 02-06-2023';
          }
          field(50003; "Date saisie"; Date)
          {
              Description = 'MH soro 02-06-2023';
          }*/
    }

    keys
    {
        key(STG_Key1; "N° Document")
        {
            Clustered = true;
        }
        key(STG_Key2; Mois)
        {
        }
        key(STG_Key3; Vehicule)
        {
        }
        key(STG_Key4; Journee)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Statut = Statut::Validé then Error(Text003);
        LignePointageVehicule.SetRange("Document N°", "N° Document");
        LignePointageVehicule.DeleteAll;
    end;

    trigger OnInsert()
    begin
        // if "N° Document" = '' then begin
        //     if ParametreParc.Get then;
        //     "N° Document" := NoSeriesMgt.GetNextNo(ParametreParc."Pointage Serine N°", 0D, true);
        //     //Journee:=TODAY;
        //     // Utilisateur := UserId;
        //     //  "Date saisie" := Today();
        // end;

        if "N° Document" = '' then begin
            if job.Get(Marche) then;
            "N° Document" := NoSeriesMgt.GetNextNo(job."No. Series Pointage Vehicule", 0D, true);
            //Journee:=TODAY;
            // Utilisateur := UserId;
            //  "Date saisie" := Today();
        end;
    end;

    var
        job: Record job;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
        RecVehicule: Record "Véhicule";
        "CatégorieVéhicule": Record "Catégorie Véhicule";
        Item: Record Item;
        EntetePointageVehicule: Record "Entete Pointage Vehicule";
        LignePointageVehicule: Record "Ligne Pointage Vehicule";
        LignePointageVehicule2: Record "Ligne Pointage Vehicule";
        LignePointageVehicule3: Record "Ligne Pointage Vehicule";
        LigneGasoil: Record "Ligne Fiche Gasoil";
        DateDebut: Date;
        DateFin: Date;
        Compteur: Integer;
        I: Integer;
        MoisNbr: Integer;
        Text001: label 'Information Deja saisie';
        Text002: label 'Information Deja saisie Pour La Journée %1 Pointage N° %2 Non Encore Validé';
        "GasoilConsomméMois": Decimal;
        "GasoilConsomméJour": Decimal;
        KilometrageJour: Decimal;
        Text003: label 'Suppression Impossible Document Deja Validé';
        Text004: label 'Vous Ne Pouvez Pas Changer De Date';
        LastDocument: Code[20];
        LastJournee: Date;
        "ParamétreParc": Record "Paramétre Parc";
}

