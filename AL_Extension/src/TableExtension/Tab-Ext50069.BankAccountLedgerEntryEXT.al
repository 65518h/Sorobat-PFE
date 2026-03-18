TableExtension 50069 "Bank Account Ledger EntryEXT" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Bénéficiaire"; Text[50])
        {
            CalcFormula = lookup("Payment Line".Libellé where("No." = field("Document No."),
                                                               "External Document No." = field("External Document No.")));
            Description = 'HJ SORO 05-10-2016';
            FieldClass = FlowField;
        }
        field(50001; "N° Folio"; Code[20])
        {
            Description = 'HJ SORO 05-10-2016';
            Editable = true;
        }
        /*   field(50002; Avance; Boolean)
           {
               CalcFormula = lookup("Payment Header".Avance where("No." = field("Document No.")));
               Description = 'RB SORO 27/03/2015';
               FieldClass = FlowField;
           }
           field(50003; "Date Relevé"; Date)
           {
               CalcFormula = lookup("Bank Account Statement"."Statement Date" where("Bank Account No." = field("Bank Account No."),
                                                                                     "Statement No." = field("Statement No.")));
               Description = 'HJ SORO 20-09-2016';
               FieldClass = FlowField;
           }
           field(50004; "Affectation Financiere"; Code[60])
           {
               Description = 'HJ SORO 23-02-2017';
               TableRelation = "Affectation Opération Bancaire".Code;
           }*/
        field(8001404; "Bal. Bank Account No."; Code[20])
        {
            Caption = 'Bal. Bank Account No.';
            TableRelation = if ("Bal. Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Bal. Account No."))
            else
            if ("Bal. Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Bal. Account No."));
        }
        field(8001405; "Bill Type"; Option)
        {
            Caption = 'Bill Type';
            OptionCaption = ' ,Not Accepted,Accepted,BOR';
            OptionMembers = " ","Not Accepted",Accepted,BOR;
        }
        field(8001621; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
    }
    keys
    {



        /* GL2024   key(STG_Key13;"Bank Account No.","Posting Date","Due Date")
            {
            SumIndexFields = Amount,"Amount (LCY)","Debit Amount","Credit Amount","Debit Amount (LCY)","Credit Amount (LCY)";
            }

            key(STG_Key14;"Bank Account No.",Open,"Posting Date","Due Date")
            {
            SumIndexFields = Amount,"Amount (LCY)","Debit Amount","Credit Amount","Debit Amount (LCY)","Credit Amount (LCY)","Remaining Amount";
            }

            key(STG_Key15;"Bank Account No.",Open,"Posting Date","Due Date","Document No.","Remaining Amount","Reason Code","Statement Status")
            {
            SumIndexFields = "Remaining Amount","Amount (LCY)";
            }*/

        key(STG_Key16; "Bank Account No.", "Statement No.", "Statement Line No.", "Posting Date")
        {
        }

        /* GL2024  key(STG_Key17;"Bank Account No.",Open,"Due Date")
           {
           }*/

        key(STG_Key18; "Bank Account No.", "Remaining Amount")
        {
            SumIndexFields = Amount, "Amount (LCY)", "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)", "Remaining Amount";
        }
        key(STG_Key19; "N° Folio")
        {
        }
    }

    procedure Iban(): Code[50]
    var
        lBankAccount: Record "Bank Account";
    begin
        //+PMT+SEPA
        lBankAccount.Get("Bank Account No.");
        exit(DelChr(lBankAccount.Iban, '=', ' '));
        //+PMT+SEPA//
    end;

    procedure "SWIFT Code"(): Code[20]
    var
        lBankAccount: Record "Bank Account";
    begin
        //+PMT+SEPA
        lBankAccount.Get("Bank Account No.");
        exit(DelChr(lBankAccount."SWIFT Code", '=', ' '));
        //+PMT+SEPA//
    end;
}

