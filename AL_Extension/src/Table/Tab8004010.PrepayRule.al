Table 8004010 "Prepay Rule"
{
    // //PREPAIE ETP 01/01/99 Table de paramétrage

    Caption = 'Prepay Rule';
    //  DrillDownPageID = 8004010;
    // LookupPageID = 8004010;

    fields
    {
        field(5; Frequency; Option)
        {
            Caption = 'Frequency';
            OptionCaption = 'Detail,Day,Week,Month,Jumping Week';
            OptionMembers = Detail,Day,Week,Month,"Jumping Week";
        }
        field(6; "Min Value"; Decimal)
        {
            Caption = 'Min Value';
            DecimalPlaces = 2 : 2;
        }
        field(7; "Max Value"; Decimal)
        {
            Caption = 'Max Value';
            DecimalPlaces = 2 : 2;
            //GL2024  InitValue = 999"999.99";
        }
        field(8; "Cause of prepay code"; Code[10])
        {
            Caption = 'Cause of prepay Code';
            NotBlank = true;
            TableRelation = "Prepay Reason Code";
        }
        field(9; "Quantity Calculation"; Option)
        {
            Caption = 'Quantity Calculation';
            OptionCaption = 'None,Work Time Qty,Qty,Work Time Qty + Qty,Work Time Qty - Qty,Work Time Qty * Qty,Work Time Qty / Qty';
            OptionMembers = "None","Work Time Qty",Qty,"Work Time Qty + Qty","Work Time Qty - Qty","Work Time Qty * Qty","Work Time Qty / Qty";
        }
        field(10; "Rate Calculation"; Option)
        {
            Caption = 'Rate Calculation';
            OptionCaption = 'None,Work Time Rate,Rate,Res. Rate,TP + T,TP - T,TP * T,TP / T,TR + T,TR - T,TR * T,TR / T,TR + TP,TR - TP,TR * TP,TR / TP';
            OptionMembers = "None","Work Time Rate",Rate,"Res. Rate","TP + T","TP - T","TP * T","TP / T","TR + T","TR - T","TR * T","TR / T","TR + TP","TR - TP","TR * TP","TR / TP";
        }
        field(11; "Amount Calculation"; Option)
        {
            Caption = 'Amount Calculation';
            OptionCaption = 'Calc. Qty * Calc. Rate,(Calc. Qty * Calc. Rate) + Amount,(Calc. Qty * Calc. Rate) - Amount,Work Time Amount,Amount,Work Time Amount + Amount,Work Time Amount - Amount';
            OptionMembers = "Calc. Qty * Calc. Rate","(Calc. Qty * Calc. Rate) + Amount","(Calc. Qty * Calc. Rate) - Amount","Work Time Amount",Amount,"Work Time Amount + Amount","Work Time Amount - Amount";
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 2 : 4;
        }
        field(13; Rate; Decimal)
        {
            Caption = 'Rate';
            DecimalPlaces = 2 : 4;
        }
        field(14; Amount; Decimal)
        {
            Caption = 'Amount';
            DecimalPlaces = 2 : 2;
        }
        field(15; Comment; Text[50])
        {
            Caption = 'Comment';
        }
        field(16; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
        field(20; Regrouping; Boolean)
        {
            Caption = 'Reorder Cycle';
        }
        field(22; "Lowest Value"; Decimal)
        {
            Caption = 'Lowest Value';
            DecimalPlaces = 2 : 2;
        }
        field(24; "Highest value"; Decimal)
        {
            Caption = 'Highest value';
            DecimalPlaces = 2 : 2;
            //GL2024  InitValue = 999"999.99";
        }
        field(31; "Exclusive Minima & Maxima"; Boolean)
        {
            Caption = 'Exclusive Minima & Maxima';
        }
        field(44; "Work Type Filter"; Text[80])
        {
            Caption = 'Work Type Filter';
            TableRelation = "Work Type";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50; "Job Filter"; Text[80])
        {
            Caption = 'Job Filter';
            TableRelation = Job;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(51; "Resource Filter"; Text[80])
        {
            Caption = 'Resource Filter';
            TableRelation = Resource;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(52; "Resource Group Filter"; Text[80])
        {
            Caption = 'Resource Group Filter';
            TableRelation = "Resource Group";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(100; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(101; "Rule Code"; Code[10])
        {
            Caption = 'Rule Code';
        }
    }

    keys
    {
        key(STG_Key1; "Rule Code", "Line No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Cause of prepay code", "Rule Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CodeTemp: Code[10];
        RubTemp: Code[10];
}

