TableExtension 50061 "Source CodeEXT" extends "Source Code"
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
        field(60000; Simulation2; Boolean)
        {
            Caption = 'Simulation';

        }
    }
    keys
    {
        key(STG_Key2; Synchronise)
        {
        }
    }



}

