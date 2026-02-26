TableExtension 50104 "CV Ledger Entry BufferEXT" extends "CV Ledger Entry Buffer"
{
    fields
    {
        field(8001400; "Job No."; Code[20])
        {
            Caption = 'N° Affaire';
            TableRelation = Job;
        }
        field(8001600; "Value Date"; Date)
        {
            Caption = 'Date de valeur';
        }
    }
}

