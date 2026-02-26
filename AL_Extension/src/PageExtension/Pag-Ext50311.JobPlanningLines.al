PageExtension 50311 "Job Planning Lines" extends "Job Planning Lines"
{
    layout
    {


    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Line Type", '%1', Rec."Line Type"::Budget);
        Rec.FilterGroup(0);
    end;

}