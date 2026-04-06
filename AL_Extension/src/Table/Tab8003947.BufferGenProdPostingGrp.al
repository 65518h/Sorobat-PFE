Table 8003947 "Buffer Gen. Prod. Posting Grp"
{
    // //PROJET_NATURE CLA 24/06/05 Nouvelle table pour affichage F9 devis

    Caption = 'Buffer Gen. Prod. Posting Grp';
    DataCaptionFields = "Code", Description;
    LookupPageID = "Gen. Product Posting Groups";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8001401; Forecast; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Forecast';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8001402; Posted; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Completed';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8001403; Engaged; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Engaged';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8001406; "Person Forecast (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Forecast (Qty)';
            Editable = false;
        }
        field(8001407; "Person Posted (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Posted (Qty)';
            Editable = false;
        }
        field(8001408; "Audit Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Audit Forecast';
            DecimalPlaces = 0 : 0;
        }
        field(8001409; "Audit Person Forecast (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Audit Person Forecast (Qty)';
        }
        field(8001410; "Bal. Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Posted';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003908; "Initial Gross Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Initial Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003909; "Posted Overhead Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Forecast Overhead Amount';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003913; "Person Planned (Qty)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Person Planned (Qty)';
        }
        field(8003914; "Audit Gross Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Audit Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003915; "Posted Price"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Posted Price';
            Editable = false;
        }
        field(8003916; "Ordered Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Ordered Invoiced (LCY)';
            Editable = false;
        }
        field(8003917; "Ordered Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Ordered Not Invoiced (LCY)';
            Editable = false;
        }
        field(8004052; "Direct Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Direct Cost';
            Editable = false;
        }
        field(8004053; "Total Direct Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Total Direct Cost';
            Editable = false;
        }
        field(8004054; Overhead; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Overhead';
            Editable = false;
        }
        field(8004055; "Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Total Amount';
            Editable = false;
        }
        field(8004056; "Job Costs"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Job Costs';
            Editable = false;
        }
        field(8004057; "Overhead Rate"; Decimal)
        {
            //blankzero = true;
            Caption = 'Overhead Rate';
            DecimalPlaces = 0 : 3;
        }
        field(8004058; "Margin Rate"; Decimal)
        {
            //blankzero = true;
            Caption = 'Margin Rate';
            DecimalPlaces = 0 : 3;
        }
        field(8004059; "Person Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            //blankzero = true;
            Caption = 'Person Unit Cost';
            Editable = false;
        }
        field(8004060; "Person Qty"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Qty';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(8004061; "Direct Cost Archive"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Direct Cost Archive';
            Editable = false;
        }
        field(8004062; "Overhead Archive"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Overhead Archive';
            Editable = false;
        }
        field(8004063; "Total Amount Archive"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Total Amount Archive';
            Editable = false;
        }
        field(8004064; "Job Costs Archive"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Job Costs Archive';
            Editable = false;
        }
        field(8004065; "Person Qty Archive"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Qty Archive';
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(8004068; "Rest To Be Done"; Decimal)
        {
            //blankzero = true;
            Caption = 'Rest To Be Done';
        }
        field(8004069; "Rest To Be Done %"; Decimal)
        {
            //blankzero = true;
            Caption = 'Rest To Be Done %';
        }
        field(8004070; "Cost Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Cost Forecast';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8004071; "Theoretical Profit Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Theoretical Profit Amount';
            Editable = false;
        }
        field(8004073; "Previous Rest To Be Done"; Decimal)
        {
            //blankzero = true;
            Caption = 'Previous Rest To Be Done';
        }
        field(8004074; "Initial Price Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Initial Price Forecast';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8004075; "Audit Price Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Audit Price Forecast';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8004082; "Real Rate"; Decimal)
        {
        }
        field(8004083; "Rule Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rule Rate';
        }
        field(8004084; "Rule Margin Rate"; Decimal)
        {
            Caption = 'Margin Rule Rate';
        }
        field(8004085; "Overhead Calculation Method"; Option)
        {
            Caption = 'Overhead Calculation Method';
            OptionCaption = 'Amount %,Person Quantity';
            OptionMembers = "Amount %","Person Quantity";
        }
        field(8004086; "Margin Calculation Method"; Option)
        {
            Caption = 'Margin Calculation Method';
            OptionCaption = 'Amount %,Quantity';
            OptionMembers = "Amount %",Quantity;
        }
        field(8004087; "Advanced Budget Cost"; Decimal)
        {
            //blankzero = true;
            Caption = 'Advanced Forecast Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8004088; "Advanced Person Budget (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Advanced Person Forecast (Qty)';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8004089; "Relative Rate"; Decimal)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: label 'Change all occurrences of %1 in %2\where %3 is %4\and %1 is %5.';
}

