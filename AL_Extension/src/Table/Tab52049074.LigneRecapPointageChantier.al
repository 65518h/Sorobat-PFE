Table 52049074 "Ligne Recap Pointage Chantier"
{
   // LookupPageID = "Liste Pointage Employée";
    //GL2024  ID dans Nav 2009 : "39001536"
    fields
    {
        field(1; "N°"; Code[20])
        {

        }
        field(2; "Chantier"; Text[150])
        {
        }
        field(3; "Total Effectif"; Integer)
        {

        }
        field(4; "Total Present"; Integer)
        {

        }
        field(5; "Taux Present"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(6; "Total Absent Justifie"; Integer)
        {

        }
        field(7; "Taux Absent Justifié"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(8; "Total Absence"; Integer)
        {

        }
        field(9; "Taux Absence"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; "N°", "Chantier")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


}

