PageExtension 50312 "Job Ledger Entries" extends "Job Ledger Entries"
{
    layout
    {

        addlast(Control1)
        {

            field("Executed measurement"; Rec."Executed measurement")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Qté éxécutées field.', Comment = '%';
            }
        }
    }

}