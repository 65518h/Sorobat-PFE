table 52048948 "Note Enreg1."
{
    //GL2024  ID dans Nav 2009 : "39001436"
    fields
    {
        field(1; "N° Sequence"; Integer)
        {
            Editable = false;
        }
        field(2; "Année"; Integer)
        {
            Editable = false;
        }
        field(3; Trimestre; Option)
        {
            Editable = false;
            OptionCaption = ' ,1ère,2ème,3ème,4ème';
            OptionMembers = " ","1ère","2ème","3ème","4ème";
        }
        field(4; "N° Salariée"; Code[20])
        {
            Editable = false;
            TableRelation = Employee;
        }
        field(5; "Type Note"; Option)
        {
            Editable = false;
            Enabled = true;
            OptionMembers = "Aptitude professionnelle","Efficacité","Assiduité","Ponctualité";
        }
        field(6; Note; Decimal)
        {
            Editable = false;
            Enabled = true;
        }
        field(10; "Code Utilisater"; Code[20])
        {
            Editable = false;
        }
        field(11; "Date modif"; Date)
        {
            Editable = false;
        }
        field(12; "Heure Modif"; Time)
        {
            Editable = false;
        }
        field(13; "Date Travail"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "N° Sequence")
        {
            Clustered = true;
        }
        key(STG_Key2; "Année", Trimestre, "N° Salariée", "Type Note")
        {
            SumIndexFields = Note;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR('impossible de Supprimer');
    end;

    trigger OnModify()
    begin
        //ERROR('impossible de Modifier');
    end;
}

