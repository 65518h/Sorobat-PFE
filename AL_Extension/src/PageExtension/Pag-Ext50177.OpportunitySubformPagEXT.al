PageExtension 50177 "Opportunity Subform_PagEXT" extends "Opportunity Subform"

{
    layout
    {
        addafter("Estimated Value (LCY)")
        {
            field("Estimated Margin Var(LCY)"; Rec."Estimated Margin Var(LCY)")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
    }

    actions
    {

    }



}