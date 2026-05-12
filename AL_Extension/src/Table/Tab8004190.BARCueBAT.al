Table 8004190 "BAR Cue BAT"
{

    fields
    {
        field(1; "Key"; Code[10])
        {
            Caption = 'Key';
        }
        field(2; "Purchase Quote Open"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Quote),
                                                         Status = const(Open),
                                                         "Attached to Doc. No." = filter(''),
                                                         "Job No." = field("No. Job Filter")));
            Caption = 'Purchase Quote  Open';
            FieldClass = FlowField;
        }
        field(3; "Purchase Order"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order),
                                                         "Job No." = field("No. Job Filter")));
            Caption = 'Purchase Order';
            FieldClass = FlowField;
        }
        field(4; "Purchase Contract Expired"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Subscription),
                                                         "Job No." = field("No. Job Filter")));
            Caption = 'Purchase Contract Expired';
            FieldClass = FlowField;
        }
        field(5; "Purchase Invoice"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const(Invoice),
                                                         "Job No." = field("No. Job Filter")));
            Caption = 'Purchase Invoice';
            FieldClass = FlowField;
        }
        field(6; "Purchase Credit Memo"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = const("Credit Memo"),
                                                         "Job No." = field("No. Job Filter")));
            Caption = 'Purchase Credit Memo';
            FieldClass = FlowField;
        }
        field(7; "Sales Quote Open"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Quote),
                                                      Status = const(Open),
                                                      "Job No." = field("No. Job Filter")));
            Caption = 'Sales Quote Open';
            FieldClass = FlowField;
        }
        field(8; "Sales Order"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Order Type" = filter(" "),
                                                      "Job No." = field("No. Job Filter")));
            Caption = 'Sales Order';
            FieldClass = FlowField;
        }
        field(9; "Sales Contract Exired"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Subscription),
                                                      "Job No." = field("No. Job Filter")));
            Caption = 'Sales Contract Exired';
            FieldClass = FlowField;
        }
        field(10; "Sales Invoice"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Invoice),
                                                      "Job No." = field("No. Job Filter")));
            Caption = 'Sales Invoice';
            FieldClass = FlowField;
        }
        field(11; "Sales Credit Memo"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const("Credit Memo"),
                                                      "Job No." = field("No. Job Filter")));
            Caption = 'Sales Credit Memo';
            FieldClass = FlowField;
        }
        field(12; "Reordering Requisition"; Integer)
        {
            CalcFormula = count("Sales Header" where("Document Type" = const(Order),
                                                      "Order Type" = const("Supply Order"),
                                                      "Job No." = field("No. Job Filter")));
            Caption = 'Reordering Requisition';
            FieldClass = FlowField;
        }
        field(99; "Date Filter"; Date)
        {
            Caption = 'Date filter';
            FieldClass = FlowFilter;
        }
        field(100; "No. Job Filter"; Code[20])
        {
            Caption = 'No. Job Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(STG_Key1; "Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

