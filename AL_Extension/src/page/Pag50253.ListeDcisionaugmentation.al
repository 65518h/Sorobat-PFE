Page 50253 "Liste Décision augmentation"
{
    PageType = List;
    SourceTable = "Decision augmentation salaire";
    ApplicationArea = all;
    Caption = 'Liste Décision augmentation';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("N° Decision"; REC."N° Decision")
                {
                    ApplicationArea = all;
                }
                field(Matricule; REC.Matricule)
                {
                    ApplicationArea = all;
                }
                field("Nom et Prénom"; REC."Nom et Prénom")
                {
                    ApplicationArea = all;
                }
                field(Qualification; REC.Qualification)
                {
                    ApplicationArea = all;
                }
                field("Description Qualification"; REC."Description Qualification")
                {
                    ApplicationArea = all;
                }
                field(Affectation; REC.Affectation)
                {
                    ApplicationArea = all;
                }
                field("Description Affectation"; REC."Description Affectation")
                {
                    ApplicationArea = all;
                }
                field("Date de recrutement"; REC."Date de recrutement")
                {
                    ApplicationArea = all;
                }
                field("Salaire actuel"; REC."Salaire actuel")
                {
                    ApplicationArea = all;
                }
                field("Montant d'augmentation"; REC."Montant d'augmentation")
                {
                    ApplicationArea = all;
                }
                field("Nouveau Salaire"; REC."Nouveau Salaire")
                {
                    ApplicationArea = all;
                }
                field("Date d'effet"; REC."Date d'effet")
                {
                    ApplicationArea = all;
                }
                field("Proposé par"; REC."Proposé par")
                {
                    ApplicationArea = all;
                }
                field("Date Création"; REC."Date Création")
                {
                    ApplicationArea = all;
                }
                field("Créer par"; REC."Créer par")
                {
                    ApplicationArea = all;
                }
                field("Validé"; REC.Validé)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date Validation"; REC."Date Validation")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Validé Par"; REC."Validé Par")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
    }
}

