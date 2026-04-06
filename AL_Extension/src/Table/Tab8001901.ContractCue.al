Table 8001901 "Contract Cue"
{
    Caption = 'Contract Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Sales Contracts"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Subscription)));
            Caption = 'Sales Contracts';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Purchase contract"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Subscription)));
            Caption = 'Purchase contract';
            FieldClass = FlowField;
        }
        field(4; "Sales Contracts - Open"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = filter(Subscription),
                                                      Status = const(Open)));
            Caption = 'Sales Contracts - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Purchase contract - Open"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Subscription),
                                                         Status = const(Open)));
            Caption = 'Purchase contract - Open';
            FieldClass = FlowField;
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Date Filter2"; Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(22; "User ID Filter"; Code[20])
        {
            Caption = 'User ID Filter';
            Editable = false;
            FieldClass = FlowFilter;
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

