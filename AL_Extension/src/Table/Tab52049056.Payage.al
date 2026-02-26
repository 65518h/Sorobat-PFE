table 52049056 "Payéage"
{ //GL2024  ID dans Nav 2009 : "39004721"
    DrillDownPageID = "Param Payéage";
    LookupPageID = "Param Payéage";

    fields
    {
        field(1; Type; Option)
        {
            OptionCaption = ' ,Autoroute,Payéage';
            OptionMembers = " ",Autoroute,"Payéage";
        }
        field(2; "Code"; Code[20])
        {
        }
        field(3; Designation; Text[30])
        {
        }
        field(4; "Coût"; Decimal)
        {
            DecimalPlaces = 0 : 3;
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

