PageExtension 50207 "Fixed Asset G/L Journal_PagEXT" extends "Fixed Asset G/L Journal"

{


    layout
    {
        addafter("Campaign No.")
        {
            field("Job No."; Rec."Job No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }
}
