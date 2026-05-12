TableExtension 50118 "Job Queue EntryEXT" extends "Job Queue Entry"
{
    fields
    {
        field(8001400; Periodicity; DateFormula)
        {
            Caption = 'Periodicity';

            trigger OnValidate()
            begin
                TestField("Recurring Job");
            end;
        }
    }
}

