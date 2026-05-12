PageExtension 50217 "Purchasing Codes_PagEXT" extends "Purchasing Codes"

{
    layout
    {
        addafter("Special Order")
        {
            field("Copy Extended Text"; Rec."Copy Extended Text")
            {
                ApplicationArea = all;
            }
        }
    }


}

