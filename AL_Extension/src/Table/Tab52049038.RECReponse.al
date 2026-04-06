table 52049038 "REC-Reponse"
{


    //GL2024  ID dans Nav 2009 : "39001491"
    // DrillDownPageID = "REC-Reponses";
    // LookupPageID = "REC-Reponses";

    fields
    {
        field(1; "Code question"; Integer)
        {
        }
        field(2; "Code reponse"; Integer)
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Code theme"; Code[20])
        {
            //  TableRelation = Table70058;
        }
        field(5; "N° Demande"; Integer)
        {
            TableRelation = "REC-Recrutement des ressources" WHERE("Validation DG" = FILTER(Validee));
        }
        field(6; "N° Entretien"; Integer)
        {
            // TableRelation = Table70055;
        }
        field(7; "N° Candidat"; Code[20])
        {
            // TableRelation = Table70054;
        }
    }

    keys
    {
        key(STG_Key1; "N° Demande", "Code theme", "Code question", "Code reponse")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

