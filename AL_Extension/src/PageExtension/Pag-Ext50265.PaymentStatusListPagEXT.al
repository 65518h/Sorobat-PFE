PageExtension 50265 "Payment Status List_PagEXT" extends "Payment Status List"
{


    layout
    {
        addfirst(Control1)
        {
            field(Line; rec.Line)
            {
                ApplicationArea = all;
            }
        }
        addafter(Name)
        {
            field("Communication XRT"; rec."Communication XRT")
            {
                ApplicationArea = all;
            }
        }
        addafter(Credit)
        {
            field("Calculer Retenue à la source"; rec."Calculer Retenue à la source")
            {
                ApplicationArea = all;
            }
            field("Calculer Retenue Sur TVA"; rec."Calculer Retenue Sur TVA")
            {
                ApplicationArea = all;
            }
            field("Tva Sur Commission"; rec."Tva Sur Commission")
            {
                ApplicationArea = all;
            }
            field(Commission; rec.Commission)
            {
                ApplicationArea = all;
            }
            field(Modifiable; rec.Modifiable)
            {
                ApplicationArea = all;
            }
            field("Calculer Retenue sur Garantie"; rec."Calculer Retenue sur Garantie")
            {
                ApplicationArea = all;
            }
            field("En Banque"; rec."En Banque")
            {
                ApplicationArea = all;
            }
            field(Annulation; rec.Annulation)
            {
                ApplicationArea = all;
            }
            field("Référence Chèque"; Rec."Référence Chèque")
            {
                ApplicationArea = all;
            }
        }
    }
}

