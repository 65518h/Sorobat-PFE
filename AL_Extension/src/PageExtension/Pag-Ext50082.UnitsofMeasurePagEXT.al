PageExtension 50082 "Units of Measure_PagEXT" extends "Units of Measure"
{
    layout
    {
        addafter(Description)
        {
            field("Time Unit"; Rec."Time Unit")
            {
                ApplicationArea = all;
            }
            field(Weight; Rec.Weight)
            {
                ApplicationArea = all;
            }
        }


    }

    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE(NOT CurrPage.LOOKUPMODE);
    end;
}