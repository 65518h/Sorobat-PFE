TableExtension 50085 "No. Series LineEXT" extends "No. Series Line"
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
        field(8003900; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
        }
    }
    keys
    {

        /*  GL2024   key(STG_Key3;"Series Code","Responsibility Center","Starting Date","Starting No.")
             {
             }*/
        key(STG_Key4; Synchronise)
        {
        }
    }
}

