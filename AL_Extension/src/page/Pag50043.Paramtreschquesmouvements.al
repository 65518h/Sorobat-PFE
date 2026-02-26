Page 50043 "Paramétres chèques mouvementés"
{
    //  //>>>MBK:05/02/2010: Référence chèque

    PageType = List;
    SourceTable = "Chèque mouvementé";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Paramétres chèques mouvementés';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code banque"; rec."Code banque")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Référence chèque"; rec."Référence chèque")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("N°Chèque"; rec."N°Chèque")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Statut; rec.Statut)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("N° Bordereu"; rec."N° Bordereu")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("N° Ligne Bordereu"; rec."N° Ligne Bordereu")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Statut Bordereau"; rec."Statut Bordereau")
                {
                    ApplicationArea = all;
                }
                field("N° Statut"; rec."N° Statut")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Statut Modifiable"; rec."Statut Modifiable")
                {
                    ApplicationArea = all;
                }
                field("N° Fournisseur"; rec."N° Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Nom Fournisseur"; rec."Nom Fournisseur")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

