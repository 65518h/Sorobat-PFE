PageExtension 50179 "Opportunity Entries_PagEXT" extends "Opportunity Entries"

{
    layout
    {
        addafter("Date of Change")
        {
            field("Estimated Close Date"; Rec."Estimated Close Date")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    IF rec."Estimated Close Date" <> xRec."Estimated Close Date" THEN
                        rec."Date of Change" := WORKDATE;
                end;
            }
        }
    }

    actions
    {

    }



}