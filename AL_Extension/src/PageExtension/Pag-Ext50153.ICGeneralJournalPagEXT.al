PageExtension 50153 "IC General Journal_PagEXT" extends "IC General Journal"
{

    layout
    {

        addafter("Salespers./Purch. Code")
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
    actions
    {

    }


}