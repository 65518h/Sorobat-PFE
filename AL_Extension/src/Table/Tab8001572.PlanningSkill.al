Table 8001572 "Planning Skill"
{
    //GL2024  ID dans Nav 2009 : "8035001"
    // //AFF PLAN PLANNINGFORCE OFE 12/06/09

    Caption = 'Planning Skill';
    // LookupPageID = 8035001;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Tree Code"; Code[20])
        {
            Caption = 'Tree Code';
            TableRelation = Tree.Code where(Type = const(Skill));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

