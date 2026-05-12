Table 8003952 "Job Dashboard View"
{
    // //PROJET_DETAIL GESWAY 16/08/02 Paramétrage de colonne de projet détail

    Caption = 'Jobs Dashboard View';
    //DrillDownPageID = 8003963;
    //LookupPageID = 8003963;

    fields
    {
        field(1; "View Code"; Code[10])
        {
            Caption = 'View Code';
        }
        field(2; "Job No."; Boolean)
        {
            Caption = 'Job No.';
        }
        field(3; Status; Boolean)
        {
            Caption = 'Status';
        }
        field(4; Description; Boolean)
        {
            Caption = 'Description';
        }
        field(5; Comment; Boolean)
        {
            Caption = 'Comment';
        }
        field(6; "Person Responsible"; Boolean)
        {
            Caption = 'Person Responsible';
        }
        field(7; "Contract (Invoiced Price)"; Boolean)
        {
            Caption = 'Contract (Invoiced Price)';
        }
        field(8; "Starting Date"; Boolean)
        {
            Caption = 'Starting Date';
        }
        field(9; "Ending Date"; Boolean)
        {
            Caption = 'Ending Date';
        }
        field(10; "Schedule (Total Cost)"; Boolean)
        {
            Caption = 'Schedule (Total Cost)';
        }
        field(11; "Usage (Total Cost)"; Boolean)
        {
            Caption = 'Usage (Total Cost)';
        }
        field(12; "Engaged Cost 2"; Boolean)
        {
            Caption = 'Engaged Cost 2';
        }
        field(20; "Bill-to Customer No."; Boolean)
        {
            Caption = 'Bill-to Customer No.';

            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
            end;
        }
        field(34; "View Description"; Text[30])
        {
            Caption = 'View Description';
        }
        field(40; "Progress Degree"; Boolean)
        {
            Caption = 'Progress Degree';
        }
        field(41; "Job Type"; Boolean)
        {
            Caption = 'Job Type';
        }
        field(8003900; "Number of Rows"; Integer)
        {
            Caption = 'Number of Rows';
        }
        field(8003908; "Initial Gross Total Cost"; Boolean)
        {
            Caption = 'Initial Gross Total Cost';
        }
        field(8003992; "Forecast Cost"; Boolean)
        {
            Caption = 'Forecast Cost';
        }
        field(8003994; "Person Forecast Quantity"; Boolean)
        {
            Caption = 'Person Forecast Quantity';
        }
        field(8003995; "Person Posted Quantity"; Boolean)
        {
            Caption = 'Person Posted Quantity';
        }
        field(8003996; "Quantity Planned"; Boolean)
        {
            Caption = 'Quantity Planned';
        }
        field(8003997; "Amount Planned"; Boolean)
        {
            Caption = 'Amount Planned';
        }
        field(8004003; "Audit Person Forecast Quantity"; Boolean)
        {
            Caption = 'Audit Person Forecast Quantity';
        }
        field(8004074; "Initial Price Forecast"; Boolean)
        {
            Caption = 'Initial Price Forecast';
        }
        field(8005000; "Amount 1"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(1);
            Caption = 'Amount 1';
        }
        field(8005001; "Amount 2"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(2);
            Caption = 'Amount 2';
        }
        field(8005002; "Amount 3"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(3);
            Caption = 'Amount 3';
        }
        field(8005003; "Amount 4"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(4);
            Caption = 'Amount 4';
        }
        field(8005004; "Amount 5"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(5);
            Caption = 'Amount 5';
        }
        field(8005005; "Amount 6"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(6);
            Caption = 'Amount 6';
        }
        field(8005006; "Amount 7"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(7);
            Caption = 'Amount 7';
        }
        field(8005007; "Amount 8"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(8);
            Caption = 'Amount 8';
        }
        field(8005008; "Amount 9"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(9);
            Caption = 'Amount 9';
        }
        field(8005009; "Amount 10"; Boolean)
        {
            //CaptionClass = wAmountGetCaptionClass(10);
            Caption = 'Amount 10';
        }
        field(8005010; "Initial Forecast Margin"; Boolean)
        {
            Caption = 'Initial Forecast Margin';
        }
        field(8005011; "Initial Forecast Margin %"; Boolean)
        {
            Caption = 'Initial Forecast Margin %';
        }
        field(8005012; "Initial Margin Coef."; Boolean)
        {
            Caption = 'Initial Margin Coef.';
        }
    }

    keys
    {
        key(STG_Key1; "View Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'Amount';

    local procedure wAmountGetCaptionClass(FieldNumber: Integer): Text[80]
    var
        lSetupFormula: Record "Setup Formula Amount";
    begin
        if not lSetupFormula.Get(Database::Job, FieldNumber) then
            lSetupFormula.Init;
        if lSetupFormula.Description = '' then
            lSetupFormula.Description := Text001 + ' ' + Format(FieldNumber);
        exit('8004050,' + lSetupFormula.Description);
    end;
}

