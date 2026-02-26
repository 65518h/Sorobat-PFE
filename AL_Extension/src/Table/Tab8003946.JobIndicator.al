Table 8003946 "Job Indicator"
{
    // //JOB_INDICATOR CW 01/01/01 New

    Caption = 'Job indicator';

    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                i: Integer;
            begin
            end;
        }
        field(6; "Reporting Date"; Date)
        {
            Caption = 'Reporting Date';
        }
        field(20; "Person Responsible"; Code[20])
        {
            Caption = 'Person Responsible';
            TableRelation = Resource where(Type = const(Person),
                                            Status = const(Internal));
        }
        field(1401; Forecast; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Forecast';
        }
        field(1402; "Posted Net Change"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Posted net change';
        }
        field(1403; Engaged; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Engaged';
        }
        field(1406; "Person Forecast (Qty)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Person Forecast (Qty)';
        }
        field(1407; "Person Posted (Qty)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Person Posted (Qty)';
        }
        field(1408; "Audit Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Audit Forecast';
        }
        field(1409; "Audit Person Forecast (Qty)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Audit Person Forecast (Qty)';
        }
        field(1410; "Bal. Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Posted';
        }
        field(1412; "Posted at Date"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Posted at Date';
        }
        field(3908; "Initial Gross Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Initial Gross Total Cost';
        }
        field(3909; "Posted Overhead Amount"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Forecast Overhead Amount';
        }
        field(3913; "Person Planned (Qty)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Person Planned (Qty)';
        }
        field(3914; "Audit Gross Total Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Audit Gross Total Cost';
        }
        field(3915; "Posted Price"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Posted Price';
        }
        field(3916; "Ordered Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Ordered Invoiced (LCY)';
        }
        field(3917; "Ordered Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Ordered Not Invoiced (LCY)';
        }
        field(4060; "Person Qty"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Person Qty';
        }
        field(4070; "Cost Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Cost Forecast';
        }
        field(4074; "Initial Price Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Initial Price Forecast';
        }
        field(4075; "Audit Price Forecast"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Audit Price Forecast';
        }
        field(4087; "Advanced Budget Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Advanced Forecast Cost';
        }
        field(4088; "Advanced Person Budget (Qty)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Advanced Person Forecast (Qty)';
        }
        field(50000; "Quote Budget Price"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Quote Budget Price';
        }
        field(50001; "Quote Budget Cost"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Quote Budget Cost';
        }
        field(50002; "Posted Payments Excl. VAT"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Posted Pmt Excl. VAT';
        }
        field(50003; "Overdue Incl. VAT"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Delayed Incl. VAT';
        }
        field(50004; "Delayed Pmt (> 3m) Incl. VAT"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Delayed Pmt (> 3m) Incl. VAT';
        }
        field(50005; "Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Remaining Amt. (LCY)';
            FieldClass = Normal;
        }
        field(50006; B; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'B';
        }
        field(50007; C; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'C';
        }
        field(50008; "Reserve Posted"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Reserve Posted';
        }
        field(50009; "Vendor Payments Excl. VAT"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Vendor Pmt Excl. VAT';
        }
        field(50010; "Vendor Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Vendor Remaining Amt. (LCY)';
        }
        field(50061; "Usage Posted to G/L"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Usage Posted to G/L';
        }
        field(50062; "Sale Posted to G/L"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Sale Posted to G/L';
        }
        field(50063; "Usage Recognized"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Usage Recognized';
        }
        field(50064; "Sales Recognized"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Sales Postrd to G/L';
        }
        field(50065; Activity; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Activity';
        }
        field(50066; "Usage to Recognize"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Usage to Recognize';
        }
        field(50067; "Official Order Margin"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Off. Order Margin';
        }
        field(50068; "Open Sales Margin"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Open Sales Margin';
        }
        field(50069; "WIP Margin"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'WIP Margin';
        }
        field(50070; "Loss at Date"; Decimal)
        {
            AutoFormatType = 1;
            //blankzero = true;
            Caption = 'Loss at Date';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8003901; "Last Audit Date"; Date)
        {
            Caption = 'Last Audit Date';
        }
        field(8003986; "Job Status"; Code[10])
        {
            Caption = 'Status Code';
            TableRelation = "Job Status";
        }
    }

    keys
    {
        key(Key1; "Job No.", "Reporting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

