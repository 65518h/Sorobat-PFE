table 52048917 "Tranche STC"
{
    //GL2024  ID dans Nav 2009 : "39001458"

    LookupPageID = "Tranche STC";

    fields
    {
        field(1; "Plage Min"; Integer)
        {
        }
        field(2; "Plage Max"; Integer)
        {
        }
        field(3; "Taux STC"; Decimal)
        {
        }
        field(4; Decription; Text[50])
        {
        }
        field(5; "Gpe Stat empl"; Code[10])
        {
            TableRelation = "Employee Statistics Group".Code;
        }
    }

    keys
    {
        key(STG_Key1; "Plage Min", "Plage Max", "Taux STC")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var

}

