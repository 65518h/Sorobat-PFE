table 59994 "Entete Gestion Roles"
{


    // DrillDownPageID = "Liste Roles";
    //  LookupPageID = "Liste Roles";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Libelle; Text[200])
        {
        }
        field(3; Ordre; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Ordre)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        RecLigneGestionRoles.SETRANGE(Code, Code);
        RecLigneGestionRoles.DELETEALL;
    end;

    var
        RecLigneGestionRoles: Record 59995;
}

