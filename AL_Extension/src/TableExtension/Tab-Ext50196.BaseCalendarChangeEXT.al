TableExtension 50196 "Base Calendar ChangeEXT" extends "Base Calendar Change"
{
    fields
    {
        modify(Date)
        {
            trigger OnAfterValidate()
            begin
                //PLANNING
                IF ("To Date" <> 0D) AND ("To Date" < Date) THEN
                    ERROR(tErrorDate)
                ELSE
                    IF "To Date" = Date THEN
                        "To Date" := 0D;
                //PLANNING//
            end;
        }

        field(8035000; "To Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                //PLANNING
                Validate(Date);
                //PLANNING//
            end;
        }
    }

    var
        tErrorDate: label 'The date must be inferior to ending date.';
}

