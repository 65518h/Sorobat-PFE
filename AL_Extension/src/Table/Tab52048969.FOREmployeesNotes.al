table 52048969 "FOR-Employees Notes"
{
    //GL2024  ID dans Nav 2009 : "39001476"
    Caption = 'Notes Salariés';
    //  DrillDownPageID = 70093;
    // LookupPageID = 70093;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'N° Salarié';
            TableRelation = Employee;
        }
        field(2; Year; Integer)
        {
            Caption = 'Année';
        }
        field(3; Quarter; Integer)
        {
            Caption = 'Trimestre';
        }
        field(4; Month; Integer)
        {
            Caption = 'Mois';
        }
        field(5; "Code Note"; Code[20])
        {
            //TableRelation = Table70047;
        }
        field(6; Note; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Code Note", Year, Quarter, Month)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

