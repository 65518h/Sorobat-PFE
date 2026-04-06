table 50012 "Autorisation Etapes2"
{
    //  // << HJ DSFT 21-01-2009: Gestion des Utilisateurs

    LookupPageID = "Autorisation Etapes";

    fields
    {
        field(1; Etape; Integer)
        {
        }
        field(2; User; Code[30])
        {
            TableRelation = "User Setup";
        }
        field(3; "Type Reglement"; Text[30])
        {
        }
        field(4; "Nom Etapes"; Text[50])
        {
            CalcFormula = Lookup("Payment Step".Name WHERE("Payment Class" = FIELD("Type Reglement"),
                                                            Line = FIELD(Etape)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; Etape, "Type Reglement", User)
        {
            Clustered = true;
        }
        key(STG_Key2; User)
        {
        }
    }

    fieldgroups
    {
    }
}

