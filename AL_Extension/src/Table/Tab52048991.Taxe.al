Table 52048991 Taxe
{
    //GL2024  ID dans Nav 2009 : "39004700"
    DrillDownPageID = "Liste taxe";
    LookupPageID = "Liste taxe";

    fields
    {
        field(1; "N° Véhicule"; Code[10])
        {
            TableRelation = Véhicule;

            trigger OnValidate()
            begin
                TestValider;
            end;
        }
        field(2; "Date Document"; Date)
        {

            trigger OnValidate()
            begin
                TestValider;

                ParcSetup.Get;
                Express := '+' + Format(ParcSetup."Durée Taxe");
                if "Date Document" <> 0D then
                    "Date fin Validité" := CalcDate(Express, "Date Document");
            end;
        }
        field(3; "Date fin Validité"; Date)
        {
            Editable = false;
        }
        field(4; Montant; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                TestValider;
            end;
        }
        field(5; Valider; Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "N° Véhicule", "Date Document")
        {
            Clustered = true;
            SumIndexFields = Montant;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Validate("Date Document", Today);
    end;

    var
        ParcSetup: Record "Paramétre Parc";
        Express: Text[10];


    procedure TestValider()
    begin
        if Valider then
            Error('LE Taxe est Validé');
    end;
}

