table 52049040 "Dégats Accident"
{ //GL2024  ID dans Nav 2009 : "39004687"
    DrillDownPageID = "Ligne dégats";
    LookupPageID = "Ligne dégats";

    fields
    {
        field(1; "N° Accident"; Code[10])
        {
        }
        field(2; "N° constat"; Code[10])
        {
        }
        field(3; "N° Ligne"; Integer)
        {
            Editable = false;
        }
        field(4; "Type Dégat"; Code[10])
        {
            TableRelation = "Type Dégats";
        }
        field(5; "Désignation Dégat"; Text[100])
        {
        }
        field(10; "N° Reparation"; Code[10])
        {
        }
        field(11; "Type Réparation"; Option)
        {
            OptionCaption = 'Reparer,Changer';
            OptionMembers = Reparer,Changer;
        }
    }

    keys
    {
        key(Key1; "N° Accident", "N° constat", "N° Ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Degat.RESET;
        Degat.SETCURRENTKEY("N° Accident", "N° constat", "N° Ligne");
        Degat.SETFILTER("N° Accident", "N° Accident");
        IF NOT Degat.FIND('+') THEN
            "N° Ligne" := 10000
        ELSE
            "N° Ligne" := 10000 + Degat."N° Ligne";
    end;

    var
        Degat: Record "Dégats Accident";
}

