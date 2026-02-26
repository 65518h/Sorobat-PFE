TableExtension 50879 "Employee Posting GroupEXT" extends "Employee Posting Group"
{
    fields
    {

        field(50009; "Salaire Net"; Text[20])
        {
            Caption = 'Salaire Net';
            TableRelation = "G/L Account";
        }
        field(50011; "Service Charge Acc."; Text[20])
        {
            Caption = 'Service Charge Acc.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Service Charge Acc.", true, true);
            end;
        }
        field(50010; "Payment Disc. Acc."; Text[20])
        {
            Caption = 'Payment Disc. Acc.';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Payment Disc. Acc.", false, false);
            end;
        }
        field(50012; "Invoice Rounding Account"; Text[20])
        {
            Caption = 'Invoice Rounding Account';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Invoice Rounding Account", true, false);
            end;
        }
        /*GL2024   field(50010; "Debit Curr. Appln. Rndg. Acc."; Text[20])
           {
               Caption = 'Debit Curr. Appln. Rndg. Acc.';
               TableRelation = "G/L Account";
           }
           field(50011; "Credit Curr. Appln. Rndg. Acc."; Text[20])
           {
               Caption = 'Credit Curr. Appln. Rndg. Acc.';
               TableRelation = "G/L Account";
           }
           field(50012; Arrondissement; Text[20])
           {
               Caption = 'Debit Rounding Account';
               TableRelation = "G/L Account";
           }
           field(50013; "Credit Rounding Account"; Text[20])
           {
               Caption = 'Credit Rounding Account';
               TableRelation = "G/L Account";
           }*/
        field(50020; "Charge Personnel (Base+Sursal)"; Text[20])
        {
            Caption = 'Charge Personnel (Base+Sursal';
            TableRelation = "G/L Account";
        }
        field(50021; "Heure Supp"; Text[20])
        {
            Caption = 'Heure Supp';
            TableRelation = "G/L Account";
        }
        field(50022; "Indemnités Imposable"; Text[20])
        {
            Caption = 'Indemnité';
            TableRelation = "G/L Account";
        }
        field(50023; "Indemnite Non Imposable"; Text[20])
        {
            Caption = 'Non Taxable Indemnities Acc.';
            TableRelation = "G/L Account";
        }
        field(50024; "Repayable expenses Acc."; Text[20])
        {
            Caption = 'Repayable expenses Acc.';
            TableRelation = "G/L Account";
        }
        field(50025; IUTS; Text[20])
        {
            Caption = 'IUTS';
            TableRelation = "G/L Account";
        }
        field(50030; CNSS; Text[20])
        {
            TableRelation = "G/L Account";

        }
        field(50031; TPA; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(50032; Avance; Text[20])
        {
            TableRelation = "G/L Account";
        }
        field(50033; Description; Text[60])
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
        field(60012; Arrondissement; Text[20])
        {
            TableRelation = "G/L Account";
        }
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