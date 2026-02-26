PageExtension 50269 "Payment Step Card_PagEXT" extends "Payment Step Card"
{


    layout
    {
        addafter("Acceptation Code<>No")
        {
            field("Code Origine Obligatoire"; Rec."Code Origine Obligatoire")
            {
                ApplicationArea = all;
            }
        }
    }

}