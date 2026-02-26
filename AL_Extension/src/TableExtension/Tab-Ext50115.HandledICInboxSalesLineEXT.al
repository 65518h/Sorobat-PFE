TableExtension 50115 "Handled IC Inbox Sales LineEXT" extends "Handled IC Inbox Sales Line"
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

