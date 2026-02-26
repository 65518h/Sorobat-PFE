TableExtension 50084 "No. SeriesEXT" extends "No. Series"
{
    fields
    {
        field(50000; Synchronise; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'RB SORO 06/03/2015';
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
    }
    keys
    {
        key(Key2; Synchronise)
        {
        }
    }
}

