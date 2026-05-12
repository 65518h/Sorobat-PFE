PageExtension 50094 "Recurring General Journ_PagEXT" extends "Recurring General Journal"
{
    layout
    {

        addafter("Posting Date")
        {
            field("Value Date"; Rec."Value Date")
            {
                ApplicationArea = all;
            }


        }
        addafter("Document No.")
        {
            field("External Document No.2"; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Currency Code")
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



