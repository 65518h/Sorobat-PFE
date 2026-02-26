TableExtension 50139 QualificationEXT extends Qualification
{
    fields
    {



        field(50000; "Groupe Qualification"; Code[20])
        {
        }
        field(50001; Prime; Decimal)
        {
        }
        field(50002; Amplitude; Decimal)
        {
        }
        field(50003; "Sans Heure Supp"; Boolean)
        {
        }
        field(50004; Conducteur; Boolean)
        {
        }
        field(39001480; "Collège"; Code[10])
        {
            TableRelation = CATEGORIES.Code;
        }
    }
}

