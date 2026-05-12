TableExtension 50105 "Detailed CV Ledg. En.BufferEXT" extends "Detailed CV Ledg. Entry Buffer"
{
    Caption = 'Detailed CV Ledg. Entry Buffer';
    fields
    {
        field(50000; "N° Dossier"; Code[20])
        {
            Description = 'HJDSFT 0103 2012';
        }
        field(8001600; "Value Date"; Date)
        {
            Caption = 'Value Date';
        }
    }

}

