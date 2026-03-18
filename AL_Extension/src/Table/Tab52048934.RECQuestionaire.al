table 52048934 "REC-Questionaire"
{
    //GL2024  ID dans Nav 2009 : "39001490"
    // LookupPageID = "REC-Questionaire";

    fields
    {
        field(1; Theme; Code[20])
        {
            TableRelation = "REC-Themes";
        }
        field(2; "Code question"; Integer)
        {
            BlankZero = true;
            Editable = false;
        }
        field(3; "description question"; Text[250])
        {
        }
        field(4; Reponse; Integer)
        {
            CalcFormula = Count("REC-Reponse" WHERE("Code question" = FIELD("Code question"),
                                                   "Code theme" = FIELD(Theme),
                                                   "N° Demande" = FIELD("N° Demande")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "N° Demande"; Integer)
        {
            TableRelation = "REC-Recrutement des ressources" WHERE("Validation DG" = FILTER(Validee));
        }
        field(6; "N° Entretien"; Integer)
        {
            TableRelation = "REC-Entretiens";
        }
    }

    keys
    {
        key(STG_Key1; "N° Demande", Theme, "Code question")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        RecGQuestionaire.SETRANGE(RecGQuestionaire."N° Demande", "N° Demande");
        RecGQuestionaire.SETRANGE(RecGQuestionaire.Theme, Theme);
        IF RecGQuestionaire.FINDLAST THEN
            "Code question" := RecGQuestionaire."Code question" + 1
        ELSE
            "Code question" := 1;
    end;

    var
        RecGQuestionaire: Record 52048934;
}

