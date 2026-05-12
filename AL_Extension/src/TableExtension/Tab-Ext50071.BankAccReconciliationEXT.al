TableExtension 50071 "Bank Acc. ReconciliationEXT" extends "Bank Acc. Reconciliation"
{
    fields
    {
        modify("Bank Account No.")
        {
            trigger OnAfterValidate()
            begin
                if "Statement No." = '' then begin
                    BankAcc.Get("Bank Account No.");
                    //+PMT+PAYMENT
                    "Bank Type" := BankAcc."Bank Type";
                    //+PMT+PAYMENT//
                end;
            end;
        }

        // field(50000; "Solde Comptable"; Decimal)
        // {
        //     CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account No."),
        //                                                                 "Posting Date" = field("Filtre Date")));
        //     Description = 'HJ SORO 20-09-2016';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50001; "Filtre Date"; Date)
        // {
        //     Description = 'HJ SORO 20-09-2016';
        //     FieldClass = FlowFilter;
        // }
        // field(50002; "Solde Bancaire"; Decimal)
        // {
        //     CalcFormula = sum("Bank Acc. Reconciliation Line"."Statement Amount" where("Bank Account No." = field("Bank Account No."),
        //                                                                                 "Statement No." = field("Statement No."),
        //                                                                                 Lettré = const(false)));
        //     Description = 'HJ SORO 20-09-2016';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(50003; "Nom Banque"; Text[50])
        // {
        //     CalcFormula = lookup("Bank Account".Name where("No." = field("Bank Account No.")));
        //     Description = 'RB SORO 09/01/2017';
        //     FieldClass = FlowField;
        // }
        field(8001401; "Handing-over Type"; Option)
        {
            Caption = 'Handing-over Type';
            OptionCaption = 'Cash,Discount,Discount in Retroactive Value,Credit after Cash,No Resident';
            OptionMembers = Cash,Discount,"Discount in Retroactive Value","Credit after Cash","No Resident";
        }
        field(8001402; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
        }
        field(8001403; "Handing-over Bank Code"; Code[20])
        {
            Caption = 'Handing-over Bank Code';
            TableRelation = "Bank Account"."No.";
        }
        field(8001404; "LCR File Name"; Text[100])
        {
            Caption = 'LCR File Name';
        }
        field(8001405; "Bank Type"; Option)
        {
            Caption = 'Bank Type';
            OptionCaption = ' ,Bill To Pay,Bill To Receive';
            OptionMembers = " ","Bill To Pay","Bill To Receive";
        }
    }
    var

        BankAcc: Record "Bank Account";
}

