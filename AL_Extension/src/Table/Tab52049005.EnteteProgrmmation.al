Table 52049005 "Entete Progrmmation"
{
    //GL2024  ID dans Nav 2009 : "39004728"
    DrillDownPageID = "Liste Programmation";
    LookupPageID = "Liste Programmation";

    fields
    {
        field(1; "N° Document"; Code[20])
        {
        }
        field(2; Journee; Date)
        {
        }
        field(3; Chantier; Code[20])
        {
            TableRelation = Job;
        }
        field(4; "Designation Affectation"; Text[100])
        {
            CalcFormula = lookup(Job.Description where("No." = field(Affectation)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; Statut; Option)
        {
            OptionMembers = Ouvert,"Validé";
        }
        field(50001; Affectation; Code[20])
        {
            TableRelation = Job;
        }
        field(50002; "Sous Affectation"; Code[20])
        {
            TableRelation = "Sous Affectation Marche";
        }
    }

    keys
    {
        key(STG_Key1; "N° Document")
        {
            Clustered = true;
        }
        key(STG_Key2; Journee)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "N° Document" = '' then begin
            if ParametreParc.Get then;
            "N° Document" := NoSeriesMgt.GetNextNo(ParametreParc."N° Bon de chargement", 0D, true);
            Journee := Today;
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
}

