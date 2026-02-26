TableExtension 50109 "IC Outbox Sales LineEXT" extends "IC Outbox Sales Line"
{
    fields
    {
        field(8001411; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
    }
}

