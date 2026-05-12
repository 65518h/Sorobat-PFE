table 52049062 "Entete Programmation Enr"
{ //GL2024  ID dans Nav 2009 : "39004732"
  //  DrillDownPageID = "Entete Rapport Chantier";
  // LookupPageID = "Entete Rapport Chantier";

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
            CalcFormula = Lookup(Job.Description WHERE("No." = FIELD(Affectation)));
            Editable = true;
            FieldClass = FlowField;
        }
        field(5; Synchronise; Boolean)
        {
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
        NoSeriesMgt: Codeunit 396;
        ParametreParc: Record "Paramétre Parc";
}

