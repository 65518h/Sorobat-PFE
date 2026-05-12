PageExtension 50238 "Service Contract_PagEXT" extends "Service Contract"
{
    layout
    {

        addafter("Change Status")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
    }
}