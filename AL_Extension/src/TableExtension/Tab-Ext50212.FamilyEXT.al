TableExtension 50212 FamilyEXT extends Family
{
    fields
    {
        field(50000; "Sans Consommation"; Boolean)
        {
        }
        field(50001; "Heure Travail Par Jour"; Decimal)
        {
        }
        field(50002; Carriere; Boolean)
        {
        }
        field(50003; Centrale; code[20])
        {
            TableRelation = Location;
        }
    }
}

