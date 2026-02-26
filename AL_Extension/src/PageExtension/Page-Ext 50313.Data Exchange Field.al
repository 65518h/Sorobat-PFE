

pageextension 50313 "Data Exchange Field" extends "Data Exch Field Mapping Part"
{
    layout
    {

        addbefore("Transformation Rule")
        {

            field("Default Value"; Rec."Default Value")
            {
                Editable = true;
            }
            field("Use Default Value"; Rec."Use Default Value")
            {
                Editable = true;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use Default Value field.', Comment = '%';
            }

        }
    }
}
