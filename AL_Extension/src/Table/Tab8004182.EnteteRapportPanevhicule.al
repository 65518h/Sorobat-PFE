Table 8004182 "Entete Rapport Pane véhicule"
{
    //DrillDownPageID = 8004196;
    //LookupPageID = 8004196;

    fields
    {
        field(1; "N°"; Code[20])
        {
        }
        field(2; Journee; Date)
        {
        }
        field(3; Marche; Code[20])
        {
            TableRelation = Job;
        }
        field(4; "Agent Saisie"; Code[20])
        {
        }
        field(5; "Date Saisie"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; "N°")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "N°" = '' then begin
            "N°" := NoSeriesMgt.GetNextNo('RPTPANNE', 0D, true);
            "Agent Saisie" := UserId;
            "Date Saisie" := Today();
        end;
    end;

    var
        NoSeriesMgt: Codeunit 396;
}

