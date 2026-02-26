PageExtension 50095 "Allocations_PagEXT" extends "Allocations"
{
    layout
    {


        addafter("Account Name")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = all;
            }
        }

    }

}



