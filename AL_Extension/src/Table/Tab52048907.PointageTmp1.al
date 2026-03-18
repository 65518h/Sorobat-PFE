Table 52048907 "Pointage Tmp1"
{
    //GL2024  ID dans Nav 2009 : "39001437"

    fields
    {
        field(1; Sequence; Integer)
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; Heure; Time)
        {
        }
        field(4; "Event"; Text[30])
        {
        }
        field(5; ObjDesc1; Text[10])
        {
        }
        field(6; Desc1; Text[50])
        {
        }
        field(7; ObjDesc2; Text[10])
        {
        }
        field(8; Desc2; Text[50])
        {
        }
        field(9; ObjDesc3; Text[10])
        {
        }
        field(10; Desc3; Text[50])
        {
        }
        field(11; ObjDesc4; Text[10])
        {
        }
        field(12; Desc4; Text[50])
        {
        }
        field(13; CardNumber; Code[20])
        {
        }
        field(15; "N° Salariée"; Code[20])
        {
        }
    }

    keys
    {
        key(STG_Key1; Sequence)
        {
            Clustered = true;
        }
        key(STG_Key2; CardNumber, Date, Heure, Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF NOT CONFIRM('Voulez Vous Supprimer La Ligne Pointage !!', FALSE) THEN
            ERROR('Vous ne Pouvez Pas Supprimer La Ligne !!');
    end;
}

