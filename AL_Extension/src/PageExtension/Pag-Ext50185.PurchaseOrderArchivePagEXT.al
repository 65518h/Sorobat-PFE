PageExtension 50185 "Purchase Order Archive_PagEXT" extends "Purchase Order Archive"

{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
            }
        }

        addafter("Posting Date")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

    }

}