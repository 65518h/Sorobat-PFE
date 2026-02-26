table 52048913 "Line Calendar Roulement"
{


    // DrillDownPageID = "Line Calendar Roulement";
    // LookupPageID = "Line Calendar Roulement";
    //GL2024  ID dans Nav 2009 : "39001446"

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "Caledar Roulement";
        }
        field(2; "Line no."; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Type; Option)
        {
            OptionMembers = Matin,"Après Midi",Soir,Repos;

            trigger OnValidate()
            begin
                IF Type = 3 THEN
                    Noworking := TRUE;
            end;
        }
        field(4; "Heure Debut"; Time)
        {

            trigger OnValidate()
            begin
                VALIDATE("Durée (Heure)");
            end;
        }
        field(5; "Heure Fin"; Time)
        {

            trigger OnValidate()
            begin
                "Durée (Heure)" := ("Heure Fin" - "Heure Debut") / 3600000;
            end;
        }
        field(6; "Durée (Heure)"; Decimal)
        {

            trigger OnValidate()
            begin
                "Heure Fin" := "Heure Debut" + ("Durée (Heure)" * 3600000);
            end;
        }
        field(7; Noworking; Boolean)
        {
        }
        field(10; "Type Abonnement"; Option)
        {
            OptionMembers = Hebdomadaire,"Abonnement Annuel";

            trigger OnValidate()
            begin
                IF "Type Abonnement" = 0 THEN
                    Date := 0D
                ELSE BEGIN
                    Type := 3;
                    "Line no." := 0;
                END;
            end;
        }
        field(11; Date; Date)
        {

            trigger OnValidate()
            begin
                IF "Type Abonnement" = 0 THEN
                    Date := 0D;
            end;
        }
    }

    keys
    {
        key(Key1; "Code", "Type Abonnement", "Line no.", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Type Abonnement" = 0 THEN BEGIN
            Ligne.RESET;
            Ligne.SETFILTER(Code, Code);
            Ligne.SETRANGE("Type Abonnement", "Type Abonnement");
            i := 0;
            IF Ligne.COUNT <> 0 THEN
                i := Ligne.COUNT;
            i := i + 1;
            "Line no." := i;
        END;
    end;

    var
        Ligne: Record 52048913;
        i: Integer;
}

