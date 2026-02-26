TableExtension 50003 "Customer Price GroupEXT" extends "Customer Price Group"
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
    }
    keys
    {
        key(Key2; Synchronise)
        {
        }
    }
}

