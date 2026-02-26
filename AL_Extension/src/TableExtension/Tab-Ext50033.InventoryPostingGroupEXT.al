TableExtension 50033 "Inventory Posting GroupEXT" extends "Inventory Posting Group"
{
    fields
    {
        field(50000; Synchronise; Boolean)
        {
        }
        field(50001; "Num Sequence Syncro"; Integer)
        {

            Description = 'STD V 1.001';
        }
        field(50002; "Frequence Changement"; DateFormula)
        {
        }
        field(50003; Pneumatique; Boolean)
        {
        }

        field(8001400; "Excess Receip Allow"; Boolean)
        {
            Caption = 'Excess Receip Allow';

            trigger OnValidate()
            begin
                if not "Excess Receip Allow" then
                    "Excess Receip (%)" := 0;
            end;
        }
        field(8001401; "Excess Receip (%)"; Decimal)
        {
            //blankzero = true;
            Caption = 'Excess Receip (%)';
        }
        field(8001410; "Characteristic 1"; Text[30])
        {
            Caption = 'Characteristic 1';
        }
        field(8001411; "Characteristic 2"; Text[30])
        {
            Caption = 'Characteristic 2';
        }
        field(8001412; "Characteristic 3"; Text[30])
        {
            Caption = 'Characteristic 3';
        }
        field(8001413; "Characteristic 4"; Text[30])
        {
            Caption = 'Characteristic 4';
        }
        field(8001414; "Characteristic 5"; Text[30])
        {
            Caption = 'Characteristic 5';
        }
        field(8001415; "Characteristic 6"; Text[30])
        {
            Caption = 'Characteristic 6';
        }
        field(8001416; "Characteristic 7"; Text[30])
        {
            Caption = 'Characteristic 7';
        }
        field(8001417; "Characteristic 8"; Text[30])
        {
            Caption = 'Characteristic 8';
        }
        field(8001418; "Characteristic 9"; Text[30])
        {
            Caption = 'Characteristic 9';
        }
        field(8001419; "Characteristic 10"; Text[30])
        {
            Caption = 'Characteristic 10';
        }
    }
    keys
    {
        key(Key2; Synchronise)
        {
        }
    }
}

