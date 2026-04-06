table 52048944 "Baréme De Charge"
{ //GL2024  ID dans Nav 2009 : "39001418"
    Caption = 'Baréme De Charge';

    DrillDownPageID = "Baréme De Charge";
    LookupPageID = "Baréme De Charge";

    fields
    {
        field(1; "Nombre De Charge"; Integer)
        {
            Caption = 'Code';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Date fomula"; DateFormula)
        {
            Caption = 'Date fomula';
        }
        field(50000; "% Abattement"; Decimal)
        {
            DecimalPlaces = 0 : 1;
        }
        field(8099198; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
    }

    keys
    {
        key(STG_Key1; "Nombre De Charge")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

