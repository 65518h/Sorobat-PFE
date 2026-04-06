table 52048906 Note1
{
    //GL2024  ID dans Nav 2009 : "39001435"
    fields
    {
        field(1; "N° Sequence"; Integer)
        {
            Editable = false;
        }
        field(2; "Année"; Integer)
        {
        }
        field(3; Trimestre; Option)
        {
            OptionCaption = ' ,1ère,2ème,3ème,4ème';
            OptionMembers = " ","1ère","2ème","3ème","4ème";
        }
        field(4; "N° Salariée"; Code[20])
        {
            TableRelation = Employee;
        }
        field(5; "Type Note"; Option)
        {
            OptionMembers = "Aptitude professionnelle","Efficacité","Assiduité","Ponctualité";
        }
        field(6; Note; Decimal)
        {

            trigger OnValidate()
            begin
                /*CASE "Type Note" OF
                    0 : IF (Note<0) OR (Note>6) THEN
                          ERROR('Vérifier Note');
                    1 : IF (Note<0) OR (Note>6) THEN
                          ERROR('Vérifier Note');
                    2 : IF (Note<0) OR (Note>4) THEN
                          ERROR('Vérifier Note');
                    3 : IF (Note<0) OR (Note>4) THEN
                          ERROR('Vérifier Note');
                  END;
                */
                IF (Note < 0) OR (Note > 20) THEN
                    ERROR('Vérifier Note');

            end;
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

    trigger OnInsert()
    var
        LigNote: Record 52048906;
    begin
        "Code Utilisater" := USERID;
        "Date modif" := TODAY;
        "Heure Modif" := TIME;
        "Date Travail" := WORKDATE;
    end;
}

