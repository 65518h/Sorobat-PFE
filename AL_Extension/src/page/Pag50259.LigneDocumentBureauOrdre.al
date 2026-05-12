Page 50259 "Ligne Document Bureau Ordre"
{
    Editable = false;
    PageType = List;
    SourceTable = "Bureau Ordre Diffusion";
    SourceTableView = sorting("Document N°", "N° Ligne", "Référence Ligne")
                      where(Clôturer = filter(true),
                            "Numero Fature Achat Associé" = filter(' '));

    Caption = 'Ligne Document Bureau Ordre';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Numero Facture"; REC."Numero Facture")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("N° Fournisseur"; REC."N° Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Référence Ligne"; REC."Référence Ligne")
                {
                    ApplicationArea = all;
                }
                field("Nom Fournisseur"; REC."Nom Fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Montant HT"; REC."Montant HT")
                {
                    ApplicationArea = all;
                }
                field("Montant TTC"; REC."Montant TTC")
                {
                    ApplicationArea = all;
                }
                field("Montant TVA"; REC."Montant TVA")
                {
                    ApplicationArea = all;
                }
                field("Clôturer"; REC.Clôturer)
                {
                    ApplicationArea = all;
                }
                field("Document N°"; REC."Document N°")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        REC.FilterGroup(0);
        REC.FilterGroup(1);
    end;
}

