table 52049048 "Fiche Frais mission enregistré"
{
    //GL2024  ID dans Nav 2009 : "39004710"
    fields
    {
        field(1; "N° Frais"; Code[10])
        {
        }
        field(2; "Code Mission"; Code[10])
        {
            TableRelation = "Mission Enregistré" WHERE("Code Convoyeur" = FILTER('NO'));
        }
        field(3; "N° Salarié"; Code[10])
        {
            TableRelation = Employee WHERE(Status = CONST(Active));
        }
        field(4; "Date Comptabilisation"; Date)
        {
        }
        field(5; "Code Utilisateur"; Code[10])
        {
        }
        field(8; "No. Series"; Code[10])
        {
        }
        field(9; "First name"; Text[30])
        {
        }
        field(10; "Last Name"; Text[30])
        {
        }
        field(50; "Global dimension 1"; Code[10])
        {
        }
        field(51; "Global dimension 2"; Code[10])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Frais")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

