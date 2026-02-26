Table 52048904 "Employee Posting Group2"
{//GL2024  ID dans Nav 2009 : "39001432"
    Caption = 'Employee Posting Group';
    DrillDownPageID = "Empl. Posting Group";
    LookupPageID = "Empl. Posting Group";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
            NotBlank = true;

        }
        field(2; "Salaire Net"; Text[20])
        {
            Caption = 'Payables Account';
            TableRelation = "G/L Account";
        }
        field(7; "Service Charge Acc."; Text[20])
        {
            Caption = 'Service Charge Acc.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Service Charge Acc.", true, true);
            end;
        }
        field(8; "Payment Disc. Acc."; Text[20])
        {
            Caption = 'Payment Disc. Acc.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Payment Disc. Acc.", false, false);
            end;
        }
        field(9; "Invoice Rounding Account"; Text[20])
        {
            Caption = 'Invoice Rounding Account';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Invoice Rounding Account", true, false);
            end;
        }
        field(10; "Debit Curr. Appln. Rndg. Acc."; Text[20])
        {
            Caption = 'Debit Curr. Appln. Rndg. Acc.';
            TableRelation = "G/L Account";
        }
        field(11; "Credit Curr. Appln. Rndg. Acc."; Text[20])
        {
            Caption = 'Credit Curr. Appln. Rndg. Acc.';
            TableRelation = "G/L Account";
        }
        field(12; Arrondissement; Text[20])
        {
            Caption = 'Debit Rounding Account';
            TableRelation = "G/L Account";
        }
        field(13; "Credit Rounding Account"; Text[20])
        {
            Caption = 'Credit Rounding Account';
            TableRelation = "G/L Account";
        }
        field(20; "Charge Personnel (Base+Sursal)"; Text[20])
        {
            Caption = 'Basis salary Account';
            TableRelation = "G/L Account";
        }
        field(21; "Heure Supp"; Text[20])
        {
            Caption = 'Supp. Hours Account';
            TableRelation = "G/L Account";
        }
        field(22; "Indemnités Imposable"; Text[20])
        {
            Caption = 'Taxable Indemnities Acc.';
            TableRelation = "G/L Account";
        }
        field(23; "Indemnite Non Imposable"; Text[20])
        {
            Caption = 'Non Taxable Indemnities Acc.';
            TableRelation = "G/L Account";
        }
        field(24; "Repayable expenses Acc."; Text[20])
        {
            Caption = 'Repayable expenses Acc.';
            TableRelation = "G/L Account";
        }
        field(25; IUTS; Text[20])
        {
            Caption = 'Taxes Account';
            TableRelation = "G/L Account";
        }
        field(30; CNSS; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(31; TPA; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(32; Avance; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(33; Description; Text[60])
        {
        }
        field(50000; "Prêt"; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(50001; "Caisse fond social pat"; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(50002; "Charge sociale"; Text[30])
        {
            TableRelation = "G/L Account";
        }
        field(50003; "Prestations Familiale"; Text[30])
        {
            TableRelation = "G/L Account";
        }
        field(50004; "Risque Professionnel"; Text[30])
        {
            TableRelation = "G/L Account";
        }
        field(50005; "Assurance Vieillesse"; Text[30])
        {
            TableRelation = "G/L Account";
        }
        field(50006; FSP; Text[30])
        {
            TableRelation = "G/L Account";
        }
        field(50007; SND; Text[30])
        {
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    local procedure CheckGLAcc(AccNo: Code[20]; CheckProdPostingGroup: Boolean; CheckDirectPosting: Boolean)
    var
        GLAcc: Record "G/L Account";

    begin
        if AccNo <> '' then begin
            GLAcc.Get(AccNo);
            GLAcc.CheckGLAcc;
            if CheckProdPostingGroup then
                GLAcc.TestField("Gen. Prod. Posting Group");
            if CheckDirectPosting then
                GLAcc.TestField("Direct Posting", true);
        end;
    end;
}

