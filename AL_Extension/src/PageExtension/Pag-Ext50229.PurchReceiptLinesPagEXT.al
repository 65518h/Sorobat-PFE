PageExtension 50229 "Purch. Receipt Lines_PagEXT" extends "Purch. Receipt Lines"
{
    layout
    {
        addafter("No.")
        {
            field("N° dossier"; rec."N° dossier")
            {
                ApplicationArea = all;
            }
        }
    }
}

