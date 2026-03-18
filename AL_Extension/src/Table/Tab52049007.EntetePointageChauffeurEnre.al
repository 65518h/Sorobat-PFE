Table 52049007 "Entete Pointage Chauffeur Enre"
{
    //GL2024  ID dans Nav 2009 : "39004730"
    DrillDownPageID = "Liste Pointage Enregistré";
    LookupPageID = "Liste Pointage Enregistré";

    fields
    {
        field(1; "N° Document"; Code[20])
        {
        }
        field(2; Journee; Date)
        {
        }
        field(3; Affectation; Code[20])
        {
            TableRelation = Job;
        }
        field(4; "Designation Affectation"; Text[100])
        {
            CalcFormula = lookup(Job.Description where("No." = field(Affectation)));
            Editable = true;
            FieldClass = FlowField;
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

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParametreParc: Record "Paramétre Parc";
}

