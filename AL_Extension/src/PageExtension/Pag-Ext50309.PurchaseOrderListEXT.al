pageextension 50309 "Purchase Order ListEXT" extends "Purchase Order List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Job No.2"; Rec."Job No.")
            {

            }
        }
    }
    actions
    {
    }


}