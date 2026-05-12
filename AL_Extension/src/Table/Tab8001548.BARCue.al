Table 8001548 "BAR Cue"
{
    //GL2024  ID dans Nav 2009 : "8001616"
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Bank Statement Number"; Integer)
        {
            CalcFormula = count("Bank Acc. Reconciliation");
            Caption = 'Bank Statement Number';
            FieldClass = FlowField;
        }
        field(3; "Stock Header Number"; Integer)
        {
            CalcFormula = count("Stock Header" where("Number of Shares" = filter(<> 0)));
            Caption = 'Stock Header Number';
            FieldClass = FlowField;
        }
        field(4; "Stock Line Number"; Integer)
        {
            CalcFormula = count("Stock Line");
            Caption = 'Stock Number';
            FieldClass = FlowField;
        }
        field(5; "Open Stock Line"; Integer)
        {
            CalcFormula = count("Stock Line" where(Open = const(true)));
            Caption = 'Open Stock Number';
            FieldClass = FlowField;
        }
        field(6; "Posted Stock Line"; Integer)
        {
            CalcFormula = count("Stock Line" where(Posted = const(true)));
            Caption = 'Posted Stock Number';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(STG_Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

