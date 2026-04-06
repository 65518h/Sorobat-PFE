TableExtension 50054 "Unit of MeasureEXT" extends "Unit of Measure"
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
        field(8001900; "Time Unit"; DateFormula)
        {
            Caption = 'Time Unit';
        }
        field(8001907; Weight; Decimal)
        {
            //blankzero = true;
            Caption = 'Weight';
            DecimalPlaces = 0 : 8;
        }
    }
    keys
    {
        key(STG_Key4; Synchronise)
        {
        }
    }
}

