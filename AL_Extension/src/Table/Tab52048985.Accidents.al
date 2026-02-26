Table 52048985 Accidents
{
    //GL2024  ID dans Nav 2009 : "39004686"
    DrillDownPageID = "Liste Accidents";
    LookupPageID = "Liste Accidents";

    fields
    {
        field(1; "N° Accident"; Code[20])
        {
        }
        field(2; "Date Accident"; Date)
        {
        }
        field(3; "N° Mission"; Code[20])
        {
            TableRelation = "Mission Enregistré";

            trigger OnValidate()
            begin
                MissEnreg.SetRange("N° Mission", "N° Mission");
                if MissEnreg.Find('-') then begin
                    if "Date Accident" in [MissEnreg."Date Départ" .. MissEnreg."Date Arrivée"] then begin
                        Validate("N° Véhicule", MissEnreg."N° Véhicule");
                        Validate("N° Conducteur", MissEnreg."Code Demandeur");
                    end else
                        Error('Vérifier la date de la mission');
                end;
            end;
        }
        field(4; "N° Véhicule"; Code[20])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                if Veh.Get("N° Véhicule") then begin
                    "N° Immatriculation" := Veh.Immatriculation;
                    Veh.Bloquer := true;
                    Veh.Modify;
                    Message('La Véhicule sera Bloquer');
                end;
            end;
        }
        field(5; "N° Immatriculation"; Code[20])
        {
        }
        field(6; "N° Constat"; Code[20])
        {
        }
        field(7; "N° Conducteur"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Conduct.Get("N° Conducteur") then begin
                    "Nom Conducteur" := Conduct."First Name";
                    "Fonction Conducteur" := Conduct."Job Title";
                end;
            end;
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
        field(12; "Filtre date"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = Date;
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
            //   lSingleinstance: Codeunit "Import SingleInstance2";
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "N° Accident")
        {
            Clustered = true;
        }
        key(Key2; "N° Mission")
        {
        }
        key(Key3; "N° Véhicule")
        {
        }
        key(Key4; "N° Conducteur")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "N° Accident" = '' then begin
            ParcSetup.Get;
            if RecUserSetup.Get(UserId) then;
            "Centre de Gestion" := RecUserSetup."Car Pool Resp. Ctr. Filter";
            ParcSetup.TestField("N° Accident");
            CduNoSeriesRespCentManagement.InitSeries(ParcSetup."N° Accident", xRec."No. Series", 0D, "N° Accident", "No. Series",
            RecUserSetup."Car Pool Resp. Ctr. Filter");
        end;
        "Date Document" := Today;
    end;

    var
        MissEnreg: Record "Mission Enregistré";
        Veh: Record "Véhicule";
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Conduct: Record Employee;
        CduNoSeriesRespCentManagement: Codeunit NoSeriesRespCenterManagement;
        RecUserSetup: Record "User Setup";


    procedure AssistEdit(OldAcc: Record Accidents): Boolean
    var
        Acc: Record Accidents;
    begin
        with Rec do begin
            Acc := Rec;
            ParcSetup.Get;
            ParcSetup.TestField("N° Accident");
            if NoSeriesMgt.SelectSeries(ParcSetup."N° Accident", OldAcc."No. Series", "No. Series") then begin
                ParcSetup.Get;
                ParcSetup.TestField("N° Accident");
                NoSeriesMgt.SetSeries("N° Accident");
                Rec := Acc;
                exit(true);
            end;
        end;
    end;
}

