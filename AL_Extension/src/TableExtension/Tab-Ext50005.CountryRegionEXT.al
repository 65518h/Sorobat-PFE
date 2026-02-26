TableExtension 50005 "Country/RegionEXT" extends "Country/Region"
{
    fields
    {

        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';

        }
        field(8001400; "Map URL"; Text[250])
        {
            Caption = 'Map URL';
        }
        field(8001401; "Map Country Code"; Code[10])
        {
            Caption = 'Map Country Code';
        }
        field(8001402; "Map URL 2"; Text[250])
        {
            Caption = 'URL carte (suite)';
        }
        field(8001403; "Journey URL"; Text[250])
        {
            Caption = 'URL trajet';
        }
        field(8001404; "Journey URL 2"; Text[250])
        {
            Caption = 'URL trajet (suite)';
        }
        field(8001405; "ISO Code A3"; Code[3])
        {
            Caption = 'ISO Code A3';
        }
        field(8001406; "ISO Code N3"; Code[3])
        {
            Caption = 'ISO Code N3';
        }
        field(8004100; "SEPA Allowed1"; Boolean)
        {
            Caption = 'SEPA Allowed';
        }
    }
    keys
    {
        key(Key5; Synchronise)
        {
        }
    }
}

