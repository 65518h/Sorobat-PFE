TableExtension 50147 "Employee Statistics GroupEXT" extends "Employee Statistics Group"
{

    fields
    {
        field(50000; Departement; Code[20])
        {
        }
        field(50001; Service; Code[20])
        {
        }
        field(50002; Section; Code[20])
        {
        }
        field(50003; Type; Option)
        {
            OptionMembers = " ",Departement,Service,Section;
        }
        field(50004; Montant; Decimal)
        {
        }
        field(50005; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            ValidateTableRelation = false;
        }
        field(50006; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            ValidateTableRelation = false;
        }
    }
}

