TableExtension 50060 "Post CodeEXT" extends "Post Code"
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
        field(8003900; Latitude; Decimal)
        {
            Caption = 'Latitude';
            DecimalPlaces = 0 : 6;
        }
        field(8003901; Longitude; Decimal)
        {
            Caption = 'Longitude';
            DecimalPlaces = 0 : 6;
        }
    }
    keys
    {
        key(Key5; Synchronise)
        {
        }
    }
}

