Table 8004011 "Prepay Buffer"
{
    // //PREPAIE ETP 01/01/99 Table de calculs temporaires
    //           CW  06/03/00 N° document passé de code10 à code20

    Caption = 'Prepay Buffer';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(11; "Unit Direct Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            DecimalPlaces = 2 : 5;
        }
        field(12; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(16; "Group Resource No."; Code[20])
        {
            Caption = 'Resource Group No.';
            Editable = false;
            TableRelation = "Resource Group";
        }
        field(17; "Unit Code"; Text[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(55; Frequency; Option)
        {
            Caption = 'Frequency';
            OptionCaption = 'Detail,Day,Week,Month,Jumping Week';
            OptionMembers = Detail,Day,Week,Month,"Jumping Week";
        }
        field(56; "Min Value"; Decimal)
        {
            Caption = 'Min Value';
            DecimalPlaces = 2 : 2;
        }
        field(57; "Max Value"; Decimal)
        {
            Caption = 'Max Value';
            DecimalPlaces = 2 : 2;
            //GL2024 InitValue = 999"999.99";
        }
        field(58; "Absence Cause Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            NotBlank = true;
            Numeric = true;
            TableRelation = "Cause of Absence";
        }
        field(59; "Quantity Calculation"; Option)
        {
            Caption = 'Quantity Calculation';
            OptionCaption = 'None,Work Time Qty,Qty,Work Time Qty + Qty,Work Time Qty - Qty,Work Time Qty * Qty,Work Time Qty / Qty';
            OptionMembers = "None","Work Time Qty",Qty,"Work Time Qty + Qty","Work Time Qty - Qty","Work Time Qty * Qty","Work Time Qty / Qty";
        }
        field(60; "Rate Calculation"; Option)
        {
            Caption = 'Rate Calculation';
            OptionCaption = 'None,Work Time Rate,Rate,Res. Rate,TP + T,TP - T,TP * T,TP / T,TR + T,TR - T,TR * T,TR / T,TR + TP,TR - TP,TR * TP,TR / TP';
            OptionMembers = "None","Work Time Rate",Rate,"Res. Rate","TP + T","TP - T","TP * T","TP / T","TR + T","TR - T","TR * T","TR / T","TR + TP","TR - TP","TR * TP","TR / TP";
        }
        field(61; "Amount Calculation"; Option)
        {
            Caption = 'Amount Calculation';
            OptionCaption = 'Calc. Qty * Calc. Rate,(Calc. Qty * Calc. Rate) + Amount,(Calc. Qty * Calc. Rate) - Amount,Work Time Amount,Amount,Work Time Amount + Amount,Work Time Amount - Amount';
            OptionMembers = "Calc. Qty * Calc. Rate","(Calc. Qty * Calc. Rate) + Amount","(Calc. Qty * Calc. Rate) - Amount","Work Time Amount",Amount,"Work Time Amount + Amount","Work Time Amount - Amount";
        }
        field(62; "Quantity Setup"; Decimal)
        {
            Caption = 'Quantity Setup';
            DecimalPlaces = 2 : 4;
        }
        field(63; "Rate Setup"; Decimal)
        {
            Caption = 'Rate Setup';
            DecimalPlaces = 2 : 4;
        }
        field(64; "Amount Setup"; Decimal)
        {
            Caption = 'Amount Setup';
            DecimalPlaces = 2 : 2;
        }
        field(65; Comment; Text[50])
        {
            Caption = 'Comment';
        }
        field(66; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(67; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(68; "Detail Key"; Integer)
        {
            Caption = 'Detail Key';
        }
        field(70; Regrouping; Boolean)
        {
            Caption = 'Reorder Cycle';
        }
        field(72; "Highest value"; Decimal)
        {
            Caption = 'Highest value';
            DecimalPlaces = 2 : 2;
        }
        field(73; "Lowest Value"; Decimal)
        {
            Caption = 'Lowest Value';
            DecimalPlaces = 2 : 2;
            //GL2024  InitValue = 999 "999.99";
        }
        field(74; "Exclusive Min and Max"; Boolean)
        {
            Caption = 'Exclusive Min and Max';
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
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Resource No.", "Job No.", "Absence Cause Code", Frequency, "Min Value", "Max Value", "Starting Date", "End Date", "Detail Key")
        {
        }
    }

    fieldgroups
    {
    }
}

