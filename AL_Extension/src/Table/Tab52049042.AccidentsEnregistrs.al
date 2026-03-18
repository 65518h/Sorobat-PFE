table 52049042 "Accidents Enregistrés"
{ //GL2024  ID dans Nav 2009 : "39004692"
    DrillDownPageID = "Liste Accidents";
    LookupPageID = "Liste Accidents";

    fields
    {
        field(1; "N° Accident"; Code[10])
        {
        }
        field(2; "Date Accident"; Date)
        {
        }
        field(3; "N° Mission"; Code[10])
        {
            TableRelation = Missions;
        }
        field(4; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;
        }
        field(5; "N° Immatriculation"; Code[20])
        {
        }
        field(6; "N° Constat"; Code[10])
        {
        }
        field(7; "N° Conducteur"; Code[10])
        {
            TableRelation = Employee;
        }
        field(8; "Nom Conducteur"; Text[30])
        {
            Editable = false;
        }
        field(9; "Fonction Conducteur"; Text[30])
        {
            Editable = false;
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; "Date Document"; Date)
        {
        }
        field(12; "N° Affaire"; Code[20])
        {
            TableRelation = Job;
        }
        field(13; "N° Tache Affaire"; Code[20])
        {
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("N° Affaire"));
        }
        field(14; "Centre de Gestion"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
            // lSingleinstance: Codeunit 8001405;
            begin
            end;
        }
    }

    keys
    {
        key(STG_Key1; "N° Accident")
        {
            Clustered = true;
        }
        key(STG_Key2; "N° Mission")
        {
        }
        key(STG_Key3; "N° Véhicule")
        {
        }
        key(STG_Key4; "N° Conducteur")
        {
        }
    }

    fieldgroups
    {
    }

    var
        MissEnreg: Record "Mission Enregistré";
        Veh: Record Véhicule;
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit 396;
        Conduct: Record 5200;
}

