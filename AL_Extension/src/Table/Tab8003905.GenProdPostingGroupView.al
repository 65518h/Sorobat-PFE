Table 8003905 "Gen. Prod. Posting Group View"
{
    // //PROJET_PHASE GESWAY 19/06/02 Paramétrage des colonnes des natures

    Caption = 'Gen. Prod. Posting Group View';
    // DrillDownPageID = 8003950;
    //LookupPageID = 8003950;

    fields
    {
        field(1; "View Code"; Code[10])
        {
            Caption = 'View Code';
        }
        field(3; "Gen. Prod. Post. Group code"; Boolean)
        {
            Caption = 'Code';
        }
        field(4; Description; Boolean)
        {
            Caption = 'Description';
        }
        field(5; "Marked Only"; Boolean)
        {
            Caption = 'Marked Only';
        }
        field(6; "Initial Forecast Price"; Boolean)
        {
            Caption = 'Budgeted Price';
        }
        field(7; "Posted Price"; Boolean)
        {
            Caption = 'Invoiced Price';
        }
        field(9; "% Posted / Forecast"; Boolean)
        {
            Caption = '% Posted / Forecast';
        }
        field(10; "Forecast Cost"; Boolean)
        {
            Caption = 'Forecast Cost';
        }
        field(11; "Posted Cost"; Boolean)
        {
            Caption = 'Posted Cost';
        }
        field(12; "Engaged Cost"; Boolean)
        {
            Caption = 'Engaged Cost';
        }
        field(13; "Person Forecast Quantity"; Boolean)
        {
            Caption = 'Person For. (Qty)';
        }
        field(14; "Person Posted Quantity"; Boolean)
        {
            Caption = 'Person Post. (Qty)';
        }
        field(30; "Quantity to be Done"; Boolean)
        {
            Caption = 'Quantity to be Done';
        }
        field(33; "% Person.Qty Posted / Forecast"; Boolean)
        {
            Caption = '% Person.Qty Posted / Forecast';
        }
        field(34; "View Description"; Text[30])
        {
            Caption = 'View Description';
        }
        field(35; "Person Planned Quantity"; Boolean)
        {
            Caption = 'Planned Quantity';
        }
        field(38; "Level Indent"; Integer)
        {
            //blankzero = true;
            Caption = 'Indentation Level';
            InitValue = 1;
        }
        field(40; "Initial Overhead Amount"; Boolean)
        {
            Caption = 'Gen. Expenses Amount';
        }
        field(49; "Audit Forecast Cost"; Boolean)
        {
            Caption = 'Audit Budget';
        }
        field(50; "Audit Person Forecast Quantity"; Boolean)
        {
            Caption = 'Work Audit Budget (Qty)';
        }
        field(125; "Amount 1"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(1, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 1';
        }
        field(126; "Amount 2"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(2, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 2';
        }
        field(127; "Amount 3"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(3, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 3';
        }
        field(128; "Amount 4"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(4, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 4';
        }
        field(129; "Amount 5"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(5, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 5';
        }
        field(130; "Amount 6"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(6, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 6';
        }
        field(131; "Amount 7"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(7, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 7';
        }
        field(132; "Amount 8"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(8, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 8';
        }
        field(133; "Amount 9"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(9, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 9';
        }
        field(134; "Amount 10"; Boolean)
        {
            //CaptionClass = wCalcAmount.AmountGetCaptionClass(10, DATABASE::"Gen. Product Posting Group");
            Caption = 'Amount 10';
        }
        field(136; Margin; Boolean)
        {
            Caption = 'Profit';
        }
        field(137; "Initial Forecast Margin"; Boolean)
        {
            Caption = 'Initial Forecast Margin';
        }
        field(138; "Initial Gross Total Cost"; Boolean)
        {
            //blankzero = true;
            Caption = 'Initial Gross Total Cost';
        }
        field(139; "Audit Gross Total Cost"; Boolean)
        {
            //blankzero = true;
            Caption = 'Audit Gross Total Cost';
        }
        field(140; "Audit Forecast Margin"; Boolean)
        {
            Caption = 'Audit Forecast Margin';
        }
        field(141; "Audit Forecast Price"; Boolean)
        {
            Caption = 'Audit Forecast Price';
        }
        field(142; "Audit Overhead Amount"; Boolean)
        {
            Caption = 'Audit Overhead Amount';
        }
        field(8001410; "Bal. Amount"; Boolean)
        {
            //blankzero = true;
            Caption = 'Bal. Amount';
        }
        field(8001412; "Posted at Date"; Boolean)
        {
            //blankzero = true;
            Caption = 'Posted at Date';
        }
        field(8003909; "Posted Overhead Amount"; Boolean)
        {
            //blankzero = true;
            Caption = 'Forecast Overhead Amount';
        }
        field(8004048; "Prepayment Amount"; Boolean)
        {
            Caption = 'Prepmt. Line Amount';
        }
        field(8004049; "Prepmt. Amt. Inv."; Boolean)
        {
            Caption = 'Prepmt. Amt. Inv.';
        }
        field(8004050; "Prepmt. Amount to Inv."; Boolean)
        {
            Caption = 'Prepmt. Amount to Inv.';
        }
        field(8004068; "New Cost Forecast"; Boolean)
        {
            Caption = 'New Budget';
        }
        field(8004069; "New Rest to be Done"; Boolean)
        {
            Caption = 'New Rest to be Done';
        }
        field(8004070; "Cost Forecast"; Boolean)
        {
            Caption = 'Cost Forecast';
        }
        field(8004073; "New Budget Difference"; Boolean)
        {
            Caption = 'New Budget Difference';
        }
        field(8004087; "Advanced Budget Cost"; Boolean)
        {
            Caption = 'Advanced Budget Cost';
        }
        field(8004088; "Advanced Person Budget (Qty)"; Boolean)
        {
            Caption = 'Advanced Person Budget (Qty)';
        }
        field(8004089; "Ordered Invoiced (LCY)"; Boolean)
        {
            Caption = 'Ordered Invoiced (LCY)';
        }
        field(8004090; "Ordered Not Invoiced (LCY)"; Boolean)
        {
            Caption = 'Ordered Not Invoiced (LCY)';
        }
        field(8004091; "Plan Quantity (unrealized)"; Boolean)
        {
            Caption = 'Plan Quantity (unrealized)';
        }
        field(8004092; "Amt. Rcd. Not Invoiced (LCY)"; Boolean)
        {
            Caption = 'Received Not Invoiced (LCY)';
        }
        field(8004093; "Amt. Ordered Not Received"; Boolean)
        {
            Caption = 'Ordered Not Received (LCY)';
        }
    }

    keys
    {
        key(Key1; "View Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'Amount';
    //  wCalcAmount: Codeunit "Calc. Amount Management";

    local procedure wAmountGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lSetupFormula: Record "Setup Formula Amount";
    begin
        if not lSetupFormula.Get(Database::"Gen. Prod. Posting Group View", FieldNumber) then
            lSetupFormula.Init;
        if lSetupFormula.Description = '' then
            lSetupFormula.Description := Text001 + ' ' + Format(FieldNumber);
        exit('8004050,' + lSetupFormula.Description);
    end;
}

