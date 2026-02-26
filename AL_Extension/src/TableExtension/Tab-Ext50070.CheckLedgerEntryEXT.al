TableExtension 50070 "Check Ledger EntryEXT" extends "Check Ledger Entry"
{
    fields
    {
        modify("Check Date")
        {
            Caption = 'Check Date';


            Description = 'Modif Caption ML FRA';
        }
        modify("Check No.")
        {
            Caption = 'Check No.';
            Description = 'Modif Caption ML FRA';


        }
        modify("Check Type")
        {
            Caption = 'Check No.';
            Description = 'Modif Caption ML FRA';


        }

        field(8001400; "Bal. Bank Account No."; Code[20])
        {
            Caption = 'Bal. Bank Account No.';
            TableRelation = if ("Bal. Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Bal. Account No."))
            else
            if ("Bal. Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Bal. Account No."));
        }
        field(8001403; "Payment Type"; Option)
        {
            //blankzero = true;
            Caption = 'Payment type';
            OptionCaption = ',Check,Bill,Transfer,Direct Debit,Credit Card,VCOM';
            OptionMembers = ,Check,Bill,Transfer,"Direct Debit","Credit Card",VCOM;
        }
    }

    procedure Iban(): Code[50]
    var
        lCustomerBankAccount: Record "Customer Bank Account";
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        //+PMT+SEPA
        case "Bal. Account Type" of
            "bal. account type"::Customer:
                begin
                    lCustomerBankAccount.Get("Bal. Account No.", "Bal. Bank Account No.");
                    exit(DelChr(lCustomerBankAccount.Iban, '=', ' '));
                end;
            "bal. account type"::Vendor:
                begin
                    lVendorBankAccount.Get("Bal. Account No.", "Bal. Bank Account No.");
                    exit(DelChr(lVendorBankAccount.Iban, '=', ' '));
                end;
        end;
        //+PMT+SEPA//
    end;

    procedure "SWIFT Code"(): Code[20]
    var
        lCustomerBankAccount: Record "Customer Bank Account";
        lVendorBankAccount: Record "Vendor Bank Account";
    begin
        //+PMT+SEPA
        case "Bal. Account Type" of
            "bal. account type"::Customer:
                begin
                    lCustomerBankAccount.Get("Bal. Account No.", "Bal. Bank Account No.");
                    exit(DelChr(lCustomerBankAccount."SWIFT Code", '=', ' '));
                end;
            "bal. account type"::Vendor:
                begin
                    lVendorBankAccount.Get("Bal. Account No.", "Bal. Bank Account No.");
                    exit(DelChr(lVendorBankAccount."SWIFT Code", '=', ' '));
                end;
        end;
        //+PMT+SEPA//
    end;

    procedure "Currency Code"(): Code[10]
    var
        lBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        lBankAccount: Record "Bank Account";
    begin
        //+PMT+SEPA
        //lBankAccountLedgerEntry.GET("Bank Account Ledger Entry No.");
        //EXIT(lBankAccountLedgerEntry."Currency Code");
        lBankAccount.Get("Bank Account No.");
        exit(lBankAccount."Currency Code");
        //+PMT+SEPA//
    end;
}

