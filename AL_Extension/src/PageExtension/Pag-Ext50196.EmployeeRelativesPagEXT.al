PageExtension 50196 "Employee Relatives_PagEXT" extends "Employee Relatives"

{
    //GL2024  SourceTableView=SORTING("Employee No.","Line No.");
    layout
    {
        addbefore("Relative Code")
        {
            field("Employee No."; Rec."Employee No.")
            {
                Visible = false;
                ApplicationArea = all;
            }

        }

        addafter("Birth Date")
        {
            field("Holding on end date"; Rec."Holding on end date")
            {
                ApplicationArea = all;
            }
            field("Type Prise En Charge"; Rec."Type Prise En Charge")
            {
                ApplicationArea = all;
            }
            field("Associated deduction"; Rec."Associated deduction")
            {
                ApplicationArea = all;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(0);
        rec.SetCurrentKey("Employee No.", "Line No.");

        Rec.FilterGroup(2);
    end;


}