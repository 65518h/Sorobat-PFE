TableExtension 50112 "Handled IC Out. Purch. LineEXT" extends "Handled IC Outbox Purch. Line"
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

