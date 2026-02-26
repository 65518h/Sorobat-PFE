Table 8001524 "Statistic category"
{
    //GL2024  ID dans Nav 2009 : "8001318"
    // //STATSEXPLORER STATSEXPLORER 01/10/10 Statistic category

    Caption = 'Statistic category';
    //LookupPageID = 8001315;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Number of statistics"; Integer)
        {
            //blankzero = true;
            CalcFormula = count("Standard statistic" where(Category = field(Code)));
            Caption = 'Number of statistics';
            Editable = false;
            FieldClass = FlowField;
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

    var
        Colonne: Record "Statistic column";
        FiltreColonne: Record "Statistic column filter";
}

