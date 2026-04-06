Table 52049011 "Ligne Pointage Vehicule"
{
    //GL2024  ID dans Nav 2009 : "39004735"
    DrillDownPageID = "Ligne Pointage Vehicule";
    LookupPageID = "Ligne Pointage Vehicule";

    fields
    {
        field(1; "Document N°"; Code[20])
        {
        }
        field(2; Vehicule; Code[20])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                Validate("Heure Travailler", "Heure Travail Theorique");
                // RecVehicule2.Reset;
                // if RecVehicule2.Get(Vehicule) then begin
                //     Description := RecVehicule2.Désignation;
                //     Statut := RecVehicule2."Statut Vehicule";
                // end;

                // RecEntetePointageVehicule.Reset;
                // if RecEntetePointageVehicule.Get("Document N°") then begin
                //     Chantier := RecEntetePointageVehicule.Marche;
                //     Journee := RecEntetePointageVehicule.Journee;
                // end
            end;
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Statut; Option)
        {
            OptionMembers = " ",Fonctionnel,Disponible,Panne,"Mauvais Temps",Accident,Réformé;

            trigger OnValidate()
            begin
                if RecVehicule.Get(Vehicule) then begin
                    "Cout Horaire" := RecVehicule."Cout Location Horaire";
                    //  RecVehicule.Statut := Statut;
                    "Index Depart" := RecVehicule."Reste Pour Alerte";
                    "Index Depart" := RecVehicule."Compteur Actuel";
                    "Grande Famille" := RecVehicule."Grande Famille";

                    //  RecVehicule.MODIFY;
                end;
                if "Cout Journalier" <> 0 then
                    Validate("Heure Travailler", 10)
                else
                    if Statut = Statut::Disponible then begin
                        Validate("Heure Travailler", "Heure Travail Theorique");
                        "Heure Travailler" := 0;
                    end;
                if (Statut = Statut::Fonctionnel) then begin
                    "Heure Utilisation" := 10;
                    "Heure Immobilisation" := 0;
                    "Cout Heure Reel" := 10 * "Cout Horaire";
                    "Cout Heure Immobilisation" := 0;
                    "Cout Total Journee" := "Cout Heure Reel" + "Cout Heure Immobilisation";
                    Fonctionnel := true;
                    "Heure Travailler" := 0;

                end
                else
                    Fonctionnel := false;
                if Statut = Statut::Fonctionnel then begin
                    "Motif Panne" := '';
                    "Motif Indispensalité" := 0;
                end;
                if Statut = Statut::Disponible then "Motif Panne" := '';
                if Statut = Statut::Panne then "Motif Indispensalité" := 0;
                UpdateFicheVehicule;
            end;
        }
        field(50001; Journee; Date)
        {
            Editable = false;
        }
        field(50002; "Heure Travailler"; Decimal)
        {
            DecimalPlaces = 0 : 1;
            Editable = true;

            trigger OnValidate()
            begin
                if "Heure Travailler" = 0 then exit;
                if ("Heure Travailler" <> 0) and (Statut = Statut::Fonctionnel) then Fonctionnel := false;
                if ("Heure Travailler" = 0) and (Statut = Statut::Fonctionnel) then Fonctionnel := true;
                if Statut = Statut::Panne then begin
                    "Cout Heure Reel" := 0;
                    "Heure Travailler" := 0;
                    "Heure Utilisation" := 0;
                    "Heure Immobilisation" := 0;
                    "Cout Heure Immobilisation" := 0;
                    "Cout Total Journee" := "Cout Heure Reel" + "Cout Heure Immobilisation";
                end;

                if 1 = 1 then begin
                    if Statut = Statut::Disponible then begin
                        "Cout Heure Reel" := 0;
                        "Heure Travailler" := 0;
                        "Heure Utilisation" := 0;
                        "Heure Immobilisation" := 10;
                        "Cout Heure Immobilisation" := "Cout Horaire" * 0.4;
                        "Cout Total Journee" := "Cout Heure Reel" + "Cout Heure Immobilisation";

                    end;
                    if Statut = Statut::Fonctionnel then begin
                        "Cout Heure Reel" := "Cout Journalier";
                        "Heure Travailler" := 10;
                        "Heure Utilisation" := 10;
                        "Heure Immobilisation" := 0;
                        "Cout Heure Immobilisation" := 0;
                        "Cout Total Journee" := "Cout Heure Reel" + "Cout Heure Immobilisation";

                    end;

                    exit;
                end;
                if Statut = Statut::Fonctionnel then begin
                    if "Heure Travailler" >= 10 then begin
                        "Heure Utilisation" := "Heure Travailler";
                        "Heure Immobilisation" := 0;
                        "Cout Heure Reel" := "Heure Travailler" * "Cout Horaire";
                        "Cout Heure Immobilisation" := 0

                    end;
                    if "Heure Travailler" < 10 then begin
                        "Heure Utilisation" := "Heure Travailler";
                        "Heure Immobilisation" := "Heure Travail Theorique" - "Heure Travailler";
                        "Cout Heure Reel" := "Heure Travailler" * "Cout Horaire";
                        "Cout Heure Immobilisation" := ("Heure Travail Theorique" - "Heure Travailler") * "Cout Horaire" * 0.4
                    end;

                end;
                if Statut = Statut::Disponible then begin
                    "Heure Utilisation" := 0;
                    "Heure Immobilisation" := "Heure Travailler";
                    "Cout Heure Reel" := 0;
                    "Cout Heure Immobilisation" := "Heure Travailler" * "Cout Horaire" * 0.4

                end;
                "Cout Total Journee" := "Cout Heure Reel" + "Cout Heure Immobilisation";
            end;
        }
        field(50003; "Cout Horaire"; Decimal)
        {
            Editable = false;
            TableRelation = Job;
        }
        field(50004; "Heure Utilisation"; Decimal)
        {
            Editable = false;
        }
        field(50005; "Heure Immobilisation"; Decimal)
        {
            Editable = false;
        }
        field(50006; "Cout Total Journee"; Decimal)
        {
            Editable = false;
        }
        field(50007; "Cout Heure Reel"; Decimal)
        {
            Editable = false;
        }
        field(50008; "Cout Heure Immobilisation"; Decimal)
        {
            Editable = false;
        }
        field(50009; "Idex Kilometrique"; Decimal)
        {
            Editable = false;
        }
        field(50010; Gasoil; Decimal)
        {
            Editable = false;
        }
        field(50011; Mois; Integer)
        {
        }
        field(50012; Annee; Integer)
        {
        }
        field(50013; "Heure Travail Theorique"; Integer)
        {
        }
        field(50014; Marche; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                // IF RecVehicule.GET(Vehicule) THEN BEGIN
                //     RecVehicule.marche := Marche;
                //     RecVehicule.MODIFY;
                // END;
            END;


        }
        field(50015; "Unite Travail"; Code[20])
        {
        }
        field(50016; "Cout Gasoil"; Decimal)
        {
            Editable = false;
        }
        field(50017; "Cout Journalier"; Decimal)
        {
        }
        field(50018; Fonctionnel; Boolean)
        {
        }
        field(50019; Ligne; Integer)
        {
        }
        field(50020; Chauffeur; Code[20])
        {
            TableRelation = Salarier;
        }
        field(50021; "Type Vehicule"; Text[50])
        {
        }
        field(50022; "N° Serie"; Code[20])
        {
        }
        field(50023; "Sous Affectation Marche"; Code[50])
        {
            TableRelation = "Sous Affectation Marche";
        }
        field(50024; "Statut Entete"; Option)
        {
            OptionMembers = Ouvert,"Validé";
        }
        field(50025; "AMM Journalier"; Decimal)
        {
        }
        field(50026; "MS Journalier"; Decimal)
        {
        }
        field(50027; "DA Lancé"; Boolean)
        {

            trigger OnValidate()
            begin
                UpdateFicheVehicule;
            end;
        }
        field(50028; "N° DA"; Code[20])
        {
            TableRelation = "Purchase Request"."No." WHERE(Engin = FIELD(Vehicule)/*,
                                                      Status = FILTER(<> 'Released')*/);

            trigger OnValidate()
            begin
                UpdateFicheVehicule;
            end;
        }
        field(50029; "Index Depart"; Decimal)
        {
        }
        field(50030; "Index Final"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "Index Final" < "Index Depart" THEN ERROR(Text002);
                // IF RecVehicule.GET(Vehicule) THEN BEGIN
                //     RecVehicule."Reste Pour Alerte" := "Index Final";
                //     RecVehicule.MODIFY;
                // END;
                UpdateFicheVehicule;
            end;
        }
        field(50031; "Motif Indispensalité"; Option)
        {
            OptionMembers = " ","Non Affecté","Absence Conducteur",Autre;

            trigger OnValidate()
            begin
                IF Statut <> Statut::Disponible THEN ERROR(Text003);
                UpdateFicheVehicule;
            end;
        }
        field(50032; "Motif Panne"; Code[20])
        {
            TableRelation = "Cause of Inactivity";

            trigger OnValidate()
            begin
                IF Statut <> Statut::Panne THEN ERROR(Text004);
                UpdateFicheVehicule;
            end;
        }
        field(50033; "N° Reparation"; Code[20])
        {
            TableRelation = "Réparation Véhicule"."N° Reparation" WHERE("N° Véhicule" = FIELD(Vehicule),
                                                                         Statut = FILTER(<> Clôturé));

            trigger OnValidate()
            begin
                UpdateFicheVehicule;
            end;
        }
        field(50034; Observation; Text[200])
        {
        }
        field(50035; Conducteur; Code[20])
        {
        }
        field(50036; "Chauffeur 2"; Code[20])
        {
            TableRelation = Salarier;
        }
        field(50037; "Chauffeur 3"; Code[20])
        {
            TableRelation = Salarier;
        }
        field(50038; Synchronise; Boolean)
        {
        }
        field(50039; "Grande Famille"; Code[30])
        {
        }
        field(50040; "Affectation Marche"; Code[50])
        {
            TableRelation = "Affectation Marche";
        }
        field(50041; "Nombre Voyage"; Integer)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Document N°", Vehicule, Journee)
        {
            Clustered = true;
            SumIndexFields = "Heure Travailler", "Heure Utilisation", "Heure Immobilisation", "Cout Total Journee", "Cout Heure Reel", "Cout Heure Immobilisation", "Cout Gasoil", Gasoil;
        }
        key(STG_Key2; Vehicule, Journee)
        {
        }
    }





    fieldgroups
    {
    }

    var
        RecVehicule: Record "Véhicule";
        Text001: label 'BL Déja Saise';
        RecItem: Record Item;
        EntetePointageVehicule: Record "Entete Pointage Vehicule";
        Text002: label 'Information Deja saisie Pour La Journée %1';
        Text003: label 'Statut Doit etre Disponible';
        Text004: label 'Statut Doit Etre Panne';
        LignePointageVehicule: Record "Ligne Pointage Vehicule";
        RecVehicule2: Record "Véhicule";
        RecEntetePointageVehicule: Record "Entete Pointage Vehicule";


    procedure UpdateFicheVehicule()
    var
        LVehicule: Record "Véhicule";


    begin
        if LVehicule.Get(Vehicule) then begin
            LVehicule."Motif Panne" := '';
            LVehicule."Motif Disponibilité" := 0;
            LVehicule."Derniere Date Fonctionnel" := 0D;
            LVehicule."N° Fiche Reparation" := '';
            LVehicule."DA Lancé" := false;
            LVehicule."N° Da" := '';
            LVehicule.Modify;
        end;

        if (Statut = Statut::Panne) or (Statut = Statut::Disponible) then begin
            if LVehicule.Get(Vehicule) then begin
                LVehicule."Motif Panne" := "Motif Panne";
                LVehicule."Motif Disponibilité" := "Motif Indispensalité";
                LignePointageVehicule.SetRange(Vehicule, Vehicule);
                LignePointageVehicule.SetRange(Statut, LignePointageVehicule.Statut::Fonctionnel);
                if LignePointageVehicule.FindLast then
                    LVehicule."Derniere Date Fonctionnel" := LignePointageVehicule.Journee
                else
                    LVehicule."Derniere Date Fonctionnel" := Journee;
                LVehicule."N° Fiche Reparation" := "N° Reparation";
                LVehicule."DA Lancé" := "DA Lancé";
                LVehicule."DA Lancé" := "DA Lancé";
                LVehicule."N° Da" := "N° DA";
                LVehicule.Modify;
            end;
        end;
    end;
}

