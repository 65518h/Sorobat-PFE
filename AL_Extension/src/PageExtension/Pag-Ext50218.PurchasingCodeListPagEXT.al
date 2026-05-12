PageExtension 50218 "Purchasing Code List_PagEXT" extends "Purchasing Code List"

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

