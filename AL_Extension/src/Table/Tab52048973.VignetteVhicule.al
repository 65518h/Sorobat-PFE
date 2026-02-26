Table 52048973 "Vignette Véhicule"
{
    //GL2024  ID dans Nav 2009 : "39004673"
    DrillDownPageID = "Liste Vignettes";
    LookupPageID = "Liste Vignettes";

    fields
    {
        field(1; "N° Veh"; Code[10])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(2; "Date Document"; Date)
        {

            trigger OnValidate()
            begin
                TestValidation;
                ParcSetup.Get;
                Express := '+' + Format(ParcSetup."Durée Vignette");
                if "Date Document" <> 0D then
                    "Date Fin de Validité" := CalcDate(Express, "Date Document");
            end;
        }
        field(3; "code Vig"; Code[10])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(4; "Libellé"; Text[100])
        {

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(5; Tarif; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                TestValidation;
            end;
        }
        field(6; "Date Fin de Validité"; Date)
        {
            Editable = false;
        }
        field(7; Valider; Boolean)
        {
        }
        field(8; "Filtre date"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = Date;
        }
    }

    keys
    {
        key(Key1; "N° Veh", "Date Document", "code Vig")
        {
            Clustered = true;
            SumIndexFields = Tarif;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestValidation;
    end;

    trigger OnModify()
    begin
        TestValidation;
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        Express: Text[10];


    procedure TestValidation()
    begin
        if Valider then
            Error('Vignette Validée, Modification impossible');
    end;
}

