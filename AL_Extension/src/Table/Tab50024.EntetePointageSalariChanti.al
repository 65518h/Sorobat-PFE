Table 50024 "Entete Pointage Salarié Chan"
{//NEW Table

    fields
    {
        field(1; "No. Pointage"; code[50])
        {
            caption = 'N° Pointage';
        }



        field(2; "Mois Attachement"; Option)
        {
            OptionMembers = " ",Janvier,Fevrier,Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,Decembre;
        }
        field(3; "Annee Attachement"; Integer)
        {
        }

        field(4; Affectation; Code[20])
        {
            TableRelation = "Employee Statistics Group" WHERE(Type = CONST(Service));


        }
        field(5; Statut; Option)
        {

            OptionMembers = Ouvert,Valider;
        }
    }

    keys
    {
        key(STG_Key1; "No. Pointage")
        {
            Clustered = true;
        }
        // key(STG_Key2; "No. Pointage", Matricule, "Annee Attachement", "Mois Attachement", Affectation)
        // {

        // }

    }

    fieldgroups
    {
    }
    procedure InitRecord()
    var
        HumRessSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        NoSeriesMgt.SetDefaultSeries(rec."No. Pointage", HumRessSetup."Pointage Salarié");
    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit 396;
    begin
        HumRessSetup.Get;
        if "No. Pointage" = '' then begin
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, HumRessSetup."Pointage Salarié"
            , Today, "No. Pointage", HumRessSetup."Pointage Salarié");
        end;

    end;

    local procedure GetNoSeriesCode(): Code[10]

    begin
        exit(HumRessSetup."Pointage Salarié");
    end;

    local procedure TestNoSeries(): Boolean

    begin

        HumRessSetup.TestField("Pointage Salarié");
    end;

    var

        Employee: Record 5200;


        HumRessSetup: Record "Human Resources Setup";
}

