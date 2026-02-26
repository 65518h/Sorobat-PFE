PageExtension 50195 "Relatives_PagEXT" extends "Relatives"

{
    layout
    {
        addafter(Description)
        {
            field(Type; Rec.Type)
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
            field("Holding on end date"; Rec."Holding on end date")
            {
                ApplicationArea = all;
            }
        }
    }


}