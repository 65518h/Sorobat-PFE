TableExtension 50032 "Vendor Posting GroupEXT" extends "Vendor Posting Group"
{
    fields
    {
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {

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

    }
    keys
    {
        key(STG_Key2; Synchronise)
        {
        }
    }
}

