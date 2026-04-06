TableExtension 50067 "General Posting SetupEXT" extends "General Posting Setup"
{
    fields
    {
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }

        field(50000; "Comptes De Charges Affectées"; Code[20])
        {
            Description = 'HJ DSFT 26/03/2012 AFFECTATION MENSUELLE APRES STOCKAGE';
            TableRelation = "G/L Account";
        }
        field(50001; Synchronise; Boolean)
        {
        }
        field(50002; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(8001900; "Prepaid Income Account"; Code[20])
        {
            Caption = 'Prepaid Income Account';
            TableRelation = "G/L Account";
        }
        field(8001901; "Prepaid Expenses Account"; Code[20])
        {
            Caption = 'Prepaid Expenses Account';
            TableRelation = "G/L Account";
        }
        field(8004130; "Transfer From Account"; Code[20])
        {
            Caption = 'Transfer From Account';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Sales Account");
            end;
        }
        field(8004131; "Transfer To Account"; Code[20])
        {
            Caption = 'Transfer To Account';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Sales Account");
            end;
        }
    }
    keys
    {
        key(STG_Key2; Synchronise)
        {
        }
    }
}

