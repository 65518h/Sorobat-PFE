
Table 52049057 "Visite Technique"
{
    //GL2024  ID dans Nav 2009 : "39004693"
    //GL2024   DrillDownPageID = "Liste Visites Techniques";
    //   LookupPageID = "Liste Visites Techniques";

    fields
    {
        field(1; "N° Visite"; Code[10])
        {
        }
        field(2; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(3; "N° Cert. Visite"; Code[12])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(4; "Date Visite"; Date)
        {

            trigger OnValidate()
            begin
                TestValidation;
                ParcSetup.Get;
                if RecVehicule.Get("N° Véhicule") then;
                Express := '+' + Format(RecVehicule."Durée visite technique");
                if "Date Visite" <> 0D then
                    "Date Fin Validité" := CalcDate(Express, "Date Visite")
                else
                    "Date Fin Validité" := 0D;
            end;
        }
        field(5; "Date Fin Validité"; Date)
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(6; "N° d'Ordre"; Code[10])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(7; "N° Châssis"; Code[30])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(8; "N° Im."; Code[10])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(9; Affectation; Text[30])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(10; "Montant T.F."; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                TestValidation;
                "Montant Total" := "Montant T.F." + "Montant FPCSR";
            end;
        }
        field(11; "Montant FPCSR"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                TestValidation;
                "Montant Total" := "Montant T.F." + "Montant FPCSR";
            end;
        }
        field(12; "Date document"; Date)
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(13; "No. Series"; Code[10])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(14; Valider; Boolean)
        {
        }
        field(15; "Filtre date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(16; "Montant Total"; Decimal)
        {
            AutoFormatType = 1;
        }
    }

    keys
    {
        key(Key1; "N° Visite")
        {
            Clustered = true;
        }
        key(Key2; "Date Visite")
        {
        }
        key(Key3; "Date Visite", "N° Véhicule")
        {
            SumIndexFields = "Montant Total";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "N° Visite" = '' then begin
            ParcSetup.Get;
            ParcSetup.TestField("N° Visite");
            NoSeriesMgt.InitSeries(ParcSetup."N° Visite", xRec."No. Series", 0D, "N° Visite", "No. Series");
        end;
        "Date document" := Today;
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Express: Text[30];
        RecVehicule: Record "Véhicule";


    procedure AssistEdit(Oldvisit: Record "Visite Technique"): Boolean
    var
        Visit: Record "Visite Technique";
    begin
        with Rec do begin
            Visit := Rec;
            ParcSetup.Get;
            ParcSetup.TestField("N° Visite");
            if NoSeriesMgt.SelectSeries(ParcSetup."N° Visite", Oldvisit."No. Series", "No. Series") then begin
                ParcSetup.Get;
                ParcSetup.TestField("N° Visite");
                NoSeriesMgt.SetSeries("N° Visite");
                Rec := Visit;
                exit(true);
            end;
        end;
    end;


    procedure TestValidation()
    var
        RecVheicule: Record "Véhicule";
    begin
        if Valider then begin
            Error('Visite Valider, Modification impossible')
        end else begin
            if RecVheicule.Get("N° Véhicule") then
                "N° Châssis" := RecVheicule."Num Châssis";
            "N° Im." := RecVheicule.Immatriculation;
            // Affectation := !
        end;
    end;
}

