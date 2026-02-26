TableExtension 50873 "Job Posting GroupEXT" extends "Job Posting Group"
{
    fields
    {
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(8003901; "Transfer Account"; Code[20])
        {
            Caption = 'Transfer Account';
            TableRelation = "G/L Account";
        }
        field(8003902; "Transfer Bal. Account"; Code[20])
        {
            Caption = 'Transfer Bal. Account';
            TableRelation = "G/L Account";
        }
    }




    keys
    {

        key(Key2; Synchronise)
        {
        }
    }




}

