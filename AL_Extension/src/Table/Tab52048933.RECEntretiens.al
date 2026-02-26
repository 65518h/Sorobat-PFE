table 52048933 "REC-Entretiens"
{


    //GL2024  ID dans Nav 2009 : "39001489"
    // DrillDownPageID = "REC-Liste entretiens";
    //LookupPageID = "REC-Liste entretiens";

    fields
    {
        field(1; "N° Entretien"; Integer)
        {
            Editable = false;
        }
        field(2; Evaluateur; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                CALCFIELDS("Nom Evaluateur");
            end;
        }
        field(3; "Nom Evaluateur"; Text[50])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD(Evaluateur)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Date entretien"; Date)
        {

            trigger OnValidate()
            begin
                IF RecGdemandeRecrutEnrg.GET(RecGEntretient."N°Demande") THEN
                    IF RecGEntretient."Date entretien" < RecGdemandeRecrutEnrg.Date THEN
                        ERROR(Texte001);
            end;
        }
        field(5; "Heure entretien"; Time)
        {
        }
        field(6; Observation; Text[250])
        {
        }
        field(7; "Note accordee"; Decimal)
        {
        }
        field(8; "N° Candidat"; Code[20])
        {
            TableRelation = "REC-Candidat";
        }
        field(9; "N°Demande"; Integer)
        {
            BlankZero = true;
            //  TableRelation = Table70053;
        }
        field(10; Statut; Option)
        {
            OptionCaption = ' ,Encours,Passé,Annulé';
            OptionMembers = " ",Encour,Passe,Annule;
        }
        field(11; "Nom candidat"; Text[50])
        {
            CalcFormula = Lookup("REC-Candidat"."First Name" WHERE("No." = FIELD("N° Candidat")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "N° Entretien", "N° Candidat")
        {
            Clustered = true;
            SumIndexFields = "Note accordee";
        }
        key(Key2; Evaluateur, "N° Entretien", "Date entretien", "Heure entretien")
        {
        }
        key(Key3; "Date entretien", "Heure entretien")
        {
        }
        key(Key4; "N° Candidat", "Note accordee")
        {
            SumIndexFields = "Note accordee";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        RecGEntretient.SETRANGE(RecGEntretient."N° Candidat", "N° Candidat");
        IF RecGEntretient.FINDLAST THEN
            "N° Entretien" := RecGEntretient."N° Entretien" + 1
        ELSE
            "N° Entretien" := 1;
    end;

    var
        RecGEntretient: Record 52048933;
        RecGdemandeRecrutEnrg: Record "REC-Recrutement des ressources";
        Texte001: Label 'La date ne doit pas être inférieure à la date de la dmande de recrutement.';
}

