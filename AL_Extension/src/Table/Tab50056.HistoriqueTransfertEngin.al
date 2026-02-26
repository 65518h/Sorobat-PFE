Table 50056 "Historique Transfert Engin"
{
    //  DrillDownPageID = "Liste Transfert Engins";
    //  LookupPageID = "Liste Transfert Engins";

    fields
    {
        field(1; "Code Transfert"; Code[20])
        {
        }
        field(2; "Date Transfert"; Date)
        {
        }
        field(3; "User Id"; Code[20])
        {
        }
        field(4; "Code Engin"; Code[20])
        {
            TableRelation = Véhicule."N° Vehicule" where(Bloquer = filter(False));

            trigger OnValidate()
            begin
                RecVehicule.Reset;
                if RecVehicule.Get("Code Engin") then;
                "Description Engin" := RecVehicule.Désignation;
                Immatriculation := RecVehicule.Immatriculation;
                Validate(Depart, RecVehicule.Marche);
            end;
        }
        field(5; "Description Engin"; Text[60])
        {
        }
        field(6; Immatriculation; Code[20])
        {
        }
        field(7; "Code Port-Chart"; Code[20])
        {
            TableRelation = Véhicule."N° Vehicule" where(Bloquer = filter(False));

            trigger OnValidate()
            begin
                RecVehicule.Reset;
                if RecVehicule.Get("Code Port-Chart") then;
                "Description Port-Chart" := RecVehicule.Désignation;
                "Immat Port-Chart" := RecVehicule.Immatriculation;
            end;
        }
        field(8; "Description Port-Chart"; Text[60])
        {
        }
        field(9; "Immat Port-Chart"; Code[20])
        {
        }
        field(10; "Code Chauffeur"; Code[50])
        {
            TableRelation = "Chauffeur Location";

            trigger OnValidate()
            begin
                RecChauffeurLocation.Reset;
                if RecChauffeurLocation.Get("Code Chauffeur") then;
                Chauffeur := RecChauffeurLocation.Nom;
            end;
        }
        field(11; Chauffeur; Text[100])
        {
        }
        field(12; Depart; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                RecJob.Reset;
                if RecJob.Get(Depart) then;
                "Description Depart" := RecJob.Description;
            end;
        }
        field(13; Destination; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            begin
                RecJob.Reset;
                if RecJob.Get(Destination) then;
                "Description Destination" := RecJob.Description;
            end;
        }
        field(14; Observation; Text[100])
        {
        }
        field(15; "Description Depart"; Text[50])
        {
        }
        field(16; "Description Destination"; Text[50])
        {
        }
        field(17; Status; Option)
        {
            OptionCaption = 'Ouvert,Lancer';
            OptionMembers = Ouvert,Lancer;
        }
        field(18; "Code Tracteur Routier"; Code[20])
        {
            TableRelation = Véhicule."N° Vehicule" where(Bloquer = filter(False));

            trigger OnValidate()
            begin
                RecVehicule.Reset;
                if RecVehicule.Get("Code Tracteur Routier") then;
                "Description Tracteur Routier" := RecVehicule.Désignation;
                "Immat Tracteur Routier" := RecVehicule.Immatriculation;
            end;
        }
        field(19; "Description Tracteur Routier"; Text[60])
        {
        }
        field(20; "Immat Tracteur Routier"; Code[20])
        {
        }
        field(21; "Index Engin"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code Transfert")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /* RecParametreParc.Get;
         "Code Transfert" := NoSeriesMgt.GetNextNo(RecParametreParc."Code Transfert Engin", 0D, true);

         "Date Transfert" := Today;
         "User Id" := UpperCase(UserId);*/
    end;

    var
        RecVehicule: Record "Véhicule";
        RecChauffeurLocation: Record "Chauffeur Location";
        RecJob: Record Job;
        NoSeriesMgt: Codeunit 396;
        RecParametreParc: Record "Paramétre Parc";
}

