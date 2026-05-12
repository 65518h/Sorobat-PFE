Page 50260 "Ligne Bureau D'ordre"
{
    Editable = false;
    PageType = List;
    SourceTable = "Bureau Ordre Diffusion";

    Caption = 'Ligne Bureau D''ordre';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document N°"; REC."Document N°")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Référence Ligne"; REC."Référence Ligne")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Receptionné Le"; REC."Receptionné Le")
                {
                    ApplicationArea = all;
                }
                field("N° Fournisseur"; REC."N° Fournisseur")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Nom Fournisseur"; REC."Nom Fournisseur")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Matricule Fiscale"; REC."Matricule Fiscale")
                {
                    ApplicationArea = all;
                }
                field("Numero Facture"; REC."Numero Facture")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date Facture Fournisseur"; REC."Date Facture Fournisseur")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Montant HT"; REC."Montant HT")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Montant TVA"; REC."Montant TVA")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Montant Timbre"; REC."Montant Timbre")
                {
                    ApplicationArea = all;
                }
                field("Montant TTC"; REC."Montant TTC")
                {
                    ApplicationArea = all;
                    DecimalPlaces = 3 : 3;
                }
                field("Numero Fature Achat Associé"; REC."Numero Fature Achat Associé")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Date Jointure"; REC."Date Jointure")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                field("Date Vérification Facture"; REC."Date Vérification Facture")
                {
                    ApplicationArea = all;
                }
                field("N° Facture Ebreg"; REC."N° Facture Ebreg")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Statut Facture"; REC."Statut Facture")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Clôturer"; REC.Clôturer)
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

