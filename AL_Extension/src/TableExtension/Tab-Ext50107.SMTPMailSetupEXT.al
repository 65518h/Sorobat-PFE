TableExtension 50107 "SMTP Mail SetupEXT" extends "SMTP Mail Setup"
{
    fields
    {

        field(8001400; "SSL/TLS"; Boolean)
        {
            Caption = 'SSL/TLS';
        }
        field(8001401; Port; Integer)
        {
            Caption = 'Port';
            InitValue = 25;
        }
        field(8001403; "Specific Connector"; Boolean)
        {
            Caption = 'Specific Connector';
        }
    }
}

