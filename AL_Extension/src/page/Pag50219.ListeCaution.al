Page 50219 "Liste Caution"
{
    Editable = false;
    PageType = List;
    SourceTable = Caution;
    ApplicationArea = all;
    Caption = 'Liste Caution';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No. Caution"; REC."No. Caution")
                {
                    ApplicationArea = all;
                }
                field("Marché"; REC.Marché)
                {
                    ApplicationArea = all;
                }
                field("Lot N°"; REC."Lot N°")
                {
                    ApplicationArea = all;
                }
                field("Type Caution"; REC."Type Caution")
                {
                    ApplicationArea = all;
                }
                field(Banque; REC.Banque)
                {
                    ApplicationArea = all;
                }
                field("Date Echeance"; REC."Date Echeance")
                {
                    ApplicationArea = all;
                }
                field("Montant Caution"; REC."Montant Caution")
                {
                    ApplicationArea = all;
                }
                field("Condition Apurement Recpt Prov"; REC."Condition Apurement Recpt Prov")
                {
                    ApplicationArea = all;
                }
                field(Condition; REC.Condition)
                {
                    ApplicationArea = all;
                }
                field("Condition Apur Recpt Definitiv"; REC."Condition Apur Recpt Definitiv")
                {
                    ApplicationArea = all;
                }
                field("Date Obtention"; REC."Date Obtention")
                {
                    ApplicationArea = all;
                }
                field(Statut; REC.Statut)
                {
                    ApplicationArea = all;
                }
                field("Motif Refus"; REC."Motif Refus")
                {
                    ApplicationArea = all;
                }
                field("Date Demande"; REC."Date Demande")
                {
                    ApplicationArea = all;
                }
                field("N° Caution Chez Banque"; REC."N° Caution Chez Banque")
                {
                    ApplicationArea = all;
                }
                field("Date Main Levée"; REC."Date Main Levée")
                {
                    ApplicationArea = all;
                }
                field("Date Depot Main Levée"; REC."Date Depot Main Levée")
                {
                    ApplicationArea = all;
                }
                field("Montant Main Levée"; REC."Montant Main Levée")
                {
                    ApplicationArea = all;
                }
                field("Montant Ouvert"; REC."Montant Ouvert")
                {
                    ApplicationArea = all;
                }
                field(Fournisseur; REC.Fournisseur)
                {
                    ApplicationArea = all;
                }
                field("Nom Fournisseur"; REC."Nom Fournisseur")
                {
                    ApplicationArea = all;
                }
                field(Garant; REC.Garant)
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

