Table 8003954 "Gen. Prod. Posting Gp Buffer"
{
    // //PROJET_NATURE CLA 22/06/04 Nouvelle table temporaire pour F9 du tableau de bord

    Caption = 'Gen. Product Posting Group Buffer';
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
            BlankNumbers = BlankZero;
            //blankzero = true;
            Caption = 'Forecast';
            DecimalPlaces = 0 : 0;
            FieldClass = Normal;
        }
        field(8001402; Posted; Decimal)
        {
            //blankzero = true;
            Caption = 'Completed';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8001403; Engaged; Decimal)
        {
            //blankzero = true;
            Caption = 'Engaged';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8001406; "Person Forecast (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Forecast (Qty)';
        }
        field(8001407; "Person Posted (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Posted (Qty)';
            Editable = false;
        }
        field(8001408; "Audit Forecast"; Decimal)
        {
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
            //blankzero = true;
            Caption = 'Bal. Amount';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003901; Summarize; Boolean)
        {
            Caption = 'Total';
        }
        field(8003903; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(8003908; "Initial Gross Total Cost"; Decimal)
        {
            //blankzero = true;
            Caption = 'Initial Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003909; "Posted Overhead Amount"; Decimal)
        {
            //blankzero = true;
            Caption = 'Posted Overhead Amount';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003913; "Person Planned (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Planned (Qty)';
        }
        field(8003914; "Audit Gross Total Cost"; Decimal)
        {
            //blankzero = true;
            Caption = 'Audit Gross Total Cost';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8003915; "Posted Price"; Decimal)
        {
            //blankzero = true;
            Caption = 'Posted Price';
            Editable = false;
        }
        field(8003916; "Ordered Invoiced (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Ordered Invoiced (LCY)';
            Editable = false;
        }
        field(8003917; "Ordered Not Invoiced (LCY)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Ordered Not Invoiced (LCY)';
            Editable = false;
        }
        field(8004053; "Direct Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Direct Cost';
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
        field(8004060; "Person Qty"; Decimal)
        {
            //blankzero = true;
            Caption = 'Person Qty';
            DecimalPlaces = 0 : 2;
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
        }
        field(8004070; "Cost Forecast"; Decimal)
        {
            //blankzero = true;
            Caption = 'Cost Forecast';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(8004071; "Profit Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Profit Amount';
            Editable = false;
        }
        field(8004074; "Initial Price Forecast"; Decimal)
        {
            //blankzero = true;
            Caption = 'Initial Price Forecast';
            DecimalPlaces = 0 : 0;
        }
        field(8004075; "Audit Price Forecast"; Decimal)
        {
            //blankzero = true;
            Caption = 'Audit Price Forecast';
            DecimalPlaces = 0 : 0;
        }
        field(8004087; "Advanced Forecast Cost"; Decimal)
        {
            //blankzero = true;
            Caption = 'Advanced Forecast Cost';
            DecimalPlaces = 0 : 0;
        }
        field(8004088; "Advanced Person Forecast (Qty)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Advanced Person Forecast (Qty)';
            DecimalPlaces = 0 : 0;
        }
        field(8005000; "Cost difference"; Decimal)
        {
            //blankzero = true;
            Caption = '% Posted / Forecast';
        }
        field(8005001; "Person difference"; Decimal)
        {
            //blankzero = true;
            Caption = '% Person.Qty Posted / Forecast';
        }
        field(8005002; Margin; Decimal)
        {
            //blankzero = true;
            Caption = 'Profit';
        }
        field(8005003; "Initial margin"; Decimal)
        {
            //blankzero = true;
            Caption = 'Initial Forecast Margin';
        }
        field(8005004; "Audit margin"; Decimal)
        {
            //blankzero = true;
            Caption = 'Audit Forecast Margin';
        }
        field(8005005; "Initial overhead"; Decimal)
        {
            //blankzero = true;
            Caption = 'Initial Forecast Overhead Amount';
        }
        field(8005006; "Audit overhead"; Decimal)
        {
            //blankzero = true;
            Caption = 'Audit Forecast Overhead Amount';
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
}

