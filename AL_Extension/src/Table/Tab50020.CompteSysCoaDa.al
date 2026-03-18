table 50020 "Compte SysCoaDa"
{
    DrillDownPageID = "Compte SysCoaDa";
    LookupPageID = "Compte SysCoaDa";

    fields
    {
        field(1; "N° Compte"; Code[20])
        {
        }
        field(2; Designation; Text[50])
        {
        }
    }

    keys
    {
        key(STG_Key1; "N° Compte")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

