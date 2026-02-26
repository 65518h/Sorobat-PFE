TableExtension 50111 "Handled IC Out. Sales LineEXT" extends "Handled IC Outbox Sales Line"
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

