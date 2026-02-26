TableExtension 50031 "Customer Posting GroupEXT" extends "Customer Posting Group"
{
    fields
    {
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {

            TableRelation = "G/L Account";
        }
        field(50002; "Apply Stamp fiscal"; Boolean)
        {
            Caption = 'Apply Stamp Fiscal';
        }
        field(50003; "Stamp fiscal Amout"; Decimal)
        {
            Caption = 'Montant Timbre Fiscal';
        }
        field(50004; "Fodec Account"; Code[20])
        {
            Caption = 'Fodec Account';
            Description = 'STD V 1.001';
            TableRelation = "G/L Account";
        }
        field(50005; "Apply Fodec"; Boolean)
        {
            Caption = 'Apply Fodec';
            Description = 'STD V 1.001';
        }
        field(50006; "Fodec %"; Decimal)
        {
            Caption = '% Fodec';
            Description = 'STD V 1.001';
        }

        field(8003980; "Contract Type"; Code[10])
        {
            Caption = 'Contract Type';
            TableRelation = "Contract Type".Code;
        }
    }
    keys
    {
        key(Key2; Synchronise)
        {
        }
    }
}

