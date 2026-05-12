TableExtension 50134 "Interaction Template SetupEXT" extends "Interaction Template Setup"
{
    fields
    {
        field(8003900; "Request Guarantee"; Code[20])
        {
            Caption = 'Request Guarantee';
            TableRelation = "Interaction Template".Code;
        }
        field(8003901; "Due Guarantee"; Code[20])
        {
            Caption = 'Due Guarantee';
            TableRelation = "Interaction Template".Code;
        }
    }
}

